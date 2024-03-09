Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB02C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 17:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj0qn-0005eu-Lb; Sat, 09 Mar 2024 12:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rj0ql-0005ds-FL
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:51:11 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rj0qj-0004tT-BJ
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:51:11 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so2364573a12.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 09:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710006668; x=1710611468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBOpPFxa99oMMIr44Hfw/UhqA7O7Buk86zQ/3jKmdU4=;
 b=mtDEdYhuz3U155cz6PaeY6y7Gf7j9QQgxAq5skriq5jf5xDzXn8qJBlLpOmJytmnBX
 gCsvxzGSV1TISdHYqZzAigE1Hemt0DdUCEDYDCzZeaZXQzQmx7JBrgiRztcuDkaWc7yD
 ClNYxfA8UQ4PhrHv2tuQFN9dDh1pbSWiK5S02fJJd6BFDGSnaTuyeB+QgMYgyN55D4Fc
 RfjTIgHCLfNzLpDcyXHPnNlH5/gAO4rvR6FXIiTJlhTmbaV0h1qKHbbGw5FnbBpA8O6Z
 uiX2gB9ZjtIzGVLug4cUXtdODklHm4+kdzqSuxwe3xp8wugQuRkCbDAHxi9lYsjoFglN
 LGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710006668; x=1710611468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBOpPFxa99oMMIr44Hfw/UhqA7O7Buk86zQ/3jKmdU4=;
 b=d8Hb5u/GVCY0BPe3ww/Mra9Sq2jX0eK3oEHL0kAbNHuUQaaM/I5jrVsYyZ+TkSKJSh
 FJ1mN6GPxYyZ5HFRat2fNnZt7Mj7VEbEePfhnCtwG/nd+Gk0mMaen5Wzk+xYBCZJmUKH
 cUXm0Oe+mNfo8DFM4Sk5bKxL8CpWrvuML13VThXX8CHcgvvJoLUPH46G0zdWGScLRrnc
 zODab2ZcyS3SSX0c3UByD6j9sRuKyGeGLLLiM5+HBDAYd5MfHgflMgPILbMmuG8yJJsa
 ytnYp1ifXWzOqkisKGrl/WsDiQ8wAgEFmqH+bAHRJuSAb1v7WntKUmBaZ7OdY5ii0/dm
 WQYA==
X-Gm-Message-State: AOJu0YyrhOojpSaeoR3AlOYBjAntgt02YMjZp1Tx8TqoxUTMWydQstim
 OTWcdoz4+vCbLYCHpbGT8yqzFthBXooKBDFsyzHDdMs7Jfefc35lUjl/ePo7k9LEaOm3S0J/FJY
 8
X-Google-Smtp-Source: AGHT+IGQwhZG2YWW4FS96ffwK9Y+/S6qOjRaDO89ASR0XvIwU91Kyh71xqE/tI7W2XHMo697mlEFBg==
X-Received: by 2002:a17:902:e804:b0:1dd:7e09:45dd with SMTP id
 u4-20020a170902e80400b001dd7e0945ddmr2249247plg.19.1710006667738; 
 Sat, 09 Mar 2024 09:51:07 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a170902d4cc00b001dcfbbb1ddesm1578556plg.7.2024.03.09.09.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 09:51:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH 2/2] tcg/aarch64: Fix tcg_out_brcond for test comparisons
Date: Sat,  9 Mar 2024 07:51:02 -1000
Message-Id: <20240309175102.726332-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240309175102.726332-1-richard.henderson@linaro.org>
References: <20240309175102.726332-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When converting test vs UINT32_MAX to compare vs 0, we need to
adjust the condition to match.

Cc: qemu-stable@nongnu.org
Fixes: 34aff3c2e06 ("tcg/aarch64: Generate CBNZ for TSTNE of UINT32_MAX")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 38446c167e..56fc9cb9e0 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1464,6 +1464,7 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
     case TCG_COND_TSTNE:
         /* tst xN,0xffffffff; b.ne L -> cbnz wN,L */
         if (b_const && b == UINT32_MAX) {
+            c = tcg_tst_eqne_cond(c);
             ext = TCG_TYPE_I32;
             need_cmp = false;
             break;
-- 
2.34.1


