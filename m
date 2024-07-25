Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE2AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Nv-0002RL-VR; Thu, 25 Jul 2024 20:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8NK-0006i0-Jp; Thu, 25 Jul 2024 19:59:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8NI-0002Hl-VH; Thu, 25 Jul 2024 19:59:58 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70ea93aa9bdso354979b3a.0; 
 Thu, 25 Jul 2024 16:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951995; x=1722556795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XteVHqBd7jEgyDB44R+ilPurEblvDxIq4jl6JsrUcw=;
 b=kJ6zVrMZToHNyGwndd/yppPYdCLxtCJGo4svwa4BwHr42UQtVHqpRGKvFUHAliNCgm
 r9Cq4uu6pq+BpiSc1UdCKZkPXujdSk9sCNYZEiou+97HtYi91DtJQX2fmh2Prxin8yQ5
 icg+OZKUlPIp7cRPm5tgXsNn7hra/0jGyqd8iaRXV72JJHfJ93X+yENGyA+eeVnTwkqn
 /qortB8Wf2zvJUvtt1MnPZYbqYdjkpIDA6OJoFftc4utxE85fMYZpx3+hipt1EHW0xos
 Rp646mRZnt1fPwbHks3XIYkUAS3tS1f0mxy9LbL8UVG/nskbci6oR/CrNq4MbExMPzg2
 z0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951995; x=1722556795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4XteVHqBd7jEgyDB44R+ilPurEblvDxIq4jl6JsrUcw=;
 b=N0w/qiaqKsTL1zPyOOO4agL610zD91gRxJM0+RDjk6wT+TGIesxuaPGcIq1I6ZruC7
 xo0NvM9NaL33HTjUQlXhy5AwR7Y0zImLXHSQRwLfULlyvE8JBWLuCdcg5HDInMyspjAt
 lw18++C88h5P2NLdoApToxge5iu2jvQDI2xiGks22BJF0kYHv1dbrNzwVmk7j6dwswwl
 u5ZWRC9n09ALDJjfjfbeyeohHPlnZa5Uz9e3Wk/8Ck2RfmwclE8urEO8INuqLMksCbvf
 duvYo113MOpS8dxkpVaOFVY2xazWTcBSF3h3pk0fjAK0aMZIkq5qHyHJ4SITbeOEB6Zc
 dUxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgMFDz/QER76OwU5OJ9QLX4qlTAs6+15tIIB1jCUw/xzRlmfhVoMdJf//QHS/FEc0ext1Ih5SI187AzXRdK2Wd6se/
X-Gm-Message-State: AOJu0YzTLcdprBO74nPmASZ20X9h+XwSIWTE/uYG7xD+jJHk/l95ulng
 ss3ha1Gm+SzkqszC6/zKOD3Y2Z0r3hr+IFGRXU9aTxmrS+g9Cvt08dMlww==
X-Google-Smtp-Source: AGHT+IFtHT/DT5LfNSnDTFLXyIIpWcMjUGVsNR9i6eyqu84wOmEUFuupUc+ZBTyJLbHPXC/t5H2KOw==
X-Received: by 2002:a05:6a20:d70a:b0:1bd:248d:990d with SMTP id
 adf61e73a8af0-1c47284fde4mr6014759637.25.1721951994715; 
 Thu, 25 Jul 2024 16:59:54 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 96/96] target/ppc: Remove includes from mmu-book3s-v3.h
Date: Fri, 26 Jul 2024 09:54:09 +1000
Message-ID: <20240725235410.451624-97-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Drop includes from header that is not needed by the header itself and
only include them from C files that really need it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-book3s-v3.h | 3 ---
 target/ppc/mmu-hash64.c    | 1 +
 target/ppc/mmu-radix64.c   | 1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 263ce55c1f..be66e26604 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -20,9 +20,6 @@
 #ifndef PPC_MMU_BOOK3S_V3_H
 #define PPC_MMU_BOOK3S_V3_H
 
-#include "mmu-hash64.h"
-#include "mmu-books.h"
-
 #ifndef CONFIG_USER_ONLY
 
 /*
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 7bc0323f26..5e1983e334 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -31,6 +31,7 @@
 #include "hw/hw.h"
 #include "internal.h"
 #include "mmu-book3s-v3.h"
+#include "mmu-books.h"
 #include "helper_regs.h"
 
 #ifdef CONFIG_TCG
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index cf9619e847..be7a45f254 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -28,6 +28,7 @@
 #include "internal.h"
 #include "mmu-radix64.h"
 #include "mmu-book3s-v3.h"
+#include "mmu-books.h"
 
 /* Radix Partition Table Entry Fields */
 #define PATE1_R_PRTB           0x0FFFFFFFFFFFF000
-- 
2.45.2


