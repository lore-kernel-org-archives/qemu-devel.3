Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE6EE83071
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDSE-0007WK-Rq; Tue, 03 Feb 2026 05:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS3-0007FF-Ae
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:09 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS1-0002Dc-79
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113750; x=1770718550; i=lukasstraub2@web.de;
 bh=jJiGbc0HKecovNYE7s40yC6PTgehIGA26Ay31XHpXjE=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HdbNGjqecAubCH2O71pgp+6t4h0D4ylrI93efD21HytkojAro5OF+5ayrfWbEUbk
 NR+phnRbaDvPBBfTLJjoQLOoyZGL/8eX8FpW4BAZQWJ+2P6Ge+ImyWHb+c2cV8OJB
 G92wfg2KYFWff0I03KmKxlYnEnyBzbSvrVNAcHEJG7XtrgVD1k6HcQuoPvXHz3wED
 7IBHWA5zfilhzKQhPPYFKl3Abm/91aC7D8BTxXZ9OarHLjd2Bp6HAsQ67lo3HxOHa
 wjS1jnekk7KcnMZ7X8+N3GksxA/UUAkNQ4YrDvwpP1jIjGCK4uQ6ahJR05rMPeYwg
 dOgg2oKryKEpjyITlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rTG-1vpPJ82iYi-00BHDK; Tue, 03
 Feb 2026 11:15:50 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:17 +0100
Subject: [PATCH v5 11/16] colo: Fix crash during device vmstate load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-11-57508b7389f6@web.de>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrQt/BUpxpY1+uixMIeLsAlrsN+MvgulgqjD
 o5IQFOxCvmJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHK0AAKCRA1qwsonF2y
 WKsvEACq6Spv7PNlu5yMBcB7qBQ6BIuFyTi/njUU0omNRIIP2LkMb23Pg7xKlgpo5LKnT8Pp5An
 tilsmZXGUQZvCyySqWEcbrbFQcUpHV3A7DIw6rWZNlp74vKEtjOepbePGTNgz4kQM+qXlWoHpzS
 1YHvDWTiDxXykofTKwoGMImEHyjRAmF9jK+HHvDxpk3MX2jDZ1y3O9vroZP9x9qP7RMd+5Qqx6Z
 oEA5U1Ax2n/bYyQxbGLoKNTD08dUVyjfke3GPPZ9X4nLFJ+qsS5MWzqBvCQSZ1D1tg7e37o0UtX
 Zsym3P7BVJ2Wy/VFZBjbUR7zs6E+M8djWCLL+ifmjs9qfbhdvtNQnlgM6+1qoBAZvx97O94ks9F
 paySXyWMtg0TLHwbL6DbNj87MqAtCm2GU/z5ICfzdHMZ9t6CeNCICYPYmYLxGjnBV6CgtmHcc74
 UPQ2Iuh4907V1DgIxiwJ+6kOxgvhWsPuOir7bPRmNKXoK8DpCPgoBf7JatOETG6GeuccLVqLCsB
 d8XcCx15hhhGbIPyTB8kZbgn1oHDRQLigKjEj4uteZPJcfzIoIa7qJJlfqbcOIf/WikMlijo7Dj
 fiKwkBnE/LcynylRdPTqwTJSAId7n7ckVUzh0qfsrT4LlIEq1OhoN+cMTZvpxP9hHtQ2CRgT/VU
 Kziym7uf6+tcTNQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:lRdlDrrQ9ed1S2LlroKHNKiLr2E634RoPFAvbVujLFCQ6DT1400
 VnKalv5INDg9b2hS8Qd1OUs2dyFerW4od3bru+WibPab/BVqXKLKjb6e+bvykPNo5Yp3N4n
 E+NKwDoE1Y7BowRNEo0eCfN5AVNbFpfQXZQbRtaVk9850f29FX5Wbyr268DnMjEVh0+YiaZ
 GLyjOyoaKfS/nmTyAUXkg==
UI-OutboundReport: notjunk:1;M01:P0:+35vGQ+YOQ0=;Tbv4jZcVul39h/JVJIvG/AWahrl
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


