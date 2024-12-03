Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C28E77169
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 23:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIc6i-0001Ps-P7; Tue, 03 Dec 2024 18:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6e-0001NK-OX
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:15:00 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6c-0001Lj-Vl
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:15:00 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-215b4681c94so16277555ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 15:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733267697; x=1733872497;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aWl6RCkJhXh66y8GBilR1MgWBHw1j2MblGEre7+EdBQ=;
 b=rZXRf9yTIGJv7MsL7UnDql1EpyogBiXda0/XEp4g++OTjt4/PZ2sBo4UQaacmGFs5h
 rtKbWq5VRM0VMh0d77AHQax8ZL4RHdyWvoWicluHR1+yIuGiSpDUVbNyC94wGwjb79nS
 Y4Q6dIayOk18EL7Wx4+YGW5g1xGmDf9QucLjLaDsl2xI7mr/UeQHLeoQ3+J9ejhZ5Ut4
 9cK8NAW6THBF8n1f3ySycorgyFxCiBUml7BNqnnV+w2wbm4M/M6+lAcN5tqiGrTtiTR/
 CEzIdnfGr6Q9Pibi6WYbFDQH7jQIpLN/zthvwexGHZ8Iq8/hvNcgji4uF1rHObhkR4mc
 KG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733267697; x=1733872497;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aWl6RCkJhXh66y8GBilR1MgWBHw1j2MblGEre7+EdBQ=;
 b=UzJnNUn1djAC2K/VytHdN5qgMiHxZCy15pogkfrhWmyIqDeUwhDQADA6Dy6V1frmyp
 7H9tdXQKoqrOKOavm9xiFpQS3EDtNVUn6AU1Ntc5iuEqeZAVBTx0HixSSsi0SmDF7DXD
 gC037167pJlvSvg6TRBO9CiRGg12y6M5hmheggTR9LQtwjc9WalziexOD5qs+5KY8d5O
 zuGXtvn7Z4RMOzj3goQCORAxzfu9Xei0UvSfWACGecDCM73BZvkLFWl6B9ep6WDq94P7
 RTOoiE0tBu/7MYVGE3nm+wq7vsIppQ/9lAbwDrmZ4I+et81y5IiMuwbP5uP8+UUi9P5e
 UOsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsK1HD+4shaMj7D02YlgrO3FMOWTISMq89CwxPV+R0zf6z6xoZ7qEqgn+x+d5UOdpgg2pRVOd/HllJ@nongnu.org
X-Gm-Message-State: AOJu0YzsWhYu5nVo4+dA3F3aP2EM58p7WxzB6JA7QMWMSVMPA31oUC04
 2kpVQhfsVq53OLLjO44IHLZwKzGib4QutAVZV/55wXhXf8uYifuE4ZHm/1ofL30vS0ad3Gb9zyu
 1
X-Gm-Gg: ASbGnctZ6Ge53eI8+ElLNzD+dZdYb9piz2oQQOuhu5L8Fn86lHd7VuP4QTm8KcS+t70
 FzSONNWZkkLmWK6zB//RuigNB2UQwCJ5UD7g/pCSrgWAMZV9DjqgOmL3hkB+olo+DLudXXpkZwe
 vbYkVxML75NY0ls0HlO+hkm2msoMLa79jA4zCOR7EHamw2+5w+WsFpD/Xc1yqWlc4nyd+h4zTLi
 IqJGmuVOnRGAGnAOmWv45UfhJKADLAIKz2DjCC+cbW5XJJRnsgcqwz9JkBPUvk=
X-Google-Smtp-Source: AGHT+IGTgPAVT7ZhRnEGuCbEfWRO+19H7I4Dju+xp5TRPG7zndoFEGt0TX6P4HuWJZr2dXM6aitAKg==
X-Received: by 2002:a17:903:2290:b0:215:b473:1dc9 with SMTP id
 d9443c01a7336-215bd161a26mr55142985ad.46.1733267697532; 
 Tue, 03 Dec 2024 15:14:57 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254180f78asm11032133b3a.133.2024.12.03.15.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:14:57 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 03 Dec 2024 15:14:49 -0800
Subject: [PATCH v4 11/11] target/riscv: Add configuration for S[m|s]csrind,
 Smcdeleg/Ssccfg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-counter_delegation-v4-11-c12a89baed86@rivosinc.com>
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add configuration options so that they can be enabled/disabld from
qemu commandline.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 410ca2e3a666..2a4f285a974f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1477,6 +1477,10 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
+    MULTI_EXT_CFG_BOOL("smcsrind", ext_smcsrind, false),
+    MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
+    MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
+    MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),

-- 
2.34.1


