Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08448EA8121
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohl-0005Em-SE; Tue, 10 Feb 2026 09:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohb-00058i-Gv
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:55 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpoha-0005lg-2D
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733601; x=1771338401; i=lukasstraub2@web.de;
 bh=jJiGbc0HKecovNYE7s40yC6PTgehIGA26Ay31XHpXjE=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=vq69A8XYvGxDjeK/upxXQKuiJTb09t4WftSRDwtmUFroVCkIAR69yimY6ubq+chg
 xZvWHSGB6LaF/Vz33uSoePJ3s0ztiKsRk+b4/DLWXWEQEvaXps1ilwTdLF+1WM9YR
 Yo1LzA7O+rfDvOoJHKty7LUKKxwbWBlhC7dB4bYseBLB+ggS3wvlW7RAGk8yog0oo
 F9F38lGw5pXkViwWAspCHFdk2VkxHzuBklAa3UaR9eBwUMtaM8MPy7RENUI3xeD/7
 hoIsBjHAcmadx3FkG7QLEZjtuy4gMDTQDjrfrD8vhXlG00ujCVrFz7DF3F2N1zaXc
 UOrBKUWR18HYkIXRWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M43GO-1vpohN24vo-00CMU2; Tue, 10
 Feb 2026 15:26:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:23 +0100
Subject: [PATCH v7 11/18] colo: Fix crash during device vmstate load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-11-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0AcGu1E99r/kiRx/aKgZkzmwDppRjQTSzEUt
 gJP4MuZ4VCJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAHAAKCRA1qwsonF2y
 WAahD/9ypoBco46DSe6exUkmRW+BueSBfF+wdwF0b1DZopOM8jNG6D0cwskFMLY9Zl8RhSy+vub
 quMAD8QHL2fYf57qX9YgKchJ5tYFHz0X4XIXMeKZKbXMhfJf7M6043j948HmIDk/JJcf8nyXCTN
 jqWpTL6c82oWQyxXA9YcyU5KdvvG5cOUC0hRdyD35DLgLzUPiATqpKqqcIw5qoxxxTb2j2zcbn8
 Eq1d+TgKJzJTp9Bnc7BdGPcaQbeLHXpeWNDwxYEcdnj0C3wN5VM1+QQhvqzmWPvTxT9pbkg2uCx
 MWpDeDqYSlEt8xXcq0zAr2W6fNwhUKeNogCJ10Ph/HUDrFfH1omXqYV1bocPVyfvk9zivFbO6sE
 4R4uYLmW4cN69DMPkIVZ6H+IPkKBxHhpWBlnqmObO726jWlotGjK6plT4qSOk5dU4wK0IKrzsz4
 Ti+tsa52Q1Rg9HjkT7/Yru/S65LGuteHJQoEc7afKzDgjmwNv6AUKPVNFreSL2CQiarSkrGTM6x
 Jd+6x1IVfXHKX9HY1ZzcST3J2os8aV8/8k0hDy1ZKYfSiVuef9vYPLe6D9GeVK//ziuVaRPL2k0
 bFw7JHDehx97Mu0DKz2B+JyD9IBqS7abBt7nJAchuvaqZS5HqiQBHyfhqseah4MQclgySk8C0i2
 gQhEmWEQncSSy8Q==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:/UdQRJ94NvUW2o62F5AA9/yvVJ4AvffNyfNVWYA1hlOf7xFdAs7
 GjFEvMpL8xSX4K2DPfyJ7U+7b7UfG4qlg8bAes/oKPLbbFEoiioVWm8heflXjuSUTsBakHX
 S4XCyJSEAnfxTCORl30mTqqPXf2ukYjh9Dh9QV+D1hZdIhTgpcifJnWkefvni30Xqz8vqnY
 Org7YJrmC6zPSM0/fm8fg==
UI-OutboundReport: notjunk:1;M01:P0:chYi8XwG4x8=;jS41T1cNpxvYzARVS1PlgJIevC4
 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
 3H0dmoiRM+u+Dlq+m7fJ
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


