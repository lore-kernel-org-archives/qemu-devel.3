Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC71E9B357
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Pk-0008RN-HU; Mon, 02 Mar 2026 05:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0O0-0006aY-B8
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:24 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nx-0007K6-BN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446813; x=1773051613; i=lukasstraub2@web.de;
 bh=1ICvXz617I/huIhIVtPmcg6MlmFeXbl2B7uO1sTyTmw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=nHFp+8xPuCvN42bBQ0HlFmuOWXAZ61ALODz+ELahStLXsF+vk1aNi9BWOvIEyU+0
 7zMngIgN6ri9F1xcZmDrQchBSX06LWTOPDSHT3RpD04+kG19edNsjg2KOF71n9fZ9
 qNe7LYmE8NBTsLAeAZkbB+ZsJNus7AhxWLYSiZUI2QDQAQBRYjvMEW4I1uaQU7DN+
 0yCu85v79Ym2B3txFVdlg72DfDzKbh1AoJuzPDbonb6TdV0cilgpktGkD4+Lry3Lb
 Fb9VpLwtDOgcVeyFRABmZigkXJhltkz2sAYW48JOD/xGpxZVCPL7lWOCzOz13cJuD
 BOMeVbXvOWNlMfhroQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDMR-1vN7T00KHP-00inXP; Mon, 02
 Mar 2026 11:20:13 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 07/21] multifd: Move ram state receive into
 multifd_ram_state_recv()
Date: Mon,  2 Mar 2026 11:19:49 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-7-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=98xoBBDImdpaajW7ylxF0FElE0Zr54AC89SoX41cbBc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQosDv4LqNZ0ydfeXy3aUBFAy97pkMsNSEmo
 GEcu63RrUqJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKAAKCRA1qwsonF2y
 WHo0D/9ZDWAp8p5D6e99brVDrBv/d6VmNbpjKan46utH1SKGKyd7URjAfI8K0sgDkXFy8N5gNIf
 gWQLPpWchi/vLjBwdh+hK2KCfk9x123pSKLYYdokkaKr2ENDowLYy8sws5jrakVKX8gLbh756Xs
 HTa92gajP4rUQaaowXFKaE6Tcu5iYwQ5eUkZ+3K9UoAWeCqgjGC5dfZOYxa4zOK49Db/Unp7mIG
 HmjjWW9VMGYY1hVSMg6Y7rOywnB0RqIjLpAYsmNpSlCyPrvW0FjcLqxely7KiaO0ALQsXZKQqH+
 JEggw5xIWwqibwWnAAITBT1gaQK546cKA+1UO8vnRHkuiA0FsDTQkqyzsOHWoNRBExPc94GOLK2
 ZCnGYRmcOuFs+Dndh31tVZflJ7Tx1T3HG32qpnXRZ7aF9c7u6T0YQxVdoWPYbv1aAvqKMW7X2bP
 NrqKIbwDlURg2ivoqMr+x08YSwFN8TOmeCmtnoHgkF75f1g7zSmov/aOI11RMg8WVBDOnQ38r5B
 OpPcZnk0JNBXFruJJeYumjtIRh8cOxhpt6pvuaUj3Lsd4Pdb5QBOhYJRsp9EW5nEF0s35RyYOq6
 hm6MywX57ua+bGlCRSVdnpZytMO6e4OJKpRwVR+s3EqonDR0kxE1ZPusfsCuqJRzfl4JgH6bEgy
 UPiGC2TDmPyDk6A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A2P3u/QUp0TZ1KqclVQ/luSjtO1ghTWqHVTgp9l/tE3NjOxvYjo
 818avuvRxKKMZMmZ+c7XrDZhDTsutD2RynVVJMZpDdSIaBy9sCQozpsCLuzpzS7DwEXYwUd
 ERbPWPcBLl+VKNwQ0HxygidvhPsCIy0H1/4Mu7ICldfgSehNDd0JU9Lm4YNdsMknKlUgb62
 Wuvho/lqLjJH0FP9MJNMw==
UI-OutboundReport: notjunk:1;M01:P0:1Co42WP5tlk=;rTOXn9TlyN9Q6kDfxgXq1x8UsuG
 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
 2yDSSkCVXMG8k0zMsAqKx5a11tvwP
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


