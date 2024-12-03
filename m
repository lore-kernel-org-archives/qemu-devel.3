Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21B4E77166
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 23:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIc6g-0001OI-8F; Tue, 03 Dec 2024 18:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6d-0001M8-Rh
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:59 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6c-0001La-1L
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:59 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so2971242a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 15:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733267696; x=1733872496;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pG0aQnUQA7YEFMoz0E4tJtn6hJqy67liJfeq3q7vHeU=;
 b=Nzmj3DrlNIkCzdF5AoL2oVlt1XhtzaOoPhC8wUysmU2xPE9Tn61vz5yWKRNO1xSZVr
 ZI1z9I/dgIY3GhtTQiqxBR4mmledrB5ZI0lOG7UkVm/J5SC4Ewaz2za762vnY6QF0FSw
 wcGXxY2z981457oGCMl+cwDLc+3ZnhuQuS5rFviC9ZJFG6j6vwD46qljpDonxITtA6CN
 KJh2dU57v4pwF+VB6SV/aFlBRVF8sQo3HPDG/iWxajvxB+lHS2STK9ZbShm1bBrE/SZV
 QOkw9w2mtYgtQOSiy20l3P6wFsheysNuI3Ae70L7ps2lkbkj55ruD/W/AlyUIat2QQb3
 BZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733267696; x=1733872496;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pG0aQnUQA7YEFMoz0E4tJtn6hJqy67liJfeq3q7vHeU=;
 b=jsHqdr+Ndo1A6mjjHdp0NlBL9U2hPzYy+YV0Tdy3Ow9pLk8T1CTlOOrC8YrN2IgQAY
 Vb/oBj47FaALIZuqzS1awpJrjzOrlBxu2nsxnGsRvvR3ySmD/4psMT+MZWZ7fM7VM1Hz
 aCc11ozZlGU4Vcwzvd6TNzn5NBaMkW13I44pOaRnNaMoo6MjlRsjjaFej3lKOlFwEkYI
 mTSL1xH5g5xI8SK2adPWO5twVPjAs6M62nHnTnr+AQfv+EfGXegO7FjYDZ8Wi3w8UB1U
 eDxtNrJwuFJP4DA8HmhXx35hYekC8gvII1+WmCDVeFpDHONxhyl2b1FOb4YZxoJ3IWBb
 Rwzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWreti4sOBuW1YrtY06oFbumohRJ4saNo/YHJynnEfDvYIWHewy+YjEWcA6YCOyyuvD8z2C0a4XQ4d/@nongnu.org
X-Gm-Message-State: AOJu0YzD5OzMEVDlYlM9A1C9VvAphlIdHtgekUCdCd2e5fyBjDmvUjAP
 K52xL/wWRAbwfKfBr05hVNAJSMJZSpRhTg/9WFcAc3quuhUkNToD9ObJY6b+rQE=
X-Gm-Gg: ASbGnctWKf8t1BXe06XHNf/FjpOE16+lQgoBIdMq6LoBNHYv9waxG+KjT6/KXOL6sjy
 n76j7g1U2ylsfYcqs0bVW6gqZ9jQRz8ol0ZUnffsOKA90PUAWk4Mbbx7iuGn6oO4EQxTf8bbMfg
 0Ud/gAfwyhn4XGWQoN++TSPQuDlD2dy16zitEdtT/8BMi/+ykjsVhI7N3jfhry3iz5zGwe9+lm6
 QLShpzK53FRTn1F9rZkX2rg1Pgt+z3sIt02GUYubEJrxIbZTeVQldvA2p4zi3w=
X-Google-Smtp-Source: AGHT+IHooGOQbGWgbWmWYOflIkzZDuYu5vVnLDYDzFLGw/Lj56bLWHFPasBSFqPOJ8VMCuDQDTKG4Q==
X-Received: by 2002:a17:90b:3803:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-2ef011eb672mr5312459a91.13.1733267696547; 
 Tue, 03 Dec 2024 15:14:56 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254180f78asm11032133b3a.133.2024.12.03.15.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:14:56 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 03 Dec 2024 15:14:48 -0800
Subject: [PATCH v4 10/11] target/riscv: Add implied rule for counter
 delegation extensions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-counter_delegation-v4-10-c12a89baed86@rivosinc.com>
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=atishp@rivosinc.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The counter delegation/configuration extensions depend on the following
extensions.

1. Smcdeleg - To enable counter delegation from M to S
2. S[m|s]csrind - To enable indirect access CSRs

Add an implied rule so that these extensions are enabled by default
if the sscfg extension is enabled.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 82edd28e2e1d..410ca2e3a666 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2642,6 +2642,16 @@ static RISCVCPUImpliedExtsRule ZVKSG_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule SSCFG_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_ssccfg),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_smcsrind), CPU_CFG_OFFSET(ext_sscsrind),
+        CPU_CFG_OFFSET(ext_smcdeleg),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
@@ -2659,7 +2669,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
-    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED,
+    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
     NULL
 };
 

-- 
2.34.1


