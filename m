Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4D0CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298t-0007th-Ov; Fri, 26 Sep 2025 10:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298T-0007KL-VX
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298E-0005f1-Am
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:21 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e414f90ceso4802285e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895738; x=1759500538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N4ZfhBUIPLSIJELQ+q97VJqf+RX7DXJlqzbKKdi+6D4=;
 b=Q5WJnyk4uMDG3gtLUI0JxkKLfoIA9Yh5RTC1LFSABDis3f2wERZBYGNwBq5M7kqn7u
 eO2Fx/ZaxWp/SvOU0oRqr5RAS/RIcXhYM5ip8So6u7PFw+BFIoL6ByQHc2O32cMx3R5n
 LEo2P640c/gR2E1zSKkrbsLpH23RpCvRv9kJrrdsUd9iowDPzf6baNbXyZJweO2b/hd7
 u7JBMG5mN0A2JJFu2KmemsSK1pl3pJTAxoCyrf0CNOQJPN5aTuFkoY8xzQvzzESCN1MY
 YzClbjyshNSyPkILlq22bMSr1eTIhQ6ES8yVNUQvQQRXGn1gm30v3V2CPKo29snY1Oz7
 rJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895738; x=1759500538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4ZfhBUIPLSIJELQ+q97VJqf+RX7DXJlqzbKKdi+6D4=;
 b=bnMCGkrrrftrWCVDRBhTpYvpsFmYp/XleL4IzqNUJv060swdMSkFdy6hN9zViouEY9
 6KsqWk1B3DNN416i+H9to05nLcdMBuc1MifY6HYMN6lRQY7MO0OkAAaSjcaIXzi+bipV
 S603RTabSzFZQqRdnIDkMtC2S6FFwB9f4FlH+rhoKwapwh8U91l1YR2HWJ3DquyAEfJd
 zF+riJB5GX7yseLvFmiDgTOvD8tFXO0E/FaB1YUdajAMmq6MFii2SksX10+uzEpiLXq+
 E8qcCmuYHNdEP9Wddm3MKa7H4OwKZGkaQoIwX+qB4QPxBpo9WJ6N/H760JYL9TGs9nih
 up7Q==
X-Gm-Message-State: AOJu0Yxg/ELsK4e7A/vK/x78eyxzqTnF7eCz+7g/R6f5pnB4FTLoq6EG
 K+TFDSbM/cxQuWJ991bMQ1ueI/9NBuNM8IXcViJytDJ11BGmMvu6TEgPNzcKysmDa/ntzS6qlyM
 lS63h
X-Gm-Gg: ASbGncuSiHSz8sd8yDY9M8Mr0od1PjXNcCzqEz0hKIoZRQIiqGMnG9fGS7qphsyK6Ni
 GXFHiAHmpX268xQDiO7by3kb40RoV8xr0uNPbyVf1ODyGmI+5Z1536URvNWqNu51iTgZ8k+qVuc
 TZeTdMrI9ZaWWo7XWtXhuDnclc9P/dWXHfOlIIjeftgwPhsim3GFP3tm/02mj+6oiGS19onnBO8
 wLs+f/cKh7CVH4lYfj+Ic6NvClHOtu8IxhMsusbyy0Rlv7/ap4P0D4SDMZBJ0oyFSkBGX/CPHl1
 Fh+i7Iv8c45rEGvb2PtU3C03WuUgFkASLpKnWbMBBiyB9GxVOGllF23loteP5+7TkzT/Wgm6yjw
 Snqp8/avjEThaUCEKzOlBd5rjbX87
X-Google-Smtp-Source: AGHT+IEe6MTp+lrHL34N62sJ5CYEebmLwasOrj4vHHBELxWo7esdHuDCPKszHCk6rVohTFYQqlnV/w==
X-Received: by 2002:a05:6000:288d:b0:3d1:61f0:d26c with SMTP id
 ffacd0b85a97d-40e4abd7c93mr7112487f8f.54.1758895738175; 
 Fri, 26 Sep 2025 07:08:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.08.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/44] target/arm/hvf: Use raw_read, raw_write to access
Date: Fri, 26 Sep 2025 15:08:11 +0100
Message-ID: <20250926140844.1493020-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reduce the places that know about field types by 2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 99d8672b9bc..694584cc130 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1153,7 +1153,7 @@ static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
         } else if (ri->readfn) {
             *val = ri->readfn(env, ri);
         } else {
-            *val = CPREG_FIELD64(env, ri);
+            *val = raw_read(env, ri);
         }
         trace_hvf_vgic_read(ri->name, *val);
         return true;
@@ -1435,7 +1435,7 @@ static bool hvf_sysreg_write_cp(CPUState *cpu, uint32_t reg, uint64_t val)
         if (ri->writefn) {
             ri->writefn(env, ri, val);
         } else {
-            CPREG_FIELD64(env, ri) = val;
+            raw_write(env, ri, val);
         }
 
         trace_hvf_vgic_write(ri->name, val);
-- 
2.43.0


