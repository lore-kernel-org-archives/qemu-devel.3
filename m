Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119D2C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1q-0000Ts-9J; Wed, 01 Jul 2026 06:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1m-0000Nv-HR
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:47 -0400
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1k-0004go-VS
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:46 -0400
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-139f1dfc9faso744695c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901123; x=1783505923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bTIPaD+O2axDE0WFafplpEczwJ6SStZTyPjY+DQUbwY=;
 b=pzRK9TSu16ER4Jg7qIaJish6xZdmK1IlYYa21h1Dtjx1MhcM2q1JQoBqCXn0nXeIZk
 1FvKsPD0j+nSLK6bVwZ3Jw77dtM24CwlzmYYI7424VQtwq2LUxcwnqcgWpIA9Wm0OMN/
 SkYF8YJTYnGcMtGue8+9jfMMlmv5fkYCfls7NAjmB395OBRH2JcnhtejIOWGv72CaTGu
 naSF2MYg3sxcJp++NJC+kH+DD2GQVhGRa/KLl7rLmw82nxJeh5rmpRFpLvUR3eN3KUQx
 k44CdSJ0IbwrjviIHRE5K0g1a1/xHBWNROqBKnXDYzjI0PdqIxM3JnlRV+sBkOFoSeGN
 jpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901123; x=1783505923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bTIPaD+O2axDE0WFafplpEczwJ6SStZTyPjY+DQUbwY=;
 b=jsyO6WHAEg4T8w8Z34H5G/whcl5mFv9UZtjxyX1/YhionRPBboMUGcvPKSyRV73gaF
 yNfjC5RAdqU4cwM6DrydBW87YcIHKid2AM9pLvS+N9gaoJK9TAoYm1AF+DAUranOs5zt
 9NvXKPO7W3HLgMMI5Cc/pdNKW8ZGpc1ROJ5fQHh2L3ea0bRa95tHhWnXm6QlCZOKYVht
 5/CcZ4Z8A4ONvqglKnsDiFO35YYDIkESo8Zvjjdk6l9OUNxCJygACLXLa1QG7e6vGHKz
 RmDlnBLwLnYs9QlZjw6u2c4fel81+VjjYVr+/0JymF0kFSup98dk72DllYB/STvZwCcc
 FjRQ==
X-Gm-Message-State: AOJu0YxYLlzr6JJkcZwR+8RcargqLmM7bmhxE1sDIdhGIDR024UfKqT9
 1VQ+0WESymihh1vx5vJ35mV191v4FvRTTLEnMfgOsWl7pdy0OCYmGJedgcHVVA==
X-Gm-Gg: AfdE7cnPWNx2S9dmmZD1cb6TvBPwzGqEcpN1YQUuhE66jvkL8ROWUgRVc5njMLSfAs5
 dPRNfQr/X3i8vV3QrtMnyFbUzDoXOXRAmCj1oaDXXeeJ2JenkNfe0PgDwfxDLKaZSXUVRNZ0KI/
 dFnnbHtp8Qhb4rfzan/uZYHOJ/ySkZvyYIjkKOC3d548CHVlKDSBgJw+TniSaUOItYY7tV9dITc
 okgl0+k6VnF/9EEEJtgWyhnYuMykvqlxFMs3qE+uGCNya5XlwL+grcYF6gzJGLy8NC+VuQaS0zM
 Hr7nWANsnGwRXWFmqzjt8f0OJlhtifSkPfgNfFTC/0SblAnGrenLaFi/t30/pNe/FmVJTPNbYvC
 fQ86THIFsibnEtfdeeOJr+gErP73dFLIWgZEnABXq+ROm4K3P03E+V10qwIzBDC/52RqVi/wSS2
 3e2jhpIxWb/OzUB5cgjKlUbbLQLbf1aik=
X-Received: by 2002:a05:7022:210:b0:13b:3132:6e94 with SMTP id
 a92af1059eb24-13b390eb92fmr217366c88.12.1782901123172; 
 Wed, 01 Jul 2026 03:18:43 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:42 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Qingwei Hu <qingwei.hu@bytedance.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/39] hw/intc: riscv_imsic: Skip reset for KVM irqchip
Date: Wed,  1 Jul 2026 20:17:24 +1000
Message-ID: <20260701101752.2522962-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Qingwei Hu <qingwei.hu@bytedance.com>

The emulated IMSIC state arrays are only allocated when QEMU handles
the interrupt controller state itself. With KVM AIA/APLIC-IMSIC, the
interrupt controller state is owned by the KVM in-kernel irqchip, so
these emulated state arrays are not allocated.

The IMSIC reset handler still clears those arrays unconditionally. This
makes qemu_system_reset(), which runs during machine creation,
dereference NULL pointers with -machine virt,aia=aplic-imsic and KVM.

Skip the emulated IMSIC reset path when the interrupt controller is
handled by KVM. The emulated path is unchanged for TCG and for
configurations that use QEMU emulation.

Fixes: 766391483b ("hw/intc: riscv_imsic: Add reset API to IMSIC")
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260615131925.3019370-3-qingwei.hu@bytedance.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_imsic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 1c86ecdb2c..7e5b5349ba 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -347,6 +347,10 @@ static void riscv_imsic_reset_enter(Object *obj, ResetType type)
     RISCVIMSICState *imsic = RISCV_IMSIC(obj);
     int i;
 
+    if (kvm_irqchip_in_kernel()) {
+        return;
+    }
+
     memset(imsic->eidelivery, 0, sizeof(uint32_t) * imsic->num_pages);
     memset(imsic->eithreshold, 0, sizeof(uint32_t) * imsic->num_pages);
 
-- 
2.54.0


