Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03490E9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7f-0007Ho-MW; Wed, 18 Feb 2026 16:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7X-0007FX-AG
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:30:08 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7V-0007Og-Ih
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450179; x=1772054979; i=lukasstraub2@web.de;
 bh=1ICvXz617I/huIhIVtPmcg6MlmFeXbl2B7uO1sTyTmw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=FmAscWAVwgMeWu5+mawmLEDut+gIdc5JXKSC0TiU5yerTEuUdeRbgr1X4iuV2vBY
 cnerIn/hSrGECG6isaStjyUNT36rB0JvXGZ2S1cockzlpkIAQ4ZgUz8QGyko7dby0
 grny4WmlKsOcFW7MXrhdOSvg2YMthrKCLrcU0TNvux5lm4c1KnL9W1/qC7MUVeCIX
 KNtxeC/vio8ght/qv4vDCFJUOkyLY+H5hZ84kSbaBYzjTidjPyrFFvMCdIL4b0gqN
 NS+CUjK1/yUkOUhFD6HbqiTj7fJLeO41/Bh2fla0KMmjBr+H8B11wQ7vh2i9eFv9z
 ijHPAkabyC3n8QfBrg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwJO-1vI6ib2DME-00bo5t; Wed, 18
 Feb 2026 22:29:39 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:27 +0100
Subject: [PATCH v9 07/19] multifd: Move ram state receive into
 multifd_ram_state_recv()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-7-d8dbdb0ca6f6@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=98xoBBDImdpaajW7ylxF0FElE0Zr54AC89SoX41cbBc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli88QG4xH9qLhiJ6ka6pqtO4aEVCK+LL9xnoR
 6mjCg+C+D2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPAAKCRA1qwsonF2y
 WAjgD/0T/sWsyrlSA/rvyYESpiR0ZmiAd/WdFyfAPmZH7b9hSqe/bqC9m1FzRwbHZXRxho8ZsP/
 7FOq3Ms3hXjcxjt+Hcd32lsWblGg8Pocxz0KHgRQzXlhsB0c2O3p8noOXmlk3od1QWAWTNoqbNM
 xhhNUkuUPKgrgLZ36oeQ/vFqSitSIJhmDMi+7CMwj7ZoPZgZGYVdZ/0zXTjAiTjFcugICM63Yo2
 jK9DLnYbo89JgisiazArpb8+M+H0iiAuC/kTSiV2TlpfKAAecHWc/1G3n5WfP+0b2N6O+QnwOa2
 qbvyN+L2ODMcR8Uk7+NEKJfbyFqgfSJQeJzQz1bEC7MUPUVYWJU5c3XuHe+tsPtvp1Qt/6VOj1S
 4BQ79J8BK4teFOft6H/kMiyfCIT72mZuHgscoXj0WBtsySZ5FdOqGekDFTQw7Sis1TRIL3immBU
 cjamh0QLW0YpjV+Qc05zlCtJq02983P84IgN4zGd4HtB+tEOZ8OgJVE0Mx4wMplXMs5FyIexXrd
 ajzj8FALoxhDQVzTCl6O1wAoAPsA/EeiTgGegXCQj/vN/WW0nogPEV/EiC+gP43B8EUuHH9H+rc
 ZFvwHokLqqkO9GojiQdrzXFpe6lmr81KFqDSJLKgLhZuv44tIyl1YcaqGeWSdxnUb1oCtTeVfPI
 1JeDyOXXXnsDvOg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:sFWGcL5aXM1qIz4kGuuy0xWpIwgq3HfChS17c9Tcjw35im6o4K6
 d4X7+6jAhBOGeuk9Zh9Ru/ByiTNuLrmFcs2sbURPoIkVf9wEtLLC5II/NyQyT7yOO66P7yb
 8IBCqdZKah82wOhNrnlCi0hlYZvC70ASoUyGjBI20b9LwLF5bkZJ6e2au2t8ddXFQ2ijO85
 JTgL5GCJS0MoCFFVTNLGg==
UI-OutboundReport: notjunk:1;M01:P0:vsrO8XkCd2Y=;Bvp4x1GWlugR68wAya0vtyAgMjy
 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
 9ymnOwng=
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

This is in preparation for the next patch.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/multifd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ad6261688fdf98a5c7f4ee9fb80ba2901201a33e..332e6fc58053462419f3171f6c=
320ac37648ef7b 100644
=2D-- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1253,6 +1253,15 @@ static int multifd_device_state_recv(MultiFDRecvPar=
ams *p, Error **errp)
     return ret;
 }
=20
+static int multifd_ram_state_recv(MultiFDRecvParams *p, Error **errp)
+{
+    int ret;
+
+    ret =3D multifd_recv_state->ops->recv(p, errp);
+
+    return ret;
+}
+
 static void *multifd_recv_thread(void *opaque)
 {
     MigrationState *s =3D migrate_get_current();
@@ -1387,7 +1396,7 @@ static void *multifd_recv_thread(void *opaque)
                 assert(use_packets);
                 ret =3D multifd_device_state_recv(p, &local_err);
             } else {
-                ret =3D multifd_recv_state->ops->recv(p, &local_err);
+                ret =3D multifd_ram_state_recv(p, &local_err);
             }
             if (ret !=3D 0) {
                 break;

=2D-=20
2.39.5


