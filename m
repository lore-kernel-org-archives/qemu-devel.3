Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A35EC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJZo-0006zX-JH; Sun, 11 May 2025 23:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZn-0006z2-2N; Sun, 11 May 2025 23:11:35 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZl-0006jm-9b; Sun, 11 May 2025 23:11:34 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-30a8cbddce3so3296316a91.1; 
 Sun, 11 May 2025 20:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019491; x=1747624291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q99inf5aLbJbNrOQn4VwsoFJUo2SQEJkEDFUVAgN/6c=;
 b=nSQDHKo9ehXkFoisWHCBJSrOT8C2e4gRpcgFPyqfT+wPx9OrysjaLxzy9tZLBIG9RB
 iUYCE6cRbPKu0iWXhuFKpE0vzuJDsV6NmVIJzhmjVO2KXy4EvBvOdonosH15/bnvm/6P
 eVKNz4LZP1XWwvu/Ay0gQ+9PWOWFqpiCi1g6XOu+K1xmI1a11DIA6fwW81v9xGirqSXI
 2iRdY4L0cDLH6gawkexxVh16+Kpbu4h/58bolUzmR//DTgGYHb827UIautmzuMg5mQV4
 jL1gEGIF0La4k3969xUag4jahud7d9WuAii6ykPGDhXf7M0iAJkSclhMiuVXKs2ZK7ay
 q4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019491; x=1747624291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q99inf5aLbJbNrOQn4VwsoFJUo2SQEJkEDFUVAgN/6c=;
 b=J2Z3QXXw1na2tVEQhHX2cb5iVewZCKgvhw5lF2a7NF6XUpJrBy2BxYtcl98v34RYwK
 0g3iMCsXcikARzg4xh7ZHTXh+KEtiA9K9Ho9uJ3YOMJAq/RwEfLCfbRGqlUqhXGawUZv
 mGZirfQC0Vv9/v0To83TWiv7XO1k+4675o+gNascADnZyKNeGWSdX4pybd8AxUkprxIi
 18szfy0A92dIkqU7kZUguoE/o8OsQS9crkyo7aEgg5sVZfB5ejYeJws9weEu65cGZVav
 oaPlAsMhQEkQfO1d/aXefdjOVlfFh6TQIkCI96XkZ0Jb/k9roEZ0oZ3vz/tLAQ2BkeTE
 HFVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiFGpd1LZb6AMPleHZa6qclStmt5mNi0OLHoDcjCDUS6SzkBc8ET7c/ufVgGs4i3f+7e1whCbTYSI/@nongnu.org
X-Gm-Message-State: AOJu0Yw7DJg6RrW14NE8PqPiJdsh/fVn0h5fOAfD4TPCw5c4kNgTdPuA
 eAfngCj/+fQ1uKcdv9xgPEA0STK2JAOAmeNi5B7F4PJ7c2JAn21niUZWFg==
X-Gm-Gg: ASbGnctlpjZgzv9c09pIM7y+oOgZZqJA0n0eB1UYzkG6DRnQSga/7i/qfZEDJgnzVje
 NN0bQ8T86agIi48XprEkDL/qolHs79TALyvj4REQBoU1SwwMJn4HnOgXUbjU3QGDZPgYxE8IS0X
 laUUj9wYhnpCVHx944yDAEXiqlMtnQkH/Z0qLpG9UPio37UOOQBVIIVYyQpBGrpxFH1OWjnHeks
 L9aerQBToaRL905ix4hpBXOWdIWh5az8NiMQ0NA/3CAZ5U1qqQEgal9uF3hh30aK1QYvX+gV137
 yLCw8PZZSjZ6spnhEliz1mAtkfE6ZsvHelCzy8rZVRL5mG8T1EWwBGHU4vVG/bPQ/GMf
X-Google-Smtp-Source: AGHT+IHNdH0yGqtbZC0u9vhJvE0scHFVbej54IdFnICOn3DrJy7ZB1fbMYtqnSTvn4qNx5d+tcMqQA==
X-Received: by 2002:a17:90b:4b07:b0:2fe:a545:4c84 with SMTP id
 98e67ed59e1d1-30c3d65e190mr15118364a91.34.1747019490982; 
 Sun, 11 May 2025 20:11:30 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:11:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 06/50] ppc/xive: Fix PHYS NSR ring matching
Date: Mon, 12 May 2025 13:10:15 +1000
Message-ID: <20250512031100.439842-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102b.google.com
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

Test that the NSR exception bit field is equal to the pool ring value,
rather than any common bits set, which is more correct (although there
is no practical bug because the LSI NSR type is not implemented and
POOL/PHYS NSR are encoded with exclusive bits).

Fixes: 4c3ccac636 ("pnv/xive: Add special handling for pool targets")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 80b07a0afe..cebe409a1a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -54,7 +54,8 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
         uint8_t *alt_regs;
 
         /* POOL interrupt uses IPB in QW2, POOL ring */
-        if ((ring == TM_QW3_HV_PHYS) && (nsr & (TM_QW3_NSR_HE_POOL << 6))) {
+        if ((ring == TM_QW3_HV_PHYS) &&
+            ((nsr & TM_QW3_NSR_HE) == (TM_QW3_NSR_HE_POOL << 6))) {
             alt_ring = TM_QW2_HV_POOL;
         } else {
             alt_ring = ring;
-- 
2.47.1


