Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A531ED47CAB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 00:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgY46-00061u-Hs; Thu, 15 Jan 2026 19:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1vgY3z-0005wM-7v
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:51:44 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1vgY3v-0000qk-UA
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=S69CqaNpTILaVSDiIWXdlALCd2xyUfUPqtotfKwH5BA=; b=Ey2VbmIa6kkQRMJe
 ZAYLAcxMqeQflkPzEOivowIstH7K4wk9GIIsaCdE4wG0AqPCOBtJVy/bHjGqi+p+DQdW56TUV+TKr
 kDsl21LnaNhwyHNWS2Foc4ZozzKQ+XyS4h9tf1wKvUJAr3+g7EcxuD7veltvwsoG7x4JvpmQWO8O9
 JdK9VwVgPn/QLwZijoq9QSz2le+KORlf1AHXKx21FYy89/gpRb0haoRnt9IEXNeRNRXmEN7BVRo+r
 hEDe3d4fOcc+qnntbC+an8Cts9TxIkVQopWFcxA05KUk/Y3vpHDIasRc/QBrkVAvikCDlPsIHP+TF
 /UgEtQabf2FgHJ6xqQ==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <dave@treblig.org>) id 1vgY3s-0000000F7wG-2cWl;
 Fri, 16 Jan 2026 00:51:36 +0000
From: dave@treblig.org
To: dave@treblig.org, armbru@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] hxtool: Split srst/erst add checks
Date: Fri, 16 Jan 2026 00:50:47 +0000
Message-ID: <20260116005050.376616-4-dave@treblig.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116005050.376616-1-dave@treblig.org>
References: <20260116005050.376616-1-dave@treblig.org>
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
index 80516b9437..51dc841479 100755
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -2,15 +2,29 @@
 
 hxtoh()
 {
-    flag=1
+    in_rst=0
     while read -r str; do
         case $str in
             HXCOMM*)
             ;;
-            SRST*|ERST*) flag=$(($flag^1))
+            SRST*)
+              if [ $in_rst -eq 1 ]
+              then
+                echo "Error: SRST inside another RST" >&2
+                exit 1
+              fi
+              in_rst=1
+            ;;
+            ERST*)
+              if [ $in_rst -eq 0 ]
+              then
+                echo "Error: ERST already outside RST" >&2
+                exit 1
+              fi
+              in_rst=0
             ;;
             *)
-            test $flag -eq 1 && printf "%s\n" "$str"
+            test $in_rst -eq 0 && printf "%s\n" "$str"
             ;;
         esac
     done
-- 
2.52.0


