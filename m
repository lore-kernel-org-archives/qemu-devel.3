Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E137AEB26E0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWU-0000ig-GF; Tue, 10 Feb 2026 11:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWR-0000hJ-FO
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:31 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWO-0006wu-Qi
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740604; x=1771345404; i=lukasstraub2@web.de;
 bh=jJiGbc0HKecovNYE7s40yC6PTgehIGA26Ay31XHpXjE=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MooBmOjGYtQfvEqbm/v2YcH7mznI4S72Ikw+jPpBCA2UyBptVD5w8wopwWjWnFMX
 b7SKP3CF9aK7OGuMhCg+hLQZhLIkdgzEn92xrSzK/wqV4H0SMd8o6R/Rz3rFwhfCE
 q5YGaqbLGifzCZ1r+3got+QhWlV1Q0MCAQv9tXzdza+fv8NB8DrY0S68et5X0gPxx
 OaZ/H6vX9Ak3L4CoQEbdOGE8srzihF0a0LpYtE8O4zXX5xLctPLaK+06vMXjNZ7Q/
 v61HUCNriRidRCaOWeOZyhiBst1yXBieQXMx9Q++tWBU+rT23YH0NGhZw02l+E7d3
 9uDTmkoYJxJC19nqWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDMR-1vH3vv1B5j-00bGOW; Tue, 10
 Feb 2026 17:23:24 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:08 +0100
Subject: [PATCH v8 10/17] colo: Fix crash during device vmstate load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-10-7f9e5f7d082b@web.de>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t3myYUAOwYYjbkbANcYKR6IUQO0oRtSmijd
 FPMJXHxK6mJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbdwAKCRA1qwsonF2y
 WNKYEAC6RTLUYGKX5L8SpVZjgKahsNoFSin4cQpcMuVnB9G7W7Tpj8nDRpFxNMGfp2AfxhcwA3t
 BpMniqbwdDU+OP5afJ5twm5/lt668VZ9kWRBalloM+0b6qaWHkI65KCZyC9IJnGcMrWEl517G1A
 CytGQkC5VloZ1mF3lfxNf/LEAwDDMljLclYkIAMJJBLzvKT23CqE1cf8ATLwA1h97hvDcreGUiJ
 jmcdpK2UzRps9oiHcvC2prP+jrwtCdR5eBrTnBNRgGLeP/7ETCIoi8vMBXeJJaPG83nfZIttiPJ
 eyBpzjqtYMLbCMVZ+PSejnpPVk86vvhBUutd61Z7sekcUGb1u2CMrLfx7SxYuzM27OY9HcGrpue
 7a0fQ16t003hKJxIzqZZk7RI6SYjMqxeBA7EFSJmuwLGeg8iGSdm2chr7JQkfL34WXmR+Y+foAh
 xYLfUimOxgsXoCFqeaADe2Im+XNrk6BPvdM4I87if4DZG8+/iugL6qXhy48e07EtO7CGT9nMXEh
 IJvwi6iJPViOjoCr8tQeBBMDjSPKxy+2TVKopprXPheoMFwfSyaB5JNwJm0HVR/sC6ew5QRrt0q
 D5BtaYHCM+b2Dfl5dN4xhAjb3ETfdDWDKIhxvKN3ebKAYpAyyqmRuLVQ02ptqhtO6Y+JQPI3QOM
 keRAib6JN2dvAMg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:H9HcH0gp4Wb+Q/5kNTxloR+8Q2LZ3apacoaf3hV//ao2LiWKuRt
 IXLVP9Q8YOh2//flqnsH0cRRCBREVgf3RUKG40psCW2MWXzHQjud6e7dAElhQ5ZaqE1vwGJ
 nIyaPJfm0Jovk74D/HsbRZh1PLdkE9mCEwKfyIlomIexwH9SQ3ZCGzfnXoTqz7sNjM8Vd5U
 rLe7eb1Mq5Y9fFomojolw==
UI-OutboundReport: notjunk:1;M01:P0:K9vctchckyc=;L4xgX0IssOWVRIVqaYVopZBU6dh
 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
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


