Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BB3FCC073
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 20:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybuw-0007ge-CU; Fri, 06 Mar 2026 15:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vybuv-0007gO-1G
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 15:37:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vybut-0007RP-3r
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 15:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772829416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ho/Mrk8He9w+IftrvucB8Peneasc8FgN8wkRmupgNxY=;
 b=HySDizmb8i13KedPnHWiciRmyfh9WXwY7zGwXUnicISzvhPthTpDKbo7MzoHu2ZYMH6yVA
 HNlx8MOKurhPZcbSRhPltTj64oiS9QjDE/k6HRmPWHGsJIJnqHEdO6xo+jsGFblVRGV73Q
 F8N8+9JNEye4bB2+gthrSJGS8ITDCWk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-xuYzblLbMuGWllL3XN8vwA-1; Fri,
 06 Mar 2026 15:36:52 -0500
X-MC-Unique: xuYzblLbMuGWllL3XN8vwA-1
X-Mimecast-MFC-AGG-ID: xuYzblLbMuGWllL3XN8vwA_1772829411
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C6C7180044D; Fri,  6 Mar 2026 20:36:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 675D53003E9F; Fri,  6 Mar 2026 20:36:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PATCH] pc-bios/s390-ccw: Fix compiler warning when compiling with
 DEBUG enabled
Date: Fri,  6 Mar 2026 21:36:45 +0100
Message-ID: <20260306203645.28232-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When compiling with DEBUG=1, there is currently a compiler warning:

 pc-bios/s390-ccw: Compiling main.o
 In file included from /home/thuth/devel/qemu/pc-bios/s390-ccw/main.c:14:
 In file included from /home/thuth/devel/qemu/pc-bios/s390-ccw/helper.h:16:
 /home/thuth/devel/qemu/pc-bios/s390-ccw/s390-ccw.h:122:31: warning: format specifies type
       'unsigned int' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
   122 |     printf("%s 0x%X\n", desc, addr);
       |                  ~~           ^~~~
       |                  %llX
 1 warning generated.

Fix it by using the right format string here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/s390-ccw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index b1dc35cdedf..6a0b987e303 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -119,7 +119,7 @@ static inline void fill_hex_val(char *out, void *ptr, unsigned size)
 static inline void debug_print_int(const char *desc, u64 addr)
 {
 #ifdef DEBUG
-    printf("%s 0x%X\n", desc, addr);
+    printf("%s 0x%llx\n", desc, addr);
 #endif
 }
 
-- 
2.53.0


