Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A16D232E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6Pi-00043Y-Ot; Fri, 09 Jan 2026 01:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PK-0003k8-Lq
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:40 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PI-0002pl-Ft
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:38 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c075ec1a58aso1681794a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941734; x=1768546534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=92h8wMo6IUZq5rJMwR5yZtQa4K7Jxdwtk3361Z/f4wU=;
 b=nm2Xw55g/8BKB4w3uNdkBJZWjdkiYpGrPA/ucLbSdfvsB7WvX+ZVfCbYxekiKGI+Oc
 gL/IzXXUtKZVB814FlZROKsWIwvZre6FT4D3alOQdGWaOcN7RJcjhnXqqZaIBYsRlGTu
 NiEavOyhzvJgU/Mx1HCuw+wSTun3/MCgV64gFugpsz3e/wpHHDEcxmzrLi+JDGd5jeRI
 e0VN3MNKY5ULCEOk3mcgoIocmrg3Alvx8YU5kZP3+iatuCRxMOmF5ea0q4Mh43Vq8PlL
 s6wmgNniJhAFsh3CCRivRFNa5wQdlRV03XvDWhcCkk6V77yevuL4+RnO7ksK5v9ZGn5V
 W8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941734; x=1768546534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=92h8wMo6IUZq5rJMwR5yZtQa4K7Jxdwtk3361Z/f4wU=;
 b=U0F+U7mu9jicQeKTSFcWVuqgb9Slt0WQGDMjXDAcvGyRXT1LVhzcvAJemILXIsTm8Q
 YAbfBQIuun6k7X9f+zeB6t2xniC3Rfmv+GjJP5GwgodJTLl5zAOWNKhzILYOjF1j21NH
 BD56Ngut6yn9kiw2sGMSgak9qr5LPfO5ljcMY28o4rwvocX9J67OTxTYaDuFORnQxtZF
 B5lEeQqShUnPPrU1aSo4iBMSjkjaNpp7UhQfxdALvdwxvM9uBp9aJTsaRIH3pmgjcFRb
 fS219Q35O/htiJbUNjAH4+mnNlcOneCR4u547ddgyNfjGs29lQFkvLYpQIA/yMuTdb9d
 CnfA==
X-Gm-Message-State: AOJu0Yz6r2vRY2HMCm26Lmq0sJI7yN+vJ4bYO/6bqKjiD0WF90/2BbZK
 arTSrpAaFmVU7nGkekNoLpHybkVfmIDaMCqsSrlqnU+1AP0BJ39TxBpk4Iw1pg==
X-Gm-Gg: AY/fxX6gfpz2Fe1f2HE9iH3087qEJc38YN84pU4Q6yDnK7WP9Hxsvi+67WIsMIfb+1m
 J7P/JMTS4TJdFthLznybmvm8zVHLrlyqXXgt+gxUx8oD6DVVHPQTe+9hqouelp/xrpBqKPUaaGv
 sZpX4hsnnSFmgeU2AFVr/evD0DHTTMQ3QS3bKchmLHigwN9+Pi1bnpBVmVCUgrYHYOPKj66qwwm
 N3ebtv4g9r9wZq8/H1NZ2hG/9m+6RWIpiXWPdhrZbddUaQuz1elicpEmqn5ExCm48xqF8HuUglW
 hZlKAgPpMUxfB9br+8tf12y1w4mEfDIxHvUXeqmff3abpc4vAKCYHRyLVH2B8lYh4KpXTRdqTzo
 J3DbssLvkkSaoYoMmNKS7ZB+p7gdnvdQSvzWPRXQS1egM/pjZ3ljHKlFyrBJrqujwSZ8Fjp1zzx
 b8I7q3epE/JZepYPxmI4KgpyJOVP+L2ELm9XvHPliCMbN240c1cMaOXPUjJgvhUt3YC+5f+xXPd
 PJcsWaYkjnPwB3Z/Is=
X-Google-Smtp-Source: AGHT+IH1XWDp21XBc6eFvg1xwJntOwV7rwfEp2ViFlh8QOvz4JuP6k0LTGfnl9MYikAG8vLCvLpUWQ==
X-Received: by 2002:a05:6a20:12d5:b0:35d:d477:a7e7 with SMTP id
 adf61e73a8af0-3898f906c7bmr7734664637.22.1767941734316; 
 Thu, 08 Jan 2026 22:55:34 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:33 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/34] docs/specs/riscv-aia.rst: add 'riscv-aia' accel prop info
Date: Fri,  9 Jan 2026 16:54:33 +1000
Message-ID: <20260109065459.19987-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Add a small section talking about the 'riscv-aia' KVM setting we
implement and how it affects the provisioning of the IMSIC s-mode
in-kernel controller.

While we're at it, fix the formatting of the AIA bullet list.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251028084622.1177574-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/specs/riscv-aia.rst | 43 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/docs/specs/riscv-aia.rst b/docs/specs/riscv-aia.rst
index 8097e2f897..f3c6ab7fcb 100644
--- a/docs/specs/riscv-aia.rst
+++ b/docs/specs/riscv-aia.rst
@@ -8,10 +8,8 @@ RISC-V machine for TCG and KVM accelerators.
 
 The support consists of two main modes:
 
-- "aia=aplic": adds one or more APLIC (Advanced Platform Level Interrupt Controller)
-  devices
-- "aia=aplic-imsic": adds one or more APLIC device and an IMSIC (Incoming MSI
-   Controller) device for each CPU
+- *aia=aplic*: adds one or more APLIC (Advanced Platform Level Interrupt Controller) devices
+- *aia=aplic-imsic*: adds one or more APLIC device and an IMSIC (Incoming MSI Controller) device for each CPU
 
 From an user standpoint, these modes will behave the same regardless of the accelerator
 used.  From a developer standpoint the accelerator settings will change what it being
@@ -81,3 +79,40 @@ we will emulate in userspace:
      - n/a
      - emul
      - in-kernel
+
+
+KVM accel option 'riscv-aia'
+----------------------------
+
+The KVM accelerator property 'riscv-aia' interacts with the "aia=aplic-imsic"
+to determine how the host KVM module will provide the in-kernel IMSIC s-mode
+controller.  The 'kernel-irqchip' setting has no impact in 'riscv-aia' given
+that any available 'kernel-irqchip' setting will always have an in-kernel
+IMSIC s-mode.  'riscv-aia' has no impact in APLIC m-mode/s-mode and
+IMSIC m-mode settings.
+
+
+.. list-table:: How 'riscv-aia' changes in-kernel IMSIC s-mode provisioning
+   :widths: 25 25 25 25
+   :header-rows: 1
+
+   * - Accel
+     - KVM riscv-aia
+     - AIA type
+     - IMSIC s-mode
+   * - kvm
+     - none
+     - aplic-imsic
+     - in-kernel, default to 'auto'
+   * - kvm
+     - auto
+     - aplic-imsic
+     - in-kernel, hwaccel if available, emul otherwise
+   * - kvm
+     - hwaccel
+     - aplic-imsic
+     - in-kernel, use IMSIC controller from guest hardware
+   * - kvm
+     - emul
+     - aplic-imsic
+     - in-kernel, IMSIC is emulated by KVM
-- 
2.52.0


