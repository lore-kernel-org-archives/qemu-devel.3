Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6153EC5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuw1P-0004Bb-W7; Fri, 14 Aug 2026 13:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1N-0004Ak-Rj
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:48:45 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1M-0007gN-9v
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:48:45 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso811044a12.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786729723; x=1787334523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GfEHRlE3qWkvYvqsb/RxYcyRStqr7mAYPCA67aZpLdQ=;
 b=XnCVPs1tUdzPWBhxhY/l8aJhoW6pk6bCUEHHyryBPAqmADuZy32UMlyh8560NyqKMO
 4Q/MW/CVNaWsnLNZD4rN03RFHdxTzcxRxhiV05S+fFNnKDDrteweoTVwXXZznjAtrCgX
 SF3qSZMRi4LXbzEgx4Tip0zTq46QXTlGk/JOK9a7ArYh/V4lroZ62I8ZdDQAY7pMJJs+
 th9C+zuyWHfT84y2640BwkEam8ji8rs1//eG/SM3sKdJ2F5PbwypF74oybaOZJ5Uh7vs
 EOSMf4c0hcDk0O8Odn1VF2aYfIBeoIPB1IOhUF9MvRaFhcvcNavIOSzdkr/HxkwG3Vpd
 Gu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786729723; x=1787334523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GfEHRlE3qWkvYvqsb/RxYcyRStqr7mAYPCA67aZpLdQ=;
 b=A9cndTKSR6RL/1d4Uo7D3CkMfRLY2eK1vBG6PvuVThbiOkm5EOi5FeiJ0soN683hCm
 jYL8huuSY5C88BCemw7puQrGlzBmijJ2cL/wlnyBUfxqWVeqd58ufGbfGdz+wdzIpTYK
 quMDp0k/HqFgiRuiQeVWDanYknpK3xkcn6cykYglvY1sSR6aHtAt4BDRol59g7G5Ryz7
 zqvZji3RBuHJk1Ogw0mV5vCvVH3P9aDI5+TwQ+IZ8CXXVwbabqs00kT8dUAqr8TQx0nu
 EckdSiSm/DLhOh0ZCjXgnJEcauZxdbUfX6LbCnINxQtd7KSWN0i+++KAuXzO5iAq+DWD
 asuw==
X-Gm-Message-State: AOJu0YzgsLY5U8+gsth0ERpegHDNGPBuBCCi0zrrJZ2Buq/pKLuV2Iti
 yt8r7now6o5Z9u4N1h3HOcDnRBDmCA+7+0AVNnovHLXjv1PUUp+a1KlNyR0BeAeO2WYj+A==
X-Gm-Gg: AR+sD13KYmHWpISg3Zq79TibxfysFHgD5cI/XStURKOXGCQgY274/QEveZtdSJumv8f
 4IK/acACQ9K7OqSPULC7wgfOTmHf/9qqpqNI1f4HKx7QyiV8VxSCZoN4W8bc6MMCPwb9fPhnhNN
 fy+mIb4mNYsZJdGP96UzVA2rdOkxA2WbocNQkQoDAiEiPG+Tgow6mYKJPFJ75Qzc/oEhigK2eSi
 FJRaQ6JLBzriv4LLkgU+wOo0u+2TIeXDsMiKBFzrukdkI6+9Y3NjbZquXf1TM7j5u2MzwnekWUG
 hHn824gktwULBxGp+nB9xTYlh1dUyGUqWtiYitmb8Tg6qEwgfgOb91MzgGFagebUNEyJl1buuOf
 g/pAPDzTwYhi0BLg5PtsP44Ki/ofhN1B3tdBIaWQekI+zB0+8En9MHv+FzP38GohwEF0HEdIjB0
 8T4rEGiK6Un71JxdD0W3m+4jYw87UdPljhYnxa/5Egag3viTiHwntRqfjNVJcjMxOxLqN1wzHVL
 bg6ObMQ
X-Received: by 2002:a05:6a20:cd90:b0:3bf:c28f:8afc with SMTP id
 adf61e73a8af0-3cc71707793mr9520364637.0.1786729722832; 
 Fri, 14 Aug 2026 10:48:42 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320e9df03f9sm6708081eec.19.2026.08.14.10.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:48:42 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH V12 01/15] qapi/misc: Fix missed query-iothreads items
Date: Sat, 15 Aug 2026 01:48:15 +0800
Message-ID: <20260814174830.1691540-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814174830.1691540-1-zhangckid@gmail.com>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.54.0


