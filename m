Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079F9CD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDNl-00024F-OV; Thu, 21 May 2026 20:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNX-0001n0-S3
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:47 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNV-0003TN-PG
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:39 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2be1dd4af34so52051335ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408276; x=1780013076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A7alx0+02PMyVUgvsTRQOtKbrrppoNwd8llf9GqqSGY=;
 b=YUavIcy4KNEv826bmRhJryZ4SH8TxCYZY1iLxcpgSjaRpPrOBnMpxGdM3sf+3zXO3A
 AsHrLOoC/oSp1S9Ldrl6GSXIr7I/9WZXSNDO7ao5nTEM+9edVHNjqkZjQX3+Phul2TPJ
 gVIFaOmbqn9tw9kWMvcyvt/3Dc9b0Q48rhYLAXmfdTJyqyhTZqERIi8bOL3uQw20YR9B
 6gwN9GI/LQZNaqRVvMq/Z54cQifrn6VAYMw38ZpF4+HTb8fA4AXAZq173r7BnYLS4ksG
 tc7z+WrZ1tEEp0vojV4FvwjxPcMmCw6L2rNN3W3HjkC0mweXMvVWBAl2tvYic32SPajF
 joRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408276; x=1780013076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A7alx0+02PMyVUgvsTRQOtKbrrppoNwd8llf9GqqSGY=;
 b=isB9RWf6Viith8LbASBEhIfrzZMAJjcsmd2YQR4vMrHYw9pUnYhcKLDUM5aWsRSGfc
 9lA5ExbeyDpfWB8NP4RXl7bh+Olpb6ykVcxb8e2AkgIpQTzAZOC9iRyESc9U9PJ3xO/T
 XOs0rEFnFUCdWBdzVMd2oHTmMYTXHtw6vv+vRJbx6+GIsKX/ta4RKO/H0xlGw+hMlhxk
 L/c04oO4JZIHiUEdgNZs64059rw/ZL1fqADCOprBMciH/YlYgGypiJVZ0+awMKQW0QOp
 R8/kSP+RxR5XlYLgPPPxDXRtwpdfCrN7yjkkIU24zEsy8/+bzFF6r980F1XaCSNjweXO
 LOvg==
X-Gm-Message-State: AOJu0Yz/1uKonxKFkAmOq42OiKk4Fn7eKLr1UQi8YVIX6VLqe9KrBn8r
 OciKUjzNPU4ARlqmapT4QyElKU448eezXB8bvRPTbw1Ma+jBJY48X7woanamF9eZ
X-Gm-Gg: Acq92OGKX4CT3mdUWhlHZ+wuZCDKdeSW/6+T+hvzIAklqDK1DDXapZMxkX03+Ku7oQa
 VloXdC1hxWVA/5F6lKA8XM4whWxZDf+4x90jQ5aT69Zp7pHJmRhGTOpaveXTHUmr/QTs6436fb4
 qonessnyjiIosNmd3CWOJ7RNPy57wUQzo7URDkURpNfnUlMpI3JkUvNKn2MkXK2pS4vFCiRX+Pe
 ZtX1jJLkCkVZSYCEq+HHfyNHVQAY13UVbppTGv6RPy5pDUIqDo0C2tZBLuncmNZJTn70t7IuUJJ
 Z2z/77Fvr+Gj0Bvxd43E7cny0+uMHBsoowIw/uOzO0cAmiLRgH1VOb0npGhN0jUAILJblBBrhgk
 fqIWJQkiYaG2OqbRwtPW6n9yO20RR7pW2OLbepNyXeX592S3lJcmpI5g1n5U9z+LD5UDRyYOojC
 YAzDzzIGp7gbAa+MUr35xAzIcjzOH9al6kUrkRajUsTA==
X-Received: by 2002:a17:903:298b:b0:2bd:2de3:51a4 with SMTP id
 d9443c01a7336-2beb0604f43mr11998635ad.27.1779408276462; 
 Thu, 21 May 2026 17:04:36 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:35 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 19/48] target/riscv: Update the local interrupt mask
Date: Fri, 22 May 2026 10:02:55 +1000
Message-ID: <20260522000324.23255-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V spec describes bits 0-15 as standard fixed interrupts. The
AIA spec on the other hand describes bits 0-12 as standard fixed
interrupts. This conflict causes issues for us as we don't dynamically
determine if AIA is enabled when setting the *delegable_ints consts.

This means currently we incorrectly treat the LCOFIP bit as delegable,
even if AIA is disabled, which is incorrect (see the issues mentioned
below).

The AIA spec indicates that implementations can determine which bits of
13-63 in mvien are writable, so let's just make it bits 15-63 to match
the main spec.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3133
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3134
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3135
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3138
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3140
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260513051841.1671987-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7ba4f0383c..b470d37050 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1781,13 +1781,13 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
 #define VSTOPI_NUM_SRCS 5
 
 /*
- * All core local interrupts except the fixed ones 0:12. This macro is for
+ * All core local interrupts except the fixed ones 0:15. This macro is for
  * virtual interrupts logic so please don't change this to avoid messing up
  * the whole support, For reference see AIA spec: `5.3 Interrupt filtering and
  * virtual interrupts for supervisor level` and `6.3.2 Virtual interrupts for
  * VS level`.
  */
-#define LOCAL_INTERRUPTS   (~0x1FFFULL)
+#define LOCAL_INTERRUPTS   (~0xFFFFULL)
 
 static const uint64_t delegable_ints =
     S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;
-- 
2.53.0


