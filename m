Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B025E9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hs-0004zn-MO; Mon, 02 Mar 2026 05:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-0004rq-RE
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:40 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HQ-00062A-S3
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446415; x=1773051215; i=lukasstraub2@web.de;
 bh=1ICvXz617I/huIhIVtPmcg6MlmFeXbl2B7uO1sTyTmw=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cqwR+nEXrW+YO/OTm7mvIBwXYP/X1kgDXYG358HXCgUDMvdeKPaWOuF7sUgfWsL+
 cD9FRRNyzJltN3dWa5jqye7etPjcprgJldhhivsjjs3rk/vLk7DwX4UzQM1x+YzRu
 qKlCf36YgxM9GyUxz9wGA6JwauF9ILev7jbhZqNfMkd51hFphZkZKA4PcrDjCvMJP
 pPKqciSH4n6MXGwjTRkCaB9+PymQWCxvfFQXw/JiUmfp/GGG3MUxc5fmA+jXEcwbB
 vmUvND6vD+XocX5ynE70PgoyraYOVDcbX//zUHbAZzyB5gJZ62ydFdx3FavhjbXgv
 VCBUy+T6iYD3TzU66A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MovnY-1vLBdA3kfm-00mBDM for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 07/21] multifd: Move ram state receive into
 multifd_ram_state_recv()
Date: Mon,  2 Mar 2026 11:13:18 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-7-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=98xoBBDImdpaajW7ylxF0FElE0Zr54AC89SoX41cbBc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAFryjTGguF8A2qc4FZJwVAjuvaP05jRAVqB
 pMY/9t0DiyJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBQAKCRA1qwsonF2y
 WFdeD/4iOoPrly4CuyvxHS/P3/WM/SqrgO1IZUDHw/+UVbDf9Q1N7/+TuFld6XHNRGpmKrd7ToC
 KgHcrdNMmMLwEiRqQ5mowcyapouA4xMw7OpZU5brUE03eOBXl3oPvd4Br7SULAgcd5muCaaEwdn
 zix7+MF1dTbBaRtjw0FzJvyUPQ2UxDtSrmngEqwd0TH1APFv54gDyzkT4NtwsZm7Jg+g69mdgHc
 tWMH8aaZx3GL1/IrgBEg+2sXOZW8DC+pfIh7jNtkupPyvZFevbs85Dq6jwUWI76lkLJjeuuCg6E
 j0WoT4fd9HXf7Tbc+I8CFiXn8MA5pDSxeceRRFFuvmmlkCWGwdh/wpoETMuTcStYEGrJciQTD5g
 3/GDSpgplD6ReTlTQG9NhSbHvj2ZBeX1cvpr8BpYJXGWveku6hd1G4Dexh5RSYMNpHciMvQrZSZ
 YWrIu7alWqL/KwayWUSMBApEIlYnzzo2W051CoqMILgvmSFHOg4BBbt9nL2GeAVPZOjUGAV5LqF
 Dc2AIbnFR0fI7UZH3rEDdfxUFl9X4M7ivow4/OiaI6fohaKPHpRKZM1wzKcQlYvna4njIhv+l3y
 yTGSpokqGnOv4FYrbExxSpC8/767Wm95Z0wK+VyVlYRuCCWWxhKY8YyiQPhpHMvT/NIh6fim69c
 TmOx6518nYB1k3w==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j9ohNV+iDI9F9R07W6w86BqQ6QLnt+eD8yo4GnLpiwDw0qqwrvM
 D48Dz5xOk7gD4YB1U7Cv1zo7y7YjBi3/d9CDqm4Gn0bEI3j55OVYAFQO2EBB1//dWBZHErS
 zZW4z7/sJoku8+RDS/hDjGsZYqcr26YpmZDOnEXwQydfqy7UACha97iod0Wsh2Fju4YKAOW
 24rFD/Y7Uy0e+g1rSun0A==
UI-OutboundReport: notjunk:1;M01:P0:Db4/GHBE8tU=;1gLdtsI11p2Md8Y0nxpaZr/OGeP
 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
 sdvFjE1xxw5+6avMulo++ec/3+SOV0zBlPHkOJ
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


