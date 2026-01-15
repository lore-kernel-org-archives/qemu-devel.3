Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E2AD3CCA2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 02:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgCiz-000185-J1; Wed, 14 Jan 2026 21:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1vgCiy-00017f-16
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 21:04:36 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1vgCiw-0001hy-FK
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 21:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=K7IkeO8eN1VAP9xOsoqI20lnoom1a0KQ/5GXf4InmqY=; b=WC/iMU+hLFxRpJf6
 7vVN/WRxRW0NKrcw2EmfRprmqB4BfCDSTAFvmf/MTXO/QJvokfk1hzX1rK7zZl6KzoLZy4Ly+qwj3
 NjkFWok6OOYaS6kcXUO3LRuMg8PCmjI8nG8CxgsLMFolIzgHbZEQaB1ji+4vSqFRoSjndbCjiAr+T
 u5Zadha/wSAu2j2w1jI0PgaBbqXaqV+E87xlacApU2hIxQg9RhAABDjI4zPkgXrW9XlZMCIMsKAXX
 eWKPwUrJfyRxbxaR+b8O1fUeZFyjPRu1c0cHtB5nY5n2vGk9lD6bRE5R1B2qXsTGTgjm/AtsHI3TB
 2qU3tARltS+02Oj2hw==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <dave@treblig.org>) id 1vgCit-0000000Eq8W-2jqk;
 Thu, 15 Jan 2026 02:04:31 +0000
From: dave@treblig.org
To: dave@treblig.org,
	armbru@redhat.com,
	berrange@redhat.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 3/4] hxtool: Split srst/erst add checks
Date: Thu, 15 Jan 2026 02:04:22 +0000
Message-ID: <20260115020423.722069-4-dave@treblig.org>
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

Split the SRST/ERST case and add some checks.
This is mainly to make it easier to add some checks in following
patches.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 scripts/hxtool | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/scripts/hxtool b/scripts/hxtool
index 80516b9437..ea2accef98 100755
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -2,15 +2,29 @@
 
 hxtoh()
 {
-    flag=1
+    outsiderst=1
     while read -r str; do
         case $str in
             HXCOMM*)
             ;;
-            SRST*|ERST*) flag=$(($flag^1))
+            SRST*)
+              if [ $outsiderst -eq 0 ]
+              then
+                echo "Error: SRST inside another RST" >&2
+                exit 1
+              fi
+              outsiderst=0
+            ;;
+            ERST*)
+              if [ $outsiderst -eq 1 ]
+              then
+                echo "Error: ERST already outside RST" >&2
+                exit 1
+              fi
+              outsiderst=1
             ;;
             *)
-            test $flag -eq 1 && printf "%s\n" "$str"
+            test $outsiderst -eq 1 && printf "%s\n" "$str"
             ;;
         esac
     done
-- 
2.52.0


