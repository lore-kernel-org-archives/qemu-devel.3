Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE0FE6BF06
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOe-0002lm-Ee; Fri, 30 Jan 2026 07:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOc-0002I3-DF
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:42 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOa-0001rd-NB
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775275; x=1770380075; i=lukasstraub2@web.de;
 bh=N3Vz8noecY5nAN6aNnQbREG8egUKFX5z4+n9xRV/zCo=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=nJBL1nI4uXmtCm3cC7/m3M58vjworGftt8P3TrgcK5lH8U1qtM0WVtzLO5nT5RNn
 fj8gw+Cl1O3HOXOJzXL9FeS/1ytc7UnGqdnlrakVdeZhxW74l+mKGQ5BHt/r3QpKo
 oBaB8yUn1dSlrb5Nfdvquv5poiRWnTWf7i9KxngBXS2tbA2moZEsoPBkBZwBBic4Q
 al9FXhaKPr3lGUpxiD0Rk174W0XwS/yZWZ6Tkjj4A5styByb7nsTS3aUbOOWNBBbf
 kFcRhXB9ABJWsfN3HlbzLMD703NTEqK+CSOH2ewNdn0VXscjM1vKvWnY7/FsDiwlf
 yT1lpqj7TRbS9076eg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1u6d-1vsZnO2moT-00tF57; Fri, 30
 Jan 2026 13:14:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:15 +0100
Subject: [PATCH v4 07/16] ram: Remove colo special-casing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-7-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
In-Reply-To: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=XFA0vOxAvfwCtCIjXiUoHlgajMWqeC0ZWy432zuy6tY=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKCltsI5qyIJYpAvVP5VRO3E+uNMfu8gzw+p3
 ES+H1T8cXyJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpQAKCRA1qwsonF2y
 WGV9D/9Yk/Ezv25drmM4yFlEMXTl3T/OXJj884mnvEO0zkut9OtTlY4CCG+vU+Y2hQMEPlhXEYn
 PTGKocAkEobq+NV/eLErrAznkuKD1iZ32m5yI5jrOAqwZbY5wwqg6NRAoxRf7TFjmGgpJc3p3eL
 qVEAuADx3ZzqX0vHkB1Tl222Ir0WeKDPm2zvUCgaQEO2o0MClty4qiFLADMNtxk144VFmkgdAoS
 N1tfkV2OmYbuNzcw2eOPwAMJqzGLLK6HRl3/zTfIHgJ0u2qdgt7/uQ7A/dghNndYWieNeqNPnjc
 VAVI11KTa3a7+M4KQ49nJmXPDT8s6E5MwoLLMbIr+He05Qy3zgd+MV9qrYuyHbjsPt96wDJcZcd
 dPZYVxaPRrncNlKNVLXZj1ZQiEWYtqx1kA1kGk2v8GNUXH5iPHNEqpC0BivM6ZSarZjzfZZXGgK
 j40eqypw8vcu8ND5CPCcqKdExEcap1SpD1Ox+NsTNZOqUsh2vZaA1mnI3Lvuia6sgkLx7jyj5SA
 hCR7q2Ly1sP0yAg0Kj8ycLqXkgtLKA3wQ9/IVCh0CI4h8jRfoZxau7u7I8xe0RqV5nUuarP65BN
 X+L/an9R5a25WzN7058QzOhsWJT5S3FEcZRGakN9E4Iz/bo6AWDbgWvFT5VuZ25ebIlmpJnD+NY
 EbIT4Nl/iPBVXjA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:TU2W2rz/ILoDy+RSQacMO8ilOupwDrs+vg8v7oFoIx7e657n8Fr
 fmpAMbBaL1y7Tfj9hbnD9AVyUSIPDNfuE8qCKcqO0fzLzGE9uNfeHinkphrTPqcJkrLSQMn
 u+JZV5SadgfJuA4xXX8WwIl7ldpbDdv40ruUl4JFe/sFlbTyqP01f8eScB+hqEHMRXz4HaL
 aMRdXYDHlF1EkjqoJwn+w==
UI-OutboundReport: notjunk:1;M01:P0:qk7fYpWcwZE=;DM4KKGyTB4xOQv3M6MbXbFgJahp
 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
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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

We only enter colo state after the precopy migration is finished
so this if is always taken.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index aebf77aa0b861e00516d6f1090aebefdd0d97e54..979751f61b30d6c4b878866b50=
11507e7c519176 100644
=2D-- a/migration/ram.c
+++ b/migration/ram.c
@@ -3116,12 +3116,12 @@ static int ram_save_setup(QEMUFile *f, void *opaqu=
e, Error **errp)
     RAMBlock *block;
     int ret, max_hg_page_size;
=20
-    /* migration has already setup the bitmap, reuse it. */
-    if (!migration_in_colo_state()) {
-        if (ram_init_all(rsp, errp) !=3D 0) {
-            return -1;
-        }
+    assert(!migration_in_colo_state());
+
+    if (ram_init_all(rsp, errp) !=3D 0) {
+        return -1;
     }
+
     (*rsp)->pss[RAM_CHANNEL_PRECOPY].pss_channel =3D f;
=20
     /*

=2D-=20
2.39.5


