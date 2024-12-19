Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DF6E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 03:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO7P8-00071e-HA; Wed, 18 Dec 2024 22:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO7P7-00071K-0O; Wed, 18 Dec 2024 22:40:49 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO7P5-0004I2-Fe; Wed, 18 Dec 2024 22:40:48 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21661be2c2dso2811105ad.1; 
 Wed, 18 Dec 2024 19:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734579645; x=1735184445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bMMfLBkMrY+DVueinUNWjTYlxFYKuSCnv3bBp02CQwM=;
 b=U2Y92zaV5fGD5GM0qatzVdDrcZoaW1Pm4jkrcrQyr3IDzP62aOuWO1mSIZonBChThp
 b/20kPfuW7FbLTW4m3k67JlZys7lNIBI6BIBVFUPfakJNskX2qtQtwifN1GbxMnTOGGT
 zp65Kv1BnDcA4KpDzCx0zjYpS43/Rr8kzKGKZT2i0USzDASPVfvOIacbvLeMSg4+uexi
 L1K8GdtTxNS3XYuQRNRn3x7RmIb6pIXt5XoI4/7TTsyvphXAkRWTfSeuknrda9nO8ktl
 IY2UXmg9M3UnHCW0YH8E+1o6bC5ZI0uCl0MKRq6VMwZmEpZ9qJT/uzobow4XBa2zB9Fn
 AycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734579645; x=1735184445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bMMfLBkMrY+DVueinUNWjTYlxFYKuSCnv3bBp02CQwM=;
 b=t5if93kib7S4HeFTw4ley4KzhaD83cIKHpkwg/EmsUzdjs1WzsSF5NLrVGkxtJd+M4
 nK2ruWswlE25JLW/R5hcD+SOvcspkJcuk2qmbAosQMYqG/wYj/EuNP+tBDtYucm5YrvR
 6e7+ciXR0NLXzrwjr0SrWN7Hq8i/DtU9xH5KPWJvgtRPxG6oyQCw6BzLacLx8YE7/L/D
 7jsp+hN315hEcmLdZ6FCsWNNuU3SZmXw3A/qd/tEbVCeuLI1WvDxSm1xyYO9KqJBOmIY
 ffi6Ml2hVndmsNKMUx2X0v9poef0D4QgLaG6KPq0KEwjhMkkNjlIql8gjihwaa3LRRBI
 nRVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMPZay9dzk2w/0BSdBn7NQP3z1JZh3bsYsTccQ9YAQEA78noNudo9crZPAm/zQ+jIicgnILJI4luO2@nongnu.org
X-Gm-Message-State: AOJu0YyZxYeHFi9+cqBEJN3u+h7TvV++DBsQ3AA8baRZKhaG18uha58f
 bwZrmlVKvd5oGrtAmA4ylDg7tiTFqBrtr784I94HFSjUm5ROEq1oFdGBbg==
X-Gm-Gg: ASbGncuGYTd4Uk5J78xmYV5P/HriNWq/ejuRH89hqJPISnes6u0xWjwKaSjF+UYXzXn
 H45pDdMWXf8KcIvcMfdX894drUtqZ1+HtNqDVpNavEb/iMTk73xRQMgMX7HMsYytkmlkToyr9LT
 HmiLzgqeY3nFr0IScf8Gu+rx/sh8R0LK7n9+OCpWLjdfd4TIUWnwQgZc/YPLD7X4z/Lufxj/om/
 EIfGZbfkU561ioUH2mLcR/EJFjRAmRwU7nBWP1nwohRbfFOAuGTiAtrt1DzAzMPadt//wVT8/hF
 90g/npN9Vw==
X-Google-Smtp-Source: AGHT+IHENSiFOOdEy02BNmlcsQw58GCu7Pl88csHFEWpDIAD2ABmzkov+HZv4gu3uEiRhUnzK8aClA==
X-Received: by 2002:a17:902:f541:b0:216:6769:9ed7 with SMTP id
 d9443c01a7336-219d96928bbmr33144815ad.40.1734579645535; 
 Wed, 18 Dec 2024 19:40:45 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc970520sm2881595ad.75.2024.12.18.19.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 19:40:45 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/5] target/ppc: fix timebase register reset state
Date: Thu, 19 Dec 2024 13:40:31 +1000
Message-ID: <20241219034035.1826173-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241219034035.1826173-1-npiggin@gmail.com>
References: <20241219034035.1826173-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

(H)DEC and PURR get reset before icount does, which causes them to be
skewed and not match the init state. This can cause replay to not
match the recorded trace exactly. For DEC and HDEC this is usually not
noticable since they tend to get programmed before affecting the
target machine. PURR has been observed to cause replay bugs when
running Linux.

Fix this by resetting using a time of 0.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index b86b5847de6..51ae3358d12 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1123,16 +1123,21 @@ void cpu_ppc_tb_reset(CPUPPCState *env)
         timer_del(tb_env->hdecr_timer);
         ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
         tb_env->hdecr_next = 0;
+        _cpu_ppc_store_hdecr(cpu, 0, 0, 0, 64);
     }
 
     /*
      * There is a bug in Linux 2.4 kernels:
      * if a decrementer exception is pending when it enables msr_ee at startup,
      * it's not ready to handle it...
+     *
+     * On machine reset, this is called before icount is reset, so for
+     * icount-mode, setting TB registers using now == qemu_clock_get_ns()
+     * results in them being garbage after icount is reset. Use an
+     * explicit now == 0 to get a consistent reset state.
      */
-    cpu_ppc_store_decr(env, -1);
-    cpu_ppc_store_hdecr(env, -1);
-    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
+    _cpu_ppc_store_decr(cpu, 0, 0, -1, 64);
+    _cpu_ppc_store_purr(env, 0, 0);
 }
 
 void cpu_ppc_tb_free(CPUPPCState *env)
-- 
2.45.2


