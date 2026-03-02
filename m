Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC8AE9B354
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0He-0004vc-99; Mon, 02 Mar 2026 05:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-0004rv-SE
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:42 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HQ-00062L-RO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446415; x=1773051215; i=lukasstraub2@web.de;
 bh=YSxykUnLHj+SuX5ceNRivJWw7C8CFbfonhplWMaurEo=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=w8uTKHGPcQWBDcXXf1ep4+f28tYwMArA35p+C4pPvgZomrdx6dNlZW+buBFfezO9
 33QrX/LnnO83E5GmIfWoFN8cXyd78OsFiNBuWV+PARVcLc7n2pFUb8j7OKE8R+hZ7
 a6CguOYyjZDz4io8c77U7M2uIg8mHfqQ4BJftBENprEmMIIaSXehIy+31zO7eofIP
 sj+IcAGwB7y+1QnH8G694sFYBY+1+rZYrdB95JNF6qxBW+yUJgDPFZPRmwVjXo8C3
 ztjlfSCMut69Sb2fbeh76fHgZDjNc42EojVzxzz3KbtsDujrf8f3s5VTu2wqQ+Ip2
 j7flLpz5BWmPo93llg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKuKF-1wFN8k1G0L-00PVcp for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 11/21] colo: Hold the BQL while sending ram state
Date: Mon,  2 Mar 2026 11:13:22 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-11-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RA7Q8b6eDwgtboLVRiR+7AHIKPUv7kjwK/dVBwC/CXE=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAFkUSE/Eo9I+v/5NRleekEXxF4NMfVylZo8
 hlHvH/s99uJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBQAKCRA1qwsonF2y
 WJXkD/9/BwOb/Ha8TbQqGDDbA9+OEwlF++2+sziind9Is7okZBDBlFqo+XQTB2dUzA8oked56vI
 bhqMVOL6ZJj/PQBbhN5Wzf+Jz56IfFHn5VaK9ZcW0EfbLJlrrK9gRpWfi0dy5+p6RG08r/tdwFu
 lJDH9Xd7FvmtfgFTDigZjpZ/PeyTaUa91AVYVIFTNYDxISQaJFr8fB1T27oMWTHp8LI3Vig5nlA
 69T/QE4XCZgOgoPqE3qChMTKTyBjf8n5zK8eyC73B5A/Lb4LaH6NuVV95qk6HlnFTltRBjZsUaB
 FJchYT45ygPu1bd0MtToo6Z6niq3Sjq1hLtQElKTLQ7VTmtGJ6n/+zw0bT1DqMsRatHamTK/Jh/
 KinATTfyBPrdarSM67U7ocCczj8tSBjXHfc1yVXHfhgj8uIRKDCERVN5foqMT2jc2iFxD0Awocc
 57h6ph2qpSVvliOCthilk41d25vvyc23MT+oXez9mu2QhnIi3OmbQ/GrnOhI6Rnd6mMhIrHCBaO
 M3iY6bxS6lME7xChxhIpymNFPDa24G9dt/3j0J0pNsHCWXVMw4+/TDme80EBrIi/UhLr3e6U3a2
 kd/LZfJ2GFrnemgrXV7WiM5ixX2ndqYoufmjX5uWtDKduLDfxpgVnTOnmV+RXrnydu03rdT7xi6
 /3J5Mzkjz1yvVBA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2M+Sj6boM0VtrF6kmpAOAhFYLAzgKuSuy7hQzmSmVVEp2k18nV2
 Yw45Hyqg2EqCp69+qPr0H/JtxGrJNjmGW/djUzghGAFN4SsMOnPJNn4BjGP4cWfPk2EHF5u
 EX5kDDcwa0Yoh9hL+sm3Bn93zTK4qP3+H0tWUo7gID0ufcPLWnL4pxjctPkA59s7P6x0xxi
 VGMgDNiGPPSWMjXWNZo6A==
UI-OutboundReport: notjunk:1;M01:P0:T6c1eFLDZzE=;N+acuQLn58mWCv1V6MsFIHZEnxF
 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
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

qemu_savevm_state_complete_precopy() requires that BQL is held.

This fixes a crash when running with TCG accel.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index dc7cfa81ef7db78e3ee372642de48567c5bc06eb..3297aa593cd9f87bf101359846=
4cc581a9d23531 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -455,9 +455,8 @@ static int colo_do_checkpoint_transaction(MigrationSta=
te *s,
=20
     /* Note: device state is saved into buffer */
     ret =3D qemu_save_device_state(fb, &local_err);
-
-    bql_unlock();
     if (ret < 0) {
+        bql_unlock();
         goto out;
     }
=20
@@ -471,6 +470,7 @@ static int colo_do_checkpoint_transaction(MigrationSta=
te *s,
      */
     qemu_savevm_state_complete_precopy_iterable(s->to_dst_file, false);
     qemu_savevm_state_end(s->to_dst_file);
+    bql_unlock();
=20
     /*
      * We need the size of the VMstate data in Secondary side,

=2D-=20
2.39.5


