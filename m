Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF60C624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Rs8-0004Mq-74; Tue, 01 Sep 2026 13:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1Rs7-0004MV-87
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1Rs5-0000wt-Jv
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788282124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60T+l3AlwkUKJ6uA4fVa+g+7QEfq9adnME/zrJKlEjU=;
 b=LyNAS4TVbM8FQIbw+1pn4iRY3IjwJZSOaxxctintn34IlRZ9W+aNW5KrgMCQ2tiUScRpEd
 J0VF1KvQDiRWixQYMdTpKAylzQyi4ZmUKPCFtoupZT+RK3pv0EJC3ZIRKoSE3Ut5e1bnYh
 Jfv27eUjkMvzyS/76K1FGkaLgb7VfvE=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-8W0KZ0QBOlWNz1TmEO3R6g-1; Tue, 01 Sept 2026 13:02:03 -0400
X-MC-Unique: 8W0KZ0QBOlWNz1TmEO3R6g-1
X-Mimecast-MFC-AGG-ID: 8W0KZ0QBOlWNz1TmEO3R6g_1788282122
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-66c767e23f6so88831d50.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 10:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788282122; cv=none;
 d=google.com; s=arc-20260327;
 b=EmZBBZkcqRKXhfWA5ijxHhdvmg67c3XzWqH56sbtF33ku1rsD/bsSaW00to/YevER4
 HQnjJ0PGVrq9mVYG+vjYc/cjg+lXCWkZTKznBLuGAXApZA4Yn4Cxt4mII4jGpo9PnezK
 Q5jQFRvsUHuskmRrQP8KH6dCc5ajKNvqwvadm0/EOnNvvZcDragathFj5iIDh822daKB
 CX/xmvsNnyaAbN61WUkJ9jWzdM1IJZEr2mdSwm9ijgBHm3JNNRj29MnELBs8UkXlLctE
 SKDyKWcTquUoiGPOaTWW9nkBHQgsxk2RxE6yVr9KoIHoJsEd9PBr3DBkGJcbpviWdILm
 AzwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=60T+l3AlwkUKJ6uA4fVa+g+7QEfq9adnME/zrJKlEjU=;
 fh=60V1tAG+kWPZTX8HCTMXfOXb3Vr/kV6rH1RFz0AmpMo=;
 b=sql8jAGSnXkNfxpkTcqG0AYBfeUgGeG/nMg6qlTvZMdZNOY88N+tSxS1+qU7OXYW2i
 KxEJJRz8dhmsMe4aLGY6C8nW4q50BDPgW2oFlbRWXkmDDbXqZeEMR5njb+Gru1FgwT8M
 ZjBYvgViFY/XsusrGiYH0oe6BGgNI6yuHNbmW8W/INNu37fpUi6Z+j+v+B2ubxqaTUcQ
 QjUs2poryFYzUETgObhZ/T/L+8DP6aY6GXWZ50b1m8hjhyYKRa27msMTSyHYTHXxzrLO
 V4ehIV4aQ9n23iTnfaUXVHvD7rbTXaaU25V2TtKl5TrovdVPYPKMJkPXF//Hw0a4I4J5
 b/xA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788282122; x=1788886922; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=60T+l3AlwkUKJ6uA4fVa+g+7QEfq9adnME/zrJKlEjU=;
 b=pbt+ADTRyYKezNwA14Jz/Wk1Ko7F7tPEcfLjDUYN66VD3DrkDwnr2ta0dJxv1Tueby
 Ouhc3R2RUkcrsXU4KILwN2Did7OfDlDKVbcUEiO3xXdRVPou9+BkvFhdBiAedai9dI6F
 xs/7yK2Trz65KM5HPrRuaUVwTcLMBkndEcrH9ewmPqWk01+EROOZ0KPD/x/CnU5RFU3P
 WqFyKn/HFrIHF53MfNPAVqfig6ELveawoM3JlUplNGYMXfVy1ornwT93n6yWd6A0nFjm
 312F71ct+EhH+BiQu3U1xm9q3bNEu99VmgPTK9ON1SQQguiaaXCyMYYiIJyPuqHQpMLe
 qZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282122; x=1788886922;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=60T+l3AlwkUKJ6uA4fVa+g+7QEfq9adnME/zrJKlEjU=;
 b=RDe/it9jrPAP25e+VJRxfOYDJ6AqpxFI6FSVC+ah/PRyeyLoXwjKQ68FKDoawjTJaH
 ouVGDNTSJQoUx9jB/JfU9SIO/2uNaiCy+bO1wXsF2329tFjkzqUB2lkobPok/Et0XXtZ
 FD6P20bYI1bS1ddGB7AcxkgnbGlH0Ya8gEkFJu3PPV7UFKJa9ORfv4geUyPbqlyAhRlo
 mLQiIGQXiArZsx6EKqVAaRgKIidJitc2ApDnCSEQelzkWTA5YXb6H1fcmjb4rn+WeSBN
 is+QzYC23TrrA3cM1XMtxKf7wyZ4hM2p8UT7Ck9XodTZDXciD7AYdpAt8BFmdC/U55Su
 /q0Q==
X-Gm-Message-State: AFuF++khCEOhcsrpUuDjWPg15E7LDzujpiIjazz5cz5csLVrA6zXT1vz
 Jw771ShBHvZ6llwVSwBfyGAByak6nuzG4Rmt5yIZtMHuOGjzAu9fhX8frXKfN2QMBfVVgIrOSja
 KMn4prRVmdpZxP4UzOLyhPfozdmQ2jpCjFx5LiUm8LDqf2E+NTxUgQhn/42k3dsLwpn1tL7snHS
 iDlL/sc82U3Sxf+cjVq50WN1df6lSk5E4=
X-Gm-Gg: AYBFou0OU8R6f9nllEJTKE+4QWcB17GwhVzzsv0dWb96stc8gh4bVXI0eyJp+nHCySW
 mj13+ERWvr5wh9A2QZwyEKMeA3cUjPyMIPWkkqXu7o1Oc+HDq81oHUT9w3Iq0a3yrP+DGQdQ+xv
 ssq4QocagfKO89r8rB4canf1+y7nhuAwRdGQUMYDEoFgcSBxiIJ1gBo//9NL1tnRaSOPmGjESfG
 af1fqFMHFmX0Fk/
X-Received: by 2002:a05:690e:134b:b0:66e:5def:7fb with SMTP id
 956f58d0204a3-66f873db286mr2861699d50.9.1788282122185; 
 Tue, 01 Sep 2026 10:02:02 -0700 (PDT)
X-Received: by 2002:a05:690e:134b:b0:66e:5def:7fb with SMTP id
 956f58d0204a3-66f873db286mr2861611d50.9.1788282121503; Tue, 01 Sep 2026
 10:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260831201945.287730-1-jsnow@redhat.com>
 <871pbd9qpy.fsf@pond.sub.org>
In-Reply-To: <871pbd9qpy.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 1 Sep 2026 13:01:49 -0400
X-Gm-Features: AcwNN1WwY9KhOHhEffsoAqUdDjHzsfzGhf3WCZkKFn57tI6T-m4ZzTC2sD0ecwY
Message-ID: <CAFn=p-YBpsxy-3tr0SZ0CBfXUYnb6eg6AxNWpwUQmsuY5ZuykA@mail.gmail.com>
Subject: Re: [PATCH v4 00/43] qapi: convert (very) trivial intro sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 zhenwei pi <zhenwei.pi@linux.dev>, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jiri Pirko <jiri@resnulli.us>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, linux-cxl@vger.kernel.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 linux-edac@vger.kernel.org, 
 Michael Tokarev <mjt@tls.msk.ru>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eric Blake <eblake@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-trivial@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 1, 2026 at 7:05=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

Thank you for your suffering :)

So, I think there's actually no real problem in checking in a partial
conversion as the infrastructure was coded specifically to allow it,
however you're the maintainer so I will follow your lead. I'm more
interested in moving forward than telling you how to do your job ;)

The series will eventually enforce strict ordering, so there is no
chance we will miss anything. If we send a PR now, we also don't have
to keep rebasing the partial series against master. If you don't want
to submit a PR, please create a branch I can track and submit patches
against, and please periodically rebase it against origin/master.

Thanks,
--js


