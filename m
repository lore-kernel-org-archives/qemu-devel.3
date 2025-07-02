Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DE6C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwpF-0003f0-C5; Wed, 02 Jul 2025 08:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjp-0004gO-KK
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:59 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjc-0002D9-37
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:56 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso2972114fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459921; x=1752064721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezys0sOuptJAVetRQW/ZH7kqDHAQfIW1cKPgXlZFpvQ=;
 b=WK8OFuEtYOa3BZw0ywcNhiFvdYXSNXx/AHaGq5N37H9V7AspYzaRu0GSiprllnAAxW
 cfkvPeWcNJmPt7Y7DVkh81zxz3imd0+oZ5y73dRmmPgc9OPywzCI94joEIaNXJHlnyPQ
 KAwlMADRltWEwjfLSWuxoIi/9dMwBg34f2ZqDmngkoc4MpzzuYZCP4pHlOlMsQIpgiaW
 18OU2varM+byvSKDkSF0BjMG9LzwS60mkcrjAKs7ay1Y23IUnyMJ5ZYUepziKzOanw7u
 E5B+OhBvo6hslnrRybC6T/9NRc+CafIDMYBXwMMDBOFw2audbaPJBp0fbXF6Wty3tPo4
 kNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459921; x=1752064721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ezys0sOuptJAVetRQW/ZH7kqDHAQfIW1cKPgXlZFpvQ=;
 b=fYzNt7tfSMHwmmMQvt0Kse0fJw+xO9PtOjW7bA1bFXAErXE/1NFJ3eOGje05LJQFZm
 METgmgx28KELxNBVuK604aLYIMzuNyB4N/Qa2CdwsiGjUQTR59YcwL9a1iomEub427J5
 vCel1Sihyrw3Vv0X/uO+ptBlqrQ5gZ823GecDtTxW002BYkxHFnkjH9YIhT1vIrPvwA0
 erGuovZ11G26RmwvHS0W6sLxLYGLL68uFE8W0IqEOO3PxWJkuyJ/9i0ZTpe4y0SLr/eh
 IieE8VXxr8hGSmParAAXG78lwaAomTwNWCZDNj9BT6nH7pli1efxWs3DBtqQCHM/cs9p
 nZuw==
X-Gm-Message-State: AOJu0YyVbTJGqAxlZFtK6gyURdslHUSABb3onPgvXx9pcEWmezVOoaYc
 5bbByihv3x083a6V+at/f6yRiKNP8J4lB5tMp6gBQJsjcb1ETnn2weKXvGMNE9PL0T1XSEgcWjK
 0cP5h1Dc=
X-Gm-Gg: ASbGncsAqimO491TbR84F33a2hESDMmL18DlWzuKxUFs575gsQgiOG3vgm1W2e5xzy3
 ccG1k0g9gCQscLXtpZZX56fuYqWuVGqLtVqnBq+hgYeRdnouXHDdnQz2VFYQza2UlUEZ9PeFfdT
 3ApWL2ipEUSopm2WYDRIpci9k1lEYVMqD+djhyoXlfp4YmSahbnhCeSn1yZurRG2I9MB0g+SgIZ
 TAjGSKeykxBWgcaGdOxVjpXtwpiBR52Ma/8lekRZyUrnFYV3FzLAEaEDZe9Z4CsLU1GLQ8oJetH
 KU1tIRkBstLnSFnanOG3PdPrl7vDrv5bBr5gmzFpIlY9fbS759i83lXT1FKEuY8uZy4fiBjOSKB
 e+2FW
X-Google-Smtp-Source: AGHT+IEVDxY/o6gJkYlJvUjlYFVgWOLDzjGJLoIJxEMdsChh0xrfGqVJ129NaPuwM7QasP8I2XtVhA==
X-Received: by 2002:a05:6871:6212:b0:2e8:ec55:aafc with SMTP id
 586e51a60fabf-2f5c7b5eb46mr1520205fac.37.1751459920889; 
 Wed, 02 Jul 2025 05:38:40 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 69/97] target/arm: Implement SVE2p1 PTRUE (predicate as
 counter)
Date: Wed,  2 Jul 2025 06:33:42 -0600
Message-ID: <20250702123410.761208-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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
 target/arm/tcg/translate-sve.c | 16 ++++++++++++++++
 target/arm/tcg/sve.decode      |  1 +
 2 files changed, 17 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c93dca224c..651b4aa378 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -1679,6 +1679,22 @@ static bool do_predset(DisasContext *s, int esz, int rd, int pat, bool setflag)
 
 TRANS_FEAT(PTRUE, aa64_sve, do_predset, a->esz, a->rd, a->pat, a->s)
 
+static bool trans_PTRUE_cnt(DisasContext *s, arg_PTRUE_cnt *a)
+{
+    if (!dc_isar_feature(aa64_sme2_or_sve2p1, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        /* Canonical TRUE is 0 count, invert bit, plus element size. */
+        int val = (1 << 15) | (1 << a->esz);
+
+        /* Write val to the first uint64_t; clear all of the rest. */
+        tcg_gen_gvec_dup_imm(MO_64, pred_full_reg_offset(s, a->rd),
+                             8, size_for_gvec(pred_full_reg_size(s)), val);
+    }
+    return true;
+}
+
 /* Note pat == 31 is #all, to set all elements.  */
 TRANS_FEAT_NONSTREAMING(SETFFR, aa64_sve,
                         do_predset, 0, FFR_PRED_NUM, 31, false)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 389a72d824..3517efb31b 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -730,6 +730,7 @@ PTEST           00100101 01 010000 11 pg:4 0 rn:4 0 0000
 
 # SVE predicate initialize
 PTRUE           00100101 esz:2 01100 s:1 111000 pat:5 0 rd:4
+PTRUE_cnt       00100101 esz:2 1000000111100000010 ...          rd=%pnd
 
 # SVE initialize FFR
 SETFFR          00100101 0010 1100 1001 0000 0000 0000
-- 
2.43.0


