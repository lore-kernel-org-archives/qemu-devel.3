Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCA9E63CBF
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 20:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk6ue-0006y9-6P; Sun, 25 Jan 2026 15:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6uc-0006x5-3z
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:46 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6ua-0006Cj-L3
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769373642; x=1769978442; i=lukasstraub2@web.de;
 bh=vgLJ+U6K26CtwA9b5H7uaEOc9nYtSU8L1BmZbwpD9hc=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GsuzWvtqunLKFqDXj2TnHg7kRKd5pr5Q3a7xaxvF/Q6Ohzj/9EkthATCof1gVzoH
 5CvqTdKkyi7twbAQmameLDs24kZU2KZNnhU4TmA4RDnc0BwDyX4tB4zAqyEmt0Oo2
 QjjcGPuaiUMgPJLdpls4sLQNpNWxywRcGvtodqe8ThL1sW6weCjbuf0+ZO8664Rxi
 SRkvV7VFn86UZTVpEu/VIAs6pToSVABHwKRhYmT/dy/CVfHIi7oZpMNAOPB5yb0m9
 g4WW2wI1XHbD+4KIBKDPW12iQR/K+vWV3DbiNCqMmBB06FDWIMdHs9iuScK00lU7J
 eoyXdXSJ16pnN6mcig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2BM4-1vtTjI21GQ-00vAK6; Sun, 25
 Jan 2026 21:40:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 25 Jan 2026 21:40:08 +0100
Subject: [PATCH v3 03/10] Move ram state receive into multifd_ram_state_recv()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260125-colo_unit_test_multifd-v3-3-ae926ccd8eae@web.de>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
In-Reply-To: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=dZIxj7jhzidArs1dqbg1/3LOr1jTSaOWyeY28DYEzI0=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpdn/FBzO4zrYb+wthobIr6ZN8k/8WDKeNVcfjJ
 ZE9/Mp7+iyJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXZ/xQAKCRA1qwsonF2y
 WGMiD/495bc2BhAh1I2YGmvuN2fhsrd1sx+220fd4Vrz3iNG34DQcekR2z9Yw6opt//4O0XfTX3
 T4IJIinpzYhLAHBhcUyGIMRmuTsyrpK7Q/DK19RaqyrSN/+MYIspvxjru/26d09/XQkk0HIaXU5
 TGbMVttGiMCG3ObM+yEnPvDiz/JQ2XRpOlWY4UfJKtMURgz6IOgJUPpW2w8m703yfg5FDwyX2Of
 9WMopfJrrNk526e16YG54wPJcNmOCoDH+jSELPoprITr+Ki46XORFcjst/ehv8UGuK4i/HA5CrQ
 BICJf0KCu1a4ABUml5vZDXT8vvjkK0DMNLwnIZn1aNoRcToKuVKZ/C4AssvbOLYTgkIaEp3kBi+
 MVpWarDgezoKw2XCy62t6jLdM++VwvntWEY6ngsM3SLSDj8lzg4kOsyaum9cZ//u0HmwAMqduVw
 rFLZSKcAeHujJNH/9mmWgch6r/q0HaFb6fGiahRC2nXE99EmzwUKO8C1WpAnbDWyNqrIvmSQ17s
 V/OcvuVxXNL6+BeXqR1tqB6Anwgnn4mX7Va9H+YccISoN7SymiO0y3uXdDQBe5NLm21ru7kDC4y
 339mupR2h9FW1TkDX/HRtoAeP020IXo0DlFLbd3MtkLj45zLzBEIcvBaUHBaAnkdoTCZt09jelV
 gcNKV+N9jwrnocQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:4eyWSNmievxAbSUzoyoUYnjk0XoxcdQ/gVxEREB19uSSYqVy/FQ
 039vJDfrY3QNBiL49Ih6pUiI5R1Q9pYADqyAZcTtBfc4nSHjW4ODz+hrAmsj2G5BFA/sKmA
 8UHdAscRCG7ZCLzmpuBrVBhyR0wvJOa8q4TSgFEqGKW0sY1sbnp0rZQ0xoPte+07RHsKsuz
 t7kwUsAxaHL8RIDEX2y6A==
UI-OutboundReport: notjunk:1;M01:P0:rHyk+5r9wEM=;mUj1FlV6yySIxnZd3DLcHkkT335
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This is in preparation for the next patch.

Reviewed-by: Peter Xu <peterx@redhat.com>
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


