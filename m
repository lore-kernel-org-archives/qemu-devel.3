Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00086CD5BD1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 02:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSn7e-0003LQ-4Q; Thu, 28 May 2026 22:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wSn7c-0003LB-Nc
 for qemu-devel@nongnu.org; Thu, 28 May 2026 22:38:52 -0400
Received: from [115.124.30.112] (helo=out30-112.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wSn7Z-0001S7-6k
 for qemu-devel@nongnu.org; Thu, 28 May 2026 22:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780022322; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=PHHeFKMfCQ5OHJlZXywHn78de5gqxKcIKm3aEM9ZinU=;
 b=rIM3dB00MGVVffAqbrU7nF8FwGsKa4oiPknQoRmJKTBx2U9rA4xbc5lIpLuUo7kIcdTw6pQAFfMevXa5Kg0xKJGIdiR10JuD1klkF1Mi2gH1VBh8+wYRpxWhYWo9oPSJJEAAJnH/8j/8OUHl0Q6hQD+28+fhN+L6H3XW8QP/pg8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R801e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=2; SR=0;
 TI=SMTPD_---0X3nv9nB_1780022319; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X3nv9nB_1780022319 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 29 May 2026 10:38:40 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH] util/cutils: replace hand-rolled qemu_strnlen() with strnlen()
Date: Fri, 29 May 2026 10:38:39 +0800
Message-ID: <20260529023839.55302-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.112 (deferred)
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

qemu_strnlen() uses a byte-at-a-time loop with an XXX TODO
comment noting that the host strnlen() could be used instead.

strnlen() is POSIX.1-2008 and is available on all platforms QEMU
supports (guaranteed by qemu/osdep.h).  The host C library
implementation typically uses word-at-a-time or SIMD scanning,
which is significantly faster for long strings.

Replace the loop with a direct call to strnlen().  Add an explicit
cast from size_t to int since qemu_strnlen() returns int while
strnlen() returns size_t; the cast is safe because max_len (the
upper bound on the return value) is already int.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 util/cutils.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index 76a9442085..9869d8842d 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -118,17 +118,9 @@ int stristart(const char *str, const char *val, const char **ptr)
     return 1;
 }
 
-/* XXX: use host strnlen if available ? */
 int qemu_strnlen(const char *s, int max_len)
 {
-    int i;
-
-    for(i = 0; i < max_len; i++) {
-        if (s[i] == '\0') {
-            break;
-        }
-    }
-    return i;
+    return (int)strnlen(s, max_len);
 }
 
 char *qemu_strsep(char **input, const char *delim)
-- 
2.50.1 (Apple Git-155)


