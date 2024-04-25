Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9BEC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwti-0000Le-Ma; Thu, 25 Apr 2024 07:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwsP-00089g-1V
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:53 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwsK-0008ME-L7
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:52 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34782453ffdso774951f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714042966; x=1714647766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1My8ZSy1rXly0MJHGOKnYCpxMH11O/qNA4PcnoQO/Bk=;
 b=KVskqAR3LQ9dvMHcvBTznebqLCn/DRkEwFiSaYB/Mgfjq36jG4YPFzAFs6j15i7QWo
 CYTMZTakuAMZ1eqoxdg9kAOu1UEh6nbMMT94cyz0ycXKLoSS7sVcfVNdKVuS52/Jmj9U
 dbVAIorWMZONE0F2lZeSVQrqwvD0TbCW1pd7TpwkVUVsHXjZ85ZiOyY5tGBF3+wzdEdk
 zYwZRdnbk9frdRd8e9xqAADnjwMKICbEWLqRxEEXsK21kFd5a+RZKisM26ZQx/bAaus3
 lFCclX8cTBJRSzQ4Zg4kdRT4tR+SbqIb5rlhUy5hRd/OkuuJ/BjuLrRPCsTdv1SQA1jc
 6+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714042966; x=1714647766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1My8ZSy1rXly0MJHGOKnYCpxMH11O/qNA4PcnoQO/Bk=;
 b=O7wUdr12Ntb/RD6rNbmd6LMRL0YqF2Ub6gisDNPAJS7+429t322KOBjAwoxogDJjJO
 D4llyVCVWeZzmrr3DQ99lvMQLKwh0oWymqCPKGeabITWyLyCNPCw4wE1/2kVPBpHPR/Q
 4cqStm0sGlmSwjym5D4T/hgqulUkSIuH6JfN+A1BJxaMlb7Pk5dagvRwYKY7bSVI7cdM
 pTFvjRzd7yLXuVm6st18s4wmNaXxUtSh5TFdpr0p/tT5zuOOM+uD8t0JhDd707HTyUSn
 AMqefwUQZ/eFxYDy3AojSx2G7pICyWG2Mekc/IdqbF37DfD95+qWsIEet5Huy71GpVoi
 awHw==
X-Gm-Message-State: AOJu0Ywon049P6UT2lE+zIyq0vq3l6Fthj9YN+MjO9bU0cM+Js3TbGlJ
 jbYU/FzknMvQ2RdCgISqM0wJrTzUfESrtXNfvNpQ6kxhZOVUFSn0g2FTEiSFps49MVYOYyjJk/d
 s
X-Google-Smtp-Source: AGHT+IE4IoeXcSulUmKusv8xe735pBmPVtI1vUDyo/L1oiGIjq+L/sDOEgWcwuFIItf50QS5uMpM1w==
X-Received: by 2002:a5d:420a:0:b0:34a:33e6:440d with SMTP id
 n10-20020a5d420a000000b0034a33e6440dmr4481547wrq.24.1714042966196; 
 Thu, 25 Apr 2024 04:02:46 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 fj3-20020a05600c0c8300b00416b2cbad06sm31028131wmb.41.2024.04.25.04.02.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:02:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>
Subject: [PULL 08/22] hw/misc/imx: Replace sprintf() by snprintf()
Date: Thu, 25 Apr 2024 13:01:41 +0200
Message-ID: <20240425110157.20328-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developer experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240411104340.6617-6-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/misc/imx25_ccm.c  | 2 +-
 hw/misc/imx31_ccm.c  | 2 +-
 hw/misc/imx6_ccm.c   | 4 ++--
 hw/misc/imx6_src.c   | 2 +-
 hw/misc/imx6ul_ccm.c | 4 ++--
 hw/misc/imx7_src.c   | 2 +-
 hw/net/imx_fec.c     | 2 +-
 hw/ssi/imx_spi.c     | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
index d888966014..faa726a86a 100644
--- a/hw/misc/imx25_ccm.c
+++ b/hw/misc/imx25_ccm.c
@@ -91,7 +91,7 @@ static const char *imx25_ccm_reg_name(uint32_t reg)
     case IMX25_CCM_LPIMR1_REG:
         return "lpimr1";
     default:
-        sprintf(unknown, "[%u ?]", reg);
+        snprintf(unknown, sizeof(unknown), "[%u ?]", reg);
         return unknown;
     }
 }
diff --git a/hw/misc/imx31_ccm.c b/hw/misc/imx31_ccm.c
index a9059bb1f7..125d4fceeb 100644
--- a/hw/misc/imx31_ccm.c
+++ b/hw/misc/imx31_ccm.c
@@ -89,7 +89,7 @@ static const char *imx31_ccm_reg_name(uint32_t reg)
     case IMX31_CCM_PDR2_REG:
         return "PDR2";
     default:
-        sprintf(unknown, "[%u ?]", reg);
+        snprintf(unknown, sizeof(unknown), "[%u ?]", reg);
         return unknown;
     }
 }
diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index 56489d8b57..b1def7f05b 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -85,7 +85,7 @@ static const char *imx6_ccm_reg_name(uint32_t reg)
     case CCM_CMEOR:
         return "CMEOR";
     default:
-        sprintf(unknown, "%u ?", reg);
+        snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
     }
 }
@@ -224,7 +224,7 @@ static const char *imx6_analog_reg_name(uint32_t reg)
     case USB_ANALOG_DIGPROG:
         return "USB_ANALOG_DIGPROG";
     default:
-        sprintf(unknown, "%u ?", reg);
+        snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
     }
 }
diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index 0c6003559f..3766bdf561 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -68,7 +68,7 @@ static const char *imx6_src_reg_name(uint32_t reg)
     case SRC_GPR10:
         return "SRC_GPR10";
     default:
-        sprintf(unknown, "%u ?", reg);
+        snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
     }
 }
diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index bbc0be9921..0ac49ea34b 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -143,7 +143,7 @@ static const char *imx6ul_ccm_reg_name(uint32_t reg)
     case CCM_CMEOR:
         return "CMEOR";
     default:
-        sprintf(unknown, "%u ?", reg);
+        snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
     }
 }
@@ -274,7 +274,7 @@ static const char *imx6ul_analog_reg_name(uint32_t reg)
     case USB_ANALOG_DIGPROG:
         return "USB_ANALOG_DIGPROG";
     default:
-        sprintf(unknown, "%u ?", reg);
+        snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
     }
 }
diff --git a/hw/misc/imx7_src.c b/hw/misc/imx7_src.c
index b3725ff6e7..d19f0450d4 100644
--- a/hw/misc/imx7_src.c
+++ b/hw/misc/imx7_src.c
@@ -75,7 +75,7 @@ static const char *imx7_src_reg_name(uint32_t reg)
     case SRC_GPR10:
         return "SRC_GPR10";
     default:
-        sprintf(unknown, "%u ?", reg);
+        snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
     }
 }
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index cee84af7ba..8c91d20d44 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -41,7 +41,7 @@
 static const char *imx_default_reg_name(IMXFECState *s, uint32_t index)
 {
     static char tmp[20];
-    sprintf(tmp, "index %d", index);
+    snprintf(tmp, sizeof(tmp), "index %d", index);
     return tmp;
 }
 
diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index d8a7583ff3..12d897d306 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -53,7 +53,7 @@ static const char *imx_spi_reg_name(uint32_t reg)
     case ECSPI_MSGDATA:
         return  "ECSPI_MSGDATA";
     default:
-        sprintf(unknown, "%u ?", reg);
+        snprintf(unknown, sizeof(unknown), "%u ?", reg);
         return unknown;
     }
 }
-- 
2.41.0


