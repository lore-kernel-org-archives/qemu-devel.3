Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0B7C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcP-0006s0-DE; Sun, 11 May 2025 23:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJcD-00060P-H1; Sun, 11 May 2025 23:14:05 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJcB-00075U-Sz; Sun, 11 May 2025 23:14:05 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7376e311086so5554029b3a.3; 
 Sun, 11 May 2025 20:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019641; x=1747624441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3aq6xHzxMbY76ahwW7NMoS3wuliK3baz43I33HUj9BE=;
 b=UNKusvHi5vO2Dr3KBWUsie/TD17/Cosc5wWLzEC36UNJFmIk1BZunCK2H4mFwZFTZt
 UGiIRAReke4iKr4peVqjCPSWXk7lfC01WLFp7k8kE/vUdDljJPAvXcwxQEJlc/N3NYZ8
 /iko9iKLFg0gt61tN/GHqU7ANZoqjOwGBpX62BsbuhmpkxKxwp9cNgB1RRlSAytxwz6c
 EIiqlKrVSta2BXDhSIGqyQzkIh2KTGzdVSg8zXr7ewFLVfkH9wV33VoiGTY0ZZz+lXWX
 6afUbDA7vhVqTTd1NZ9RIGeeRinW2STNIoPn7F0jrPOfXvKcZmgeYgJACkyccmxOe5L6
 XPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019641; x=1747624441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3aq6xHzxMbY76ahwW7NMoS3wuliK3baz43I33HUj9BE=;
 b=K9a3TtkDg/XqnRmbp7jCC5vewg8iMmDV6wm/uMCRXgMQ8nj+CZD9Og7v1/MC9YoZu8
 omz6MeHfodfFN1vdsLO11fQlVLUZYUx5WrFYKNCMTAODeFawoyCP/ct8pwEjTV2QvZns
 3HvfEzDpLkUdi6KNC+4YDQ2KzFMC8ZdHZEgTU8g/NThTGbTMv+gbOw1CW6e0rezmu/rO
 KnSv/DQmr7W4FDokw2R/VoRWh2EoczdUYCaZIRFgK/zvpAcXNovl2WQ1bBPC0Y7U0a8x
 gjYz2xLDfHmtKBwmd4P01GZxFsgNcBm0XUq2FewUV+eZZuNyZhCVMJZ1UIHpjFk6JpEM
 ejuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+WZFoI0HLuGFA1tTXiFp2QlOJDvRjP5xqIQLV1+Ri0rWOm/4JT5a0Z7a3XitAi75JRErbV4g9bAEq@nongnu.org
X-Gm-Message-State: AOJu0Yw0PUiaAYJk/44ynfz2TzwectT8doCirMp0qV+Hg1h9DJ4baKfj
 0Ep6qp+RMupMUraZWWoPvPAUhoJ9OKnHFPz2IQl6F81894STXVJFmxFRSw==
X-Gm-Gg: ASbGncsNJEyWgxRrV74UbRe7+8N4qHYNRI1gUz7Mfn6Ip0Hrhx0lrmA604bOVyp6IXm
 TulP5FAZoJVrpnZ9P2QmGvDLrGMYJxNKqs032QGfFZkOk5i3AtHj951eiaBk+65Ono618uZe4St
 nn1bBpRp1cwm9b+qrbw3tmM/v6bqLt1WqDLavE6xqb54/t/P5Ie5VCoE2BKd/rcFgCI1N9/AvAw
 +ynI+jwQ99Aec+Vp4hGl24ezuD0L/VKnO94BS/vcLJCaQ7eNs1eB6Jxc/UfEhzH8DvL6JKBHVy5
 WhLpowaeXmkIz0QdCWyHDCwe6Rox9BHI8OlJbAkmlt7RXcdW8VUSfqI1uA==
X-Google-Smtp-Source: AGHT+IHUhNS1jnJThKR55wIbiafTkUucHr+yBXA3/LBxoomIXmRrUpsA2TlZ+2EZ+oHe/28KWOpQFQ==
X-Received: by 2002:a05:6a20:2450:b0:1f5:6c94:2cc9 with SMTP id
 adf61e73a8af0-215abc22f24mr17498125637.22.1747019641430; 
 Sun, 11 May 2025 20:14:01 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:14:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 47/50] ppc/xive2: Implement POOL LGS push TIMA op
Date: Mon, 12 May 2025 13:10:56 +1000
Message-ID: <20250512031100.439842-48-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

Implement set LGS for the POOL ring.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index dc64edf13d..807a1c1c34 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -532,6 +532,12 @@ static void xive_tm_set_os_lgs(XivePresenter *xptr, XiveTCTX *tctx,
     xive_tctx_set_lgs(tctx, TM_QW1_OS, value & 0xff);
 }
 
+static void xive_tm_set_pool_lgs(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value, unsigned size)
+{
+    xive_tctx_set_lgs(tctx, TM_QW2_HV_POOL, value & 0xff);
+}
+
 /*
  * Adjust the PIPR to allow a CPU to process event queues of other
  * priorities during one physical interrupt cycle.
@@ -737,6 +743,8 @@ static const XiveTmOp xive2_tm_operations[] = {
       xive2_tm_push_pool_ctx, NULL },
     { XIVE_TM_HV_PAGE, TM_QW2_HV_POOL + TM_WORD2, 8, true, true,
       xive2_tm_push_pool_ctx, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW2_HV_POOL + TM_LGS,   1, true, true,
+      xive_tm_set_pool_lgs, NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
       xive2_tm_set_hv_cppr, NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,
-- 
2.47.1


