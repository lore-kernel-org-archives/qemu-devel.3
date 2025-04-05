Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1A9C369A1
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 21:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1BOQ-0003TB-4S; Sat, 05 Apr 2025 17:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u1BOE-0003RL-DU; Sat, 05 Apr 2025 17:49:26 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u1BOA-0004NW-Fm; Sat, 05 Apr 2025 17:49:21 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e61d91a087so5135936a12.0; 
 Sat, 05 Apr 2025 14:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743889755; x=1744494555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvSf9TCswsvHlHP1HmqYppAppZQUi4irJNJ4qlnuZD8=;
 b=CJh+R3mCbFkp82qMuWiCdPkFXYr7JAJZqKeVCR5SlJ4gKPvIAApoyycWGAw3L1SU8B
 ErGwZm/LVW9RbPNOYaXRaQR0EWixVj9pSLLbU/O/ILrdS3+iJbTqDHG1UmK/aZtP43XA
 E7W8z0zlDmsDU2ni/qvS1YJMV77/XzWeqvbGBDbVSJdtjOLvSsGPtWBYyuPUy7F1ITe1
 K9ixYnyoIkrJK1VppnhWS5uEzWiM/cdwY5vL37CCeS+2c60Y+XbnHzhBMTN5rPE5Ajk8
 OG2t2ruqIzfoVkmPN2SPEldLjAwZFfuqG/dqeS18QJYWNOYZh5Q8a179vQ7WdrAufG4O
 fxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743889755; x=1744494555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vvSf9TCswsvHlHP1HmqYppAppZQUi4irJNJ4qlnuZD8=;
 b=kmHi25hHVuw5qdxIGRWYUAVZL7UdVLkmxRdqmJUDehfXE85tWtEROZv1O0cARg2B5p
 jhtaCOdO4xGnl+o+tR6Oo1P3zCXn50vu7kYm/4imzCtcvWWa2KWC3x86G1S7dJ0wBWrq
 WQKUDClbpKmlDguYPC0qColfa0XUJO0G7CdSLPXGHkR816UmNpKFXIWnl1QI6xD9mMIE
 s1t9/xxNOh8GW+HbEtUk5hIlsSXV0G2TR1Vf6AxcWqDdUOUizVqlz6UyLbgqYCXOnTiY
 fNCs6YVHbfozFsDMCgqq7YCBfgBoSIiQQ2YxGHst6D8SiwhQ0lNBnEw2htRlIoPjgLvR
 hFjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd7mcke1kgYSBAU+jkHhUSMiEnZVQSeWIkMRGHlsIcZ0TNHnVV4qp8k8KoLB9ZZAttqVPfD6AV6Q==@nongnu.org
X-Gm-Message-State: AOJu0Yw1gOMQLV2Cn1sKCTS1j9GhDLuM3o16aVqhIMm5dh3ep/MqN+6X
 bGJtqcvUrf7iA0J3QKDT8K1wOQFIzjWYT7Hw7/DCgT16RLB1hVY1JiXdtg==
X-Gm-Gg: ASbGncsxirxgK9Lf9eEczUXoW7DjkCUkLKO/ymzz7vfYSjkv/IIvcMM8RskcOVoNPcq
 Isd0QNn4hUFNBvSJ7RXfQt3mRlmZLKDEmktN/zvaVY8z253iSbGJjwycHrac13zQan4EONBuqOK
 g9AVOCIr7T14BTLrkL2PJ0k1XdQKxIdaUmDGVz2Es1kqRI1N4vcp/46XghNXaD9jIMXG2D84n6C
 Qcfy5MQR71oV/7ug5oXoAAbC4VodIwpEI3qkDdgSa+SQ2vF6iUGA6mDzSMhbqgsdffeS77ZRrrv
 QjQ8Jnm9jfQdlngMb1PuZuIjd3WXz1yr5WojrrEc+p3dmXkRB4g5UNQSH+4uF6W5DFVNk74HRtq
 B3pmfyCZEOP8EjKk3Hrg0Cv+8XlroorogQ3phcWGEcKRJSFzwBRyjLEZR0GHOtoIU
X-Google-Smtp-Source: AGHT+IH6ybiIybyjTHTwEfDU/6Cd2anIghJD0Jbj9kTs8WAe6ShbayhUOE/DxKeK4YulFz04VoOeDQ==
X-Received: by 2002:a05:6402:5187:b0:5e5:c847:1a56 with SMTP id
 4fb4d7f45d1cf-5f0b3b8f022mr6647717a12.10.1743889754988; 
 Sat, 05 Apr 2025 14:49:14 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-1bf0-7700-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1bf0:7700:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f0880a535fsm4382270a12.80.2025.04.05.14.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 14:49:14 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-10.0 3/3] hw/arm/imx8mp-evk: Remove unimplemented nxp,
 imx8mp-fspi node from devicetree
Date: Sat,  5 Apr 2025 23:49:00 +0200
Message-ID: <20250405214900.7114-4-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250405214900.7114-1-shentey@gmail.com>
References: <20250405214900.7114-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
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

From: Guenter Roeck <linux@roeck-us.net>

The nxp,imx8mp-fspi node triggers a warning backtrace.
Remove it from the devicetree file.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Inspired-by: commit bf1da4b308 ("hw/arm/raspi4b: Temporarily disable
unimplemented rpi4b devices")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
[Bernhard: split patch, adapt commit message]
---
 hw/arm/imx8mp-evk.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 3bbf2bfbea..b5aec06ec5 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -19,7 +19,22 @@
 
 static void imx8mp_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
 {
-    int offset;
+    int i, offset;
+
+    /* Temporarily disable following nodes until they are implemented */
+    const char *nodes_to_remove[] = {
+        "nxp,imx8mp-fspi",
+    };
+
+    for (i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
+        const char *dev_str = nodes_to_remove[i];
+
+        offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
+        while (offset >= 0) {
+            fdt_nop_node(fdt, offset);
+            offset = fdt_node_offset_by_compatible(fdt, offset, dev_str);
+        }
+    }
 
     /* Remove cpu-idle-states property from CPU nodes */
     offset = fdt_node_offset_by_compatible(fdt, -1, "arm,cortex-a53");
-- 
2.49.0


