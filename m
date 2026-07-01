Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2418C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1o-0000Oe-RA; Wed, 01 Jul 2026 06:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1k-0000ND-Nn
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:45 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1j-0004gc-7x
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:44 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-13b2d7dc8d1so389188c88.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901120; x=1783505920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCxXyJGnPgrLKzxNFm2z8guBWfArySRohcHx9XVJ4g0=;
 b=SpkiWCkkL6G0wGMhL5EMo/DEv9s3L7s1z5KSDIJtoYbtotdg2nlFrg/WEub7QnUky4
 36uqGhqp8Xz3JHL1qWvwv7rfVxO/Zdv1ZkRbzrYleMfXX3+yuZODjyVrE4/zIwaKEuvJ
 bRcMh5U113BS5jUZgqFYTIsqhvejlGzIZtMWYWgKd29s1XO6sjanMAfrL9iVSbN3kC6O
 hIAonSCCn/0FQwYncPVbOa9uUbkl471MjvWh5VXwOYcxqOhwkEhNoBDsSeOrht6dGYOh
 nPzm+R12LUO0R4W4lP7w2la/rbcakgPNHeAjYlhYXc9F7kfSyW4bXZOLesRUacQGnFcL
 92Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901120; x=1783505920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vCxXyJGnPgrLKzxNFm2z8guBWfArySRohcHx9XVJ4g0=;
 b=Vx3mBpuWRe+cfbsH72I1IjUSPHrIkAsIoQqjUrVfIH1DmmznRikEyf2CgiA0yut1HQ
 TINEX+UTGqlf7ZFwbep/O2Ze/Lm1cXZe42KXK1TEw2w4D6obp5e+XP/lR5/3DhUPUzBn
 DIShZtwJm1eQNQPPVVei+HdFC/QkXaQYExlsjX9PFsHtn7JK3bGaJGNWf9iJvaaPJjA3
 pvJ0PFB9F/d+VeCHuAM0em89e0hOvpEhcEmef5BTouaP/qVTF1oeJ7JH1K4rHkIZxGnJ
 WN+aLIUew+Z8pAXz+bCDGaTX9z3szemF63TW8fsBes1UGFRGi8l/vyAr6Puq9HbZ67/W
 Zdag==
X-Gm-Message-State: AOJu0YyDK02JCT5YKiUbl0ir6Stintq4i4Imj45c3xCwtGq6o+ebj85g
 1oeNezs0c3yXFlF4ynlRbPNLdmCuG33M5HSARpMpmlLxzmvz65wucpOxM+EczQ==
X-Gm-Gg: AfdE7cn/jJDak3n9JWu8rvCAFWsGr5xqIpQ+z4mCOG35o6T7mFpukYnKfRob6xZTo4v
 f9TqzQR+7gPv77HEsxR+rACYhwgxVJlK0Y5erKMxnQ2eulteCdYRHdPfuKeBs/Kq9PKnsg7Wsp8
 z/EhdM8ZvMnOiHkINfSQwGVCjtpZbQC51QHkrR0wIHOTAm+DwMTKw4+i8GEz834EdMZ21f8ikDK
 amFxkRjnugLx9Ie5RoWjtZ1skYUVWr2UOB755ePHNafQT+85iAhQ9B/xucFqga2/MWcvSohQ/XV
 jD7nKs8CrvnFF+ni1ArNL4zJLOm12xzMkOkj53r4B/TNW7AZGJHn0TahGIeEFjA9I16wh5yljv4
 2YeKEPOxvWfrNq+7Tzl0w+3ZYL1l2IgitAVaQSeIT5sISSh9WauQ8qn1VAepbcL1NV0XPgFIGO1
 6G48o/JjIqD6i/taA4KuSpUtrX/yaKIac=
X-Received: by 2002:a05:7022:ec3:b0:139:afa6:fce4 with SMTP id
 a92af1059eb24-13b36d6f151mr940267c88.12.1782901120068; 
 Wed, 01 Jul 2026 03:18:40 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:39 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Qingwei Hu <qingwei.hu@bytedance.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/39] hw/intc: riscv_aplic: Skip reset for KVM irqchip
Date: Wed,  1 Jul 2026 20:17:23 +1000
Message-ID: <20260701101752.2522962-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122c.google.com
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

The emulated APLIC state arrays are only allocated when QEMU handles
the interrupt controller state itself. With KVM AIA/APLIC-IMSIC, the
interrupt controller state is owned by the KVM in-kernel irqchip, so
these emulated state arrays are not allocated.

The APLIC reset handler still clears those arrays unconditionally. This
makes qemu_system_reset(), which runs during machine creation,
dereference NULL pointers with -machine virt,aia=aplic-imsic and KVM.

Skip the emulated APLIC reset path when the interrupt controller is
handled by KVM. The emulated path is unchanged for TCG and for
configurations that use QEMU emulation.

Fixes: 99bfcd329a ("hw/intc: riscv_aplic: Add reset API to APLIC")
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260615131925.3019370-2-qingwei.hu@bytedance.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index c2c67c29e6..84606e9f3d 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -910,6 +910,10 @@ static void riscv_aplic_reset_enter(Object *obj, ResetType type)
     RISCVAPLICState *aplic = RISCV_APLIC(obj);
     int i;
 
+    if (!riscv_use_emulated_aplic(aplic->msimode)) {
+        return;
+    }
+
     aplic->domaincfg = 0;
     memset(aplic->sourcecfg, 0, sizeof(uint32_t) * aplic->num_irqs);
     memset(aplic->target, 0, sizeof(uint32_t) * aplic->num_irqs);
-- 
2.54.0


