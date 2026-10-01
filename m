Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4E6CA5FD9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCPmL-0004Op-LR; Thu, 01 Oct 2026 19:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1xCPmD-0004Nn-Tl; Thu, 01 Oct 2026 19:01:23 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1xCPmB-0007j5-5h; Thu, 01 Oct 2026 19:01:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=Al8KiRi
 pNsCFc8DcWuF57vTe8RO9ciEYc2EDYhUZNpoo2aUc+oIU/JCIYxBxbr9xAkpdZo9BBnXz+
 yEp4VvypPRh1oRRswjjSVGuhHPZ3iQUU1s6btJYYAfGvcctSLCMSFwt5TSevYcdcGItcYK
 EBaRcyplOkYAKSMHHDJ8P7DJm2wSsYGiXuc3L3UCGUXk4L+9BFlvgRwna7xkpG6u7AtCbi
 8XyBj9qgCQZNnoi0O3aYztUWwhEyCWUtKa/Me3lPCR9M9zWnXOEyq/6uOXHByMr6EdfTEg
 V0oknhHHzIXH61cZO5/5AR367As1LLACRXXHh4port3lLNiDIbOGZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=R
 rND9HDXtGM7Fq5gbWj7QVWsA02TIkIilgSin+ESmpQ=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=w75p3y/f4M9P0NhBPdzMMWWILxLF7847DVitgMH+ahc55omnudOtan7Cdu79yao3KOSF
 m318r8UROf+wEQhpyiK+g0dSDtFVjqpztIGn7j6OztcW009x9LJndHk4WYomwVJvaT69Fz
 F0ZCEpH0BnPdja/i3Gm/te9y88MLb8bh9lV5v8lLUxutc0rk6pK1LAAWsd5/2C8nsqTM11
 9ueNx2x/VFMKCYwDrZogzN0s/xdHd3QZXPlKTyK+WFOLCulGx6Iphjjpf3Y/fcUEDEgt23
 NMQzxIRLowD9QAdRy38Zkw0v4+7peGhx95uYE0zLBPM8cu4qdxHvU9NDNgLBedYw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=Q44ljrQA; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=mpCY6uAl;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=RrND9HDX
 tGM7Fq5gbWj7QVWsA02TIkIilgSin+ESmpQ=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=Q44ljrQArDEKDlIfN85wNTRWqsDGxqSfXSK
 KmLCL6j88ANpGSexWrM2gBtuyb+pP9L1DlUkmkTp4RRlKOScN23Kc04UvBf4pNfkGimr48
 yL/kKQimW+iHXvaBMGaK9wGLUrWU+zMyHp390MoiF4i8q26GpNNPQcbVF9yM53UNfP1kWs
 YBpiXdSglq6jGuAdfOyV36SzJdp88GH610Iu8mt743mPgkolxxKHifcivGyCM1aG1Zjqya
 lx94At8sNlgnZ4BofckJ38hInJLS8EvXddlDym5fmk7iZqN7fFU3G6RNCjWwA3FpIlXCum
 NG76217ktsamtusHxpfVJZnULEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=RrND9HDXtGM7Fq5gbWj7QVWsA02TIkIilgSin+ESmpQ=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=mpCY6uAl3UlDd76t1H
 P9ZZUJi0254vdgJoI1eWBWhzbxpvTtKP957yu1AoMNEVAy1SV/zcENayoPzRBt5vUcCg==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id a7eb329b
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 2 Oct 2026 01:01:10 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 6f518043;
 Fri, 2 Oct 2026 01:01:07 +0200 (CEST)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Kirill A. Korinsky" <kirill@korins.ky>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Miles Glenn <milesg@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PATCH v3 2/5] ppc: Raise decrementer IRQ on zero write
Date: Fri,  2 Oct 2026 00:59:01 +0200
Message-ID: <20261001230058.11465-3-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001230058.11465-1-kirill@korins.ky>
References: <20261001230058.11465-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: "Kirill A. Korinsky" <kirill@korins.ky>

OpenBSD writes zero to an edge triggered decrementer, then enters idle
expecting its interrupt. QEMU defers the already due edge to a timer at
the current virtual time, leaving the guest stalled.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 hw/ppc/ppc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index b123b4cc1c..6f99b61a28 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
      * an edge interrupt, so raise it here too.
      */
     if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
+        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||
         ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
           && signed_decr >= 0)) {
         (*raise_excp)(cpu);
@@ -1104,6 +1105,12 @@ void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq)
     if (is_book3s_arch2x(env)) {
         /* All Book3S 64bit CPUs implement level based DEC logic */
         tb_env->flags |= PPC_DECR_UNDERFLOW_LEVEL;
+    } else {
+        /*
+         * Classic 32-bit edge-triggered decrementer: zero write fires
+         * immediately
+         */
+        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;
     }
     /* Create new timer */
     tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-- 
2.55.0


