Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D167CC7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7zI-0005F2-T7; Sat, 21 Jun 2025 19:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zF-0005CP-4r
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:05 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zD-0004XD-JB
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:04 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b2f0faeb994so3236074a12.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549862; x=1751154662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AVLGi6yVBj9f4DTQN3Bb0Gk823PKe0kOw43jnGxIjBU=;
 b=DJQWOYvVIB8xz/KcNDWH/07TmcwjGsOvA6HRO2IPbIpj2IpI9vLvQa6E95Py999ID3
 x3Af5W3tWTvaKpAEDaD+tZtXIdafoMhvIXAZfGFAh/oV8Vddz3CU8UVIm03IIWCALJF0
 +N1J8cLgxfeyL9OpJYmiMTzYSFxMnHwwLON2X4XP7PXC6zL61zua1n0yl+1n31YUkH/a
 epgAbh++bBZ48pw4LqYz1/PqJFzj0ph2CXFIK+4WAFn9SnKLzLOUTnW0VX6hLjJylRlI
 1SFCorsHqkE2FHx0TTx0TLodJF+MOAI9hl8ZUjHe47BBRimJMhficrYCb04FwQPqyRMx
 8YIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549862; x=1751154662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AVLGi6yVBj9f4DTQN3Bb0Gk823PKe0kOw43jnGxIjBU=;
 b=gVV4DCslMT1OtzGe8ZV0Gi05kgPAWxKcc5h0Jojvouaw//ba6GRW2UcHk4daWeFnpr
 +wOHDcfGlQ4+Hqvjxj3Cs3AFFlJRXfFwF+iqmrXE8ZE1QNv6PP8rnCNkpI0IKyd28ZUo
 2VIU7ryK0DPHmI7TGK1NUPn88jO0l0DcfwUOIaerBpkJzvY7Z4OlCTCi2mw1JYjUOWaY
 4/cgfZoZH+Q8Sx4siXnFZOaKgJQsA8/4GJYRAc2U+PNZXRkRNZSrWoOWoU9p90vQCb6O
 xvo0Z0/jcBhF2L+6yD/7L5yV2pvYdq/+NtGe7fBijc24rruW09LcLxCpAZO+Yht3zerB
 WnnA==
X-Gm-Message-State: AOJu0YwfiM8CZEnAlD4yMaCX/ddfkJsbQmYPURnkhBgzCqBHOQ4iIvYg
 B+5p7ThBMY2k1AV8QHK3EGwq2oSLk7UnkBI4EBJ/avzACAjUb9BVxlMFw/t3i1PGv9hz/4SeDpc
 M1Ygz
X-Gm-Gg: ASbGncsT6/bWeTQRQRlcqX8CJx4KDJjQszpNwLRWYEUUw3DlGEWSu+H/odUGXnte82V
 TTDVfbpopgoEFfElBQc71OlnsyjBJLjtLRs6ZcpQfR7u/87VfeVhGqwINdFOYy0G716vYYcLo5r
 4ahY3MPmaallNXVCbZPcS3mkAc6ZMvcWp+KO6o/w7gL0YycnVDKGxdGvnMGeLVXEXHBmvSyUJOh
 ZpQV2hUpI2z8Z69vPhWdca1zdBUy7uPOV2gmV4ZwpVLA9CpOXPCUy/YowXXt14eVnK9XfPYQ2Pn
 B/05wR7xeFlR5PjP25B7W+vt75A+pjTAtmHaLLWY94zb82aFPsI3pUaRZvj52i7m0YygVgt/HAR
 mjX1if2NCzj+xo7b6gy0P
X-Google-Smtp-Source: AGHT+IHapHY14W/TxmnIG347DkCvCbHWhYpSfV3/icKB1c+xbM5wWkDEzgS+4rmyJEYpfSe7c05rvA==
X-Received: by 2002:a05:6a20:9148:b0:21f:419f:9019 with SMTP id
 adf61e73a8af0-22026e95549mr11650424637.21.1750549862202; 
 Sat, 21 Jun 2025 16:51:02 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.51.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:51:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 036/101] target/arm: Implement SME2 BFDOT
Date: Sat, 21 Jun 2025 16:49:32 -0700
Message-ID: <20250621235037.74091-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
 target/arm/tcg/translate-sme.c | 17 +++++++++++++++++
 target/arm/tcg/sme.decode      |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 607dd2a928..f4467d13c6 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -862,3 +862,20 @@ static bool do_fdot_nx(DisasContext *s, arg_azx_n *a)
 }
 
 TRANS_FEAT(FDOT_nx, aa64_sme2, do_fdot_nx, a)
+
+static bool do_bfdot(DisasContext *s, arg_azz_n *a, bool multi)
+{
+    return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, 0, 0,
+                         multi, FPST_ENV, gen_helper_gvec_bfdot);
+}
+
+TRANS_FEAT(BFDOT_n1, aa64_sme2, do_bfdot, a, false)
+TRANS_FEAT(BFDOT_nn, aa64_sme2, do_bfdot, a, true)
+
+static bool do_bfdot_nx(DisasContext *s, arg_azx_n *a)
+{
+    return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, a->idx, 0,
+                         false, FPST_ENV, gen_helper_gvec_bfdot_idx);
+}
+
+TRANS_FEAT(BFDOT_nx, aa64_sme2, do_bfdot_nx, a)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index a2b93519c4..18e625605f 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -288,6 +288,9 @@ BFMLSL_n1       11000001 001 1 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=4
 FDOT_n1         11000001 001 0 .... 0 .. 100 ..... 00 ...   @azz_nx1_o3 n=2
 FDOT_n1         11000001 001 1 .... 0 .. 100 ..... 00 ...   @azz_nx1_o3 n=4
 
+BFDOT_n1        11000001 001 0 .... 0 .. 100 ..... 10 ...   @azz_nx1_o3 n=2
+BFDOT_n1        11000001 001 1 .... 0 .. 100 ..... 10 ...   @azz_nx1_o3 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -328,6 +331,9 @@ BFMLSL_nn       11000001 101 ...01 0 .. 010 ...00 110 ..    @azz_4x4_o2x2
 FDOT_nn         11000001 101 ....0 0 .. 100 ....0 00 ...    @azz_2x2_o3
 FDOT_nn         11000001 101 ...01 0 .. 100 ...00 00 ...    @azz_4x4_o3
 
+BFDOT_nn        11000001 101 ....0 0 .. 100 ....0 10 ...    @azz_2x2_o3
+BFDOT_nn        11000001 101 ...01 0 .. 100 ...00 10 ...    @azz_4x4_o3
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
@@ -365,3 +371,6 @@ BFMLSL_nx       11000001 1001 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_o2x2
 
 FDOT_nx         11000001 0101 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_i2_o3
 FDOT_nx         11000001 0101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_i2_o3
+
+BFDOT_nx        11000001 0101 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_i2_o3
+BFDOT_nx        11000001 0101 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_i2_o3
-- 
2.43.0


