Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE99BEA8122
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohl-0005EY-KJ; Tue, 10 Feb 2026 09:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohd-000598-2o
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:57 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohb-0005ly-Bi
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733601; x=1771338401; i=lukasstraub2@web.de;
 bh=8Sh4jCsixGU/ngEDSP7iq4j7Ehuo5ihlh5H1iguY9wY=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IgHkxH+dL2h5KUcNbl9ZHwuBGBF0JjPJFRB2sCFNgY6CtXxTcSnrXLHooJyyc9YS
 M2pTMlKmQkeJBQusWm41jQMwsBAUPC9yi1itOtQgIY/IPoTWMF8gxaWYXQu/ruu01
 mH3SqRZ+ZXtYxsHR9b4f9tC4v2Py2k65PdEAUtWGQz0EHrrPKExaJpY+ByAdxJbdA
 3P5BRM/X+rzso1UuSodxV6qEuFfrKttny5wwnLC0i3Vb8Vj640OF27DH2bTIGpV9L
 3tbNCEuVwyaP4bBPNjpAeJOJBXPKHUWm8dQY2AWbGXXfvntjq9twlEdSK8XVeg9CG
 8kk+YnEEGsG2cFhkpQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVJRb-1wGSms1H4p-00KmPh; Tue, 10
 Feb 2026 15:26:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:22 +0100
Subject: [PATCH v7 10/18] Call colo_release_ram_cache() after multifd
 threads terminate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-10-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=CrmZ30ApIHhMHmX1e6HZ1CefluvR59mmAs0+FI/64Pg=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0AclyT7iPOJ+GBZ9FaxS3xWXYgsCLV3eLTN6
 6I4Q2yRLh2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAHAAKCRA1qwsonF2y
 WEBvEACfkB11GIoIbsMtzvIb5J4nfnrwtRxrzzjjb8iXe0e/Ur4pfFKG7ibtWshC8sWuTV9II8M
 k5/C4UEl9HL3a/ck1hdH6oImF1lGQzCqX1n4Qz344Rey/5VHUVx9f4pEGCrbTZNN0tGwEskV0vt
 zEk3IOD67HOkChl22vwRUurcNlciqf54p6SEwt0FhpXFOwF3jZotFQHauJDHFCG7IAhbElwQkyP
 6DuruhED8T7Vy54Nzy+Du09pQht5FXXzoVD6S4DiWzPQA4j/X0vYrqgZ9gluD6JYzafH1Vg8a3n
 zzmOTzRpjqEnoHSY5LwIJ96r2WWIvUJLiyIwGasZkqwmGaPByz5pHgA5Ik7U8S9dF0TcfkIPb8k
 P19fG2b9NdQWyAhg2KeJUuobUPrugLQYYiTTmGJmrqomBZ+/8zuOXkrpkqFK1rUHM5fBYDT5p84
 pWDJuH3FaocQ+sDTXHKUw60Q1HFE6TxwnN9r+FThCL4xOc7+UPn/B/7UlArG0mD1gSWrHLbtTnU
 czylmJFDnyHqK+C3YIUVVRi03wlJVUApJUG/CWz06bk69jtC8fUv0OxEX6BPRDEU483wDjLjiD9
 C7OR8wtBBBBHvVdjA7C11cZnFu54mwGJcrAQ4N2nWJ2Thylz0dYO3jREB7QICoKjQ4RvP01vfVO
 K0zjqM/zP7IcJpA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:YiyF/6YOiTURv/InfyrJR1X0HQnlH6Tr9HMaGpYA4ad3h62tczM
 QtbigRoaucMHlUGwvVyFqin9f8yFZoRpMwwdEeTxaRkK1zJc2ZbnPWs8pGY+zfb/P1xMjf7
 6ehlF5aRTK8wkjsFcD0CCMwAs+OD8+3WPRDj+C/mcrNjlQRWouX5I5iISj8sxVQr9ZQ7lLA
 IB+MZyDOC+5ZCTay0UNQA==
UI-OutboundReport: notjunk:1;M01:P0:b6MTlaDLjZo=;3XbJTA6Tye/E+ZuqplmL05u7q1R
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

The multifd threads still may access the colo cache, so release it
only after they terminate.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c      | 3 ---
 migration/migration.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 8dfd39b035c48590fcebeb20459f01fb37fb67d1..d3534d1a32ad82f02101ac092e=
bf818a0caee6f2 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -947,7 +947,4 @@ void coroutine_fn colo_incoming_co(void)
     /* Wait checkpoint incoming thread exit before free resource */
     qemu_thread_join(&th);
     bql_lock();
-
-    /* We hold the global BQL, so it is safe here */
-    colo_release_ram_cache();
 }
diff --git a/migration/migration.c b/migration/migration.c
index 5515be1bf305b40ba0b590136df18a53451872c5..9e3f73f27766196ea8673bf9a5=
8c97d5b8b1672f 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -454,6 +454,9 @@ void migration_incoming_state_destroy(void)
      * BQL and retake unconditionally.
      */
     assert(bql_locked());
+    if (migrate_colo()) {
+        colo_release_ram_cache();
+    }
     qemu_loadvm_state_cleanup(mis);
=20
     if (mis->to_src_file) {

=2D-=20
2.39.5


