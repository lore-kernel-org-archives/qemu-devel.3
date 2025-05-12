Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6002C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcO-0006oS-Pb; Sun, 11 May 2025 23:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbg-0002s0-PX; Sun, 11 May 2025 23:13:33 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbe-0006zx-S0; Sun, 11 May 2025 23:13:32 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so4730426b3a.2; 
 Sun, 11 May 2025 20:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019609; x=1747624409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9+8HrVEPnYNTSg+zbNsTgA2+OAQPBPqGzjvgGq7Of4=;
 b=XHcnyXAeEIkAmmMXjtl9iycWzox+JntJAMD3hPrvMkQ3OnF8GdAQc+mNcQ7cRXKVD4
 RTDEkkGUMtYNewQCFAniEVk7/oiBqHI793clAbnrlc1TqkxsmyzlxF6ReleZqJkfsKe2
 KSivalCT8qh3KoNSuA2tcWubsg6sVjN1B+9he38Cd8jzfA6GhjnKa3QmpvNCw0BCCDMf
 inplUYpPRIlYkM2lv7qqMUVg8HsvMggKPmKbz3MTWXq/Tsa11hahx/BG9QF/o9AhtHb5
 Y4IvqtrzO4Or8hf8Necztgyw09ijNQmqISkdOaroQgUnvLyojJ9jRSj7s3zhWUKZ2tQZ
 bLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019609; x=1747624409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9+8HrVEPnYNTSg+zbNsTgA2+OAQPBPqGzjvgGq7Of4=;
 b=Tz5aIU4WiBR6x5Oy8OXZhxc1Evc/wDwtT9u0+77zNrOlPD6JENz0Rj8HOJWKzRFl/W
 MZhw3hj13oeKeMkAFFp6Q/AQPKOHxwoHHLLoE/xsgwcNvdlopjkm3dxLikYTynTLL85Q
 iE3trAXUDcywtj74f9zezJIKYaCLWewBRD3VoRlgaNNhvUVfzQNzwP60aybIuorTPtGQ
 NpQ9fj8UBHjaFOrmxmHd7M6jhw/GqcE+YC5CZBPx9fSwedySwrH22AbOmC4hIYC2o1us
 po9o0asgx8cT2HMhQve1N83cT7HFhWsWFmk210UgNaUGbdNUolHCqhJYB7A+fK+5rWfa
 xVkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1UL7frYk0k31RqqUoCcjXh/wSbrIIbN4TZxjjiQ5YnjAkWldWMkeR1xqf/B2UoKhlRnf2bsD6eq7j@nongnu.org
X-Gm-Message-State: AOJu0Yws+LQ3M+Rl/uaTZnST7JHNFTvKffzscCoZlWWlT9ESNdWD9NYh
 ubkRKmi9jTkMdFh6Qdq3YMGB8BcN8lwxGNR5uxTMmKwp2QwyZYNmUhlkwA==
X-Gm-Gg: ASbGncuKuDo0CVnTeJ4BSthuoIILK4tK9o255eEzlSfJ42k7IAmr+82HTXLdbODCh49
 PsuMtIM1nqsXmnrBXmPt8L64LoUWgAsEqVQOXLrgHI6deNWjYH2byoceSqElSrtev5DT9DRrH8e
 czKybQTj2lP1C/Q55tzmggUyor0iioZvRFchUbKDn3jV27xHIlGuSqkC5I3kD1B0xV1mWow6UqS
 0yJgye9hrpOKDU0h5UDYFNo45lz1561W0G78yf8Yj3C6n18VUE+iEZ50/NBO1NpJs7GDqazEIJt
 bmaQtq7N2/CewS/+c759MJeAAJuT8l4+Ku9mAWpGJ4J4wdzUKFaAN2R9rA==
X-Google-Smtp-Source: AGHT+IFVtcJdk5bhW1kaA4yoknlCcpnNzB6XUCz/+HcSfa7GMxPjFIXr79GSG8P5YLoCCsx68V9A4g==
X-Received: by 2002:a05:6a20:6a13:b0:1f5:a3e8:64d3 with SMTP id
 adf61e73a8af0-215abc227a7mr15266775637.21.1747019608784; 
 Sun, 11 May 2025 20:13:28 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 38/50] ppc/xive2: Avoid needless interrupt re-check on CPPR set
Date: Mon, 12 May 2025 13:10:47 +1000
Message-ID: <20250512031100.439842-39-npiggin@gmail.com>
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

When CPPR priority is decreased, pending interrupts do not need to be
re-checked if one is already presented because by definition that will
be the highest priority.

This prevents a presented group interrupt from being lost.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 0fdf6a4f20..ace5871706 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1250,7 +1250,9 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t sig_ring, uint8_t cppr)
     }
 
     /* CPPR priority decreased (higher value) */
-    xive2_tctx_process_pending(tctx, sig_ring);
+    if (!xive_nsr_indicates_exception(sig_ring, nsr)) {
+        xive2_tctx_process_pending(tctx, sig_ring);
+    }
 }
 
 void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
-- 
2.47.1


