Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598FECA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXYf-0002aO-VU; Thu, 14 Aug 2025 08:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYa-0002RF-4Z
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:49 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYW-0004PG-FS
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:47 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-32326de9f4eso810918a91.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176379; x=1755781179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHDom8RqSvFBhHj/9Q/rXAoVV+sGpC/X8GRYrjCGKNI=;
 b=XLHYs7y9RNKJjUNF9jng37BF+QPVh+op4kRJy35/wj0MgAm73Ag0xOUJBTV41/7Nx5
 mSYbB21B8msg5RrSHyIiuJYpQ2uZHezUxJdPY32lKv9whmilGRVHncezbk4pBStAMLNp
 zv9AEubXDQrZaix2K1MmrAdVlB5dR1ZFJQ3mfg0HwYnglLmUjSbTeI08Tb4rwlE73B/1
 piaALfmRQjtefWYRgHLVBNCIcU+OMcGc0sS4tvduce6fiO4J7l1naVa51vGwJ+FCZlx5
 YlAW6jxY8gvkMpsjXvvQJ9m3MB0km7Y8T2WYRJvSRSfT/GKYSJ9AcsKgsO1Um2NeECen
 EI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176379; x=1755781179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHDom8RqSvFBhHj/9Q/rXAoVV+sGpC/X8GRYrjCGKNI=;
 b=vqMzF4wxaSuEo5PxWzg9jS8gdR/Q/+e37BGbk8be6eTZbGQblKkplEMhEbfQjuV03t
 OdLMDrKf+BepLjT1VlPuFKI1h5Yahz7sLzgwOjA6S8YFkRfkfbkIsqyXhsLjaEkSHJZp
 Rku1MzUpbvvSlsSlbx9b73Jb/qErbLw+HIOq8ybErgYlollKiUianJHQpKVGL5as/vl9
 CUsQPlTl1KYOkAzzSjoFpMVPbAX8KLziiGuErE5AUmZ2EzekY+h09HRx5kI+C4LkPg/V
 2h4Y4QO3crJFOxnB0mzGQWgywECXHJiCX9qlzpiRSvB7nraERhQ66JklrSG6uKeo4tDD
 Cc4g==
X-Gm-Message-State: AOJu0YwpapxHOp5S5iUATl8o+2r7BR9RL9hVzvA5GPRWCrwdiPHxI86l
 tfvUCzwuzIS8HMDOtfBIVovg4mNxI0SRduIRxrbU9toZdGyTMYCy2vv+5NA14FDgoRq50S0lPVn
 n5sSzKho=
X-Gm-Gg: ASbGnctn09MASZWz/V9C7JPMA9R2awI+1Wd5HVrQbgUc31HNnAkn5eK0HsXe41p0zsX
 62lwjWymEeOYw9oi2OSTayEAAJiib3NrOswdugzozq/BtNg7IfiLjYpF+lm9yjoLMURzZnINE/s
 ntqudYRxtn127R8K1ZOBn/CxN79QgUFqapyHpjE/R61rTksNtt1t88ij2C1JxW8sIJf6PGmhRRZ
 TtvNbHm5DjN4mwe1s/UfYsAFxS09zZFMGjEX3cNMlVKAKy7G1A49I0d13WEyKLeEBjfyp4Vpq+R
 zrGRu5mkZUZvLI3xJhIk26nZr4HXn3jizu5hPxN1C/wSPc6aZFqo/BjFH5TMx1+qYX/uh1r+9Cb
 yQV0SQb9dhbBGwAMvg4Nbrws24Tktpg3O7kmFeFqSNlb6D3Q=
X-Google-Smtp-Source: AGHT+IF1wmKY9MmDTwxHy7FIkgF2CAJJ2uVf4fo7it9i5WUI1Iv/muQj/UO7ebCQ2zagCFxL7cGg2Q==
X-Received: by 2002:a17:90b:1844:b0:31f:336a:f0db with SMTP id
 98e67ed59e1d1-32327aadbcbmr5085805a91.10.1755176378784; 
 Thu, 14 Aug 2025 05:59:38 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:59:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 30/85] include/exec/memopidx: Adjust for 32 mmu indexes
Date: Thu, 14 Aug 2025 22:56:57 +1000
Message-ID: <20250814125752.164107-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memopidx.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/memopidx.h b/include/exec/memopidx.h
index eb7f1591a3..66d9c58b3a 100644
--- a/include/exec/memopidx.h
+++ b/include/exec/memopidx.h
@@ -25,9 +25,10 @@ typedef uint32_t MemOpIdx;
 static inline MemOpIdx make_memop_idx(MemOp op, unsigned idx)
 {
 #ifdef CONFIG_DEBUG_TCG
-    assert(idx <= 15);
+    assert(idx <= 31);
+    assert(clz32(op) >= 5);
 #endif
-    return (op << 4) | idx;
+    return (op << 5) | idx;
 }
 
 /**
@@ -38,7 +39,7 @@ static inline MemOpIdx make_memop_idx(MemOp op, unsigned idx)
  */
 static inline MemOp get_memop(MemOpIdx oi)
 {
-    return oi >> 4;
+    return oi >> 5;
 }
 
 /**
@@ -49,7 +50,7 @@ static inline MemOp get_memop(MemOpIdx oi)
  */
 static inline unsigned get_mmuidx(MemOpIdx oi)
 {
-    return oi & 15;
+    return oi & 31;
 }
 
 #endif
-- 
2.43.0


