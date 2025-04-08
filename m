Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D839C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 18:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2E7T-0004fZ-8j; Tue, 08 Apr 2025 14:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E7R-0004eq-NH
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:56:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E7H-0004GE-8l
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:56:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso42152115e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 11:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744138569; x=1744743369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvBD1LnrYNmOkAZrAGP0jzg4GO67WuTA1FoobUCdqFg=;
 b=tV4VBKw42jk+I0OaGQpOe11P5QN7NhAGUnV9042hC7ODalHM1USwkFMmYHW0a83Vw9
 7u/iW04lgcjeRIHS66jCXRajipzZ1ub0Rfe2W3rD2dzKR3dXPTW1cdlkN2LlC6q1b07H
 BoFDJ6ZyXxMLXNa7VjG8JS033EdKMn613VtOSE0HYJIBJs2Qiw6M3v6wnT54MOdIaUDN
 zHXtnrBRb2uY6R069EKTfsUuokwqkLIAph60HIoiVCLsaJgGTOxu5cUvzNpTJ63t3gYr
 VUBM+EbfFPp5H6IsJyrc6E+tnck/q+cFthgVV5SoWcgm4BvIXSm7MDQstkE03PbfnnNq
 bSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744138569; x=1744743369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvBD1LnrYNmOkAZrAGP0jzg4GO67WuTA1FoobUCdqFg=;
 b=d2RGTn1u40F5svVxdQW58AWBNbvg8AwDYNjqyXSs21wJKSCOaoIQoFQ4qsuhb45HDa
 6kMtIICXfJ2rqI8dOPGnI/7lVO3p8FOcBnj0FVQMSwj4xvAW8ec4/+QMlnuOiQ38s9Vf
 /ftTLVyXR0rlHDp8I3j6KpFYJBhCz23ynk94nDb9d0Ussjcc+WobAXLPokue9NbKwFdC
 hicEqtkGe5Syt9SAjbwblm0JvSkMEZVXn+XAKmPeOW1p7PC+vzk7OBtzI7wfhtrIqkg1
 3iMDxB5zYn7pF/Lj1tZ+v5a3SZlvXUCWbrzEpynbdXa3clbu4Kl7RWcwsNF5SpoG5KKr
 32Qg==
X-Gm-Message-State: AOJu0YymhAiRkOB0bdbNXN+VfDhdcaot8tE2zdW+GYk6VHLev6b8IILR
 nU0ul7GohmCbSFkOGzccPsQe56LHF+VumzCwfzgy/7znQVWRecbmKmE+EyDhKs+N9FL+kyoU8zP
 YJx4=
X-Gm-Gg: ASbGncshBvLz6KkxdRemqwsrb60N2MSn3lkR1ra/RcpREgENZDVpJCiNbiRqmotM/jt
 6WonbKCWxTfB84TMChPhS8bvWR2ew3moYSwWRyK089ETOa5q+uv68CVXrpxVRO0N6T1VZs6TgbC
 VNvU20Qj/dh1g4ohO+5L/Gr8nZaMh9+MBeEG8VS35m89AxL8gaLdQp95Yz+0XREAXzbeYgXUKpG
 XFhyEe2NZWEmnjy5eb0PvWN03v7ItP+PA38IJbJDA8zZY9uhKrUfSTvl6hOyUR4K6YT2e/bfFS5
 RGlsPaQkw8erg6V0DUNdFB5dQImdTxDUb4PpkCHd/gA8adIZApIEV4Y+F02s2yZs4RWwXzk17TL
 hyTFxYe05DdO2ILlxV/s=
X-Google-Smtp-Source: AGHT+IEvWFLrefaAc9VW5wNYrj4PWj8ZucnBp1g/COuIukdLhIXXnKhwk8Uj19jAGkVeBkt+pMFEkg==
X-Received: by 2002:a05:600c:1ca1:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-43f1ec800a1mr1344865e9.1.1744138568923; 
 Tue, 08 Apr 2025 11:56:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226ecdsm16359785f8f.99.2025.04.08.11.56.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Apr 2025 11:56:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/8] hw/arm/imx8mp-evk: Temporarily remove unimplemented
 imx8mp-fspi node from devicetree
Date: Tue,  8 Apr 2025 20:55:36 +0200
Message-ID: <20250408185538.85538-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408185538.85538-1-philmd@linaro.org>
References: <20250408185538.85538-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Guenter Roeck <linux@roeck-us.net>

The nxp,imx8mp-fspi node triggers a warning backtrace.
Remove it from the devicetree file.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Inspired-by: commit bf1da4b308 ("hw/arm/raspi4b: Temporarily disable unimplemented rpi4b devices")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
[Bernhard: split patch, adapt commit message]
Message-ID: <20250405214900.7114-4-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/imx8mp-evk.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 3bbf2bfbea3..b5aec06ec5e 100644
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
2.47.1


