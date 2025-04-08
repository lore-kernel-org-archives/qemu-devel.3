Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FE1C369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u26NU-0005BE-MA; Tue, 08 Apr 2025 06:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26N5-00053O-QD
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:40:04 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26N3-00086x-DX
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:39:59 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso7225615b3a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 03:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744108794; x=1744713594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okfLtsNaV9KLOy69h7OWfmHmqJ33rwhMC2cNzNSxGPw=;
 b=cSQV40d1ENJ5JUMk9cpGf788gBAOmTiOq/1sOpusEou4lAhd+Z4Vry0kfJpuCU21hO
 yQ8Gq22vaFBSFLYXZgcxmAWCGQiO9KOQ9UgyqKjQ7mQf8Wg1E61zHZ1GAclRRoig6Omt
 zRDWr1i3J1WOFxqMl08+wk+hgOsG0Rv9hFeuPqb324mPaSU+96Gt1tXX27DjpHn+LIhL
 k1TgyvCzl1+NSwfaIMGB6zM+EvYvx1b93CguaXWVjiV5CvYtYbdzZ9w9Qudzlk9bFxKC
 AXjR+AicvjjjEQL3PvEE2Wi+vX301mN6rRAJK04ITr0BF+D+Y+WH3ktF23OM+2mckr+W
 Nw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744108794; x=1744713594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=okfLtsNaV9KLOy69h7OWfmHmqJ33rwhMC2cNzNSxGPw=;
 b=m6g+HHOTOi4n7RVPNqIsCs4McT1rGxjS3eOR9gxZAJJmqZL3mzWtcDNjTHSYXmSli8
 p9Xk95sQx2pFaJfv1p6Z/miTEMf2uxyrpVJORH5RMQHCrXCwGP0W/xEy8FAEQHMHnHmZ
 wLL6zzuk4KO3p+rfIlG6ClvZNjE98k5BgEVwde8fJZcPj81j4YPCvUe0kf8QXMtj+qp5
 s7r2q8mCzOz5cqAb8GuqNG9RnnjyyXjgY6Aq2+kKNg5FoOO26e7hv6U5xGx86GGhaas3
 Y34JIP7fwAP9mqFgdTfcsdI/Fk8jtQpwWnDZ5tIaGMkRoAJztj97b/c//r3FG3QGIObI
 hPjQ==
X-Gm-Message-State: AOJu0YwYsiNpmAMR2qU9JWCyIEeEN7X7fBitbI3L2/Q4VrgOrVK42tlk
 38NUHhEMHDR3dS/1JMjbfPa781Q13EpmOlVK6xh/pVVFkToTeb5wcSQrIvbbcssdV5UVb7CrQIU
 huZf1+whdYZ5VAITHawC8b8XEgKQL3sXKFV66tEgfoHR9OOfauQFMX2z0QbDaT3KnpaKYHKLAXT
 RVevR9cgTn7oboJWlhVZVLmOC/zSPvjSG17vglC6e0
X-Gm-Gg: ASbGncsIVAWGOWOmoxWEqVsD+4XL18AoFfbulHDNKlPkKOhA4uMEuK50M/U6EK65Hof
 vZw6dN2JaTZM+rAduQEliV2KSnxPS+Xi+yC0xUgR0pXyVh9mm1JhjUmwRcN8BrImmbEQbp15D03
 iwTI16oVNVhiuQrL5XvEnLrvrUyOevK2uJNcRZgWWIPzvBhln8bHle0kUxRtATvmgT8/6rDgGny
 BAsmazZtBaJohYkqjHRDRPDzutW8HK8IBc68sYjt5Y7b78hfKd8aLF4nbW3YWxbpawZpJpHaMp3
 P0HCwPGC8X2ITHQh7dgkpj+jXZQnzWoRW42/InXlDreqUSOaRo9RK3WUGM0AdnVfTE4vLhraTK2
 HpbaQo3QqC+EDJA==
X-Google-Smtp-Source: AGHT+IFfdikpRXZD35UWQJA45o4VqkFmblaYmnCITK/HYBRzCX9f8E69YszvV3ZcOEhvIbCmXCgaLg==
X-Received: by 2002:a05:6a00:2381:b0:735:d89c:4b8e with SMTP id
 d2e1a72fcca58-739e48cf25bmr19502763b3a.5.1744108793600; 
 Tue, 08 Apr 2025 03:39:53 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0e3734sm10532380b3a.179.2025.04.08.03.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 03:39:53 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 01/10] target/riscv: rvv: Source vector registers cannot
 overlap mask register
Date: Tue,  8 Apr 2025 18:39:29 +0800
Message-ID: <20250408103938.3623486-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408103938.3623486-1-max.chou@sifive.com>
References: <20250408103938.3623486-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x431.google.com
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

From: Anton Blanchard <antonb@tenstorrent.com>

Add the relevant ISA paragraphs explaining why source (and destination)
registers cannot overlap the mask register.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 29 ++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b9883a5d323..20b1cb127b4 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -100,10 +100,33 @@ static bool require_scale_rvfmin(DisasContext *s)
     }
 }
 
-/* Destination vector register group cannot overlap source mask register. */
-static bool require_vm(int vm, int vd)
+/*
+ * Source and destination vector register groups cannot overlap source mask
+ * register:
+ *
+ * A vector register cannot be used to provide source operands with more than
+ * one EEW for a single instruction. A mask register source is considered to
+ * have EEW=1 for this constraint. An encoding that would result in the same
+ * vector register being read with two or more different EEWs, including when
+ * the vector register appears at different positions within two or more vector
+ * register groups, is reserved.
+ * (Section 5.2)
+ *
+ * A destination vector register group can overlap a source vector
+ * register group only if one of the following holds:
+ *  1. The destination EEW equals the source EEW.
+ *  2. The destination EEW is smaller than the source EEW and the overlap
+ *     is in the lowest-numbered part of the source register group.
+ *  3. The destination EEW is greater than the source EEW, the source EMUL
+ *     is at least 1, and the overlap is in the highest-numbered part of
+ *     the destination register group.
+ * For the purpose of determining register group overlap constraints, mask
+ * elements have EEW=1.
+ * (Section 5.2)
+ */
+static bool require_vm(int vm, int v)
 {
-    return (vm != 0 || vd != 0);
+    return (vm != 0 || v != 0);
 }
 
 static bool require_nf(int vd, int nf, int lmul)
-- 
2.43.0


