Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC797E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7H-00077n-4z; Wed, 18 Feb 2026 16:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7A-00076I-WA
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:45 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp78-000793-R1
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450180; x=1772054980; i=lukasstraub2@web.de;
 bh=q/mNNwnaGGa47jBNu/l/VsNCmpfLA9HBEoNXzcytdkc=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=phlR9fGhL/MerUL2IsLPcyNOk5wDgBvegW3JRXNC7XSNE9Sp85WLcKaRu6GSElTX
 WPqarW7XTVYA33EebinoYT3tDBfuyaf/eWYXYZ79hxhHcigPpHWlhgJo1oFvUnW25
 khNgU0gYiXUoaDfe9QYqNcLi+K/u/5Vk4wNfeyMLPWXVdLqyiM06dQUgeJn3GPr6v
 8qx4xfxX+Wkwlv6Ysz4TQYe+VJxi/Y4C/G5cZGbDElLkW0KR92Sln5wvmyW6B2Mca
 MMM1OXNapCupi7SmSJ14fFD8Cut4l6XrliFyXJ43FoGWrvG3RPq8KcIyFLve8d7Sa
 hIpG8vi1wjl690vqEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MALiZ-1w3VAV1scd-00A7qy; Wed, 18
 Feb 2026 22:29:40 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:30 +0100
Subject: [PATCH v9 10/19] colo: Fix crash during device vmstate load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-10-d8dbdb0ca6f6@web.de>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
In-Reply-To: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli89fUps5yKeIoBi9++7dECnUjkPqLuYkqjZB
 T6tyn1xdsCJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPQAKCRA1qwsonF2y
 WPRzD/0RNes+Msl5UW764o+eaSThQi8cKgFmA0tveS5rmsxIiVggv5/+LG1I0d4UWy79UYKxuQq
 3de7kkY9oKOQU3DsbSqtd20U6EsVB7y0Nw+fgsS5jCHpLqO2Fd6cyUH5jFGPYFgC9shKXE+iuuK
 q9ZjFzsNbo8Si7q3N06rTpYzkkmtNgHKSZk3esYfqYZKt3p4jqODoaCRg9P8xTaaKXzPt39l8m0
 421Mo4ELLYOJJ0etHlqGKSw/c7TErKCvPVD6okCL4Tf2jMBcrJG2JR2ZSurXIE3vE1coOn44Nyt
 Y+jsNYMF6rEHuIoG53RN9DkHhVzpSMLAgkwfXKeMy43zNwB9PFgIOEJ+cWpE/RN1+FGtUy8ruI+
 Uku1qsfxmAjuKkM2tVRQ8eTE9LWuBCF9P3Wl+Gw/JUtayFWGe3uxBaCTL+//lAkYrKlJv3rEcgm
 M2EFMXZF06PkQK9fvcmTbRrjt3snyovGFh2EGIBEeq6W0dwxoKNHeKoaD/kKo2UoWq2AOp9wBZ6
 yFrB+GXvNk/+WURm3vJV4j2KRSAezyrEAgvtx+iD2d+/rnTcYa4v3LfXa07yWJ+UnANK2eM24oC
 QPSziyFssR8jwlD4FFGQHz1rUhqrjbJ6AlfakQ4FZMEaUwI7cy0j8XvZOnxmXq7/Y/O6W/cYvn9
 /SqoUwjmtztYU9g==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:Ksa9PoqaQX1gqnikDJga90Q+PaJt5gDdLHL7vLGHjaFuofyQyBj
 WPbPvSv8vWEHiFsYTJ8Mx3RlB/uC1uxAat5r5VTYTBNUuwo51lo2XTekiGusoAXv1jlkVn0
 oC8oQ+GcY5MTH6vCvLZflZYEVp6ghUDajbpWDORnZkHLIq8Dcy7Mu2VfFQjxjaKkQUTmpJJ
 HLrZVGewZqAi8acs8hFgg==
UI-OutboundReport: notjunk:1;M01:P0:3v5rHVZx9kU=;vVhxZpVof2pD7rAltMa7eoaBX/6
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


