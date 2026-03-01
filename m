Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A3CFD007D
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoUL-0004Cy-1A; Sun, 01 Mar 2026 16:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoUE-0004Bh-Jn
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:38:03 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoUC-00044D-50
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401063; x=1773005863; i=lukasstraub2@web.de;
 bh=1ICvXz617I/huIhIVtPmcg6MlmFeXbl2B7uO1sTyTmw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=k11KbmRVDj2Io3LMFghtIcj8PVtqMlEiDKE8HrVzkzevFpXZlVDEpzCpMSjPltv/
 U/uUeo/BJGwcRdD5YEep13KTz8uNIZORSdl4gO3/G8Ch02Tj6YrGd+tAGYwETE8/Z
 KIbKbwkKmT4VMPIMdqyiHnBtWtgkgg5uaYkRWyYUwK8+EPnI5BHkfbB/ZNq6KtpFR
 7Em1xPrWTEFhhvSUMeBpbXY8F2XuaBrNl6fTzLxqnU+IInGXXr05DBgB8LwWQmM4h
 j7EZJR+MbJJgV5vDyyPQ1W4jiiOFSbvevIVzimMejJvHPK494Zr1fSSqZCPaIYxsI
 01rK6YyQBRRWrA0KZw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKdHC-1wFat1121E-00PmTs; Sun, 01
 Mar 2026 22:37:43 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:27 +0100
Subject: [PATCH v11 07/21] multifd: Move ram state receive into
 multifd_ram_state_recv()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-7-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGhVLDXHy5iObuZzP7DZ+XkxBm4c3nuldh+/
 SGwHgKAu0uJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxoQAKCRA1qwsonF2y
 WO+yD/0R3cnbULAQndHICSWhjIe6EUBoGpttkyUwEzzaSWYirskUnTyrFTmxRG968RHfMNKluan
 2iXJaj76RlZBef9RQ3DCzSPcWPybcvgibODooqbkNEetIkM5dVOrpSg7jtnWMZhNGIsp0bmkAWL
 hNXufXicmhg6G3I1ztZDMV1CEFuwhI2xfGvQQI98ucTVNxPhjViZ197N1I+sN3seibYMcr/quH8
 S9Mibgox821tNk3Y/dwcCbzkKJrVw9mBISe7PVzz1hRtnzt7f9IaMjGHGt+FpS0KZHEVzTnZs+2
 cSHBK+8U0CmAcJRVs66BeFbDlF+qnWRU9UAkiNcffe1N2YTS2BXJ85ccF7dO1TIAr1t4VYMtoal
 o9w2M9wBCSkGj2RjUP8eIAlLt3BcCfryzpEUrlEqBrLAQhVM205cfWqjmBGNgU0NHeFRhuUHog7
 /wxzvL12QPgB8tWVKEsHxDcf+xdPXSupQPdIDLKFskLrbotMDLIRyX2RfUYNGUFPJkraqSVGomi
 nC1h60dclQfFhUER3GQ+8Z9GMaRI6FsLkBk5Seswe6ijEOU3qO+ndkKmW7pfxgyeGG3HMuMkhBJ
 dwhX/1PXHDva2Ake9kXdPBWZo4YYFDknLEjBJEX42loy3FjJNn7NN3FLPyWd87x2I1GS23rLMnA
 F0S7rLTwBwHsP/w==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:07KewsnGpPgxp05mf/FC6mOxbQI6ptFcAOeJXZnjLo6QuwP+f3x
 8XfTa24UqRUbAFl5cBbKwqJE4sLM/vE1jiG24gXsO3bon7KCgvEafbvCAqhJn/QI/IRX17/
 xLAcZGNI+Ei/iP/jNaooiDKHhEX0lbN00lBEYZiPq3CacTwu4VENMf0don9UFM5zPegBZ9/
 BkEOUf0t75BSoiZtiPPVg==
UI-OutboundReport: notjunk:1;M01:P0:qeLBs/XyBIo=;r3ouoW0CNtr5i1NNbUrqmwKksEE
 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
 Cdm1cCFt62jEQ6xFpDfs0pN2ae8KD
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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


