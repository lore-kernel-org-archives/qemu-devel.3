Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EECCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZDz-0004OE-OM; Tue, 16 Jun 2026 15:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8W-0004jQ-QH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:51 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8S-0001C0-Mt
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:48 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45fe59255beso2781471f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636858; x=1782241658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V6sLBGdgtQYDIl7E66w9tV0s+p4xqf8JGUH+izJ1pxI=;
 b=UfcOD8vCi7A8c4/NK1MO5/sqOe73V7bRnNklypOB3CLgNWMluBXlGZky9SQi2d43Ls
 USl99rhy//pH1HejtQHti4HH6Jd0rCylJ9t9Qw2yflctNCCxDtcMAbEvRGB7kax8Xpx8
 aeIrnW3iFvjJNJWDpCW0HkI72hEuuailswYdu9mKPp4ADXOZEytYOFauPoXAZDI29quw
 EbHO37v1RMq6xJLSnKHmNoEF6lpD5dEGRGX2sNbLJR13R0fJl7jMAf58wkBo1iadGWJ3
 ZKAJBjGqD12mpHTohbBU/zmmAfoSlF1/UpyyKj3oqBirKGipMi6mNAodNONCK+nEgU4P
 liAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636858; x=1782241658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V6sLBGdgtQYDIl7E66w9tV0s+p4xqf8JGUH+izJ1pxI=;
 b=kpN2eQWLyzQgpeWj3Xy/6WGszUDR/flkhYcJBsdmeLbiNC3ncTK1x8FMK6r21MUijQ
 rfqPD/KGlqimunkJHjoUQGmdFUoLczrPEwwNHzYu647LkmttQv3WrYCxcnYkk5EO06wd
 Ktqi8n7MO9qefeQ+uO5Wl/2GbPWw/GTTxl82yO1ZnxeUXJlCJ39mI5nUldlNii90kTVI
 3GOeHVMyHIhd97Hio7540TVjgcBsGg9jYqExfB1mHwFJv34yM60fArp0gGM5zfR4cP9C
 F7Vg+Uqk7Ut8mSFEeOZZy7PIM/3NOR5VPqMylGuTSJ0jp9RdlSuBxMrRpkZFuvuR4xcS
 u+AA==
X-Gm-Message-State: AOJu0YyVTw4AtU9LFmADtO5S5FD0XC5eMribPc9U+sslibf/1PNYB3Sc
 le2zBGB8ns5BWcfKEvN3tZ2bFpLjk/0KbLNxzMS3QOZeNOLlXI5y7qrpt4G+CgNJSg+pDgu7sFI
 Gu2Gd
X-Gm-Gg: Acq92OGjHN5MbKTd4T3CZMegYOZZFs8OshheUi0OTujCcISBVtEWd7tHUPdhDt/Ypxb
 WKCiqjKpJHuxcxGTzIyGmgBCnAqQzPifY83kE6d80XKh4kyseYesJBHv2VEQUd5jek83ftkdwIT
 63Cv1KpzRpuK7wjYRh82WY2brQyKA0GvSBanVyaEwz8tGstQXrb3D040VnXrGgDTQwy/UkE/CNp
 de6Y6NxDc3C5MsyUvx1GGtM1AtypSRSzlBRm0C+1G973TZSG9r3NkUHGApMYyGwB5/0qR7Iw4H6
 UD/UQyIcML/5UezUchKLIzpFEFyWap4fKUQBsFYvx7cxHPlxjRlhYkV0I7ZMdF46oOt9GwCp8N3
 6/zr1g7JS2GYxLRG0rnfAkU8PQjzjETr2By6xVNirkWw40eW7N6yvu7WeiISDrh7mZPSOfvwmd7
 D/jyHf7tjVLeAz+pikYukD0BO43UH32ZGIiEfplgzRNDkhDmb1FxsocLIyK3VcLjS8LsHe5e5qA
 56Kyv3XUIMnCTYea8iNmkwznSu1F5+D
X-Received: by 2002:adf:fc09:0:b0:45f:f142:d55a with SMTP id
 ffacd0b85a97d-4623f8b3005mr883612f8f.14.1781636858069; 
 Tue, 16 Jun 2026 12:07:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/61] target/arm: Implement SVE reverse doublewords (zeroing)
Date: Tue, 16 Jun 2026 20:06:28 +0100
Message-ID: <20260616190639.3462006-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      | 1 +
 target/arm/tcg/sve_helper.c    | 4 ++++
 target/arm/tcg/translate-sve.c | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 867ae2916e..45f8633fd3 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -734,6 +734,7 @@ REVB_z          00000101 .. 1001 00 101 ... ..... .....         @rd_pg_rn
 REVH_z          00000101 .. 1001 01 101 ... ..... .....         @rd_pg_rn
 REVW_z          00000101 .. 1001 10 101 ... ..... .....         @rd_pg_rn
 RBIT_z          00000101 .. 1001 11 101 ... ..... .....         @rd_pg_rn
+REVD_z          00000101 00 1011 10 101 ... ..... .....         @rd_pg_rn_e0
 
 # SVE vector splice (predicated, destructive)
 SPLICE          00000101 .. 101 100 100 ... ..... .....         @rdn_pg_rm
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 9634517925..1711444800 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -971,6 +971,7 @@ DO_ZPZ_D(sve_revw_d, uint64_t, wswap64)
 void HELPER(sme_revd_q)(void *vd, void *vn, void *vg, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    bool zeroing = simd_data(desc) & 1;
     uint64_t *d = vd, *n = vn;
     uint8_t *pg = vg;
 
@@ -980,6 +981,9 @@ void HELPER(sme_revd_q)(void *vd, void *vn, void *vg, uint32_t desc)
             uint64_t n1 = n[i + 1];
             d[i + 0] = n1;
             d[i + 1] = n0;
+        } else if (zeroing) {
+            d[i + 0] = 0;
+            d[i + 1] = 0;
         }
     }
 }
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index cd1e0e744d..6a29c1e43e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3089,6 +3089,8 @@ TRANS_FEAT(REVW_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
 
 TRANS_FEAT(REVD_m, aa64_sme_or_sve2p1, gen_gvec_ool_arg_zpz,
            gen_helper_sme_revd_q, a, 0)
+TRANS_FEAT(REVD_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           gen_helper_sme_revd_q, a, 1)
 
 TRANS_FEAT(SPLICE, aa64_sme_or_sve, gen_gvec_ool_arg_zpzz,
            gen_helper_sve_splice, a, a->esz)
-- 
2.43.0


