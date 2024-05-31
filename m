Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1800C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 14:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHOrH-0001xa-6m; Wed, 12 Jun 2024 10:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHOrF-0001wg-Kk
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:21:49 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHOrD-0007YD-O4
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:21:49 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ebe6495aedso31821921fa.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 07:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718202106; x=1718806906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references:date
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RZYotvZm8flZHwVGs3lruaxI5q9gsqXWfY/eQ2ZxrdE=;
 b=Bk5EVQPRJa6UU01Nxv+ge1Wgc+42t4CVK/iv/5husSzjyNIFyj+STXP4RdoQy0k5MQ
 bvFEop6AUGUd7RKEEIhajpdMyvnDLDxvqKt3XPEXthdKJlv4P+o3APs3mIlPvrReJb7A
 JxfY2CyIun487e+1yWaol1W4H7veV9xJ65T0yQtaNjqye+2XWMHg1wB1o18QlUPD2uBc
 2Yup6v9x1joF24VLGy6lzW/DShkrv9ZFCeDcv/Szz/HTC0MitWao2/h8BXqWhxsp4+38
 6Fh2B1V/hcjcJ5RIt+Q8+U4+nMfD0a7t9YMMoLzcEAoVbjKMY6XIBk1yXed3r9TBysgK
 LD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718202106; x=1718806906;
 h=content-transfer-encoding:mime-version:message-id:references:date
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RZYotvZm8flZHwVGs3lruaxI5q9gsqXWfY/eQ2ZxrdE=;
 b=uAnoUoHmGomSO2+xkizom13i8wLR7EmBoY2wCQCYYDQcdLL5TUZbX5ju/Pj4H2EfAt
 qkUBKEnrkvdgoM776FLhgsiC2tyQumU7HeaXHzgOGrUNdak5PcjTDsGtq2nhNl1joDU+
 scHJeR1T+jdnxvFoxvMjNZixQ/KawtVu2HQUA4yRpb2qffTWNOy0hZyPUR4GseFMgMpY
 D0WgzVsDjZ/3Ax40FfjK4XXH9yckOxa2KfXejilt91Gw0xpNoAFTblCavnaff860C5af
 JbEGBfgOE8Q1nfr+ciYsziIDnMRmT+fB88xmbgv1ucpH+KN3ADQhDlLN/JCLW4ox+dse
 qEaw==
X-Gm-Message-State: AOJu0YwTjyt4E0gSbN/EPn6zQbv/Uov+3ZzwFsL2NcW2HNalVZqb2hlC
 qwm5lr/ayE080rY/3gzWabd0fQa20/SztIukO213EuywZ+7bnvG0GqmfRD6exqc=
X-Google-Smtp-Source: AGHT+IHP/FjNL61stWtOPDB05AI4oDYdmvIpilw416ZrTKgXrAMbLCg8kOO8omdoDgqoG+irPJGEnA==
X-Received: by 2002:a2e:9cd6:0:b0:2eb:dec1:6276 with SMTP id
 38308e7fff4ca-2ebfc8585d2mr13253371fa.0.1718202105729; 
 Wed, 12 Jun 2024 07:21:45 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cab3f4741sm1198366a12.22.2024.06.12.07.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 07:21:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 59DA65F893;
 Wed, 12 Jun 2024 15:21:43 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hubbard <dmamfmgm@gmail.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe Mathieu-Daude <philmd@linaro.org>,  Michael Tokarev
 <mjt@tls.msk.ru>,  Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
In-Reply-To: <20240520232634.317988-1-dmamfmgm@gmail.com> (David Hubbard's
 message of "Mon, 20 May 2024 18:26:34 -0500")
Date: Fri, 31 May 2024 14:59:56 +0100
References: <20240520232634.317988-1-dmamfmgm@gmail.com>
Message-ID: <87cyomxmvc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

David Hubbard <dmamfmgm@gmail.com> writes:

> From: Cord Amfmgm <dmamfmgm@gmail.com>
>
> This changes the way the ohci emulation handles a Transfer Descriptor with
> "Current Buffer Pointer" set to "Buffer End" + 1.
>
> The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more than td=
.be
> to signal the buffer has zero length. Currently qemu only accepts zero-le=
ngth
> Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI hardw=
are
> accepts both cases.
>
> The qemu ohci emulation has a regression in ohci_service_td. Version 4.2
> and earlier matched the spec. (I haven't taken the time to bisect exactly
> where the logic was changed.)

I find it hard to characterise this as a regression because we've
basically gone from no checks to actually doing bounds checks:

  1328fe0c32 (hw: usb: hcd-ohci: check len and frame_number variables)

The argument here seems to be that real hardware is laxer than the specs
in what it accepts.

> With a tiny OS[1] that boots and executes a test, the issue can be seen:
>
> * OS that sends USB requests to a USB mass storage device
>   but sends td.cbp =3D td.be + 1
> * qemu 4.2
> * qemu HEAD (4e66a0854)
> * Actual OHCI controller (hardware)
>
> Command line:
> qemu-system-x86_64 -m 20 \
>  -device pci-ohci,id=3Dohci \
>  -drive if=3Dnone,format=3Draw,id=3Dd,file=3Dtestmbr.raw \
>  -device usb-storage,bus=3Dohci.0,drive=3Dd \
>  --trace "usb_*" --trace "ohci_*" -D qemu.log
>
> Results are:
>
>  qemu 4.2   | qemu HEAD  | actual HW
> ------------+------------+------------
>  works fine | ohci_die() | works fine
>
> Tip: if the flags "-serial pty -serial stdio" are added to the command li=
ne
> the test will output USB requests like this:
>
> Testing qemu HEAD:
>
>> Free mem 2M ohci port2 conn FS
>> setup { 80 6 0 1 0 0 8 0 }
>> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20920
>>   td0 c20880 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 be=3Dc20907
>>   td1 c20960 nxt=3Dc20980 f3140000    in cbp=3Dc20908 be=3Dc2090f
>>   td2 c20980 nxt=3Dc20920 f3080000   out cbp=3Dc20910 be=3Dc2090f ohci20=
 host err
>> usb stopped
>
> And in qemu.log:
>
> usb_ohci_iso_td_bad_cc_overrun ISO_TD start_offset=3D0x00c20910 > next_of=
fset=3D0x00c2090f
>
> Testing qemu 4.2:
>
>> Free mem 2M ohci port2 conn FS
>> setup { 80 6 0 1 0 0 8 0 }
>> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620920
>>   td0 620880 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D620907       =
cbp=3D0 be=3D620907
>>   td1 620960 nxt=3D620980 f3140000    in cbp=3D620908 be=3D62090f       =
cbp=3D0 be=3D62090f
>>   td2 620980 nxt=3D620920 f3080000   out cbp=3D620910 be=3D62090f       =
cbp=3D0 be=3D62090f
>>    rx { 12 1 0 2 0 0 0 8 }
>> setup { 0 5 1 0 0 0 0 0 } tx {}
>> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620880
>>   td0 620920 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D620907       =
cbp=3D0 be=3D620907
>>   td1 620960 nxt=3D620880 f3100000    in cbp=3D620908 be=3D620907       =
cbp=3D0 be=3D620907
>> setup { 80 6 0 1 0 0 12 0 }
>> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620960
>>   td0 620880 nxt=3D6209c0 f2000000 setup cbp=3D620920 be=3D620927       =
cbp=3D0 be=3D620927
>>   td1 6209c0 nxt=3D6209e0 f3140000    in cbp=3D620928 be=3D620939       =
cbp=3D0 be=3D620939
>>   td2 6209e0 nxt=3D620960 f3080000   out cbp=3D62093a be=3D620939       =
cbp=3D0 be=3D620939
>>    rx { 12 1 0 2 0 0 0 8 f4 46 1 0 0 0 1 2 3 1 }
>> setup { 80 6 0 2 0 0 0 1 }
>> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620880
>>   td0 620960 nxt=3D6209a0 f2000000 setup cbp=3D620a20 be=3D620a27       =
cbp=3D0 be=3D620a27
>>   td1 6209a0 nxt=3D6209c0 f3140004    in cbp=3D620a28 be=3D620b27       =
cbp=3D620a48 be=3D620b27
>>   td2 6209c0 nxt=3D620880 f3080000   out cbp=3D620b28 be=3D620b27       =
cbp=3D0 be=3D620b27
>>    rx { 9 2 20 0 1 1 4 c0 0 9 4 0 0 2 8 6 50 0 7 5 81 2 40 0 0 7 5 2 2 4=
0 0 0 }
>> setup { 0 9 1 0 0 0 0 0 } tx {}
>> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620900
>>   td0 620880 nxt=3D620940 f2000000 setup cbp=3D620a00 be=3D620a07       =
cbp=3D0 be=3D620a07
>>   td1 620940 nxt=3D620900 f3100000    in cbp=3D620a08 be=3D620a07       =
cbp=3D0 be=3D620a07
>
> [1] The OS disk image has been emailed to philmd@linaro.org, mjt@tls.msk.=
ru,
> and kraxel@redhat.com:
>
> * testCbpOffBy1.img.xz
> * sha256: f87baddcb86de845de12f002c698670a426affb40946025cc32694f9daa3abed
>
> Signed-off-by: Cord Amfmgm <dmamfmgm@gmail.com>
> ---
>  hw/usb/hcd-ohci.c   | 4 ++--
>  hw/usb/trace-events | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index acd6016980..71b54914d3 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -941,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct oh=
ci_ed *ed)
>          if ((td.cbp & 0xfffff000) !=3D (td.be & 0xfffff000)) {
>              len =3D (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
>          } else {
> -            if (td.cbp > td.be) {
> -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
> +            if (td.cbp - 1 > td.be) {  /* rely on td.cbp !=3D 0 */
> +                trace_usb_ohci_td_bad_buf(td.cbp, td.be);
>                  ohci_die(ohci);
>                  return 1;
>              }

With the updated commit message:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

