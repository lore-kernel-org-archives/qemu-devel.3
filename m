Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F286E9B359
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Q6-00018H-NE; Mon, 02 Mar 2026 05:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0O9-0006lu-AW
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:35 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0O3-0007Qx-UB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446814; x=1773051614; i=lukasstraub2@web.de;
 bh=YSxykUnLHj+SuX5ceNRivJWw7C8CFbfonhplWMaurEo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=uOVQd4NWeiW1eBjmhhggcxjJarRUuqGcPQLBAYK991IB2FkJOJJuOkgPUey/40eV
 /fOFuE0gYa6PXCMB6uXy7OwG08SsPf6arP9pVo9f3GzdQtH7cxkoVknn8ul03M2KL
 r1fwkH+IfS7ZOI8JiTR1aPVeJjO+gyptE+VP8hJolH/prs+c/yjmL/FDRDlKJ1esD
 zLoixIQNnGouPCQpY+tRnkOb/bempce6VPPB7mFhuHlQrUQ/nyyaLfJn3n53g0+EG
 uSrntMN+gybS0bvg7Lto5D1OHekpyUVBRJd1V4gidcUAkL7p4wtXF1HrOFUgxzivi
 U7RLRbm5AhBSluV+uQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq1CA-1vK54G1w7W-00flFu; Mon, 02
 Mar 2026 11:20:14 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 11/21] colo: Hold the BQL while sending ram state
Date: Mon,  2 Mar 2026 11:19:53 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-11-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RA7Q8b6eDwgtboLVRiR+7AHIKPUv7kjwK/dVBwC/CXE=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQpBoHMKPloPO05ULUynr5rZB2G2GbaslWaA
 THMec5j7vuJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKQAKCRA1qwsonF2y
 WHVkEACsR8/WqaQW9c0iPqiDKvyQOzNHC479wsw/MPb989UlX2KBMz+SSCAUOxOhgBWP9xrAv27
 WeQt1vcNVtx4e6OtUBb0+aSmcp2LxYfow8NjcX8rSicAbTjqkIsdAxJuzPXXyaIs7IyLt99HjgQ
 vU4BMXDkzICtvXOo9Q6D3pUv3W21oVmTje6sT+PD52pnBah/zdkQmZCoMwFdf9i52tSFO+XcxDY
 aCHxecbe/Udov1BFdOy8U+Y799mwRJwB3LqmcwealCTIgvcmbQrvZNcuOr1bT04+CLpmSDoanWc
 Jw4ZrwHcXbJApSKRj1XlDgmh7bk6RVbSDAxquj6XyF+QArDJO0UKEtkGCkb/mp8gFdMrb+b3+sW
 TZSgCoVlXKQ7VUTVEgwRb0y5/Un4oc4w42wzpuG7J9j/lwuvGjliVn9r0/a71dABKj1xAVV/Fev
 ockdpQC7+tGXy3KVDLpNnvKYEWfuALAEr972HQPslIbZc78wfoMO22qWtkIqi0lNBT90h0Avf3P
 6tyg+Y/D81a/nJdBbIonJHxH/SvF+N83L67WThmWH6LWoJPfAFhKaMVeAG1x+dzEqQhibWx6b/9
 LFWFp2ZIXQKMvDDM20SZSruBdZiAsAy5FuFWL/Wk6ZwuCAfzwNNPrCYKv9OiJZe97xAIB3FF8wD
 4kp1I2vC0sxcGcQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Agasw1vyUWtUQHFIEbCuFnXl11Cf6fgfiNAcKMWN2s9q9IFf6F
 Lhw7pjEjq8BjOHtpfhra5NxKmisaW/fJatNZaNX8Jl6hE6svoBaQmCksyRyJSoEmx5L4l0+
 D4AWZ2E5S/m6ZohaA1aIWOv/LucWw+2Zg7tYXsUed76pV5ILQSQO4GoS9GK72E6uNSyIMjy
 GIV4WZSokE28xOU8ot6Gw==
UI-OutboundReport: notjunk:1;M01:P0:ctQvuPz2wno=;YQYnRV7U8n+DD7wx8eEV6CS2SaC
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
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


