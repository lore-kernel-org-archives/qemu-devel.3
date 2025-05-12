Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318DBC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJZl-0006yi-KF; Sun, 11 May 2025 23:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZj-0006xm-9c; Sun, 11 May 2025 23:11:31 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZh-0006jQ-IH; Sun, 11 May 2025 23:11:30 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-30a89c31ae7so5230407a91.2; 
 Sun, 11 May 2025 20:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019487; x=1747624287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftgY52O8U5rB01AfG0DWav75M3+1FQBbiSmbGilREmU=;
 b=L0g/qWRBbs/E8MW2UitF6IMy6NXBmdwRMLlo+1WqiPEWkIb0mJMDocdn80kH/63Zlr
 yx3OLUzNqhZrkKKyRi5ENrWcgWN+/0EP+QtDNsE0AegFzIKf0wRUPbuNGD/XQv7lQCTn
 Nzjs1gfxUAaLvaDuyP4BRMDixzAeJHnXIznGWF6edk6oOmjgUv3rWUZ3x+biXrwRdfXU
 om0PEWLbFjroc2SOnFPXapm4DI2M6WoiI9VVmUA0OpfJx1Y8CXxerpbLuGgRfzKGHIxh
 cSypm0Eh2/i9Rvj3wATQDvGGI6Pz1BDmXBdYXHr7wItalABFGrGZCK/KmmXPWKkJDJQ7
 kQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019487; x=1747624287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ftgY52O8U5rB01AfG0DWav75M3+1FQBbiSmbGilREmU=;
 b=s4wqh2k1s7d0cyg2D7wnGNCbox6+t1uD2FAjbWpj9p5HTtQ25ZgKHLqIgEv6GPV2S/
 0pl+i5qw8JY+MRei5ATTIDJaQ8uqkCtPzFxJHN+tcjfFJyFgoMVeh7W5o3pEzb3Y9OoQ
 oahCVFfbSSHx/04D1qjbGYrkTS1TGJpvIE6qg19OgWcoSkMnGssOSk4jp1d94Mqqo/KT
 KrhhoSTdCw/Ns8F3sgU0zpl5ChXEUlWJ04zLxkSZc39p+T+mrrXO0HsojzOW2KsIB3H5
 gn6Mi0Pep9F63bYgQzBLLVB3sY4kiEWrzZnwr7e3dGYmNzwbHSvPfQyyd3xLSsIfu8kC
 clPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6kUMDD8lRlCqXrzxc73pEPKNcEWCclgIpBJcYWhEgb66UfZ3u2j0XRo76/hTmS0r6SCUrhO7R1mq2@nongnu.org
X-Gm-Message-State: AOJu0YyptQvmiItNf+mK7jyu00tCnGdn7+yRhLgPlb2EJ/6wCqzpsgPO
 NnCwvP0t1FeYyc7/SuTw0b09oRCYZzno730AhUqzGHbh6diXEmibC85e4g==
X-Gm-Gg: ASbGncsiQJfRHFnd+rRuuboPzpyt3RboY/BTThJZf72iXg+b/Rt1QXghWYdavey6lKU
 vP3C+52UVJwNbR7smQ4VI1BhM+QiSKLpzqFKOIa9gGdRWicbeJKTeAvBrxGd+f5jvcQ2AaWmX0a
 dE4BD8+IW0Teuw+zUOqCysIMJNw3Is0bXpMokzzncfHdwUKOU8khygYK98Kn+21kdnjBJRxwviD
 7PCpyrR0Nm7fd+YHPbUEZUB0367kXpFfr2ixx1WUHuTXYGfF70jW896qkFDzQ8KDYB9AFGi/dsP
 oS6jkgJt+w87VTstJCzvcsECESE3RBkD2JQO0QisY3RsQhb0gt3IAy6HGHBsEFV7o0hh
X-Google-Smtp-Source: AGHT+IGJPCzjJWn00O8Nd0StjreT2c5YEc17B5v8JunnQigJYBT3gnbIUUpK+qKzDBfhexTOEPsSiQ==
X-Received: by 2002:a17:90a:da8b:b0:30c:52c5:3dc4 with SMTP id
 98e67ed59e1d1-30c52c540e9mr14536365a91.24.1747019487265; 
 Sun, 11 May 2025 20:11:27 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:11:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 05/50] ppc/xive2: fix context push calculation of IPB priority
Date: Mon, 12 May 2025 13:10:14 +1000
Message-ID: <20250512031100.439842-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
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

Pushing a context and loading IPB from NVP is defined to merge ('or')
that IPB into the TIMA IPB register. PIPR should therefore be calculated
based on the final IPB value, not just the NVP value.

Fixes: 9d2b6058c5b ("ppc/xive2: Add grouping level to notification")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 790152a2a6..4dd04a0398 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -835,8 +835,9 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
         nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, 0);
         xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
     }
+    /* IPB bits in the backlog are merged with the TIMA IPB bits */
     regs[TM_IPB] |= ipb;
-    backlog_prio = xive_ipb_to_pipr(ipb);
+    backlog_prio = xive_ipb_to_pipr(regs[TM_IPB]);
     backlog_level = 0;
 
     first_group = xive_get_field32(NVP2_W0_PGOFIRST, nvp.w0);
-- 
2.47.1


