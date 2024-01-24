Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E47C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaiS-0008Bd-V8; Wed, 24 Jan 2024 05:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSaiR-0008Aw-6s
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:42:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSaiP-0008Em-Od
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706092961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qG7LlzPFeAc3w9HYJJ45DfjcNzEfiyMt+pw3J22zwoI=;
 b=OXpod+yRWpkZnhcGllYCscCNPOufmSW7IvaB8MTKIoZfIIoUVePTRs4+PiuM7UlRfEt9FK
 PzJVpWlbvnzoBUUzL2OPfNmCMunIGG22GDss45lQxQcONXw8A7JmOwVlERTnV324PG5xQk
 2TgkhsEmj31qOGgfnErY1ZiWASnIXyM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-uxm4KSp-MVSMTZMSRau3GQ-1; Wed,
 24 Jan 2024 05:42:37 -0500
X-MC-Unique: uxm4KSp-MVSMTZMSRau3GQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 168743C0F36F;
 Wed, 24 Jan 2024 10:42:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 171ED51D5;
 Wed, 24 Jan 2024 10:42:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/7] tests/unit/test-iov: Fix timeout problem on NetBSD and
 OpenBSD
Date: Wed, 24 Jan 2024 11:42:26 +0100
Message-ID: <20240124104231.603418-3-thuth@redhat.com>
In-Reply-To: <20240124104231.603418-1-thuth@redhat.com>
References: <20240124104231.603418-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The test-iov code uses usleep() with small values (<= 30) in some
nested loops with many iterations. This causes a small delay on OSes
like Linux that have a precise sleeping mechanism, but on systems
like NetBSD and OpenBSD, each usleep() call takes multiple microseconds,
which then sum up in a total test time of multiple minutes!

Looking at the code, the usleep() does not really seem to be necessary
here - if not enough data could be send, we should simply always use
select() to wait 'til we can send more. Thus remove the usleep() and
re-arrange the code a little bit to make it more clear what is going
on here.

Suggested-by: "Daniel P. Berrangé" <berrange@redhat.com>
Message-ID: <20240122153347.71654-1-thuth@redhat.com>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-iov.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tests/unit/test-iov.c b/tests/unit/test-iov.c
index 6f7623d310..75bc3be005 100644
--- a/tests/unit/test-iov.c
+++ b/tests/unit/test-iov.c
@@ -197,15 +197,17 @@ static void test_io(void)
                    s = g_test_rand_int_range(0, j - k + 1);
                    r = iov_send(sv[1], iov, niov, k, s);
                    g_assert(memcmp(iov, siov, sizeof(*iov)*niov) == 0);
-                   if (r >= 0) {
-                       k += r;
-                       usleep(g_test_rand_int_range(0, 30));
-                   } else if (errno == EAGAIN) {
-                       select(sv[1]+1, NULL, &fds, NULL, NULL);
-                       continue;
-                   } else {
-                       perror("send");
-                       exit(1);
+                   if (r < 0) {
+                        if (errno == EAGAIN) {
+                            r = 0;
+                        } else {
+                            perror("send");
+                            exit(1);
+                        }
+                   }
+                   k += r;
+                   if (k < j) {
+                        select(sv[1] + 1, NULL, &fds, NULL, NULL);
                    }
                } while(k < j);
            }
-- 
2.43.0


