Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372EAE9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7d-0007Gb-1g; Wed, 18 Feb 2026 16:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7M-00079Y-VS
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:59 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7K-0007OV-UX
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450183; x=1772054983; i=lukasstraub2@web.de;
 bh=Nc4MoQ5UkwuBg7fNoiu5u0pRXBu41aadsmkuWZWusLA=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=aHRs/uIZzunXkvzrtGZVc8ZJCtQzPGSxVSwyjoEAeNLJsJO07LJYBfQPOMMPLN7J
 D2WBMRhOwgdWeoMJR+UEZOHtF4+mn1ADOvceiVj6/hDJxC3wD5UbGzB3noj97R/Ir
 dqvi3it7aspW9GEd7nTLtdGgsQdzr7qpIfMapm0sCeIT/YvNhud3j7lyE3VMwjgA+
 fG84AcC4h6kjVNUUgdkO8OKatwY5gu6OwjUsI+WUfaIExCrTuxXlxZVrdlbQxt5re
 PqOuCpLlT9H6zff5aDyFe8Mypr95zd9+xKga1KOs14sNci2/woYuksAC3I6Ubq5Sy
 O5ek8PTdnWwd0llRrQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mm9VU-1vSWr03YPY-00mDQh; Wed, 18
 Feb 2026 22:29:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:38 +0100
Subject: [PATCH v9 18/19] multifd: Fix hang if send thread errors during sync
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-18-d8dbdb0ca6f6@web.de>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
In-Reply-To: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=IdmQMOTONed9jm8GP2TtOdP0FdN8xT93mBHs8Lu2bWM=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli892WFthe59sWNeZ64fy1MBXuxF1HnSROy6Q
 Iffgjiti8yJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPQAKCRA1qwsonF2y
 WOOXEACUJ8t2dJE2wRIlismGOzmc03YAWnlpjFMKTc2NZNX4l5nuGnMcPaaHkEt5Kwa2UfegTN9
 LtCN3DUD3jnjRrNtDL8UpTqfXt5ELANq7OyeSkpXO88OTw++wrzz+9pq7nX+1tVYiFSuAQbivda
 ty3rvnIrnIhbxkwgOvcTBuYOHM6IMe81MpRn7TCNU9XGI7zq8BcFCuFPQyWtZ0If82Xz6EC468d
 Xj6gSaFogcgBizsBr/vmC6qCyZub/Pnnntn1NqgXnHgoPmwHdCgER6ehOYRtu9Fcu9/K6mTa2oi
 tohnsswJf1W+eYb/27YuL2TZm5vixEJEYNC7R9bHQjWnD0Iq7u6oVYa2m/STUM1SjgdxRy/pq6s
 2BLe4E0wZwjXRzjOOKUOzNMOtG2rqmDe4GXT+0WC3naJZkgVSU7vQjns/Cl7mlBpNzTga8KqH8Y
 6udqSAAzF+HAtOio6IXkVV/BfGnzV0eBNtYT5fO6I6n0Qwpfo7UvPqX5pO0wm2lN9wHMihObwCy
 yRpLgR1XdnPNS6sETmJYfVUnceaXskDHSxkWVy9knO8Y/lg+osHQet+p01+VnieT3xewzd1I54T
 KmCaSCO9BrIXXrSJzxmdAbnS1i9ZgErqK4iJX7mJbM4Cwy1vf4ltPCLiqiZpZA+JBInFjvZItFE
 WrgOk1o9LZCAWBg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:ZPoGPHE5o/w8Hptnn8YCvWObRyHX08sd9tp6r74H6LIlxFhi+Z1
 VYhka9wcXLsRJBLyIN5EeFGtYaDQik3xccwqgKjZJ8VFpG2R8QmA5KqoXsxFOExpqCLi5oS
 2AB6C459G5SuR3t9BSTOivgtn2l8HCFN8SP9fUXH8ySjrWVavxlrKUye9P74uRRQgKOicMM
 l7g5p3Y9GG8Z55Tc4RITQ==
UI-OutboundReport: notjunk:1;M01:P0:JaDs8Q5T4Ls=;1zT8S8KL4WpFSNpXEWD5XCkB578
 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
 xGvHYgt8=
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 migration/multifd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index 220ed8564960fdabc58e4baa069dd252c8ad293c..e8c85cb6c48deaee2c9bda7b82=
1a976166d78c9c 100644
=2D-- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -677,6 +677,7 @@ static void *multifd_send_thread(void *opaque)
         qemu_sem_wait(&p->sem);
=20
         if (multifd_send_should_exit()) {
+            multifd_send_kick_main(p);
             break;
         }
=20

=2D-=20
2.39.5


