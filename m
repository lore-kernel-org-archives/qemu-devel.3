Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE9ED132CC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 14:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xd1-0004HV-7n; Mon, 04 Nov 2024 09:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1t7xd0-0004HA-0e
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:00:22 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1t7xcx-00052M-Mz
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:00:21 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c767a9c50so39944295ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 06:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730728817; x=1731333617; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o4ev782Upul9mnYQkcVYu7XgIc+ueVOkYherNHNxmo0=;
 b=NlElC57dqQ7lQMscmAWU58gL3+jlrBaKOOL6n2iJWwnTItwY3l9l1Bh3mE54DeozOB
 anmcJz0CkfpgQ1fGIfpwa9anoEFptjvd7VPaMYKna5mV4k66lJt3769LGj0b29Cvkzy9
 FZEuRaZE/SJ9x6R8nyWR+9qh+VnmLNAmNHN9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730728817; x=1731333617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o4ev782Upul9mnYQkcVYu7XgIc+ueVOkYherNHNxmo0=;
 b=RaS4yAntDivrYcujECG/S0diAVLCKdptauQn9S/GxH5GXPZOW9Q8b6bVj8KLfUCs0o
 XS+Du/SxKoEtMgQNVXxV7+7a2P8Ex7e/TpBhEwd48cdY7HdBAsu8Idl9MGtV311ufzgZ
 Bo+ZLc12xiz4FLSMSmgGFWqtkI/ttDHOfdEp0yt4/6ino4RfsN1n3lg3zL2+faA9Dyf0
 PqRF7aPNjWe2dLrWDfEGmHfJXTp9HigEptlmP1bFp6QaWn0j6aA2nUKIhJ607ur+SgQG
 owK3w/MO7pZvpnugL76/ix9rL5AweTYHqEVCaBeZy/YJBkx1UM2XYGijNlpS7nbl4iZJ
 +aSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfrFtz/4bu+EX7FNeplR1Z/pnRd54T+tWG4gDls7qjvcrOVY+hNjhEXelNVy9jGNy0CMEtYvbZGZ1o@nongnu.org
X-Gm-Message-State: AOJu0YxvYm6b+lMs3rVFCCPxNrq+Co/o3Aa7DtAJalDNY8HRt8X0Ww4q
 ESg65Mhq42gsFopVc/OfQ55qpP1owMfadeimh20iFI/5p37LM8JpC+m3MHXTHxx/ej+BhaRsmSI
 =
X-Google-Smtp-Source: AGHT+IHA1YpDCrSipP84aiCHjGg4d+sriCN+zOm/Y0HBrECpEO00rW4wN4BHG7qTuHqoO9GN2hyH4Q==
X-Received: by 2002:a17:903:181:b0:20c:a189:c006 with SMTP id
 d9443c01a7336-2111afd268bmr150057085ad.45.1730728816527; 
 Mon, 04 Nov 2024 06:00:16 -0800 (PST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com.
 [209.85.210.171]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a60f9sm61545575ad.167.2024.11.04.06.00.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 06:00:14 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-71e4244fdc6so3299127b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 06:00:14 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX3u/1WFq5caTFmZmpsh3cWyFMqeUjsshXwNsRgu8oBp6kuZsTwXeazLMf0gLTb3xjeAXDQN3tfXYOC@nongnu.org
X-Received: by 2002:a05:6a21:7886:b0:1db:e177:7737 with SMTP id
 adf61e73a8af0-1dbe1777839mr3241947637.8.1730728812907; Mon, 04 Nov 2024
 06:00:12 -0800 (PST)
MIME-Version: 1.0
References: <20240924132417.739809-1-ribalda@chromium.org>
 <20240924132417.739809-4-ribalda@chromium.org>
 <20241104084521-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241104084521-mutt-send-email-mst@kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 4 Nov 2024 15:00:00 +0100
X-Gmail-Original-Message-ID: <CANiDSCvTJxAajTVbZdarJ0xqKfUvtPaj_ZHCKcvo6xtHHtwOrg@mail.gmail.com>
Message-ID: <CANiDSCvTJxAajTVbZdarJ0xqKfUvtPaj_ZHCKcvo6xtHHtwOrg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tests/acpi: pc: update golden masters for DSDT
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=ribalda@chromium.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Michael



On Mon, 4 Nov 2024 at 14:46, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Sep 24, 2024 at 01:24:12PM +0000, Ricardo Ribalda wrote:
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
>
> two things wrong here:
> 1. you do not describe what changed in the ASL in the commit log

In the cover page I mention that the ASL diff is NoP:
```
Unfortunately, the ASL diff is not the best (or I cannot produce
something better):
12c12
<  *     Length           0x00003917 (14615)
---
>  *     Length           0x00003914 (14612)
14c14
<  *     Checksum         0xD9
---
>  *     Checksum         0x09

```


> 2. you forgot one DSDT: tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x

Maybe the tree has changed since I sent the patch? I am pretty sure
that I test it before I sent the patch :S
Also, I cannot find that file on the tree:
https://github.com/qemu/qemu/tree/master/tests/data/acpi/x86/q35

>
> > ---
> >  tests/data/acpi/x86/pc/DSDT                 | Bin 8527 -> 8526 bytes
> >  tests/data/acpi/x86/pc/DSDT.acpierst        | Bin 8438 -> 8437 bytes
> >  tests/data/acpi/x86/pc/DSDT.acpihmat        | Bin 9852 -> 9851 bytes
> >  tests/data/acpi/x86/pc/DSDT.bridge          | Bin 15398 -> 15397 bytes
> >  tests/data/acpi/x86/pc/DSDT.cphp            | Bin 8991 -> 8990 bytes
> >  tests/data/acpi/x86/pc/DSDT.dimmpxm         | Bin 10181 -> 10180 bytes
> >  tests/data/acpi/x86/pc/DSDT.hpbridge        | Bin 8478 -> 8477 bytes
> >  tests/data/acpi/x86/pc/DSDT.hpbrroot        | Bin 5034 -> 5033 bytes
> >  tests/data/acpi/x86/pc/DSDT.ipmikcs         | Bin 8599 -> 8598 bytes
> >  tests/data/acpi/x86/pc/DSDT.memhp           | Bin 9886 -> 9885 bytes
> >  tests/data/acpi/x86/pc/DSDT.nohpet          | Bin 8385 -> 8384 bytes
> >  tests/data/acpi/x86/pc/DSDT.numamem         | Bin 8533 -> 8532 bytes
> >  tests/data/acpi/x86/pc/DSDT.roothp          | Bin 12320 -> 12319 bytes
> >  tests/data/acpi/x86/q35/DSDT.cxl            | Bin 13148 -> 13146 bytes
> >  tests/data/acpi/x86/q35/DSDT.viot           | Bin 14615 -> 14612 bytes
> >  tests/qtest/bios-tables-test-allowed-diff.h |  15 ---------------
> >  16 files changed, 15 deletions(-)
> >
> > diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
> > index 92225236e717b2e522a2ee00492fb0ded418dc7b..8b8235fe79e2fa08a6f840c8479edb75f5a047b9 100644
> > GIT binary patch
> > delta 50
> > zcmX@_bk2#(CD<jzPmzIvF>@oAE|a9ky!c?JcmeN{0B27F5towqfS?eDB|_fCn**8t
> > G$pHX!zYhWc
> >
> > delta 51
> > zcmX@-bl!=}CD<jzUy*@<F>)i9E|Zk!y!c?Jcmbc10B27F5!aIVfS?eDCBi<%T$=-!
> > H{>cFVe<%+E
> >
> > diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
> > index 25b39955059409b177870800949eaf937cd39005..06829b9c6c6d726d955dc7c99bc9f42448e22aeb 100644
> > GIT binary patch
> > delta 50
> > zcmez7_|=iiCD<k8s{#W9<ED*Vx=fND^WuY@;sv}*0-QY!L|jVZ1A;;rmI!$lZw_Qy
> > GDhB|jb`RtL
> >
> > delta 51
> > zcmezB_|1{aCD<k8n*sv^<D!jRx=d1@^WuY@;stz40-QY!L|jYa1A;;rmI(V4b8QY_
> > HS}F$svl<WN
> >
> > diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
> > index 73a9ce59e9426b180fea0ec5820c4841ebdb6700..2fe355ebdbb858fa9247d09112e21712e3eddc45 100644
> > GIT binary patch
> > delta 50
> > zcmez4^V^5ZCD<jTT8)8$QEelaE|a9ky!c?JcmeN{0B27F5towqfS?eDB|_fCn**7&
> > FRRD#m4w3)>
> >
> > delta 51
> > zcmezE^T&tFCD<jTMvZ}iQEVfZE|Zk!y!c?Jcmbc10B27F5!aIVfS?eDCBi<%T$=-!
> > Gv{e9+a1N3H
> >
> > diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
> > index 4cef454e379e1009141694e0f4036a2a701c80d7..4d4067c182a6625db1e877408eb7436113884b50 100644
> > GIT binary patch
> > delta 50
> > zcmZ2hv9yBACD<iI)rNtAv3w(!E|a9ky!c?JcmeN{0B27F5towqfS?eDB|_fCn**7y
> > GS^@xfwGR#e
> >
> > delta 51
> > zcmZ2lv8;m2CD<iI&4z)2F?}PKE|Zk!y!c?Jcmbc10B27F5!aIVfS?eDCBi<%T$=-!
> > Hu37>BgE$Wk
> >
> > diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
> > index 1dc928333d7ae7e4df6bb51d850af5e1cb480158..045a52e75b7fcd4e5f840a758c548231498b96e4 100644
> > GIT binary patch
> > delta 50
> > zcmbR5HqVXACD<iIPMLv$@$5z}T_#D7dGWzc@dDl@0nVNVA}%HI0YM=QON6|OHwQAE
> > GQvd*IF%Gf-
> >
> > delta 51
> > zcmbQ|Hs6iQCD<iIUYUV`aqmVhT_!2ddGWzc@d7?20nVNVBCaLz0YM=QON4!jxi$wd
> > Hol^h+ba)Q3
> >
> > diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
> > index 9f71d2e58b1707e733584e38dab7f73f9bda5eb7..205219b99d903555125c4b07fc047c42993eb338 100644
> > GIT binary patch
> > delta 50
> > zcmX@=f5e~5CD<k8h&lrU<IIg*x=fND^WuY@;sv}*0-QY!L|jVZ1A;;rmI!$lZw_QC
> > GQ3U{wR1Yx#
> >
> > delta 51
> > zcmX@&f7GALCD<k8s5%1!W9LRLT_!2ddGWzc@d7?20nVNVBCaLz0YM=QON4!jxi$wd
> > Hm8b#$nr{y=
> >
> > diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
> > index db420593a3c51eced25cd57420353fbb9ccdf63c..8fa8b519ec65bd5099c45f4e1c85b11b47a23845 100644
> > GIT binary patch
> > delta 50
> > zcmbQ|G}npCCD<iIR*`{$aqdPgT_#D7dGWzc@dDl@0nVNVA}%HI0YM=QON6|OHwQAE
> > Gl>-1^5)N_z
> >
> > delta 51
> > zcmbR1G|!34CD<iIPLY9uv3DbvE|Zk!y!c?Jcmbc10B27F5!aIVfS?eDCBi<%T$=-!
> > H&dLD*Ya9-8
> >
> > diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
> > index 31b6adb4eb941e5bf0c02ec8c3819c9213adf022..01719462a72fd6d40ce433dac601e4b94eae574c 100644
> > GIT binary patch
> > delta 49
> > zcmZ3bzEYjbCD<ior7!~nWA8++2a+E1;)9*y1-wfFoIMRhTuR~tf<hRU2zeK8W?@_=
> > F1ORu)4$=Ss
> >
> > delta 50
> > zcmZ3fzDk|TCD<iol`sPXW9>w)2U4E%;)9*y1$;^ZoIMRhTub5uf<hRU2>TRsZDwX%
> > GCIkS3!Vb~^
> >
> > diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
> > index c2a0330d97d495298889b9e28bde2f90235cea88..0ca664688b16baa3a06b8440181de4f17511c6b0 100644
> > GIT binary patch
> > delta 50
> > zcmbR4Jk6QQCD<ionj!-O<I{~?x=fND^WuY@;sv}*0-QY!L|jVZ1A;;rmI!$lZw_Q~
> > GlLr8LI1Zrz
> >
> > delta 51
> > zcmbQ{Jl&bgCD<iox*`Ju<JFB^x=d1@^WuY@;stz40-QY!L|jYa1A;;rmI(V4b8QY_
> > Ha+3!Dh4&7j
> >
> > diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
> > index c15a9fae947bb3929a30c60b7c0f2092705868f8..03ff464ba4e72082fce0921815cfc09ca20b561a 100644
> > GIT binary patch
> > delta 50
> > zcmbQ|JJ*-XCD<iot{MXaWAsKYT_#D7dGWzc@dDl@0nVNVA}%HI0YM=QON6|OHwQBL
> > GssI3QI1W(&
> >
> > delta 51
> > zcmbR1JI|NPCD<ioo*DxKqxVKGT_!2ddGWzc@d7?20nVNVBCaLz0YM=QON4!jxi$wd
> > H`KkZ_dYcYW
> >
> > diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
> > index dd29f5cb620e5164601e303e37524530ddb12684..b081030f0ed171e52b13e28cfdc8770a04c2806e 100644
> > GIT binary patch
> > delta 50
> > zcmX@;c)*d%CD<k8fC2*pqwz*AT_#D7dGWzc@dDl@0nVNVA}%HI0YM=QON6|OHwQ8m
> > G$N>O%X%3M9
> >
> > delta 51
> > zcmX@$c+io{CD<k8paKH}qw+>BT_!2ddGWzc@d7?20nVNVBCaLz0YM=QON4!jxi$wd
> > H703Yqg6|HI
> >
> > diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
> > index 8a6b56fe7da18bf42c339d13b863aabf81780527..2c98cafbff5db04410b35a1151eaf18723a4dad7 100644
> > GIT binary patch
> > delta 50
> > zcmccWbj69wCD<h-M3I4kQFtSlE|a9ky!c?JcmeN{0B27F5towqfS?eDB|_fCn**6x
> > F<N;{*4aEQe
> >
> > delta 51
> > zcmccObk&K=CD<h-RFQ#!k$EGRE|Zk!y!c?Jcmbc10B27F5!aIVfS?eDCBi<%T$=-!
> > GSmXh88x6$(
> >
> > diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
> > index a16b0d9d4becec47fa3cf57ed0077ff6cff88908..da018dca9e3102e811107994248719ab5278c505 100644
> > GIT binary patch
> > delta 50
> > zcmZ3GFh7CICD<iI-hhFD@#{t|T_#D7dGWzc@dDl@0nVNVA}%HI0YM=QON6|OHwQAE
> > G*98E3GY>2P
> >
> > delta 51
> > zcmbQAupoiUCD<iI!GM8*@##h`T_!2ddGWzc@d7?20nVNVBCaLz0YM=QON4!jxi$wd
> > Ho!12bhUO0}
> >
> > diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
> > index f561750cab8b061c123c041fe2209d74c7a740f1..3c34d4dcab16783abe65f6fa5e64eb69d40795fb 100644
> > GIT binary patch
> > delta 89
> > zcmcbUb}Nm`CD<h-%9w$HF?%DIuq>BTe@uL^Q+#xj=Vo<TD@JaYlK6n25QZf}-o={}
> > U)&1Eg?@<j!RwS*4q3Aa^0Nj2Y6aWAK
> >
> > delta 91
> > zcmcbWb|;O?CD<h-#+ZSD(R(A8uq>Bze@uL^Q+#xj*JgEDD@GpIlK6n25QZhfKE+&{
> > V<JJAyC+}7bMOG!HhN<c|Hvs;691s8i
> >
> > diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
> > index 8d98dd8845a60a08df5aff27097646bea4913b75..4c93dfd5c4b362714d3f9aa606a838d4625b3369 100644
> > GIT binary patch
> > delta 115
> > zcmbPUG^L2kCD<iI#FBx5k#i%Luq>BfLri?IQ+#xj>tuD=rQ9wh@c}_03`>N(i#Okp
> > Z4P{4`H&;cKf1!#h@2-m~|3g=v8vqA!B?tfj
> >
> > delta 127
> > zcmbPIG`)z+CD<iI+>(KT@#aP@VOcK!hM4$Zr}*e5x5?_VOL<&N;sb(07?ue86mxC9
> > gE*r{@tiVhaLxC6jWCLApWJRvJSQKrxH@(UX0RQ4B(*OVf
> >
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index f81f4e2469..dfb8523c8b 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1,16 +1 @@
> >  /* List of comma-separated changed AML files to ignore */
> > -"tests/data/acpi/x86/pc/DSDT",
> > -"tests/data/acpi/x86/pc/DSDT.acpierst",
> > -"tests/data/acpi/x86/pc/DSDT.acpihmat",
> > -"tests/data/acpi/x86/pc/DSDT.bridge",
> > -"tests/data/acpi/x86/pc/DSDT.cphp",
> > -"tests/data/acpi/x86/pc/DSDT.dimmpxm",
> > -"tests/data/acpi/x86/pc/DSDT.hpbridge",
> > -"tests/data/acpi/x86/pc/DSDT.hpbrroot",
> > -"tests/data/acpi/x86/pc/DSDT.ipmikcs",
> > -"tests/data/acpi/x86/pc/DSDT.memhp",
> > -"tests/data/acpi/x86/pc/DSDT.nohpet",
> > -"tests/data/acpi/x86/pc/DSDT.numamem",
> > -"tests/data/acpi/x86/pc/DSDT.roothp",
> > -"tests/data/acpi/x86/q35/DSDT.cxl",
> > -"tests/data/acpi/x86/q35/DSDT.viot",
> > --
> > 2.46.0.792.g87dc391469-goog
>


--
Ricardo Ribalda

