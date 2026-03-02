Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBFFE9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0O2-0006bV-L7; Mon, 02 Mar 2026 05:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Ny-0006Yu-SH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:22 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nv-0007Hf-U8
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446812; x=1773051612; i=lukasstraub2@web.de;
 bh=f78P3av60iHXeYLfBcNIb/W7089vNVfF6LL/haLWLTM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=M+DOgcpOhbLAzc5I2gXu6N1FIJfov84X3kj6FH4o1Yp1le7SJkVR4DnI0GB/pOnb
 KWBJhjBhrbRODU3j9BidApvF9+rGed4R8RC8ewIFG90d/TQw9le3OeBVVqNYT79AH
 ouT8LDhak95v8fKJ8itcK5bpuErgfNj9p7Gz/KuMUh6OcjPUbNNCfZ0Y8k3XVKM6c
 uim/Z6/+jhqaJ/fGAHijYkmoQrPFgdtJQQjZdSoO3fq5IuVvCE+yV7kD5Kap4jB0x
 GjzbEaWNrOY2RVpweMen+xhnA0k8BPsB5OpImdw1xhi/UjH/xloeED9O+C6aqq0tw
 E4rrk0fINDdQWS28jA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MT7WN-1w75Fr36MR-00KLn1; Mon, 02
 Mar 2026 11:20:12 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 06/21] ram: Remove colo special-casing
Date: Mon,  2 Mar 2026 11:19:48 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-6-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=vR/wp6SYVr5uUbTS+XPqPG4RkOoroNdE8dtNpsOBphM=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQoqPpAyBg3RnsSyT4+nMUvi+b9Ybc4azPM2
 ZuRwQKjs0OJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKAAKCRA1qwsonF2y
 WMCpD/9DzC/Z7E+HqOYsVv1obYHYD0kkbAIuSi5oWtE0CU6dBhjESeiIM+0Iaryh8gOkA0sAQ48
 j4g5Gsjpt8WSW4RLXD2V/919111p/1l5dehMutFOEBgq4aXOkoCdIxZ2YI7QzZ0U2ruPmY0m8i0
 s/5geoyH4y2jdXYszqaPbUk6T2UaQuiDZf+iAaN8IfLQ4wdpb7ODstLbH1rvDSeGIlQfrOwjrNB
 EEOJF1XEznzyJ16ROS/QMKJfZq2x+i4huCwvHf08ADD2xMip1C4C2c3cFxkM/T+7WVuom+ViXeC
 +YLxbIUU/5McpPK0jXWq6gXFb3KC3Z4wiAEbgg/uI18lr2PBHZFz1UPzSWn/pZJ0kidCjP4yFxX
 RlhWNjmdj5Qdu+tXYLjtdR+ZcLAB7B1rSxp+W1ALCesMSakbPx8m+9DGp7yg5dhnNZlcvyTpg5T
 4OOodzpUvThvMkGHNqYKPuoiccipehr6qImGCV6tnHrri83tRz2CI2DW/cCtHmrG29df3L0MBB0
 MwAR9qjocXNZRg7VB3PpFDPY3KDsBUnbQSy7A0gQd2uxTKfNWhVVQtmuA4tgp+70SokcC74rAbr
 aLrOez7HyVwYA/Yy3sbEqXUwdHE/jI+fL/B51zHG0PVWiB5ThYq8kpPtHzBp/m8n0jBKOQsx7Hw
 cCvidJG5BzZrI2w==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k0j8tz25bpgLWTmDS6njk0eKKgwC9mOF/X7K4zJG06Mh+QADbZ3
 M29QztDLaLDKY6wXuFLxIX6XwInIazpFHyUUqHYnnFy9Lsj0vBoEny4cFHBmZuX6iQd4cYI
 m6LIg5vPQHRZZvTOS5EeiE9YhVMjluT12i25lwFF0Sl7x1MyF2MhT1fOug3AkbdlhzWeE1E
 sn6jbwF7YBpki+fWm/NJA==
UI-OutboundReport: notjunk:1;M01:P0:EfMx3/24y30=;zFZfcG1kk11vj6aXHwEPhTV9+me
 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
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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

We only enter colo state after the precopy migration is finished
so this if is always taken.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index aebf77aa0b861e00516d6f1090aebefdd0d97e54..979751f61b30d6c4b878866b50=
11507e7c519176 100644
=2D-- a/migration/ram.c
+++ b/migration/ram.c
@@ -3116,12 +3116,12 @@ static int ram_save_setup(QEMUFile *f, void *opaqu=
e, Error **errp)
     RAMBlock *block;
     int ret, max_hg_page_size;
=20
-    /* migration has already setup the bitmap, reuse it. */
-    if (!migration_in_colo_state()) {
-        if (ram_init_all(rsp, errp) !=3D 0) {
-            return -1;
-        }
+    assert(!migration_in_colo_state());
+
+    if (ram_init_all(rsp, errp) !=3D 0) {
+        return -1;
     }
+
     (*rsp)->pss[RAM_CHANNEL_PRECOPY].pss_channel =3D f;
=20
     /*

=2D-=20
2.39.5


