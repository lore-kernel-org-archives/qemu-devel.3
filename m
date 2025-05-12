Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20212C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXqx-0004Ri-Eh; Mon, 12 May 2025 14:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEXps-0003Nv-PP
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEXpq-0002pM-Kf
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747074305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPi7TsdCUCbjJd188mz8wJdZpgOwHxDrFtk1yk04jD4=;
 b=iSsVkOt2C4V6HbbYL/+AOwbRl+rM5krPgBT7sgnnHERX//8edQl2s2XXtB8AjkEcc9LoKk
 kW1tVTcDju6FjUlDs5iufzgMdhSVCFUH7Eh/uXkZV/82obF+DN1FZGKmv3gQmn4Mz0fn9T
 Zvc/89N0zoQYvQfv7Qdwz9/4cHRrLNU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-ERY_-mOqNRCcVXr2bYpHGg-1; Mon,
 12 May 2025 14:25:02 -0400
X-MC-Unique: ERY_-mOqNRCcVXr2bYpHGg-1
X-Mimecast-MFC-AGG-ID: ERY_-mOqNRCcVXr2bYpHGg_1747074301
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5986F1955DE0; Mon, 12 May 2025 18:25:01 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.162])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E392B1955EA0; Mon, 12 May 2025 18:24:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 6/7] scripts/checkpatch: use new hook for MAINTAINERS
 update check
Date: Mon, 12 May 2025 19:24:46 +0100
Message-ID: <20250512182447.1139105-7-berrange@redhat.com>
In-Reply-To: <20250512182447.1139105-1-berrange@redhat.com>
References: <20250512182447.1139105-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

When seeing a new/deleted/renamed file we check to see if MAINTAINERS
is updated, but we don't give the user a list of files affected, as
we don't want to repeat the same warning many times over.

Using the new file list hook, we can give a single warning at the
end with a list of filenames included.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4a18daa384..d416a6dcf9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1442,6 +1442,25 @@ sub process_file_list {
 		      join("\n  ", @acpi_nontestexpected) .
 		      "\n\nfound in the same patch\n");
 	}
+
+	my $sawmaintainers = 0;
+	my @maybemaintainers;
+	foreach my $fileinfo (@fileinfos) {
+		if ($fileinfo->{action} ne "modified" &&
+		    $fileinfo->{filenew} !~ m#^tests/data/acpi/#) {
+			push @maybemaintainers, $fileinfo->{filenew};
+		}
+		if ($fileinfo->{filenew} eq "MAINTAINEfRS") {
+			$sawmaintainers = 1;
+		}
+	}
+
+	# If we don't see a MAINTAINERS update, prod the user to check
+	if (int(@maybemaintainers) > 0 && !$sawmaintainers) {
+		WARN("added, moved or deleted file(s):\n\n  " .
+		     join("\n  ", @maybemaintainers) .
+		     "\n\nDoes MAINTAINERS need updating?\n");
+	}
 }
 
 # Called at the start of processing a diff hunk for a file
@@ -1485,7 +1504,6 @@ sub process {
 
 	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
-	my $reported_maintainer_file = 0;
 	my $reported_mixing_imported_file = 0;
 	my $in_imported_file = 0;
 	my $in_no_imported_file = 0;
@@ -1760,23 +1778,6 @@ sub process {
 			}
 		}
 
-# Check if MAINTAINERS is being updated.  If so, there's probably no need to
-# emit the "does MAINTAINERS need updating?" message on file add/move/delete
-		if ($line =~ /^\s*MAINTAINERS\s*\|/) {
-			$reported_maintainer_file = 1;
-		}
-
-# Check for added, moved or deleted files
-		if (!$reported_maintainer_file && !$in_commit_log &&
-		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
-		     $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
-		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
-		      (defined($1) || defined($2)))) &&
-		    $realfile !~ m#^tests/data/acpi/#) {
-			$reported_maintainer_file = 1;
-			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
-		}
-
 # Check SPDX-License-Identifier references a permitted license
 		if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
 			&checkspdx($realfile, $1);
-- 
2.49.0


