Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC51C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2Z2-00062V-GX; Mon, 17 Aug 2026 15:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yp-0005zi-Fw
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Ym-0006M7-Ky
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so19821835e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993186; x=1787597986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AUPnthLnZv0HXOGLcjECWuJuRRQZL1kc6hOnrSo+zaA=;
 b=lkRWq6d2Spbda9GOmt7lgnylBnxjCfGxKOl4nvINx+zu2SzAiUs7z4JWDK7h54HEAz
 WLlpW0IEdlQxBPCygNbpWsRVpqapRYzKmEjtKJzjffM55AN32+Za/uJyC6BXoDiM6LVe
 TUU76II0QlEVefsFq+O8CEhv6vjgL/3T0I2xYFgQXpJMcYDhLcekAKLm5xfwYQjOEiBw
 5yf43IuWMedRR0nCslDpgt7qgoT/bDJkkUWNl0FPT+AQwvmhQK+3JzofEVAHdpa6LTaS
 ru2ExdSo3Kv6SJ0LLEvAa0PUaDVw1DvZjEbb9gyD85gBMpKtZorqGmpefqnd6RGHpfeT
 3w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993186; x=1787597986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AUPnthLnZv0HXOGLcjECWuJuRRQZL1kc6hOnrSo+zaA=;
 b=f1oCRsPdAINUr0mtd9T5LWacvvZXwilIE9zjCz/HRCfXxrhWTQzLsUVQKKRku/SKth
 uBsEmo04bENBB4/jJFctpMlFyy1akGnA8od8FwM2sERBtG+OzoWO7EG2eccaDOK7UuS4
 8S0IOHdmiFe8UUUMmAGj1vX8642blbYQtr3pR75gpO928HJeGfj1CnZ+3TSu7WYDyMtt
 qt4wlNIl7wRA5GKuKSSaKVlpCGwzp7zxXzssRwV4okSVZfOmo7Zjqz2drvnv+xJ/gyv5
 UCxgaMVvk8ACLFounZCFOI4iWL5HWd9uPjEarfMT46rcrYNnndiv2DmpkAp6FXKpJARk
 k7BQ==
X-Gm-Message-State: AOJu0Yw31iu+0OSbsvLK6iSDVgy+XArxcZRu28qma+FinYUahuCgCBII
 UmgEHinjKJ7CCb6757gMoUVI9MeF7d5WBF9fN15QQzYBw4VZ4eFCX4aQMfsreWbkZKWix7bv99W
 lOzfZ
X-Gm-Gg: AR+sD12cWL12V9F82kRdaWKOHtH7XX21bsXoUQOEjMZ87T6hdoStx6Txwd6/Vmfl9t+
 rjMQIaY4u3hSdbQxRZA49L6RgMpfRwvbebMbzK0bhAEEubMCDQrAKFDIdiWAFshB1KuBxyDBoAt
 4sVVHZmpmSyTATqhEdqhXY+LEUHIIAjOg2kr68MSSq5OTs04FExsJ5QHl3BWkM588aF5vW+r1vg
 nSo2ddRaApqlUTqM/ihrQEOaNirKlbk8U71NM0bX5lEtT4mhb7z+sRfa1ZgR1c5eWWE7+buEUs6
 875OKuqI53Hliu+p+83EjP4MOIppnCyV6VLoYWHtOjYAnU3YsTQs2uk1X7oFof0o5O/uav6rciq
 Bd3lfLGqSKOWHakX/rWpzfdeDPte3Js9XOEubXeAXdWm7m9+9u2rfO4FUidWxgNJL9Eb5PXsJxx
 vUBmZ6w2cJqwUo9cfwuJNSEywHIDXH5d2hf+Uc63UsgXSj0foWFTTQVl3fPjV1
X-Received: by 2002:a05:600c:1988:b0:496:c93d:e2f with SMTP id
 5b1f17b1804b1-4998798dc17mr405865395e9.15.1786993186129; 
 Mon, 17 Aug 2026 11:59:46 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.11.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:59:45 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PATCH v6 01/25] parallels: Set s->used_bmap to NULL in
 parallels_free_used_bitmap()
Date: Mon, 17 Aug 2026 20:59:18 +0200
Message-ID: <20260817185942.1065143-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=den@openvz.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

After used bitmap freeng s->used_bmap points to the freed memory. If we try
to free used bitmap one more time it leads to double free error.

Set s->used_bmap to NULL to exclude double free error.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels.c b/block/parallels.c
index 50748d1415..94692275c9 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -254,6 +254,7 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     BDRVParallelsState *s = bs->opaque;
     s->used_bmap_size = 0;
     g_free(s->used_bmap);
+    s->used_bmap = NULL;
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
-- 
2.53.0


