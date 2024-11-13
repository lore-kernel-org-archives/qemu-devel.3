Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB762D637A1
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 17:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBH0o-0000Hg-1h; Wed, 13 Nov 2024 12:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0h-0000FN-OM
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:33 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0g-0003nJ-BQ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:31 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21145812538so66631935ad.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 09:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731518308; x=1732123108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/LTsgycx238NK4SFPWzXaAV3vV2r5w2wkO+45OR4ay4=;
 b=MR1kcmN/aU9MSI16Fsr2YxjhkGwGRVcuJsUbEnA8p80yuuW9GbFbi1XJEuFb5HeqsH
 VRmUZF4zPPyhZd1On+djI+wxU+5O/y6e4he8BTk8CT348veTKCVUiGdD+y7uUjTq7KhG
 qzQgGXfBKil5vPmKad604UE5H1G1PHjQwR2uIZUsrXZ46WC8F8XYBVbDN59w1VbPutM0
 NDDZOUSuEHOKr23yBIvLRsWb7FjSBQlwH7CuPw12X/ijJZQsKtkyjy1e3pFjk4yorjmo
 ydG+2SxzBNkDvY3r1nEM284VRQW9myTPd8MxqIdZ+Zq0KUbsUjmzRMX1zZ0xJHb9kZ1q
 mTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731518308; x=1732123108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/LTsgycx238NK4SFPWzXaAV3vV2r5w2wkO+45OR4ay4=;
 b=I+CfpwiI+umh5SFmGeNziH6inE/+KqkcYSiyaltAI26VIM1AfCzV8mo4JjogYHvrqp
 gXX7aWYcJlN69Mc0n5Vg8YWg9pRLTO2fljQb0a5+KycZgf5cPn0o1cUpvOsmHk4qIP86
 DKONiHSZcobbOEjyW3l2PYBTZ27eoibchhmGBQ2FUunHjVH8YDFX0YbXlPawgpQqs4lv
 qAH0p1SI2P1GtgMIpriYt1qSkaWOVJruKY1leKGyi1uXRzoMYjSjQemPa6Eg3XjYtVco
 Y3UrFwBw+sfJnJNizlofdxjbbT0W2dXC2CJtYytf3hlT9/XhqNaVgPCd7OkwdMyxIgKf
 e1KA==
X-Gm-Message-State: AOJu0YxGkN/Tg96+JosiQZmnZl3bLw9SpRThSidUe9gw8GA/8uTVi2gR
 cAE5kCws/FutRW2dS0HIsq5GTK01Id/6LsDAPuHHZN7XYDyLm36Ky1erXFcWBu86oRbyx8dJ2T1
 1
X-Google-Smtp-Source: AGHT+IE46CKv1B78UNZ1wO7vYUtMANQLWLDQsMfCdeOccvO9k0FH0UO3K8gH6qHUApStNTUWLmzu9w==
X-Received: by 2002:a17:903:2448:b0:20c:f27f:fbf with SMTP id
 d9443c01a7336-21183ceaa93mr302841835ad.25.1731518308018; 
 Wed, 13 Nov 2024 09:18:28 -0800 (PST)
Received: from grind.. ([187.101.65.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9063sm13392889b3a.75.2024.11.13.09.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:18:27 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 8/9] target/riscv: add shgatpa
Date: Wed, 13 Nov 2024 14:17:54 -0300
Message-ID: <20241113171755.978109-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113171755.978109-1-dbarboza@ventanamicro.com>
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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

shgatpa is defined in RVA22 as:

"For each supported virtual memory scheme SvNN supported in satp, the
corresponding hgatp SvNNx4 mode must be supported. The hgatp mode Bare
must also be supported."

Claim support for shgatpa since this is always true for TCG.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 068b019564..fff7010647 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
-- 
2.47.0


