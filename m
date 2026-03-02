Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281E2E9B354
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0He-0004vv-PU; Mon, 02 Mar 2026 05:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HV-0004sD-PZ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:42 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HQ-00062D-SK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446415; x=1773051215; i=lukasstraub2@web.de;
 bh=q/mNNwnaGGa47jBNu/l/VsNCmpfLA9HBEoNXzcytdkc=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=phFdA6G1fXYNYa1U3yjPOc7ib7lwarZJN0j5dCollVtp8hAu5dwbTZfUaOenHeaH
 IhWxSKCQe8F+yHFT11qGwx5TWmX2kk61tvlgAvNK7cwfZHvGfzV9roMvxJPtvrfrF
 5XJfjjDl4y3sqTOxsD8HCGCau26Ns/wgaulb69DpqiYFlQX/ZrMlCrfHvwAz+AV3i
 iQHFywW41/4WmT+z9vICl4ZbiHq1ZJdVjRhzyg6EQ3DXMGeFGkVfco2rnMZZVScAJ
 P0NintoPjt1/MhLCkxBdq1OaTqdop0qOv+N0DhayQgH1c1HAzm2OaML7IauSjKQXo
 uh5gZT/VTDNtNmfk6Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuF8x-1vgJN40q8D-00yZOV for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 10/21] colo: Fix crash during device vmstate load
Date: Mon,  2 Mar 2026 11:13:21 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-10-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Jo9ygbD9kqkeUyQ0JD+anPkAvVD/vEUQ7S+iY6iqDJE=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAFEyNplvJjjgWSdbvwARSa5gUjnNXHkw9H4
 U0VNYf5RnCJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBQAKCRA1qwsonF2y
 WPekD/9IghVPQWDf8a8ZOLGVV2WNngYD1PMSGUvSGMzJnNYu79FOyMi2rylZeIXVi+M3Hvs4zUK
 dw3jWN4uJU29JnQCU4wqrAeOcOmXtkUHyMZiev+uLDyGzWUZgAc+N5xv4oZcAFebpFq/H4LPVE8
 UjYgA6NV33gJMUTOQpcynCjT3DOnyrO1djXX0pWiKdat3w3/clPXloVfvAF4WrKhhyIEjV6bw5o
 Vt93VPVaWbCXZYuZYpEoUgdgORuLbDX5Zj2L5A7EjnlhzRJH2OzEk8lPx7j8h/c5YiKbEnuFygK
 bPbWXR4hrlUmTGFYy0JIoJZwmNsDCxIqciu/BwWKGBuWHiwVZpoKGu7hQ/GDCGzNK7oZ75o9HQM
 tdmsKXzwUUiSjpWm7+gu37Mih6HnIpMc5v9TnlfSZN3WufmFaT9xZHxkDNx/opqlTURLOyWsW+V
 nKgK6Ok3vcQnJybgn4hhPBUIDucOxAkdHL3sFHre6156CfylD990/6jJ9vctx5pwpiq5rK7JSDJ
 302X862qonMVTU7W6uz/Wm2UOQZBZfkvYvYY3UCiSKWjy6m2Gc/9ITWeExQnXSiBY7+jFekLRdB
 N2hSC4Z4jB6iuMPV3JEfXrO62FE0CHei0HU+HECmLgk68PLibN76xt7510VqcrLGaUs4Gk71Mz0
 33l7AoVdWzEksKw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F8ZuA8cX7ek44AWBJIaVL7SmVFE0GxwlXKXfO3jYYRu4xZHRQd2
 9ThpXw5s/Dke9C2gpxJA8YsxAr0utzHCLn8SbXwaMyPAJSLkcnY0PeCsp2FVhBO41EYS0Rk
 g+D9ZFhOBvYCcK95O/G8Asmn6czPBKPgkuLmjumxSOoY4oiEJrFrqkoTRdDxptSrnbhtLkH
 qTrdmmuHuOclDnPcxm1dQ==
UI-OutboundReport: notjunk:1;M01:P0:MeB2wVhqKAE=;yHx8wvasAKmU/ks2tFczvwjc6A7
 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
 yEjA5TSS5QkUL0dYc=
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


