Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B746F1098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYS-0002sP-OT; Fri, 20 Mar 2026 09:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYQ-0002pz-IH
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:18 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYO-00060H-7R
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:18 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-664f8bef4e7so2758920a12.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011974; x=1774616774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7IMorunvZEgUBqMMO2t6X3hXoPF7SbGEFrN2VHLAQ4=;
 b=uVcdnSZOTw/F1qilb4lZ0HYmxMnVSabZu179eaFs/3KaYJio6PKC5y4cPAs13X14/v
 xGL111zXCsxtUk5riqXX3H4WLffX2T1gPPgi6Gpe3bFS7/Ks21T1HvtdRN0oQzyIMEds
 6grNZ7KK+VrjIV2AJo+QQASg28EJ5dbMVOMd733oTkCJLMsAr1BxzZNMdaUKvWkYi1Ch
 HeoCiEEoVZEaEkzWAYQwKVEfA0X/3P1hlPr4F3hAyerXIMuG4Ko5BG/O1rytNIFUt85h
 nIamvR24/wRfz4eUKJjFgjZLujHw/JipK3TSkv+fxvG7XYtl9mvleQ8P0UJwOjNtGkAY
 aQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011974; x=1774616774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H7IMorunvZEgUBqMMO2t6X3hXoPF7SbGEFrN2VHLAQ4=;
 b=TSljoiW6KCeGG+BzyKNy/pXkqln+YnXK3DVA/yf5AMuyVe4Pf2hZ+fzgcegeDUxadk
 2rcwgeaDaGnmszrcwKgtlaLHDq2FrhbdtQVQ/jnBjQ/OTPg5lVhGG8D69bDuRerCZhAf
 NfK5XJgOi3sSAj0h1hP3pSJFpGyT9nBDRitwBq4kUF1j3bPoVUFzeBtOwfCpJdJyQ0L3
 FfRE3obcnyKlTb5/on6nGe5/sMUJAJB1ZaC6vM6VlgOaOcnrQiRPAh/8NjsLYG4+av3n
 4RC8GvgCVvmNBgbONN0O6Q5TTarlPcbrbUaZ56AQp0/yT3MSXlNVwNatj6/oVnD7CoGC
 tkGg==
X-Gm-Message-State: AOJu0YzWD9G4YVcMdoq6j/j4SGSzZzNNPGUaovC41UNJYT38hw8QoHNx
 0Mss6PY8XVsxu5sYhdaosDarvV5P49/f79/aDfKUxxg4SRiStMKvafyWOojggSp5MCE=
X-Gm-Gg: ATEYQzwIB3cn5gU6TCEwE13L8bErsqWPY0xEqjAGc/3tcLzPvO3CIbftMUd7F6A6IX6
 66lFsp4jRKoKwsWhieafpk+MEFjf0Z5ZnUFSHPkKncIvqtlMfPRrZXFPxPXJ0pVagTopmWQ+HGD
 ZnB8Ghy9hJ/1izNlos7jN2SM0Q1RnnmAas0XJLpRAO3f47qO7N53KDPaNpbNlEKjGKDCu3RXXiJ
 k+hwIvm1lg1vZbb6LFun2En9aDMzF4iHClrbb1sbtQ40Nkecx1fGJLC59YuPfsbv0g5fvEpgdU4
 zwudPAH6KwdmPNctyT5Eq3bz34rnKjCNRWZzd74U/Dc4IEvv2gMl7UCLsAK8qYbCzsDKaLGYv+7
 64AgIXlIFxvnO5w8Q0ArXWf1i5G0KjT/3mUjNgce/CBVUlhy9r6uJ5h1ZkFrKNxbb3WNnhdpK3r
 oWHRCSTfeVS8r6USgx7KDMgl8=
X-Received: by 2002:a17:907:170c:b0:b97:9139:738 with SMTP id
 a640c23a62f3a-b982f2f0c72mr174716466b.33.1774011974166; 
 Fri, 20 Mar 2026 06:06:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b98336675e1sm154348266b.51.2026.03.20.06.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2DE255F946;
 Fri, 20 Mar 2026 13:06:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 08/35] target/arm: migrate BXJ trap syndromes to
 registerfields
Date: Fri, 20 Mar 2026 13:05:39 +0000
Message-ID: <20260320130607.2071996-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

This is an Armv7 specific syndrome for chips with Jazelle
functionality.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 0520e51a686..fb86e7bf6a8 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -440,10 +440,26 @@ static inline uint32_t syn_btitrap(int btype)
     return res;
 }
 
+/*
+ * ISS encoding for trapped BXJ execution
+ *
+ * This is an Armv7 encoding.
+ */
+FIELD(BXJ_ISS, RM, 0, 4)
+/* bits 4:19 are Reserved, UNK/SBZP */
+FIELD(BXJ_ISS, COND, 20, 4)
+FIELD(BXJ_ISS, CV, 24, 1)
+
 static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
 {
-    return (EC_BXJTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-        (cv << 24) | (cond << 20) | rm;
+    uint32_t res = syn_set_ec(0, EC_BXJTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, BXJ_ISS, CV, cv);
+    res = FIELD_DP32(res, BXJ_ISS, COND, cond);
+    res = FIELD_DP32(res, BXJ_ISS, RM, rm);
+
+    return res;
 }
 
 static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
-- 
2.47.3


