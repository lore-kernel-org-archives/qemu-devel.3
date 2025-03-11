Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D16C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzJb-000534-Dr; Tue, 11 Mar 2025 09:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEk-0005bA-3u; Tue, 11 Mar 2025 09:01:36 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEg-0000Hn-9D; Tue, 11 Mar 2025 09:01:32 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff69365e1dso7929979a91.3; 
 Tue, 11 Mar 2025 06:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698087; x=1742302887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q98gbAuec0TkReIAHsIjEI1jfEiskw6MwZvR40Hgs1w=;
 b=fTebRs/YekZTR3N+F00+3NCDbdmNVn1Rhdqx+BAPMVBakvoTTofs/oiMz9Jqzcdztq
 fk56ZeBIdPUnyHrcBrbckoKr2yzGM6//DpVqtUCAPEWP1Zn+DkWCuUXM636LAnox0VOJ
 +wxrvJXCD4YxCfmRk0Ya1IHwMeCp0VWggQI+fmFyWO7FbbZDizHVzAGtS4QMFJg3m5ol
 x+MPlR/coKjz/vRZRQ/ze4NDTYFrQGWcb0DfO7c33ikI/qcZBmz3bOYMjZ0qIZdF3sUX
 1PQ3cPsb6vZa5hqy0Ebh1COqb36WuqNIN0F89CXIfdZl8mVTvsxKcQ8c3scoTxmqK3Lk
 x4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698087; x=1742302887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q98gbAuec0TkReIAHsIjEI1jfEiskw6MwZvR40Hgs1w=;
 b=JGH/AkKs1S/wW3zhNIGEi3IoehXSUAzD9EqBElP4Qx9roZnG2PjLVp6f3LxwVv8voj
 3uF7o7cYb24fIZ6zOuXOkipvQ6HJcWGQq6Zftgs6CTLAtquQN6jeZrV03RkzyvBiL+IK
 XLEuu5CFveJshxiJI4s1+AzkIAnAgDIhFw5Y7fvSPkmUssBI+uhF8+WxbWJCRLj1hpGj
 dkgCGjc8acaaNtTCy6QwR95W55f6sTTM/kYhKftnnYkkuGfoRxyKUKFJBVc326Nn0KO0
 HDwC0gwR0SNBc87/v8hKgZ777Mm24K2ze951TuNbeycDfkXZYrDYm7gJlt4AB7MkQAIS
 Q/1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+z3sM5RAVxHhtO1LuX2rO545UdKJ51j5lS+dBPKluUQuaTmU0Wxfe6m0GYqrtRLrjir3m7EfRVg==@nongnu.org
X-Gm-Message-State: AOJu0Yzf0hLUMHIkGYBl8l+P2LIRFeKJ2q1GL8cu81l8OqHl7sg54R5S
 qN/IicNMYLem60iC0zDw8wjprI+yfjfuzkolvGkg1Wrp1Nj9RqhEZ7lypw==
X-Gm-Gg: ASbGncuTQZwQvdlQvrdzU2dZDQPAd/0Ij0r1OZCz8Yv6RevvBDACFLFAs7MPFEPHgqv
 7Xrh05KQjNU6CtfjoYSYCG5WKUtIURqSXUE/Jn1gbksD4Ham2GIWRVLVkgHH2zNTn6Y/OkBlKI2
 XvbRqoFJtWZmOFcuNyOTD9evObA0XH7ZpRKfawTO+5FOf1oNyOwLAKBDDDCaVnsg29r4KY7xecP
 RRJbiMzRPGwrHCcVEssMHxqz2x2nb4XSQwBJeGiU739GLO5vRWCflB1iTV6DxCo1n5TSmvzLn3n
 n1OOlF1VvLCTrTLF+9C0uMRp10MpR53NtVsAJFJ1LdMbsx4827s=
X-Google-Smtp-Source: AGHT+IHxDv3LZ4LBZ1myb8OjwuffMy6ub21FaKhxEpo5n74ntVMs1uiuc7nCmlD4qbtnf/q+6ar6ZQ==
X-Received: by 2002:a17:90b:38ca:b0:2f9:9ddd:689b with SMTP id
 98e67ed59e1d1-2ff7ceee83amr22267581a91.22.1741698087437; 
 Tue, 11 Mar 2025 06:01:27 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 59/72] hw/ppc/epapr: Do not swap ePAPR magic value
Date: Tue, 11 Mar 2025 22:57:53 +1000
Message-ID: <20250311125815.903177-60-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The ePAPR magic value in $r6 doesn't need to be byte swapped.

See ePAPR-v1.1.pdf chapter 5.4.1 "Boot CPU Initial Register State"
and the following mailing-list threads:
https://lore.kernel.org/qemu-devel/CAFEAcA_NR4XW5DNL4nq7vnH4XRH5UWbhQCxuLyKqYk6_FCBrAA@mail.gmail.com/
https://lore.kernel.org/qemu-devel/D6F93NM6OW2L.2FDO88L38PABR@gmail.com/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20241220213103.6314-7-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/sam460ex.c     | 2 +-
 hw/ppc/virtex_ml507.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 3ecae6a950..7dc3b309c8 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -234,7 +234,7 @@ static void main_cpu_reset(void *opaque)
 
         /* Create a mapping for the kernel.  */
         booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1 << 31);
-        env->gpr[6] = tswap32(EPAPR_MAGIC);
+        env->gpr[6] = EPAPR_MAGIC;
         env->gpr[7] = (16 * MiB) - 8; /* bi->ima_size; */
 
     } else {
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index a01354d991..17115be74d 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -119,7 +119,7 @@ static void main_cpu_reset(void *opaque)
     /* Create a mapping spanning the 32bit addr space. */
     booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1U << 31);
     booke_set_tlb(&env->tlb.tlbe[1], 0x80000000, 0x80000000, 1U << 31);
-    env->gpr[6] = tswap32(EPAPR_MAGIC);
+    env->gpr[6] = EPAPR_MAGIC;
     env->gpr[7] = bi->ima_size;
 }
 
-- 
2.47.1


