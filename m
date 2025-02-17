Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6600AC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwL6-0002d2-Fx; Mon, 17 Feb 2025 03:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwL2-0002Xc-Si
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:18:49 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwKw-00014N-Gp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:18:46 -0500
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6dcdf23b4edso36914666d6.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1739780321; x=1740385121; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Avllbujkgt9jGISnFqk3eNbI7THZ3CoG/MVM08xKPXc=;
 b=HjCpZeTZu/x/rZ84zPwHL4UHRcyOpSCQGb2OkG1Qns7zmxmiMfaen4Xx7ohQhUmhyw
 eKqe9kgcAL2JZ5h9Aw7ixRQv0QVCgt2Wpb1C+HYLToRc43TzIFGyfZoonq7qTgo6gzmw
 S/xhhx+SlTFmssKrJdno85YaF43FpZOqy6giY1OlNcCghFsF0gi877ep0IYvhYFKe/n0
 gaAcyE17Bayp0h/Ak9D4A6ENPgX5yumG0VQCYbNSKJf6CL218isEE80Oj8sLR+pTcrq9
 brJadFPcxIEG3GyxZlB8sLnCq2N6MhZYHdG8fZOBqHiFC2c2/mIZbGKOOpVeVVdiL4Pa
 JK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780321; x=1740385121;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Avllbujkgt9jGISnFqk3eNbI7THZ3CoG/MVM08xKPXc=;
 b=SwoKjdzyiLu/C8WqWiE9SCPF23vs/lngtBPMu3IrdhhJnLtd3bZJ9yExxVzRjhK6rG
 iOOHDTVTmxqj0ZqgHy1AX7e01SzaBiUtUQd4T5NFu9s8Qu7NgXAChTNMLow4OAjhi+hC
 Nekp8e5PpoulkW/kxwkYrSXnatgMZ8Zj8/aYVZe+zzFzgQxvjICqQvUWAOGrFzCPJX10
 iol3Lvt1/mQFwxPdgDZFLhc6o3zpZwXCaJMgKGO/vyPT39kjchJltgDcEkVeLxDXxtDP
 i23HUPlCxrn5jS/zEXMD/dFNILH2INkZ+9xOfGqxy0TkrZGRuxJgyOqnYqnq12ZIAvN/
 kDkA==
X-Gm-Message-State: AOJu0Yxnzzm8B3NlR0ZLl5ypCWDQ/p3WIAErdX6MjKiAhe9fRDbgNy0m
 MDIXiRdaGaqxwSRo2xqDrNUqjNq+Xzip4sv/uo2Lofbsi7gh/4y+esTlHWvGILFGtC51NYiLRlP
 vZk5tF9kukhf5M9CYlA3HRBrv2mevSuqQ+Fkuh5bgarcJLe/qPefKrNyNpH11UtUsvNc4uIAKh8
 1WWxN7o5rURFhr+d0al9yjdNSgf6oCAcnwt5Wmydr/4Q==
X-Gm-Gg: ASbGnctuO7rRW+sWgbp3dvbBN0kkU3SUoXX9RcPvtZMZUtvFlQF7TwJng90p5x36Tdu
 drCunlEwakA6vxHm0i5eM2CmxzSx3BqOMAuwRrN+Rb572HyUERam867Ly/DzBkEHpsPj6gmPrnn
 7pj572hcs5QSfE/T0QXUPKPJJUPTHYpxQXDgobSJZdctjA8htGOgnRjLrU+Jgj7U1Y0FYUfGj33
 5JXi/pO9bC4LQxttQ99yZ1honLFtXbnES5+xdFWxsRgxr9aZGxMcmKkElKN3KHtI2Gnn6BuX4OC
 FibANMgMRdVpRSxpjGTjFhlweTCMBKvciFNtelyF58GgSA==
X-Google-Smtp-Source: AGHT+IHisylNRgoOuNrWbD/d5X+eESRzBVFM6AyDkkDeGTsOM1Q1w4iNdFMyFkzeWLLY2UBq8aORzA==
X-Received: by 2002:a05:6214:1c4a:b0:6e6:6713:3ea8 with SMTP id
 6a1803df08f44-6e66cccc3aemr140345816d6.23.1739780321066; 
 Mon, 17 Feb 2025 00:18:41 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e65d9f38absm49673346d6.88.2025.02.17.00.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 00:18:40 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 8/8] docs: update the description about RISC-V AIA
Date: Mon, 17 Feb 2025 16:17:28 +0800
Message-Id: <20250217081730.9000-9-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250217081730.9000-1-yongxuan.wang@sifive.com>
References: <20250217081730.9000-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-qv1-xf29.google.com
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


