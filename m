Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAFFCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3sbQ-0000ht-AM; Wed, 01 Oct 2025 04:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1v3sbO-0000hQ-NP
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:54:22 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1v3sb9-0004dj-Mc
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:54:22 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b3da3b34950so600944366b.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1759308844; x=1759913644; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Zh10HA3jd3BGFgUDTi6jZ+9AfEQlb5Kz3AUdlvCQRc=;
 b=eiIl+rco0kyIgKA3VmALGk7KsfCXPL1dT75oMrjtjHEyssPj6mVWCVTGbmntmWxd0y
 HKw/gbcAXhNoy37jlJmQWhsZ0FbS36x3lQCWzrBdQZJJ74bZSG1/4HCwJRU8ru1/Dtf3
 HaEn6TK17pCuQZWGZz7IT2VwjtA8TtEEMhFju49aF7PYpvqS3ZH1fgDV8/hvKkVmAR2D
 9uP1phliu4by3hreJK2sHGifwTDaNprNBSyvjslS6Rcnre6qE8r8OvatpMZn83jBuydy
 9/QlCHRDy/vKfe0gMlty4tDoi9cFpLY+v0V3PDUUy5lTKY2qPtwyw1my37MP9JobFtBT
 7FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759308844; x=1759913644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Zh10HA3jd3BGFgUDTi6jZ+9AfEQlb5Kz3AUdlvCQRc=;
 b=H9joNWZ8dWqGC7/2WcRAJZokAqo30gtDtMZifjosMpdIOZ+LkeJnaYKf4xQuu6w/qT
 Q0RYueql1AnuxIQRt4CuZFqAiz1Jv72hE/p/en0DpzHO/MT/bVsyb6ynDDIFQg+9TC+Z
 gTk1/TxZWYMCEtlRRI5GMlXA4DY54Y8YNFIC5nrX2VSPS21BufegwbvQW0b5J9VUSV1Q
 ZXjZ4Vr3C4yvY26uonaoQ9D//cXyoExqSL8CfgGxkVJIAKg3rrEcNGSXIrcCX8td+vF/
 rOY5v5nJfE01EMxhp+O1ZzzFQPrd1Pm1a7/2BpF+frJAEMv3bYY9I+q0BB63P5x1ft21
 9M5A==
X-Gm-Message-State: AOJu0YyGwkw6uUKxIhHeg41E6qHc+GPMooRdsdoHKtlfSHEXtdfs7/b9
 1Y6qjaJJtMd/eq7znIS3X0mfMNpn6h3uUUzMtujDHFzCXwSGwiVQ6dpa/Q8coggf/uVRb5TAALN
 oOzfnqdeQzRqr/JUKeJpiGqAGDxKMxTUunaB90rwjdtJlLYY0NEfWuQ==
X-Gm-Gg: ASbGncs9DY1VEqaNIqcK7umM+TZBfxQmrz+188sZYV0cURU43YwPy6839XwktrOiSxv
 6lFk6eZ68eSgqvxIUI6Kqz/LGjNTp/hMsjz1wJfzEnAOSwdj8QzniCrFEpALL2+z1eYOTjgIHP0
 y33MiIuEStbqd7kxDpVKdECU54/30rPhn9r3jXia1ogOJzuq4VUW8G84XpM1ZpCMbu2h/vFGoww
 4zF3DkeX+KIyZq61hdeHuliObMghh0=
X-Google-Smtp-Source: AGHT+IGFBL4zsWyLpF3k8R2ybT951kwllSJWAlf6Wa5RkOI4YUsgHRU35nq9BYGkQ3ol1Txmlhe6CaigrXG4TyqjyJs=
X-Received: by 2002:a17:907:da1:b0:b2d:9286:506d with SMTP id
 a640c23a62f3a-b46e612bed0mr345459066b.38.1759308843815; Wed, 01 Oct 2025
 01:54:03 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 1 Oct 2025 10:53:53 +0200
X-Gm-Features: AS18NWAc5OXjaU_6ylbXYWtac8HygHEdbA7wCtqpIDFk3fZIL5YU3laO9cBeKWk
Message-ID: <CAJ307Eg67ri0=-ocEr-q=Y9+OY-9XKGFb5AYh59-X8szH+3Ryg@mail.gmail.com>
Subject: [QUESTION] aarch64=off with TCG
To: qemu-arm@nongnu.org
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi,

I'm wondering if the check [1] preventing "aarch64=3Doff" without KMV is
still valid nowadays and if yes, if anyone has ideas about what are
the remaining blockers ?

For the record, I was able to boot the Fedora kernel coming for our
function/arm/test_virt on cortex-a53, after having removed that check.
  | qemu-system-aarch64 -cpu cortex-a53,aarch64=3Doff -M virt -kernel vmlin=
uz \
    -append "printk.time=3D0 console=3DttyAMA0" -nographic
  | Booting Linux on physical CPU 0x0
  | Linux version 4.18.16-300.fc29.armv7hl
(mockbuild@buildvm-armv7-06.arm.fedoraproject.org)      (gcc version
8.2.1 20180801 (Red Hat 8.2.1-2) (GCC)) #1 SMP Sun Oct 21 00:56:28 UTC
2018
  | CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7), cr=3D10c5387d
   ...

[1] https://gitlab.com/qemu-project/qemu/-/blob/master/target/arm/cpu.c?ref=
_type=3Dheads#L1213
  | static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **er=
rp)
  | {
  |  [...]
  |         if (!kvm_enabled() || !kvm_arm_aarch32_supported()) {
  |             error_setg(errp, "'aarch64' feature cannot be disabled "
  |                              "unless KVM is enabled and 32-bit EL1 "
  |                              "is supported");
  |             return;
  |         }

Thanks,
Cl=C3=A9ment

