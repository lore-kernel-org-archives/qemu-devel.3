Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F11C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJZY-0006t6-Dh; Sun, 11 May 2025 23:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZU-0006sL-E7; Sun, 11 May 2025 23:11:16 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZS-0006hQ-NK; Sun, 11 May 2025 23:11:16 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30aa8a259e0so3664415a91.1; 
 Sun, 11 May 2025 20:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019472; x=1747624272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LMCKPO/n+BoIGsw1L/n2w4PQ81+aWohfHdPU7DOYMI=;
 b=HMsUCMjssBTGy0267wGUThSY1/uY+/I2zFsMLS4s+Ed1csW7+URWQK2jC3EwAtb84J
 Fj1n5I4xkjScbNbl010Ip8/cp7+/9/4sYozcW+epxjt14qNv2Lo8ff8XKL9LF5w6xI+r
 CG9Xja+H9zjAb7WhHLhSzcOJUko+mUFphW2T8U1SaNcy6wq7TnYBgrdm9M5diQaXaZGT
 agdi2B5IhNO+MG+y5KN8oElUlh2N3wWSXJwOzAv2BLoZOGWqS8IEzqQDXDWI1nlFLQvq
 yM94UHri7VflnOvePpFDnwJqWp5drmjzxY8m3HIZtm7IjJwcdLpPUxckYGFmUJEt3Uuq
 0gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019472; x=1747624272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LMCKPO/n+BoIGsw1L/n2w4PQ81+aWohfHdPU7DOYMI=;
 b=Z/jYwaUgT/Zf4yw2UmaMhWbxcKqicXGRcQaM5poAwy1lSdQaHfub8Z0FxBIpvG5iIR
 ldIp5A8JrTUCxkXE18t6sgwsmIFP0gjcsKfMV4dKSz1GS/du5ztJqTQGOKHIApdl66Q/
 TV28qLCd8hx9GTHKr4UUSAOvfq+OdAJQxDzKSEZ1YbuV/GdvjYezo8tRyzCVPEp1Luaq
 CRRrcdthY/oZK5+sF883OZ8mpI57EtYBShh1x1MpHP055piXJek5vrHM52CrioYw27MB
 nIVT/pxYj3h1cNSJF95PdmDPCymb9sKqAJgvxStNEK6pOA59Qv5Qvu551MAiC3cJg+zM
 NkfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWzPNQ3oP+Tx7aLsatQWOiueys7BxAfRdgPpBirwDSX/Lg2bc74syxnVhH3xEpjivnyNaWhDIEsHi/@nongnu.org
X-Gm-Message-State: AOJu0Yzj4xMsClU5DxdduD8MSzixlY4leZjjXdCb1pECbvZ6ZoGfwvfV
 sb1bxaZPKx2449D7VmrA23lC7WYNlSkMfsECMGZZQtbnHFS6w72ShR+fjw==
X-Gm-Gg: ASbGncsb3PSHQXe/qMTmc3Suti94MlNNBk+1SoqNxc/UgnWe2JIJ8PS0RwYTWO1Vzzj
 a0t3m1uI9EegBD4ptXbGpPNsZ/wy4hE7aArv0kjH3oHCyWAS1Yzk2PD4odTK0fw16gSUngP9ChI
 np8qV45jdjptazzdDZx5lYo8EZMgdR0XfkxOkXd0lj1QcSU1Kz0rbOlF3JpWWY91MAv5OCPNgkh
 OzI88mihPQXno5+LXf2OnDzko5TZaBUP6gk9INNYrIx5nfBXRkgWVovdFG+nIRzz7q6NSShQ1nq
 UTYwc1q0yJ7k7kn2lqtRRpX6Ur0iu6rfe2Pf9vfT01nJMapp9biJ9SrX0A==
X-Google-Smtp-Source: AGHT+IEU2yVZeJaMMUdPEBdTFvXWA+h6pl+chcxnWkxz8BG5OSs+D6OUwp+jEsGwt4NSQ/Y9C5UVMg==
X-Received: by 2002:a17:90b:1844:b0:30a:4ce4:5287 with SMTP id
 98e67ed59e1d1-30c3b8fea1bmr23895220a91.0.1747019472349; 
 Sun, 11 May 2025 20:11:12 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:11:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 01/50] ppc/xive: Fix xive trace event output
Date: Mon, 12 May 2025 13:10:10 +1000
Message-ID: <20250512031100.439842-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
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

Typo, IBP should be IPB.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/trace-events | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 0ba9a02e73..f77f9733c9 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -274,9 +274,9 @@ kvm_xive_cpu_connect(uint32_t id) "connect CPU%d to KVM device"
 kvm_xive_source_reset(uint32_t srcno) "IRQ 0x%x"
 
 # xive.c
-xive_tctx_accept(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IBP=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x ACK"
-xive_tctx_notify(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IBP=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x raise !"
-xive_tctx_set_cppr(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IBP=0x%02x PIPR=0x%02x new CPPR=0x%02x NSR=0x%02x"
+xive_tctx_accept(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x ACK"
+xive_tctx_notify(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x CPPR=0x%02x NSR=0x%02x raise !"
+xive_tctx_set_cppr(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x new CPPR=0x%02x NSR=0x%02x"
 xive_source_esb_read(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
 xive_source_esb_write(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
 xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "END 0x%02x/0x%04x -> enqueue 0x%08x"
-- 
2.47.1


