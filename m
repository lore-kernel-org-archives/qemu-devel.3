Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B6ECCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQ2Y-0005pY-Fv; Mon, 10 Nov 2025 06:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1vIPi3-0002K3-Cw
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:05:22 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1vIPi1-0003hN-Bj
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:05:18 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-297d4a56f97so19527915ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762772716; x=1763377516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20o9Xst9XlcOWtdTfHw9EuIvq0wWeaEzw9AmUw6Jg9w=;
 b=cJOfF8AqVE6j0QKz2u1bGFXuWG/z0XsZGvIXvo+7stiBII4JDICzTeIuX/5R8bPMb9
 TmNrKbw14t0Q5veUWBSCHKCfTsvMNzDrYdSS8CR14Z9OIYtB28daVRZTpTNpBum+dITU
 GHsW2ebDu2ymWjQlOj3ZAwaXIlunqPW68tkTi9GcqTI8Asnz/6BTqiV+sg65yC1NIW1N
 kaDdVHlJiRKWO5Lw4j5VV4vGlaE1uFjQelADOYsEpOWbR4FUgt8w1O6hRj5aGPBbTmEJ
 mJTHKNU2S08oTiJ6xlCO/+0itnpzyC5miYq3vHWnCCShG+/m981BPQFBjiGlfDgZ/PAV
 kslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762772716; x=1763377516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=20o9Xst9XlcOWtdTfHw9EuIvq0wWeaEzw9AmUw6Jg9w=;
 b=EQzKGvzFgx4+0hpdrjOLb+g2dTXtFtlhHjmG6NeioBuuhBB1z9JRHStweRC49eoQsL
 GIX3GmhEg7wyWfLJN8cGRIT42/zs2Spg2jXhL+X8Z5burplLvdejyMPqwrDzwFngzkK2
 DZT8dpUrP4+7ll18ZGIV8Rwvcd2xtaFmatum4SI/aDlmQYoibegEXfz30XbBW34WY4TL
 JZTsFxLLDta4VEagl89GvXRJeDb2lrfrsMQSh4ppGh3pVipHNZoAtppo2o7ntuXrf3Qv
 gNO6q8FUGDSs2g/vERBzgK0U/hcJloED80z/oX4c8DyE1J/u6OKe7PF085c7pTjQ4xuD
 KouA==
X-Gm-Message-State: AOJu0Ywioy2nOq2uNIDu92ulQ27W41ve13hyXny8QXJIlfR0lyc7O+vT
 rwk0KNbMDWuUvHRzv7+b9WP6B91nL5K101z9u2VOqnz1R6u0kiOWy2Wp/q8hZfP/qcM=
X-Gm-Gg: ASbGnctUxSybtvzIDTf9QiktYjzPS6xeScmVvD0riOFkJzvXL+awiYD7yH3otW58+Pz
 95PenCWHhKqTMAtBxZ4GqC8gkk2y+Dz6sah0LS+440TF74LN33W4nttvbuvAea8t4NiSHnpw43v
 odxTzcxYHWQkRQYBwdpMILWa9iTD/Zdbpr1+nSGZq3qzBVzRsFhx0dp4WrAhzkdzkmH1iCbyUCW
 hCHAaQu9KJ/hYqn5bRk0zqyjjT3h+N7hVGbgkX8jv8h/q7DKm5Rb0s4hCGrh1A0vkfxJZMs6xaQ
 /I/Jwycii7l1jQaf1pUQcm/Ucdiz4ZGgvQ+NmFqhUNYicsK8fi6qSW9eKMU4p1xC50/gBjUCG7K
 e43ts0ec99bMftwBvwx/4HFnSPawlSdYd5IUd0Vt5N++mH6dQbD7quWsBwhZWf4PpaxgY8VA=
X-Google-Smtp-Source: AGHT+IHaYR8vbceRo5WmnHK2jM/sWc7chrh8xZH3UA+HvXG97kRMw+SLjgRlnUYq8OvxlWtZaSLfWA==
X-Received: by 2002:a17:902:ec90:b0:295:560a:e474 with SMTP id
 d9443c01a7336-297e56c9f49mr106692215ad.32.1762772715568; 
 Mon, 10 Nov 2025 03:05:15 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651ca1b8csm145706605ad.85.2025.11.10.03.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 03:05:15 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] hw/sd: Fix ACMD41 state machine in SPI mode
Date: Mon, 10 Nov 2025 19:05:07 +0800
Message-Id: <20251110110507.1641042-3-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110110507.1641042-1-bmeng.cn@gmail.com>
References: <20251110110507.1641042-1-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x636.google.com
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

In SPI mode, the ACMD41 argument only defines bit 30 (HCS); all other
bits are reserved. The current implementation incorrectly checks the
voltage window bits even in SPI mode, preventing the state machine
from transitioning to the READY state. As a result, the U-Boot
mmc-spi driver falls into an endless CMD55/ACMD41 loop.

Fixes: 3241a61a ("hw/sd/sdcard: Use complete SEND_OP_COND implementation in SPI mode")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2945
Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

 hw/sd/sd.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5aae541363..11c3a64080 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2289,20 +2289,21 @@ static sd_rsp_type_t sd_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
         }
     }
 
-    if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {
-        /*
-         * We accept any voltage.  10000 V is nothing.
-         *
-         * Once we're powered up, we advance straight to ready state
-         * unless it's an enquiry ACMD41 (bits 23:0 == 0).
-         */
-        sd->state = sd_ready_state;
-    }
-
     if (sd_is_spi(sd)) {
+        sd->state = sd_ready_state;
         return sd_r1;
+    } else {
+        if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {
+            /*
+            * We accept any voltage.  10000 V is nothing.
+            *
+            * Once we're powered up, we advance straight to ready state
+            * unless it's an enquiry ACMD41 (bits 23:0 == 0).
+            */
+            sd->state = sd_ready_state;
+        }
+        return sd_r3;
     }
-    return sd_r3;
 }
 
 /* ACMD42 */
-- 
2.34.1


