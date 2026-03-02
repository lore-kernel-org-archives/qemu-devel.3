Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C77E9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1gt-00055P-Bq; Mon, 02 Mar 2026 06:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gp-00054A-J4
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:56 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gl-0005hm-I4
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451825; x=1773056625; i=lukasstraub2@web.de;
 bh=f78P3av60iHXeYLfBcNIb/W7089vNVfF6LL/haLWLTM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=r1/bNWz3RlwThsfN3Oo25rOrdHk3hKezok8dISxxhKc+QiXNaRMw54IUNsOKZZGm
 0nV3JRaL7iDG+BCHysmkGfU+PJY2QV2XsmoVZKX4doaIxOGV0iw32Hxy9oWMbXjFM
 uZjy3p88FDHCzhMpAYbcWCHsFZ3/IBkTHR75lc/S+1jZqUyPxEeb+B4cZi3to9ra2
 XL8Fqqd6q0mRzHM48OGgKYRHKl1U+olyv7jokbS36c3qQBzQ9MnwvDAyoEnv8Gjc5
 orBQXRRGszCo/Bos/HcchJctukoonWvCmNqwwWYJPZa6XqbMU/W0cExilVN5cm7e9
 HPPTFj6zm4710J8BoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myf3v-1vkhpc18iT-00uBbr; Mon, 02
 Mar 2026 12:43:45 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 06/21] ram: Remove colo special-casing
Date: Mon,  2 Mar 2026 12:43:36 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-6-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=vR/wp6SYVr5uUbTS+XPqPG4RkOoroNdE8dtNpsOBphM=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6Tpo1+8aH3hmLz1lRI0iQmadQ/WfnzCeJGg
 9gxOvxzaBWJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVukwAKCRA1qwsonF2y
 WD2iD/wLk7MbQ3ie23Bv4wTDfJInS8TOy1ESKRvKOJavCSZdSHXGnncVykt64BNN0ZGDVJC+MFT
 o1xoCCrPgACZlFpRAymtuVMNgbJjOOHCkZZF4iGSZJc15/XUg764a6ZKYSYUWKspvyp5XgVmtN6
 ehlV4BfRZJD4AGZRXe3lP+wobqqKM7yIEWnaZb4Y7YVBPAp5ZTydAf4o6AMyT4eToknvEXvQxzu
 YHzoNGf4wMAk6eJyQ89qJKvYURvFhc1nMmLLxVOoXWTgAKQvrl2tithA+nJYOYz4xDpvuweR1PW
 SZqjXeMgEM2P5T09bJdef1FzKrqjYBhY20wFdL1VGKwAnTc797e2rSkvVqmM6jd6eFsa9XDhy45
 F2j/RtSsaaJFJPvGakSSUny3C3VMEBFdR8xP1rFQ1WOKZ7T4TxvlS0YX4j4De2SDeML92SKl7bC
 tFZOrhpofJRYwfEWjT4kXdDjGqD7YCBOd5uDeg3eKF28SGo9+QMvj0Cd0n5kSqOzaw063ehY5if
 LtxrJqnAiXVeeMS/C5uOIwx7boX9Y9yHW13g0sCJkI0351XBrraithwhPH1ZV65tcq8MuTL6u5R
 LucbKsi8HT+WBdegVb0pWosuoUFz7O4b4vlJ3J5+Do6k4qsifeqvTD0Twdd89Z52jEY3vr9/GdC
 1VJ051gWt6rxI6A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gI14izy3qfdH5TYHruv26XdkrUQqL81xS5NVWvVm5ftdTMTWJDy
 HiSPsWZICrtDXbABxXjJ+zonhx+F+aNxxyncw4kdlMJgGjH0UGAlHHs4Et0d0u+iJY0bObz
 rdeuc95zqksAJ0YhrUFs9iuFqcKagLdPcX6sjAwrkRMgLcCfdyIgQIukPs1sKnNRm9G+3yH
 xm7iHbDiIhp2diX4Kv40A==
UI-OutboundReport: notjunk:1;M01:P0:zAJUYzBskjY=;WxC6ippAVK5en//v+Ea/0W/seTL
 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
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


