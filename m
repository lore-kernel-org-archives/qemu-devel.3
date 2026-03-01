Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D24FD0047
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmID-0001US-3h; Sun, 01 Mar 2026 14:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHt-0001BR-Fw
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:10 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHo-0003XZ-Cn
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392612; x=1772997412; i=lukasstraub2@web.de;
 bh=q/mNNwnaGGa47jBNu/l/VsNCmpfLA9HBEoNXzcytdkc=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=tXbAPwK6sqMdLkx6CjE3kAI/tlSfd0Iz+JWjjQpFqxVbgbrccSnvxvDM+m5BAeCt
 7/qrf7/xJ3rPnbcNavJJyMOvG2JBmp9/XrZkIIHIxcnEL8ukr+29QtsmJBR/SYpcp
 xuYFPa3/soq1d3qzaJraJTlQZMWYC+C9pPK834QxNTbDqi+frjyYID++SL7H1UDJY
 wB6dM4TqWlumst2sJPE3xAun0Tok6ZmqsOjWrTcdJv2xOx2HxWxtlo/v4d2s0Ad09
 Gx2DgDjX09BUzSJUs3M5WG2oEAOr139unUCg+lgChAS7sY9ceARWjfP1HeOPdQ6Fk
 rI6dzMMzxigSpwqC0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MECGl-1vnC1h0QiL-00EU91; Sun, 01
 Mar 2026 20:16:52 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:35 +0100
Subject: [PATCH v11 10/21] colo: Fix crash during device vmstate load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-10-a9701e795d7a@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Jo9ygbD9kqkeUyQ0JD+anPkAvVD/vEUQ7S+iY6iqDJE=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCdha/1Vh5RDDUSVN9tFIOpprsr4w5xEgx0p
 0lwRdYcn6yJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnQAKCRA1qwsonF2y
 WJP/D/0TqR/SNrA8s3hSd1H7GIacKtdFGpDK91BG9rP9XDysplU8/qXK/liUsrHG+vSSe2dalb1
 oX3md3CEk5z7HlrMaEWngEPvlHgbX+2ASdmdnYvn6FPEbX6ibW9G+RdjYFHo6rSZxatwFN8MlvX
 XOoXaLhHX1U2HGFSbdWa+Hwdh3Fssjhc5x34KG8lh/HDj/AbJS+Z18mfzPU2LQzrrTnc/EH7a8p
 zjLOnSh5oxe1u1besarCTf5LFlfmPombTtX0L68Wf8kSfdG054S5X2Kwg3b1E+JyCXMsUV0Kk+K
 dx2IDe/q5aFSnAJ8YyCigcuISYq2eC5aYjQjbD//uve5tnMT+129xPtUQNJTscYe1Wd+44G/xYX
 8VL+seavcf67Xquw+f/01VNd4s/kXUOeqZH0R9B/UUiXbOCFepVTQCG3FgqgQimAI+SlCY31Gb/
 c0G3/agce3H2RHzyo9GzIEYEaFnx9FgIaA3YhJAXHMnF2iza15bFWpso2l5oR8Y40sSOhwWnnuy
 I2slF5m2hMvk9pAthm3pWF6u2pT3N8spk6fr5Ao25rZq3nS76bHaV84pUXEKtU0pXRU48/WU8xI
 QDIrLKKNP3QFfFozOyP/clnv77CJa1s5xXo1C0zzC1021ciuUSJkSLI4qJS8YoqPNAibdXpcKPp
 gmdGnkKA1H2lXEQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:nWcDkWNJryzs4yIUmEDYbZC9ulgTW4Buc53xWqPI4VisC0BSo8E
 CKGwBxu0kTxT8CdHXuyKVN5jZVhIIHPVT9hO7MtloQir84Z5uWfcXBjyxtDZwPJppVMRr1I
 feahSodsS03LmwfpKKn4LKkyy68M0egz5/CcztBoGvecdX8lsPYLYFR88ywHUbRGeuCYAps
 sps2IgwghYhZqlCkv/o9g==
UI-OutboundReport: notjunk:1;M01:P0:mT1Rf1k1f3Q=;juPtzgKSXHdm861iLzMB7ZnkMKp
 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
 moGZr5pPI8jcSw1x3i+6+3s7tRLlO
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


