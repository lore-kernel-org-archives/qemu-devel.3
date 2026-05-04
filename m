Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E90CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxQQ-0004dJ-M5; Mon, 04 May 2026 13:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1wJxQN-0004cB-1Q
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:49:43 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1wJxQJ-0000c4-T5
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=eui225Z0UCfacH5eyWoLlqyenDHCvrvlYzvvNvlGNqE=; b=MQpfRXzwbU5wkizV
 NNoWhRieE0+axoUTlmAAqclzbeGAPEXaScd3a5p72saH02w0OHmHV6fa/E+aliMmpw19W0O00nVLg
 /pdus4aOaTcSXIpDZcrqp2FcfyDjqv3oYMSKmV09HzLr9LGPNNcoAgCkkx3Q5VN/sn5QcSFN5UFJZ
 D+j1s84bIw7OF/hX48EdUoZoLJ5X97YK06do9qww5wLF62BJrYdX2qQ39fnQIJt80TcQgnMuJU1qP
 76zTUlKShrHq7KNrI8WB+xcmiJG/bb43/QxtQTTMslGsCH5Gxm4dvyyp1CqGxfoRUFWBSaIzkYb8q
 IdnaTu9Mdc+YzQZg4A==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <dave@treblig.org>) id 1wJxQB-00000000ZQZ-1GUN;
 Mon, 04 May 2026 17:49:31 +0000
From: dave@treblig.org
To: qemu-devel@nongnu.org,
	armbru@redhat.com
Cc: AlanoSong@163.com,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 3/4] hxtool: Error on missing docs
Date: Mon,  4 May 2026 18:49:13 +0100
Message-ID: <20260504174914.122607-4-dave@treblig.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504174914.122607-1-dave@treblig.org>
References: <20260504174914.122607-1-dave@treblig.org>
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
Reviewed-by: Markus Armbruster <armbru@redhat.com>
  With the two minor tidy ups from Thomas's review
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


