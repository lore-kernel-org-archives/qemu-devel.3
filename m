Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E229C5AD68
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWY6-0000bg-Aj; Fri, 20 Feb 2026 14:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXj-0000VG-Rs
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:04 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXi-0001TY-8T
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617109; x=1772221909; i=lukasstraub2@web.de;
 bh=8hHLJHabzCk4FfrjTAJvzzHBO1OUkODVuFNUMhqME4c=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jYdpUOnEvMQo+tw5zSKdXJuUBSIvi2ETMe8IYk6tfndsR+z1qVKYYCo1OjbHD1P8
 D4jJd8SkR0OeJ9sDxQrgHQZk1mRVud6OghD60jg3eDUQoDEm8q+2Yxuy4OrbtDhl/
 DVzbif8bi8Br45Dwa93jrT6tp2awaH2hekoM8iPUb+eBap4BHpiZ81GH3S9FLu+ST
 lf95IQQyYAwuDNnn1qgtDWR4PObk8dCKbkEfxw4THh716I9EHfakT3GKEngFdlVog
 cEugGrhQFGc9i7Go45f2MJb66qE57xmaw/kH0M9AE/pifWhVxeOHMSYCZxTDKLVhd
 RYR0p6AOSyqn9siM7g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkVsg-1vSOjb2bPS-00iMTu; Fri, 20
 Feb 2026 20:51:49 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:31 +0100
Subject: [PATCH v10 09/19] Call colo_release_ram_cache() after multifd
 threads terminate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-9-bfe67d422ef1@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=742UeEMYZJ7tKnjG0Stx7vUAA1BGNxPixG9gIstyBU0=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtOkMXaWxRLe1zY3hsGVM733tWUeFguL2e9P
 XtC9BdqUUGJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TgAKCRA1qwsonF2y
 WLWGD/9c6Prpcsr/SdMumrg9zaCKRafQzASbpXa4FohN53z3VCgI7uKS1uxurAIZSFM9Lz+36O9
 ItHljEsHgj3XdqL0JWLOLM76oWuR4+bIGFOTtyTstfSfqefSK6YRX2Dvd9MQ5t9MLo+cnDmruFJ
 kH3l1qiy9sOZoKEhjZcnA7hzdiIQ6vAjifhIEfiNLyodBR4A84vrYzTUPMpXrkFUneEf8Zju1py
 r9x6CZ0Fjm5HP6GohFhJczJvSrDrzyRFWu7XOf+1njsQ3DxOWHYyF1lXan1nZHnUg9IrVBp0uDL
 saYc/TpHpMqdzYIjT4xkGsaMuZVHTncs2jEiap534H+1dbXi+HQfdIN5V3kfHLYr/H5CvT/hieD
 1yywxLdPEdn34wYKrDYJYhwr67fNOtQJiPBCSAEack/KaIyGU9EdK5VtQPN65iOq1R+w+OAIdJP
 4BBQPWnSJamDC1PhQiq1h0MIxjL3oPgqGJnpk+L6yQfS7YyPgNhDRLHwqDW3JhGrkuOKGPeN+rt
 8MUhCz5V5mg9FESjYC0uj+MXupi67qucUEGks+AZpfPbxtat+KXSUljEicjuVUs8LbxQOkZg4it
 zQKUc+W2lVQP/+ANKNZ6CNutNyhx/35Cvmf/Kr7uanBnrl5Fj8NTvBPicyONsFrXC5kbhpX+5gF
 /XHOI18XQqhSwYA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:orGjv+EN+D1T+EUEKFK3uv64QsQhUjQs4crVllcgW0EoLBi1bQb
 XC/STkcyuTy5xNtcm4yERr/+CAbFyhmjJdRLakWC5iqzgQdFbyFUNpSSqztDjdOQACzw3wI
 8ZDB5HFbciEkD0xbrul/Wl6ACAzpvYUxgEHF3aVrA2RP4Y8PVTVj12GLyTZjKywUBdPd2+F
 mcy3f0+9oKxCnCTx0voBQ==
UI-OutboundReport: notjunk:1;M01:P0:m/XUGeFsWyw=;r1btxZmh5Iy1vDDD51QBMTYNSq8
 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
 0R0yoV/bZOAQt/nIPGropfQfE8C+E
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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


