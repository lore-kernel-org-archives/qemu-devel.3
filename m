Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3CBEE6B50
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3W-0004Ju-Tt; Fri, 06 Feb 2026 15:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3K-0004FT-Dt
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:45 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0008OK-Lj
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408206; x=1771013006; i=lukasstraub2@web.de;
 bh=jJiGbc0HKecovNYE7s40yC6PTgehIGA26Ay31XHpXjE=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ayM3+qnfwGpzKPl6H+b5I0WYgGxkTN4KiOAABSZJPKFlGTum6K+x13DqXE5Ndigp
 Zi8JKwvFp+JFih0MYHpDh6/nuh6hHGcF367V/nbcakFbOR5krrStF0hoiVUFFl1Mm
 cijhe5oLFHHt1M7axV/o+jpGiaBkV2l7cjXexJA27Gnm/lp529VvAFZC4WSaH/68M
 Q6Kh3S83kWoispYjMloB071xIW2TEXH6krokSjig85D4haxBJeKpsVH5NF+k3VE6z
 NTNn7dYwqVgTIDwSEzO+EZSf/7tub8D4CGQKXzyeMmes9174GJnHEovQmNRH0zNr6
 r7mZy5pk/O0e6VXbVw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeUXg-1vEIPq2T4e-00bZYs; Fri, 06
 Feb 2026 21:03:26 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:09 +0100
Subject: [PATCH v6 11/18] colo: Fix crash during device vmstate load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-11-27779dda139d@web.de>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
In-Reply-To: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=8iGx9SD/mI/gEl+YOmte9J4DH7w8mDTmFlt+tTKua3E=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkGhqyC5h4xaKH6C0s5nZxXeLhAgfnNmykda
 KIcop8gfQqJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBgAKCRA1qwsonF2y
 WK+CD/9g7aTCrdAF8FPa8/80YX3ylYfjCaN6gqnpg6csFrXtzFvm0JD1joOKm/g5qqPVeiJHYhV
 Y+u+nglkgfuQlUuK8UUXmH0KjxQuGQPYmkFZJx9hrjPqur/NypwMyqfPyYRvcPvMty6D+O6aj8D
 7xeIUki43EQBimNRzq6ikWAj1so1Ff7fmipgqNP6gQySWzRrjeLQmljHK1IpkUIuljW393L3xtO
 jhUrGYDaJPXNgKihwtz+jNk6N1V0KVpAMB+0G56upcZz5KAqox0VDKNvT9yF+CXr9bjG/1yA2ab
 HIZrt+3Q6xDGprfqhMN4Y3T79/7gr40IIsgxr0w4bLu2kYKA4s6QbMpcfMvFNqyxh/p4YhGEWYr
 zE7mLoZ0fn73VKtNt8E3MjUwEScKqBFVs38kkYdn/DULFsMKG34ccShMqnATGMXPZVX9JiVBGi/
 uooIdnYL3uIOBueWWPXKuJ+zmE3ta3oeqBUJg7sXDnEKnAV6j1dvIK4TflK/0R6WMnBru+PS6LG
 zc1nDcNDvY6LkCKJTFf67nv2qServlRT0TWdKPaNC4UZLCnCFlskEhBHI2rV4u80+zL15ZAcSMm
 OV/+sxUw81l//maVskXXf2/TvkxtgPqGFD/h2OASSP+GPfQMaQzfQaeOGxoPx7ow/mIiJEYxnIx
 21RenprJYgLtA+w==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:cp8aNQMe5C5YjV9uvo19yGYuIEJYtDWsi/4DG+UBh8wVHf3dJAs
 8s1AOABjMVkI3XUjFa3cRva/RW/DDqRAlF95Pgd8TefqWr03lj6nxHTxqksWJohzoZI00vv
 Ktfge1vuJ7qNo2SBkZD6U85GnFSPAqbEv3iMnV6YLCTO5m7u1UBSQVdx1xr7FZX+DHvUyrN
 CCsNjhOePom5jr+sO7Whg==
UI-OutboundReport: notjunk:1;M01:P0:hLXqWQslndo=;hCqOyKKrVIKplQmV7vASTJKG/ty
 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
 WQR7KeUel1NZg9iXO1il
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

With colo we load device vmstate during each checkpoint, on top of
a vm that was already running. Some devices expect a reset before
loading vmstate on such a previously running vm.

This fixes a crash when using COLO with Q35 machine.

The reset adds 10-20ms overhead to the checkpointing proces in my
testing.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index d3534d1a32ad82f02101ac092ebf818a0caee6f2..afab8eeb14d09c1db9b235121c=
5845b11a80deba 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -727,6 +727,12 @@ static void colo_incoming_process_checkpoint(Migratio=
nIncomingState *mis,
=20
     bql_lock();
     vmstate_loading =3D true;
+    /*
+     * With colo we load device vmstate during each checkpoint, on top of
+     * a vm that was already running. Some devices expect a reset before
+     * loading vmstate on such a previously running vm.
+     */
+    qemu_system_reset(SHUTDOWN_CAUSE_SNAPSHOT_LOAD);
     colo_flush_ram_cache();
     ret =3D qemu_load_device_state(fb, errp);
     if (ret < 0) {

=2D-=20
2.39.5


