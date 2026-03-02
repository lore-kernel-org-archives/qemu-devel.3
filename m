Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D67E9B365
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1iw-0000R5-8g; Mon, 02 Mar 2026 06:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1ib-0008UR-I1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:45 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1iZ-0006CD-T6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451941; x=1773056741; i=lukasstraub2@web.de;
 bh=1wB4PGSEbATkgykqfYbhMdJ4xkZ6sROXVEk3Mx6V42s=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ON3UuZD8HelPprVhB7dvtqQ8puoRvqS9ye/A4uvL0cUB0Bb5H3Oq/pszIqbyyzo1
 SHrG0Vk7ejDVxL/WEJYA6LuQ9nD/WcUyQWoCbUrervT/Wzv2HOWnMKFZIMU9CjyEB
 qe6933FpouZbb8T2/iAqqp7bZT5IepcERnULHZqs2be74blEBAfzHlQRMbDau7w38
 OTvR31NvsE+PQe/CzMsnIDXJ8QMsUeeoyLinW82kyD88SvbzV+wD4Q8V3IGTdQeXl
 qLNPPVe13tE5JnLBI8t6tznWMo/rmaTebIlehx2dJTiAmBmpzR7fkkDaN8Rqkc7L9
 Gc5lseVdXFIesciZtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnX1L-1vDlOi35dt-00nXYh; Mon, 02
 Mar 2026 12:45:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 18/21] multifd: Fix hang if send thread errors during sync
Date: Mon,  2 Mar 2026 12:45:33 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-18-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Di3bviqJ1tNSV+njROs9ZVoxf8DQzRNWY6OcVfgFrAU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6Uq3YJDRxEXAx4yod3RvkzBXk6rOgx3O7mo
 Sm82ZTWq2+JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVulAAKCRA1qwsonF2y
 WOCNEACxPunzlFrLKgv2fgaGjDvS/6TR+sKnIWSuVVHtJvWrskEkQsJysyf8t1vA2tK+i4X3eVd
 XuMTCtIAL3yOQGG/KjKFb+/lym0z+g5gdBNVX16RZhlnywYF7rtxCK1y6ZtcmYpL6IRvFw5hvT0
 phSj7QxCUYbe0uQDn7EB03bZViIxilUzaA7xXfTpfttsIgP2HCjqJm63l4zEZ70wZQfy2SABTR3
 maSZKplTHcmXaxJJ9IQKIkqNpTlm42qr7o1wfa2O9JHUqwGHIlljF0lFL+ZzUp/ObgSyyjyAIpm
 W5+glJKOMw899uscUQU7kALP4Tp54aVjv6PfiTXvKxh5Q4OhNE/1HdNSUwAhy43QYieSsIeaM4h
 6HF57pFCNQXRtzjuVg3ol+kJPgT7L/Yy7vk5gVIhQzLrMostVpKhYjELKugRdjwIadUGH4RUJe1
 HZUu2H+Cv3xEJVJjB4LWtht9lX5rGKFbfV4zjlz6kmpNDccCVl/yRJUpOaqwqIj7wbaNS8Xv53W
 8R4BDJUD61bi0TNmsoeIYFxvrcNDCQ5YG3F3VKTE/dmNdZpV2nVhp5Sk6BU5MNftz+9EkLy+INa
 2qRT9eQ7XAeCigUlxtinB50gHKKukbE+8Bhwrc4hlVZozBTJaK7GWqyzngwd5L82cM9nhHOh2oh
 58akAqjhecATcDA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TrYYIUsK+tsckehEzcsidSyNDkrQ3UYPayA8dqaBUNaSOoE35LU
 t6WvMVJlOY1aZEHZNHoXOhNq0Tg0fPZ6iOGfG8hNzLIdlEI75XgpQ3Su0cyqxHlmQn62KJN
 qeoo99gbXGm2bHhEbgmrzTRt/SO0kxys50CsTqMVzQeYf3Z2164WPoSI72TGghmcAmz5+ve
 Hzy8PIINSrw2gt1EYcl8A==
UI-OutboundReport: notjunk:1;M01:P0:Fzy8jB0T4qU=;njgzmWq7wbGkEQJ20vCDRz5ZViD
 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
 SUrud0H2dZlQ9fUYCTeJbvTrr6ytN
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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


