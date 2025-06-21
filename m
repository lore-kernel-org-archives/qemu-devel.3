Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9007AC71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82R-0002GK-KO; Sat, 21 Jun 2025 19:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82H-00023o-MU
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:14 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82D-0004w5-RY
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-742c3d06de3so3592755b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550048; x=1751154848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gkoi7wbkLQHDVykv2CbABLU85QfHPJbq9ICWtI7STgk=;
 b=MM+Y1QXqeTKKYp7phqFHhmW9zSC7GetcKMwfYmfc4aONAN7S7djrSLrxFmq49Jvz3K
 qgagK0UfX5LX7HY6dAAtVn83fSV9gO9S5h/gmjdS2wsmJ4l4GrjTXhtmIhQ6MBfNEkk7
 NQ6mR8LUETKBOmEuFt4DzvysuBVhEWiIdjqlNpVkTkT0TqOSUGony0omzcnvyTjrxto2
 yL+ky32eJQa8s8uve+tb9ODL4A8n5byr+JSDb9WAcfUqArM2Aql5HShlppOklNDvTeNB
 bB9tRYCWvfFNcPAeSGTg9KgvYTDniDCp3hfekwaKo6LG1gNmmBwitmDmJTPjh8CckqfO
 Mp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550048; x=1751154848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gkoi7wbkLQHDVykv2CbABLU85QfHPJbq9ICWtI7STgk=;
 b=BWi8n7htnJJnbd3DZ9WsM7gfZwpnH+4t8Kr1+SgGUEHcxQRR2ZcjC75pRMXjWMJXP8
 fFNEB1XCcCm3bFl3+3wKLm3Dvxxip90nZcb9nl2QB49jkrA3tVSCgg+il6Swwx/fON4x
 7Ri8l/8xIowh/Ps5FuyVgv7Joejp+7w0vbLru+jmihHVur4tfW7y0im4T2O9cz/bsJB+
 8a/h62FZ6ZZgxn6EUPo5+XaHI8khQ58mqzkIPhkvstd2eKZzyu49r2/UP4JLDGXL1tzY
 HjE/uDEXRyquGHnG/NOsg04UlRfAuXf6kk343rz2/qtSOu5p+SgQObTMG7xcChDAmLl7
 temQ==
X-Gm-Message-State: AOJu0YzpgjLUrt20yQMVoZ95HJ/GEwjmxgStl9YwRyudoOdOw064a9vS
 +k8HBf/AAdVN8T6zUcwUL1BAf/eoyjgK+EbBBeTU6vCgNUt1mu8r6i8bL7L2lCCBs/z1uxTLgn1
 3v1OYvIU=
X-Gm-Gg: ASbGncscVxZVV6WCgzh1fEYCeKQZdIo/suUUCZ9RrWKgczV2dBS7WKyB8TG90v6gN5/
 MT9GxGa4BmfzGLxCzSF9D3r55JsaUWjP5nqd1RwakIijN3/gw/rMB9WseMCwry8MqebQgYw+QHP
 dIDlSZ1r4QWtEw2oaq671jh/eucobnm+jmToxDjTNqp61LO1RN4k+Uz2637lIK2SEtyisw+aVtr
 UY0E7zJtU0SZccq0hbzI4SZTv/+6zzgsCJ6LG3lhv5ybzg06YZqWZBkGqxpn7U9yB1deZKcq5+4
 76OuCrGOmz/ClHAC75jDr3ALj3qQDEVAYxE2OSkttpLyZdVmOBM+dFTISGn69aX1u4d8hOLJmoT
 BUYy4Oer/GsGS9W5e6dbF
X-Google-Smtp-Source: AGHT+IEV2mxx8YHDtu3jk5HVbojp2GyKtVfRPrrNDvqVL31D4hIe/jWXx+u9ls0MV5a2wVEO9pQ0qA==
X-Received: by 2002:a05:6a00:3c90:b0:736:2a73:6756 with SMTP id
 d2e1a72fcca58-7490da07100mr10857279b3a.21.1750550048311; 
 Sat, 21 Jun 2025 16:54:08 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 045/101] target/arm: Implement SME2 SMLAL, SMLSL, UMLAL,
 UMLSL
Date: Sat, 21 Jun 2025 16:49:41 -0700
Message-ID: <20250621235037.74091-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 target/arm/tcg/translate-sme.c | 29 ++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 44 ++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 9cc8b5760b..f7242f1061 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1003,3 +1003,32 @@ TRANS_FEAT(UVDOT_nx_4h, aa64_sme, do_vdot_nx, a, gen_helper_sme2_uvdot_idx_4h)
 
 TRANS_FEAT(SUVDOT_nx_4b, aa64_sme, do_vdot_nx, a, gen_helper_sme2_suvdot_idx_4b)
 TRANS_FEAT(USVDOT_nx_4b, aa64_sme, do_vdot_nx, a, gen_helper_sme2_usvdot_idx_4b)
+
+static bool do_smlal(DisasContext *s, arg_azz_n *a, bool multi,
+                     gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
+                      0, 0, multi, fn);
+}
+
+TRANS_FEAT(SMLAL_n1, aa64_sme, do_smlal, a, false, gen_helper_sve2_smlal_zzzw_s)
+TRANS_FEAT(SMLSL_n1, aa64_sme, do_smlal, a, false, gen_helper_sve2_smlsl_zzzw_s)
+TRANS_FEAT(UMLAL_n1, aa64_sme, do_smlal, a, false, gen_helper_sve2_umlal_zzzw_s)
+TRANS_FEAT(UMLSL_n1, aa64_sme, do_smlal, a, false, gen_helper_sve2_umlsl_zzzw_s)
+
+TRANS_FEAT(SMLAL_nn, aa64_sme, do_smlal, a, true, gen_helper_sve2_smlal_zzzw_s)
+TRANS_FEAT(SMLSL_nn, aa64_sme, do_smlal, a, true, gen_helper_sve2_smlsl_zzzw_s)
+TRANS_FEAT(UMLAL_nn, aa64_sme, do_smlal, a, true, gen_helper_sve2_umlal_zzzw_s)
+TRANS_FEAT(UMLSL_nn, aa64_sme, do_smlal, a, true, gen_helper_sve2_umlsl_zzzw_s)
+
+static bool do_smlal_nx(DisasContext *s, arg_azx_n *a,
+                         gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
+                      a->idx << 1, 0, false, fn);
+}
+
+TRANS_FEAT(SMLAL_nx, aa64_sme, do_smlal_nx, a, gen_helper_sve2_smlal_idx_s)
+TRANS_FEAT(SMLSL_nx, aa64_sme, do_smlal_nx, a, gen_helper_sve2_smlsl_idx_s)
+TRANS_FEAT(UMLAL_nx, aa64_sme, do_smlal_nx, a, gen_helper_sve2_umlal_idx_s)
+TRANS_FEAT(UMLSL_nx, aa64_sme, do_smlal_nx, a, gen_helper_sve2_umlsl_idx_s)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 4146744a46..ec011d9382 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -311,6 +311,22 @@ UDOT_n1_4h      11000001 011 1 .... 0 .. 101 ..... 10 ...   @azz_nx1_o3 n=4
 UDOT_n1_2h      11000001 011 0 .... 0 .. 101 ..... 11 ...   @azz_nx1_o3 n=2
 UDOT_n1_2h      11000001 011 1 .... 0 .. 101 ..... 11 ...   @azz_nx1_o3 n=4
 
+SMLAL_n1        11000001 011 0 .... 0 .. 011 ..... 00 ...   @azz_nx1_o3x2 n=1
+SMLAL_n1        11000001 011 0 .... 0 .. 010 ..... 000 ..   @azz_nx1_o2x2 n=2
+SMLAL_n1        11000001 011 1 .... 0 .. 010 ..... 000 ..   @azz_nx1_o2x2 n=4
+
+SMLSL_n1        11000001 011 0 .... 0 .. 011 ..... 01 ...   @azz_nx1_o3x2 n=1
+SMLSL_n1        11000001 011 0 .... 0 .. 010 ..... 010 ..   @azz_nx1_o2x2 n=2
+SMLSL_n1        11000001 011 1 .... 0 .. 010 ..... 010 ..   @azz_nx1_o2x2 n=4
+
+UMLAL_n1        11000001 011 0 .... 0 .. 011 ..... 10 ...   @azz_nx1_o3x2 n=1
+UMLAL_n1        11000001 011 0 .... 0 .. 010 ..... 100 ..   @azz_nx1_o2x2 n=2
+UMLAL_n1        11000001 011 1 .... 0 .. 010 ..... 100 ..   @azz_nx1_o2x2 n=4
+
+UMLSL_n1        11000001 011 0 .... 0 .. 011 ..... 11 ...   @azz_nx1_o3x2 n=1
+UMLSL_n1        11000001 011 0 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=2
+UMLSL_n1        11000001 011 1 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -371,6 +387,18 @@ UDOT_nn_4h      11000001 111 ...01 0 .. 101 ...00 10 ...    @azz_4x4_o3
 UDOT_nn_2h      11000001 111 ....0 0 .. 101 ....0 11 ...    @azz_2x2_o3
 UDOT_nn_2h      11000001 111 ...01 0 .. 101 ...00 11 ...    @azz_4x4_o3
 
+SMLAL_nn        11000001 111 ....0 0 .. 010 ....0 000 ..    @azz_2x2_o2x2
+SMLAL_nn        11000001 111 ...01 0 .. 010 ...00 000 ..    @azz_4x4_o2x2
+
+SMLSL_nn        11000001 111 ....0 0 .. 010 ....0 010 ..    @azz_2x2_o2x2
+SMLSL_nn        11000001 111 ...01 0 .. 010 ...00 010 ..    @azz_4x4_o2x2
+
+UMLAL_nn        11000001 111 ....0 0 .. 010 ....0 100 ..    @azz_2x2_o2x2
+UMLAL_nn        11000001 111 ...01 0 .. 010 ...00 100 ..    @azz_4x4_o2x2
+
+UMLSL_nn        11000001 111 ....0 0 .. 010 ....0 110 ..    @azz_2x2_o2x2
+UMLSL_nn        11000001 111 ...01 0 .. 010 ...00 110 ..    @azz_4x4_o2x2
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
@@ -449,3 +477,19 @@ UVDOT_nx_4h     11000001 1101 .... 1 .. 01 . ...00 11 ...   @azx_4x1_i1_o3
 
 SUVDOT_nx_4b    11000001 0101 .... 1 .. 0 .. ...01 11 ...   @azx_4x1_i2_o3
 USVDOT_nx_4b    11000001 0101 .... 1 .. 0 .. ...01 01 ...   @azx_4x1_i2_o3
+
+SMLAL_nx        11000001 1100 .... . .. 1 .. ..... 00 ...   @azx_1x1_o3x2
+SMLAL_nx        11000001 1101 .... 0 .. 1 .. ....0 00 ...   @azx_2x1_o2x2
+SMLAL_nx        11000001 1101 .... 1 .. 1 .. ...00 00 ...   @azx_4x1_o2x2
+
+SMLSL_nx        11000001 1100 .... . .. 1 .. ..... 01 ...   @azx_1x1_o3x2
+SMLSL_nx        11000001 1101 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_o2x2
+SMLSL_nx        11000001 1101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_o2x2
+
+UMLAL_nx        11000001 1100 .... . .. 1 .. ..... 10 ...   @azx_1x1_o3x2
+UMLAL_nx        11000001 1101 .... 0 .. 1 .. ....0 10 ...   @azx_2x1_o2x2
+UMLAL_nx        11000001 1101 .... 1 .. 1 .. ...00 10 ...   @azx_4x1_o2x2
+
+UMLSL_nx        11000001 1100 .... . .. 1 .. ..... 11 ...   @azx_1x1_o3x2
+UMLSL_nx        11000001 1101 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_o2x2
+UMLSL_nx        11000001 1101 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_o2x2
-- 
2.43.0


