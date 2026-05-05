Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595C2FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 12:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKEzj-0002o3-M6; Tue, 05 May 2026 08:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEzZ-0002fa-6T
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEzV-0006xJ-DV
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777984507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YN96wE0xMfP184+ExrjUxV1C0+PzpEZRnQ6zKTfwyP0=;
 b=h4JG4Yqq0LdM/urVQMmFVaFo9a/iok84pAXuUFDD5rCvA6WAZ1PW4Txtzgay5qQcJhuutX
 EL1yZkOSv8SlUO/+QXfXA2RXmsiCUJaXt3l+VY3xqdopQSn8LVm50DX1F4LknFWRqYLbdS
 rH4GJdevjIX6JnUrfuWcu0F1yKtgEe8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-yPifRvY3P4S086xChJqicQ-1; Tue,
 05 May 2026 08:35:06 -0400
X-MC-Unique: yPifRvY3P4S086xChJqicQ-1
X-Mimecast-MFC-AGG-ID: yPifRvY3P4S086xChJqicQ_1777984505
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75D7A1956095; Tue,  5 May 2026 12:35:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24A0B1800347; Tue,  5 May 2026 12:35:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7448B21E6A05; Tue, 05 May 2026 14:35:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 3/4] hxtool: Error on missing docs
Date: Tue,  5 May 2026 14:35:01 +0200
Message-ID: <20260505123502.1316554-4-armbru@redhat.com>
In-Reply-To: <20260505123502.1316554-1-armbru@redhat.com>
References: <20260505123502.1316554-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

Error if a '.name' is seen after another '.name' without an intervening
SRST, this normally indicates missing or misplaced docs.

We can't check DEF (as used in command line options) because those
often have multiple DEF per doc.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
  With the two minor tidy ups from Thomas's review
Message-ID: <20260504174914.122607-4-dave@treblig.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/hxtool | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/scripts/hxtool b/scripts/hxtool
index 51dc841479..617a694eaf 100755
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -1,8 +1,15 @@
 #!/bin/sh
 
+print_if_not_rst()
+{
+    test $in_rst -eq 0 && printf "%s\n" "$str"
+}
+
 hxtoh()
 {
     in_rst=0
+    # .name for HMP
+    seen_name=0
     while read -r str; do
         case $str in
             HXCOMM*)
@@ -13,6 +20,8 @@ hxtoh()
                 echo "Error: SRST inside another RST" >&2
                 exit 1
               fi
+              # consume the name
+              seen_name=0
               in_rst=1
             ;;
             ERST*)
@@ -23,8 +32,18 @@ hxtoh()
               fi
               in_rst=0
             ;;
+            # Note the space at the start - we need to exclude something.name
+            ( .name*)
+              if [ $seen_name -eq 1 ]
+              then
+                echo "Error: Seen another .name, maybe missing docs?" >&2
+                exit 1
+              fi
+              seen_name=1
+              print_if_not_rst
+            ;;
             *)
-            test $in_rst -eq 0 && printf "%s\n" "$str"
+            print_if_not_rst
             ;;
         esac
     done
-- 
2.54.0


