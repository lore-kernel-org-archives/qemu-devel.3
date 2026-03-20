Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4781098784
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYZ-0002yt-VU; Fri, 20 Mar 2026 09:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYV-0002v2-CE
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:23 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYS-000635-MA
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:23 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-667acaeae82so2864660a12.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011979; x=1774616779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HI5bsg6gI1dq5e33RiLLzAmqut1VQt7v+7lGbNwBtkY=;
 b=omSix8FM5u5OljAKjZ+/eBcp7139xPoGWbSvAI91L4KOeINbVvDWMTMHQnTu7XOOhg
 CVrdrxef9nybu7mVTqqhQ/pQblv/48omJo7qVa16zlGXIUF++zk+qEdA5ebxJCXJoxtT
 M5etfFmt8qgJcTURwehq+IpQRPG4zzRkiXG0GR+QBiSUWZ2libR1gx0HEVIyUxY26lek
 tGOxnxAb+gWZCHgGu/DTR1MAPA6FC2gkIVN6HVqI2ZJxqvWDgWUws9/gbATJQ68rr0Hq
 NRX7qGXUpGhgqlmTtQXQqqJIO3QxTtMMZNF88WbyG2GW4AesIloD4xTLwskGc0tAybdj
 ziWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011979; x=1774616779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HI5bsg6gI1dq5e33RiLLzAmqut1VQt7v+7lGbNwBtkY=;
 b=tNP0BvJLaHnAZCqNi1P46hihSjUh1Cgo+8UrcOAT/Gjhr/qoPKH91N+W6gY7ykqUXY
 JiS6F8y1/0LEpOGfUqX4kUGDO6c4nVzIcAWI3liQuXkIezLCcAEQyntx2CwPbbJed0vX
 9edncyHO25HdzwBx2Mz3Zx3IA0tpE+CTcipFv67ekDKt+YcBtw4gyD/bFV7uH/mrJq1f
 udPRxKZfClIju7qSxkwTQKhz8uOOgt+DYX5Ril6POixK8skZ7JNLVMKB6YdGOgLFbvDN
 XGugFyuy5Gc1d0dYQdfZsFjblbmVf8dNtTDKPHZt4jf02iCcpoFJXPz5VP9uhQeZLit5
 peYw==
X-Gm-Message-State: AOJu0YzLEALWIOcYpGjCb+lPK+iuHO8/lvXhUJwbKbOI92wYcLZ4RwPQ
 o9dWRKv3mSrbUsSxQd0miPKzOVPONlbxC9aCxBfX7ZCyd4kQtM9cyiS9KsfVJZbhSi7snJ2JAf5
 c6S9kjKk=
X-Gm-Gg: ATEYQzwRzQsrPnTcfZ0IFP+aPa2dCZc6r3fpqQxWGr0fY/jyuWdP0MpFo1wXxr218ZY
 XQe6oW9B1Y8DKSLWVtyoCrfZGwP+BgZzGUXe5Li4pHy9IDM3Rr/slMde6vqtNTuTKf8YVJOzLzM
 hVW0Wc21VKSTkb0OZamCQ1uIhnh+HHZlZgAVav/j0Kj+DBK9ayozvvSLyQBYVRBTWlmKTGAk43b
 P1/k1qjAkXR+ZF/Br+x2gY4qHV8A1YrHnmThM+3rveO3Qj3msP+a7BEIAxSlzQGpqzujiyNFHKT
 YzYKW1zViMJaOCZcvfjmbnpp5mKzQ2lstCmN0NYtoTIS4qaOSdPpn1lPgKg0KEXBlY1bnLL36av
 7LUUcsuEc5ukReIsQCyArl3erjiXjmK5UFRujx39dzHrFjE6lZ3oRvTEvTx21CiEa3zWBFsN2Oj
 PgAbdIJMh6FhD5uAYtgySt5Gbmhxw3Br2lkQ==
X-Received: by 2002:a05:6402:358f:b0:668:599e:103a with SMTP id
 4fb4d7f45d1cf-668c91005famr2219464a12.8.1774011978920; 
 Fri, 20 Mar 2026 06:06:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-668d1cc5f1dsm1356965a12.14.2026.03.20.06.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A65445F954;
 Fri, 20 Mar 2026 13:06:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 13/35] target/arm: migrate gcs syndromes to registerfields
Date: Fri, 20 Mar 2026 13:05:44 +0000
Message-ID: <20260320130607.2071996-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Added a little comment to explain the RADDR<->ra mismatch.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 503b19b5d02..76f66b3beef 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -690,21 +690,49 @@ static inline uint32_t syn_pcalignment(void)
     return res;
 }
 
+/*
+ * ISS encoding for a GCS exception
+ *
+ * Field validity depends on EXTYPE
+ */
+FIELD(GCS_ISS, IT, 0, 5)
+FIELD(GCS_ISS, RN, 5, 5) /* only for non EXLOCK exceptions */
+FIELD(GCS_ISS, RADDR, 10, 5) /* only for GCSSTR/GCSSTTR traps */
+FIELD(GCS_ISS, EXTYPE, 20, 4)
+
 static inline uint32_t syn_gcs_data_check(GCSInstructionType it, int rn)
 {
-    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-            (GCS_ET_DataCheck << 20) | (rn << 5) | it);
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_DataCheck);
+    res = FIELD_DP32(res, GCS_ISS, RN, rn);
+    res = FIELD_DP32(res, GCS_ISS, IT, it);
+
+    return res;
 }
 
 static inline uint32_t syn_gcs_exlock(void)
 {
-    return (EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL | (GCS_ET_EXLOCK << 20);
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_EXLOCK);
+
+    return res;
 }
 
 static inline uint32_t syn_gcs_gcsstr(int ra, int rn)
 {
-    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-            (GCS_ET_GCSSTR_GCSSTTR << 20) | (ra << 10) | (rn << 5));
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_GCSSTR_GCSSTTR);
+    /* when ExType == 0b0010 RADDR is the data register */
+    res = FIELD_DP32(res, GCS_ISS, RADDR, ra);
+    res = FIELD_DP32(res, GCS_ISS, RN, rn);
+
+    return res;
 }
 
 static inline uint32_t syn_serror(uint32_t extra)
-- 
2.47.3


