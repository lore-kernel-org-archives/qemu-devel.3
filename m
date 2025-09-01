Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7B6CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2eV-0000KY-QI; Mon, 01 Sep 2025 07:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ut2eC-0000F8-EX
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ut2eA-00065k-Fw
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756725865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=og6ymulh9UmaMSIescETQPevhxzm1aJMZFMSGR8zlFk=;
 b=ahzJWL+w3cUsrLluLC85aODAh6f9S8vz9REheRpQGn6XP7l2LdyQW/2aoOMsiiqxctSaAp
 iDCyOSv1d1Vs2xKzBb6zWP2uD1+VFfpmPtYW8a7diM3K314ZA0uTGkoOKF6iKDwL9ehueN
 jxn58EZvNQvRCJt5Gl+V44uBl3lyw1g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-yZ1Hsw8JPZGABBRb-SEpsQ-1; Mon,
 01 Sep 2025 07:24:22 -0400
X-MC-Unique: yZ1Hsw8JPZGABBRb-SEpsQ-1
X-Mimecast-MFC-AGG-ID: yZ1Hsw8JPZGABBRb-SEpsQ_1756725861
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 076C5180036E; Mon,  1 Sep 2025 11:24:21 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.80])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3391F1800446; Mon,  1 Sep 2025 11:24:18 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 1/9] qga: Fix ubsan warning
Date: Mon,  1 Sep 2025 14:24:05 +0300
Message-ID: <20250901112413.114314-2-kkostiuk@redhat.com>
In-Reply-To: <20250901112413.114314-1-kkostiuk@redhat.com>
References: <20250901112413.114314-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250730072709.27077-1-thuth@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-linux.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 9dc0c82503..4a09ddc760 100644
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


