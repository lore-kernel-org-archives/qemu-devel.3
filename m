Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D510C3ABC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJZt-000745-Lg; Sun, 11 May 2025 23:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZq-00072F-TY; Sun, 11 May 2025 23:11:38 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZo-0006k9-Qq; Sun, 11 May 2025 23:11:38 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-74237a74f15so3935287b3a.0; 
 Sun, 11 May 2025 20:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019495; x=1747624295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFGaQPUZduu5nfpuN+avlrzyXYFKI26S6yw/0fquOwI=;
 b=DtBLes2gPg/41ARbUsCMVrTGYZC5ieP+UIu0Wld9ZZ2itYWpPEvDE44yvGFcrtg2dv
 sqZso981ygwWWIKQw0bCZSWXPzu+5a/dwrZ1H3xBtBrOSO2njBZ9Z4PpiRwdidvkrBNF
 jUGlrueiqH9yUW8SNCk0sgKfHHSYMgrWHTJj9PuvDoSe1zfyGcncmCfH7FwKfo3dt5pc
 57aczOXoZH46M5l4cZ9vX8CxYY8gFekVYJ4hkOMiInUCpKZL2SIjy63m1qEvv37sxZCY
 s1jyXKmwEDNOnTGm8eV73qzCyg1UGnPQE5AxNs71r6EYeli4AbZnLpKkjK928bCYk4zU
 CF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019495; x=1747624295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFGaQPUZduu5nfpuN+avlrzyXYFKI26S6yw/0fquOwI=;
 b=ozKI95xZnmuT5ujbjQKHlYtwczmqmJ8u+t7qXA31NgUgU+rvqPqHbpgiugxpXKURHU
 r9BcuTtu3e6Ym0duK42avZV07nP/YOjZ+Jmw++T8qjsmPtG2L6BugTCVBtMQAr6jWtr5
 fUCSrL2enKLlr5UuneoEacc5Inz9QNwyBhJM7lXp1mALJlbH4QJFhOF9COtuNIodTOFz
 6lhs6ybdseLP1KW7XIY1IEENeqFUy/VWGQVjGTHzfZkhDgSuzLn/+OaotFpPysc/Y8vg
 Yx8HWsS1SQGfkqDLmWmpcZYDzX13CdvfZ6Fp2V+hHjJLStjTZJrIlsFcx/MVuN+iGcDR
 FQvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi3SNGMmIKvND7tSMdFlV5+Og4V+ZD8onlrV+SORAeOR41CRwbqcviB6ebEz4TFd/JETu5ZwUvOAZN@nongnu.org
X-Gm-Message-State: AOJu0Yz3kPcs6Gk/LEbXmiwwFYFg1t/EAePWKtvm4XYbxa5uYyGn6hwL
 7eEWiXYGwj4FnYZXgNZrhZARu1FAD/mE0g3Fk+b9BMBSdBv9BbBSFE/t2Q==
X-Gm-Gg: ASbGnct0NwO8tQM5PNa2OVqZ2DUn76cF5wjfWzHsqve2Eb0a6rQEzPMtVZf//sbyNF6
 8njRBcI0soC2RnNXIb9zU/8f1/HU24DuP5ybz2Ph1kb3SFd0COeItqAW/CmmrQOQ5KCv4xfrX1T
 g4/thVBNH4xxnVRt0E0sASn2tz/+XIaxvP5p8cxG1476NulYCA2feKdjwf4Mq05+LfYNIINCJnv
 bCU5drGMC9zbeZj5JLAdvJ+4Qrq48zmeBrTlZUVXdISdrs6+m/iNrYu4ShUwET2SICubBxKMced
 1BRJMJwAf1K0ECwwTdFMHHXHH29TtwZSb3OErbItHSPpmOjeHKyBTq7C8lr3yDRv+NR4
X-Google-Smtp-Source: AGHT+IHpnlvHs8SfBKScp9xwSxiYUrwcIHVMtwCoEjMUzCco69mxixK9PdOi7JzkGUwsN0/ie7M2uQ==
X-Received: by 2002:a05:6a20:918a:b0:1f5:7873:3052 with SMTP id
 adf61e73a8af0-215abafbd7bmr16658809637.11.1747019494676; 
 Sun, 11 May 2025 20:11:34 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:11:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 07/50] ppc/xive2: Reset Generation Flipped bit on END Cache
 Watch
Date: Mon, 12 May 2025 13:10:16 +1000
Message-ID: <20250512031100.439842-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

From: Michael Kowal <kowal@linux.ibm.com>

When the END Event Queue wraps the END EQ Generation bit is flipped and the
Generation Flipped bit is set to one.  On a END cache Watch read operation,
the Generation Flipped bit needs to be reset.

While debugging an error modified END not valid error messages to include
the method since all were the same.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/intc/pnv_xive2.c | 3 ++-
 hw/intc/xive2.c     | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 30b4ab2efe..72cdf0f20c 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1325,10 +1325,11 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
     case VC_ENDC_WATCH3_DATA0:
         /*
          * Load DATA registers from cache with data requested by the
-         * SPEC register
+         * SPEC register.  Clear gen_flipped bit in word 1.
          */
         watch_engine = (offset - VC_ENDC_WATCH0_DATA0) >> 6;
         pnv_xive2_end_cache_load(xive, watch_engine);
+        xive->vc_regs[reg] &= ~(uint64_t)END2_W1_GEN_FLIPPED;
         val = xive->vc_regs[reg];
         break;
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 4dd04a0398..453fe37f18 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -374,8 +374,8 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
         qgen ^= 1;
         end->w1 = xive_set_field32(END2_W1_GENERATION, end->w1, qgen);
 
-        /* TODO(PowerNV): reset GF bit on a cache watch operation */
-        end->w1 = xive_set_field32(END2_W1_GEN_FLIPPED, end->w1, qgen);
+        /* Set gen flipped to 1, it gets reset on a cache watch operation */
+        end->w1 = xive_set_field32(END2_W1_GEN_FLIPPED, end->w1, 1);
     }
     end->w1 = xive_set_field32(END2_W1_PAGE_OFF, end->w1, qindex);
 }
-- 
2.47.1


