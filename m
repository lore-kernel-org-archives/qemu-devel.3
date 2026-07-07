Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7078BC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1gb-0001qC-8b; Tue, 07 Jul 2026 05:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1wh1gV-0001pT-4e
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:01:48 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1wh1gT-0000yX-MT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:01:42 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3856d4015e0so216511a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783414900; x=1784019700; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SqmLeXWTI5g71Nu13EonIZN9PnB5FcQGBUyd1AmQZoY=;
 b=jhvka1PxRwQJsTbuXmOtj9vhkX2ByIFKFUHVIBgF4DIJRkAEscts+5beDww/h/T+A/
 W1S+93DWSe75sm9N5Bcfd0DIY7jXfkgDh9ITou469GrqtBi978OYCRtK29/M9Y1KfJLm
 raBFXWvjtR/9hG+riI0tpLkp9ExHdqIuxFmDc06Kdwhd+z0xS+RZkuTcaK9h61tPSovD
 gB6IAEmeuaFG8+GwGEV+n/f4YfvJWE9gfAQ3GUbo69LqocDpjOlJBiICusR/GyXHq55+
 hYy+y/olOBYPEP1j757ox/LWGXpX8QBlvutEMFdAFtzN9Mok2E0bPTB7jcTG9aO2CZiP
 wFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783414900; x=1784019700;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SqmLeXWTI5g71Nu13EonIZN9PnB5FcQGBUyd1AmQZoY=;
 b=GKhvBIrtvGaC3iyWSvgA3Bw3f8rgK+7mN1502FoerBgKYAvmZTph0KzbQnztNiMFnJ
 hVrkINxWLDtCc9zEf/bivNCMDV8G2bNLOXUFjo0d7Nu5pkjgPJ4DeaWCA5vcki3lkmDW
 bCTQKCJebmCh/QawoduXKx4nCwtA4jq3q5u9bwBRYS+zmrJYdZ9KUR1NeqDajUHrYddA
 bIuUhWvfJfu1JIgDXZBsWb7UnYfbw+2DeqiUwVGhptp9RfU/+bbO0g3x8KSBDpj544vt
 VaqVMuWVWoI6Gw4Or8dm3dYATRSvSvfTanmBuntmGPzz35BLOpH+mX61Wia6sbdvCmgR
 CwIA==
X-Gm-Message-State: AOJu0YxjDA/hEjVC2ZHad7P9NpSKQOmGCW4buT2BeflYxSmDUYNjWzYj
 i8oK4ZRzeETZZ0MRHv8+vzImTcFvvRVvQ+sJLSaRtju4lg+fRlj6UlOw
X-Gm-Gg: AfdE7cmEh4MKOo3Zwy3y1Nhsa/SoZJDwz45AGITJhn9tD5GrqmN727eSDgFVLnILRMB
 86OZTWJRoSi4Bv9tNAY7Zy/o+v128NVK+u0mdscSKsg7awEa/F0sSkT/A+XYs2HRZ5/gW+14nIh
 2x9yMSbhP9IGrjycN/GOfJqe1sjqV6z3x/EqnFu2oSCHeZxL+T9x9X4ViTWQ/boTRoI/JvHrfBc
 GV4ZdRZzrHEiIkh0ITLd6SmqtZsvsidsNybgjPHW/0Fpq3rV/3z2bYUUidIaIcYOEgBpbBFzwrA
 HZVvs7PjgTwqqMq1pOq0cO/JP5dYtCQbU4Fg2wwhsXA+hz/Nheban7/qG1zVzUAgxw1nCKSoXbv
 G54L4zTDoxO761/w1KYGLgZvlUAqh44j05ptUgyGbNsflEiO9BL2ad4IM1qL0BxbATb62cpKDyv
 D+SUCmDShwfYLzefTwPTqm/Evy8oSeniRVRPk=
X-Received: by 2002:a17:90b:3c10:b0:381:96a2:14d8 with SMTP id
 98e67ed59e1d1-382a08b0ce7mr9653476a91.8.1783414898137; 
 Tue, 07 Jul 2026 02:01:38 -0700 (PDT)
Received: from smtpclient.apple ([23.247.139.92])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-387d12fcd99sm736786a91.2.2026.07.07.02.01.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:01:37 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] qemu-options: Enable the -enable-kvm option for loongarch
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <2d2e2609-ff6d-448d-9a78-9e9b6b9a9ec2@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 17:01:22 +0800
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B737D5FB-43B3-478D-BD78-E5A2A8296B6A@gmail.com>
References: <20260705-add-loong64-kvm-v1-1-aa8b85ecfa32@gmail.com>
 <2d2e2609-ff6d-448d-9a78-9e9b6b9a9ec2@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=shankerwangmiao@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

> 2026=E5=B9=B47=E6=9C=887=E6=97=A5 16:57=EF=BC=8CPhilippe =
Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi,
>=20
> On 4/7/26 21:50, Miao Wang via B4 Relay wrote:
>> From: Miao Wang <shankerwangmiao@gmail.com>
>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>> ---
>>  qemu-options.hx | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index =
e44b47de68137120da9979fb081d0c108f13179c..c7dbbd01e73367380fcf653fa8d0d187=
95dde9a7 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -5164,7 +5164,7 @@ ERST
>>  DEF("enable-kvm", 0, QEMU_OPTION_enable_kvm, \
>>      "-enable-kvm     enable KVM full virtualization support\n",
>>      QEMU_ARCH_ARM | QEMU_ARCH_I386 | QEMU_ARCH_MIPS | QEMU_ARCH_PPC =
|
>> -    QEMU_ARCH_RISCV | QEMU_ARCH_S390X)
>> +    QEMU_ARCH_RISCV | QEMU_ARCH_S390X | QEMU_ARCH_LOONGARCH)
>>  SRST
>>  ``-enable-kvm``
>>      Enable KVM full virtualization support. This option is only
>=20
> Isn't the legacy option for "-accel kvm"? (Apparently since commit
> 303d4e865b7 which is from September 2010). Maybe we should get rid
> of the '-enable-kvm' use in examples / scripts...


Yes, but I noticed that there are still users of it. I believe that
either we can fully remove this option or we should enable this
option for every architecture for which kvm is actually supported.

Cheers,

Miao Wang


