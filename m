Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8648C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDOx-0002jG-65; Sun, 11 May 2025 16:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOt-0002SZ-RG
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:55 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOr-0006KL-Dm
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:55 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-23035b3edf1so1718015ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995752; x=1747600552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIvXrHcg71Zxao4OnBZBdLddOM/XHAwRxf7Qh2NnRSQ=;
 b=tP+RTKgwLc9hiNgK6pzd5C/YshgcZ++sqagAMALZYFh/9NyqMv6yAmVEDvh+2biG5E
 GnAyJ6T+ohdaD+J72Y4/bFN5WIHMFNo1hKRSmK9p/X1z3WSNW5HwXW2q3J5vQJUfdop/
 jO+ZZFTzg4gjTK/GF9XTs3Kt4d33Fsx3Jyh4IRvwuXK11fB5maSdlYugyRmtZcpWetI0
 JFRRDOnyWvPD3Sx40OXuPudp5jbkx+g7Eiu2jaEM15hdSvLcJ43niP3H11WGNF70WnWf
 g6go83tlHEeX5rFHrzjxndj18TXkUHnZDFq5ROBsNE0IvzExNnkDmM/CGbOHFIHmWyV0
 bH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995752; x=1747600552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aIvXrHcg71Zxao4OnBZBdLddOM/XHAwRxf7Qh2NnRSQ=;
 b=uHXOkUNIwvAAVsYK40kRjdA+jZLMbaLUuEYR38m7Rvfo5z/8O3gr/MCd+GKqPHBceh
 jSxvBAcotq76179fZViSR9OLRxnVg5zK53rBHIXxppWqi3dJ97m0Ye6M90jEAVWI0e4H
 HRzFO05QOkCthvU6DrCiCHRtycBAozL25pIjkKKfmI7t4RQfcpJcqAp2ZhNDpEDjnEbg
 tVrvXrYycXvlBWhcvIaYeY1dctwyz8zm4Gt2iYv1ZmBdbrY88GqPxtZZoF3lxin2rg8f
 F2B80DGzkLkX2xxx6NcnSJgwvDwn6eO6j+SECmqGzPIxEoOrX3BZqeIOAZrjXU5Ap4hk
 Qkew==
X-Gm-Message-State: AOJu0YxLoDED4m3YMLTiIS1GTzdyKnoI/xTdyEgL2TR6rSJiSM53NKCy
 AxlQTL0TlfcJrReC0h0LPwoe1Fttheqj4jqBUlRPcPQyLtGrbrhflnIFZOWrkOz++lV7Rlgw2gI
 f
X-Gm-Gg: ASbGncvmjxjxfXts7gRVrSCFr7zoFy2tyrJUtZ36hdzenUFMVK1ydG/WL7RKU5AdvsZ
 U+9tBGEML3gcSUkHMd/NyZEbDFPdshHPHfryqRQKIpllo0FT8L/xUsBDqrS7tw3D5hTZb5NKKna
 wQwZ3/lruiUzv9I3JNJZ8nCgTtOQk+ix2wp1nJOI8N49BavlswzCApIhER4hau1nF5SwtdoyFpM
 f7c7DH6KqvHH3yhq8jSpQui5f6X4PbN01wnb9Dc9VbYIZw1ztVKnGfCZjS5WXWvobtvCXv9t3f5
 pCGpP2t5/TfQtjSdiKfuPhg9RHX7gsaLvwseGyMVD8vP6z20v7cyv3G3BHNaXe9ZdX/OigNcicV
 S+F+FnmeSNg==
X-Google-Smtp-Source: AGHT+IG15KMAb0m7Zp6pNOBGxJDgGsCleF9bWFfE2fuAo+HS23GmNTKF3Ko98zkOP7VopHfl2adPIQ==
X-Received: by 2002:a17:902:d48a:b0:220:ca39:d453 with SMTP id
 d9443c01a7336-22fc8b6131amr177999475ad.17.1746995751826; 
 Sun, 11 May 2025 13:35:51 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	schwab@linux-m68k.org
Subject: [PATCH v6 05/24] target/m68k: Update FPSR for FMOVECR
Date: Sun, 11 May 2025 13:35:27 -0700
Message-ID: <20250511203546.139788-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

This instruction sets CC and EXC bits just like any other.
So far we do not properly emulate inexact for the various
rom entries, but we can certainly update CC correctly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/fpu_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index deae94b0ee..e63fd3ec11 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -425,6 +425,7 @@ void HELPER(ftst)(CPUM68KState *env, FPReg *val)
 void HELPER(fconst)(CPUM68KState *env, FPReg *val, uint32_t offset)
 {
     val->d = fpu_rom[offset];
+    HELPER(ftst)(env, val);
 }
 
 typedef int (*float_access)(CPUM68KState *env, uint32_t addr, FPReg *fp,
-- 
2.43.0


