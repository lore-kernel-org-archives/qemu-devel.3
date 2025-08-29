Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4286CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkA-0000g9-7j; Sat, 30 Aug 2025 11:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7X7-00034i-NX
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:21 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7X4-0002wB-I1
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7723f0924a3so9165b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506317; x=1757111117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDt0kaislKgfQkK/AeZRFzppj7QwoJ8FRry7veda2b8=;
 b=iVmnVaYan3SXe7Sg7JtOZbDPNAmlyrokVuISqnH9DGzhRkaF+VCWCTO/xF/yERPo9U
 tC8zAOhD1YxUJq9aBvCuBWJ/gIpg6ezFlNfr359beClXrRo/522hNcLxo4QWJADealGg
 jRi5L9zabaeo6gtAxunRgH5UG+GF7aJtT5PEF2uEJMfwMuFKKnZxS2GPgGWilpIXtPY7
 ogW+BI4DpkcLaLh7f3zwUotb0kbBzgP9ozZdLE+PR9t65HEUEdsMWlecyz68clMNggsF
 8oaf1XikctRF3k0Odnt18LQ69KfeBuPD9B+/ocw1yVIDOOOLWR7ak/mYy82C2gnhJAzE
 h9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506317; x=1757111117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDt0kaislKgfQkK/AeZRFzppj7QwoJ8FRry7veda2b8=;
 b=rsVqekgo9oOEMHTYTPNAhbgqkkE1MVNM9iroYSRxJ7HOY47af2lU7RCuhEwL0pHWQL
 LExAD1mxErRRJKdkoXxX8lQRQJwI5HBqQl3mwOfyxh7zWPPmc2gQd9e5kQ/Lu3+GjngN
 Hr/xMl1fTpmgwKOBK+2WUc+tJDGdxgjU8lyGhqpKZnviPbnyB9F8yPA2UoTshAjN+3HM
 7xkPpN3U+a5kb9d/Fns12dysIU4Tan5Y02uO5bdQv/BTAgzFaY43epv3D+Q82VoNNUaS
 wBukUm8RoQ0Sw/4mZaa35XFhBt9p4g1tECEM+G76mgn327TkOGvmlvYLgDOlD4NqXNbv
 0diQ==
X-Gm-Message-State: AOJu0YytW8X3wFEewFuOCMgvV1JcTcZpJAh4VYJeSXB0q6C0P8EbBiol
 7oYXZ7BH0GcE/r7oO4IXQHK3qXii1xxajEt9Oj8Xoafvn9S7IDtqhKqLd5QKTHwnWf1ae6ZL5rf
 N0PiksTY=
X-Gm-Gg: ASbGncs/qa6xySDEiJyhfjxKbhX8cR/eIcUxnzMC7qJGNBUekHVlXEvCPRPD00BdLZ8
 b1I0EzTlTH905Iiaz99Wl6/yOhXbGaBngF4wcA2Apkc8qubMJSgPocns1YqOm9ZaFLJOo1q3iM6
 HprNQoFyYci8zZHzf1jwsn/YtB5ZdU+tAS1NedOi9xCnzlWH+tFnFk1nfjUIRRCxVOzV4e8qrJT
 KAdcFZRaIXLuz4xGH/Vd0pIwbYRGRuoR5YH5QnOCAqmerrzvh4TCbva++4waTj9RgjMg3RcW2RM
 dX/R/g+ywGjvXInig64Xe+Z26pvl6lTbxw5p/726EzJnq/bIGAHVkn5J4mVUN2ltsHhBC94x4NS
 IC3xm2Z68mB8990q/MB33oYEENqt7A70IDj3FczGXhyvS/OI/d+fBC1nn600T
X-Google-Smtp-Source: AGHT+IFQwT0iSyIpw4JbYWlj5mslKJ+EjHlTHNU4OQ2ZGcqL1jTSKNXFerf9lXZL3bc4xH7KEDR0eQ==
X-Received: by 2002:a05:6a00:2451:b0:749:464a:a77b with SMTP id
 d2e1a72fcca58-7723e376d48mr340043b3a.18.1756506316889; 
 Fri, 29 Aug 2025 15:25:16 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 18/91] linux-user: Update comment for target_elf_gregset_t
Date: Sat, 30 Aug 2025 08:23:14 +1000
Message-ID: <20250829222427.289668-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

The only thing now used by generic core dump code is
target_elf_gregset_t; ELF_NREG and target_elf_greg_t
are now private to the implementation.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 930701f08f..74f88dfa68 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2859,12 +2859,8 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
  *
  * #define USE_ELF_CORE_DUMP
  *
- * Next you define type of register set used for dumping.  ELF specification
- * says that it needs to be array of elf_greg_t that has size of ELF_NREG.
- *
- * typedef <target_regtype> target_elf_greg_t;
- * #define ELF_NREG <number of registers>
- * typedef taret_elf_greg_t target_elf_gregset_t[ELF_NREG];
+ * Next you define type of register set used for dumping:
+ * typedef struct target_elf_gregset_t { ... } target_elf_gregset_t;
  *
  * Last step is to implement target specific function that copies registers
  * from given cpu into just specified register set.  Prototype is:
-- 
2.43.0


