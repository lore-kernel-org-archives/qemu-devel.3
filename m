Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402BFCD6E55
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrZ-0000RM-85; Sat, 30 May 2026 19:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrU-0000Lf-QM
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:00 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrT-0007ai-0z
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:00 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8423efad617so39549b3a.0
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182777; x=1780787577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxaQcX3SsrNf12ryZ3sI2+knj5jWNC9sXQqDHj+8xnE=;
 b=de3uq6qclHN3K+LqU/UX1nQt0gKRil4zfDPf+y6lgIynBaITVLnq9s8I475Xjag5tY
 43G5iZjiKIqbnJ6T5qNQYuP/4jR509KY2OQaGUbdmcL2kKhisRLqtAMvP/29YF2nIaFP
 XMgt0n+ty9rOSf5XW1sHTaGd8f3makadrjGZiu0AHRQB4JoRrdRuCJR32d3lz/5NFs94
 HTJPOmXvV5f34bcoqhWGHgvkzBQiFtvfGiIXBEO9I7+6lIJ8/tWiOtD1bP5dmEJrMjIn
 YZzRbw2G5b1rzoViAJUZTi7MVjDOcH0WzPQkuEynvVtV9ikcm9bao+xuzp3SZsc41tDQ
 2lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182777; x=1780787577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zxaQcX3SsrNf12ryZ3sI2+knj5jWNC9sXQqDHj+8xnE=;
 b=n4ycn9ZpHqnD/1Yr+M8ygcHCYFdZPTX2fd34pQyt6EqO1i7/mZy3nb1IZdmjWSTby+
 YjEdm6fi8EQwth9WyFSXykxtgYLm1g0QjMuyJDQ80rCU7mT4czcCUErkCtNyaq4+IXQq
 qQVP/DNnO2Jk0Q4nU/btn8UXtHL9FYRbWoyjdrIv2Pu86bARkq6jLZiR0MGclp60JjHi
 Wx9r7NTnKqCoINA7dsBTwEfR2MeroHwAhmcKPHCVT1My20lnwFcmsjgDAyUowavxW4sC
 IJA8EzsqxVuKRxxo73wQ7FHE+Q4HS/D47LQZwRxqmr22pgYILv4znh5zNrXEafcqzJ34
 sjbw==
X-Gm-Message-State: AOJu0YzpMp36vHuhl+iCqS/JhK5A7VlkjDnk9MVDCTALkrGdZ0UQK4XH
 vnzyDhiSDMqiu+e4gj09ik+T8z1j+PjNq6yjWfzATlv4921OCOmTX1znindmrQWtPclWmbqX18o
 uZXlURYY=
X-Gm-Gg: Acq92OHwUGeTaFBD+E41FbSOXeoTVq6BKaqW/v9K34e1J84SgyTBIPTkCZpFETq+S4h
 YYEgGQrpZh1MrMJvI7f5x00cSj3srMqsM66aIgvp8rPrgCJr4VHsvXNRo6YHQVJBSlaO3YgaIhA
 1NoSY84EpSLUncUmAkSBoLfvOXOARw7LU+TFP9Ivy7wduP2kMKQEHkfYA+A8o+O4Azubq0o5DwR
 ECXmY7lTxzn8JqlauH+V+cp6J5CNaMeH2tY+T4uu552H/hfYmv0+6EEiLWum24gL032UJflTRbq
 nVyWSKM7YG3GHrk+FbYjfEvokR0sLo/DskjLf4oJfhjtNlA4n8CX+4IYI3m6ynFHZrzRBhWGnLS
 gCFUh98W/q2ERPk5qvQj8lnY8seVPAcxIP7QrWv6eg2iYLm3tzHfzpAXn5fTgQJUusi2kD0xunS
 0/L9uOB84d4rsz/ELW8LqwdAlBi0MYJ3eOSQXDFtU=
X-Received: by 2002:a05:6300:6701:b0:39b:e9e1:699f with SMTP id
 adf61e73a8af0-3b427eab30fmr5355167637.12.1780182777357; 
 Sat, 30 May 2026 16:12:57 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 28/41] target/arm: Implement FMLALL{BB,BT,TB,TT} for SVE
Date: Sat, 30 May 2026 16:12:16 -0700
Message-ID: <20260530231229.400441-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 target/arm/tcg/translate-sve.c | 3 +++
 target/arm/tcg/sve.decode      | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 1044b81c95..95ec3a011e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8388,3 +8388,6 @@ static bool do_fmla_fp8(DisasContext *s, arg_rxx *a, gen_helper_gvec_3_ptr *fn)
 
 TRANS(FMLAL_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
 TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
+
+TRANS(FMLALL_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
+TRANS(FMLALL_idx_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 71ec09393c..06bbd7fa63 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1868,6 +1868,8 @@ BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 FMLAL_hb        01100100 10 1 rm:5 100 idxn:1 10 rn:5 rd:5 &rxx idxm=0
 
+FMLALL_sb       01100100 00 1 rm:5 10 idxn:2  10 rn:5 rd:5 &rxx idxm=0
+
 ### SVE2 floating-point dot-product
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
@@ -1887,6 +1889,9 @@ BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 FMLAL_idx_hb    01100100 idxn:1 01 .. rm:3 0101 .. rn:5 rd:5 \
                 &rxx idxm=%index4_19_10
 
+FMLALL_idx_sb   01100100 idxn:2  1 .. rm:3 1100 .. rn:5 rd:5 \
+                &rxx idxm=%index4_19_10
+
 ### SVE2 floating-point dot-product (indexed)
 
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
-- 
2.43.0


