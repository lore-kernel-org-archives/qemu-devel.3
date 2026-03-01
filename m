Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D776DFD0062
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmHm-000163-IJ; Sun, 01 Mar 2026 14:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHl-00014y-A9
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:01 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHi-0003Vk-Fm
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392611; x=1772997411; i=lukasstraub2@web.de;
 bh=1ICvXz617I/huIhIVtPmcg6MlmFeXbl2B7uO1sTyTmw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hb0bq/2H3NgwsbqXT4oORDMhv0nPnvXZYJur8R4YCq1itBzsYdt9ghAds5f6HV0h
 89/RM+OZT1jwEV3klqaSqL6CpxNCmD130eJCIfR6D9QMfE8cQQTCGnMbXSUVxW2ta
 yTqq9IjINIC9J82s5SPvA82Mr9DE4uixJ0v8Z8VN49ssFXjYMaAQGOhsa6hgdMTwU
 jiVofO7LnOfMTe03xmw7KyU3ILsfMvJhy6iBOtO5x66oWzz92corrXYktoNRMjYzw
 vVUStCY2VHNYWfYmGTDoUq76dfjPvR+YM04LR4Uh4jbHi2d8aiJmAlSY29RBZ0OX7
 hfP/7RFh70eC9njtag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mt8kN-1vhauo05Zx-00xT11; Sun, 01
 Mar 2026 20:16:51 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:32 +0100
Subject: [PATCH v11 07/21] multifd: Move ram state receive into
 multifd_ram_state_recv()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-7-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=98xoBBDImdpaajW7ylxF0FElE0Zr54AC89SoX41cbBc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCdcTbFXJr5wZEdEtYi9U1bbPbltvTrdg4q3
 E6nT0Eb4qmJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnQAKCRA1qwsonF2y
 WP4VD/925mAYrEuLrJF78CJ3wDvKwsI6ovuHj4WZ2KJhIJ9Yl1XK79PATNuAc+Fd5VBxj7+HvAH
 ZppQH/n773cuc5OU+bgjRb2928Nhw1l1R9c60zIHTQplX+Vh5CAL4t2AAhKTTspxDQV31i82Mp5
 QHs83+vLpu8x+IHLHBSNTtkX+XW2Rj5HrPtKTpx6h9X/y1dINuR2QwbS6TWZ4amZwH8soPjt+Bx
 ZAVNxu2QJ8M3CajTLexs+tJEKLvLskc0UrHfQQoj6G/RBX5VX3OOvbaO4RGV79i1PurMJtafsDT
 j9mtNVYPVW+KnJC1oYoJuo6aamGq9ELoYRsTqtc6osL50/eNc3u/Ndx7KaSoaNj85GmjTErpYHk
 AuQT0f80o2Em5sBRDPQFwOnh7LOgYIvK/V+yb+yWgYVyYE58TRRr8l3kdF2b7rviXGcC6ybSNqR
 VmiIwf0lfHIHmnRV4EL2wEtHb3h3sU4sOmMHkxTJWmk5t4nTP/hCzfpN2gqLI0QOIbF1VJHp78t
 ihgPXrIK86iy0BHRPOdB6/wtyQoovHf+/sNcP0v0300mXYE3MCdR/B4PYdiEinUCjrI+pFtjyZO
 IYon9v3ApQkb+MuCiXIbbvM+IftJau4jIa4btkZf7Gu4WwJqmfyPSPD3XXVSWmau9yFU9I04239
 6rp8W6IkixQyZaA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:wrYsrHnV44/ZUZxT9Hg5SmR76e0oFIv8xt3qGa4O3lMuRibBgJ+
 x9DnXkf7aHP+CU9knH3MN2AS8hqZSNXP08ScFl9Q9VqSE2N+BDmdLdLPVb9IALHv/l9Auho
 fuLxp7/xYIEjt+it/QjmosptxhuKPFovaP2SxTVcf04W0nhutw91KJXS0noXSsaIu2v0DIm
 t/bLscjN9hh44FdoBaZRg==
UI-OutboundReport: notjunk:1;M01:P0:WrJqN39Mb3k=;lrYIu4Nki7aLJng7AzTWDpnEbRv
 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
 JipyucZskHaO0+Y3MDVvz7985E/B1
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


