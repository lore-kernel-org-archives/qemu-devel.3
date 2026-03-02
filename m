Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7ACEE9B358
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Q3-0000g6-6U; Mon, 02 Mar 2026 05:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0O9-0006lw-BO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:35 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0O3-0007QB-TP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446813; x=1773051613; i=lukasstraub2@web.de;
 bh=8hHLJHabzCk4FfrjTAJvzzHBO1OUkODVuFNUMhqME4c=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=KGmSP3FD8AsEdaB+tBBZGNkWO44vBA3YP5sZingfMSJ7vjzmGUde6ebrXf4oC83q
 jyK7YYuNRftScQIb99BEF3Jo1qDuQEsdbtOxAplpWGrD23at+X5oTjhiEV7pAHLYS
 1Z20Ponl2Gcj1mMa/bhmgoqqKWyxoMkL4xRGuUhDe6OSz5Z1Je6jKpGm7ZAjQAN8O
 Yb9oloaPGMfm1pb3GnFakQuQ0YyOg5zpP2mDBSnYACU5+eRUIORngwMjdFbj7T+xQ
 t9tg5poVrbRDZ7lmr/nYBAd8XxjfL4d8qjGUcFR067BMWxXn6ISnmu4vxlVS36NRz
 cFhwbsu0pmrgBlNPrw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9qcr-1w02mW3E3x-00DKOn; Mon, 02
 Mar 2026 11:20:13 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 09/21] Call colo_release_ram_cache() after multifd threads
 terminate
Date: Mon,  2 Mar 2026 11:19:51 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-9-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=742UeEMYZJ7tKnjG0Stx7vUAA1BGNxPixG9gIstyBU0=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQotyeGGzr2AK+B5Ahs4+9Excu8iuTWm5I4+
 12n2EMdCYiJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKAAKCRA1qwsonF2y
 WECoD/9Iq9jaim9nxarS7ZHiGQyKzYzP8Hgw5xdRFBL81In3f4EYuk8q3g2KC3Cwpa+AO9j3Z4n
 68N8c71SEnCz7vorg9BE6Iya7tGYMFxqCcfJtpMZDEucaj377DjLH+XOFEi0hpipbwp7pKEw74r
 kWxneyNJiXsMqDwNl7X6CmW7BLmEOr3aUSGEXlEuEoQPlo18hUYZOxU4SX3YV3UfKlgPMR5npqv
 l1Gqfb2YArojWnP8jgx0pYT3YEYXG/6oo2ZJr8GsmiKCAVBXxyaBhKOvu1jeKa3rvLyQhTJCRY7
 wMZleYv1ASYrZUIQ+vAEPrX9nZI2dYhZj/Hk//P5M2qQPeEBEj6cDkB9hXJnbT1Szrio9p96zN3
 cXMrTinQid0hVmLcHYg3j09p5zNjW41YzeAyOXZcnKtEbMDNWJTRDM3Jo2CcjeDkPDZBogQbHwv
 aXgr4vO3rHRpZvsLkyUyHRQ3zmoDBp5U1518x2oq60h41NDMnOPPtk1JA8/scC6iYM0HQMm+HhA
 yRdKeiKEOYH98KDkNcWSNLWyskFEuuEQdsH1jMgFoWOBFsuuML6O3PLgc9wIrIrtS2gR8RY9Frc
 04toKS2/f0GYNlfoO+QhPJBiTiMl8eHVkXZ1ipwD5jsDfB0BjOJoYsCqdCipptqWTTXyieNGJZV
 /qCRuEoxcqwpCtQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nI0HW3Dlj2nx+KJ2oVcNzhpFYO2gzI5OLZaK54YUhvFJZ7XG2tK
 zDXh0npvGgDZmDiMxi3+eq7Zig7YQszClOZBxlWVxwx7TZbU9dw2HY6OG0cAYIiA9cRSf45
 mmgYCi8dBGIbqgkwKgRo1n4/7B38twBO8hVSE3cxnAxmBS11DoNNjDRJt/h8zEBwdZgyEvj
 E85M57w9CGs8N1/cUlw0A==
UI-OutboundReport: notjunk:1;M01:P0:II+5Or3F6Yw=;azP315at9SD5gSR98m1E3UVgkMn
 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
 y1uZ5e/E727wxFGArboLc5I6iqp2G
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

The multifd threads still may access the colo cache, so release it
only after they terminate.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c      | 3 ---
 migration/migration.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 97a224c39c49ff2269f375db47112458cab0b4cb..96102c9d0fb3b60e063c81ce07=
b730011bc4919f 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -949,7 +949,4 @@ void coroutine_fn colo_incoming_co(void)
     /* Wait checkpoint incoming thread exit before free resource */
     qemu_thread_join(&th);
     bql_lock();
-
-    /* We hold the global BQL, so it is safe here */
-    colo_release_ram_cache();
 }
diff --git a/migration/migration.c b/migration/migration.c
index dba5d6ede579da42693d5270ede9660fb145238a..f36d42ef657bdf26d78ca642d7=
7a9b76e1c0c174 100644
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


