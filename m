Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D14C5AD68
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXp-0000WH-9Q; Fri, 20 Feb 2026 14:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXd-0000Sk-30
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:57 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXb-0001QJ-3P
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617112; x=1772221912; i=lukasstraub2@web.de;
 bh=Cgrs5fJ3wLcY8dy2SlqIUK33R4liCUKYjQM41dJk8cc=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=JqZ//tyeedwZL+y84oUnlhu/qf8Pa8Wq1pWGRwnV2rAAT9e6hu9FRJ1L9iSu2GDS
 HzpihSzSHjb3clRTi11HMQPodC8MxcxjIpVxqvdsDBgXdjcGdxBm+ZgTBLMlEqHsB
 arEp6PLkxsw+L9G0p0NmzGSKz1RtE9azolNf5ERI5xHIHxZ6Ef6rWV9SruGzc+Af8
 IHd9y8Ng+gDbY9Li0emvKG5zhVclyD0RfvN5TI542L25qIInTpCrHS66Qc3d6NHnH
 4Iqh43/gWiZaP9NRKHaQPpA86d+Bp+FQ9gGYBFfiolvtkvdIsoCKBD4xgTt8nasGT
 gkwPEAEQisPjha311g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N14pS-1vixe61dUI-010zII; Fri, 20
 Feb 2026 20:51:52 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:40 +0100
Subject: [PATCH v10 18/19] multifd: Fix hang if send thread errors during sync
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-18-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Z+G5VSUmy777CSFznMpcXnI45p5UxHNR6BTVe96EOVQ=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtPch3r0v0hPoaT1Y9riyzYUWEWy6wCP1o1N
 wsvI+rXJ2yJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TwAKCRA1qwsonF2y
 WG1fEAC5CCRByMKqB3L+Z2RXe/qXblNCkBYMPO+mNay8SAPoEo9PJRJQJRQq3/tUQEooLEHNrXS
 gNvqn/t1Wz0WjO5gSbTbD65gP+iRmf0Fos7EadZjJ12qnX7NrHaF1XmlCqEGfStKRKXDocWBJ3w
 scybLQwhd7fzqr/6eqpuRbghR7/RVyTcXZjSkDbrtcEkbZPggyyTgEasK07s5kOtD+36nyFqRNR
 HTlv1h4Y9w/BNHuRiIVrBCpz3NRExrIc2pezsX2/NvkQoWl+U71FxLmhzGscn+k5n1cZ8fFFjBi
 UHKY7RPBBq2dxwHKjUjzpJvusHZBt2KnvTPwuJg2qOwAMQiqWSlwwdkbntnr5mde4e0ED6zIKlx
 NGP9eMfPXNWkStN2Iv/syCUkhP91gNiufiyMYYYClJQGmjvZg6aaBQWIq4wrWBNIm4g6yIJyR/v
 W5vhZnLyakELkoVSn3x1KLEKJ9h/+0HiBFNnAQww63tcIYlTGKlwxch64BQ/gKJ4HKz4tKgNTm0
 A/sHe74PJ1oQUKhzfgTNbxFXKhRD5eZaHtxd7UFPQICojZuw0W+ELKZM7dG2VRN4ycaL6XNqsKR
 KzBQyQLEsjAFN89jLg13J148zjvy8AZmuB5s6fbYWpiVL+Xg/xcXDmt2FmDGC1vJui0MC8p/I5k
 bizdsNamWykNeMQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:TgwuXZiMyFYVIdaPNuIBQycOiR6aizy0cVRfrxqtpueIn3x7mQC
 LmtYH7ZxvjVgQ3BUxLbuXMmThhc+5rl96xCmadtVVF77lRlnP5PhEXvmhwbYjSGnr/K0NdP
 nQFwdduEqd5tNuEbfxJrvYGCXl3yXK027wbLd6ktCf8Sy/U4+pOJkg73mHfnxi1xyFJky02
 JOp7qLNfngEwXXAJNLg8w==
UI-OutboundReport: notjunk:1;M01:P0:BvI/WPJ963U=;ErArORZsednq0Yn5yMdc5fpTH8s
 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
 oVd6DKYu3r1ly0+S/YSzuG5SXI2N3
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


