Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D84ACA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBFej-0004o5-Fe; Mon, 28 Sep 2026 14:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBFef-0004nM-CE
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBFed-000356-C7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790618441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iEhPpJfQgm6GF4EslS3FLodmLvPs4OIPRbio9anLmNo=;
 b=eJoWnLz1EFG4vU4dbg8Y6z/H+73elokUgeQI3O0AOx6ANoUovambj4yEvyzTbRNjFBjlbl
 ER7bOsheFX+Y3PiKcqULRypaO/IEKRMKuWa/z5O3zIBHWu2l291+aYB87dnZT3XiXSWyOc
 y+86Suz+EXBwcKpHa7v4xIUgKiL3g68=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-N1cKuXygMlmfxXBNPHlR5Q-1; Mon, 28 Sep 2026 14:00:39 -0400
X-MC-Unique: N1cKuXygMlmfxXBNPHlR5Q-1
X-Mimecast-MFC-AGG-ID: N1cKuXygMlmfxXBNPHlR5Q_1790618439
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-66ce3040ea9so4537320d50.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790618439; cv=none;
 d=google.com; s=arc-20260327;
 b=H0PP3SkWeUGoEiv8xynGVgFi7ZUdhZr1qXxL/44DY/jDvyD/aFe8tNmBZXXvcbR4kI
 HbdpaVf93oZXEiJf5kIu/1e+kxRNFc2iSLxf0Pci5JnSxb3x7oQeOlPJapzHmDJ+XHcy
 /CY/ijTs2ga0eMoA04N5pw9lLHBkQbIbHeJNMBazVRmuNJ9NvPcK/cuQWDU66xq3xQ44
 lDrh0n+Iy8LllvRyrmCvlrwa8uD3QhASF8w+rXUgPR2sa+LNQwR3Lqi2S9iz0sXS7omu
 VW88pUfyO4mh2NU/ckpJeYmFrdAAw0phIbo7zP642e6P4APmsSWKcyfuprHL37AidTXq
 z2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iEhPpJfQgm6GF4EslS3FLodmLvPs4OIPRbio9anLmNo=;
 fh=Z6xqQETmBQHCMUmtgNvZpB0/PqW8mRNgD4h2NHznaGA=;
 b=iV6IGIBrwT0w3q8bQAbe5eNEQrCX6JSAweMSas7hhwSkcdrQlIRxuFi2pFWdCUr0Z7
 ukvfLOSSim03UzAl/P3iFZNBI22yqViMfOHhH26kUnTum+Gib2N9TSMR2ogMlDy9IaIu
 1si5bU48D9twq/qfKGnhs4xx5nwxXlZ35IhJkW3GszPuGTRJU/aetBRlUn3279OuEzKn
 jVo0+eaape3RN6FtVCaK6f96zD4VJf5iEHErXpNo4ZLBKvZ/sk15vRXB6OXiYwnLIv2P
 HJEjAyulnvuceNQqFyfUlkoYF5yXHYMLS2QS5L/ARYGqjkQM7KkOt7mtS/L24I+pcKCz
 93lQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790618439; x=1791223239; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iEhPpJfQgm6GF4EslS3FLodmLvPs4OIPRbio9anLmNo=;
 b=nMLXMqxRF8rm28FFp+7fHoQENdwVAscEq2a3+lpTZ/F372sgJdGZJv+XWF+xH8EkgL
 UL7H0mrN1FkbzD+0WExWGafM1yjme0++8oYx1NBqrh1Rfqc58vKtU8NsuWewYyrgeb6B
 w4Vrtj5vM4xVRfDZdAfD0m80m4cnHsjBigoNNb3+SiljDe4KpYYbXI4bOKhuDCbK0P5D
 iPqCUzQ/SGwjj50XGwDnZutHE9d3SMn/TdD4IMRgndA5203HVtAJR0WCbHSqba59E5Cj
 0Z6GWQ2kZsdGCG5Tl+iS8UYXeqUVAqAV423XwtEoMK8wi3KtUOTljJe6tOQM3O1t3a2T
 aRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790618439; x=1791223239;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iEhPpJfQgm6GF4EslS3FLodmLvPs4OIPRbio9anLmNo=;
 b=ZsWS9DCplHsKcH9mhvZmiZr6sa9kPJaL/qd5LeQDgMpMx04NWQzNnAOWeGbQ2mh+cT
 tP8JyFBMyp1eZa7bT8x2rL+OQ7PqYZkEqb9HFXfedJA2ILCoiurXBrlDg0+mYf61AmOU
 u3tTjJFr9NIjE6Ha0N/XWccMoe/TscPao0t6tepvFcAnnp7APlAV/2sFYw3SKPMb/BXn
 tDek9SsVslC5FBpvpLlln6IzwvBn3eLNyZOz2N+Cmkymtvao4xjby1jNmZt9HYpAlSh+
 iDozRfBg45qGxpCOUgiU1hdeWgjoqtxS4NI+TZHt2IPihUJdxpGU8C3zcqxjB2d6zSZU
 RQpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVG/Z4R3ZH6KWUxI6K4wdNU9gUM2VNfqftYSYvglzYudeocTPCeq2xwLhie02ktlPSaiixxoevocyV@nongnu.org
X-Gm-Message-State: AFq9FYLpfbfc3jazJOkTa2EZfRU4zXg34O4l/+0NVmEljYJcSlNBc32q
 8uRmq2NxPP4eUmVCbpgWWCK6sXHVjs7lEC5ron+GxpbrMoedWsf2AZrxxemtiizgZR0nXRO1qU0
 0YAn9PfYvnT3QVTagRzW7SJaq9UwmpMcv1yCpIZD2K9idnk8b+1P8IWuyvhIiwob7pBfWncO8gg
 NZZrt+B/NjQgN8T+Ouc3gEejVQBURhI6M=
X-Gm-Gg: AYBFou0Nat2dVNmT5H3rhIafUvGPcxvWJgvITvPYiTLiW2Hzk8Opl9NXiISOvh03BxB
 iaeA+PeJkNx+jq3vVXeHOfKOczM0Fk7b3G0UxY5e5ueKbuosQw+eEDQPXkcLVgFyjcsbbmXbq1Y
 sOkMbfJOPQ29l/7W0qlif8ADh/BUat/nl+jU/2/xv4kmm9HkNYsMPtrioPlyY0VaKnG6iuR/iaF
 3HCKpaa0AMVDUIb
X-Received: by 2002:a05:690e:812:20b0:674:1743:a143 with SMTP id
 956f58d0204a3-6741743a7ccmr2077777d50.148.1790618438439; 
 Mon, 28 Sep 2026 11:00:38 -0700 (PDT)
X-Received: by 2002:a05:690e:812:20b0:674:1743:a143 with SMTP id
 956f58d0204a3-6741743a7ccmr2077760d50.148.1790618437790; Mon, 28 Sep 2026
 11:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260921205712.1862167-1-jsnow@redhat.com>
 <20260921205712.1862167-4-jsnow@redhat.com>
 <877bkcwcl5.fsf@pond.sub.org> <arp6VdpPGB8JgMJt@redhat.com>
In-Reply-To: <arp6VdpPGB8JgMJt@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 28 Sep 2026 14:00:25 -0400
X-Gm-Features: AclHuK-RnGzfrxbiOE0YxfB7iu-z2CNj_ss3DFdl6CFGAveFY_KLbkO5tGBVNWM
Message-ID: <CAFn=p-awvipaJTFXnoKV45mMLyrce9yOECUC1hMPQ=VDdiscLg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] qapi: convert/split intros for block commands
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Jason Wang <jasowangio@gmail.com>, qemu-block@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Sep 28, 2026 at 10:33=E2=80=AFAM Eric Blake <eblake@redhat.com> wro=
te:
>
> On Wed, Sep 23, 2026 at 11:17:58AM +0200, Markus Armbruster wrote:
> > John Snow <jsnow@redhat.com> writes:
> >
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> >
> > Consider mentioning how this affects rendered documentation:
> >
> > 1. blockdev-open-tray and blockdev-close-tray: first paragraph splits
> >
> > 2. block_set_io_throttle, nbd-server-add: Arguments: move up.
>
> I'm liking this series, but also the suggestions of documenting the
> known impacts. At this point, I'm trusting Markus' review rather than
> diving in deep myself, but you're welcome to add:
>
> Acked-by: Eric Blake <eblake@redhat.com>

I'll admit that I have been somewhat lacking in providing a
comprehensive analysis in each cover letter as we have been doing this
conversion rather piecemeal in order to make it more palatable on the
list, but here's the best, shortest synopsis I can hope to give you:

(A) In order to define a point in the documentation where we should
insert auto-generated documentation (for members, returns, etc) we are
pivoting towards a strict ordering of sections:

1. Intro
2. Members
3. Returns
4. Errors
5. Features
6. Details
7. Since

With this goal in mind, the "Intro" will always be up at the very top,
but "Details" - the unindented portions in this series - are
ultimately fated to get sifted to the bottom. If you consult the
rendered QMP documentation - for example `block-dirty-bitmap-add`:
https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#command-QMP-bloc=
k-core.block-dirty-bitmap-add

The stuff that appears in the middle - Arguments and Errors - always
forms a two-column table sort of layout.

Anything that appears above it I have been calling "above the fold" -
and that's always the Introduction text, now.

Anything that appears below I have been informally calling "below the
fold" - and that's always details text, now.

So with this in mind, stuff I indent will go "above" and stuff I do
not will go "below". Simple enough.

(B) The tricky part: We are still pursuing the documentation inliner,
which means that for block-dirty-bitmap-add, the arguments we
"inherit" from the "BlockDirtyBitmap" structure will be displayed
"inline" as if they were defined locally for this command. When we
inline documentation from another definition/entity, we need to know
where and how to splice the documentation together to form a coherent
document.

What Markus and I decided on was to *drop* the intro from any inlined
documentation. For this reason, delineating the Intro from the Details
becomes very important: the Intro text will not travel with the
inlined arguments.

With this in mind, the splits we are creating here become very
important for structures specifically, as their intro text will get
dropped on the floor when it is rendered in an inlined context. The
split for commands, enums, etc., is less important because there is
never any circumstance where we would drop the intro on the floor.

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>


