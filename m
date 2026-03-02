Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3C3E9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0P9-0007VS-A6; Mon, 02 Mar 2026 05:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0O0-0006an-JX
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:24 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nx-0007Kf-PP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446817; x=1773051617; i=lukasstraub2@web.de;
 bh=1wB4PGSEbATkgykqfYbhMdJ4xkZ6sROXVEk3Mx6V42s=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=lZpZzLR4rULbSd+G9ryBuTi+S5QbkSHFwZnQ4TM1PqIJIW6b/k1weojmZhRDgkqC
 /VvU8kksPaWlfV/DNuWS3YBvWU/ZZZD8/5qXE/xrko1EStHVzmG3ExBB7QmzIiKxM
 q63Sda6NH1v/UbyQe3YMY/BxvCXziGweg1kRT7AYGm+uDqRDd4RsuC/AKVMEAKXTv
 bmD2bnwvMuy0TJD2h/8WKLZ4kclEUnqb3D/tKAI82SoYHIaJHe/egfPQcH0mbuPTQ
 i9+MR4ndxwR7Q+EZN5/SL9zNUtGbAV4qdqwfnlxdzXIBmHagnKTKwbtmYRPXUf346
 dPgIdU1s7Z8SrOb1WQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFs1z-1vtyFL40QJ-004JNg; Mon, 02
 Mar 2026 11:20:17 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 18/21] multifd: Fix hang if send thread errors during sync
Date: Mon,  2 Mar 2026 11:20:00 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-18-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Di3bviqJ1tNSV+njROs9ZVoxf8DQzRNWY6OcVfgFrAU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQpeRKSnG7Ive204agvlNsh9jCxxjmaV9vF4
 C0NekOIay2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKQAKCRA1qwsonF2y
 WBVRD/0f4cGiqGpo4NZKYmQ0BqSMVXhC0yK1JwFIi1dmhDqQ+MKl7BbBcriaWac+MnAVzKx0ApU
 H5sb2fbPDv33oftYdpFv8TiEJ68Yy15fUD+pJA+vmAto7kYx9lXgcEq7E/aDkRLOlr4p/ZLI5xP
 /u9zi17QuUu82kChx2HeWDssxhnwk4Tg+aHC9fG/dVxYe4wJamgVWywKtoHunFSb0JIb5NeceAy
 V5Ftk+DVmotdNLcnMBkoj0g8ohc8hpHHPlF6e0xJe4qKZMFXKZaglhAynqCyeauh4MGvExzLeXd
 jxjCYTGZ/zGg85XMgAdBk70esPSZPESUGPo7OcS/gVYB/b3o5HyYF1ps8Lydao5NQB1r4Oh9Oiq
 q65WdbbRpKCzinLQGX8GZwrI5E/kAD/ZiUUr/aIDuK7x2Zht7CgoiNS16cdS+ZK87WN/g3Foplp
 PGOCS8BW/LXEwxC7Qd0A5OGM30al0e3IyqGzcNZx1zw5LqBzm5rJT4nHZR3D4Bu2yInQ5swKu4r
 9Uyblgv+HmOQvq1AP6DE4QFuhQWdHeQS3/d6T1THddRawsMoa4tx3bsTLSZ0rDmmpGzDpaTyQ6y
 /pp4ABsYU5vg4yKHhRC1JMTu/PJn1DQf87/9PUCQW5cckmZM3xDapT6u23auHrkQKPIMatepLCr
 h/uLlE9SFGjtXuA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q+kN8eH7NJma6wIDuXictysvidOnRO/owZb1oHaxbD+N1aBkw4u
 vzABZ2tcY3kkO4HVvqutqmnygUdL3CTidShnmIN31B2rOYnNMMw3pfykwIGzj4TNMX9WEGD
 Mgo79wVBpaPQzw0gD5UzlFvd2dGuYiYjHIVAOPPGpzHgsMgrbL8/BKh4zqv85s2iE/9U/Pe
 PuY2OardQvWJkOX0XoRZw==
UI-OutboundReport: notjunk:1;M01:P0:zB5hIsDZ5WU=;Kp17etkD4zaaiVG8tiQ9jnWmRt6
 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
 veZXZwXXg20PPuZYAAUdOeGjdgMrR
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When a send thread encounters an error (as is the case with yank),
it sets multifd_send_state->exiting and the other threads exit too.
This races with multifd_send_sync_main() which now hangs at
qemu_sem_wait(&p->sem_sync) in multifd_send_sync_main() line 647
as it waits for threads that have exited.

Fix this by kicking the semaphores when exiting the send threads.

I encountered this hang when stress testing the colo unit test,
though I was unable to write a migration test to reliably hit this.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/multifd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 220ed8564960fdabc58e4baa069dd252c8ad293c..7762aab8e0702672d3730f27e9=
c9ee3b86500f0c 100644
=2D-- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -772,9 +772,14 @@ out:
         assert(local_err);
         trace_multifd_send_error(p->id);
         multifd_send_error_propagate(local_err);
-        multifd_send_kick_main(p);
     }
=20
+    /*
+     * Always kick the main thread: The main thread might wait on this th=
read
+     * while another thread encounters an error and signals this thread t=
o exit.
+     */
+    multifd_send_kick_main(p);
+
     rcu_unregister_thread();
     trace_multifd_send_thread_end(p->id, p->packets_sent);
=20

=2D-=20
2.39.5


