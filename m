Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE55CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 20:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urMse-0003pR-MX; Wed, 27 Aug 2025 16:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stove@rivosinc.com>)
 id 1urMsb-0003mu-Eh
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 16:36:25 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stove@rivosinc.com>)
 id 1urMsY-0002S5-FD
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 16:36:24 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-771ff6f117aso293496b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc.com; s=google; t=1756326979; x=1756931779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Ddve7p4fI8qnHNRjLS5NATRfUqe+W6ozPOkYas4euQ=;
 b=J/xpgUX+OUnvJfcyFlg0W+gYkrNX+wjUs4uf9FLZC6zZtYyYFnROFu3Jw3b9F7xDLW
 wI/K06JV6u2L1bxk5ob9UTxwcDFhii+8ix0bkOPnonrD2tmJ2fNrbKIQVtJYCpNtyHW9
 Gpk4aPLb4x339XPRSLEmit6NhO/zFjmqdHi0Nv646eYzREK3rlZSMpC6ykz986OD7NtO
 oQdlBQiQWhjBSLhbMnLH1+Ym5FPLjJfePTB3BId2Va2/ddx/XnxH67r+nS88T6Pb0TUe
 dp4B37VMgW7Fyk7bJszxIus6rKZxTW4fgSwaqQDEvodQB4TyrjyG7tLa1z9hbhDZO4QC
 xbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756326979; x=1756931779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Ddve7p4fI8qnHNRjLS5NATRfUqe+W6ozPOkYas4euQ=;
 b=BKq5su5ZRhkQY/HTpCdEid8kru9KdugorroLsygxElEG3C3ZCOf1lSfY66/j1JGKRi
 kVKP6eu/98bn9lFMO98w/v39e3QWnWu2iIHTQqsYQhhFQh2hCOpmJExmzbwJ4+DProiR
 Liug/ijt6TPYIwLcP0l+ofCsfb1+0MkwpquRz3LrTy1jiGOrdkFoQXz0Ad4BUOHSKF68
 HYglTH3SDpnTPtZimMaD4TDPErGoNMk0ae/E+EjJxFQAX7AZxELKtJ55BX/ExTy4l54D
 6yBHK55a8/1Bt0N7Uk81SkBaDtsLB9n9dV8zJzb/t+uOHvzg+WeAtQRhSUUQpjg6ict5
 QWtQ==
X-Gm-Message-State: AOJu0YyiR3x1i3hSUM3rYi7YpQ8Xw5m3YJSgbYPvCOfDoPBrZFAdqLCI
 V2/04phrg4tPj0ch2qM2tXTcLTzwiDHQQYZqzasLpt2pmEsEOilbEd2aTfm3wB3kL38/JDgdxv4
 WypN5byM=
X-Gm-Gg: ASbGncursg1MoZkjWSk9zRPFRjxgJd1+KKB2te5S8i1/QRdL/hQPLn8puML5CDMNwAB
 /aoP/RlDNLvFdv5nN0EQtWkmM9ot8pK613dq6XI/zCyyn9i0JNQACu+XGXg+lvxTZXP5N2s+zwn
 opLd17dLVIvtSXB/Z1KN7ncaUHQuZteFmzb+ExkgpIp2U+S/XyAiccTy/GnunZyrx0RXuOc7Shg
 9i6UWG+41MuBKLpilN0FkvN88xSg/PQX7C1szO4XaZ8XDWr/4NSvgicLGZiNNDJyen4OdtRZtLT
 yxRtDUT/rdPWhJ0/nFxq2Wqi+E/yGq35CRlucrelO6RkC8xv8wrpXAObH3HbwfE9u5Ri7MEyOzp
 1o+uvUuFZ9PlZB2l382SmSC5mv185qDrHuh8hgDuL
X-Google-Smtp-Source: AGHT+IFx+fyEmVZjkee3XZtmXtLNubdmYGpTt4glOlJ629w74cDd8GBr0FIJTxAK3IhQosGL0NIkPQ==
X-Received: by 2002:a05:6a00:99d:b0:771:58e:5b10 with SMTP id
 d2e1a72fcca58-771058e5ff3mr16281797b3a.8.1756326978817; 
 Wed, 27 Aug 2025 13:36:18 -0700 (PDT)
Received: from mbp-nixosvm.ph.rivosinc.com ([12.151.45.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771fc95888dsm4959732b3a.89.2025.08.27.13.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 13:36:18 -0700 (PDT)
From: stove <stove@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 stove <stove@rivosinc.com>
Subject: [PATCH] target/riscv: use riscv_csrr in riscv_csr_read
Date: Wed, 27 Aug 2025 13:36:17 -0700
Message-ID: <20250827203617.79947-1-stove@rivosinc.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=stove@rivosinc.com; helo=mail-pf1-x434.google.com
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

Commit 38c83e8d3a33 ("target/riscv: raise an exception when CSRRS/CSRRC
writes a read-only CSR") changed the behavior of riscv_csrrw, which
would formerly be treated as read-only if the write mask were set to 0.

Fixes an exception being raised when accessing read-only vector CSRs
like vtype.

Fixes: 38c83e8d3a33 ("target/riscv: raise an exception when CSRRS/CSRRC writes a read-only CSR")

Signed-off-by: stove <stove@rivosinc.com>
---
 target/riscv/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4a862da615..dca8edff6d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -873,7 +873,7 @@ static inline void riscv_csr_write(CPURISCVState *env, int csrno,
 static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
 {
     target_ulong val = 0;
-    riscv_csrrw(env, csrno, &val, 0, 0, 0);
+    riscv_csrr(env, csrno, &val);
     return val;
 }
 
-- 
2.50.1


