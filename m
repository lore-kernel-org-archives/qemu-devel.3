Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122D7C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 22:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaMb9-0001Lk-4D; Fri, 11 Jul 2025 18:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYs-0007YL-6W
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:47 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYb-0008Vl-Mb
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:31 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-61208b548e8so709333eaf.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 15:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752274167; x=1752878967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8MiZSYeSsFc7E9O+r65QuNCOOnlvBtRW+4SiNaYQadU=;
 b=a47NU0h2PcXOH4zNCoD7V3dG71GE7UpCKUz9PEPlQop4rZzSneue5IeOoLcVQSY+Sz
 LiRhp0FOJ4DTkRtKKkglfMnBjBYNV7nXyWDqGIsJ+4f3lq6lEgQP/iKw915ssBzreQ5o
 qmU5cw/KWseapxmOXLkMHyO8hB+Swc7MYmJwZUmGPG1f0o/t+hFLnrsbCWET8QIgK0u7
 CtEYRXJmP2Ai85mWjrpZhdbRAcHm4tSbsK6R+xwjlArieCQcUUUxq43m5Yud43Y3EyxZ
 cdgIHspiNnqp/Jqrrm55KGSgtxoaX+XAhJFQ9wZ88rx29tZbyNddyb/aq6UqOHsO0CmT
 eV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752274167; x=1752878967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8MiZSYeSsFc7E9O+r65QuNCOOnlvBtRW+4SiNaYQadU=;
 b=SiYsoBQWvjjPeh/6qnUFURCyEq+S975Yu+7IxxR5Pgag/6ozrOEGTE23rFDRb4RMFs
 T4mLakzie5bd4o5NVpXo1S6dx37wczJsv8DyMRk6+qeoyDmSo22YR8o+sF7evIUP1qo7
 AyRs9xAE9Tj99RcEb9l+udFJe+mYUHF+d+Fi1AINqazSwEX0BZlv9nttt8tmlQrdrylX
 c/LF+iSIYr+Gyo2O5omKyn8EbND6b4gns8Mg8wubZI+J6FDeL1c+hThpH9lzntTfVqW0
 hR7Awe3/ZlfLuL2NZOOfC3DBB2pXi5/mKhEzGW3WyXWu+8K7yYjwGdgWn0ymbx01qVsT
 Y9Ng==
X-Gm-Message-State: AOJu0Ywa//p+RZkCqOMz5SQP/zp4FEVlG8RIMWC5FxUJvjncjtWqBNMs
 rpQ5jiCEfDDhfu7M78Aw86ImVoLdyZ4j4Y+wh3NAiSS+wpV59N6uZ/w2OoidQRk8BOgxC8uYiSJ
 kQOMKqcI=
X-Gm-Gg: ASbGnct2BT8Grq0s0/Du5mdQC4jdicj4pgTz1GydpayijEcDVnAKwvAlLN/Kv8RnvmO
 DKYm5Ze/U2MmDlGoFoTTTjwSQZ9GVjNS8A/lzIAz6TQmRbaK5ow+77QaIG7OnARCVfPARvVzJdh
 z8SCQQD3ZsG5MvxUUaBlPdUY46k76mdoIzB7G0slZuVpe0ew12N4FBwemgT/8zPW81TBUbKv944
 j464e3RvE7QzWhZUN/uGWj0QXnZQ25vuXyzyy5f8OKVpN/Xna6WSa1R21TMTUKTntFwyll539qu
 E/DEyqRKO8zzbk7KU9Junz1bKSI08IfhVCSGbfYPhkuA5Vs7FAWdAKfKA7nMWFMAxOZI4TVivkQ
 xz1+v3bkg90s9ZaDIBgMvb7XHYt99LFISZlkmQGkxMXDdJLkfh9zi1FBDsuJNzosTwIYA/1XLpm
 UgX+qCSfLs
X-Google-Smtp-Source: AGHT+IHVbX6gvoj89AkIBy0BO24YTgUwsopb7/bS+LGdYPdlTAQF2c2acGbVaqq/xNclqrP3z0DbtA==
X-Received: by 2002:a05:6808:2e4a:b0:409:52f:b361 with SMTP id
 5614622812f47-4150cd84e8cmr3798418b6e.0.1752274166877; 
 Fri, 11 Jul 2025 15:49:26 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-414197c6064sm696638b6e.20.2025.07.11.15.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 15:49:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 7/9] target/arm: Fill in HFG[RWI]TR_EL2 bits for Arm v9.5
Date: Fri, 11 Jul 2025 16:49:13 -0600
Message-ID: <20250711224915.62369-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711224915.62369-1-richard.henderson@linaro.org>
References: <20250711224915.62369-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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
 target/arm/cpregs.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index c9506aa6d5..1d103b577f 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -408,10 +408,19 @@ FIELD(HFGRTR_EL2, ERXPFGCTL_EL1, 47, 1)
 FIELD(HFGRTR_EL2, ERXPFGCDN_EL1, 48, 1)
 FIELD(HFGRTR_EL2, ERXADDR_EL1, 49, 1)
 FIELD(HFGRTR_EL2, NACCDATA_EL1, 50, 1)
-/* 51-53: RES0 */
+/* 51: RES0 */
+FIELD(HFGRTR_EL2, NGCS_EL0, 52, 1)
+FIELD(HFGRTR_EL2, NGCS_EL1, 53, 1)
 FIELD(HFGRTR_EL2, NSMPRI_EL1, 54, 1)
 FIELD(HFGRTR_EL2, NTPIDR2_EL0, 55, 1)
-/* 56-63: RES0 */
+FIELD(HFGRTR_EL2, NRCWMASK_EL1, 56, 1)
+FIELD(HFGRTR_EL2, NPIRE0_EL1, 57, 1)
+FIELD(HFGRTR_EL2, NPIR_EL1, 58, 1)
+FIELD(HFGRTR_EL2, NPOR_EL0, 59, 1)
+FIELD(HFGRTR_EL2, NPOR_EL1, 60, 1)
+FIELD(HFGRTR_EL2, NS2POR_EL1, 61, 1)
+FIELD(HFGRTR_EL2, NMAIR2_EL1, 62, 1)
+FIELD(HFGRTR_EL2, NAMAIR2_EL1, 63, 1)
 
 /* These match HFGRTR but bits for RO registers are RES0 */
 FIELD(HFGWTR_EL2, AFSR0_EL1, 0, 1)
@@ -452,8 +461,18 @@ FIELD(HFGWTR_EL2, ERXPFGCTL_EL1, 47, 1)
 FIELD(HFGWTR_EL2, ERXPFGCDN_EL1, 48, 1)
 FIELD(HFGWTR_EL2, ERXADDR_EL1, 49, 1)
 FIELD(HFGWTR_EL2, NACCDATA_EL1, 50, 1)
+FIELD(HFGWTR_EL2, NGCS_EL0, 52, 1)
+FIELD(HFGWTR_EL2, NGCS_EL1, 53, 1)
 FIELD(HFGWTR_EL2, NSMPRI_EL1, 54, 1)
 FIELD(HFGWTR_EL2, NTPIDR2_EL0, 55, 1)
+FIELD(HFGWTR_EL2, NRCWMASK_EL1, 56, 1)
+FIELD(HFGWTR_EL2, NPIRE0_EL1, 57, 1)
+FIELD(HFGWTR_EL2, NPIR_EL1, 58, 1)
+FIELD(HFGWTR_EL2, NPOR_EL0, 59, 1)
+FIELD(HFGWTR_EL2, NPOR_EL1, 60, 1)
+FIELD(HFGWTR_EL2, NS2POR_EL1, 61, 1)
+FIELD(HFGWTR_EL2, NMAIR2_EL1, 62, 1)
+FIELD(HFGWTR_EL2, NAMAIR2_EL1, 63, 1)
 
 FIELD(HFGITR_EL2, ICIALLUIS, 0, 1)
 FIELD(HFGITR_EL2, ICIALLU, 1, 1)
@@ -512,6 +531,11 @@ FIELD(HFGITR_EL2, SVC_EL1, 53, 1)
 FIELD(HFGITR_EL2, DCCVAC, 54, 1)
 FIELD(HFGITR_EL2, NBRBINJ, 55, 1)
 FIELD(HFGITR_EL2, NBRBIALL, 56, 1)
+FIELD(HFGITR_EL2, NGCSPUSHM_EL1, 57, 1)
+FIELD(HFGITR_EL2, NGCSSTR_EL1, 58, 1)
+FIELD(HFGITR_EL2, NGCSEPP, 59, 1)
+FIELD(HFGITR_EL2, COSPRCTX, 60, 1)
+FIELD(HFGITR_EL2, ATS1E1A, 62, 1)
 
 FIELD(HDFGRTR_EL2, DBGBCRN_EL1, 0, 1)
 FIELD(HDFGRTR_EL2, DBGBVRN_EL1, 1, 1)
-- 
2.43.0


