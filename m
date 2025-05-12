Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2447C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcD-0005wu-Oc; Sun, 11 May 2025 23:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbk-0003HV-F8; Sun, 11 May 2025 23:13:36 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbi-00070T-J9; Sun, 11 May 2025 23:13:35 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7406c6dd2b1so4453759b3a.0; 
 Sun, 11 May 2025 20:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019612; x=1747624412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GQiqAbLv2hLPfJWDP+1dBwjaMr1KEBVw4hrwsXlMz4=;
 b=cw7lkVJbrQMPkuW4dRY7NeZzBPXzmL7sai0xkVsDrgB8DZp1eSOVFIRsOys/DX5Co9
 eT1+CQgPuyE9aMSWmiNZHn91q7wWoTJaXso908qbXRbZOXdD4hfe8FQSoz8WlxLR74hr
 rvRKBPb3bS6o1Es9D613Te3NaTtmfIXgRxAaQD1grkYtAEYVUYe83WgK4JJvtEmU3WNC
 0QUtA6i/0IvU86/3eDTxoi59ig4ZyiLzG0AhFbSPKwCj1JHZixwF+p2FVO3ZSMiYZ9e2
 5KokW83FKeW3Wsdj1anSpnyMZ13YbjPBOZjlLyeqYtf5kfeAa/v7Oupcum3K6b5CRbzR
 IAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019612; x=1747624412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6GQiqAbLv2hLPfJWDP+1dBwjaMr1KEBVw4hrwsXlMz4=;
 b=NLzFucRtqWT4etq8rTF8aLG6gVx3AvLyDcBOhsWmEEiZIrINrhFsctaw8r/sZVYRaQ
 NIFIFOmTNzWq1GkkV9/I0jQTZj4z+6pbKQLutSU8vEIZUmFu9Vlq78h91Pya+X+y++U4
 4Ne3Efrn46adGB9KkBJpyc8poY3PuFxg8cSl0TV0oSX256wUGpSLDh6rEMqydqqVSAQ1
 ZI3F0Zcz68eUXK+nr0/jHWcG5KHVC6PdClL809fK1DBCEJ1mtLXC+bojA7bioUZlNOYj
 FNRAT5YXCi6ePtbr8ul3F3ZMuq9n8QWzvXRfc76motXRCUqLoXvYpUSAR1MKTpLPAQN4
 H/6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX92CWjU24qpx9L0GLHTV/vvevv/QmD87a+ERobMil0XNwkGaZ7haS+8wSbXzi6xwCCDX5CwCWk5qI@nongnu.org
X-Gm-Message-State: AOJu0YyRNDTQ23Wmd9T7WJ63txmbYwPbGC65HUqUm2UF1hsCVoBwcaI/
 LGKFqywlaGnysi1TXlfF1eDf6T6P+VLaECPohkNCC8EZZ5wtpki94/N2CQ==
X-Gm-Gg: ASbGncurnQQ/qkmfry8kvgm8OZg6SwOovcKttFb1Wx9d30a5WWdOhGGdw9CaSMrklkl
 OuXh10Ijb4tn+YnGNcJ6GofD8upPVeXp/2Vx2LAXjzgCwknAWQ0IQQLzirDSJWZSvEZ7WusFN5t
 +0iJfsiNb07UhVSLB9ndSSbKRlY9u80nIf462vl3aClB6HnmJjtJOfdjOWPzIU8ujOECT3IpSTd
 LS7umPH9YiH6lx8BTtiuYA+9U7mOC+Yqhx0ajpLAwATMmgRdsZ5B0XXzh0l/blbb0Vi7MnSTNex
 iVTQntGtXguTj/LMCxEmT+NgRCGYyAqF4O1hrmncq/So0khAfGNkRLbDfw==
X-Google-Smtp-Source: AGHT+IGBrNTRS4RntF8WY0QLrnENVQQjKrqztF4HZZONPbHhLtiRIWmtLjwmc7CBqmiU8FPN/B4ebQ==
X-Received: by 2002:a05:6a20:431f:b0:215:e02f:1eb8 with SMTP id
 adf61e73a8af0-215e02f1f9fmr390850637.14.1747019612414; 
 Sun, 11 May 2025 20:13:32 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 39/50] ppc/xive: Assert group interrupts were redistributed
Date: Mon, 12 May 2025 13:10:48 +1000
Message-ID: <20250512031100.439842-40-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

Add some assertions to try to ensure presented group interrupts do
not get lost without being redistributed, if they become precluded
by CPPR or preempted by a higher priority interrupt.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c  | 2 ++
 hw/intc/xive2.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 4659821d4a..81af59f0ec 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -132,6 +132,8 @@ void xive_tctx_pipr_set(XiveTCTX *tctx, uint8_t ring, uint8_t pipr,
     uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
 
+    g_assert(!xive_nsr_indicates_group_exception(ring, sig_regs[TM_NSR]));
+
     sig_regs[TM_PIPR] = pipr;
 
     if (pipr < sig_regs[TM_CPPR]) {
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index ace5871706..e3060810d3 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1089,6 +1089,7 @@ static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring)
     int rc;
 
     g_assert(sig_ring == TM_QW3_HV_PHYS || sig_ring == TM_QW1_OS);
+    g_assert(!xive_nsr_indicates_group_exception(sig_ring, sig_regs[TM_NSR]));
 
     /*
      * Recompute the PIPR based on local pending interrupts. It will
-- 
2.47.1


