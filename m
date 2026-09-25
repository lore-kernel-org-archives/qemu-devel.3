Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FA7C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xADoX-0007y7-OD; Fri, 25 Sep 2026 17:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADo3-0007l0-LU
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:14 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADo0-0007Zy-R1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:11 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfd1so570270a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 14:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790373007; x=1790977807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3uToE5TQtUeu04oq/KPmYzTSFGfvjSl8xGGZIFShgp0=;
 b=g8cUFVJvk1i1cHzjULDBmxe1MuUWTTZ2EZR772TFL1ZseYKvASt/E4p1M9fkPoUZfG
 K2nh0O/TNg4eoCuusSuVJCIC4ZFJpoU1yNxdk0J5Sr5+w/mjBSY0O7bdCj9wAGbkN7xe
 ve+nbW49rG/G8NpgDzDbK+S4/rskBDeoBdvpSSBLJLFK5fgcoy55In8MSxkwQSK2a2Ut
 2KUwxLesf4f+fQEdaMghjSZJ8WzITfNyjl/aywJrjWdmXwXqslPiHDfOPeXVvadwouyS
 0jDwKOfggeCaKkWos2UFkV9dLWPzTMqGn87MY1Ce2O3v00dIveklfi6+NxwMir0FEMBF
 ld6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790373007; x=1790977807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3uToE5TQtUeu04oq/KPmYzTSFGfvjSl8xGGZIFShgp0=;
 b=TSiRAhlCjQfEgaRk8uQrz9rzZWZja4Jpj17SSf7iLqrN5icIsz+DTkWUMDlVtem/CB
 ZJY+A/QPKh0yNCsfFmRYttw4Ul9MCtorU7ieO2aF7zkq71YC+MZWNBfmXJWIO7yROcPY
 QzeRZelhJ5K4j5kmgG1pnqSgyMXDSQYZvLvu+96xtglgvpAZN3Au8MHUFqzxnJEE5zYU
 BstatQG0AdSUDNmHOnTj6By6tW05ydXvwRaiCOZxhfPa4gVKGVdGjMDi0cAvQ9wfu9hP
 3fQXgq0x5rvc957uXjS0F+gB8fjVEusRtng4Ib1vhNTy3vuv2NvkOEM9MjAiaXKdm5lb
 nuZg==
X-Gm-Message-State: AFuF++k7h9+zLMvt51AeeeH8F6RdZMlT2+Pre7wRgZ29JZKNatYpTfGd
 QMuTbvfi90UFNcq4RDFy+QaxKeRKeWUANWC/u1fMk+y14MQz1DSxHniZXJvbO2aY+YQ8fpuYIWR
 Pd/1s
X-Gm-Gg: AYBFou3piv3kRgTckRer4HkuvrXQNnpirehFu9+PbInDd+IG40uq80ymGeG7hSL+Fbt
 R2RmriDk+ONaPa4y64NS3l2iSk4JAFKni7kKE2PfjAcuUyH3dufE3I13+BOB7/hjrlyYbtCgSwI
 oCrntjsAdnNk2w99T/W94qWHS0Qc0zgcBvGhgFQFdu8k4wamB8osBd9oscAexuThIGd2m/H4Coj
 Wkv1eXzgSQQf7Je0Hcfg7guAx3D+3P2l1idH7DxsA+I3Kdap6kY4o8CLOHumJoS950xE+1Z9bEu
 WUjKisfYKQ6/l7YMPVHOMoHnrcaAHB6sG9QjN7Ok3+vCsZ4YIfYqU3ochXAzH2IAyUGnPwC9OwT
 +TZeNuL6WqUe2iGbPdi9oUfFBuUa/RZypIBoGrRuYgTvtb58ZzC2QPT0vjk/IGhanSZ5qj5NMMH
 rXJYfQfCVkiFwtJnv3dNCFp1tYUKN9llpJcXc6lubgoEdC7/GTx0dtX+7FYHvC7BO70cw/o2jDG
 N+J/qMDjOo75GrRk12t+Z1rq9GI/OvWPjzc21V3
X-Received: by 2002:a05:6a20:d090:b0:3dd:a196:309f with SMTP id
 adf61e73a8af0-3de0e9901bdmr6090359637.79.1790373006784; 
 Fri, 25 Sep 2026 14:50:06 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea1940ecsm1725256b3a.13.2026.09.25.14.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 14:50:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 01/14] target/arm: Parenthesize tbflags arguments in TBFLAG
 macros
Date: Fri, 25 Sep 2026 14:49:51 -0700
Message-ID: <20260925215004.456336-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925215004.456336-1-richard.henderson@linaro.org>
References: <20260925215004.456336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e3f931dba26..8c50e91004d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2583,21 +2583,21 @@ FIELD(TBFLAG_A64, MTX, 49, 2)
  * word either is or might be 32 bits only.
  */
 #define DP_TBFLAG_ANY(DST, WHICH, VAL) \
-    (DST.flags = FIELD_DP32(DST.flags, TBFLAG_ANY, WHICH, VAL))
+    ((DST).flags = FIELD_DP32((DST).flags, TBFLAG_ANY, WHICH, VAL))
 #define DP_TBFLAG_A64(DST, WHICH, VAL) \
-    (DST.flags2 = FIELD_DP64(DST.flags2, TBFLAG_A64, WHICH, VAL))
+    ((DST).flags2 = FIELD_DP64((DST).flags2, TBFLAG_A64, WHICH, VAL))
 #define DP_TBFLAG_A32(DST, WHICH, VAL) \
-    (DST.flags2 = FIELD_DP32(DST.flags2, TBFLAG_A32, WHICH, VAL))
+    ((DST).flags2 = FIELD_DP32((DST).flags2, TBFLAG_A32, WHICH, VAL))
 #define DP_TBFLAG_M32(DST, WHICH, VAL) \
-    (DST.flags2 = FIELD_DP32(DST.flags2, TBFLAG_M32, WHICH, VAL))
+    ((DST).flags2 = FIELD_DP32((DST).flags2, TBFLAG_M32, WHICH, VAL))
 #define DP_TBFLAG_AM32(DST, WHICH, VAL) \
-    (DST.flags2 = FIELD_DP32(DST.flags2, TBFLAG_AM32, WHICH, VAL))
+    ((DST).flags2 = FIELD_DP32((DST).flags2, TBFLAG_AM32, WHICH, VAL))
 
-#define EX_TBFLAG_ANY(IN, WHICH)   FIELD_EX32(IN.flags, TBFLAG_ANY, WHICH)
-#define EX_TBFLAG_A64(IN, WHICH)   FIELD_EX64(IN.flags2, TBFLAG_A64, WHICH)
-#define EX_TBFLAG_A32(IN, WHICH)   FIELD_EX32(IN.flags2, TBFLAG_A32, WHICH)
-#define EX_TBFLAG_M32(IN, WHICH)   FIELD_EX32(IN.flags2, TBFLAG_M32, WHICH)
-#define EX_TBFLAG_AM32(IN, WHICH)  FIELD_EX32(IN.flags2, TBFLAG_AM32, WHICH)
+#define EX_TBFLAG_ANY(IN, WHICH)   FIELD_EX32((IN).flags, TBFLAG_ANY, WHICH)
+#define EX_TBFLAG_A64(IN, WHICH)   FIELD_EX64((IN).flags2, TBFLAG_A64, WHICH)
+#define EX_TBFLAG_A32(IN, WHICH)   FIELD_EX32((IN).flags2, TBFLAG_A32, WHICH)
+#define EX_TBFLAG_M32(IN, WHICH)   FIELD_EX32((IN).flags2, TBFLAG_M32, WHICH)
+#define EX_TBFLAG_AM32(IN, WHICH)  FIELD_EX32((IN).flags2, TBFLAG_AM32, WHICH)
 
 /**
  * sve_vq
-- 
2.53.0


