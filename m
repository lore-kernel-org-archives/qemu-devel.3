Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25796E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwq-0001iw-Lt; Sun, 15 Dec 2024 14:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwm-0001bx-0a
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:32 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwk-0001HM-Ae
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:31 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3eba0f09c3aso971351b6e.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289589; x=1734894389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUWs487i1AsoAZAXsWndCvFPp5W8PVatVy6EB92egpU=;
 b=ikVD3swCOWjwojdsy7+s5V6A2wVDgtLC8l35sKzF2vLga1nnJpCwFJ5QFM1DcZFfYs
 Iio8kSPuSDx71QD3U2bpxnFiUAcOig93mHIkMc9SXP1PpZn7gPw+90+2MpKDy7Rj/J6k
 ZdmV3Oo6k5n1ZFeEjE4aLzM5Udz4fssG490hdKHJT70Cnd/LrKU1uytQEWl471sTXTOB
 s2+WoEXHU41KU1WCJLwF1r2MOCa8oSoGFdkGzPDMWGcy8iNrhJW+nlI9R/VcZ0eRaNIX
 59jTbY0p06eT6O5zCQHf3JC8kcDBe2F/eRts4wd36KBtMaOWS3oqVKfZq1vm60Uh2kIO
 fZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289589; x=1734894389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUWs487i1AsoAZAXsWndCvFPp5W8PVatVy6EB92egpU=;
 b=uhgW6CDnKJvFAippZ330lsdJT8rcYrad/GicH2x1ceoAr3NMMXxta9lrhdKX1r8s8j
 XHmUpRnyx5hwVaHa9MIl04oBjOPbqxNpF77it7yIsZwMT5eZwHROSgG61e/g3CIK3xJ4
 2yCGSFtReTEBdN+A+Y86tcylW5jR9lKym5PwZJzK3zWbFmtL5MCRcinCKVJGX8fLEfA3
 mA20btq95cQioSX8I+v9mTS0Y8hQJU7JNC5qwub4qCjjr3Lr+CNson60ArRHrokOxWHF
 EBhs2ZLh6J8PK1Fqhh1BJFspicO47P3+j/tJBpD2fpB8hwtqOj/LdHmCZkeRpHRNQWcu
 ujyQ==
X-Gm-Message-State: AOJu0YwG5oat9Bb8LwglPc/JRnLAllcMUvyMx4lGjywFE64pPg1uA+7Y
 nekaGpsX/lxZZweRFsd3UtNS9TUuXzt3ntBi4W/sEZhfWysj2gmCd5sm3OKsZSW/MReuoI6yR9e
 aQ3+umQn4
X-Gm-Gg: ASbGnctHIMOi2+cpMZALbfRCsDgb4N1bInyt7lkCPtv7SrJbB2HcsJQUjjdp8c+TCs1
 Qio4YQsB4Os55hpDa+LQUYwDOrtBes6W/Q5z6RYSLeFDUYr1sOH67ybYxvFbFGmSL3w0e6WDWUg
 vQK4+qHWrW8FvZOvV+00QOyN1lM1GGUOpM4PGCa0rZEkiV/FpfqR/QqcOCUICxO0DivIKPfE3/o
 SWRw8N7Fj6C+FpUovgHesxvM1GM2yCG/8ZbqeLkU5kNfht7yQlNpn1bmeGShhFcsXwWBKey6nZ4
 8KRhcFt7VQqMWgQOV9H5NzbK0Myfz2lPPMTAWcKoH0s=
X-Google-Smtp-Source: AGHT+IFTW8F33dbe8A2pkkrH62aDRWrTUnM6O4tZZCFjbobhHYUkDmPNusDsZoaRrXnBy/MIbCeswQ==
X-Received: by 2002:a05:6870:9713:b0:29e:6bdb:e362 with SMTP id
 586e51a60fabf-2a3ac5ee1b4mr4474334fac.17.1734289589015; 
 Sun, 15 Dec 2024 11:06:29 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/67] hw/mips: Constify all Property
Date: Sun, 15 Dec 2024 13:05:03 -0600
Message-ID: <20241215190533.3222854-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/mips/cps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 13046628cd..1a2208666c 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -166,7 +166,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr), 0));
 }
 
-static Property mips_cps_properties[] = {
+static const Property mips_cps_properties[] = {
     DEFINE_PROP_UINT32("num-vp", MIPSCPSState, num_vp, 1),
     DEFINE_PROP_UINT32("num-irq", MIPSCPSState, num_irq, 256),
     DEFINE_PROP_STRING("cpu-type", MIPSCPSState, cpu_type),
-- 
2.43.0


