Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF53CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 17:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP24j-0005VW-Dy; Mon, 18 May 2026 13:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP24X-0005SA-AW
 for qemu-devel@nongnu.org; Mon, 18 May 2026 13:48:10 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP24T-0003lt-OS
 for qemu-devel@nongnu.org; Mon, 18 May 2026 13:48:07 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c80227c9572so1163338a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779126472; x=1779731272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sUSmtVvY1NQk69uLXjxtFtfhPh/zNM2c1Alkm2srAIg=;
 b=TZXjXWE2yGvlDHFlo50NTC6BbTWLibvMMj9x2DM91Oqjn3177shQXyYWDuIq3RiS18
 jdl363Kq+nvT41QNhoHwEGRhjc0+pvAWd2UhXv7iNohBXuxxYmufnb7DwaZLvTshgeBv
 6nMV5VdRGqkJv5nSokZmYDUUyzq2SOFc9YjhBZoEEiZTIokZ/ufoqXEAmzaGULW+YZhx
 lf365I8vpLvilwTdYYoabwHtHBXOjlq2ROifyqXZW4LqwbAShXpu4uOXMMhT9WgcKI8x
 uNVuwSczlXn2Scjq+d38dKFs8ytasgIAY0xQUh8AlQckPv7+q5y3gQWnfgAQdeUxE8gD
 PzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779126472; x=1779731272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sUSmtVvY1NQk69uLXjxtFtfhPh/zNM2c1Alkm2srAIg=;
 b=VQiA32A/GFwTLbaNhmLVaHvV6NSybfIEw+01Ib8z6Vp6FX1zgDdzih4EE6zjAZmA0k
 moC/n714a5QL8cXww4LgmTSVrvtfzXouphBz4kR0zg0QPs/A7I7RZbG4ljNavg7UyW4A
 Nj0GTizGqjgYa4wttWwb53I1hCq+Q3EiY/ONkgX+yw5OXUNLWWrM2H0vPkU6e3MfwQqo
 COe7HsKM02fFqP3VSg4BQZjhSpJzrSsOhkpTxw1h/jO6fkRrsuTJ3PhAV4p1sBXSGrf5
 NAJ1NjjENd/85jzfI2Lmu5YVklQ+K1KvcFBOiNfSNR1W3GRruHR3KiJ5QeiexIeyItSb
 Tavg==
X-Gm-Message-State: AOJu0YxuwihgfbkluwClRju6oqphwTfSliN6ywmZhtakLZWSs3O72KVU
 yV8eaCt1Zk3PRxehC64IqIWQnedkHwS93cxPl9woSJr3dgfDb/vcltI+Nm77iq/k7Nhfe5819fy
 sUWEUNrw=
X-Gm-Gg: Acq92OGqxHOq0GBkE+w1diZYdDxNn4dPm90u77dkk/B5NoJw2Jp1NAr9nRnOMjNUPdF
 rVwZgIPodJUIgK06Gd12/iK9XLVXgpNoD+808SXfv3NPZztM7XDF4E0gw8zjlKWbHz8sfe77IRU
 zIkjNao91zEFiuEi7f84pk1dS40nAQa5ECmb2KvB+5LedICS7oy5sPAQHn7QyydlauLAXtLVBdl
 EG9/3nBLVaWzbPBiT7Q5bd8clCrcojBPMuYJezoMiuuEuWoAHhlGegqiDEzW4SjI3sBOnbe9D52
 SDoidF3i/V/kHoj7pnuMquycZ4gbE21ZXlBudhx+ZM5zEwjFudlLmajnyV7/kqfPKXA3vj5bJ50
 iV4gDRlPYuHxgBIrN6LO00qi5hcwc7o75OFtCiJDQog2zcpE+VbopXhGkrKjhwv/skiCOiiGGAU
 Dkj+6p7eUYoqjmBycQFIYvEp90ZTEW
X-Received: by 2002:a17:903:13c6:b0:2bc:7d5d:e2b7 with SMTP id
 d9443c01a7336-2bd7e9a7de2mr181034645ad.36.1779126472308; 
 Mon, 18 May 2026 10:47:52 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d12e38dsm157334905ad.77.2026.05.18.10.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:47:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 1/4] target/arm: Add feature predicate for FEAT_CMPBR
Date: Mon, 18 May 2026 10:47:47 -0700
Message-ID: <20260518174750.660258-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518174750.660258-1-richard.henderson@linaro.org>
References: <20260518174750.660258-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4e44245a8b..217ab29bb4 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1043,6 +1043,11 @@ static inline bool isar_feature_aa64_cssc(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, CSSC) != 0;
 }
 
+static inline bool isar_feature_aa64_cmpbr(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, CSSC) >= 2;
+}
+
 static inline bool isar_feature_aa64_lut(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, LUT);
-- 
2.43.0


