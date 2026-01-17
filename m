Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAF4C98327
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 14:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh700-0007Xl-DQ; Sat, 17 Jan 2026 09:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zj-0007VL-F8
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:42 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zh-0002T9-GT
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768658975; x=1769263775; i=lukasstraub2@web.de;
 bh=FpNK1t9Pyzk1GtTohgZn5ss6d9KC39cjvTauvs/5kOI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=wUR+pTzywHjqJxjFVbwJldAIOss/n1mhlCxupNlzl76d8mvbp/vVPnNWfkBicX2a
 G0cb7zaUqkOBEICxpGVuF7oU4/nPHGp5A8utxYk54ffVzyA448/QIV//jJozKRxLv
 uATEC+uvvyw2UIFZYZ0NWTfl7yNPrpSTovKOTBgv2ZI38kPDAIuah8fd6Q1PsgS7o
 O5k1jkUS3TibqyiKsgOfqnM+NzPq6+BMHnXBfoEqaHzmYv066qVJb1ooSiq/UwHPx
 wXbnyCXqZz5t9PJT1Xd6F0nGJJiOXtx53oDnnH+//ERxcnbPj+ermlG/+cSeoL03Q
 sQLh0WDZtxBx9gKDeA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.100.70]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk4e-1vE3pF0BLe-00NYpm; Sat, 17
 Jan 2026 15:09:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sat, 17 Jan 2026 15:09:10 +0100
Subject: [PATCH v2 3/8] Move ram state receive into
 multifd_ram_state_recv()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260117-colo_unit_test_multifd-v2-3-ab521777fa51@web.de>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
In-Reply-To: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=Mj50C/e2pQMojt6scYosf/diMLC11NkCGVS67VKjm9I=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpa5gbUXN31RjqMKFrDbp3jgddmc0ZTlIFvCndw
 42kWkm0SviJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaWuYGwAKCRA1qwsonF2y
 WLHOEACb+8C4tcE8zoKp2r66yHy2skPsRyb2PgiBQuM5PSSWUZYdjmQ+FYfaFjE+mY/Qr1320j0
 CVM0/sNsVVfUozEiez7tLle5SnJps5aUuMrvR97/HStxxHvsxuEJMbwm1Tpy87IN9LIZXhBbGh8
 en/IlfLZOEFecFyAhADLQ93rxacAm5BYQjnT1ZNg8ulEGoKjO0JwjsXZ0wPATmxTx4Zn/ka33A9
 6EBE4I4c2GQoL7L2M3EYux9gmmAJuXYd62Woo0WmyQAckHDfPhmmo1/Sm5quuEKr8WBHUXQID0k
 fye8knUtA+teP+EAVCDFLwCQ8XkBPkBFK5mw9X3b2DWOKUTgc2SKsZdwk/Nm4s4d08ZNTuWOFli
 I+QjBQf1ar68vz2yOSkNHYKsiAetpzUANrvO08pfwfrqhU7VWpgBc0HfbZZ6mHBfL6cv4qwtMpC
 VnJ7GlxtKeg5gCFfOeC6cECGvTie9EaqmTMnfreyIDffRg7XnuyAhlVrCGyKBsQFjgiazYrFOE0
 2Cg1DGqMplHjmFTAV4zll7wtjKpiEL1H8AeqaYf/Tjp5N28p18E1FpXZCGAAxXcWvhZu+EcEgW9
 aezn37aDQAZ18DgoaU65DjfVFTS1fGuEI5is0xb7t8czFt14z+Xq8czJDeHCC2ZBbEPi5FldSAy
 eHO2qMwFweIe6hg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:UBBh2/9BN2Vv6BIdtivV7cptpR/4F5jWKUUMoEsPVoJMbaesweH
 M3J+jvLQ4kx1M9Um/3o1hHpmjWBDY2GT5UmBrkApUS/B61bsb7Ep97ULnNsH1PdcmLnpH+5
 JRHL5ZTAI7ECFfdtidJd2sGm/feXHh6h/jQha0xTScCnya3McOkryPmgUIc0jx81tpvE8nT
 VOZdV0ijTWGUG0EVb7dig==
UI-OutboundReport: notjunk:1;M01:P0:WnVNAd5PRdU=;rHZbHatchNeNLcpVt/FvnqU5AjY
 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
 rcyi5WYY5XTz0X+MEoW9Bi1dK2WnR
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/multifd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index bf6da85af8a1e207235ce06b8dbace33beded6d8..8e71171fb7a17726ba7eb0705e=
293c41e8aa32ec 100644
=2D-- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1265,6 +1265,15 @@ static int multifd_device_state_recv(MultiFDRecvPar=
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
@@ -1399,7 +1408,7 @@ static void *multifd_recv_thread(void *opaque)
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


