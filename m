Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460B9CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbcv5-0001fn-KY; Mon, 22 Jun 2026 07:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <inochiama@gmail.com>)
 id 1wbcv3-0001fE-ES
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:34:25 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <inochiama@gmail.com>)
 id 1wbcv1-00049o-Sg
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:34:25 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c8b49639fbaso1630145a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 04:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782128062; x=1782732862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3d1w/Ecvpo9SAU0olHhh8kvv0qpHefNp4PB+eSWQeIU=;
 b=FgAhdWOFtjE8YMS0yNZEg9c5sizhnslTHKQRCBoo11PU/O0gfcCpxgcgcjgtXwzg9P
 3IiiV6RffIxr3TP/La4DZWhxLwWQuB3Z0HOhxMq/DjxFNbLUKJgzcHVArT7nQIWAoiMG
 8Cd2xIaQ2/9RkgslLd3nBip0GZRwyN+fDzfQGlwkDo5Aq1xi25+vjgbUnfg3rRX1XfbZ
 T02c+A5UwzRKxLrGCcOV5PpAvk7ol7BOSbCw8DYWJJFpAnP9aaKqUpxCES0IjNcGmyDb
 o21n+KJrPU6w4CyUQ46qtePUSUX+BA1xq/oTP2su75o4f0EGUMnyQ1u90TrNivIwfU5o
 YrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782128062; x=1782732862;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3d1w/Ecvpo9SAU0olHhh8kvv0qpHefNp4PB+eSWQeIU=;
 b=qIw3maK/aCfkj5h8UmEJa2UcsM+xrFRh6yEgGIlfZPfY123mHH7nPWdn8ZiiiqOLg4
 DqrjyDHUcKW2ifa7ig9v+PK6e+igkB3YmScSJ5Gw3LNFfMRdbO0fyz1LlmQkOs7aP92D
 J0ZY3Fr6GZfsgYGeeKeEGm21Sjn65Z72/tBufGyDldZpYirBdR9GRK8gOBTNuGLyzfRB
 ZmzsTWeXUFscFd0JpidA33BZqdg1ehFdIJBdJCAqcDAqn5F+z7MkmHw3dgJ+pv6MfQg4
 4KX58OE/6poShbd0leA68Hd56DrSBWMk1gv9zfzbNVvRbpuKWfndnZ8vT9UcS5HXBPKe
 2jNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Zqn24XwH8/ukTQxUyTJLDcbNjU62ptc3UnC0MPCjBrwLFoQDGaTs4HOuJbeU/s6NMwDSehWIFEIwy@nongnu.org
X-Gm-Message-State: AOJu0YxS+SkCx89SpJWeQam3Mt+YEB+MGoPWUfL439Yakk3W8plebut/
 0FX2aLzs9IQvsalG9T2b7F4SCzZhQzE4loSYEycP/39dC7TpYOyZZ7Nh
X-Gm-Gg: AfdE7ckGRsetyZr02e1MTGUsBCeyi50JxG+4e663iC+fcFYasfMZUED8HMPbXdjL88w
 Z6Si7k1KoCdzU4KbFAI3W3X5HuNh7XNrNLNNOEId1tU/kmPXWHnQK0Hbq/bkNGxHGjkkCAxObH9
 gnN9lO9aJHxqzYRLV+FI4euhJPXgQwz2jqal7D5V8uevqnR/TK03rqatmybycqetRpqgrSUzsjR
 8A1oVqNSl7LGAA/ECEedr8j/E86C6uXoCywybdolqjUepKJiaqTjwxoSwnSrU+Itwea4LckWCFU
 HM8OUyJ829/jPuBebIkUhhgZ5FSDlOBdrIL02o16YNLcXkJO7bHou8kYg8LuIVSAAVoKFNObbGR
 SgyTay4LxDK0ABPbRLRTeHImmHwR6C4nOP+1qAnmtm7tCSepdRpIEIUFXlYkWjEqS+ixdB7VmmG
 +SiUwin+WN0z8=
X-Received: by 2002:a05:6a21:4684:b0:3b3:f46:1eea with SMTP id
 adf61e73a8af0-3bb69ca4180mr14911100637.7.1782128062170; 
 Mon, 22 Jun 2026 04:34:22 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc5a1d583sm6634124a12.25.2026.06.22.04.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 04:34:21 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2] target/riscv: Check PMP before updating PTE
Date: Mon, 22 Jun 2026 19:34:01 +0800
Message-ID: <20260622113402.563196-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=inochiama@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

According to the RISC-V spec, the PTE update is a supervisor write
operations, and it should also follow the CPU PMP configuration like
the PTE read.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
Changed from v1:
1. Separate code statements and declarations.
---
 target/riscv/cpu_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 59edcdd370..2db07f5dfb 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1655,10 +1655,18 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,

     /* Page table updates need to be atomic with MTTCG enabled */
     if (updated_pte != pte && !is_debug) {
+        int pmp_prot, pmp_ret;
+
         if (!adue) {
             return TRANSLATE_FAIL;
         }

+        pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
+                                           sxlen_bytes, MMU_DATA_STORE, PRV_S);
+        if (pmp_ret != TRANSLATE_SUCCESS) {
+            return TRANSLATE_PMP_FAIL;
+        }
+
         /*
          * - if accessed or dirty bits need updating, and the PTE is
          *   in RAM, then we do so atomically with a compare and swap.
--
2.54.0


