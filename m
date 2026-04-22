Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A5EF9EDC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX4q-000650-JP; Wed, 22 Apr 2026 08:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4k-00060P-4S
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4h-0005Uo-Oh
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so38386835e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862382; x=1777467182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/O57BXYHK8ET+Z6BA/YHEqhtOr337eupd637bkTh7l0=;
 b=zRjYZxtUV3maLgzQ8KVnwGBsPALz02V7MPZ77c2TB1Hhmc4P45atpS6FjzWBmx00vM
 tAzamBKjtxFRWAIvCZk4VZciTPUjK1WrpHNvl+pt02oNrNulFB1L8eL7kAWvBO1bOWm8
 m042/uUNI4EYCd2yURo3e877ITU7IrTBL0n8g/YrJjMGiW1pZQE7LBa22tcZUz3Hv13l
 1osaOqUjpl/xpUf7QLvtwU9SJjp7i8oATIXP6MPFAfkg80DnEYpyfsCNcugzLg0uGGvx
 s4XO7QCBFfpYZyP6NhC+JxmMo0/3tI0eyRJc5Apqbq4/O+ozPcTLPlmG8SW3lr4KZT35
 xpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862382; x=1777467182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/O57BXYHK8ET+Z6BA/YHEqhtOr337eupd637bkTh7l0=;
 b=lIU+u/XTWVhguN/dOwbgx4L0Etbio2ANfUr/dbQgu6PXOm5A2uPPaEVDJVN3C0Pktk
 bU9rdPuSHp8VdZwIjkvohz263pGiC2xhEXVqTKBfmkIsUcfbga6UheYoK01aPYYoHozU
 t+g8I6CD0fufZCHtwx7IEkQxu+wsXirSHsjC9RbZXor5zs7/94NKMALSEP75Cq2iftfb
 KZiIh7iyq9n8j5JIBgffT30n6tkHl/V3ElLGfdhZfZTU89f6UKbbwO1RqHbP6gQqRG4c
 NSEsXU8qr73habKtToftQo7dezTEOTqwYndk2UzKGcbXtI0HiUmM34dDI1mA/QalrN7y
 YE4A==
X-Gm-Message-State: AOJu0YwijdWt+HuvYNYn01m4vED2+rCyQRra8fGtExmDHtmIgI+9v+Sk
 MCBxZCcvX1FDTQm3ECYyDouurUXrPx3TKEm1ETnZFG+xiitJCvA2w05EfefTRX4c4mA=
X-Gm-Gg: AeBDies/ATv0m/DsDXf77mgOKjv7oF6jVCDm3Uht3pmo/nGzlZTl7jNkK6t/j+M7FoB
 RUbUknjjTCaGD1JCNtyCNEdLZSSMVYlRlNVH7YjNM/W4TK+GBtqlo5V4+E9LghuN2JSuWea9baO
 6z6t6EJKqG0bgOog9JVdWDXJYQDS8Qk7n6os2bkjUcri9/mz/X9iqVUMSN2mEwyZFlGynTPBi5d
 5TjKq3YJYxYxBrkOxdC6f/lLUo63cBSHVX/P06tMBSXe5xyKpA1PBBXmd5/SO8aYnIm7qh1mQPd
 Bn2o/+qhLmT01uoylDsulD52ju2p4yh7RpkO9CzWdjX9pdPvP/2WpAz16ib1UDVaJlRlEQeePHy
 6+vEeiVCNp3yxR+vGLWuH0hKhaEi73tRzn5RUxwPj9U7ZkLgBYLeTr5gIvflIcwTZx4WJH1J9No
 XmvfOVqXw0QyoXXapimU4JvGonDhWS8XPjrA==
X-Received: by 2002:a05:600c:3b04:b0:48a:5574:3a57 with SMTP id
 5b1f17b1804b1-48a55743eb7mr94839625e9.29.1776862381644; 
 Wed, 22 Apr 2026 05:53:01 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb75c695sm134492015e9.14.2026.04.22.05.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6C5CD60469;
 Wed, 22 Apr 2026 13:52:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 06/32] target/arm: migrate PAC trap syndromes to
 registerfields
Date: Wed, 22 Apr 2026 13:52:23 +0100
Message-ID: <20260422125250.1303100-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

syn_pactrap is fairly simple as the ISS is all RES0.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 61053475984..fd8639d4f07 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -398,15 +398,32 @@ static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
     return res;
 }
 
+/*
+ * ISS encoding for a PAC Fail exceptions
+ */
+FIELD(PACFAIL_ISS, BnA, 0, 1) /* B key or A key */
+FIELD(PACFAIL_ISS, DnI, 1, 1) /* Data or Instruction */
+
 static inline uint32_t syn_pacfail(bool data, int keynumber)
 {
-    int error_code = (data << 1) | keynumber;
-    return (EC_PACFAIL << ARM_EL_EC_SHIFT) | ARM_EL_IL | error_code;
+    uint32_t res = syn_set_ec(0, EC_PACFAIL);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, PACFAIL_ISS, DnI, data);
+    res = FIELD_DP32(res, PACFAIL_ISS, BnA, keynumber);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from a trapped Pointer
+ * Authentication instruction is RES0
+ */
 static inline uint32_t syn_pactrap(void)
 {
-    return (EC_PACTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL;
+    uint32_t res = syn_set_ec(0, EC_PACTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    return res;
 }
 
 static inline uint32_t syn_btitrap(int btype)
-- 
2.47.3


