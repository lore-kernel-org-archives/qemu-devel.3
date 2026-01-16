Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F97CD47CA3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 00:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgY47-00063k-2r; Thu, 15 Jan 2026 19:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1vgY3z-0005wL-7l
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:51:44 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1vgY3u-0000qn-S2
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=E2mXrTWQiOztBEj6wySA6rn8mt3kagBW5G9HJyHhrOU=; b=cbfTYx79baCyMNgx
 +LmhZNfFSrg9PeqSHZi7EhkAiYdx8AYNMrIKtFvBUcbN79W8KtmU2qWxxQuRUrbyr81L/MFqznk1O
 W2pB01AfzmMPsYpDKG35elqsmbdqxWNpE/JG6p+1peqgwfQPitB142d5pHKQxDbZutISJhU4fxNfZ
 77xsrWuaIu+jT0t6O1Iz0jL33tcF0wcxvjeE/fGTmsGRM9KuvLPoid4Ha2LG3WPHu7R85Q18QiUhv
 qg279PeZOUotnjMWRLUg/BMiad4rMTgL7mKhMh9Q1gwmvrOOt5+NixlPKe73ljXkaKtGrQVgemwGR
 TwH2zPrCew76+6LN7A==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <dave@treblig.org>) id 1vgY3t-0000000F7wG-13Zw;
 Fri, 16 Jan 2026 00:51:37 +0000
From: dave@treblig.org
To: dave@treblig.org, armbru@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] hxtool: Error on missing docs
Date: Fri, 16 Jan 2026 00:50:48 +0000
Message-ID: <20260116005050.376616-5-dave@treblig.org>
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

Error if a '.name' is seen after another '.name' without an intervening
SRST, this normally indicates missing or misplaced docs.

We can't check DEF (as used in command line options) because those
often have multiple DEF per doc.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 scripts/hxtool | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/hxtool b/scripts/hxtool
index 51dc841479..ee98fb9c09 100755
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -1,8 +1,14 @@
 #!/bin/sh
 
+print_if_not_rst()
+{
+    test $in_rst -eq 0 && printf "%s\n" "$str"
+}
 hxtoh()
 {
     in_rst=0
+    # .name for HMP
+    seen_name=0
     while read -r str; do
         case $str in
             HXCOMM*)
@@ -13,6 +19,8 @@ hxtoh()
                 echo "Error: SRST inside another RST" >&2
                 exit 1
               fi
+              # consume the name
+              seen_name=0
               in_rst=1
             ;;
             ERST*)
@@ -23,6 +31,16 @@ hxtoh()
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
             test $in_rst -eq 0 && printf "%s\n" "$str"
             ;;
-- 
2.52.0


