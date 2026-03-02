Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A3DE9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1gw-00057X-ET; Mon, 02 Mar 2026 06:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gr-000559-DF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:57 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gp-0005jH-BE
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451825; x=1773056625; i=lukasstraub2@web.de;
 bh=1ICvXz617I/huIhIVtPmcg6MlmFeXbl2B7uO1sTyTmw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=dX4vA/4EGmi7PKiAfCLxhs7EdwX7/soL5LpPdgphJUvK6lVPhOYPB/oHJsmcNexW
 LDyo3ZH8nwYuISQRbPrpKqpCr+0s3KzMmNdUC4OCwwjTXyxxm0NTVQTPFsGepx4mp
 ngsaO7YOHAASVYeYsJgbxQ3rLpwi7Bef6zhqERaJoxL8tBZNDoekPd13DTYfTzsxO
 QumWaUdtoWdtDXyZ9aUaYeYcV/aOzrJ3GUdmHLEVvQElATMZmiL8xhBX/SbpDrTiH
 b+v4vsqHKEtZyOSC9t1CAaTaevqTKLAWB2LwLrvqMiQzHNMZvy/EvCFnokoWBidPc
 GktjRo3uYyk2kxsa3A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiuOk-1vRFAb2BlM-00abUc; Mon, 02
 Mar 2026 12:43:45 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 07/21] multifd: Move ram state receive into
 multifd_ram_state_recv()
Date: Mon,  2 Mar 2026 12:43:37 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-7-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=98xoBBDImdpaajW7ylxF0FElE0Zr54AC89SoX41cbBc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6TBDf5Fd70zaQkvwtaCIlrBiLswXnuoTCF3
 wYO8kFUefmJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVukwAKCRA1qwsonF2y
 WGWcD/0Yln2kKjaEMkPqp9Jhl9aGOw52bgzfGE0CENgczzFEDZzupkop5l53Q0YdoONJ4nTQtqf
 DfJLbl3tSDUibqcEB/dCN6e25ahGb/2YiTcUuuJfNj5d51Mr8k43KEDmhZsxPPFOJDaedrHYbA9
 pqOD3u6ul9GlHTMxc18ojhvtPVx1WFHz4Dxxrn3sm/XPM0Fb6EzpSWohyzyKFf6lmtxKHml58PC
 /lN3Ob96Xk+x2mmD8R6nBIf5+tYP1/5MPmMvw3SUNaxG7/GvDeeuEJqcfYFXKXJgtzcX6EcpR27
 UP0rQYAUmypC3XJGvvEp03A41s4otNSUmQCq6iIhu6tP1Y52r18yWiR1P+ygdxJkV/JZnZPwvb+
 6CpJO2DLzucQhOO76Lb6KLoV17Ozbzc5AS8DePJSkIbIQS8UliKe15ZhtSZhGCQvckVUuT2oRr3
 C2gmMLE/iJymJWnKntxkP2DMHkt2wh20uO7oPzvOaHYOH91Vc96wGLjKmL6HQGKmCY4UVrDcLzs
 4idRV3OtIX6XGMDCwNlLJepVelRA9Uy7rA/E8IpCYsFQdLEvo0u94IH0zXv7NM8j/J6oFnwZM0o
 3P9E1JS7r6jw66XKYd1dNIzjK37mcbAY9qr72+zT/q6JtZT40h4Gai9H5B2aJY8hCMMzv4sV4cx
 ge6hUT/yQhINzNQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LFt9yVjrALyVVdnXs5vqLC5isVgtbXipdERd8xvRdS5EZZ8Ya9e
 gIZPf6RXajOiqC2KQHr1DbaIk3UR9gvcps3+q0AQOjFiPL938hG9I1bt9NgLHT/t+AsOtpM
 cfNk+ywF4lelE56vscjHY5pWV9bE5nW5cZNGH+r+n/dZQTYdmqLe/Zj6bCBvFG6ynE7ko2f
 Z2mjUOQ9rl84eFHx2TWjg==
UI-OutboundReport: notjunk:1;M01:P0:bhMoehjTuqQ=;ZZYVGDEJQinSZ+QbBimCSg7pW3g
 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
 7+n+B0tSifCJxZFMenVk3qNXdTwmT
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

This is in preparation for the next patch.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/multifd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ad6261688fdf98a5c7f4ee9fb80ba2901201a33e..332e6fc58053462419f3171f6c=
320ac37648ef7b 100644
=2D-- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1253,6 +1253,15 @@ static int multifd_device_state_recv(MultiFDRecvPar=
ams *p, Error **errp)
     return ret;
 }
=20
+static int multifd_ram_state_recv(MultiFDRecvParams *p, Error **errp)
+{
+    int ret;
+
+    ret =3D multifd_recv_state->ops->recv(p, errp);
+
+    return ret;
+}
+
 static void *multifd_recv_thread(void *opaque)
 {
     MigrationState *s =3D migrate_get_current();
@@ -1387,7 +1396,7 @@ static void *multifd_recv_thread(void *opaque)
                 assert(use_packets);
                 ret =3D multifd_device_state_recv(p, &local_err);
             } else {
-                ret =3D multifd_recv_state->ops->recv(p, &local_err);
+                ret =3D multifd_ram_state_recv(p, &local_err);
             }
             if (ret !=3D 0) {
                 break;

=2D-=20
2.39.5


