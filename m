Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303F7C5AE49
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXh-0000UY-92; Fri, 20 Feb 2026 14:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXc-0000SI-T1
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:56 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXb-0001QU-1u
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617110; x=1772221910; i=lukasstraub2@web.de;
 bh=YSxykUnLHj+SuX5ceNRivJWw7C8CFbfonhplWMaurEo=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=regRXqGaruUOr79fWRzDSmktwyBU5J7FgnvtQGIqGvc/4f+5tp4MOmhZSunE6PjA
 uE8Kp6fsPgA6V5T7YUilDMJgrcbPJTA8DIBxCus1wIo2N0teteH8+0cDuXVOl9fwh
 Ct3q4P0UCKBKC2EHofcnXWBeA1jeIgV3ZIQtB2xUjmkrzSR5RG1ooWoSr3fUkVCTR
 e5KxFIa4wWnngMIli0xwqU3JDcqF01qJFOpX6cbw/UlsjUyyK6Z0ri5R85RHhvB7B
 QwOUbO6QJ50bkAfY49oCs1krAov/cYswL5Tmjd9PjFdfI2R0EJYQ6etPWH2yaozE4
 Tpml8UU/+lgd9mFlVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtPre-1vbIfQ0tnK-00r7vK; Fri, 20
 Feb 2026 20:51:50 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:33 +0100
Subject: [PATCH v10 11/19] colo: Hold the BQL while sending ram state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-11-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RA7Q8b6eDwgtboLVRiR+7AHIKPUv7kjwK/dVBwC/CXE=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtOvYjjpYmlxWh+FlSdi2Je/Kqe9cyv8FgRW
 zHxhEn5vkiJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TgAKCRA1qwsonF2y
 WEcPEACUhFI7q10DMQ70Skb3OfSolcG5HRkYEI0022aJhUD72pxt6C8/oX1P5ZAlPICtg8Ri6UY
 xkN6F0YiMckoAUM6D3FhPdjQdYiBAkkHhbFLwKZs/8YwgZs/gITO4gU2CrnkJ9xK/SWBfWp+FE/
 p87zKyXy0kWGJFenCDTx5wTFEHQw3Hv6y5SknNrQt04XCgLD/1Jg7MrDElgeLlZkZ7FvikWqWjP
 ZmBW3V+E2ES8BV4lBZLC4sZ6byxpkcJAQZtFkM0hR+4QpMICrLlA3xPFcOvDEyYJmwwSzhi4MWm
 AZDXBXYVSSZ+PRMD+QKIKXsIkdVZNN8irlaRNs6vAuIf2zLMB/nKBmCvyqyf51nHDZLwjaoMrcD
 fPoq9GXD6ksiyrrTlsiNCkJfWoR/EbgVg0afy8VXC7GNgHhkQhIZGhf3hSbbwxFgWRfRTLPuDzW
 XlOvIW7hQjBWiWmzboA6Yl1v8VQQwnn2Veh9wWFVNS66W38P1N6YtBT4cR0fm3LACJI09rKV91A
 +izYzJOMHMgWgOLy4n5QsSKe/ot8YNuvl9Wc7rFnH4zH27sjaN8D34pQt3zSPjNz9wpHKStIusi
 6KgK/0LEaMzbRG1iYXTpCZ4bLuDMUgU6sHYKF1U92LVgvtwhfGDNN6Lpn0I+2W7MJ+7bmQqQLc2
 OZ4ygnUNlDcVLfg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:OACjv1tRceKRRxAVH5powvHG+6JM4BW1xWgSEdmwPPyugHmeJyv
 lvp7ayuPdConF91yfw8MAwG/Gk0KNsinJeI4iGzsmAxAP65GxyuBa39q8n0TYzJ0/ONADS1
 w7vbMHBFNylf6sceYSzDYcMV5s3Rny0Y7xLvUc4VQ/HxPco6DD318jgfyBCsBjs7n7uMsxx
 00N20JdRVQanYeEv8R7YQ==
UI-OutboundReport: notjunk:1;M01:P0:SQa0JcU8vOA=;3AkX1BXr1RN3jNSjo5l+3yB/f1m
 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
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


