Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0D9C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 13:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH0U0-0007a3-Lm; Mon, 19 May 2025 09:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bibo.mao@gmail.com>)
 id 1uH0Tz-0007Zq-Eg
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:24:43 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bibo.mao@gmail.com>)
 id 1uH0Tx-0005an-RP
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:24:43 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-86d5e3ddb66so1048503241.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747661079; x=1748265879; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94wdVv2DdU4Ltt4xoqCKmh8KKDnd6QUL8D/s8mEqdwA=;
 b=mGpFkuHk2WGHDepLZiZ5s2RBlffMOhoLUHkANKsVuklLcsn31ZHVlRNpI2hK+I+MrP
 UEpRf4Mq5/T3qDHSYiRhCzOlblRZeyD4+ju+Hh6wUxacyd9zz4dP1f3vGB5qxUb9+oLg
 YA6r6PMMXUD+3oevjkV6zIKdxE/UJF+2/ux52ymJqwnYM/K6PfyfbgKgAQ0lsdEdTUIG
 V1iOsde71zSvZPLp0n50v9fjn8gFDOUHodFYtdcTV4BZxa7jNKIau5Vg5n4kIezevmfX
 QR2V/stu6ZwAIJo8FzA35b69pd5E5VDvz7omWSVFSMNRGVmGRRy/+90OnCKA8XfMj1BA
 6IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747661079; x=1748265879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94wdVv2DdU4Ltt4xoqCKmh8KKDnd6QUL8D/s8mEqdwA=;
 b=dlYICYpR2pSRF1RBBsQWZIOoakmDyaCSU7r0G1zgP/SFxUJQWyWpL+c7JCSdmNNAbZ
 YkTZavSy08UU5sYXpTOoQIm8TX2+PoVToBhUVmYL/vEliZ6Seblv/ojSzcKp1tRsV4wR
 0GcozRWEBNBV7lnLAwYG9+2nAvAW6K8tShddVkKikcbSVgKyHUAbpy5TFaYrdZ0f91K8
 bbn8H7AFAP+z2JTI/VsxwQLCcK6CvaEH74IQHg9WsHVh3smm38a+nSI7gDncamD/nEdf
 DXgfKYaZBj80tAv7cweH89VDGraGpZsxsPp/mSgI8Vv5gRqQXIYuzrZ60X8wI3mC0i5X
 D0tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQdu3SKfLrHketsowIRgBEppcwpVGXZGknlFrrMTBu790fG43V1hgVTmLtfTBgn84Skfz2NhTnnaCL@nongnu.org
X-Gm-Message-State: AOJu0YypBsSrQIGorrKlVqnEHkzEdi3flbn3c7sZCPvpxA35e7L2qbeU
 PkUp7PxIBGy63JukrjT0tJK3xYDWF5r3uGsqiuil2w7FaekGnuRf1x6ewaVWBUSCxzEUfrNQx2+
 EQJWlQXyLFQTM+tieCyuZJtEa6GUvB6Y=
X-Gm-Gg: ASbGncsl8/PmBcvhjiDqRkVgbbRsfBZpAl5r/TrU+siCwnCL5KQ+qcI7cCna8X31v7l
 egK9svGZRlfzXyxokOiCU+Kt6hCuGn5MMp7s/vGANSPHL7E7tNdWJ0cU0wDNzNO1D11mtoT+QUz
 bNeJrk3rTbVsoYFMTgZHqy3vO9SaiES5Nb2w==
X-Google-Smtp-Source: AGHT+IEtslOsGNtgTKi2WiLQVcnFbnvdkn7njYiEIy+Bi8MRS7VWCOzLSZD+wiv7X9zLGyqV27mt4o4jpdJaIQtq6gI=
X-Received: by 2002:a05:6102:3e1d:b0:4c5:1c2e:79f5 with SMTP id
 ada2fe7eead31-4dfa6bfcc7amr11405184137.16.1747661078868; Mon, 19 May 2025
 06:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250509100747.1070094-1-maobibo@loongson.cn>
 <20250509100747.1070094-4-maobibo@loongson.cn>
 <5fa02121-43f6-4335-883e-efe07a2f3711@app.fastmail.com>
 <391ab7d0-9e61-1b9d-fbd3-98dd23f2d2a7@loongson.cn>
 <671157ca-de54-4053-93a9-8ea7f3fa1f1f@app.fastmail.com>
 <0e4690a6-1f28-f97c-a7dc-3b7888d23f38@loongson.cn>
 <930362d4-695a-44e6-a220-898e265a944c@app.fastmail.com>
 <1422bdc1-9251-b88e-44fd-e953ee88d0bd@loongson.cn>
 <73bd3e6c-78b0-4378-b391-8f20beac2079@app.fastmail.com>
In-Reply-To: <73bd3e6c-78b0-4378-b391-8f20beac2079@app.fastmail.com>
From: bibo mao <bibo.mao@gmail.com>
Date: Mon, 19 May 2025 21:24:28 +0800
X-Gm-Features: AX0GCFsTI1MheZXSRQcaNu0YMmmT9zHLViNrnUgObu3W0ZYVt8Qbd2jPJDgKA9k
Message-ID: <CAPpFdZ0NMe56bZMj=akJNaFJEjBpx4W_3Uyzr=6j-3moDWOaDw@mail.gmail.com>
Subject: Re: [PATCH 03/15] hw/intc/loongarch_extioi: Add irqchip-in-kernel
 save/restore function
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, QEMU devel <qemu-devel@nongnu.org>, 
 Xianglai Li <lixianglai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=bibo.mao@gmail.com; helo=mail-ua1-x92d.google.com
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

Jiaxun Yang <jiaxun.yang@flygoat.com> =E4=BA=8E2025=E5=B9=B45=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=B8=80 17:17=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> =E5=9C=A82025=E5=B9=B45=E6=9C=8819=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=
=E5=8D=889:55=EF=BC=8CBibo Mao=E5=86=99=E9=81=93=EF=BC=9A
> [...]
> >> It's actually different machine as kernel irqchip is never on par with=
 usermode
> >> emulation. This approach is taken by i386 (TYPE_KVM_IOAPIC vs TYPE_IOA=
PIC),
> >> Arm (TYPE_KVM_ARM_ITS vs TYPE_ARM_GICV3_ITS), PowerPC (TYPE_KVM_OPENPI=
C vs
> >> TYPE_OPENPIC) and I see no reason that LoongArch should not follow.
> > So what is the advantage and disadvantage from yourself understanding h=
ere?
>
> I think I made myself pretty clear in previous replies, in case you misse=
d that.
>
> The advantage is clean design, clean interface, clean vmstates (user spac=
e emulation
> tends to have more states vs in-kernel irqchip), proper signalling to use=
r that
> migration between user-space/in-kernel irqchip is not feasible, perhaps s=
ome performance
> advantage on reducing number of user space IOCSR ranges, reducing attack =
surface
> exposed by userspace emulation, reducing the chance of hypervisor error b=
eing covered
> up by userspace fallback....
>
> I don't think there is any disadvantage. I don't really buy the "differen=
t machine"
> justification you made. Paravirt solution tends to have its own behaviour=
 and I don't
> think it's a bad thing to expose it to users.
irqchip-in-kernel is some kind of optimization, register layout and
function is the same whatever it is
emulated in kernel or user mode.

The same for cpu type, do you think that cpu type la464 should be
named as la464-kvm in
KVM mode? Or you do not care about name at all=EF=BC=9F

Regards
Bibo Mao

>
> Thanks
> --
> - Jiaxun
>

