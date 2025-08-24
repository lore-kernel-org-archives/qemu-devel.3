Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C1ACA0FEB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 22:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqJBr-00062e-3l; Sun, 24 Aug 2025 18:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqJBl-000623-SD
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 18:27:50 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqJBi-00069a-Uv
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 18:27:49 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-55f4345cfd3so491598e87.1
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756074464; x=1756679264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNGvEOc3hjFKrNjkZThH9ubiJryO/GrmqZf5jARL5gs=;
 b=gg6NGmJU+UN0W6QUH7pKbjsj7l3iNaPEi8NMli6TdOvZJ6S1fn3k/AaM4zRDudh38S
 LyKFcDule/a27uaN2lgdW1H++prbm96NT83wp4T2v6VfZZzNJIk2UoLzAxVWbbBpLbA+
 4zk62HlPKpCqyMgskdKDMrhlWakKaT7rkeCko9Joc5nVzalFBTk8LDEqcKwAcIFDL0Qg
 98uMU6RRkXOnuQy4j0JJBx+JPYlPifni+gmWY6G86HdQVKIl4Dv696RcOU9MFKPgRePv
 j/pN96aCfJXtpWUrPiYH8/Ds/RlfRGlvimUFaOKYBTnBbO7lSp46+s/+OtcaH4AIWwy8
 ILuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756074464; x=1756679264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNGvEOc3hjFKrNjkZThH9ubiJryO/GrmqZf5jARL5gs=;
 b=N/2p6JPaGwo/THTh+6pz9alPTTWFD4XDA3zQeuel1+RT/dp8jxTDm9DeMlsbzn4AdY
 1eiQJnMg8Jz0fOciE6I21vJLDpTYaKS3oVg4lk5bGQ0L0fC2QzAfIElQIWaDsOIWfsSS
 Q64Gy9ZNE/NVi3+mrZTfb7NoHZHIWoIVtqd08t5mMbN/V2gRd9rv/hqNjTIerAnQNsk/
 S+7q+nRYEO/rBmwrvyjLEp1f9mXX5pEdO1/CqIi0xB3s9RRdNy9EKx2bWibHKqc9Ay6h
 xgo7zhaPFRtpd/5ShE9CsC/JsLqJNCH7JTz6Z4QcBVqRJ8Id8PVvDcgxzi2auX4/l+my
 biiQ==
X-Gm-Message-State: AOJu0YxCvd8u9D7HKW7n6+3Z+MXe9q/oPId8CgzwYLjK17q3aBv/4Pcu
 ji9dy8ukRkbOr0E523CJ9BCYoaSPOuxu/HLN2syIFTV59wsjSNFh1RzLHOWx7S1S
X-Gm-Gg: ASbGncukFVqYBu9R9HiaXsXCpqc7zodoUEMnjx6/nJlnJoe1qu7vmqDLnhRqC7CiI7o
 tNnc5mMkcif6hqM8HWwosvJV0+ZETJvJ2gSjmkURVpZE6R+bAXsTo8awpzFIz49ATXcGkJlL0Od
 u07g4tJ0LoZyatMUBREFZU32gkBj+j1YNaE8D4Cybq3LLmCnSfIG+/tmHnBaCenohsm2HAUpmnm
 LDJxz7pR0uG1fkpYJQEEriygD1yZYB0heVUGI9BwbrZThn5DmT4wZv2dtD4nUnoSgoYb9j/c19A
 I+7MLqq1MivAjnty+OJH0CpzNixvCwhfQtYxTpGewbw+ITJoFYYd69j1dRqZg1cT2WPlTUQXF0O
 0Ed5R1vCaDmpUVLA708+Tfe1c98R9oUhCt+RA3bTQjHbVW4q8gZdxgZGIlj+3QVrPIsrF3w==
X-Google-Smtp-Source: AGHT+IEKq69Zam6FqcavCIJ0PoS0rlX7KjSq4g0nJt6TCVzwBolyUacd6EeRRWx2Bt/wRexv3yQhYw==
X-Received: by 2002:a05:6512:2522:b0:55b:814a:a7fa with SMTP id
 2adb3069b0e04-55e0da1a7e9mr3465047e87.8.1756074463534; 
 Sun, 24 Aug 2025 15:27:43 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55f35c11e88sm1265853e87.39.2025.08.24.15.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 15:27:43 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: richard.henderson@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v1 1/4] target/microblaze: Remove unused arg from check_divz()
Date: Mon, 25 Aug 2025 00:27:31 +0200
Message-ID: <20250824222734.4151956-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
References: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12b.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Remove unused arg from check_divz(). No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 target/microblaze/op_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index b8365b3b1d..470526ee92 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -69,7 +69,7 @@ void helper_raise_exception(CPUMBState *env, uint32_t index)
     cpu_loop_exit(cs);
 }
 
-static bool check_divz(CPUMBState *env, uint32_t a, uint32_t b, uintptr_t ra)
+static bool check_divz(CPUMBState *env, uint32_t b, uintptr_t ra)
 {
     if (unlikely(b == 0)) {
         env->msr |= MSR_DZ;
@@ -89,7 +89,7 @@ static bool check_divz(CPUMBState *env, uint32_t a, uint32_t b, uintptr_t ra)
 
 uint32_t helper_divs(CPUMBState *env, uint32_t a, uint32_t b)
 {
-    if (!check_divz(env, a, b, GETPC())) {
+    if (!check_divz(env, b, GETPC())) {
         return 0;
     }
     return (int32_t)a / (int32_t)b;
@@ -97,7 +97,7 @@ uint32_t helper_divs(CPUMBState *env, uint32_t a, uint32_t b)
 
 uint32_t helper_divu(CPUMBState *env, uint32_t a, uint32_t b)
 {
-    if (!check_divz(env, a, b, GETPC())) {
+    if (!check_divz(env, b, GETPC())) {
         return 0;
     }
     return a / b;
-- 
2.43.0


