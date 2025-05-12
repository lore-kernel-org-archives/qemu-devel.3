Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074DEC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcD-0005wz-OQ; Sun, 11 May 2025 23:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbS-0001Xh-5r; Sun, 11 May 2025 23:13:18 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbQ-0006yO-Hd; Sun, 11 May 2025 23:13:17 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb2so3614546a91.3; 
 Sun, 11 May 2025 20:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019594; x=1747624394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HsBj22uLdU+RqO7TIsmV1n+sWxv+uojwlrhxC1hIb4I=;
 b=MNUTHLO6NiDYJQfeg3120yU8HK8eQdIFpfAzuumgKfOoHUaRAcSjQXwWkVQBlBk8Fi
 Ks//bLoHUH8IGEpTQkVMFLLymRnArrT8UuOv9GkczoSzUtbmiv9ul96+qlwp1sUqEPC6
 8qb9xy63n/1WnsA8kud3JemxZyz5Rc+X6i6B1Hol+T5CD5MccPBrLHy3x32bR5olSHDb
 yZWNKDdDTBl/LVjvbkuMVa3OUwS0DnjcEwm3gkrLevRwBGdJ6A4XEcpjBmkjbRTWUbGV
 sKL3eaIBguX9fuCXia9dbpW37w5wHmml4Ona1dLg5rOEfno2Utv9sfh007HbZvkG8ICe
 GRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019594; x=1747624394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HsBj22uLdU+RqO7TIsmV1n+sWxv+uojwlrhxC1hIb4I=;
 b=vKuBnxstI+p6SQl65H9B0VSVxyB/4kkrnCDgPFZls3P8X/SKHQuZQlVvI+LsOYJdy8
 7UdZzwrAAlCOGt7g/juWHpKt/4i7bhThnU+x1uDuU11eOiX7RJZP8OsxcS86PCqsSyXk
 e2bWgi41xED7gYNP7h3zKmOqZWJKamehie5iDFW3ZRPDWTwuyaqL8g8CdC3h3EOuq1zd
 5yNkT0yPJE2ZeL5im2+tMv7F1cRxnlMTDwZGq3+EwXzijmHj4gcYDb//nPcFQmuozO7K
 bEFQdUybGZL3xLgwdtYERYYbkKr3oQu43NkiwZhr0xyRIlx3iUAbYpajaB+hnshmHGCD
 UXdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlGJje7d552Nv6piQ/20FHKLke5cpTHuXwWoeOcF+mf2rpcqC2yauMQTzo6pfvIye8McZZmst4XbpX@nongnu.org
X-Gm-Message-State: AOJu0YwFzOzhhb3ia+Rpz+Z2ixT/5NWXnJpPqhu18RX1Wp24neGCBo6k
 +4yl3T5RfOGzr9wJSXKkXzfQpZbQJP+8/n85//V7mHkJmCg6/wtqi++03w==
X-Gm-Gg: ASbGnctG4sbzFE3XfC5O+aLzw4CVIeTeE/tqUceVBzsoxpe0QieEoJRg167hZkcKqZU
 2JAumG7NJCJJjeshBd29Kp3+E/1tpFemKbL24m9e/3Y6Y4d4Rzxy/nRi9HO2bGqLD6I1MmCOgTe
 VeusDhoProdGZgVohCv81luIBvD9f+6fATAsryVMVFucjIwLM4rOWTAI5seCKWQsuYYCXUCB5yI
 TrE12g0HgEuEHyz+GghFxskpVEb53r7T4SwV7elb1A4RwLEq/o970pmzlWF4sf5Hz4Yg+95Aq96
 8qwDnCYmwhHk+oIgu0mlIQRwZbGirtWgw3pZal/TQfOgMPrdMwCkDCBAgQ==
X-Google-Smtp-Source: AGHT+IEO+OygOxG8AC8s/T+p2vJHBvk8f9gmzreYgrWlAwHECp9Hm0uNFZAKYrrusMc1lGq1+WhJMQ==
X-Received: by 2002:a17:90b:17c6:b0:2ff:502e:62d4 with SMTP id
 98e67ed59e1d1-30c3d653aafmr15267972a91.32.1747019594237; 
 Sun, 11 May 2025 20:13:14 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 34/50] ppc/xive: tctx_accept only lower irq line if an
 interrupt was presented
Date: Mon, 12 May 2025 13:10:43 +1000
Message-ID: <20250512031100.439842-35-npiggin@gmail.com>
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

The relationship between an interrupt signaled in the TIMA and the QEMU
irq line to the processor to be 1:1, so they should be raised and
lowered together and "just in case" lowering should be avoided (it could
mask

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 4e0c71d684..d5dbeab6bd 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -95,8 +95,6 @@ uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t sig_ring)
     g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
     g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
 
-    qemu_irq_lower(xive_tctx_output(tctx, sig_ring));
-
     if (xive_nsr_indicates_exception(sig_ring, nsr)) {
         uint8_t cppr = sig_regs[TM_PIPR];
         uint8_t ring;
@@ -117,6 +115,7 @@ uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t sig_ring)
 
         /* Clear the exception from NSR */
         sig_regs[TM_NSR] = 0;
+        qemu_irq_lower(xive_tctx_output(tctx, sig_ring));
 
         trace_xive_tctx_accept(tctx->cs->cpu_index, ring,
                                regs[TM_IPB], sig_regs[TM_PIPR],
-- 
2.47.1


