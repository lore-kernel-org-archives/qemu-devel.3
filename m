Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0170CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 12:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKEzk-0002pD-54; Tue, 05 May 2026 08:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEza-0002fv-Fj
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEzX-0006xV-Ki
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777984509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5mKi/48bzyRVpnUGJc6MY3SnY4zBGlsfHELb3LFJeF8=;
 b=cvuiGskRgnKd3bx9xHxLAAO7a1mvdxpRmK20QWlToDFNZUeiERs71sbDovwu1K7rUtPm4y
 rKeNS73+XH0LeVCPTsGkEOkQUxRkSOoIIDIauQ1CsiKXmdxpToRaTiYfR4UmolxpFSydo7
 Bf1MOhb4ROtHB4aNDoBo0JpmJfdn8Eo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-cMrsPw5mOr-ZLk_Dr15btA-1; Tue,
 05 May 2026 08:35:06 -0400
X-MC-Unique: cMrsPw5mOr-ZLk_Dr15btA-1
X-Mimecast-MFC-AGG-ID: cMrsPw5mOr-ZLk_Dr15btA_1777984505
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FD4F1800451; Tue,  5 May 2026 12:35:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16D511800446; Tue,  5 May 2026 12:35:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7072C21E6A03; Tue, 05 May 2026 14:35:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 2/4] hxtool: Split srst/erst add checks
Date: Tue,  5 May 2026 14:35:00 +0200
Message-ID: <20260505123502.1316554-3-armbru@redhat.com>
In-Reply-To: <20260505123502.1316554-1-armbru@redhat.com>
References: <20260505123502.1316554-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260504174914.122607-3-dave@treblig.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.54.0


