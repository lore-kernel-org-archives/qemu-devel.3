Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E29C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woNwB-0007a1-18; Mon, 27 Jul 2026 12:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woNw0-0007Z2-OU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woNvz-00005A-8P
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785168725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VyriG6r8kFXeFEsuHn9qWyV7x8BT/tGnBpBLeDt657g=;
 b=ihbWRORNKrXJeZ0kntOwn7PECSRRwCh41IOQjKzevNmIxZ1AhId5FP66dNFHKRkljJJo1e
 GVvWxEhYY3c9Z2NhCErzXvvhsti9cVVmHMv0xSP64r0McAJ2EROCIEu7a9MaBWLQO0Wr6G
 DKAS8n1LYB77VVFV4jIAB/b6Z/kKdaU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-X67iZ2ydPO-LjxzLJdg0VA-1; Mon,
 27 Jul 2026 12:12:04 -0400
X-MC-Unique: X67iZ2ydPO-LjxzLJdg0VA-1
X-Mimecast-MFC-AGG-ID: X67iZ2ydPO-LjxzLJdg0VA_1785168723
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1819195609E; Mon, 27 Jul 2026 16:12:02 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95A5A430; Mon, 27 Jul 2026 16:12:01 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, chao.liu@processmission.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] scripts/checkpatch: warn on duplicate trailers and self-review
Date: Mon, 27 Jul 2026 20:11:56 +0400
Message-ID: <20260727161157.2112984-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Detect two common trailer mistakes:

- Duplicate trailers: any trailer (Signed-off-by, Fixes, Resolves,
  Cc, etc.) appearing more than once with the same value in a commit
  message.

- Self-review: a Reviewed-by, Tested-by, or Acked-by tag from the
  same person as the patch author, which provides no independent
  review value.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/checkpatch.pl | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 03f35e75012c..a9326297d626 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1539,6 +1539,8 @@ sub process {
 
 	our $clean = 1;
 	my $signoff = 0;
+	my $author_email = '';
+	my %commit_trailers = ();
 	my $is_patch = 0;
 
 	my $in_header_lines = $file ? 0 : 1;
@@ -1795,6 +1797,14 @@ sub process {
 		    ERROR("Author email address is mangled by the mailing list\n" . $herecurr);
 		}
 
+# Extract author email for trailer checks
+		if ($in_header_lines && $line =~ /^(?:Author|From):\s*(.*)/) {
+			my $author_info = $1;
+			if ($author_info =~ /<([^>]+)>/) {
+				$author_email = $1;
+			}
+		}
+
 #check the patch for a signoff:
 		if ($line =~ /^\s*signed-off-by:/i) {
 			# This is a signoff, if ugly, so do not double report.
@@ -1811,6 +1821,28 @@ sub process {
 			}
 		}
 
+# Check for duplicate trailers and self-review
+		if (!$in_header_lines &&
+		    $line =~ /^\s*([A-Z][a-zA-Z]*(?:-[a-zA-Z]+)*):\s*(.+)/) {
+			my $trailer_type = $1;
+			my $trailer_value = $2;
+			$trailer_value =~ s/\s+$//;
+			my $trailer_key = lc("$trailer_type: $trailer_value");
+
+			if (exists $commit_trailers{$trailer_key}) {
+				WARN("Duplicate '$trailer_type' trailer\n" .
+					$herecurr);
+			}
+			$commit_trailers{$trailer_key} = 1;
+
+			if ($trailer_type =~ /^(?:Reviewed|Tested|Acked)-by$/ &&
+			    $author_email ne '' &&
+			    $trailer_value =~ /<\Q$author_email\E>/i) {
+				WARN("$trailer_type from the patch author\n" .
+					$herecurr);
+			}
+		}
+
 # Check SPDX-License-Identifier references a permitted license
 		if (($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) &&
 			$rawline !~ /^-/) {
-- 
2.55.0


