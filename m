Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A37C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 19:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHTm7-0002tn-Sk; Wed, 12 Jun 2024 15:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHTm6-0002t8-IW
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:36:50 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHTm4-0007B1-Jv
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:36:50 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6f09b457fdso23966966b.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718221006; x=1718825806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a6+CH/Iv6paohDd3X1utok6bq4giO8fcw04omKWdGs0=;
 b=YQzrg1EodJ7FFQ9/RjIpIg3iDCrAaDKULs7HLNUa2RXBfwGOD+PqOEM56B3p4YVM5k
 IWh29dVZ9WClW9X4IHT+HVg+Awaqvs/Dmc9+Y+YXBWlc9/8hnHQbklCZPAp9tEBLUzZq
 57FaydtELb1SJTJdTf1iyo0sWW9mVwP9nwnqXiU/YdoHRPn5wedHnxPYtNocmRhLXErR
 r4dTa9hrZwrCZCsPGiF/brim5vzeIu4P2409ZKtq+CsqTUljVbuf8JW9yZ1gGr+Fw+pv
 NpfMshjBloX2w2fEvhn8qk1g4hr8X4HC0UACv280BTdfd0RViiJBBE9YLHq8+hdYdUPC
 eotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718221006; x=1718825806;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6+CH/Iv6paohDd3X1utok6bq4giO8fcw04omKWdGs0=;
 b=wjvrobarJpgCJtw6FHXo6WlchSVXt33zekLxch0x1LDjLVBircFVYNLfObHTtYIqLb
 hbN5r+NArkxUZWD1Mzf7+NIHDOnkup/D75G7dqbcppDK8FXI720cU3tN102ANerPIHR0
 W3kJm5MZgVWh+G6R6ZhBMviZgBugi56DyNyPzFN2avjgCRG+ZL232hBgZYtkag0WK2TQ
 6rdkEr0DWmuRHWGQAC+Gvaa4dRhna7ISGFbgJZQf08wH+TCNcmJQ+x5QSDqGpdyd2ssl
 yQQEEDDbhBUT1WAvXooVrP9lDXt7a5ccQOIXG8kLzFWH+dyH7MiCMOMGSJ+Ar0FAdyqs
 W/MQ==
X-Gm-Message-State: AOJu0YwQZSqgXAvWj/km9+j/bP2Cq5WU/Os1BjxHGzOpCf9f31MtPjzD
 CuSM93+OnR0Ngv8yrRo0tislEu9VX85OmKosOfrD5hNgBoK/UKZ7AErXZ4T3XEg=
X-Google-Smtp-Source: AGHT+IGgmm3qMQIDAvRQNc/Mbpsp3qjrkVJmPvKjyDz4wj1rVQb+9HEliOPS5jmGdTAC6gMDaKMviA==
X-Received: by 2002:a17:906:1d14:b0:a6f:507a:b0fe with SMTP id
 a640c23a62f3a-a6f507ab15dmr70830166b.62.1718221006053; 
 Wed, 12 Jun 2024 12:36:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6ef83ac0c4sm681098266b.74.2024.06.12.12.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 12:36:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 947675F893;
 Wed, 12 Jun 2024 20:36:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cord Amfmgm <dmamfmgm@gmail.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe Mathieu-Daude <philmd@linaro.org>,  Michael Tokarev
 <mjt@tls.msk.ru>,  Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
In-Reply-To: <CACBuX0SMvD6+vWGBv_m0rBnwgp8fbv6rHKUmbr-MWDLknz8LyA@mail.gmail.com>
 (Cord Amfmgm's message of "Wed, 12 Jun 2024 12:17:30 -0500")
References: <20240520232634.317988-1-dmamfmgm@gmail.com>
 <87cyomxmvc.fsf@draig.linaro.org>
 <CACBuX0SMvD6+vWGBv_m0rBnwgp8fbv6rHKUmbr-MWDLknz8LyA@mail.gmail.com>
Date: Wed, 12 Jun 2024 20:36:44 +0100
Message-ID: <87msnqvtpv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Cord Amfmgm <dmamfmgm@gmail.com> writes:

> On Wed, Jun 12, 2024 at 9:21=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>
>  David Hubbard <dmamfmgm@gmail.com> writes:
>
>  > From: Cord Amfmgm <dmamfmgm@gmail.com>
>  >
>  > This changes the way the ohci emulation handles a Transfer Descriptor =
with
>  > "Current Buffer Pointer" set to "Buffer End" + 1.
>  >
>  > The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more than=
 td.be
>  > to signal the buffer has zero length. Currently qemu only accepts zero=
-length
>  > Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI ha=
rdware
>  > accepts both cases.
>  >
>  > The qemu ohci emulation has a regression in ohci_service_td. Version 4=
.2
>  > and earlier matched the spec. (I haven't taken the time to bisect exac=
tly
>  > where the logic was changed.)
>
>  I find it hard to characterise this as a regression because we've
>  basically gone from no checks to actually doing bounds checks:
>
>    1328fe0c32 (hw: usb: hcd-ohci: check len and frame_number variables)
>
>  The argument here seems to be that real hardware is laxer than the specs
>  in what it accepts.
>
<snip>
>
>  With the updated commit message:
>
>  Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Please forgive my lack of experience on this mailing list. I don't see a =
suggested commit message from Alex but in case that
> was what is being considered, here is one. Feedback welcome, also if this=
 is not what is wanted, please just say it.
>

Something along the lines of what you suggest here (where did this come
from?)

>> From: Cord Amfmgm <dmamfmgm@gmail.com>
>>
>> This changes the way the ohci emulation handles a Transfer Descriptor wi=
th
>> "Buffer End" set to "Current Buffer Pointer" - 1, specifically in the ca=
se of a
>> zero-length packet.
>>
>> The OHCI spec 4.3.1.2 Table 4-2 specifies td.cbp to be zero for a zero-l=
ength
>> packet. Peter Maydell tracked down commit
>> 1328fe0c32 (hw: usb: hcd-ohci: check len and frame_number variables)
>> where qemu started checking this according to the spec.
>>
>> What this patch does is loosen the qemu ohci implementation to allow a
>> zero-length packet if td.be (Buffer End) is set to td.cbp - 1, and with a
>> non-zero td.cbp value.
>>
>> Is this correct? It appears to not follow the spec, so no. But actual hw
>> seems to be ok with it.
>>
>> Does any OS rely on this behavior? There have been no reports to
>> qemu-devel of this problem.
>>
>> This is attempting to have qemu behave like actual hardware,
>> but this is just a minor change.
>>
>> With a tiny OS[1] that boots and executes a test, the behavior is
>> reproducible:
>>
>> * OS that sends USB requests to a USB mass storage device
>>   but sends td.be =3D td.cbp - 1
>> * qemu 4.2
>> * qemu HEAD (4e66a0854)
>> * Actual OHCI controller (hardware)
>>
>> Command line:
>> qemu-system-x86_64 -m 20 \
>>  -device pci-ohci,id=3Dohci \
>>  -drive if=3Dnone,format=3Draw,id=3Dd,file=3Dtestmbr.raw \
>>  -device usb-storage,bus=3Dohci.0,drive=3Dd \
>>  --trace "usb_*" --trace "ohci_*" -D qemu.log
>>
>> Results are:
>>
>>  qemu 4.2   | qemu HEAD  | actual HW
>> ------------+------------+------------
>>  works fine | ohci_die() | works fine
>>
>> Tip: if the flags "-serial pty -serial stdio" are added to the command l=
ine
>> the test will output USB requests like this:
>>
>> Testing qemu HEAD:
>>
>>> Free mem 2M ohci port2 conn FS
>>> setup { 80 6 0 1 0 0 8 0 }
>>> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20920
>>>   td0 c20880 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 be=3Dc20907
>>>   td1 c20960 nxt=3Dc20980 f3140000    in cbp=3Dc20908 be=3Dc2090f
>>>   td2 c20980 nxt=3Dc20920 f3080000   out cbp=3Dc20910 be=3Dc2090f ohci2=
0 host err
>>> usb stopped
>>
>> And in qemu.log:
>>
>> usb_ohci_iso_td_bad_cc_overrun ISO_TD start_offset=3D0x00c20910 > next_o=
ffset=3D0x00c2090f
>>
>> Testing qemu 4.2:
>>
>>> Free mem 2M ohci port2 conn FS
>>> setup { 80 6 0 1 0 0 8 0 }
>>> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620920
>>>   td0 620880 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D620907      =
 cbp=3D0 be=3D620907
>>>   td1 620960 nxt=3D620980 f3140000    in cbp=3D620908 be=3D62090f      =
 cbp=3D0 be=3D62090f
>>>   td2 620980 nxt=3D620920 f3080000   out cbp=3D620910 be=3D62090f      =
 cbp=3D0 be=3D62090f
>>>    rx { 12 1 0 2 0 0 0 8 }
>>> setup { 0 5 1 0 0 0 0 0 } tx {}
>>> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620880
>>>   td0 620920 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D620907      =
 cbp=3D0 be=3D620907
>>>   td1 620960 nxt=3D620880 f3100000    in cbp=3D620908 be=3D620907      =
 cbp=3D0 be=3D620907
>>> setup { 80 6 0 1 0 0 12 0 }
>>> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620960
>>>   td0 620880 nxt=3D6209c0 f2000000 setup cbp=3D620920 be=3D620927      =
 cbp=3D0 be=3D620927
>>>   td1 6209c0 nxt=3D6209e0 f3140000    in cbp=3D620928 be=3D620939      =
 cbp=3D0 be=3D620939
>>>   td2 6209e0 nxt=3D620960 f3080000   out cbp=3D62093a be=3D620939      =
 cbp=3D0 be=3D620939
>>>    rx { 12 1 0 2 0 0 0 8 f4 46 1 0 0 0 1 2 3 1 }
>>> setup { 80 6 0 2 0 0 0 1 }
>>> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620880
>>>   td0 620960 nxt=3D6209a0 f2000000 setup cbp=3D620a20 be=3D620a27      =
 cbp=3D0 be=3D620a27
>>>   td1 6209a0 nxt=3D6209c0 f3140004    in cbp=3D620a28 be=3D620b27      =
 cbp=3D620a48 be=3D620b27
>>>   td2 6209c0 nxt=3D620880 f3080000   out cbp=3D620b28 be=3D620b27      =
 cbp=3D0 be=3D620b27
>>>    rx { 9 2 20 0 1 1 4 c0 0 9 4 0 0 2 8 6 50 0 7 5 81 2 40 0 0 7 5 2 2 =
40 0 0 }
>>> setup { 0 9 1 0 0 0 0 0 } tx {}
>>> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620900
>>>   td0 620880 nxt=3D620940 f2000000 setup cbp=3D620a00 be=3D620a07      =
 cbp=3D0 be=3D620a07
>>>   td1 620940 nxt=3D620900 f3100000    in cbp=3D620a08 be=3D620a07      =
 cbp=3D0 be=3D620a07
>>
>> [1] The OS disk image has been emailed to philmd@linaro.org, mjt@tls.msk=
.ru,
>> and kraxel@redhat.com:
>>
>> * testCbpOffBy1.img.xz
>> * sha256:
>> f87baddcb86de845de12f002c698670a426affb40946025cc32694f9daa3abed
>>
>> Signed-off-by: Cord Amfmgm <dmamfmgm@gmail.com>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

