Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1C1CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4q6-0003HO-5X; Fri, 29 May 2026 17:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4q4-0003H8-K3
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:33:56 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4q3-0002n4-1G
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:33:56 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82f8893bff3so6707714b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090432; x=1780695232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQp4e741RWeqANR+AnBnweSrNx7Xk2H8EAfqd4DwHpY=;
 b=CpshXBPZyOA5xjJpKTVoq5E7A1o+fKvXRmCl/5ghqAjNY3FbBbCqremTsCoaf156E0
 i/QwmOSTyhkiJohcHwiDQ6kwkx/wwAqYRcI9d6xnnG66Abe2X7ZRKZiwG4XWNqebZCcN
 cd15yikpP+wQU7Gsi06SkRs6HYz9+Xdu4lcbzmhrZGkqJVVP/u4dsHVa21m3D1/M6/6X
 oGawVs4+I7DS7oykjsYNPHYRP4YWeQwQs29/Te2VPXz+p3/wfwG40/+DToPai7of9V0U
 quqGYtvbwRMGYrrsDXHXa2GjcZ1k1Cc1J7KFs8wI2aWOc7YttbUjUoYFcL1IEcofVA5O
 eVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090432; x=1780695232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iQp4e741RWeqANR+AnBnweSrNx7Xk2H8EAfqd4DwHpY=;
 b=KxSiXeCTtWshTQ9ogNEGXoXDUX6BkAQB2mtUl0QND3H2WmV21wIXuvvAKpSJFVDutO
 HIG9i87cT78xC74M2aPqWlqFpHqJ99zsvLMDE0QWJru9PN7sEPVZOcHdoU/2FVqdOqBx
 1f2dV/ZZtlzbNwCgmgUmTxBGl0TwgbcOrpyofgU5TTdojkCzEBGTwbiiA563BPjipdud
 FYjEw0DXrrFmcswv5irvW8hHA6PF2FxP2hzdqsKjNXOJSM1MAzlxI8PHswtUWgwrH3uw
 uuyKtidxkB7jGY7qXZ+9KiJH5dSJXSuyXD46G72APQ8eKRpjQ5JEZx5gFui//hLFWnZS
 Qo3w==
X-Gm-Message-State: AOJu0Yzu2PziA2uxJZs3UHTPbHJ+52qFy2kaqUQHDALMBPVv6OxmycvT
 zRcgeWwmA+Kar1lirM+22d9h2cGeTI2R9kDyDQajW0tBSYO8C9pVip6DbSnuvvUESpM=
X-Gm-Gg: Acq92OHgnhrFEgNQiyz58j1J5ExrmfjWqcRlB3vSq+CBflYF+g9frtCfgNOie+F4cHm
 38hrsp5RLsNQBCe/9ikdVvyJe4B2my73a3p8JdAfUHhOXmgP0RAhCouA2paRLRwNj+wKtiJE+fM
 d4aXM3Po+qiN93U2k4BB0CtKBcaBgB7jl5n8APwMA+S/eu+YrT9C8LwEIDrUSdF9QtMD5+Zh0sj
 ImNom7+v7vi+hcbO95Driyo2CneimyxMFpFOTzfzcv/6aPTh0LJHmolk70Ns7l2myJvD92Il8Ey
 Gl6n/JiSulUAFXHLtxeQSg9XAI14gM8O/+STTTCFLf96RvlNuHGZTd5TesKgR/Vca7ts8q3BmyA
 qjTlBYd6WrAt/L2vvE4BxwRbbaI9SZG17OICNiLTeTMXYMERZ9x7QLjsfJGlZ2lzIvZ1EnBMm3w
 HXmno6SDuJ6L7L8kCWoor/go1lQt7l2dwXkYnMmOszz54W9+W4zXALzFWuya0gu84=
X-Received: by 2002:a05:6a00:288b:b0:83e:ccd6:2dc8 with SMTP id
 d2e1a72fcca58-842255cf64fmr1164964b3a.27.1780090432514; 
 Fri, 29 May 2026 14:33:52 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.33.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:33:52 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH V8 01/15] qapi/misc: Fix missed query-iothreads items
Date: Sat, 30 May 2026 05:33:07 +0800
Message-ID: <20260529213321.96271-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529213321.96271-1-zhangckid@gmail.com>
References: <20260529213321.96271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x42d.google.com
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

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

cc: qemu-stable@nongnu.org

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 22b7afed9f..c71a5fe657 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -123,11 +123,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.49.0


