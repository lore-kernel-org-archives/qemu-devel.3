Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2441CE8D44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJvi4-0003Rq-1F; Fri, 14 Nov 2025 10:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvc1-0006JJ-Nb
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:21 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvbz-0003uB-Fr
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:21 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42b3c965cc4so1090805f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763133678; x=1763738478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j6qK/mmIQX6+RgydV4dqdyOl5CiG+CIqgaya71mNSPI=;
 b=WZul3Xp/jex9Dge0uVIAUULYZ1rC98oAKMS0ImLyyV/jeV3MQzOSV/XIk6JLBIXBus
 QSDM06pGIEKkYBddQ82esvLFXQ384ZEP7AJCAB62lwolNiuFlvjO6LiQdMk2tSchlLuB
 H/8nl1NvQ0LXGxYI3fl6bzdkrRWkG8HzevRYSF89xfw0o3x0mKOzH0lIS+/7/xQgWQaC
 w/Wum5m1Kl/TJGOFZ5eUajRdNR5tQlSgcO2kcq7WI2r2m++s7+E/dKFsFTS4Xkbd96Yv
 lLAsfxTGVhhgpFkgLL9d0LAqeeG+255gH7NM4lURgNAaa6BQ9vCpTjP9f6kGJNUFa91M
 8qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763133678; x=1763738478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j6qK/mmIQX6+RgydV4dqdyOl5CiG+CIqgaya71mNSPI=;
 b=CUVlqMuWG9v8ewXTXw1rAxgSCfHD0ZD9Cq/wdujRkRHMS/vJ7j/CW9K4DI9gQ6oSdj
 MYE+aRsq9hvl6RNTYo58FKKvpqcxNJd0LWe+ctCcbPuikvUKx+f7enfNtXgcp2utWQKg
 Q1m93yD8ECjeh0dn6fPO/OYQ+Rc6N+VECd9Vwb2C59hA4N4fSrAHxwan1lqSKlEEKLdZ
 aEY1bR5WKbiak31ccHnTkddeZ+9ClRW1zEqvz9VrKdQ+jz7xz5607t1o/dJXzICX9L8t
 SJf8JT9Mj2jXrn1ZabKJKEHNG/qvmOdS8V3FShfxVXu+MvsLKhtgLO6EfXtHOsQoNVaU
 x7/g==
X-Gm-Message-State: AOJu0YyP+K1CPDANidNpMlH/R+gDSx6FfycU/X/aecAiU2x3krLkbCYB
 xXtNBxYhHV13mRKXP9Lgszz3ASc+uzQMDWo8XzsojsNf24qhqJICwMfxVNUk1h22sersqoKDCTi
 mNzXV
X-Gm-Gg: ASbGncsGvrkmQrnjV5kUKLcUZZ9qwq1wiGz/XFRQNhhHF8ObL9/64cKtuDG12LQpRsz
 uMC2zMGyQpowlLF0Uu2/f7azKtPZrhV7eqFTMeVdedlFmbP6SfapBk8zH/aWfdeOHhzdkFrN4pQ
 JtCSKC0JmwwFSboTx+I1wFEIcy0GXIFQ/flLnUV6YRuxG+ZwyATHOshTi7sSgPFJKDFmOnB9EOq
 D6CkvihQAfI4YVxErQdEgMhvHeid5ckoaIVeMXQ0S2jVSimcGXFcnrxjqxu8T+cCuwXagV+xSlQ
 SHzVrEguhcsKy3i/n8SX8aJEXZqNGrwJ6mjll143zVdv1gaZE29FZES9/xQXgJDkWVO6jl1JZr4
 ZlXDNlsF6qE7mapn/VU+ku3HiQplkUf3uv4QgXVPqmY8WMWz9C6t9Pzra8ZhtnY5BlluBkqfdHp
 +9b9hIVuxUdFLhMv1w
X-Google-Smtp-Source: AGHT+IGFYRflc75+1KqyKfqzbFvi6neQ7M+J5c0O/pe+Axxxoxu7WN6K2FrWWpsUL4k608QGP1/JqA==
X-Received: by 2002:a05:6000:24c4:b0:42b:3aa8:ff9f with SMTP id
 ffacd0b85a97d-42b52844e6dmr7906441f8f.28.1763133677869; 
 Fri, 14 Nov 2025 07:21:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e798sm146772835e9.10.2025.11.14.07.21.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:21:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/10] hw/display/xlnx_dp: Don't abort for unsupported graphics
 formats
Date: Fri, 14 Nov 2025 15:21:05 +0000
Message-ID: <20251114152110.2547285-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114152110.2547285-1-peter.maydell@linaro.org>
References: <20251114152110.2547285-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

If the guest writes an invalid or unsupported value to the
AV_BUF_FORMAT register, currently we abort().  Instead, log this as
either a guest error or an unimplemented error and continue.

The existing code treats DP_NL_VID_CB_Y0_CR_Y1 as x8b8g8r8
via a "case 0" that does not use the enum constant name for some
reason; we leave that alone beyond adding a comment about the
weird code.

Documentation of this register seems to be at:
https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/AV_BUF_FORMAT-DISPLAY_PORT-Register

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1415
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251106145209.1083998-3-peter.maydell@linaro.org
---
 hw/display/xlnx_dp.c | 55 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index c2bf692e7b1..a248b943a5a 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -665,14 +665,28 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s)
     case DP_GRAPHIC_BGR888:
         s->g_plane.format = PIXMAN_b8g8r8;
         break;
+    case DP_GRAPHIC_RGBA5551:
+    case DP_GRAPHIC_RGBA4444:
+    case DP_GRAPHIC_8BPP:
+    case DP_GRAPHIC_4BPP:
+    case DP_GRAPHIC_2BPP:
+    case DP_GRAPHIC_1BPP:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented graphic format %u",
+                      __func__,
+                      s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
+        s->g_plane.format = PIXMAN_r8g8b8a8;
+        break;
     default:
-        error_report("%s: unsupported graphic format %u", __func__,
-                     s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
-        abort();
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid graphic format %u",
+                      __func__,
+                      s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
+        s->g_plane.format = PIXMAN_r8g8b8a8;
+        break;
     }
 
     switch (s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK) {
     case 0:
+        /* This is DP_NL_VID_CB_Y0_CR_Y1 ??? */
         s->v_plane.format = PIXMAN_x8b8g8r8;
         break;
     case DP_NL_VID_Y0_CB_Y1_CR:
@@ -681,10 +695,39 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s)
     case DP_NL_VID_RGBA8880:
         s->v_plane.format = PIXMAN_x8b8g8r8;
         break;
+    case DP_NL_VID_CR_Y0_CB_Y1:
+    case DP_NL_VID_Y0_CR_Y1_CB:
+    case DP_NL_VID_YV16:
+    case DP_NL_VID_YV24:
+    case DP_NL_VID_YV16CL:
+    case DP_NL_VID_MONO:
+    case DP_NL_VID_YV16CL2:
+    case DP_NL_VID_YUV444:
+    case DP_NL_VID_RGB888:
+    case DP_NL_VID_RGB888_10BPC:
+    case DP_NL_VID_YUV444_10BPC:
+    case DP_NL_VID_YV16CL2_10BPC:
+    case DP_NL_VID_YV16CL_10BPC:
+    case DP_NL_VID_YV16_10BPC:
+    case DP_NL_VID_YV24_10BPC:
+    case DP_NL_VID_Y_ONLY_10BPC:
+    case DP_NL_VID_YV16_420:
+    case DP_NL_VID_YV16CL_420:
+    case DP_NL_VID_YV16CL2_420:
+    case DP_NL_VID_YV16_420_10BPC:
+    case DP_NL_VID_YV16CL_420_10BPC:
+    case DP_NL_VID_YV16CL2_420_10BPC:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented video format %u",
+                      __func__,
+                      s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
+        s->v_plane.format = PIXMAN_x8b8g8r8;
+        break;
     default:
-        error_report("%s: unsupported video format %u", __func__,
-                     s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
-        abort();
+        qemu_log_mask(LOG_UNIMP, "%s: invalid video format %u",
+                      __func__,
+                      s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
+        s->v_plane.format = PIXMAN_x8b8g8r8;
+        break;
     }
 
     xlnx_dp_recreate_surface(s);
-- 
2.43.0


