Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A3CC021B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 08:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmTlx-0000Qx-Fb; Mon, 24 Feb 2025 03:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTlu-0000PO-ER
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:25:02 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTlr-0001Dk-9m
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:25:01 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2211acda7f6so88002455ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 00:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740385498; x=1740990298; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Avllbujkgt9jGISnFqk3eNbI7THZ3CoG/MVM08xKPXc=;
 b=W8fv9PZzCqws9eozHowe8oihEfIJQ6AXG5qmSOekS71HcoUEzdsrncpiENaPzqXJKB
 2+t1BZzPT82Ta1V6ZsZBPl3CdbGR5+ER/nIlfUQjYcqqFf9jTiXP+Bbo3jGb2rZi1oxe
 KZMXe63JbS9TBydeA9lXlH5199SvL9ued00R1B7Gw72zJh+JO7y5i8uxD/oEkLTbauLG
 nJPXSWuN/IsOBK1DJbRdQpiuSRIShYN7cDHKkCuSbhUjMkHYHltXG+xh3huMmRzIZtPu
 y2RPr5QohXmG8OvahCpLCDibZmbEjD4Ow5Kmoiah3npWsNTTNzPhmRfDtNu1C/J86JYT
 DF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740385498; x=1740990298;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Avllbujkgt9jGISnFqk3eNbI7THZ3CoG/MVM08xKPXc=;
 b=F7U/e7pR0cMIY9+1LllwgRj3BwHvHJOhOMH+YVhqN04VUOAo2XelriJfDBOqNF6Tc/
 5Yx1yK26mIJsokqbhy42Y1cr4g6saCIRf313BH7dhKiSEre2kaOQ/yVtlIr0bflVB8a7
 undDl6VJZI0SDiGexxZ4Cx0Q2t9bYGvd0VuZfXq0CWKO+AxSN2yKREaGiuDbH14QTT96
 jQVDQe42PrGsl1Cz158nQns8s+pXbKFc574LBtKLqLapQ+t2QA41wpfbWECx2AZ8sy/m
 H7NMCV+EmJSmR/9l26eb6k2F3jpPsK9mrvafBDiAPdRZXzYYTWaytCkiC+BBm0RGhKGP
 8a0Q==
X-Gm-Message-State: AOJu0YyX8gA+tMvWlqgDzexP+VNmckKJXLdfvT9XDbGq3GKgGTlVDJ11
 hmzWsoS7iEXLgAZRImAtau7BYmEW72YHMNN+EarsAInj9jU+HhIgZbQkEqzQf59OKMC/EI8Of00
 Vt95o8pGB47sVGHZwY6mZrFd4rLZfswMZEvom0Pyr/647ry+R3MMcwUqaEIYoRVY+BmsQ66L3XZ
 rEMNue1GEhWhoB7gpQhCxPPAUtsbHLme2sMUc+Ya9/pQ==
X-Gm-Gg: ASbGnctWGtUKaJS4LzLOUnHwIHBIaO+6WzjTjENKPAjSr8SCEg7+DvXUv8cSUPzOH2b
 1wk4qLOcA7LPjFNGyLnszo9Ze6Et+J8oH/qZ++Ujjw1gpQTVahLkmBvseUNWI8tYLdnSCNBwBFw
 Ulun6KiBkrmvzBSg1JLEYgoJM0hFxkhtPYofy4ynxZODS5eqsgkn7VE5OGJZT/MoBbCN5HK7dZ0
 6OQFZbnpn3yty1Tx0v4+CNyqAntaKgjRV9IMx6Rqj5+fBwcaaoJd8LXi/fN4sSnv+IjccJt69rr
 trdW6WIEJyU5hL16Uogze9yUGw50N7gE7L4OfL6OKBoA9nZHj7QeixOj
X-Google-Smtp-Source: AGHT+IHXVNbKiuaZi5hJilq5rfYkqfKJ1saB7u7EBGsYNKFH9pNciLVoY4TdM/LgkpwmuBmpcrzx9Q==
X-Received: by 2002:a05:6a00:2e87:b0:732:2269:a15c with SMTP id
 d2e1a72fcca58-73426d8f207mr18199720b3a.20.1740385497562; 
 Mon, 24 Feb 2025 00:24:57 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7325c88d74esm17714914b3a.149.2025.02.24.00.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 00:24:57 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 7/8] docs: update the description about RISC-V AIA
Date: Mon, 24 Feb 2025 16:24:14 +0800
Message-Id: <20250224082417.31382-8-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250224082417.31382-1-yongxuan.wang@sifive.com>
References: <20250224082417.31382-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add the description about "-accel kvm,kernel-irqchip=off" into
docs/specs/riscv-aia.rst and docs/system/riscv/virt.rst.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 docs/specs/riscv-aia.rst   | 24 ++++++++++++++++++------
 docs/system/riscv/virt.rst | 10 ++++++----
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/docs/specs/riscv-aia.rst b/docs/specs/riscv-aia.rst
index 8097e2f89744..38797cca4998 100644
--- a/docs/specs/riscv-aia.rst
+++ b/docs/specs/riscv-aia.rst
@@ -25,11 +25,16 @@ When running KVM:
 - no m-mode is provided, so there is no m-mode APLIC or IMSIC emulation regardless of
   the AIA mode chosen
 - with "aia=aplic", s-mode APLIC will be emulated by userspace
-- with "aia=aplic-imsic" there are two possibilities.  If no additional KVM option
-  is provided there will be no APLIC or IMSIC emulation in userspace, and the virtual
-  machine will use the provided in-kernel APLIC and IMSIC controllers.  If the user
-  chooses to use the irqchip in split mode via "-accel kvm,kernel-irqchip=split",
-  s-mode APLIC will be emulated while using the s-mode IMSIC from the irqchip
+- with "aia=aplic-imsic" there are three possibilities.
+    - If no additional KVM option is provided there will be no APLIC or IMSIC emulation
+      in userspace, and the virtual machine will use the provided in-kernel APLIC and
+      IMSIC controllers.
+    - If the user chooses to use the irqchip in split mode via
+      "-accel kvm,kernel-irqchip=split", s-mode APLIC will be emulated while using
+      the s-mode IMSIC from the irqchip.
+    - If the user disables the in-kernel irqchip via "-accel kvm,kernel-irqchip=off",
+      both s-mode APLIC and IMSIC controller will be emulated.
+
 
 The following table summarizes how the AIA and accelerator options defines what
 we will emulate in userspace:
@@ -75,9 +80,16 @@ we will emulate in userspace:
      - in-kernel
      - in-kernel
    * - kvm
-     - irqchip=split
+     - kernel-irqchip=split
      - aplic-imsic
      - n/a
      - n/a
      - emul
      - in-kernel
+   * - kvm
+     - kernel-irqchip=off
+     - aplic-imsic
+     - n/a
+     - n/a
+     - emul
+     - emul
diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 60850970ce83..96d7ee1ebc64 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -129,12 +129,14 @@ The following machine-specific options are supported:
   MSIs. When not specified, this option is assumed to be "none" which selects
   SiFive PLIC to handle wired interrupts.
 
-  This option also interacts with '-accel kvm'.  When using "aia=aplic-imsic"
-  with KVM, it is possible to set the use of the kernel irqchip in split mode
+  This option also interacts with '-accel kvm', when using "aia=aplic-imsic"
+  with KVM.  It is possible to set the use of the kernel irqchip in split mode
   by using "-accel kvm,kernel-irqchip=split".  In this case the ``virt`` machine
   will emulate the APLIC controller instead of using the APLIC controller from
-  the irqchip.  See :ref:`riscv-aia` for more details on all available AIA
-  modes.
+  the in-kernel irqchip. Or the kernel irqchip can be disabled by using
+  "-accel kvm,kernel-irqchip=off". In this case the ``virt`` machine will
+  emulate the APLIC and IMSIC controller in user-space instead of using in-kernel
+  irqchip.  See :ref:`riscv-aia` for more details on all available AIA modes.
 
 - aia-guests=nnn
 
-- 
2.17.1


