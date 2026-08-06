Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1249C56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws1fQ-0006vl-Al; Thu, 06 Aug 2026 13:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ws1fN-0006vT-Pm
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ws1fL-0006tU-M9
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786036426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2lqJ7GbnPnuHqImOhswYpmNtCSUsC4Xz4VtOHh25hyM=;
 b=aDJ+T0PxzDE5X3ZkAG6uyye3GSPhJyb4KYVg/OinoU5iQhcZtyrcTzOjiI3mDvaYf8quey
 A5dfgQ5c/p64cDWbo6bYxHytc86oagXUPI7Cmcd5PzFnYP5qym+WKMFyxL02qbiOFvjEVp
 HGfuTgsG1qoiBaKfRk9pVRrGrcBCX+g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-q9MUoBtQOYSlJVriORo7vQ-1; Thu,
 06 Aug 2026 13:13:39 -0400
X-MC-Unique: q9MUoBtQOYSlJVriORo7vQ-1
X-Mimecast-MFC-AGG-ID: q9MUoBtQOYSlJVriORo7vQ_1786036418
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18F351800BC0; Thu,  6 Aug 2026 17:13:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.82])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 069751956049; Thu,  6 Aug 2026 17:13:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4] scripts/checkpatch: validate Fixes: tag format and commit
 ancestry
Date: Thu,  6 Aug 2026 19:13:33 +0200
Message-ID: <20260806171333.328864-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Adapt the kernel's checkpatch Fixes: tag validation for QEMU.

Add a git_commit_info() helper to resolve commit hashes and validate
the Fixes: tag in commit messages. The canonical form is:

  Fixes: <12+ chars of sha1> ("<title line>")

The check validates capitalization, spacing, hash length, lowercase
hex, and quoted title. When the format is wrong and the commit can
be resolved, suggest the corrected Fixes: line.

When running inside a git repository, also verify that the referenced
commit is an ancestor of master.

Lines matching "Fixes: CVE-*" are skipped. The check can be disabled
with --no-fixes-tag.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v4:
 - Added chomp to fix false positives 
 
 Changes in v3:
 - Dropped $git_command 
 - Modified git_commit_info() to use $! instead of parsing stderr when
   calling git log
 
 Changes in v2:
 - Introduced $git_command

 scripts/checkpatch.pl | 66 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 03f35e75012c8c7a00b67f036e4befb2ea162d4a..d9efade05386b3fb7647097cfe3b1256d7f24dda 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -21,6 +21,7 @@ use Getopt::Long qw(:config no_auto_abbrev);
 my $quiet = 0;
 my $tree = 1;
 my $chk_signoff = 1;
+my $chk_fixes_tag = 1;
 my $chk_patch = undef;
 my $chk_branch = undef;
 my $tst_only;
@@ -54,6 +55,7 @@ Options:
   -q, --quiet                quiet
   --no-tree                  run without a qemu tree
   --no-signoff               do not check for 'Signed-off-by' line
+  --no-fixes-tag             do not check for 'Fixes:' tag
   --patch                    treat FILE as patchfile
   --branch                   treat args as GIT revision list
   --emacs                    emacs compile window format
@@ -94,6 +96,7 @@ GetOptions(
 	'q|quiet+'		=> \$quiet,
 	'tree!'			=> \$tree,
 	'signoff!'		=> \$chk_signoff,
+	'fixes-tag!'		=> \$chk_fixes_tag,
 	'patch!'		=> \$chk_patch,
 	'branch!'		=> \$chk_branch,
 	'emacs!'		=> \$emacs,
@@ -441,6 +444,10 @@ sub build_types {
 build_types();
 
 $chk_signoff = 0 if ($file);
+$chk_fixes_tag = 0 if ($file);
+
+my $gitroot = $ENV{'GIT_DIR'};
+$gitroot = ".git" if !defined($gitroot);
 
 my @rawlines = ();
 my @lines = ();
@@ -561,6 +568,24 @@ sub which {
 	return "";
 }
 
+sub git_commit_info {
+	my ($commit, $id, $desc) = @_;
+
+	return ($id, $desc) if ((which("git") eq "") || !(-e "$gitroot"));
+
+	my $output = `git log --no-color --format='%H %s' -1 $commit 2>/dev/null`;
+	if ($? != 0) {
+		$id = undef;
+	} else {
+		chomp $output;
+		$output =~ s/^\s*//gm;
+		$id = substr($output, 0, 12);
+		$desc = substr($output, 41);
+	}
+
+	return ($id, $desc);
+}
+
 sub expand_tabs {
 	my ($str) = @_;
 
@@ -1811,6 +1836,47 @@ sub process {
 			}
 		}
 
+# Check Fixes: tag format and commit validity
+		if ($chk_fixes_tag &&
+		    $line =~ /^\s*(fixes:?)\s*(?:commit\s*)?([0-9a-f]{5,40})\s*(.*)?/i) {
+			my $tag = $1;
+			my $orig_commit = $2;
+			my $title = $3;
+
+			if ($line !~ /^\s*Fixes:\s+CVE/i) {
+				my $tag_case = not ($tag eq "Fixes:");
+				my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40}/i);
+				my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/);
+				my $id_case = not ($orig_commit !~ /[A-F]/);
+
+				my $id = "0123456789ab";
+				my $description = "commit title";
+				my $has_quotes = 0;
+
+				if (defined $title && $title =~ /^\("(.*?)"\)$/) {
+					$description = $1 if ($1);
+					$has_quotes = 1;
+				} elsif (defined $title && $title =~ /^\(?(.*?)\)?$/) {
+					$description = $1 if ($1);
+				}
+
+				my ($cid, $ctitle) = git_commit_info($orig_commit, $id, $description);
+
+				if (defined($cid) && ($ctitle ne $description || $tag_case || $tag_space || $id_length || $id_case || !$has_quotes)) {
+					my $fixed = "Fixes: $cid (\"$ctitle\")";
+					WARN("Please use correct Fixes: style 'Fixes: <12+ chars of sha1> (\"<title line>\")'" .
+						" - ie: '$fixed'\n" . $herecurr);
+				}
+				if (which("git") ne "" && -e "$gitroot") {
+					my $hash = defined($cid) ? $cid : $orig_commit;
+					`git merge-base --is-ancestor $hash master 2>/dev/null`;
+					if ($? != 0) {
+						WARN("Fixes: commit $hash is not an ancestor of master\n" . $herecurr);
+					}
+				}
+			}
+		}
+
 # Check SPDX-License-Identifier references a permitted license
 		if (($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) &&
 			$rawline !~ /^-/) {
-- 
2.55.0


