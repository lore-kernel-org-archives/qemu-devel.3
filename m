Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90BBE9B358
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hs-0004z2-4s; Mon, 02 Mar 2026 05:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HX-0004to-T0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:45 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-00062y-GQ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446416; x=1773051216; i=lukasstraub2@web.de;
 bh=1wB4PGSEbATkgykqfYbhMdJ4xkZ6sROXVEk3Mx6V42s=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gKhZfk7DtKQBkj05pqrbXWkS1UI4opBEZdTkOg6O/85icVaSQJmVV6iHu3tRwGGZ
 0dB4S8/Iohib40A+gV2CDk28pGbs/Hd1XTS6SJzNtZKSMAR4RaAwXa0sKI0eH0iKn
 gNku3xC+r4FBHDyJpz9FDtIzHn3799MxRhrovav7zzDA3esQwAiV4vTnHOg+SSX7M
 tY4XbOwAPOCk5dEXFfbWozqnjo+VDxCg0MVMPmxyf2Lt3tf/lvwTOv8tc7B7gB85x
 XN2h8zqMwYBASi7EpcNLLI/rz/FQT7TPeCT3UC0U+nPwL//5U3Z9RVgHvxaVACNwR
 5R5/zq+AR0g27k+01g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8TBS-1w1Q7k16X2-000RQf for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 18/21] multifd: Fix hang if send thread errors during sync
Date: Mon,  2 Mar 2026 11:13:29 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-18-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Di3bviqJ1tNSV+njROs9ZVoxf8DQzRNWY6OcVfgFrAU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAGi1hGwatsrGuBy0YwyDNruxTOlQvkBUmwQ
 JRYcsmBG02JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBgAKCRA1qwsonF2y
 WOO+D/wOqIIU/ynznatn4PkGQCCVozOoGUxlMisC91FbOnXFJuV3kh043pRohXNEP6rM+WhUtfP
 gfHoYZEdled1p7bou2ZbI69zpbCznkUdri7oU4NYWkaUAlPtMDDuNd39aZjfekV/G5nTYInnM2X
 actWRAEXahzxIgJ0p5Ps0GQZLxzGMrsudVCcEILJm72io6ZVhweceFVuTs2U6B5IQuLK7xlx88a
 5ALCGsFrK03kSRjzZTbB3j0S5GZY3AEtxTOkWD8/NocLJlENsjARkLEOjWB7ZO1jZ3q1Q2M7Q84
 eskBOnMY32ZYeJvoJ8RmTmKA97+cYXozSTkri6XOYAs9yZ/zr+sqjFIgMlHNP9rmOxKgb6ifcNX
 ryKHxjKYoKAsv5g/qGPriPHs0ncU3JmZtZH7qTQ2c1XAQb8H1EgafQUqrHoKV+Ip3MmnhXSbLlm
 MguQTYC1/FYpcw3NVBodLsJ3w7Muia2TqwWmCSn1GFIcQn+3E8FdhXM2dlFFyJbqy+hdtTbzyLG
 DhR/UiR8bYpxgXyjDw7aH7KRQ+3rL3mj8gu9QE0XZtcAswNBNbC89yV8S6rijAP5dmXAy8aHqh+
 ntc7zyh8Yg+th/rGmil4AruFcTPMYaI7Td4UqC8+7DbGC3K/QMdnxdP9iu+3KIng0/mSv4TxAmb
 Tbdpwp0isuQnutQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ook3dI5vSLz9pNKS8IlJXa0JRaMmiSMAKhQG403BkvPwZkGWAAp
 Ixynsy/uJEDljOSqk2GXcRt35fpXrBLlr2wPLnRySVx8iVQhW1JaI39m7pFhBIuaj/e/iKW
 LaAIFw39Bx7bGFxoZvxa5cVF0AN1Larc5qYDVh6vf0oPefLSmyHorTqLH+1hxlS8Cd0NM6h
 Ud3dFNq4/7PbrTrw16knQ==
UI-OutboundReport: notjunk:1;M01:P0:QnE7M5laaAE=;78B9XzzAT3uwEpIzpAMv3/xvY67
 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
 SpndOReE1r+fWJM8M=
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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


