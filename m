Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821ACD3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 10:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaAfo-0007xl-Tf; Mon, 29 Dec 2025 05:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vaAfB-0007p4-Hs
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:39:46 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vaAfA-0000FZ-3T
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:39:45 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-34ccbf37205so6687330a91.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 02:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767004781; x=1767609581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0HjVDu1KKaZEVDhVpQXw2F/PCF8s9RlfszGzbJVND14=;
 b=lZc0XQahAdzrMS7hPairAeQiymOg5y0vZfFowWkh4qkdtvgF80yozMURzpwSYwtgip
 y+h70OPH9/0nxf6cdLNry+99qVMl1v5mYPdIxF9oCxexesB2LbNff509giM80KwXFoOC
 f+HZPNNpyDGhMv264BvXm/wKCdTvNqP9hTJA6qjxrFTugL41hL9yGzL+zMyLRRksxYzZ
 1EuVWpLtQ8tYIMfbddSy5dbC8rGuZ6YujrEb3eHFcceAXI8USc74ZgaPgOXn/z/QvJrb
 PPnJMzPgD4R4wbYIOPXwlsltSn35gXahLV0z6cCwlkSyMPU15U3bsPnDR/etIokjloyN
 P1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767004781; x=1767609581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HjVDu1KKaZEVDhVpQXw2F/PCF8s9RlfszGzbJVND14=;
 b=tbkj5jdJrB85fe7QSQ9MJMrkfFTOVXLb3PTQqwma0Q2+xnoS+serZJz2FqiRS1PC5H
 m4/N0HxaPbjvuRxLJ54X3vVr0NMXOuFTRABjebWbmTXbfHWNMPKIhIISBFq0TuhFIicQ
 5xcudnjylvS9U7udVqg812qZk7+dRX7+AU/RskrgoiYK/+fCtNfZmdQAJ6zfyZc5OZnZ
 MQkCkuhML1G9u4GVxiumWnzvmVVFnqrmMl6VZ1sKJfObUUoNzPdnSmbGXUOI4p4SJ0bP
 YvAzqXujEbokWxATX3mG3Qatr3BBlcKbxBRuX8Ajm1b7m0XN5jJYdnl68nva8CAudZ+b
 W/kw==
X-Gm-Message-State: AOJu0YwEiWqIGOZ7flaWYrD9tPUJzjzztBjQnRXPzMJushgQx+Fsl2gl
 ycBNdfLqIbwEl3+V66iRBxgS1DXf84xNv9yKKcQTqQn0HVEOs4KgLy98HteZ3Las
X-Gm-Gg: AY/fxX714DPy5TFL8wxu/aPsU3Lovcxr8vZrOBG6224jPtDnL8jyyNDyk3bDi97xXsy
 QXcYUoYKiV/LIwsoH+FfdLl1YxASHTttDqgmFpxn9D1UugsJHG6rWI1jIbMONJ4Z3khD7fbolZJ
 46EpicG5Jd3RX/Q/CW++znVJItpB7Y0VS4UYFQ+EElq1xiSQaHSPaY/SJWmVQt/At0xuhZzOzdv
 ZQdklQgUTTjnASatIK8EQehI+xzD9qxPhzModaGVZ3EtczUPTnBUFxS2OLKCiHnV81hFvZI9Dv+
 DyfCTjlkzbjUKif/p1S79juKZj7p/edDcKjRKEAytdRNjRl1kpo16eOEXYcogPzVO1LxuP5FxTI
 EYhXybJwM+E7jY7ZivVlsSOPYgvM/rPHM2CnPSgbog2QZUea5WdQKGvQQSZb3ejdK/2iks5zIns
 npOC5KRVNtSQiR1O3qzPNZHg==
X-Google-Smtp-Source: AGHT+IFTk6NnEJEnfCiHzKJ+YTu7SgL8uWJSt9IRE+i1Jku+ImFlxbP/79ZGd56+ah06OXtyA47PnA==
X-Received: by 2002:a17:90b:3c4b:b0:34c:e5fc:faec with SMTP id
 98e67ed59e1d1-34e9212f72dmr21308850a91.2.1767004781516; 
 Mon, 29 Dec 2025 02:39:41 -0800 (PST)
Received: from localhost.localdomain ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e76f03baesm17082982a91.2.2025.12.29.02.39.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 02:39:40 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH 1/3] qapi/misc: Fix missed query-iothreads items
Date: Mon, 29 Dec 2025 18:38:57 +0800
Message-ID: <20251229103859.98777-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102c.google.com
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

As the struct IOThreadInfo definition:
{ 'struct': 'IOThreadInfo',
  'data': {'id': 'str',
           'thread-id': 'int',
           'poll-max-ns': 'int',
           'poll-grow': 'int',
           'poll-shrink': 'int',
           'aio-max-batch': 'int' } }

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 28c641fe2f..6153ed3d04 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -117,11 +117,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 'poll-max-ns':0,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 'poll-max-ns':0,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.49.0


