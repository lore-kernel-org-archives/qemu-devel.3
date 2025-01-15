Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6679FC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6ul-0007RD-Ax; Wed, 15 Jan 2025 12:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uh-0007QV-C9
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:43 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uf-0006Za-Tl
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:43 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so42545f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961040; x=1737565840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLyfo8A7IZIE7IOrZd9qH5+UHn+eynSluJZ+bRJ10/s=;
 b=Y1mof02fdBTswiEUSGVm4FqMYLmwpohZLULN7oTQyFOWLHNQf8cLAweM231D0tyEwu
 EjaqkvRH6ah4T4z/cFMPPsHGyzBBPwWcU79KHWW1hGojhAK8eqQQifggW8MT9oq+UKkp
 cSHjqx1Zwlzxhd/l0zrzzYUpAIZBGNn6KWOIdhdD0XQ37g6MgQiOjISb8zAWe/tJeo/U
 6JYdTorirH3WDILqSEmYcRMA+O2CEVKd/xXIQBK8pRIeDioWC+1sQgsG+z+EXhPLvYHl
 9bMckJ6FS9pzgrHgJsK4btSXaZsN3XFT73sRMsDffNPmJddu47d0IJx5NNqFooVDvvBZ
 uOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961040; x=1737565840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLyfo8A7IZIE7IOrZd9qH5+UHn+eynSluJZ+bRJ10/s=;
 b=r5+BzSzA2b4/bEfQzeFwy2og4uv45pj8NyfBHHmrVFGZTkU3cGRd3In8o7tyRJ2x4R
 NjZgir9XzI8Rjue8s+b7l8meLVN/NxBgsqwabe1WP1ZOx+aLQ5LNkW43M3VHyy/kSCG7
 r0IcdC82LnB9TJaIC6hkyTc2CSOWctrZb1Li3B6oIePfOeNwL7CizeMkT9nkGNbgf8lB
 h9ryHMUqItr5eNOBur4dvnG2q9cUbVHY0WrWQ/EYDNQs4vpW0vAumfRQJon8jOKl8NZt
 QFKOrRJM/kjn++nkgl7XvANEnNvt/aprmzlCw21wk3diCp0V03RkTvMgvb4LOdBFay8g
 Vr1g==
X-Gm-Message-State: AOJu0YwDZcOfmJcIM3G1PmnTgponFCcc0NTBIkykAY+X2HPwBlRRxyTx
 yqC+kTdhUzjvkpA3QMhwpEGaWBBqpxsUE3jQWXPzLSrl0rhyJTpHdOH+1llpyjCd7sbYyiyVnrU
 fmuY=
X-Gm-Gg: ASbGncs1gITy66M10GhcSD6G3RzXHpdPcJNrhMTk51JviXUCXR8+JgwtnamiBiaBYQu
 D3KfIf9KiudRjAc4UzkeV8Bcb6BXq4Z1ZZxGFcNS5H55mVS/iIBKZdDf8+C4gwU2U9B+0ssei47
 siyxXD4iKBFJbhPzbSkX1gxYKYUImtbznUa0/ZESmljSTmV77eeC+8CpEDUU6ECqBHSKgBF+sHL
 iJ7OTDKl0XoKg7nOs/oWsJgu2wC3DR1e/8YZQysNRn+Lp/6tOKori8gziyjvlsByKkFxyZWSyIN
 PKEnzqTo+KCIKecvD0/PbkuWM7cUKgbs7V8q
X-Google-Smtp-Source: AGHT+IEewz6G4VAcWkXSJWgHbrI3YcLVGLWnoWAclkHQ8MH9KvNFGDSsG0PllBaS1l2s+02bHlOhqg==
X-Received: by 2002:a5d:64ed:0:b0:38a:4b8a:e477 with SMTP id
 ffacd0b85a97d-38a87306a84mr28026807f8f.22.1736961039922; 
 Wed, 15 Jan 2025 09:10:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74995f6sm30405545e9.1.2025.01.15.09.10.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 09:10:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/13] hw/arm/virt: Remove deprecated virt-2.8 machine
Date: Wed, 15 Jan 2025 18:10:02 +0100
Message-ID: <20250115171009.19302-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115171009.19302-1-philmd@linaro.org>
References: <20250115171009.19302-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

This machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst |  4 ++--
 hw/arm/virt.c                   | 13 -------------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 435f081d805..732ec2cd05d 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1065,8 +1065,8 @@ for all machine types using the PXA2xx and OMAP2 SoCs. We are also
 dropping the ``cheetah`` OMAP1 board, because we don't have any
 test images for it and don't know of anybody who does.
 
-Arm ``virt-2.6`` and ``virt-2.7`` (removed in 10.0)
-'''''''''''''''''''''''''''''''''''''''''''''''''''
+Arm ``virt-2.6`` up to ``virt-2.8`` (removed in 10.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''
 These versioned machines have been supported for a period of more than 6 years.
 
 linux-user mode CPUs
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d7a7cee79df..4ec94190769 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3556,16 +3556,3 @@ static void virt_machine_2_9_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
 }
 DEFINE_VIRT_MACHINE(2, 9)
-
-static void virt_machine_2_8_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_2_9_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_8, hw_compat_2_8_len);
-    /* For 2.8 and earlier we falsely claimed in the DT that
-     * our timers were edge-triggered, not level-triggered.
-     */
-    vmc->claim_edge_triggered_timers = true;
-}
-DEFINE_VIRT_MACHINE(2, 8)
-- 
2.47.1


