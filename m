Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B5CE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7V-0007EZ-ST; Wed, 18 Feb 2026 16:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7L-000795-QJ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:56 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7H-0007O0-FV
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450180; x=1772054980; i=lukasstraub2@web.de;
 bh=YSxykUnLHj+SuX5ceNRivJWw7C8CFbfonhplWMaurEo=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=UodtQ3TnNyz2NVX4wX7Sh1CdTFvAgEII6CWTOOYvWX5M+wbfRIXORYO2koi7UZWZ
 jpqlLkcknnLnVO92Yz5RdVkOwHm3rT3S7+ctXYR7A05AMGRDpxMNgD4XZxKbh7qee
 hkZzoAYqTbo2x0VUa052aQuAf2eVFeKyG4+y+qho+OoutwgGtKqqJTwbn9hML/31r
 lkqm8ckhXe5HChleP22tss1g2t50V1WWtP8VrXzeLbGc6l13vktfkzTkwPnkjwjxv
 wP/6OsJb4PpsWSxjARLNLXV9/YGkVWrFVjKnz+fkEiATKH5pLBWmUATBRvPMcxshO
 m2YJ71huTmWr57hR8g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPrPT-1w5pWp36Q7-00PTwW; Wed, 18
 Feb 2026 22:29:40 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:31 +0100
Subject: [PATCH v9 11/19] colo: Hold the BQL while sending ram state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-11-d8dbdb0ca6f6@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RA7Q8b6eDwgtboLVRiR+7AHIKPUv7kjwK/dVBwC/CXE=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli89kqSzfu0OlO62PvqrFfFPLP+ZUKq21CEhr
 PYT/OYs58mJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPQAKCRA1qwsonF2y
 WNSXEAC2BdjOxcdmcWTFUa6oSZKREkZhXN/BfD91jG0a12fvQgp/lPp8NcDJBRzsg/UOsSX8aMB
 CG9IHxKhb9g25h9C70X2TrI+ExtHR9pPETHIZ9Csenhua/70iqMEgsLmabUOh0m/if97AAmaLmU
 lea5p9obYKRksJzuxWPx3CgLvzVNNKP1mvjULiB1pKWwMHjd5KaflKsF+Z97Rw4kMJtf2hPiHGa
 1mBxAqz36+d1+RpIk4IeSiUW7J53zl8F0o1sxPPNdUfCJ9anybhcGvhxOOimNyMjT2DFVOrq1dm
 VjYQ8Ydqwk2x1h0ydzNUXZ21iPPn7st4Hu2ltnxDNaXZnQbnYQ5RBEvPpBuo08/M6VRV1kDvRKF
 CLJcj2D8AhfD2ispPIIEe/mW6SL1hPneXNyBYeQ4OCe+IS+cl9s31M4r2BWvwYwYfhhL6CYat+W
 /143BnEqUWHCkyBI0jiveJviZWFxOCrkezXzx+XFCPo6l9+4bEpLdWwUaJcPgmeDaR3TArM1hs3
 +mF5A2zOUyVOLh5nbmjsQt/6MGNl6AjPNwGLIh2+PQT+38PPpk1NzyVtY3Enyd73jUInCv5NQKh
 fQnI6XcyUrStQX7Rbk4r95Cr3de9eAkdpDKlbhLTAVkkOIqnowUFJBYhiK+tf8pCO2FFZhZ8Exc
 s8kTPqMazCgnhtw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:4ZwjbLRLTdPERLUmL8Ef6iDNZD/zQPNmkMHl3ihS/hiQRmxZUxn
 UjsnCfVQmd2hM1OjSkdqhkQyrNns50ONHE4Z9ljtygJ3enCiOPAP/hXjSB0oDceXxKkvkWc
 JoGgywg3yCixcniz0g3ZBXRBQyxaI02eOqKctMA3gjtkb9BXj7vtM8jrzaRME/GZaojEtUE
 SuE1rlmECjR8Sfse95ung==
UI-OutboundReport: notjunk:1;M01:P0:ITJVklMEiZU=;oBnn6ArMS4GwWz1mq1eI/zH1Ftq
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


