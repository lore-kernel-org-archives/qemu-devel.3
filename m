Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BB0CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 14:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH1LY-0006IU-6D; Thu, 06 Nov 2025 09:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vH1LW-0006H4-B4
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 09:52:18 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vH1LU-0006cR-9i
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 09:52:18 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso11972665e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 06:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762440734; x=1763045534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8LEQa3iHwl6VkcSjXzC6iUo2ZyZOmvujJ07KAZdpWU=;
 b=Cm2Png//krYoLlDG6HWXUKxNCFfa8BMyaz7FodNVUAep35JpArI7bZQ6lnSwVnzBo9
 bj5jo5apd+7OML2ax4SeHbvv97G4BP4wHZaqr/SCsv4FmBTTZw5gLJ1hurxFUaa1czkS
 BwOJaHqQ0iu2jv+wrK4JWnns2Y56H5/B8dlooaVcGOhvHuFwRO38VoX++eUyDVYCbXGR
 XztmeA95fS2uxPcF27qrskhIuIHFMf/GpYnUDPiL4MtA97JOWzo3Mn624arpvM2PUldk
 QCl3MBazgOxaFLLdEcbD63DFcVh182uuxIypw4aVLseM4jLr1rOngvv5qC3TkeWqbA/S
 hotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762440734; x=1763045534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d8LEQa3iHwl6VkcSjXzC6iUo2ZyZOmvujJ07KAZdpWU=;
 b=DQfY19JTQRwJuJYR+u0R2FP3WYrr1uvt0VEyYpWE5PSBDODFQjPeTFabgjWN+vd6xN
 x4b5rzeB2AyX4DKMPE2X1DBBYjnOjnB8PT75Y9u1sNnf3rnYW8ClGStoOU48KRnBQvSw
 0ONpFpGjqZIIP6YbC4Aqs4QABhhd0V4CzXhrtv+8f7tUF8mR/Mf9MMHLzzlvBZk/Pxj1
 C923SxYCHEECa7mpSEKQe4pHuLiNPyEKOahoxEs1AMByJd8sNysR64Z9hS3D7tq4Rigo
 5jRIW961YG3rYuifadaxgv+G+NBeJl1riJbaZVG7FMsfBdt+PnS6aZBdFD3sY3/R3CQb
 h/2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjU5UpWpDwA9JhYc8wuQLURe05aPcREXSw2UkznrsQlwJ4w8/BytqnZR2Ah6Ok2ZRpcaeLeg9L1kGj@nongnu.org
X-Gm-Message-State: AOJu0YwtXprft+52TKrrkf26Qe0nKbZAfgAmtJr2GcQIclaWsMUbHP9V
 9iKmyz7APQB+mtFzFH7n4uUHo8OJJEXQhQU0HwQkZS3uLNQPIVCUn/gAv6hqIlNM4bkJ77I6TBr
 Wo0E/
X-Gm-Gg: ASbGncuwjCArO7VEiFiyTNM7Td7Uu/UIpYzRcR0fEPecqar6/GU8PTuLlwa/2rOp1De
 w9yolN+JOT3W1GX44mUuQglhfygW51TS0HLVXISuj5nl5P3AwI5eaV4ByZidCpkh5KQJEEJBQWW
 K54SfLKcOgDvYHsxnk9b/GDmZawQHqcg9yMtYaRxr1j+6KjOdoBoGncStcv5LwFFcMdijs7Bdd6
 +4v1Jf5i2KsP3BhssAXzYVcIphpuSC3mAoJIhGpIxfnM5I2QGVYdlrEeD2qsehKuQ61yiy1SyqE
 i0SQ236wHtRbtkPa7hfhhulSgBjjbGylq4SM5oWN4idZ8SDU3IIqo0O0qRDgZtOovysmLSC+nqb
 gWDXC0FFNcE/ktYGt8gChIHUa1cO6xwDzvTggVeoAdZtYto/cR8RDLzJVmfUSzmEhqMcraC9qUn
 xGKDrdMA==
X-Google-Smtp-Source: AGHT+IEjDOISWhs+InErwAH2OMzaU3heIKhAFrinZg+2uRf6LjUO7D0k2834+/JShZRQRTb1rRoAHg==
X-Received: by 2002:a05:600c:450e:b0:46e:394b:49b7 with SMTP id
 5b1f17b1804b1-4775ce26f5cmr62456945e9.37.1762440734500; 
 Thu, 06 Nov 2025 06:52:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb47721bsm5694891f8f.25.2025.11.06.06.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 06:52:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 2/2] hw/display/xlnx_dp: Don't abort for unsupported graphics
 formats
Date: Thu,  6 Nov 2025 14:52:09 +0000
Message-ID: <20251106145209.1083998-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106145209.1083998-1-peter.maydell@linaro.org>
References: <20251106145209.1083998-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
---
 hw/display/xlnx_dp.c | 53 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index c2bf692e7b1..d8119a56292 100644
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
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid graphic format %u",
+                      __func__,
+                      s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
+        s->g_plane.format = PIXMAN_r8g8b8a8;
         abort();
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


