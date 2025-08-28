Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83E6CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgHb-0005Rq-IG; Thu, 28 Aug 2025 13:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXU-0000xk-Je
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:39 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXT-0000J1-1v
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:36 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2445805aa2eso8865095ad.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383333; x=1756988133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opS1/MQaTNLhtHvSC8J3as0oJFPKDsl0TAly/SBB3gk=;
 b=VgYH0VpPOAFNcLAprpYc+PMNdUBPBrEIp3kExQixINfPVCmP2LxIDcbtbPvIIJlpoO
 WoE7yGE7CejjDjDV1DBRHKrG+mNKrBYZdekfnvTtUGt+SEoqyIJAKl0HflA42Tj+HEVA
 tjZu7b316kjKlcr7dliG7hhaXF57EmJP9wAm7MQ2LXNPSSFkfP2DMzZmucBWdd72Fjqa
 n2CRUknEcOlzWgndBHfUEPuj6gwDADDnX2pwq2b4/DWEISkFQxcKAyCgB9EvhBHRYn0a
 eXr4IQC1oQ3i/PG2FEJaRI30EpdwlYWggt8tPsIEro9dPnEmElHcN3wLQboIwfBu2Ld3
 Rg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383333; x=1756988133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opS1/MQaTNLhtHvSC8J3as0oJFPKDsl0TAly/SBB3gk=;
 b=pP3lL0Q/kegBRp/DMwR3HUtwFnhLNUSMBvFgLj0LjBV2qhVv2N15K2YkFlGbJaN5Lw
 nBoobCAQ0RMo54/VpJTy+99wQ2Fh3Bp2G3z20qaWOgTpVtZluNfPJtgQvSi4yfBWAQeT
 RlmDnazn0bI5BESkzYhzujd01IfmU4jpJrNTuPJKyJowCfPN7735ttbGeUuOYm67TCEf
 AB4Zr6buens+tLd9XRxRUl51x4tNQp7XfSJvbahnYAFIFusRjGVr9sNuUA0D55hNn27b
 yE3U62UqF1HZeoYA+xnME6/PbUxIS9Eas9C+wPBMeglntRAARjlZkairNSMAmkYUJXoM
 uSVw==
X-Gm-Message-State: AOJu0YxrjLQrYOwOxDBjFGhot+FvGLsHQFwVFuB5FBYNRSNnd5Hb0U8A
 GhrtaF5z7Ro7y/PE0aqK3JLj/qwlR2VUg8dhQaWFOnzzQNmiqucjO5Ke0D3lS96ipk7K4IUeO4u
 OFFJ8/uU=
X-Gm-Gg: ASbGncvpa3XqQQqnQtnNe+iHnuSH0ez4MQIDMS4kdZ3eJUAfLLys/qpehPy4jEEkur3
 nW5UWv7XcF6jlTlCe/iiDuEbxsbmUJjuzcM0c7wZB5YAPg8gfZU7uHZMlLCu0CjF3LTq0h4WtbJ
 8CsDsWZ31h684bv/3vPAdM5uCPJtWnU63GeujUkTozUbLjuGAHwnG/qga1nfBQ1Z0qAMKWwGtW8
 Zdg46imJK/MNYaesWpc8ipYBNHmvhy3e1ms2AnT5dTBXiJCV8O3JyAFg92TnX/uDp3SRjjYbGeq
 dp/QKk6NDqFdWZ8XH5faXH+zuc7tWIAwsC51xs8K8BdNBPjZL5is/GSKyZMNF3SURP9PNLWEB0y
 SBJKMtoPco6cOyM9ZGWw3dEzpsj1Qfvj6zwzN
X-Google-Smtp-Source: AGHT+IH/P5xU2ilB2wmo4Lcnbwloz+Elotgbl/dcxENqYYK8L4f+8RWKCKvMeHmY/rTCI2NE6rzzDA==
X-Received: by 2002:a17:903:1a87:b0:248:db40:daf0 with SMTP id
 d9443c01a7336-248db40e31emr25462975ad.31.1756383332680; 
 Thu, 28 Aug 2025 05:15:32 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:15:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 73/87] linux-user: Move elf parameters to m68k/target_elf.h
Date: Thu, 28 Aug 2025 22:08:22 +1000
Message-ID: <20250828120836.195358-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/m68k/target_elf.h | 3 +++
 linux-user/elfload.c         | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index 0737412cee..073c85becc 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -8,6 +8,9 @@
 #ifndef M68K_TARGET_ELF_H
 #define M68K_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_68K
+
 #define HAVE_ELF_CORE_DUMP      1
 
 /*
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1a6e81394c..a3757c595e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_M68K
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_68K
-
-#endif
-
 #ifdef TARGET_ALPHA
 
 #define ELF_CLASS      ELFCLASS64
-- 
2.43.0


