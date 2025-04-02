Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C964EC36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Ht-00083c-Fs; Wed, 02 Apr 2025 17:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05HF-0006UP-HT
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:38 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05HD-0006Vp-0F
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:36 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-399749152b4so157414f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627933; x=1744232733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zpc094T3sbl+v7Fp0FXsAbkLtO1MTd0oi1OcLdP5b2Q=;
 b=cfI/N1iVenCYZCzEDui9Zhy5gCo6TvbgXaG3KXzDNM2f+hxMfPWPIkobvO7jpe4D3O
 nShgxJ+JefWxqbyTGyZNugagedoLgW02QSq6EFfXE9QqSmAoB7FmZiyjZ30wPM/sngYs
 cZ6AQVYmxJddtXcy6dlZYf6i8F96uJPUN6wcEOFMfhrDvYeetHH9MpV63XeOvC/Vq+e/
 3bE7jHgLSExJVOGpI/BxtFekVfaX35Nx3FLNKgVi5NiYE04Say8iSU5rJ577lnk1RWMl
 zNlkv+gSPCN/vAol7ALDalexYjZ8VlkelJiWSw90bAWjyKudde6pZWliuSUQ1+HqQyya
 AErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627933; x=1744232733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zpc094T3sbl+v7Fp0FXsAbkLtO1MTd0oi1OcLdP5b2Q=;
 b=VT8R7qWIpKhZNVzvvsGEaikv4F8x8reGagVzFH43LsMdmqjtPMIV6KLGUSASVBOtsT
 qku+yiyPQE6UAR78pwVQfUqfs7oCCkqRyfJJhjgaz1srwMTx4sNVJ7+rUz4r49PO9Ju+
 rtRyRVggQu4BAu1JMnc4WfLt2bB8/Az9LBm+1EHDiC6W8/dw4li3BpT4JKWgxY0RNbt3
 XnnCbtoW6W1jqB2725d0ywtJBzGA0YBt10nSdnF9C9BO4tbwEf/93ar59OJcxN5iw8iL
 qywPa1CSMpfw77vDJU3Q9dSNeny7K/mekM8L9NRZB17R2F9LK4FHTtBi9NNe3CgKFLaL
 6XpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVItYM/RUDtLNG99Ie7kPQanGKsXkuAPQzu4aqnb/+fBRg9lNkbvROkPLpSWS4KCVqXaNiEx1OA+tZr@nongnu.org
X-Gm-Message-State: AOJu0Yy4Jcs2nM6p5DyfduU8HxrbEqnV1jIaEJD+NCWd7PlrXkGE0rVL
 57BTaG+rlhMlyuFI2fPxshR15OJBdUKdTu+MUHgsm+WKfSayP/M/pxVY34h/xCs=
X-Gm-Gg: ASbGncvS/p83UlyT5H2JkjlXB+bcOxdtKmYJHrorbOx1n5ED3nTRm5JcjpCMwKGMuLx
 hK7Dbp8zY4TNSHUZOjauPJgNEPq7EnXqFb17VguPv2iVa/JZ7ncFKf32w6a5cHYydvbvpl6XIm0
 ZMgCCPQm2Ulp+zUDREsJG5Or+4ajyQri0jtdwTcI5aMI4M+LCxUaEKPnaLlhN17f5GmGfb04ftL
 GFWz2vAwXXrdFxY+8kfVth0L09KatEHnR/xOopt5TdfxV8IyF2Aj6TxnmNGov/uHcFrgPrUd+y2
 ZCPha8PbmhBS81o2RP9CajF+0MRhLKyGoNjY5wAa57xq1ny70Pg9+1ChPn9ZMMQQEDh2IavuKxD
 KroC8PZkUYc4QuiVcejc=
X-Google-Smtp-Source: AGHT+IGwy88CnrPa/bJVuCa15chqISy5V8lUiHJO034gK0dtkGVnYH/MhGBMBBMbcxegVQFfe1SGkQ==
X-Received: by 2002:a05:6000:4285:b0:390:fdba:ac7 with SMTP id
 ffacd0b85a97d-39c236747eemr7447573f8f.51.1743627933178; 
 Wed, 02 Apr 2025 14:05:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb613a283sm31632255e9.37.2025.04.02.14.05.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:05:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 25/43] target/xtensa: Restrict SoftMMU mmu_index() to
 TCG
Date: Wed,  2 Apr 2025 23:03:10 +0200
Message-ID: <20250402210328.52897-26-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index ec6a0a8b662..51f9ee9e89a 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -236,6 +236,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .translate_code = xtensa_translate_code,
     .debug_excp_handler = xtensa_breakpoint_handler,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
+    .mmu_index = xtensa_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = xtensa_cpu_tlb_fill,
@@ -262,7 +263,6 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
                                        &xcc->parent_phases);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
-    cc->mmu_index = xtensa_cpu_mmu_index;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
     cc->get_pc = xtensa_cpu_get_pc;
-- 
2.47.1


