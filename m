Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C855C7115D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82Q-0002FP-Ii; Sat, 21 Jun 2025 19:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82L-00027G-Rs
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:19 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82J-00051g-Ma
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:17 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-748f5a4a423so1829680b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550054; x=1751154854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OpkbFbMGSOhybuGYn+mQ7FijZZl7dQi0hDdIn4qmOA4=;
 b=UJu55X++FD59ivsGAVS3hPz7Deg4VcvTne24/WULewnCm+RLWHUFwEyISsgD3XtpQX
 YSSAKV31azjRB+wHMUSm1SHu/LJP+m2mJiobv7eghqBOwv4zY3rn4+SONYtu+G8g49eE
 DD9TPSqQH9zNMY2jmiP03wPnf2UWHBLkzYvRBJRM2TFnXLW0vgr2wpzCz1sbjFgogjDn
 o8VpEN1qznomOoSdBBuwOinuF/o/TdUR8JPtcdYp/HAhsQ9YUf/5m9KQG4lNmgYoI1oz
 YYyNMz1N/CXDRt+HqSBzSBux71WLDcd5u7D+Rww5YtlB8G40pcAnV4iC2kTbzcsFmirL
 j37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550054; x=1751154854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OpkbFbMGSOhybuGYn+mQ7FijZZl7dQi0hDdIn4qmOA4=;
 b=lznsTZcWPwDM9UfJY7exabCX9GFSxKSBJ4ixupBZjJGmtBo3hSnL7tJ3BJA0KNVUK/
 lPfCbdGMNlC+QECaOXejAOvYE3iWRDdZb8m9fv3xerJW2BKMhsYVPkkgAeLSrXpvug8M
 G3fBCJ7WHAKk9Os2S54hHM1eAxi0JHKh0wF0uusuLueRmioPha4zbnNM5LQjO3SGzhzp
 MRFhAMeaEkji+CCayYJLCzLsA+TqwBq+6r4ZmSCjrJdBaA1UcAYteaqB5AZd9D2Y0zDS
 2X8n6Yjcx1zNnxQxgGVuNm3CCuubVfZdcwnczOAZY1SvNseul5jqjFvggt/wW5CQhTfo
 /svw==
X-Gm-Message-State: AOJu0YzlBZ4tGtwFRxYXtT4W465LBilH44oIBd2FVtWgh2n5n5spAwnC
 jGfvbdpuGfnB9UHX25xzygEhdXZopxiQBMCbtBeX9o0JTW2484c4R7xl+AaSrDzS/dEHGNiXqwS
 klJV4Tjs=
X-Gm-Gg: ASbGncsNeeFlAo41KIt4Sd1ERdt8djqXMqQKoczePg9C1k7vb/wCK2fflUPERcN9NQj
 oMPJq4MOx951o2KAkCBgn1qZOLTv2MklTYjByX7s3ymKv3UeZqlOzmtO1a7PjVgKSqmOJTf7FTA
 oFZCY/hsk28LI+lv0pVSYczpO49+Hnyvp1r09MtX/T6ld3H9AGkZBdjZFxxoxPDHEgbILYWpk80
 hDID3g0WDu0571oW1x/lyUpJMDT7XYRGkW9d/sWbMyRlQrcBrBlYK+IreJFMIsbJFUS6PCaKMOP
 0UbgPSeUD0cjcaiX1ZDvjX1EkNsgkysmyQY5jfRekDwAfXEZdcMZRmJjneZer82mJycK/Hut2I1
 wYiZjZbrzct7OuwjdQIbW
X-Google-Smtp-Source: AGHT+IEdHV4jMJDeZOLe13H7yAy89+EPFONAsXipwlzKQ7AEmZF0tMJjdHl0l2mq0VX/YDjoNXOyJQ==
X-Received: by 2002:a05:6a00:1990:b0:740:a023:5d60 with SMTP id
 d2e1a72fcca58-7490d74b176mr10307966b3a.19.1750550054238; 
 Sat, 21 Jun 2025 16:54:14 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 055/101] target/arm: Implement SME2 FRINTN, FRINTP, FRINTM,
 FRINTA
Date: Sat, 21 Jun 2025 16:49:51 -0700
Message-ID: <20250621235037.74091-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 target/arm/tcg/translate-sme.c | 9 +++++++++
 target/arm/tcg/sme.decode      | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 733b7a0743..a96d5ace43 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1303,3 +1303,12 @@ TRANS_FEAT(SCVTF, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_gvec_vcvt_sf)
 TRANS_FEAT(UCVTF, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_gvec_vcvt_uf)
+
+TRANS_FEAT(FRINTN, aa64_sme2, do_zz_fpst, a, float_round_nearest_even,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
+TRANS_FEAT(FRINTP, aa64_sme2, do_zz_fpst, a, float_round_up,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
+TRANS_FEAT(FRINTM, aa64_sme2, do_zz_fpst, a, float_round_down,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
+TRANS_FEAT(FRINTA, aa64_sme2, do_zz_fpst, a, float_round_ties_away,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index e2d3668567..dffd4f5ff8 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -750,3 +750,12 @@ SCVTF           11000001 001 00010 111000 ....0 ....0       @zz_2x2
 SCVTF           11000001 001 10010 111000 ...00 ...00       @zz_4x4
 UCVTF           11000001 001 00010 111000 ....1 ....0       @zz_2x2
 UCVTF           11000001 001 10010 111000 ...01 ...00       @zz_4x4
+
+FRINTN          11000001 101 01000 111000 ....0 ....0       @zz_2x2
+FRINTN          11000001 101 11000 111000 ...00 ...00       @zz_4x4
+FRINTP          11000001 101 01001 111000 ....0 ....0       @zz_2x2
+FRINTP          11000001 101 11001 111000 ...00 ...00       @zz_4x4
+FRINTM          11000001 101 01010 111000 ....0 ....0       @zz_2x2
+FRINTM          11000001 101 11010 111000 ...00 ...00       @zz_4x4
+FRINTA          11000001 101 01100 111000 ....0 ....0       @zz_2x2
+FRINTA          11000001 101 11100 111000 ...00 ...00       @zz_4x4
-- 
2.43.0


