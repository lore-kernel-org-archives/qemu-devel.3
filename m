Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D06AC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 07:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh1Dr-0003hF-3z; Wed, 30 Jul 2025 03:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uh1Dm-0003d2-Cw
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 03:27:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uh1Dg-0002tR-1C
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 03:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753860442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nPI7pdlOcMz7QrP0SBU39anyG80W4Kt/XP9FRi6Jd1I=;
 b=ZzO1wK4n83GK3DgKWAKJqvhiARLFnUK4gikwjiu998/8UZtdK220LbXRaPPYJLpeZ1X/QY
 9FSWQB+RpWEkQC5kE07Tg4q+qLu5TF2m1QYFMvRInHERz6mpJls//P9obeap4edMdoJFS0
 j5R0SKubTDoM+y5prhAIh1DCYRjKzrQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-BR3DqirsPLGnywzHHvm0vg-1; Wed,
 30 Jul 2025 03:27:15 -0400
X-MC-Unique: BR3DqirsPLGnywzHHvm0vg-1
X-Mimecast-MFC-AGG-ID: BR3DqirsPLGnywzHHvm0vg_1753860435
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A19F819560B2; Wed, 30 Jul 2025 07:27:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8235F18003FC; Wed, 30 Jul 2025 07:27:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2] qga: Fix ubsan warning
Date: Wed, 30 Jul 2025 09:27:09 +0200
Message-ID: <20250730072709.27077-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

When compiling QEMU with --enable-ubsan there is a undefined behavior
warning when running "make check":

 .../qga/commands-linux.c:452:15: runtime error: applying non-zero offset 5 to null pointer
 #0 0x55ea7b89450c in build_guest_fsinfo_for_pci_dev ..../qga/commands-linux.c:452:15

Fix it by avoiding the additional pointer variable here and use an
"offset" integer variable instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use an integer offset variable instead for checking for a NULL pointer

 qga/commands-linux.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 9e8a934b9a6..0c41eb97190 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -400,10 +400,10 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
                                            Error **errp)
 {
     unsigned int pci[4], host, hosts[8], tgt[3];
-    int i, nhosts = 0, pcilen;
+    int i, offset, nhosts = 0, pcilen;
     GuestPCIAddress *pciaddr = disk->pci_controller;
     bool has_ata = false, has_host = false, has_tgt = false;
-    char *p, *q, *driver = NULL;
+    char *p, *driver = NULL;
     bool ret = false;
 
     p = strstr(syspath, "/devices/pci");
@@ -445,13 +445,13 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
 
     p = strstr(syspath, "/ata");
     if (p) {
-        q = p + 4;
+        offset = 4;
         has_ata = true;
     } else {
         p = strstr(syspath, "/host");
-        q = p + 5;
+        offset = 5;
     }
-    if (p && sscanf(q, "%u", &host) == 1) {
+    if (p && sscanf(p + offset, "%u", &host) == 1) {
         has_host = true;
         nhosts = build_hosts(syspath, p, has_ata, hosts,
                              ARRAY_SIZE(hosts), errp);
-- 
2.50.1


