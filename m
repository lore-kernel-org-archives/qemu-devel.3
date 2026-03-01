Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391D3FD0078
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoU9-0004Ay-8B; Sun, 01 Mar 2026 16:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU8-0004A0-7H
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:56 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU6-00043W-MU
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401064; x=1773005864; i=lukasstraub2@web.de;
 bh=q/mNNwnaGGa47jBNu/l/VsNCmpfLA9HBEoNXzcytdkc=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Q2VP9V5Ov6cvzq2MePD1GkWMqhg0fKfXyLEoRMeMmzPPcg7jSbTxdn3Ikwu2WxZ9
 29pCjDfzZ9FkocS1QJHAB3wWuGECvoo5XGaU5c0JSb9SM8PM0550qTEWeIIdpFgh0
 qJ3HIW9QOhbvWMap4QJC/twXTUhz9XxTE9hrB6aZaNpR5lyNRKmslW5PjD3vTDXBs
 MsljyIWnvxqSBAQH1rUjZ5xkp9N9DHbZUM7+onK8Xy5KmUYKrFu8IgfdWbjGFEdQm
 I1RSwtg/cgutNVlVo8MYU0JHQPWJeKU2b/VXoMk7TcQ/ilYfrtykMK6SEOmp6SpPa
 K2DnGvWUAPYSaGM81w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lnF-1vdjE31Gqh-012TGl; Sun, 01
 Mar 2026 22:37:44 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:30 +0100
Subject: [PATCH v11 10/21] colo: Fix crash during device vmstate load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-10-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
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
 h=from:subject:message-id; bh=Jo9ygbD9kqkeUyQ0JD+anPkAvVD/vEUQ7S+iY6iqDJE=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGhVCu9xCb2eLZJPkAWcKTcsM1JR4yaiAiIs
 OTCVrREdnWJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxoQAKCRA1qwsonF2y
 WEOYD/4kfDu/AjkUXgNTf+jlSqlyWUEPaFFzPgEUjal10B232A+3AAD9SaW51GAxv2Fa21Civzq
 S6uyeVLegC5H9p/RvQYz2lzyp4Hn6hSEJ4esDebQlNamW5PQXo1GcaCaCDlKRQBZ9Asx06AdpNn
 f6t+CwhigMnucfjkeumESMK/JB4w80C75EICQnRBeePj4f7rDbv1sXKtmAz2mqudkiqRCKHxXTG
 riod7DJGvHu/j0WDW7QIZ1mJsQc4wOqiXduTK66z49gBybjnWZ1XtaGmWKUF6E8u9uX3JHzaAX8
 QIyP0EcmgcFN+vWpGwpnf0xAkwt0lDIbwEgSIPnUy0AvuX6Yr2lrlIxnnp6W+gadBWkCEt9p+ic
 mkYTu0nQrvKLdsUjZECFvJO1qTRO0AH5C4I0HnCbGZtngmOfsgV3/wAmvY96rRdGO5gXtbCENGW
 aKUJo+TCDyeHNhGiKjNIvUy79zXMfSTT3axZNCNaBnS/b8VU499rMEVNuUWqcKd9DiU3qWFCwSn
 4X30VJ3pzjhtH6XAg2IVJPojc1GMeEc9MUD8Ky8w+Acv7jLiTt6b2dhnJ/XL/r3gmeae57Fjttp
 JwhovsptBUqIHwAB50BbQYh1omzJq1a0Du2zn64h5Gl4G6h3gSEg/i7CkSjh3FL+OSf78tjBTqA
 42FYeQH7UI7Y+cQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:L4Y5L3KN3w7WLFoJ1rQn634j2VXebt6qw1BOEYcJmpK06AkjOmE
 nNqi0RzoXkH51o9+cd7w0KavBX5n0jGzJZIHjrA/QGq5zvBSaNNJfquQayaz1ekcdgAZIQG
 d64eOmu8OuGkod6CB5PLLBcKW0I/7la0AIj4fyw2MMeOHkiBZA6xYOGJzzMJuKQyEL2f3Ga
 4eM7Jh1ycva7hYaP0Jpqw==
UI-OutboundReport: notjunk:1;M01:P0:Rpjb6lRPUic=;gmBynog8q+2VnBGtjaNbEXPkEF6
 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
 5BSatKuQ=
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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
index 96102c9d0fb3b60e063c81ce07b730011bc4919f..dc7cfa81ef7db78e3ee372642d=
e48567c5bc06eb 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -729,6 +729,12 @@ static void colo_incoming_process_checkpoint(Migratio=
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


