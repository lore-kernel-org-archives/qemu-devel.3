Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7600E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJFu-0005sj-Um; Thu, 05 Dec 2024 16:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJJFt-0005sT-7C
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:19:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJJFp-0004U0-7Z
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733433559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXI3tsfTyvI9BuejIpXKaDaqjzqRGG5fozWw8z2vD2w=;
 b=fJ3W0IBQZHOP5Da+kAnXzXyXUCU6KFeCSDUPv8VexpXd3L32ZYamqGr2+VllSgZInMtMO6
 P/3XbtwDDOQ3uihAGb/vpHN7aCJDokeXBCPG84Y43QvToWQsHYpOStvTvQyhAYBd6o64O0
 UEtua8LzuiDXJwOD2a2OORVBCm9xLro=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-oAJcoL18PzOVcD5OSQ__sA-1; Thu, 05 Dec 2024 16:19:17 -0500
X-MC-Unique: oAJcoL18PzOVcD5OSQ__sA-1
X-Mimecast-MFC-AGG-ID: oAJcoL18PzOVcD5OSQ__sA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-381d0582ad3so1099027f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733433556; x=1734038356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXI3tsfTyvI9BuejIpXKaDaqjzqRGG5fozWw8z2vD2w=;
 b=HUJ/piNpBzhNAlYG1PUEHI44nOXEDuj+/0vQn0R11i6jbmNZyPfhU336CU0VnuPN/s
 biWefvMOX9nrIgcmbMIhytdV+UXkqBJcYNtUdlrwGWypAwq/KKH7ouhFgnT/AlO2ztgz
 ArzTWxKK68nDIccRwy13OmwIjO5UbbFpEhb2EPBm/EE8Xan1N/Wni2OXWt6LHRXfwQ4K
 g62GqQuwHIOOpC33zmKeVDNes3pONdP4oKZDCGuvZ80G1WdhD3KeFH10DwTY063h4HT9
 1uS2eBlErcbV3dBeT9U1HgWSpwl1QE5OT84fmbBCFNGu1t0xNWpirnmE90Lq3zuz8Ykx
 B5UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ5prbUnJq5+jO1hHOLhKvHd2iwwHIcdzMnUKQYNDhRRiJZMzQLT9cHaYEMZMAU88epzg6pEWs7tt9@nongnu.org
X-Gm-Message-State: AOJu0YyG+EWNzwTwC9+R/F2JCQDRcLx24e8geJ04+pkPdf+Jt0NxiR3w
 +m/ILZbWxY03awi8QhSkPT3bmhtG8jsaopAuCbDuiwlQQNbXzRrsnnsKKaNk2n/QkZVwqlPMnCs
 2YBuNw6y3kFf6uzkpEpUCQbq17zF0U9CCvlXp5hPrDtcFC0YNfHaFKYnjP44YEaAI87IKd5La+E
 nTyTRh7H9NtJYI9ndYWtoHfFcS0xo=
X-Gm-Gg: ASbGncv2E2UGuiwguERZJkfMd+BvqIJPTrd7pCu1la5H1HEJ4r5FHfvR3auJAw+LF2v
 /p0+MSWWrRA/kMv74VAIRaK3zQdVi+jqq
X-Received: by 2002:a5d:5f8c:0:b0:385:f66a:4271 with SMTP id
 ffacd0b85a97d-3862b33ce03mr429185f8f.4.1733433555980; 
 Thu, 05 Dec 2024 13:19:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrPmaF9yr+0WjzCSAwMpfuWJn+5BcSt4W/dF3U8X0EMuudal6yikyprmhQBKXNpw1yA0wzRE+hgclksex+D0Y=
X-Received: by 2002:a5d:5f8c:0:b0:385:f66a:4271 with SMTP id
 ffacd0b85a97d-3862b33ce03mr429169f8f.4.1733433555599; Thu, 05 Dec 2024
 13:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-10-zhao1.liu@intel.com>
 <ed49af53-4a10-4cee-829e-d5921b8aee3c@linaro.org> <Z1GgjZOCc8vkkB3A@intel.com>
 <8cb0a692-420a-4645-b1b8-bc6e47bbb116@linaro.org>
In-Reply-To: <8cb0a692-420a-4645-b1b8-bc6e47bbb116@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 5 Dec 2024 22:19:04 +0100
Message-ID: <CABgObfa7ojzTWOdzd9MUq76ebO8oEU24ew=N80JOOEd=7XuO5g@mail.gmail.com>
Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Dec 5, 2024 at 10:18=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 5/12/24 13:46, Zhao Liu wrote:
> > Hi Philippe,
> >
> > On Thu, Dec 05, 2024 at 01:04:58PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> Date: Thu, 5 Dec 2024 13:04:58 +0100
> >> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet=
.c
> >>
> >> On 5/12/24 07:07, Zhao Liu wrote:
> >>> HPET device needs to access and update hpet_cfg variable, but now it =
is
> >>> defined in hw/i386/fw_cfg.c and Rust code can't access it.
> >>>
> >>> Move hpet_cfg definition to hpet.c (and rename it to hpet_fw_cfg). Th=
is
> >>> allows Rust HPET device implements its own global hpet_fw_cfg variabl=
e,
> >>> and will further reduce the use of unsafe C code access and calls in =
the
> >>> Rust HPET implementation.
> >>>
> >>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> >>> ---
> >>>    hw/i386/fw_cfg.c        |  4 +---
> >>>    hw/timer/hpet.c         | 16 +++++++++-------
> >>>    include/hw/timer/hpet.h |  2 +-
> >>>    3 files changed, 11 insertions(+), 11 deletions(-)
> >>
> >>
> >>> diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
> >>> index d17a8d43199e..dbf709251a8f 100644
> >>> --- a/include/hw/timer/hpet.h
> >>> +++ b/include/hw/timer/hpet.h
> >>> @@ -74,7 +74,7 @@ struct hpet_fw_config
> >>>        struct hpet_fw_entry hpet[8];
> >>>    } QEMU_PACKED;
> >>> -extern struct hpet_fw_config hpet_cfg;
> >>> +extern struct hpet_fw_config hpet_fw_cfg;
> >>
> >> Could this field belong to the (yet unexisting) HPETClass?
> >
> > Several instances would share the same class, so HPETClass could manage
> > multiple HPETState info.
> >
> > But in fw_cfg.c, do you have idea about how to get the HPETClass?
>
> Have hpet_find() return an Object and call object_get_class()?

That would work, but anyhow this patch breaks compilation without HPET
so the question is a bit moot. :)

Paolo


