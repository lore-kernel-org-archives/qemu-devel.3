Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D70CC9EC80
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 12:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfH5c-0000E1-QA; Mon, 12 Jan 2026 07:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfH5a-0000DE-Fq
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:32:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfH5X-0004lj-8c
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768221115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tvoCcnd+gfPmEOIGDVzyy7vWTdvij/23zmn+TtZxEE0=;
 b=iF0kF/Oxln++wC7W16RRriUcBsIa3RCnDlmNYcKEkx4laARbtyldMFaAO9zxGsggmU70QN
 pcq32yG0pZ2HYifFqlGNxj0XTCWPzMaDdPzCddlJHQj1Fp3Vvs+WyEXyjeSyeIthwo5G4w
 TQmh3BmJ+4UWdHYz6fladduP+fY0/Sc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-vgrZibWeOZ2ScQ0A6Z0B2Q-1; Mon,
 12 Jan 2026 07:31:51 -0500
X-MC-Unique: vgrZibWeOZ2ScQ0A6Z0B2Q-1
X-Mimecast-MFC-AGG-ID: vgrZibWeOZ2ScQ0A6Z0B2Q_1768221111
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC2461800350; Mon, 12 Jan 2026 12:31:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB2DE19560AB; Mon, 12 Jan 2026 12:31:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] tests/qtest: Fix build error
Date: Mon, 12 Jan 2026 13:31:46 +0100
Message-ID: <20260112123146.1010621-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Newer gcc compiler (version 16.0.0 20260103 (Red Hat 16.0.0-0) (GCC))
detects an unused variable error:

  ../tests/qtest/libqtest.c: In function ‘qtest_qom_has_concrete_type’:
  ../tests/qtest/libqtest.c:1044:9: error: variable ‘idx’ set but not used [-Werror=unused-but-set-variable=]

Remove idx.

Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/libqtest.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 622464e3656e2c0138c4cf1cbf98733f84dce876..61f05be5caeaff1c466395234078a37a5d1c4398 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1041,7 +1041,6 @@ static bool qtest_qom_has_concrete_type(const char *parent_typename,
     QObject *qobj;
     QString *qstr;
     QDict *devinfo;
-    int idx;
 
     if (!list) {
         QDict *resp;
@@ -1066,7 +1065,7 @@ static bool qtest_qom_has_concrete_type(const char *parent_typename,
         }
     }
 
-    for (p = qlist_first(list), idx = 0; p; p = qlist_next(p), idx++) {
+    for (p = qlist_first(list); p; p = qlist_next(p)) {
         devinfo = qobject_to(QDict, qlist_entry_obj(p));
         g_assert(devinfo);
 
-- 
2.52.0


