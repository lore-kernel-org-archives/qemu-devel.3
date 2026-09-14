Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1E2C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CC7-0004xg-4d; Mon, 14 Sep 2026 15:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6CC3-0004xS-VV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6CC2-0001XQ-8d
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789413496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=se4eB4FpMuBa8eGTKqq0/FlgCnnxhiTkbD6AcH+LoPo=;
 b=VwJekC5bsWVGEyRA/PO6avmbj4w76PJbldybrvNBAQvg/V2eaLSTniLeVcoN6HcbsRGiPz
 J6ODHcH6M2Fr5kFQtT3IlrjvtVf/HZ1m/j195khoH5v1HrzE+s8Z8wCgEwh+dLRy2mGCG8
 kVWRvTC0SQCbw1TxjgBVjHpRSuelQQI=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-Si2VAbjKPlGMoywoHbj16A-1; Mon, 14 Sep 2026 15:18:15 -0400
X-MC-Unique: Si2VAbjKPlGMoywoHbj16A-1
X-Mimecast-MFC-AGG-ID: Si2VAbjKPlGMoywoHbj16A_1789413494
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-66cad42590cso4863341d50.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789413494; cv=none;
 d=google.com; s=arc-20260327;
 b=WhrS1MsLz8VdRyYz03YAHgQLUPHddU5e0l0E/ZCmDvQcFKAYt/v9QK8v+fY6Vk5mW7
 zQZC7j77k5GKtlsCLQn7BvY/r3mhomj//Zeh6pyCVrg1QdFahpAx+VpX4xvbZcNuOKBF
 mQb/n7Q5Nxn9o5yvROr3wEe/UW2TSHTAISi46fO4fqXyfm4DwyK1jofhIfkKN6avXzC6
 TYV6Dt2LRQCYMKf6qMHTpBchJG3OvM7h5ZWfLQbs5Eua57kg2cB/BbLZa0QNtOdv7o1v
 OOTL1LCB4HLsMyOapEYC+OAfK9FwA/yX5aeUi7oqyI/RtGEN2/UdPPVhCl19hbZm8+SR
 zSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=se4eB4FpMuBa8eGTKqq0/FlgCnnxhiTkbD6AcH+LoPo=;
 fh=6/3MBLY771l9Tjbp9sIrjfuM3gYSL1dAxCLrcHqISag=;
 b=rZ0lN+cUuD9lN+FfoZQKVeTmV6n5dlgOsiQPHiy2Oruowpx6yyk0ZzQ/wKIq8CUdUh
 weglv7aVBvXu/C5333wpCQijuQkundQSFR3rNASwkC8peCh4E4ivTVBCQDqCT5FzIu6j
 sLe0O7cEnNiJyWl1+yPeZVySXxEHzDLi1FLb7k3SKn1VbOzDzaAHp1jFunMVso1R0WeO
 6g1SzheLh1GQI7lHDVaK4oRUs5OGhSO/rvMw9RuovRUoX95ehyNZEPeQsyfdtwfSaJmS
 QSncLRSkmNlTtJlX9oFpl1mhV4MpP6zq77NKPWAilenDynMcUMIAtZagrpCaZUfyVGZJ
 xSXw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789413494; x=1790018294; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=se4eB4FpMuBa8eGTKqq0/FlgCnnxhiTkbD6AcH+LoPo=;
 b=JYQB57/6Hlx02eby3IA3hM2HNYO0hiWZSBlF5PDVJPhyNwO7s/xpKeaDdLMtncQKAk
 X9hb6jhHi0dy1nNe5oLnnR9jpzwVs7tjCeUU6ghZ4mnb3roqu6Nio1HcJSEJAqvcfjYX
 7NV+HVI9EM/8RXz+sLKM605XtvrreEIqqN+YyNL1SmXcJnPyKzGdO49+rV+GUiRxtxLW
 nwoZZ16hz8R9Dc3sDOzwEbQc7A2iPfqjv5HkmKouf+tg7SqLwg0Eby2oEqABWxDNj5V3
 oTHBRePcDl03hfj6LsJ8khkgKheIwerhVn795xp6X9EMGO3Nf14BowGUms3Vdrwr0Srp
 Ewbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789413494; x=1790018294;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=se4eB4FpMuBa8eGTKqq0/FlgCnnxhiTkbD6AcH+LoPo=;
 b=lMB2ewsLUSejpWO+xelbmOvLRwbko1R/y9fimhZZ4qRm+gUVYBo/I5n+eZOAMbNQ66
 IcyGvlJCIGX6AkebFdpq7s3a6YyQe0ufbuybh3NvpWttM4ZgebriquvzSmZ6kpr+1kzO
 De28BNyMpCHlze4t+haYle85MrxgMinIV8TmM3j3yZ2xiZGhzQXskIroidFBiXMSBlEF
 1GwU3Q5S/n0sgd8A2Xuyz+Iitq2SvVpkq2LpYNdNzpxdF3KxeDSp5dE4tCyY9EEa4boI
 W9Ucv/I2zb9isNgRhbcdoWBzEE68kgBobHI5fAIq16TI/PUVpdC4Ix29YNB3g9dSu6Z9
 1zQg==
X-Gm-Message-State: AFuF++nffcfaukHuMjJq/OGVhx8q9iL1b+jHz7nV554Ulfnv2VvpR/MA
 W8MtGvwUyQHAIgOe0l6KluwWMT7vUyFnS+Nht6YmvdbEualsC1g3o8LQNjAHxDdW5+lv96twx6O
 ksHz3lo3mvFBFO8VyN5EijgHqtUFz7Z4C10w3wMEKpQixYNWjedXZu08bpCgwMnOdoZp93qhmqb
 nZ1Ho9c/AptW4TCv+4jfM9JL6LG9GNuA8=
X-Gm-Gg: AYBFou3Pa901PS9J7cKoRLaZPPzQ+ufZX/lxGjws5pmDk6P6ZrvPbOLD6Jj5xRje6/m
 8NRO0hNxRR8imNx7fZfgBAOC33l/mOWHpK2HLlvtkWDSg1j4j38/s52Lv1zr8Gg+dbHCQrjJyXu
 rssvuH9K0O/myHPT/XzKpbfCytlmC0PC4jaBVd/NGN6LicVCRyQBVTi1KTL6GMM/yV52QE7AB5x
 pWJp0FU48PpeQqK
X-Received: by 2002:a53:e6cb:0:b0:66f:c1be:3172 with SMTP id
 956f58d0204a3-6714e1a2dd8mr995084d50.73.1789413494383; 
 Mon, 14 Sep 2026 12:18:14 -0700 (PDT)
X-Received: by 2002:a53:e6cb:0:b0:66f:c1be:3172 with SMTP id
 956f58d0204a3-6714e1a2dd8mr995008d50.73.1789413489171; Mon, 14 Sep 2026
 12:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260911203002.305316-1-jsnow@redhat.com>
 <20260911203002.305316-2-jsnow@redhat.com>
 <8733vf3qav.fsf@pond.sub.org>
In-Reply-To: <8733vf3qav.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 14 Sep 2026 15:17:58 -0400
X-Gm-Features: AcwNN1UxCM6sVvgKFqbx8-QIvper17XOVocvYU9Y-cD71Ryl4moklh_9T1nRGvw
Message-ID: <CAFn=p-anhPzHfd1S_UZiiw=W_=ZsZC5kaJxH9Uk4FDKHXyc-hw@mail.gmail.com>
Subject: Re: [PATCH 1/9] qapi: convert remaining simple intros for
 block-export.json
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Sep 12, 2026 at 3:02=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > These are either structs or unions that are used in an inlinable
> > context: i.e. the generated documentation is likely to feature a
> > version of this documentation block that does not include the intro in
> > context of another command, event, or structure.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> This patch is also in "[PATCH 0/6] qapi: convert remaining "simple"
> intro sections".  I believe it's included here accidentally.  Harmless
> :)

Yes, oops. Too far down the rebase chain.


