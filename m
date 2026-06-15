Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBDFCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ6Xm-0000W9-1c; Mon, 15 Jun 2026 08:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qingwei.hu@bytedance.com>)
 id 1wZ6Xk-0000Vq-Aq
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:35:56 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qingwei.hu@bytedance.com>)
 id 1wZ6Xh-0007dH-LP
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:35:56 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-486560db81cso2711177b6e.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 05:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1781526946; x=1782131746; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJBaTgnYBhJ/7ZxZTUrmZhgNziWSVLbeEuWoj2TvCuQ=;
 b=dOOZrAJ4u6T2cbI/J1J8FeXnFXYCoztmbNwjKWH0juOnzM7nGd8Tt/8cYRBc5fEaP7
 A1Cuh981szJFNLkr03ZcMrmdBDphxbaRNeGDVWrl4jTMVUygacINi3YbswkHvFXwnuar
 /JNkF4zPnTPtxGhrI3NJh0r5pOsLLAa01kD4LgZDyIdjFbx8rPedejnwnL823GiQ8OLX
 aeSGEwOYIZKfpjWGOWrVYSTTLmD+ZohGJ4WV0AB5rJMPyRM6er3OgFnGoCJqBNLadJ0j
 XSkVSuuRGyVUbHSClNewDViKOc9SiYuTpEVaxtwAMEPmjsnavYwoJ8tyIF6RbwWSns7c
 0hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781526946; x=1782131746;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lJBaTgnYBhJ/7ZxZTUrmZhgNziWSVLbeEuWoj2TvCuQ=;
 b=k7xl472tbYOzZc7Pj+MTBXq0gAmhBlR/TLd8XSG/kfmTlHgnNjGXuwBbTllwZ3Oe4R
 SD2TgW7ihbl80a6wcVG2KofhYEdvUDzP5Dwb72yaFEFt2jNucZigEcKzOexFCm6aH6bb
 gWLYSez3Pw9T5eKih06ziAqwd80I0YsV0vTFZ44bwAC1TDPuqZ96lfBLIcX0Hfc3mIgW
 B3PkE7JdLp08T4ymoh2yO3dggpkaZojXA3/jrRuRqu8QV9C/grH0aYPR+CqyMCZK3d2N
 Vqpf1D/s0t36GB/9oC9NPaDuj0kcbEqqZ9C4RcVt52J7mkeMC9pWOYzwfTT9bmMiovdU
 rK6w==
X-Gm-Message-State: AOJu0Yxfw2KNGpki1+QIyJ2k0Yf2wqpJ8Px94oteB55M1LRFW08rMuUn
 eg8vouMCqIU+VsLGPejsWth3bEfBzeETFN7QEiPHU6SpGj/J+SKqmyLStwtL39ucPr8=
X-Gm-Gg: Acq92OFV5FlKGWlWtvrBiWiGDir7GA05zt0f8mdXxVVID6CFT181at9DAFA40Z51NnN
 QSdl9gbqTlWeEezYFWzm2b6Q1sanRKaReEWXG/9oYt1ekpqUMnx4OQ73VdRz2f2dO7HnVyVLy3E
 KIOjsREY7xvbcjO8xVXCEal+j3c7ZcUUyBbbcI3gGMCwC9j9dsAhjTCIT+wNMz56+G11edGWbau
 lvJyq6jz3rU0hu9DBSSRzxeWgblcF+iaIcIYhkyARC+L62zTHpQChpehhZ5t8FokTC0G/i6v5Xk
 k0H5pvsY3FeUU0hSPaU7Cp4LwDUUX12bDgVTFbxi0FdeEhgC1EzJ6MXRJv835JJvtqdTnXu7iqy
 US3DVh2/aCT61gL9sfr42aI4kmZ/ihfxhfeecptn/sf5vQuYYgQwP7I1vEo+A+mct/WRNrp9jhs
 7ay2nKf7G7FzPXlCKc3drRcMibEoP6Dfoh7Lo=
X-Received: by 2002:a05:6808:4fc9:b0:486:79ad:96e9 with SMTP id
 5614622812f47-4872f580f5fmr8987808b6e.37.1781526946210; 
 Mon, 15 Jun 2026 05:35:46 -0700 (PDT)
Received: from smtpclient.apple ([240e:694:e20:401::4])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4875df7fc36sm2569297b6e.9.2026.06.15.05.35.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2026 05:35:45 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [External] [PATCH] hw/intc: riscv_aia: Skip reset for KVM irqchip
From: Qingwei Hu <qingwei.hu@bytedance.com>
In-Reply-To: <SE3PR04MB89223BFA19CAED63F7C799EFF31B2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 15 Jun 2026 20:35:21 +0800
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, jim.shu@sifive.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3284CAB2-000E-468C-A565-7F28F145C032@bytedance.com>
References: <20260605110621.644997-1-qingwei.hu@bytedance.com>
 <SE3PR04MB89223BFA19CAED63F7C799EFF31B2@SE3PR04MB8922.apcprd04.prod.outlook.com>
To: "Nutty.Liu" <nutty.liu@hotmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=qingwei.hu@bytedance.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


> On Jun 11, 2026, at 18:06, Nutty.Liu <nutty.liu@hotmail.com> wrote:
>=20
>=20
> On 6/5/2026 7:06 PM, Qingwei Hu wrote:
>> The emulated APLIC and IMSIC state arrays are only allocated when =
QEMU
>> handles the interrupt controller state itself. With KVM =
AIA/APLIC-IMSIC,
>> the interrupt controller state is owned by the KVM in-kernel irqchip, =
so
>> these emulated state arrays are not allocated.
>>=20
>> The reset handlers added for APLIC and IMSIC still clear those arrays
>> unconditionally. This makes qemu_system_reset(), which runs during =
machine
>> creation, dereference NULL pointers with -machine =
virt,aia=3Daplic-imsic and
>> KVM.
>>=20
>> Skip the emulated APLIC and IMSIC reset paths when the interrupt =
controller
>> is handled by KVM. The emulated paths are unchanged for TCG and for
>> configurations that use QEMU emulation.
>>=20
>> Fixes: 99bfcd329a ("hw/intc: riscv_aplic: Add reset API to APLIC")
>> Fixes: 766391483b ("hw/intc: riscv_imsic: Add reset API to IMSIC")
>> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
> It would be better to split it into two fix patches.
> Otherwise,
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
>=20
> Thanks,
> Nutty

Hi Nutty,

Thanks for the review. I will split this into two patches and send a v2.

Best regards,
Qingwei

>> ---
>>  hw/intc/riscv_aplic.c | 4 ++++
>>  hw/intc/riscv_imsic.c | 4 ++++
>>  2 files changed, 8 insertions(+)
>>=20
>> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
>> index c2c67c29e6..84606e9f3d 100644
>> --- a/hw/intc/riscv_aplic.c
>> +++ b/hw/intc/riscv_aplic.c
>> @@ -910,6 +910,10 @@ static void riscv_aplic_reset_enter(Object *obj, =
ResetType type)
>>      RISCVAPLICState *aplic =3D RISCV_APLIC(obj);
>>      int i;
>>  +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
>> +        return;
>> +    }
>> +
>>      aplic->domaincfg =3D 0;
>>      memset(aplic->sourcecfg, 0, sizeof(uint32_t) * aplic->num_irqs);
>>      memset(aplic->target, 0, sizeof(uint32_t) * aplic->num_irqs);
>> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
>> index ac59496c22..f1f23c3a3e 100644
>> --- a/hw/intc/riscv_imsic.c
>> +++ b/hw/intc/riscv_imsic.c
>> @@ -347,6 +347,10 @@ static void riscv_imsic_reset_enter(Object *obj, =
ResetType type)
>>      RISCVIMSICState *imsic =3D RISCV_IMSIC(obj);
>>      int i;
>>  +    if (kvm_irqchip_in_kernel()) {
>> +        return;
>> +    }
>> +
>>      memset(imsic->eidelivery, 0, sizeof(uint32_t) * =
imsic->num_pages);
>>      memset(imsic->eithreshold, 0, sizeof(uint32_t) * =
imsic->num_pages);



