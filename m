Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1908ECD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 16:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waFgF-0006hN-CM; Thu, 18 Jun 2026 12:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1waFg3-0006cw-Sn
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:33:15 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1waFg1-0006Kz-FK
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:33:15 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45ef6565cfdso623361f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 09:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781800392; x=1782405192; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4hX01wxKGw3BuQr74QeKdveuBzAtu1koRwZnMOTRaN4=;
 b=an3QwisRzIbc1VaBEx51sXKZ9JLQZF02z04heHTaRzdh93XAvLV08+Rn8WQgc0l863
 aHQ9SJXYNOhdDPX9geO9DziO2hyZz2StSwyP8XexQolMT03UZaW+KLNOaFAeXsKybBsH
 FxhLcl5Ykr0S+cX1c84FUj/b6+SNdEZsCMZ+PS4hcfn6xSzLmH/HQOQ3LMX9dT2ASxnM
 E0fZE62GUy8ynd//FTzLmikVEan9g2zdzmKdDlG74/p8stGyOJvMiwAjFRk/nSGrVdus
 3FKddB6/G2R4jpMocXgl9g5FMBhw5u7FFz4PZvqQhdXoEds8elH8eQI5xpIv/2hZCY6e
 OJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781800392; x=1782405192;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4hX01wxKGw3BuQr74QeKdveuBzAtu1koRwZnMOTRaN4=;
 b=T2S+swm5R+/te0g/2DDhgdNLw43Ovp3njNjb/w2s/JbxoOEMQq9+WeWqz0q2oK4rVu
 1w6J/7/FJImdGWfwm1rDN5KjivAZpKV1W6wchfs3m1qaknVcg9w3jmk1CYHekwqrmgWK
 QR9Omw1zomXkfh2UQdDoRupHf2xwAMgvqxM9L07rnanuJRkz734AHB72rjEjOA7XUlZR
 3P5uslL03b//Du+yJ8mB9R66+l8Dn8nd9zcy64rmhEKBTm4zPUWptfnvboGDnoP+fd2+
 7pI4ZDnmLFERilUoeow4yiYffIVhtR++GcGtt5lFkFrcas44xSpmJKTiJgsuMVOpKHuI
 BqIQ==
X-Gm-Message-State: AOJu0YwmERbKbPHEFBnMfUTiQKeVgklJf6BqzkgiCnpBphKIRzD+r/t6
 GiEkBEvmtlqjy3fprp0zb1XCi3S60iYQjO5lctPCbggphgG8JpV5WB9V0wbblxSs2VU=
X-Gm-Gg: AfdE7cn2fzWhSaprkWzgRYH4XF8EnNtm3bFXh/LGX+AKPKoDcs7hyj+73nfelwIxmLS
 RNwuZlFn3SZw0Wwgsdljy8bTFKTBr5R+S2fjlJybT/wdHHryhMBQw+f9x8JyCHL/fIXKMhJwKCX
 3aKEZ4mFmLSxUz2BhNzMf0fljT6UT+CNj00vgM3TOcge15r4WKHdGzfnrAtTZflTiqVDdgPpG3h
 S4Sg2ieT2BA6kxgVHqetboLQ7JwgOBcDC91hqHaBwHaMkODSSgT9SF2ZPDsJuX2qoDnZEWdluPg
 TkPXcnUzkzU1tlcLPBN0YEjr4jp71/0RlMMoX+u7crBJ4a1swp7gKZWY1ZEQVr+yrbOf35u0fQ9
 iwgCmexzDJZAG//47ZTMewXHVa77YWI4tVxRhtLONKpeayHuJLt1jeFydHafpLRLinYzoGNFg/0
 Fh4qu7ptPASUJADg==
X-Received: by 2002:a05:6000:1865:b0:461:9fc7:7d01 with SMTP id
 ffacd0b85a97d-46501685f0emr358890f8f.23.1781800391974; 
 Thu, 18 Jun 2026 09:33:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:b52:6a9:569d:e33e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650bc426e1sm26942f8f.29.2026.06.18.09.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 09:33:11 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 18 Jun 2026 17:33:04 +0100
Subject: [PATCH v3 1/6] target/arm/tcg/cpu64.c: Extra test for GPC3.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-jmac-gpc3b-v3-1-353e546067e7@linaro.org>
References: <20260618-jmac-gpc3b-v3-0-353e546067e7@linaro.org>
In-Reply-To: <20260618-jmac-gpc3b-v3-0-353e546067e7@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x434.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 9e70d30964..26099f4c83 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1159,6 +1159,11 @@ static inline bool isar_feature_aa64_rme_gpc2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) >= 2;
 }
 
+static inline bool isar_feature_aa64_rme_gpc3(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) >= 3;
+}
+
 static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, DIT) != 0;

-- 
2.43.0


