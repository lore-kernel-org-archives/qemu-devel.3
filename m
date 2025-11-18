Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B506CEE34B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQxo-0000RA-Ep; Tue, 18 Nov 2025 14:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQxc-0008LZ-6e
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:55 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQxa-00062g-MX
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:51 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b3d7c1321so4228874f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492509; x=1764097309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+Cgq1nPDbrgVNM6eBtgyf6KBbF6NBZzhdBWfVQaqrO0=;
 b=v6JbdAVx05NbQK4yB8I5ATYktV0IbtzxBZcKjgRQNQC2DNOuXG0bs6JHOhBa7PvyWZ
 EDwMi+p4lxbnHzvcQ2Do34G83VIF5dTnXNOwyibIGMQP27YDN7j9U+6rkZMfWQOO0VY2
 WRei/kD5FCtslrNT3Ld6rjgNEZZMYNagu1C932u2JW1vpyJQEsOOdbqvo3Ps3LosTfHU
 WXG2LOOIFTh8HkEKXC3XISLeSl+nj59AZBQXtSi03i6IiPAnhTc/ZUhSqcyUtRUGCEo3
 0fdp2vbFQCb+8aO5JpTTTaZy22Xt67LNav5pJsUPDW5P22/iSrcXk5A554PY/1GakjJN
 h3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492509; x=1764097309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+Cgq1nPDbrgVNM6eBtgyf6KBbF6NBZzhdBWfVQaqrO0=;
 b=FF339jH36A9H69n2RTKKaDnj2B+gIUMRlHeQCbgy02Ayzet4miQyIgK2wfA1nrZ9Pv
 DrX+gTwJm1ZQN6u0c1OLZc/yH2SklOm+G09HTGvAG0zpY3kM2i8Ei3yxXJ5dn0OCOrF4
 G9gZu3mT6QSEafuGFAhp2neTGvt+y/DLtAAXNTgt9GNxtCIJ5OfHBtureabPLZBcKBlZ
 8zqF7CqChg5b8Xd7570Qfjl0VYwrzwL/KIOuM/LccGRCUwZmJM3IBNnRPIyVNneWmJv0
 hr1ebitT6au1xFFG9y362w/m3mpYetco3ailVJ3tgimqwXAqF2QralGC5oRmk9QZD5nT
 1v7w==
X-Gm-Message-State: AOJu0YxASqE8Io2TEie3xRfEf+qw6UXY/DFVpNcKmYG+Tc9+6DBzFjW5
 ImqxS/TN8EtVK0mytDM4XYWixWcJVLu1JXlubw9HIObKf27Ayk6RtbWBf9ce39y+z+Csy3M+1Ed
 Iygy33UOKqA==
X-Gm-Gg: ASbGncupnjxZsoOTX5CwBA/yF9dA6B3jG2dqhMDRiw6FS4OKmvkNjhimcvP4gOeeW1z
 X92SFpxhKpI35j6qwZqp5/IBUEplJnn917LRTAIZoj0hYBGM6g9wAwCZ3JaZ+UzRUxTLYsUBHbz
 6BFSF0ZmSXfNzc9+cnda0b67zqvSTYPXitOWj4NsnyEobfLOQZByO/4E3fEB2+r5WZ2kKOS5qIi
 p0ezrMvD77qlbaLOZdbUZT9Q+M7rR9xxKVY24dmRlvS98l/wvuUi0AoemYruPGPSp5Zy8uXmMWX
 5f9dghzbIjJfbwKboZ6ih03hAVktK2bCQuYpNmhsCg4iMagKS0VAeNmoX0yPwhNf73z09O+r8f1
 rHxqbZzdpm15jXD4SHulJsw9GnHE6DjR3vW7ScmSiOS0XCIws3XLDPgBEaaFnHb45Yg7pQgUV7V
 +BPlOjh+Ps7e0r/alqzNKGMEnBgbx+tBLWLfZ6QwkngORC4lPGbCmQXhT1r+nNKO3H4yIEMz4=
X-Google-Smtp-Source: AGHT+IH18rYxk/+S9TGaATYnDltnQ9XBBZ+6uQG7n/MKLwdelr0BsNhSZG6QhmqksyeP3dqmI/lIFQ==
X-Received: by 2002:a05:6000:4020:b0:42b:3302:f7d4 with SMTP id
 ffacd0b85a97d-42b5934e25bmr18741385f8f.22.1763492508813; 
 Tue, 18 Nov 2025 11:01:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f17291sm33724503f8f.32.2025.11.18.11.01.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:01:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/18] hw/arm: Re-enable xenpvh machine in
 qemu-system-arm/aarch64 binaries
Date: Tue, 18 Nov 2025 20:00:42 +0100
Message-ID: <20251118190053.39015-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

While registering the ARM/Aarch64 machine interfaces
in commit 38c5ab40031 ("hw/arm: Filter machine types
for qemu-system-arm/aarch64 binaries"), we missed the
XenPV machine. Correct that.

Reported-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20251117091253.56009-1-philmd@linaro.org>
---
 hw/arm/xen-pvh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 1a9eeb01c8e..86a02966161 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -10,6 +10,7 @@
 #include "hw/boards.h"
 #include "system/system.h"
 #include "hw/xen/xen-pvh-common.h"
+#include "hw/arm/machines-qom.h"
 
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 
@@ -95,6 +96,7 @@ static const TypeInfo xen_arm_machine_type = {
     .class_init = xen_arm_machine_class_init,
     .instance_size = sizeof(XenPVHMachineState),
     .instance_init = xen_arm_instance_init,
+    .interfaces = arm_aarch64_machine_interfaces,
 };
 
 static void xen_arm_machine_register_types(void)
-- 
2.51.0


