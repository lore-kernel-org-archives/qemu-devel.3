Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAAFC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5kP-0000yf-0N; Fri, 28 Jun 2024 03:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kC-0000q5-CU
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:08 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kA-0004Zr-6K
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:03 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2eaea28868dso3274731fa.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558599; x=1720163399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t05HoVB9l7/y3jswyRpww8YiOUTnZmazAh4RttVAsxI=;
 b=bft+f3/rNWVof/h482ThKrPnXCwN1atrYGMxO/ML2UDjZ3XHcopv4mirm+zB6szMTk
 0Q4H5cTUm0dGeSCPBmS2D1SBBI0CFAjFi4vakcCSdHPSajUYYfxhGIn08LWbkDx6Vh6Y
 Rv5mzCMrmTu2gQI36f/jpge6mdytXDf3cUQpeeMQCNRFrn/rTdYXHx06a8HcP3p3XjaR
 L/NmloamhtXC19pre+wrawq8SRYU8G9NE5GlSh9qKjk+ZuGnazNdb0rYnOd+m5Mok+Go
 A6TtBqUcatJXuCxqkzRg+vHNt3MSQNfGCgNBaXKbKbs3oor5X1crz4Hi1iqb7xLihaco
 xzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558599; x=1720163399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t05HoVB9l7/y3jswyRpww8YiOUTnZmazAh4RttVAsxI=;
 b=KOpRIR7PRvIGQ05bM7JQJECli1QU5NF3h42a5sUhqkCj5FDRnYf24JYSsU7YRutQ8g
 Yt5lJU6X6CdGgjgX8mqdNOLqZp2sRfQvAAazu9l4d/fOuYXgsMWJ2lpLO1jRiQC6kXEU
 6NQm7cv0rv1a+5ztHmhzQGu0xkaBAWsKENttQJRB0YTrx/YM58p7SVhIw8GYLdgZEgoQ
 7mecZsCcrbSAwTuHijisAij16B4+m02bDexil4BrlF3evN9QGvUaMlPX7QkdxqbdrlO3
 t3dVHUjGUhjXJjzimtNS5ou/Ic5KAxAMgA17ITJNdxWvWXYRFYkZ5/wYyC6cG76bXubO
 bsbA==
X-Gm-Message-State: AOJu0YwEIwrL4WAdsH38o5aodt99Yh1kxE4+1GzFlIZp6ZmzCCd3rXy2
 zNkIuIfB4QzciMstIcAEoEk4LLlvvqBW/DihFLikddogsTiIGHe25GeBHiCPTh4TeBsFUMZ1ny9
 4KjY=
X-Google-Smtp-Source: AGHT+IHkB06HZddu5gtKA07sowY8jEL7SSsz7A4JWtO+h3CfiODl+y/J7Ui8JPdRRI7uUfiLF/OkBg==
X-Received: by 2002:a2e:a17a:0:b0:2ec:4093:ec7 with SMTP id
 38308e7fff4ca-2ec5b2e7238mr119455091fa.30.1719558599421; 
 Fri, 28 Jun 2024 00:09:59 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3c272sm22262955e9.8.2024.06.28.00.09.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:09:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 78/98] hw/sd/sdcard: Remove default case in read/write on
 DAT lines
Date: Fri, 28 Jun 2024 09:01:54 +0200
Message-ID: <20240628070216.92609-79-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

All read/write on DAT lines are explicitly handled.
Reaching this point would be a programming error:
replace by an assertion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0a7b422b2c..64621d4340 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1951,7 +1951,6 @@ int sd_do_command(SDState *sd, SDRequest *req,
         /* Valid command, we can update the 'state before command' bits.
          * (Do this now so they appear in r1 responses.)
          */
-        sd->current_cmd = req->cmd;
         sd->card_status = FIELD_DP32(sd->card_status, CSR,
                                      CURRENT_STATE, last_state);
     }
@@ -2016,6 +2015,8 @@ send_response:
     qemu_hexdump(stderr, "Response", response, rsplen);
 #endif
 
+    sd->current_cmd = rtype == sd_illegal ? 0 : req->cmd;
+
     return rsplen;
 }
 
@@ -2171,8 +2172,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown command\n", __func__);
-        break;
+        g_assert_not_reached();
     }
 }
 
@@ -2238,8 +2238,7 @@ uint8_t sd_read_byte(SDState *sd)
         break;
 
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown command\n", __func__);
-        return 0x00;
+        g_assert_not_reached();
     }
 
     return ret;
-- 
2.41.0


