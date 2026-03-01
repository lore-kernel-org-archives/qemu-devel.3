Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93477FD0075
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmHw-0001EP-U3; Sun, 01 Mar 2026 14:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHm-00015u-DG
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:02 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHj-0003WA-F9
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392615; x=1772997415; i=lukasstraub2@web.de;
 bh=lcGEXTcmjSwo1uIOCMzYBcGqppfFNt21+FB9vZyidNs=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=nfomnCuUUZnUAWJewVlCV1z3qzMD+IVMXntvRp0yZDlkhS7K7QMjgwjLVbF+fN32
 0oietYFL6PY4YwcIA2qzYRKVvtmb+3V1KlJ2/4Ld3NpUxhTBzpnLXG6U54f77kEm/
 IPxj1YoME4lO3tqg1m/O6aYOTr5WRx+lQ19C27Dkd4f9gTbqhXFmUa7qr5PYr7ttg
 Iacbg4xQncbVjgcHra6iwL7TkinrlQqbm6ucIOKpw3nCU68eSGgTXT1DSJbQPaU8k
 P258fp2d/HijMtQdrx/psCbNvepokLFyFBCdaAW8tvRfRpwqMhGrzCItjmBnbMAWR
 HyBve0iau113J1zdJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QqN-1vvxT80rkD-005eRL; Sun, 01
 Mar 2026 20:16:55 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:44 +0100
Subject: [PATCH v11 19/21] colo: Use file lock in primary_vm_do_failover()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-19-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=REq8s1GLond4/LcE4TppwatMZ1netju7z89n3hnA2Mc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCeCVLvhUu4XxLKEAbnhqaZEMX78MCO19T0t
 4vqT2qhT4WJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQngAKCRA1qwsonF2y
 WJjyD/95CROfiQHbi6FyHssuYs1tFzZRRVOKY7CVs7zU/G8g6l01P9ebLXYbt7PfsgBC50btiNp
 G741wswaMqC0RSc6B8q5J5ylkiH4fz419AS1IIbU4BMqxetdTUuLwnllrnMm4OpAjtdQfOicYEq
 k2saf/XDeQg0RwU3JE7uME6MATcuGttkT8iFwNPw747tWNF/1+Z3eANZ+sINbr6m5lpfnafbk7V
 jFBaJEmpa6fIgmsxM/0R7akIkSkNt5Kt9gwc38+o7TIu1b+71bLEywPZRzREz/Whkydq7hzI7T2
 jrO0KRG8s3pTsnkcUAVRse6gp3vawdcLM5U9DCfnlh3GwZf/zOF04WsR2Hb1++pH/6hQYqetSKf
 +VS2s4hMBZm67DoeaoArt8OWU2a7MeEC2VFswkCbl1ra/w0o767UY3dESxTVUGDvGDcswCHD/z4
 ZycJB/pBdCx1Y2I6SwgczSiV5O2gMQN/qSR4e3NEpJrAkliNdgCv06e8Vwyurdlij9Sci4n2X9q
 yDaHcxMvDnMDiZuKJpjlMh3vZntidlzc1tFjcEZJLpEDRxjny8gz0BofUY/r+QYdHifGmjDYz/w
 le85Y1n/WvHGkCzg+fyvqJAMM9bhhBtKFp1Idtu09GE+bGWJeS/fulu4ndmaOaEiLF5jDPSqIIt
 BzHOff2YGuPg4+Q==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:TrTeDn9f0lLZeDloMqevvWktvYnsCvKCXQtIAkXJUVZVoaIzbDg
 Jl7Ci2+x9EaqTP1hj3R7lFkqCfxpIOnLIF0TcaW3zr5Ew4c/JzFnrwaJ8ruYyFawsQyyjBr
 AFTzbTybWVO8aG0om1mcnyzOWOFhQhUc6eaG6ezpUvWiD9ibsYOwybpA91eXZFh8e3K1DoN
 DGzm3LqT9g5K+2FEva3Sg==
UI-OutboundReport: notjunk:1;M01:P0:KR28YH3QTsc=;VhdmkFX2NmC0+88rp42z6dFLrkc
 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
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

Take the file lock since s->to_dst_file and s->rp_state.from_dst_file
may be changed in the migration thread.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index ce02c71d8857d470be434bdf3a9cacad3baab0d5..dc47d03874039b686d2a4072ac=
4e6c77e4ff1f87 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -173,11 +173,13 @@ static void primary_vm_do_failover(void)
      * The s->rp_state.from_dst_file and s->to_dst_file may use the
      * same fd, but we still shutdown the fd for twice, it is harmless.
      */
-    if (s->to_dst_file) {
-        qemu_file_shutdown(s->to_dst_file);
-    }
-    if (s->rp_state.from_dst_file) {
-        qemu_file_shutdown(s->rp_state.from_dst_file);
+    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
+        if (s->to_dst_file) {
+            qemu_file_shutdown(s->to_dst_file);
+        }
+        if (s->rp_state.from_dst_file) {
+            qemu_file_shutdown(s->rp_state.from_dst_file);
+        }
     }
=20
     old_state =3D failover_set_state(FAILOVER_STATUS_ACTIVE,

=2D-=20
2.39.5


