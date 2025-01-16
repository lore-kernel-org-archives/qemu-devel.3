Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16AFC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYOWf-000284-Id; Thu, 16 Jan 2025 06:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYOWV-00027B-3B
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:58:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYOWT-0002le-IA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737028732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSBIJLajlX3Rlq7ZmtOn1iXD3uSckffeCtqbDWsf4yI=;
 b=Wis+0kpibcN3DIiqZLU3vC8OEDL4rrj6yuITmw6CBryBqjDFHEXeeDlankc24o16opxdH3
 lbBoJKf2wyuc5/qLc2oMb6891xrY5evWbxWS6KmcyC75IDr1Xw8wUuThItvosVRkPj4dcN
 pHR41wT83bFXyWxgckEaNw4fnfEfojE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-SllNMfF9MQqZ1KQ0A1SGNw-1; Thu,
 16 Jan 2025 06:58:47 -0500
X-MC-Unique: SllNMfF9MQqZ1KQ0A1SGNw-1
X-Mimecast-MFC-AGG-ID: SllNMfF9MQqZ1KQ0A1SGNw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 729AB19560BD; Thu, 16 Jan 2025 11:58:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.129])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C20F30001BE; Thu, 16 Jan 2025 11:58:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Jared Rossi <jrossi@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 3/3] pc-bios/s390-ccw/netmain: Fix error messages with regards
 to the TFTP server
Date: Thu, 16 Jan 2025 12:58:26 +0100
Message-ID: <20250116115826.192047-4-thuth@redhat.com>
In-Reply-To: <20250116115826.192047-1-thuth@redhat.com>
References: <20250116115826.192047-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The code in net_init_ip() currently bails out early if "rc" is less
than 0, so the if-statements that check for negative "rc" codes to
print out some specific error messages with regards to the TFTP server
are never reached. Move them earlier to bring that dead code back to
life.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netmain.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 335ea9b63e..719a547ada 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -168,6 +168,14 @@ static int net_init_ip(filename_ip_t *fn_ip)
         if (fn_ip->ip_version == 4) {
             set_ipv4_address(fn_ip->own_ip);
         }
+    } else if (rc == -2) {
+        printf("ARP request to TFTP server (%d.%d.%d.%d) failed\n",
+               (fn_ip->server_ip >> 24) & 0xFF, (fn_ip->server_ip >> 16) & 0xFF,
+               (fn_ip->server_ip >>  8) & 0xFF, fn_ip->server_ip & 0xFF);
+        return -102;
+    } else if (rc == -4 || rc == -3) {
+        puts("Can't obtain TFTP server IP address");
+        return -107;
     } else {
         puts("Could not get IP address");
         return -101;
@@ -183,17 +191,6 @@ static int net_init_ip(filename_ip_t *fn_ip)
         printf("  Using IPv6 address: %s\n", ip6_str);
     }
 
-    if (rc == -2) {
-        printf("ARP request to TFTP server (%d.%d.%d.%d) failed\n",
-               (fn_ip->server_ip >> 24) & 0xFF, (fn_ip->server_ip >> 16) & 0xFF,
-               (fn_ip->server_ip >>  8) & 0xFF, fn_ip->server_ip & 0xFF);
-        return -102;
-    }
-    if (rc == -4 || rc == -3) {
-        puts("Can't obtain TFTP server IP address");
-        return -107;
-    }
-
     printf("  Using TFTP server: ");
     if (fn_ip->ip_version == 4) {
         printf("%d.%d.%d.%d\n",
-- 
2.47.1


