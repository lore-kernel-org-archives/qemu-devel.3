Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557F3C36013
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 14:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyXR7-000851-Go; Sat, 29 Mar 2025 10:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXQr-0007vE-Nh
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:13 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXQp-0004QA-Td
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:09 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-303a66af07eso4431155a91.2
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1743259506; x=1743864306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJ/gCap1AeI74yWY6W4cGphoViTS/8uzBKN9k5Sz4tQ=;
 b=fo8rj4ewtTzdlBIt69nq27N//6Zyb5xKGwmpX8Fd5wl2+2mVhc6+OeR3iweo6PFLHc
 y8JImc+dM51z0C2FA/qLAGUNSyeyZ8GjBVsvc1VBW7HOz1HMZzCl36HI/2VAI8ifhG9e
 N3awxKG7aS9K6b9IuVpENBeDnJuZt74J4eMeBlu6ZnH46bRuNC4ioY9K/ziLxeAXbMpo
 uD1Sa8xLOSf/aOPl4VOxs2jZMyl0j66gi8oUOVaEoa2wGvT5l0vK9KGG9cSMoBvF2wxz
 0SQ9oJeWSZ4UW3952x0Un46FW1iWiH/kgkAJH0ffGl2sX4QiKMA0bLOYiCrzInlYAJUU
 WPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743259506; x=1743864306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJ/gCap1AeI74yWY6W4cGphoViTS/8uzBKN9k5Sz4tQ=;
 b=IqvpQBlRLAXADM5qu6YKyu8yGPFjo+SlymzN7o7axm1qk8Aqd1HPKMtuHKhFew/Qpa
 rTqbvOkhpwArX345J/Osa/dHdaTxJPRs+FhldqzmH+3l4Y8DcLOuCiEUeRTgd7vaCUdZ
 1bVaWcI0gagXWeEXEAciHuIOOFZD/tFie2bsTGvX36YXKkynPM78FSaquZOqL3tPcPIG
 9ZDkK3P7U61SMnCryMtLWRaQLjNg0tZ+6GHLq7HMJ+EXcjBj/kECyZAFU4rva9Etr4NA
 +fyHbp1e8zf6dsNCs5wtsraygUD2TYkvgT8RgnkbWDLD9xpvJjiqj/X13CdC3Fn5pUfa
 aAqw==
X-Gm-Message-State: AOJu0YzqSOqoFgiT52FfaO1d5q/YSrgiieLreataENOuPaw6selRDnfR
 mlSKg6RmifRdKEXhgDZnhnXfB3aqvRM5hFVfw+UQvpb5tI/NTPX8TPCTV8XPFrQqUMPyFFXQXUV
 qCOMqCIoffAm1o88sbzgzMO9F8Bsbx5MB4pWCGObL03XqUSHcKFvjkmhMvj/qw0mk8Tr+DH0OXq
 NONBvtsqGDsC5x2/yn9YJkZ/g53mK62WL5TD17NA==
X-Gm-Gg: ASbGncv7uYhNtU/c8aGoipVFtTPpKGoVMpEeUrEQbSUc2C09WzY6u9XSvAxitQszpGi
 1Emy+E3ZM0Ej/YOXi5hhslEHGn9YmMeIaV3Xq/TQaSBe7b2T8O4IE33x2incE7ariX3eEx8M/N5
 NhX81IntyfPWqLJGUDKnYPMyJaF9bzMICkAuI9jnLbGayWYvmmttPfgpjqjAwBGaf6TpVB3nGhq
 lEkWJkVKWwJCNJgF9w+R2YeVx+2nf9gJW7dO/UjB/+zZ4kKDtW6oFzmGustZDA/gUcT9nPIZfcE
 gnXw25Qb/aQ81jVkgOsGBqJK9ZZrnMc4jmh0A2GJ77c5i/xqGa7srI5SOZvqhte8LFTRs6IcPsR
 D1uMO8Jx5LMxLqg==
X-Google-Smtp-Source: AGHT+IG4B3/d28bcXvXr8RnwM5+Aaf708a9yRJosrpJDUltHJfSKGjdCLFKzV89V02oXWQg6s8m4Fg==
X-Received: by 2002:a17:90b:2641:b0:2ee:90a1:5d42 with SMTP id
 98e67ed59e1d1-30531e8873emr5979072a91.0.1743259505950; 
 Sat, 29 Mar 2025 07:45:05 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f6b6bcbsm6737196a91.45.2025.03.29.07.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 07:45:05 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 04/12] target/riscv: rvv: Apply vext_check_input_eew to
 vector register gather instructions
Date: Sat, 29 Mar 2025 22:44:38 +0800
Message-ID: <20250329144446.2619306-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250329144446.2619306-1-max.chou@sifive.com>
References: <20250329144446.2619306-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1035.google.com
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

Handle the overlap of source registers with different EEWs.
The vs1 EEW of vrgatherei16.vv is 16.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Co-authored-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 70c19c49ae4..4a0c9fbeff3 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3478,6 +3478,7 @@ static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
+           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew, a->vm) &&
            require_align(a->rd, s->lmul) &&
            require_align(a->rs1, s->lmul) &&
            require_align(a->rs2, s->lmul) &&
@@ -3490,6 +3491,7 @@ static bool vrgatherei16_vv_check(DisasContext *s, arg_rmrr *a)
     int8_t emul = MO_16 - s->sew + s->lmul;
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
+           vext_check_input_eew(s, a->rs1, MO_16, a->rs2, s->sew, a->vm) &&
            (emul >= -3 && emul <= 3) &&
            require_align(a->rd, s->lmul) &&
            require_align(a->rs1, emul) &&
@@ -3509,6 +3511,7 @@ static bool vrgather_vx_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
+           vext_check_input_eew(s, -1, MO_64, a->rs2, s->sew, a->vm) &&
            require_align(a->rd, s->lmul) &&
            require_align(a->rs2, s->lmul) &&
            (a->rd != a->rs2) &&
-- 
2.43.0


