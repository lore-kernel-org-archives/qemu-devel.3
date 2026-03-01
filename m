Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580CDFD007C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoU4-00047J-7l; Sun, 01 Mar 2026 16:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU2-00046M-38
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:50 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU0-000429-II
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401067; x=1773005867; i=lukasstraub2@web.de;
 bh=1wB4PGSEbATkgykqfYbhMdJ4xkZ6sROXVEk3Mx6V42s=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=JXaMjIDqPiqSHfGSQpcnbuvP8kE0R0+dsghDFzFZEap2WTn/1TrdE6hon3mtmOYE
 FcqF+hioKcBQsj5VgE9t1PxSQExbRmGrl/ca19675z3HU9saj0LKIwCx1e/u2L+Hv
 k61QtpCiW1xcEAMsevFI1zRKkN2Mx+vvWngEe7P4aNshEk24I9dAUWtSA3aUH0Vxq
 EUcuQL18uNPs74ZViB95XKXGLFwv3TgEuVCUvVR0HmBMPNv2rl4VBypm4Og7k+Px8
 reLdqQzDkz60lMx2JR8OozFGU28pZoApcMbiw1Wi73a72lFR09hRHDEM/U6KnabDU
 OF98/2Qyb8ecWlp3gQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq184-1vJZub0KME-00it1G; Sun, 01
 Mar 2026 22:37:47 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:38 +0100
Subject: [PATCH v11 18/21] multifd: Fix hang if send thread errors during sync
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-18-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Di3bviqJ1tNSV+njROs9ZVoxf8DQzRNWY6OcVfgFrAU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGiGTK5N6lOwe8Tqza9rZhG4fQqrkoMcPQnC
 LThTvs/LX+JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxogAKCRA1qwsonF2y
 WC81D/wLPF624GlzdUbENXB7ze6Imxp8uacz0F5vDSPRv52XnEoayQ4kYG77QEW93KmmudCCf5H
 fX1kcsJeVw9/qr99QsaX17v/QsIShjnyU5DDHgziTSn6zNRoubnW8kntCUtK1S/ChsuejV/WRJZ
 Pl0eGDmspHg6qSLkqYn0NIhzYV8whYkj+yzvn+WbC2JEq2Zpn1eEHL+9LSepi2dhZg4FfCvBSjJ
 BsYC5nmEI++bCaL/VkgFJO4TPY+/Lhw6+jScCIgYgrgzhVw4jwUoKtEXVZbgPgut1lFl/AiZ5WR
 tLlFru8gsqYB8zjiLdq1CVOM11CtxJZZd+4kAn0Om5Zwl3upu/m50FxHXr5FBN5ORAupsavfaja
 azmyS0JloY2qtCrxS3EK53Es9tmeiGVBdPIn4Tcwda0QlJgxssmYMHhuhf8y2vujpEKtN0ZQJ/u
 8YAK3VtnvCsyLY+N7QMX8NnO8Ehox4NGBcb5b7dCDosDrRf8oO1dU0h1gUvLuHWXZpQ8g8kPOsK
 HuI23Rx+MRiKS0dUr/mhJaNzX1reoHGQnti32hhHX3Cm15ToAvAXtQ9jj2Gslj5fMf0hpM+N96+
 8qPhCgtFgyNXIrMWSXVbnaSlgKUFTlHVP4bJ8oJq55qCYwOg5VpoTRzaiWENo3TfGZU8oxJD+H6
 a9LWHJTg9tVwJjw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:FrPtJVfVU7wYBZBVBvfB94vXzbDKs+fBJMfcvk7ymi6kLSVQAv1
 lZpfOWGba8W4TRLfvosJSlmKfU0JKxvlckwfp46C4anNeqKlhSqQM0o7cdvx67+LlSNbE7j
 4ZpBtpCBwgNoFa38cBYUUd8g/4gGeto7N6WeFMaUaDbOSqostrCCuVgmE9XA88qrBCJibFr
 wMPcQETQj6aTfbyueuVSw==
UI-OutboundReport: notjunk:1;M01:P0:orrftsEAeZg=;Zj+3GlpHW5FFNKNr+rD4Wu4Llew
 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
 S/u0M7D+VO00zw0W3aSOwSRVAgKUZ
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


