Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E63E83837
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6Cw-0002nC-R0; Mon, 16 Feb 2026 16:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6CK-0000us-GP
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:32:07 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6CI-00043M-IP
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:32:04 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4377174e1ebso2685765f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 13:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771277521; x=1771882321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8wNVeXGsx4+MMgwpCdoiP3HRol652dz1JzpsDMD+6w=;
 b=GBmUQg0DARuunz3u1v8BuoPKnU8ffmQ6/sRGf2Y5tqvo/LsLDa5yrVufmqB62Z/Wp3
 xjO+3lLR6dH+7hu3SJ+HI4Xc3POk5ZM0s2Eo2GtinL3pc/3SI6ZfrU/y7/IulNDkY3yd
 i0nervPMEdMnKn1t9d0kQDecgxhlYnGdNGKxC0daxtAKmz7AvReT7fbMGJTrwMA2zsHm
 c+M2Nw59ED6X/y/mDZ88wvrJP1doMisvpISuW82tQU2Pf8t33r6S9lGLpyBTbmrsoZB2
 X/wVXZkaS7c2xCPQ0TnQC/7LlVZVu+LJuipdBOT+mNFCvgsT/qeDQNkaOrfbRU0z7hHS
 jJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771277521; x=1771882321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V8wNVeXGsx4+MMgwpCdoiP3HRol652dz1JzpsDMD+6w=;
 b=tgGO3SIt+C0hW7DAZ6X5Widx6gZ0t8y6arQX7Yz9CFNx9eBP82tm96Ps7rOA1m+62j
 IOqaUxy/P4YfwCcOhZYcCHVGBSWfk9VHMwj8OHQHI5i1DilPQe5IPHCixrItL2SbjGiX
 2JX7d9t6vpdWnySvZKnJcayIKMEJK0n9JjJuOdzAgM6Rc4w4Mmkjc6B6GHoshkm6JtZA
 yO5N8xc4nOqLCMqavWg73cnwT5Pz7SxPLe0FIXQ1FwacjNODGBkWBhJjLT/MYPuanrRY
 +hB4/ihugCLTaj5lJ2MbQm7DmC3gIXVY712gmYj2A/Sy2wGDwb7VAul6k8lot20fKn5L
 Ppcw==
X-Gm-Message-State: AOJu0YxCcrN/uYAX89s99I49WCJNl/sdKr3shHkdswYXT6W2RD9UeAoQ
 9kMqkDf1HdHyCchSHFb9/FZ6FkeQO6+K78DDqpVe+I1knxnTrJScNosnnVbTfq5LTVgGJ67EE5s
 p7rrFivQ=
X-Gm-Gg: AZuq6aIQXl66Ux+p2UbgLjonhXQIi3Ai27hMBxdH2q4dc4I5qO5f5tQulYFoL2U/SqU
 K6QSzwQhfi8J/HXh3iOgMvl+LMNKUNeK+KTXV7OtvLORxlxwiXHBU8VdjSAU9LHPzmIefi4GoQU
 6cVFt9OHSoeZgZjK4PD6Q7WuVqTZW7zz3Hkx6L2WkS2A9c2ubq+x+4jxz+FvKDca8KqPo+Xr94P
 icjU4pFZ21Z1uf5LwbPx1NXc4nnj3kNAARjLcuFwWpXDiG8NvXbWk/6PB8VR1342kX7t9qAufs6
 iMrPWwm2xcf50f+oC8YB3e8LTo8ZojDMlxnQ4CPhhcbUR0VKE4mR0AvbaIwi7QI+vD7wrxNn4Dy
 dnXvi9bBsql/O+I1QSMYa0jLft1i67hlem36RKcKUIhFVS8l7rWCk7mOHi375wJzdOrM6rBgx47
 0e1vt+NMdPnmzIvFnyP3zFW7EBo6zPsNi6XZkaiKoKx4ec+z5qOTCnCf3YpaSceELICnj39UIpY
 3zLtHKOLIM=
X-Received: by 2002:a05:6000:1843:b0:435:e3bd:5838 with SMTP id
 ffacd0b85a97d-437978dd2fcmr20770738f8f.25.1771277520693; 
 Mon, 16 Feb 2026 13:32:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a74704sm31690316f8f.16.2026.02.16.13.31.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 13:31:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/8] hw/m68k: Set graphic display dimensions generically
Date: Mon, 16 Feb 2026 22:31:18 +0100
Message-ID: <20260216213121.47122-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216213121.47122-1-philmd@linaro.org>
References: <20260216213121.47122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

If a dimension is not set, have the machine init code
(q800_machine_init) set the default values.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c          | 6 +++---
 system/globals-target.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ba32da2fa45..ded531394e6 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -560,9 +560,9 @@ static void q800_machine_init(MachineState *machine)
                             TYPE_NUBUS_MACFB);
     dev = DEVICE(&m->macfb);
     qdev_prop_set_uint32(dev, "slot", 9);
-    qdev_prop_set_uint32(dev, "width", graphic_width);
-    qdev_prop_set_uint32(dev, "height", graphic_height);
-    qdev_prop_set_uint8(dev, "depth", graphic_depth);
+    qdev_prop_set_uint32(dev, "width", graphic_width ?: 800);
+    qdev_prop_set_uint32(dev, "height", graphic_height ?: 600);
+    qdev_prop_set_uint8(dev, "depth", graphic_depth ?: 8);
     qdev_realize(dev, BUS(nubus), &error_fatal);
 
     macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
diff --git a/system/globals-target.c b/system/globals-target.c
index 989720591e7..e3f7d846ac0 100644
--- a/system/globals-target.c
+++ b/system/globals-target.c
@@ -14,9 +14,9 @@ int graphic_width = 1024;
 int graphic_height = 768;
 int graphic_depth = 8;
 #elif defined(TARGET_M68K)
-int graphic_width = 800;
-int graphic_height = 600;
-int graphic_depth = 8;
+int graphic_width;
+int graphic_height;
+int graphic_depth;
 #else
 int graphic_width = 800;
 int graphic_height = 600;
-- 
2.52.0


