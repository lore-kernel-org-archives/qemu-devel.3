Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624C3EB26E2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWV-0000ne-Sc; Tue, 10 Feb 2026 11:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWR-0000hL-Ib
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:31 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWO-0006x0-Ql
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740604; x=1771345404; i=lukasstraub2@web.de;
 bh=8Sh4jCsixGU/ngEDSP7iq4j7Ehuo5ihlh5H1iguY9wY=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=pAOEbS+MDX6x4f5sD5f3yfdBmRkcgIkt5+6AliHfed0SUaq8IvhwpGXNalftPWIy
 dWQ+l4ca4jqZkIoca8q2yU/BD6rMN5NnaIFOGTcWAYGJbx4SLK4E4gkxUCctLLRF9
 S+h4rg/tz3onNkpw5Ibx/a+jXdZjelxfU0/zHjGImIpG9EDuvfmlVLlfib1MyIDuf
 3hoVJMp2/zePHREomRT9uXnMmf4GKc84MsBcqJ2l0ESgk6ccKlzSRh7m8+6n17GTJ
 Ib+wYOpRiz0683Tmes7O1isPGzGo5JuMpdA/gWB01azIomfzYuooGJa+AaFGUldnh
 kXB+KAG4ObUGBHmqhQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30ZN-1vflmD0OR3-013QSw; Tue, 10
 Feb 2026 17:23:24 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:07 +0100
Subject: [PATCH v8 09/17] Call colo_release_ram_cache() after multifd
 threads terminate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-9-7f9e5f7d082b@web.de>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=CrmZ30ApIHhMHmX1e6HZ1CefluvR59mmAs0+FI/64Pg=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t3idwnSj8UUUe71/7mcY8caWHXopw+6+2BT
 UxKfdtMbc+JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbdwAKCRA1qwsonF2y
 WKYOEAC0c+Exrw6HEZw/2FCNqJTnqZoVcvh7oB+5Trkdz02+PzHDk1jJk9FQB3ldk9qlWHZ2374
 iNHov0DEKgTu7P2/WPrdD+JTH6Tfprnk5fwW6cVaNUkvsRzi9xkuFpNOTcY2fPHYPgIXdNClGPH
 /GQfZVrfQJzK0dDwOCM6GD9cNI395HGlMsItSV6VVKY5M+gWMTmal4HHN/CefN22vCvP3BITpLo
 eNAUsu8mqksMQQ+fOxcuGXHL481LUEJbcKumNM1ufMAgg8jEXoWnVy0RvviRKas63MeeE8xOXv5
 d42fRm4rf/MbKswbe+oPnQaZpNj0WpVxIx6wIzknAQz+5WzLpjR6GRvxdT7dqRsGDRn+FRQDKRY
 haBxm5e8rTQFE/e9VI/+Gk/rOSPDpLGZsnJ+Umg/SKEgoAXjjOx1Vx/K4pUqAqNCseTLEmGSM9C
 Oj5b3PdhNn42pHq1cbm5B00awYZS1o4jK62F75vpSrwr8sP/9QUQGJsznHn0ANB/x7zq5bkljmB
 ZWe7JOAGXhAb/KDbPcfm9NT/J6WU5BzZDzACpOo4JuVfhuOHMdSaHjS1BDe5h+B/oQCRNBZmf8t
 Y6ou52Fzs71DxRBCTHgnjeDZlwkluNry/Tgg0KtMz3ujMJTftXZjAN0G+1FEcXZWJvtFDaSpgc4
 dl6WtJ+76EaEMfg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:sg56Cb/qMNzu+zFrloFUuEzYUxXzPf7ppYCfw+tZ8AoiwkCGPFU
 vnLTJgAq/Hd/n8mGWzjhbK6InQKF6fN9ZEaujGbd0EeppU2drdsrt9vLW1R8S21+N1t7EJo
 EejIEGdQ9TjWTZpstU5NTm3i+7AeBuWeypy4HfwpAEI9qgEgEbHYRVAdd3jGcvoc61kjh1f
 kqpTJxPXAqVZWwrlYEG+g==
UI-OutboundReport: notjunk:1;M01:P0:2cyo8AYfCRI=;slx6fFF4clZiQh6qeOwVW5zW945
 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
 40qsl1FSQH5wgzx8v8wRbtPdUkbF2
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


