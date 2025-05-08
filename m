Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E48C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 17:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD4ci-0007eL-1c; Thu, 08 May 2025 13:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD4cW-0007QY-38
 for qemu-devel@nongnu.org; Thu, 08 May 2025 13:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD4cS-0004A3-2e
 for qemu-devel@nongnu.org; Thu, 08 May 2025 13:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746723669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IV/KVgp6JmcqDg6Pzi4KZdTBDmTw3g2Q4TDbOLBzvvM=;
 b=c7b8Gp0sETy35WdTW/WtXJYSWvqn+z+BCXQ/rwj9VbC8VKiWtfkDyY0V2ekwGxpWy54wJK
 5lUmnZcLs4m0J2hVCTH3aOBtiH65ZFxppZ2sE3eYN7kKcvYg3bu4U80RtO5ruskNJP/sz/
 7fQ2+U+KuV//GAffO9wzDtDBhfMDT5I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-31Zqf4STMvmwHYt12dPQkQ-1; Thu,
 08 May 2025 13:01:08 -0400
X-MC-Unique: 31Zqf4STMvmwHYt12dPQkQ-1
X-Mimecast-MFC-AGG-ID: 31Zqf4STMvmwHYt12dPQkQ_1746723667
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 035AD1800878; Thu,  8 May 2025 17:01:07 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.138])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3DE71955F24; Thu,  8 May 2025 17:01:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] scripts/checkpatch: reimplement SPDX-License-Identifier
 detection
Date: Thu,  8 May 2025 18:01:00 +0100
Message-ID: <20250508170100.876374-3-berrange@redhat.com>
In-Reply-To: <20250508170100.876374-1-berrange@redhat.com>
References: <20250508170100.876374-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The new attempt at detecting missing SPDX-License-Identifier in
new files is using the following logic

 * When seeing a line starting 'diff --git ...' it indicates
   the start of a file in the patch. This must trigger reporting
   of violations in the previous file (if any).

   It must reset the validation state, since this may now be a
   pre-existing file being changed. This will be resolved by
   the next rule.

 * When seeing a line starting 'new file mode...' it indicates
   a newly created file and must enable SPDX validation.

 * When seeing EOF, it must trigger reporting of violations in
   the last new file in the patch, if any.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 56 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d355c0dad5..5da0f85e08 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1353,7 +1353,22 @@ sub checkfilename {
 	}
 }
 
-sub checkspdx {
+sub check_spdx_present {
+    my $expect_spdx_file = shift;
+
+    if ($expect_spdx_file =~
+	/\.(c|h|py|pl|sh|json|inc|Makefile)$/) {
+	# source code files MUST have SPDX license declared
+	ERROR("New file '$expect_spdx_file' requires " .
+	      "'SPDX-License-Identifier'");
+    } else {
+	# Other files MAY have SPDX license if appropriate
+	WARN("Does new file '$expect_spdx_file' need " .
+	     "'SPDX-License-Identifier'?");
+    }
+}
+
+sub check_spdx_expression {
     my ($file, $expr) = @_;
 
     # Imported Linux headers probably have SPDX tags, but if they
@@ -1442,6 +1457,8 @@ sub process {
 	my $in_imported_file = 0;
 	my $in_no_imported_file = 0;
 	my $non_utf8_charset = 0;
+	my $expect_spdx = 0;
+	my $expect_spdx_file;
 
 	our @report = ();
 	our $cnt_lines = 0;
@@ -1679,9 +1696,38 @@ sub process {
 			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
 		}
 
+# All new files should have a SPDX-License-Identifier tag
+		if ($line =~ /^diff --git/) {
+		    # Start of file diff marker, report last file if it failed
+		    # SPDX validation
+		    if (defined $expect_spdx_file) {
+			&check_spdx_present($expect_spdx_file);
+		    }
+
+		    # Reset state ready to find new file
+		    $expect_spdx = 0;
+		    $expect_spdx_file = undef;
+		} elsif ($line =~ /^new file mode\s*\d+\s*$/) {
+		    # This diff block is a new file, so we must
+		    # mandate a SPDX tag
+		    $expect_spdx = 1;
+		} elsif ($expect_spdx) {
+		    # Capture filename if don't already have it
+		    $expect_spdx_file = $realfile unless
+			defined $expect_spdx_file;
+
+		    # SPDX tags may occurr in comments which were
+		    # stripped from '$line', so use '$rawline'. If
+		    # we see one we pass validation
+		    if ($rawline =~ /SPDX-License-Identifier/) {
+			$expect_spdx = 0;
+			$expect_spdx_file = undef;
+		    }
+		}
+
 # Check SPDX-License-Identifier references a permitted license
 		if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
-		    &checkspdx($realfile, $1);
+		    &check_spdx_expression($realfile, $1);
 		}
 
 		if ($rawline =~ m,(SPDX-[a-zA-Z0-9-_]+):,) {
@@ -3213,6 +3259,12 @@ sub process {
 		}
 	}
 
+	# End of diff, report last file block if it failed
+	# SPDX validation
+	if (defined $expect_spdx_file) {
+	    &check_spdx_present($expect_spdx_file);
+	}
+
 	if ($is_patch && $chk_signoff && $signoff == 0) {
 		ERROR("Missing Signed-off-by: line(s)\n");
 	}
-- 
2.49.0


