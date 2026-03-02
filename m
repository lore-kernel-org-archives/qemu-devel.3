Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C07E9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Ht-00050C-Fs; Mon, 02 Mar 2026 05:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HY-0004tq-6X
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:45 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-000632-H0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446416; x=1773051216; i=lukasstraub2@web.de;
 bh=lcGEXTcmjSwo1uIOCMzYBcGqppfFNt21+FB9vZyidNs=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Yt7TjyYc5ssL4Agcl9ZaW1OQ79uadWLs305G96emTeUzCCC8YlP8BH9IwYuejbnb
 GARECORL/l0QE5+rOjng86KrlJI3ayZt2Jzdpb04WCguEykH0RcXdb644cSxUsjH/
 XRCF5lS9jpe4IbAkTuxe0cEYraIxUec99haW3d2IyDo2ssc5sciDFv6dVI05rq2sd
 vgDDxk7bnJNgByzhUh4rw9m8jbmmORvq7PIp2tgTCTouXZMFJhTylY6dRBjKyyTW3
 aCozOrDguTTpd4F2hfxaVk5sspTyN3Lin1yOxaS+YxTv0piuR5wOKTRR1m9mEjrGY
 +LcvYByZLnepu7tEZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2xvy-1vy7HI1WRA-0087TR for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 19/21] colo: Use file lock in primary_vm_do_failover()
Date: Mon,  2 Mar 2026 11:13:30 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-19-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=REq8s1GLond4/LcE4TppwatMZ1netju7z89n3hnA2Mc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAGpLXmFDkklvHimiR55IB4X+7WvbvEkxo3+
 fofp7eeAzGJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBgAKCRA1qwsonF2y
 WNUhEACUdN9jRlkC2Xpj4iHM9rix0hk+oAd86kLopdrKms/jndWjcPtjdToTKcULzqzUc6KpmiU
 gPG3s9qmxu9jIfjW2HL9VlmlTRKGApQk+0CSk/VFNX7x20RigUzgvnwpnJkoQ9Xt0fh6+41xkpr
 iQUzPOWcwfpZaKX/Hlo2AsyX6CDM2uQduaNdGvZ5T7nteeGASL3VTR512Xpo35h9HbApsXEDSmA
 Vvsp5qirKz9dc2ZEs99Jbm81IbDm8K06nxyjb1igCrG6GCf2mgBE6TPWNq3jrk4fwu/FdOzZgy3
 5+UMdw36+FaP4OCzPgay4envpUNWRWC8LSsQmtU5bcLn/75oIIgOn4qlp2g/mQC8StJ3fMdbuZs
 ha5gu+o9UnBRGtWcbE4KhFrh4+A3LF3nU3/Yadq0rJ36p6ymfsnu7JEnm0HbXiXZO1/MmE0E5o0
 RjyOjnvTZpNAVBjR3zZME4jJ8CAeUhT6xrBCTR1u8f49RkROtDFPQ/TcuaA9lb6hz4rOEE36L5Y
 WmrIi6F8WAThWViwOVIY5rRVNNWF7xaCKVE/GEuqxZF5wwbtnIWZl+5RatimsKdzedyW0dK9h7F
 ZdMYdkJNMW3oqNSvUvLR1rZQXkPHiZ7ulzkWHjWmztE/PNAbgcnqCJnUHBfWay4qMt0RQL/5fCb
 YHg0S7e44V0X/3A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hEbQW0AfcPy2cotDqb0o/1UqsltyTtjKlnA9JiCLYeVuQKtcbJl
 F3sLp70L9ntVemln8UkfMS/ocQv/th/fK5Ms0MaQ3rC41uLt7HRskjJau9cEaNkEa3QuFxG
 pQJxDF3OMIeZ0oJvK3dYIo22QIWSBgkFVMFJhuu0wdXe0gCvp1X3wE+jXyOY1/t2izJcpUu
 9jYnEFHHG8fIimXcgJHJQ==
UI-OutboundReport: notjunk:1;M01:P0:O3+9T5HGtPs=;03wG69lawInfm6Qrcxg/RjplI0R
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
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


