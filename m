Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B95C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ktd-0001eR-R6; Fri, 25 Apr 2025 11:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8Ktc-0001dE-5p
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:23:20 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8KtZ-0002p0-Fw
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:23:19 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-af523f4511fso2284078a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594595; x=1746199395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFIjN5FugvOLKOwxhVcNRX7EfVOZPbGYkwA/+pKFgdA=;
 b=oOeCT9xFE3Eq5oxqEdjHH4jqrIZUsaWlxl1zXzFGDxtyiXdNk0b5RD20mzqkZiDVrV
 2V9VCsC/Pv+TwgA0IQM8KCAV4wxj53ZQXLpNDG3bha7xiO1QudCqlj7X2vMmVUxyrNIg
 GTUW5dp3VlrlseHjHh2suKvr8liLCynXPpdol++hIUFSuwnp8JhEegMfANqYhIIFnESa
 ahCcxmPBKDvLJ71cyk2STd1k/Dn4vIecscgkjKw0EizOAUJdykQcxIV8phERBHYtGNNO
 8fGJLdmXGbQ9kotBg295lRf5Oooi17M5Khm57dcQLa0y5YcXxweDuUcRT+xduUuwtndK
 CfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594595; x=1746199395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFIjN5FugvOLKOwxhVcNRX7EfVOZPbGYkwA/+pKFgdA=;
 b=Q4g0aA9rxs2IefNOuhYRSIyuZJuApDjNFgAB5gE9zz93uyHqzLrJND5O39KfixrTEg
 bMBl/hOMlHcMWD3T4B2tx/slIS8RPRjR6S2JdJfYKKKgKmoa+VDBquMlsn2AuxngvePz
 jaCV82QIvDRMwi9Uvu0P8JOiWf+7lZsvM+xZqnp4+5kq/rkjU5PYVDv3drBDbl9+xYdj
 YEFeYJVV1dAMY6+if2fpMfUIFhjRY9LPIhbUBtelDMwPPkfJCEsn9HwiYlN8c0KbXzK/
 zdcjAljamV5yZaIT+SE8fslDK/wBNuyuQIdpqYigjbxllhOPoFmEzdpEtLFpRIFRVS2Z
 4o/w==
X-Gm-Message-State: AOJu0YyIMDF5TsO9QkzJN3+DtV2KwoysvShv+NrjqMCet5maLyOL29TR
 SqF/BwryQjQeFx36ZJ5APsUdV1btA2FSCb4m/+JcZIx5Ee5xzO2far6BBsOchEIsyw6I4SwL7kG
 k
X-Gm-Gg: ASbGncvO6eCj0e+gXRL8nyM+bYu4QGJgYG3MD9oZ4w5SopYHpzG2LgOIbPjKewXs7l9
 +9BX5toaWFXxDrHUWS5WqCUqOpHOByxSZZ2n3Teau5nz3ladYZDZ5+tDeVcBzUVWhqei70UNxrp
 56s7iw6SXRb/2G9/ozmKZtkMm3CpNu7T9c9hVBKtObGlVGpxSRyn/hgvOF0M/6l9UmCCxsWxf/K
 1opUDSY4GRcgZoroqJyfds3a5R+te1h1cB8TjarMFCoPy3oQMqyolrK82OdS8vWBOYf7kZsIeXC
 st/mZ3mHiARF8UkSfoI6l9ehaQnJKu186/Sr/Pg6hrwBGhjpTaWJeuNddLHjY0+b6Tkv1s/uizo
 =
X-Google-Smtp-Source: AGHT+IEpk8B8DIMRg7LZdaT1jRwYovqQYpTETxvBjIOWMDh0QZoc/IHxM4cPzs8We/hqxH1VxC0xDg==
X-Received: by 2002:a05:6a21:920b:b0:1f5:8655:3287 with SMTP id
 adf61e73a8af0-2045b9f6f37mr4592429637.40.1745594595499; 
 Fri, 25 Apr 2025 08:23:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3390466b3a.106.2025.04.25.08.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 08:23:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, dbarboza@ventanamicro.com
Subject: [PATCH 3/7] target/riscv: Pass ra to riscv_csrrw_do128
Date: Fri, 25 Apr 2025 08:23:07 -0700
Message-ID: <20250425152311.804338-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425152311.804338-1-richard.henderson@linaro.org>
References: <20250425152311.804338-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/csr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e9c2f95b6e..d62d1aaaee 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5588,7 +5588,7 @@ RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
 static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
                                         Int128 *ret_value,
                                         Int128 new_value,
-                                        Int128 write_mask)
+                                        Int128 write_mask, uintptr_t ra)
 {
     RISCVException ret;
     Int128 old_value;
@@ -5610,7 +5610,7 @@ static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
             }
         } else if (csr_ops[csrno].write) {
             /* avoids having to write wrappers for all registers */
-            ret = csr_ops[csrno].write(env, csrno, int128_getlo(new_value), 0);
+            ret = csr_ops[csrno].write(env, csrno, int128_getlo(new_value), ra);
             if (ret != RISCV_EXCP_NONE) {
                 return ret;
             }
@@ -5637,7 +5637,7 @@ RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
 
     if (csr_ops[csrno].read128) {
         return riscv_csrrw_do128(env, csrno, ret_value,
-                                 int128_zero(), int128_zero());
+                                 int128_zero(), int128_zero(), 0);
     }
 
     /*
@@ -5667,7 +5667,8 @@ RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
     }
 
     if (csr_ops[csrno].read128) {
-        return riscv_csrrw_do128(env, csrno, ret_value, new_value, write_mask);
+        return riscv_csrrw_do128(env, csrno, ret_value,
+                                 new_value, write_mask, 0);
     }
 
     /*
-- 
2.43.0


