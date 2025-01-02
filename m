Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B0EE77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbY-00073n-71; Thu, 02 Jan 2025 13:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbH-0006yf-Lg
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:19 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbC-00058s-UT
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:13 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-216728b1836so140668535ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841229; x=1736446029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q58QUvS93qtXQPhM9P64ki8OvVkTAGVw9wNq6sZqJ3E=;
 b=MxRBquSlMibHkWblfr6ypYoJAwiTrfv0VtvXnHEQklTchDLBsgTgTMx8Z9B08JgaNE
 X4phVTE1LJ4rUqgwJj6B0QuR6ZiG5nK+v4kkluHvH3XnSfln/mfWblV9cTr9IIipm4cL
 9u7bpivzHnCHux5fOWBAvnuavoKYH+hK2ElUE1rhlYXRrPkGUMHXEBd2TrmOAGUyNigE
 NqfkifaMKTUkJQa0LpKddw5/oJ2JcuDiUNU4Eg24bGG4JAbQ6d07CHEMYV8Ph/m5R73O
 OtU4FIXT+zDm0v+PB3dOPXswyOkPKXOBXPJee5h9LxGIf0fVoY2pBhR3Gem6u9bgR1Kt
 IzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841229; x=1736446029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q58QUvS93qtXQPhM9P64ki8OvVkTAGVw9wNq6sZqJ3E=;
 b=gglesClf6T2bvpAeO+JiCAGt2WlAiioIZbrfrhz1bqqhDZd+FGhS7UJI6tovqb5s6p
 llFRn215h95GJdGe4294B5Mo2v2HSeyQ40GJsEcDE32ZnsNFcByCER5qg+wPjcjUkcBL
 a64J5YpogoVT2DWDy0IurCww3kAg7lTEVw0JdeSLREqF+W34idlMIp93eYsbLN4gWUva
 DigneEl705L1Yxx4Hkp8TD/M3yKZ4yOu91MXnU09RKYumlDJwAzAIKAMspB2XMpqJNKm
 VG5bxQo43ozkSRQKshNsWMXsGhniTpbeeonp4p1cnddpr/8A0M7d9TdPBU5PNoq9SoAa
 tXAA==
X-Gm-Message-State: AOJu0YyKSBooqzHb+5eie7enKe3QSNRcN+1cbviLFVd4A5ZLHwdG6H9q
 FCfBM0HavwgNCqMXTlGtd1EOnxuT2uHIs9yueeu9z0Blr1nPsHvgMl4I4t2mW3xKsknNQiXOpt2
 u
X-Gm-Gg: ASbGnctfxy6n/ILn/Qdi6NM0iQ0aFRNTk0dSS7KTr701Fp9IEOwxZpsOXgbwKH0o2Uk
 7eVAgIMSVxYNkPDujd4df6ovSejsZpMfQUB8RNU8Req5Gk3hg0uU3RMImQ0SrksZ7/ojp/kWgEJ
 zM+lYdMuPvPVqOAMeSp6Q0n+sNZfaoheiy2Djg50CPfjiYbitkTo1u8IVUb0uY1IfFSSQwxIGhY
 zSnS0KNqVhsKqi6IACoLsSht/AI+hq685pjaZfDhUIzIuTLT16FPMzAaxhyJw==
X-Google-Smtp-Source: AGHT+IH42mG5geNCy5GHpPs7fU49d/avKcXSbFF5tvRQ3qH/LarigyqphLHxwG89aTUhnk5lsFeavA==
X-Received: by 2002:a05:6a00:858b:b0:72a:a7a4:9b21 with SMTP id
 d2e1a72fcca58-72abdd20f03mr69385746b3a.5.1735841228932; 
 Thu, 02 Jan 2025 10:07:08 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/73] tcg/tci: Move TCI specific opcodes to
 tcg-target-opc.h.inc
Date: Thu,  2 Jan 2025 10:05:57 -0800
Message-ID: <20250102180654.1420056-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Now that tcg-target-opc.h.inc is unconditional,
we can move these out of the generic header.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h        | 6 ------
 tcg/tci/tcg-target-opc.h.inc | 5 ++++-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 93622f3f6b..14aff6e7f9 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -303,12 +303,6 @@ DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 #include "tcg-target-opc.h.inc"
 
-#ifdef TCG_TARGET_INTERPRETER
-/* These opcodes are only for use between the tci generator and interpreter. */
-DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
-DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
-#endif
-
 #undef DATA64_ARGS
 #undef IMPL
 #undef IMPL64
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 84e777bfe5..ecc8c4e55e 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -1 +1,4 @@
-/* No target specific opcodes. */
+/* SPDX-License-Identifier: MIT */
+/* These opcodes for use between the tci generator and interpreter. */
+DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
-- 
2.43.0


