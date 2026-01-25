Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57E4D72369
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 20:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk6ue-0006yG-HO; Sun, 25 Jan 2026 15:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6ud-0006xs-9w
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:47 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6ub-0006Cn-Qx
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769373643; x=1769978443; i=lukasstraub2@web.de;
 bh=le+nLiERzrnlm19tGPVw4LccaOtcc2jCGxhjGVm2kDI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=niE1Gs3ZZUC316b2iDiFi3HGsKhysopqBG22hQ0GMSvuR2LCtIWBY0/7RpGXHCgV
 oWBin8HPTPnlBWAzsA3FyTe0ANoX6E4IF23c/o2Ary6AjjfRvTKChTFqjWL8Dff9P
 xdmD2uQGYcHCagyzQOtqjrSv86BJxpRptZwJ55TuS/OAIofWEPBPuoqRRvshBYGzB
 XZqAzPbmqp8KF8qegXXA89HcG3TWbj1evBoPHzgYsXvhmisCGurilhEIVHTDKQNWe
 SAejoDJMvC1sVbU9tQVw8s7bBOEzqJXSZ36dUVI3WabObsbvvsU6TaMW7c4AU/3TA
 q0jtsrpMPfkq2XpgrQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7ux6-1vf8pt0e1q-00E38s; Sun, 25
 Jan 2026 21:40:43 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 25 Jan 2026 21:40:10 +0100
Subject: [PATCH v3 05/10] colo: Fix crash during device vmstate load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260125-colo_unit_test_multifd-v3-5-ae926ccd8eae@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=zWjKFO5Ycx7AzQX5X33F44lkl1z+MO7MkWEZu8sryXs=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpdn/F4YV4P63fSgHzeKK63BXPnYVzdxTUwrhDe
 0QVmWuOVpKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXZ/xQAKCRA1qwsonF2y
 WNfgD/sGCrU7h6S8w1bIa3JIT2/fM2oWUvVdI8My3XW/Ea7UJhmgWrsztADcB5CAxTJUDM1M1D3
 beXkN96gft0rf1EaXfeG1mpa7nvtwxNfuETzwqzvOsg4UevlJVXS8CQFA/HIGv/kjCTYOlp2Q3u
 P/E50be9IPJWv5liGzPx7iStckj7w6fyJRSN8ob0kD+Ltk7+tNHVS/Opyl6PNsI5/54boGLs0q+
 xU23RFdJNKCrk5kfVsRKZH7howXTqE26QDP58F0GnEiP4uS3dU+adRB+rGqr6+FSR1FiOCcrgvJ
 bBoCugGrUy0v5tgktS3wNFmWrGq0jqXfuiiTi27A4tMl9rlSGV0pxRZKKfxBZkDNUgxWHly1bre
 FzPkVx6vgQ4FoslgU6p9EiqgRjS9qXKuP66bDmuN9ezhbiV0wahZMiwpm/ldxTLW2na0LlxXPdS
 TzaARl0EscHjWrKJzFTMQp7juw+VZxOSYGORIlaWFFmhflCOK3cfEdMU6kTyLx98TrzwZGyITAx
 5qKU0qM4W9LsCsC9Daa9Ak752wWZtZAtMbht5QIYcevd3zdVQ1XI0G6xUj5csu0XYCA6tj3wiak
 /IMUFJ1+HTU6wATuOcL+ZvzZsL1Z0oqecnLp5v7IVgWLGO8KjzPdVSJjzqvI+003HQJWgUsAN3P
 bgBwghNr1YCCk3w==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:BsfnpUIO+Sks9HKwP6Cpg+/493WqXXkvHATuZD9UA/bZQNY+kD+
 bN7mo6A267lQnIDWCIfB2/5rs2muPy6XVFVGNAOFWEna0TfuPPzzBuGw8o/s0ILMA7MYguG
 XKsS+Kp0luVZrQ57z/4PyfOnX3KTwq7qVunQ5WVTM8Ve+FhU4ZjMB/rdd1kffp7twy76mwY
 5c+Nh4+LaF2d5LlbECMhw==
UI-OutboundReport: notjunk:1;M01:P0:m8TcFpZ/l9I=;iYSc0rktE9EJVrqBQWrHIuj+O8c
 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
 n4Vh26087ocM5/gWBwso
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/colo.c b/migration/colo.c
index db783f6fa77500386d923dd97e522883027e71d8..627b3706687036554eda3909b4=
194116a7640493 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -727,6 +727,7 @@ static void colo_incoming_process_checkpoint(Migration=
IncomingState *mis,
=20
     bql_lock();
     vmstate_loading =3D true;
+    qemu_system_reset(SHUTDOWN_CAUSE_SNAPSHOT_LOAD);
     colo_flush_ram_cache();
     ret =3D qemu_load_device_state(fb, errp);
     if (ret < 0) {

=2D-=20
2.39.5


