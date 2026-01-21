Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD5DD262B2
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 06:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viRuE-0000Dt-6H; Wed, 21 Jan 2026 01:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1viRuB-00005l-UK
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 01:41:27 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1viRuA-00010Y-Dj
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 01:41:27 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81f3b4ae67bso3315175b3a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 22:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768977684; x=1769582484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rouqgSAo+m0gpVTi/PkxtDmhXejpv6rzGgSC2hvy3hw=;
 b=QUuQz7zlfLuGU8DyycbW1Eezpof2aeklQBYrJGRlK4yKC40EiKgQ5PXTphHcZOZ8cf
 SurKEo10m23JUVfblK7gPUfP9PbZUP3CyRiMWGl16OAuvNNWeCfaIVFtyg71YYj/j+Wg
 AplpdoDkRDb33l90Iy73BTg+7Skb4tTe8/xdZ70D46NQrXlmnV5zFl07+P3i5d54s/4U
 iuQ+bW6jZoTioHwCuCuxO7FlPpe7teI385qHfuzNMeI+wnHJbimflHTXWC+f4Ku9QYx4
 ZEkkJZ7dO8gvswm5YRGR27pH+QhhDElI2lnO7FSZJxmuml7M10gvgbMNRi/QjO9JKtl5
 IDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768977684; x=1769582484;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rouqgSAo+m0gpVTi/PkxtDmhXejpv6rzGgSC2hvy3hw=;
 b=TCqYSrQyiVcW1POgYl5IOVqZ3ORyHxHIs8ixnYX25W9PfAufi3ZqRzyg5HqrOLhVHH
 Lksjcj6e51kShxSJ6uj0PIL6h1pG8Yhmpox0MtxA6M/jy6UsbM3h811Ye+Hj4zotQ/2e
 WkX/5D5nFIcwDvDfkvZ+95eLqR4ih3aBqmO404yyG66Y8pd/2EMHoNlcJnBDA5pSErm5
 IH4NOXn+r9HtiGigPhB5XWv+LjmTKrqSlLSMnYzB5LhtsiZESRZr2XAnt0TScJUZHNjM
 bbfTrkj0dIENGddSV9RSnCa5Q1+cTLXe7WmoKlizMlcG79VcHlaFpixerxad4i9T4cmA
 N2fQ==
X-Gm-Message-State: AOJu0YxCLUp5qsPZULixCwXAlzTKm0ZhPXXNisPtYUTZAacqg2SRXkG/
 p3n4GQ0VCrFfXA85yvl+KD6BTrf26sAmizVnKq93N7t5CaWYPCZZWppHeIzwrNLc
X-Gm-Gg: AZuq6aKf+c2Z8HJ30f2pgFBZ/V41Hev4B//OnalAcfE1j5sx+8Da8ppmvIbFWuwt9Q8
 9bCSsgP0T1iQXSgzWzyVytuppbj71cFS0KOvsZYQwJUtY2zFQAQ/R6FPmFwxp34Y0en1vIQ2E3W
 FD6PwwdPCM9Sdb1KyBwbYS1nkQ07RMIZ7+9f5TKzooIRWBnwZ198E3hqmjXW7DjXX1aUOdMVfUS
 iNxLPPl56hTbbeUw02amqRnP0SnlaypvauJyaA6QZHPiEJ+rZ892CoiAd/TcglaLgYhNGxJ+xD4
 5bY7KiYNBRgqP6buM4mJrDRDVA62C6dm1AOBWvy6w7uwNHHJJtTiUxvRBoTIghFSK5B68U2znVy
 FL8TSSOueSPKZEyJ5OTo2imO5CJ0RVe0dLMZxXQE8iZq8Hu6vbYaF+80Xx5yTLhqcGqJn7qGTQb
 b06wiiepnaRJFzV/8=
X-Received: by 2002:a05:6a00:8c05:b0:81f:394a:4897 with SMTP id
 d2e1a72fcca58-81fa01ef1b1mr14691745b3a.44.1768977684170; 
 Tue, 20 Jan 2026 22:41:24 -0800 (PST)
Received: from localhost.localdomain ([180.87.170.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b3165sm13876714b3a.60.2026.01.20.22.41.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 22:41:23 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH V2 1/4] qapi/misc: Fix missed query-iothreads items
Date: Wed, 21 Jan 2026 14:41:07 +0800
Message-ID: <20260121064110.28760-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

cc: qemu-stable@nongnu.org

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 28c641fe2f..e87994c9d9 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -117,11 +117,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 'poll-max-ns':32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 'poll-max-ns':32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.49.0


