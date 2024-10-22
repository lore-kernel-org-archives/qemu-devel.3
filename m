Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAFFD2CE01
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3I4a-0000Hx-B9; Tue, 22 Oct 2024 12:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4X-0000GF-IF
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4R-00064Y-B4
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729615758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDoKVxzboEyOZx7JDyIdlXgX6eUiunNnXmtg/ZwTIlk=;
 b=f13coFq2pK+lN51b2J3str8kjypkK+h4JwQPM03ZVlDyDh9B6h6f7xuV0drKAvU9asRfQ1
 IYLzml8rxhyzrrRegNfSTPulKcbeAg08mdVpDjC2EZhCWISs9bzaPETeKMg25AiF45dN6E
 gK+t0qpjYzlywBGawCkyKa8dUlo/8js=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-jp-gYhGgONWmZrwZfF9gGQ-1; Tue,
 22 Oct 2024 12:49:17 -0400
X-MC-Unique: jp-gYhGgONWmZrwZfF9gGQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A59E7195608C; Tue, 22 Oct 2024 16:49:16 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 745541956056; Tue, 22 Oct 2024 16:49:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 2/9] block/ssh.c: Don't double-check that characters are hex
 digits
Date: Tue, 22 Oct 2024 18:48:56 +0200
Message-ID: <20241022164903.282174-3-kwolf@redhat.com>
In-Reply-To: <20241022164903.282174-1-kwolf@redhat.com>
References: <20241022164903.282174-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In compare_fingerprint() we effectively check whether the characters
in the fingerprint are valid hex digits twice: first we do so with
qemu_isxdigit(), but then the hex2decimal() function also has a code
path where it effectively detects an invalid digit and returns -1.
This causes Coverity to complain because it thinks that we might use
that -1 value in an expression where it would be an integer overflow.

Avoid the double-check of hex digit validity by testing the return
values from hex2decimal() rather than doing separate calls to
qemu_isxdigit().

Since this means we now use the illegal-character return value
from hex2decimal(), rewrite it from "-1" to "UINT_MAX", which
has the same effect since the return type is "unsigned" but
looks less confusing at the callsites when we detect it with
"c0 > 0xf".

Resolves: Coverity CID 1547813
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20241008164708.2966400-3-peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/ssh.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 871e1d4753..9f8140bcb6 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -364,7 +364,7 @@ static unsigned hex2decimal(char ch)
         return 10 + (ch - 'A');
     }
 
-    return -1;
+    return UINT_MAX;
 }
 
 /* Compare the binary fingerprint (hash of host key) with the
@@ -376,13 +376,15 @@ static int compare_fingerprint(const unsigned char *fingerprint, size_t len,
     unsigned c;
 
     while (len > 0) {
+        unsigned c0, c1;
         while (*host_key_check == ':')
             host_key_check++;
-        if (!qemu_isxdigit(host_key_check[0]) ||
-            !qemu_isxdigit(host_key_check[1]))
+        c0 = hex2decimal(host_key_check[0]);
+        c1 = hex2decimal(host_key_check[1]);
+        if (c0 > 0xf || c1 > 0xf) {
             return 1;
-        c = hex2decimal(host_key_check[0]) * 16 +
-            hex2decimal(host_key_check[1]);
+        }
+        c = c0 * 16 + c1;
         if (c - *fingerprint != 0)
             return c - *fingerprint;
         fingerprint++;
-- 
2.47.0


