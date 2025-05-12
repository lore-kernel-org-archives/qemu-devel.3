Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF1BC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXq0-0003P8-RI; Mon, 12 May 2025 14:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEXpr-0003KV-5t
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEXpl-0002dq-G4
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747074300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gw4dd2QSOv6XRkiJ8PdXqG5e+/IIosT1Cw9Q3h7RFu0=;
 b=E/9EclVZydUec54szx3gtZvCVQpNes4t+8kbmjx5LddGSv8hoGsPASkKPSKwBe38VKDY16
 xnS0ng2lkwiLu5IOxH5/DU1PnIn8DjB9x7Tzo/H9saGlwbAhLYwsk44XNsH/0r3H7rimRX
 mrSFYjwwz63A0t8P+7L3WZNgU15isN4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-dLRFyk7aPluE_PM0NHHoPg-1; Mon,
 12 May 2025 14:24:57 -0400
X-MC-Unique: dLRFyk7aPluE_PM0NHHoPg-1
X-Mimecast-MFC-AGG-ID: dLRFyk7aPluE_PM0NHHoPg_1747074296
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D63D5195608B; Mon, 12 May 2025 18:24:55 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.162])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EE4D19560A3; Mon, 12 May 2025 18:24:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 3/7] scripts/checkpatch: introduce tracking of file
 start/end
Date: Mon, 12 May 2025 19:24:43 +0100
Message-ID: <20250512182447.1139105-4-berrange@redhat.com>
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

Some checks want to be performed either at the start of a new file
within a patch, or at the end. This is complicated by the fact that
the information relevant to the check may be spread across multiple
lines. It is further complicated by a need to support both git and
non-git diffs, and special handling for renames where there might
not be any patch hunks.

To handle this more sanely, introduce explicit tracking of file
start/end, taking account of git metadata, and calling a hook
function at each transition.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 109 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7675418b0b..b74391e63a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1417,6 +1417,38 @@ sub checkspdx {
     }
 }
 
+# All three of the methods below take a 'file info' record
+# which is a hash ref containing
+#
+#  'isgit': is this from an enhanced git diff or plain diff
+#  'linestart': line number of start of file diff
+#  'lineend': line number of end of file diff
+#  'filenew': the new filename
+#  'fileold': the old filename (same as 'new filename' except
+#             for renames in git diffs)
+#  'action': one of 'modified' (always) or 'new' or 'deleted' or
+#            'renamed' (git diffs only)
+#  'mode': file mode for new/deleted files (git diffs only)
+#  'similarity': file similarity when renamed (git diffs only)
+#  'facts': hash ref for storing any metadata related to checks
+#
+
+# Called at the end of each patch, with the list of
+# real filenames that were seen in the patch
+sub process_file_list {
+	my @fileinfos = @_;
+}
+
+# Called at the start of processing a diff hunk for a file
+sub process_start_of_file {
+	my $fileinfo = shift;
+}
+
+# Called at the end of processing a diff hunk for a file
+sub process_end_of_file {
+	my $fileinfo = shift;
+}
+
 sub process {
 	my $filename = shift;
 
@@ -1453,7 +1485,10 @@ sub process {
 	my $realfile = '';
 	my $realline = 0;
 	my $realcnt = 0;
+	my $fileinfo;
+	my @fileinfolist;
 	my $here = '';
+	my $oldhere = '';
 	my $in_comment = 0;
 	my $comment_edge = 0;
 	my $first_line = 0;
@@ -1591,17 +1626,56 @@ sub process {
 		$prefix = "$filename:$realline: " if ($emacs && $file);
 		$prefix = "$filename:$linenr: " if ($emacs && !$file);
 
+		$oldhere = $here;
 		$here = "#$linenr: " if (!$file);
 		$here = "#$realline: " if ($file);
 
 		# extract the filename as it passes
-		if ($line =~ /^diff --git.*?(\S+)$/) {
-			$realfile = $1;
-			$realfile =~ s@^([^/]*)/@@ if (!$file);
+		if ($line =~ /^diff --git\s+(\S+)\s+(\S+)$/) {
+			my $fileold = $1;
+			my $filenew = $2;
+
+			if (defined $fileinfo) {
+				$fileinfo->{lineend} = $oldhere;
+				process_end_of_file($fileinfo)
+		        }
+			$fileold =~ s@^([^/]*)/@@ if (!$file);
+			$filenew =~ s@^([^/]*)/@@ if (!$file);
+			$realfile = $filenew;
 	                checkfilename($realfile, \$acpi_testexpected, \$acpi_nontestexpected);
+
+			$fileinfo = {
+				"isgit" => 1,
+				"githeader" => 1,
+				"linestart" => $here,
+				"lineend" => 0,
+				"fileold" => $fileold,
+				"filenew" => $filenew,
+				"action" => "modified",
+				"mode" => 0,
+				"similarity" => 0,
+				"facts" => {},
+		        };
+			push @fileinfolist, $fileinfo;
+		} elsif (defined $fileinfo && $fileinfo->{githeader} &&
+			 $line =~ /^(new|deleted) (?:file )?mode\s+([0-7]+)$/) {
+			$fileinfo->{action} = $1;
+			$fileinfo->{mode} = oct($2);
+		} elsif (defined $fileinfo && $fileinfo->{githeader} &&
+			 $line =~ /^similarity index (\d+)%/) {
+			$fileinfo->{similarity} = int($1);
+		} elsif (defined $fileinfo && $fileinfo->{githeader} &&
+			 $line =~ /^rename (from|to) [\w\/\.\-]+\s*$/) {
+			$fileinfo->{action} = "renamed";
+			# For a no-change rename, we'll never have any "+++..."
+			# lines, so trigger actions now
+			if ($1 eq "to" && $fileinfo->{similarity} == 100)  {
+				process_start_of_file($fileinfo);
+			}
 		} elsif ($line =~ /^\+\+\+\s+(\S+)/) {
 			$realfile = $1;
 			$realfile =~ s@^([^/]*)/@@ if (!$file);
+
 	                checkfilename($realfile, \$acpi_testexpected, \$acpi_nontestexpected);
 
 			$p1_prefix = $1;
@@ -1610,6 +1684,30 @@ sub process {
 				WARN("patch prefix '$p1_prefix' exists, appears to be a -p0 patch\n");
 			}
 
+			if (defined $fileinfo && !$fileinfo->{isgit}) {
+				$fileinfo->{lineend} = $oldhere;
+				process_end_of_file($fileinfo);
+			}
+
+			if (!defined $fileinfo || !$fileinfo->{isgit}) {
+				$fileinfo = {
+					"isgit" => 0,
+					"githeader" => 0,
+					"linestart" => $here,
+					"lineend" => 0,
+					"fileold" => $realfile,
+					"filenew" => $realfile,
+					"action" => "modified",
+					"mode" => 0,
+					"similarity" => 0,
+					"facts" => {},
+			        };
+				push @fileinfolist, $fileinfo;
+			} else {
+				$fileinfo->{githeader} = 0;
+			}
+			process_start_of_file($fileinfo);
+
 			next;
 		}
 
@@ -3213,6 +3311,11 @@ sub process {
 		}
 	}
 
+	if (defined $fileinfo) {
+		process_end_of_file($fileinfo);
+	}
+	process_file_list(@fileinfolist);
+
 	if ($is_patch && $chk_signoff && $signoff == 0) {
 		ERROR("Missing Signed-off-by: line(s)\n");
 	}
-- 
2.49.0


