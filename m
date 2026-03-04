Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA35EF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmTJ-0007CX-N8; Wed, 04 Mar 2026 08:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSg-00070O-V3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:32 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSe-0005FC-KM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:26 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so7230322b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772631623; x=1773236423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRsjV/mz2UynU8xkVuTY7bpWJP/z7vg2veO1oJFHtwg=;
 b=JXwvEROkUr/NiJt6FYQSHsLUAE5yykqvNgXYKfExG6htzbI5fswgTYJPVk6DWkIQ/r
 w8R9AN4YiSe6Z/sUjNBqMcc0Z5DtNTzgrZ5S/vdN4gg7iN2kzFc8viULNlMeGyd6MA7J
 hT8dRPmtmSVdfQ+Y1uTdOuKQ5tj6pERDVzhZbd+zhtcHuhxlC83qrzeqy2hzit/q3Nqp
 P+yll4xYTwcZ8lKVK9Zg9sIGbvI0JwGIRbFb6YDTU+cO93zaavov22GygIyPbYrGsotd
 HBdBPiuz6mCDDVVFRF596+64vV/RE8p8L0q6jwaiyUCjhe8I9Hf0bxCy7thdZAd+uog1
 zTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631623; x=1773236423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CRsjV/mz2UynU8xkVuTY7bpWJP/z7vg2veO1oJFHtwg=;
 b=iEqwJ+wGezBIlnyGr9/SiEFsEYxncLVG1FDKCQXOYo6wpF+1XSLpzXZgjTPEvKsn6o
 apEz1MZkYpoP8jyX8/PFfmDb5eRC1dl3XYW/hYoTdsG0i1aCoEADOSkxLBrQZXNFja+P
 D9usfpXkOrKjdVlNulD3jlnphEArEW9scteIIsl4efq5bCjGy5fvUx30W1Oi6IFKBrf/
 qSmz1Ci+lkkds997wAR30UagMEL6j2CXvERP+B3Js604aHVPotO5hVkxwxX64Hh99zbB
 z3ujVzUznfaWXqXXVXgy/nKbnECBW7bNF5x71v4eZM4oI1V+q9Lp+mwUqI+V/B5QPUPZ
 mm/Q==
X-Gm-Message-State: AOJu0YxDUYQ+g/0cnNG72G1jjRIenok3VQ5WbeBYj/KfHmw9Qb+27dfD
 WTA0oqYFQLCiXbFbugFeyvxju/tSCd8/b0Qgv2dk0Td6S6V6khVK1mfktYjRteHjSyVG14eovls
 /bfVdEx3Hj5XGVNtKiMFhK9az6DYR1DqGi2aOBzuDuoyoAATFbzvH0NNmFdac1/vdRBj6eiBoBr
 K8QaqxbNrfHma/7h5gasU5+jRBJ7Qy+XzZD9SjrPApCw==
X-Gm-Gg: ATEYQzxLPw2rkj0hIjcWXjQw2MhojbPnvuhublNk1ihFhO6Oe4u4pDitJSJZ/X7bVyq
 UOB6TMzHYdZcm/JWex4kjmvfrojxtY+2XPgQJ5mWyC88vZvTz/Cg2Hel35wdVoQ60kM66NmgMvJ
 zd0ShW8D0h2xtFyOeIIMKuuP0LCyKgNzwFRjthhewOduD2eQm3p/GZKDa/fvvhjHLaFWipmRtu3
 NsvqYu6KHnS68Dafag+eftbw28sgqkM1pw0LUy6sDgb8ctPfz1SYHoci3GYl/Mut6s9a079GCbN
 39Ck09qSH3kGm8NlIl5uYZQ4TEJdGzmgMlhoQEtk+BmH3HWNI7JjKb6brv9CZCyuKGpKj2WP83v
 dDQpj+sMDrc+e4K1D36Yh3JFFxj+T8/iLfCpN7AXTJSUuF/tMhlfAIItLWutjRJo0DlTcXHe0Mp
 ek5VwVu0FmhwkHdB7YSA5iKFy2I3MRYgLu+KDnALl3rc9Rp7bkHPNP8QtY8MZ4mUiHy9we0IhM3
 BdBwtxgAnUWaUujxeN4A0eXqkcRI3m0PhnixQ==
X-Received: by 2002:a05:6a00:6ca6:b0:824:a01f:6335 with SMTP id
 d2e1a72fcca58-82972b31ca5mr1680293b3a.22.1772631623075; 
 Wed, 04 Mar 2026 05:40:23 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e11bf5dsm251921b3a.28.2026.03.04.05.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:40:22 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 01/14] target/riscv: rvv: Fix NOP_UU_B vs2 width
Date: Wed,  4 Mar 2026 21:39:53 +0800
Message-ID: <20260304134006.2908449-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42a.google.com
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

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index f75177b0fc..b2315ecf9c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4982,7 +4982,7 @@ GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v, 4)
 
 /* Narrowing Floating-Point/Integer Type-Convert Instructions */
 /* (TD, T2, TX2) */
-#define NOP_UU_B uint8_t,  uint16_t, uint32_t
+#define NOP_UU_B uint8_t,  uint16_t, uint16_t
 #define NOP_UU_H uint16_t, uint32_t, uint32_t
 #define NOP_UU_W uint32_t, uint64_t, uint64_t
 /* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
-- 
2.52.0


