Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51504EA8121
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohk-0005E6-Je; Tue, 10 Feb 2026 09:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohR-00055p-Sz
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:47 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohQ-0005jC-2j
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733601; x=1771338401; i=lukasstraub2@web.de;
 bh=vDwo5voZ5MxEwVTCWV2ZsNB7oCoNMDxztsKzH90Jjok=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=JZYmg2vkuvNYPoQoY70raCHiVf0NI+5EtQ8yXR6lroc6cfTEuUWidNBJUZG01Rrh
 asAqxEQ8ENh6gvFfyEpFcvz3aQFZIpmFHh1/KtL03LcFmRjAHuXhDAeocxJ0ShdvI
 oCfFSFvOgJ7CEd8mol+wldc5rmuzkMYsih8QQxAJOf3CrQn0dwy+qdqEqidLwNEes
 QhihlBae2YXnlMCe9Psj4EOUOrTKtVJ3tnuTHYBbxzAKdRvQOINOQn5YQwD0DWBSr
 qigp0U+pUzYzjEXdVFbIQrD/sMPyy1hxtloQ7rTQ/RBMcI9OwVmmE9CFsH+Qz++a8
 Vjc1IIj9bhYJczBYqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkVsg-1vNxKJ33ug-00ZqSG; Tue, 10
 Feb 2026 15:26:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:24 +0100
Subject: [PATCH v7 12/18] colo: Hold the BQL while sending ram state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-12-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=qckNqe049aOGUPLcO7lqIGw+0pvXh7cNkXCCgK3qxO4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0AcQ6/HH+UQ6rGsRVlI1ShhxyxotvkZkzSZQ
 cQfD204AWuJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAHAAKCRA1qwsonF2y
 WGBkEACNLadr85E1wH5uWEt3ICUhgGACE1NQ4Fyk0V/LPzgeZvoLpsMHuxTStrKhDue3zL5gvUx
 oRfUs8HcRi40ZHUVxJvbHKq5/9M9hqvgelieV58JAqr+Tj8JYlo/5i+xl0t/YDrYiSBnhnk1DeF
 37M1Ld/t4C6GfrQlzbyp3UNyUxncxWkKl3ES+aNv+PZ+0gnXFG9Zj4m3sW0iweTZAYdeLBamtgS
 oUY4qarur0DK5hIq/PXIvfc6Pb51TCuyXZV4acxXIiauV1IOx5/xnrguRDuCqwm965PjndpSaXq
 woO+l8aTxQW1l1ORQJQnGeK9gZ2XsqoWfDenT1xmsAaEdregieUd/yCrCLfcgs53IKq6oMtcc4O
 l4Z8ANwsYHhXL7f3rTXhUqN+zPMcqJCf66CoR1bx2qZ9Fj9K0x7Nr8VxWvt0TOBM/0rX9+1O91+
 CTDZyiz6a+dvE55VznUPcNgKsHRe28tybsua66vGYDuVrf7z+9Q+VeqiEBfI0Ejm+kKQoHB9hZT
 BPJgWfrgPjSssmQhCny+KzPcjZ8kmW2T7JAwMIL6GdKsXSEQl2jeOROnXk5w+z2rUYJqYrtyYJ3
 +Y83IxmVMBhMUhVRO0IlJkAaMGpTGmedzUX6HYoDS5EbC3e0aGBa2sqkCkF6vNdsizSribmgerp
 QF1h3o83+vRBHfw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:lpwg2RTGVVz8JzeVlaNF/tM6YLUjzL9kXYETNdWrOAjARQB3A7j
 Ga+hx7qWo+XaxI8V5yX3AommJY9scwuTLdhANX4sP3Id4mp4xOfAa05s28RF9367/pNi2RC
 kpYqtLV9uB/EuC5GurYBlmrnptANnR6A/lD1+JQVzYGN/mQIjGQ717cYexrPfgAiw/h0qh7
 CS3xqbxYaAxiIvRQdMcVw==
UI-OutboundReport: notjunk:1;M01:P0:efBmd6kP2q0=;rZpd4To+K0422nF2oNQ4tvDgvnU
 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
 X4S6Wh+csxpVl/skUOnSo4xSBZEGK
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

qemu_savevm_state_complete_precopy() requires that BQL is held.

This fixes a crash when running with TCG accel.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index afab8eeb14d09c1db9b235121c5845b11a80deba..74338a59b563846f4562161942=
001889dd6191bc 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -457,9 +457,8 @@ static int colo_do_checkpoint_transaction(MigrationSta=
te *s,
=20
     /* Note: device state is saved into buffer */
     ret =3D qemu_save_device_state(fb);
-
-    bql_unlock();
     if (ret < 0) {
+        bql_unlock();
         goto out;
     }
=20
@@ -472,6 +471,7 @@ static int colo_do_checkpoint_transaction(MigrationSta=
te *s,
      * to be blocked here.
      */
     qemu_savevm_live_state(s->to_dst_file);
+    bql_unlock();
=20
     qemu_fflush(fb);
=20

=2D-=20
2.39.5


