Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CD9D3CCA2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 02:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgCj1-00018w-FA; Wed, 14 Jan 2026 21:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1vgCiz-00017w-6d
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 21:04:37 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1vgCiw-0001iR-Gs
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 21:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=pVf4Nq5yyOaiSh5/d48eFUOJ2zNDs9ZI9Zq2WaZY3k0=; b=eGmluPZOfSr2roMY
 DzCNXFes9AHpJly7PAYePIihsYP1DpQWOw6qxsh/YQqOZ8wdTuCBFT3g/KDDVuVI0REnL9xOqijOg
 gk9zkaIuvISQVdM16dnRdOCcHX19KShuPIGNS1LYXa62O1seCJCsxbOqPx6AaSrmzZ/tFHjUMN9Vz
 53JS4fmsS06bDtfCNy1gO8orI8g8pi7rVUwuoLqWLV6A/6OpydtxxPpiHyy7mXmZvz9fNhW4lv5Ja
 Vpf8aA9JdjY5oAd8s9ZY9BBGg6UrCSBSj7dbsUNVCLT22hZGx1VGizDMRB50SwaRUuHsrCZib2iQD
 7iCXP8mXVYVzm+wAsQ==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <dave@treblig.org>) id 1vgCiu-0000000Eq8W-16bK;
 Thu, 15 Jan 2026 02:04:32 +0000
From: dave@treblig.org
To: dave@treblig.org,
	armbru@redhat.com,
	berrange@redhat.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 4/4] hxtool: Error on missing docs
Date: Thu, 15 Jan 2026 02:04:23 +0000
Message-ID: <20260115020423.722069-5-dave@treblig.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115020423.722069-1-dave@treblig.org>
References: <20260115020423.722069-1-dave@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 scripts/hxtool | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/scripts/hxtool b/scripts/hxtool
index ea2accef98..f310071daa 100755
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -1,8 +1,14 @@
 #!/bin/sh
 
+printifnotrst()
+{
+    test $outsiderst -eq 1 && printf "%s\n" "$str"
+}
 hxtoh()
 {
     outsiderst=1
+    # .name for HMP
+    seenname=0
     while read -r str; do
         case $str in
             HXCOMM*)
@@ -13,6 +19,8 @@ hxtoh()
                 echo "Error: SRST inside another RST" >&2
                 exit 1
               fi
+              # consume the name
+              seenname=0
               outsiderst=0
             ;;
             ERST*)
@@ -23,8 +31,18 @@ hxtoh()
               fi
               outsiderst=1
             ;;
+            # Note the space at the start - we need to exclude something.name
+             .name*)
+              if [ $seenname -eq 1 ]
+              then
+                echo "Error: Seen another .name, maybe missing docs?" >&2
+                exit 1
+              fi
+              seenname=1
+              printifnotrst
+            ;;
             *)
-            test $outsiderst -eq 1 && printf "%s\n" "$str"
+            printifnotrst
             ;;
         esac
     done
-- 
2.52.0


