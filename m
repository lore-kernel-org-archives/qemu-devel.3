Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4670EE6B51
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3W-0004Jd-Cn; Fri, 06 Feb 2026 15:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0004F5-Tp
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:39 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS37-0008Np-7z
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408206; x=1771013006; i=lukasstraub2@web.de;
 bh=bHKDgq6h+b/M7EhW61MaX0Cm/kdRU0pIx1l0id9k6Us=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=uYX5eK6aTEeEy1QpJmVEcZjuoB7SN6OBZgGSrw7psX36+Zlz7Rdb+sJCBrB0+3xt
 CqNGO7DfeDCg2ZFTy1pm5qgSDpr1UaShOOtgwNMLB6Xao9RwFCUsDX1MaHcQMk1JU
 N1T7QWdMQbFF79O1e37RvC/o1X5m3wjbCaewtyTthHOkFy224wYj224X1PvTcm4uX
 ea1aEb96sdCxifmyMp7vXITJO8L7XQ5AuRZjADteeIPagQhRFdTxc2yByNDkM7zLs
 w3TKBPmR5sCx+fnNwRjYgg/Ia6ypHYqqiYian/XKg8OyTjBrsmn5JRhtwmRiVrdCi
 CC+9Fsqd+nCPxZWGXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlsON-1vNx4H1Btj-00mGPZ; Fri, 06
 Feb 2026 21:03:26 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:08 +0100
Subject: [PATCH v6 10/18] Call colo_release_ram_cache() after multifd
 threads terminate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-10-27779dda139d@web.de>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
In-Reply-To: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=F9IEy+4YXw0ic4hdA5SnWxv36ftHLR6BjkCOtPAGjYo=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkGHCJpXigfFlMzqjt8R9y3eSRf0Bgr7pt5e
 v96etJmhceJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBgAKCRA1qwsonF2y
 WAnID/9Y88OoKx+ytp2dzI4pKEXk/Gh5h+tNnb7p+OhrcW20gvrJ2Fb+PAk4MFHkzK+vQTqXEjv
 7+52AJg/aG7+C11QOdmmmyN5fsDRXUAA75QERR36aq3q2VhrGya9kDSVD26SJ/5p3crXfl//Jam
 FX2m5zjiXgDTVIjG+s7nKTgZMk3vWCd1BcQTVoCNfbfpVlmGwFvsp0IO1f2+xPgVPszCQ9YAIeM
 z8veTqHaNdBHRomvOHc/UPfypepRInpZ4BkZUJFNRxYkW8f7SGxlg1gnVlKx1urYlBD2E5tPPKl
 B/u7leKu0FZfTEC7EpKIdjG/Nb805TWmLqYOuXl+nZJvztKJks/zVeo9nZJ6CC104mIerZYrsv1
 NYkiHXK8gQNVOw5Gwh2qfAo00Q0lms8/7nltUL/Fe3NkeY7ULHjlsHx3NzuDwSmrjK6FIRRHSDL
 Wr4KVObm47mIZ80xi131EGzGxRJMxP/08QsWCNWgBx6J8d10hhfzkXBRgI7UHjasT9T6xJTv0Kd
 a1cBrAiHWiCMp+e9PrMGmYkFo51zHTqFTgqdLRnLnCS9geLw0ab/eu057dVpX///MujTkNtLnVf
 2Z/93rQSBFKlIMF2gRh0ON6ec0NKALWaHiaf7Yyyw8/owOKR2Z7zGTLTFa9OA/hcb3giYON8NGn
 HfFlSKIIuH48J7w==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:9niXr7qC3fP6UygiLq95+ZsMeqaHQElbMC3KTQNzioWnB1bs03c
 fjx4OEFLf+RdHkacycbT9HW1z5v5lokfE1INNNxFQh7x0dazkqVI58hJDixXRP4+AR5TiSD
 vVpTlAIe2uQLLbQJcvKPmNxg39aVH7zpIFd5ZojN6yHfU4Oc/p4QWl7VzWsGRZ5tj9UFpwx
 HeW+1FyqJZj9vMPEbB0Vg==
UI-OutboundReport: notjunk:1;M01:P0:a2bvi1+KqDs=;PMlH528by3UcUuwiFyEJNXYfkiq
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
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


