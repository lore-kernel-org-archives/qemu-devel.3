Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE439E6BF06
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOb-0001xV-8C; Fri, 30 Jan 2026 07:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOa-0001g5-1A
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:40 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOY-0001rB-CK
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775276; x=1770380076; i=lukasstraub2@web.de;
 bh=Rrc0no70hhau4Jt8fTPloXuIX4qo3Se3NfNuNt3mGFM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=QZaiVOC7l/B5QWO5WwpVbrf6+Py6Xoph8/RUuh/mDTJEXFSfokNgalm+Ge5plClE
 SwYTaDU+bELj0tfnRLCy9//TP+A1v9qrpEAlxh7LwHBM/5hfNEYXnKclJntpjmC2i
 WToisfg5i6pbI2YYbajUAQCyNMHN93p0IUch8zujmLCF4tHTB0s9tr7xc7el8VG+R
 4hQjGm+JvSlPFVeWckWEaIVMKMJLON1Pqe3Rumx73HNTR86ZqWi7IR27RsvNG6yTR
 x9SoPc6dhVZ1RIn1JmgOg4L0SLIozeMKk+6U7NJcDAbMKWl/aw8wXADkPhvYqoZjy
 XKdl3S69AycdhuyHKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCHy-1wIfEi2wNU-00kc64; Fri, 30
 Jan 2026 13:14:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:18 +0100
Subject: [PATCH v4 10/16] Call colo_release_ram_cache() after multifd
 threads terminate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-10-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
In-Reply-To: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=ubZcelOaoSvdF5jib/qpqIcKQiRls2j3BfCh/MOdpis=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKCmavHgbeZJIJbd3c1cO4C9FRc3xP5I2OU7g
 1Mt9zyGny+JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpgAKCRA1qwsonF2y
 WJNlEACXtyd034VwnVLFf8y8WBgQnVYtqzlMaRjKVbsk4Khznf3GCE7ZJIaJdUtHjmwSqMVttfr
 VxHNgFIV3F6kTxFaMZtZTg+Y72pn+j83oe2zDZGZ6mWl4uZe8+9X7krcGmqzycX6o59/UI8MeEb
 H33+GHu6JX1PXtYjlPnPP/f5H/y71ocggVnM04+Dq76EwqAMEpb61PUOMHmD7zOTB90cEJjiM8q
 r1jPRlg0qAvodPwEjx4RiJmtt4HJlXJgvQ38h/UA5kAqesJ0zvy6KDPXcuOuAi2uAkONdqTuWZQ
 FWtpko3GGwIQ668gFXh7hzC+y6id/3ONaMAHa7Oml5gIFU2sKknKCslYVIgoV7A4mrRiBa+lszZ
 ykth1wwfdx78es88X36O+AXF7T9HuyG0w292QDRBAk30/N8GpPRKinhoNVowNy01ObohFuYT27j
 Ex+PA4sjsq9LmLGYVT1azgCp/jf3E2zSauqCWSGKs9XNmVbFyBuuh+WhGjIrsKHyNjzfCojMxBE
 JrYfe0t8RlFAk/+Mv8mu1zPQiQ8AjeTXLVdAR4Y0HXJ4goTlpMdvjEDk6OI805hLiwh24kvifHd
 Rv+ziew8VSTUFhLkLtAFlEwIzP0hxpZQcurz6470rwlIdKQukf+FTkNpuVEiqWAmZH6vdsvx9Pu
 UdCEx5UJQMw3Dww==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:9EFdtjGlL/q0QGCxdHQDqPhSVXdTfjEMvLvhuAl8xPBXkkV5JE4
 D10wTsaEjWMKKte1xUgj/vffhl1jLsDX8BI22SOBQi+a64A/OdsGCZMDv+6dpylbwDU4Dul
 nqxS4Xq4h40km+uMCagkOL2P9jhDvCfT2I/25m6cA6AE3Umtr364rYhdOQg1CSvuho1Lo/P
 UMGsv/TOXyXS6NH3wXZiQ==
UI-OutboundReport: notjunk:1;M01:P0:CbxItbPgZ78=;rxKwAzUfSMjOzE7JIdwO7VZnS0q
 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
 5zGGcJsrfr8tmHdwq3re5G3Qf8/QU
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The multifd threads still may access the colo cache, so release it
only after they terminate.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c      | 3 ---
 migration/migration.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 8dfd39b035c48590fcebeb20459f01fb37fb67d1..d3534d1a32ad82f02101ac092e=
bf818a0caee6f2 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -947,7 +947,4 @@ void coroutine_fn colo_incoming_co(void)
     /* Wait checkpoint incoming thread exit before free resource */
     qemu_thread_join(&th);
     bql_lock();
-
-    /* We hold the global BQL, so it is safe here */
-    colo_release_ram_cache();
 }
diff --git a/migration/migration.c b/migration/migration.c
index 5515be1bf305b40ba0b590136df18a53451872c5..9e3f73f27766196ea8673bf9a5=
8c97d5b8b1672f 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -454,6 +454,9 @@ void migration_incoming_state_destroy(void)
      * BQL and retake unconditionally.
      */
     assert(bql_locked());
+    if (migrate_colo()) {
+        colo_release_ram_cache();
+    }
     qemu_loadvm_state_cleanup(mis);
=20
     if (mis->to_src_file) {

=2D-=20
2.39.5


