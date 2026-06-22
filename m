Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFC3CDB470
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbcsz-0000AD-PI; Mon, 22 Jun 2026 07:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbcsl-00008S-PK
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbcsj-0003Y5-Nb
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782127919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2iHkvTM8qQSv8jUlgYdv9MyagRPGGF3URjB34rzRfBY=;
 b=au1bGFnKKWQYwrlyrkruuYgprcb6ge7ePIk9jdy0tJNgCY9aWseYBnR322ZTvUUzYY9Nft
 ZleA1e4bchgbKUXJMiCrBmdw42jG2Y9sgCsLLDGHZ9jurKeQyWnu+yDghp7qUx9VIAQuz4
 YBORQg9jz6lfi10Ky0vcJ9xJHNOtNEc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-xvTALYsRPdCdKHGvj1DYIQ-1; Mon,
 22 Jun 2026 07:31:58 -0400
X-MC-Unique: xvTALYsRPdCdKHGvj1DYIQ-1
X-Mimecast-MFC-AGG-ID: xvTALYsRPdCdKHGvj1DYIQ_1782127917
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 462271955F7A
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 11:31:57 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.119])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BD5C195394E; Mon, 22 Jun 2026 11:31:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/3] get_maintainer: add ability to report Git Lab handle
Date: Mon, 22 Jun 2026 12:31:50 +0100
Message-ID: <20260622113152.1710585-2-berrange@redhat.com>
In-Reply-To: <20260622113152.1710585-1-berrange@redhat.com>
References: <20260622113152.1710585-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

One of more Git Lab handles will be recorded against subsystems
with the "G:" prefix. These can be displayed using the --gitlab
option to get_maintainer.pl

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/get_maintainer.pl | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 76be402e11..b88ffb2227 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -35,6 +35,7 @@ my $email_git_max_maintainers = 5;
 my $email_git_min_percent = 5;
 my $email_git_since = "1-year-ago";
 my $email_hg_since = "-365";
+my $gitlab = 0;
 my $interactive = 0;
 my $email_remove_duplicates = 1;
 my $email_use_mailmap = 1;
@@ -186,6 +187,7 @@ if (!GetOptions(
 		'n!' => \$email_usename,
 		'l!' => \$email_list,
 		's!' => \$email_subscriber_list,
+		'gitlab!' => \$gitlab,
 		'multiline!' => \$output_multiline,
 		'roles!' => \$output_roles,
 		'rolestats!' => \$output_rolestats,
@@ -227,6 +229,7 @@ $output_roles = 1 if ($output_rolestats);
 if ($sections) {
     $email = 0;
     $email_list = 0;
+    $gitlab = 0;
     $scm = 0;
     $status = 0;
     $subsystem = 0;
@@ -234,9 +237,9 @@ if ($sections) {
     $keywords = 0;
     $interactive = 0;
 } else {
-    my $selections = $email + $scm + $status + $subsystem + $web;
+    my $selections = $email + $scm + $status + $subsystem + $web + $gitlab;
     if ($selections == 0) {
-	die "$P:  Missing required option: email, scm, status, subsystem or web\n";
+	die "$P:  Missing required option: email, gitlab, scm, status, subsystem or web\n";
     }
 }
 
@@ -457,6 +460,7 @@ my %email_hash_address;
 my @email_to = ();
 my %hash_list_to;
 my @list_to = ();
+my @gitlab = ();
 my @scm = ();
 my @web = ();
 my @subsystem = ();
@@ -471,6 +475,11 @@ if (@maintainers) {
     output(@maintainers);
 }
 
+if ($gitlab) {
+    @gitlab = uniq(@gitlab);
+    output(@gitlab);
+}
+
 if ($scm) {
     @scm = uniq(@scm);
     output(@scm);
@@ -536,6 +545,7 @@ sub get_maintainers {
     %hash_list_to = ();
     @list_to = ();
     @scm = ();
+    @gitlab = ();
     @web = ();
     @subsystem = ();
     @status = ();
@@ -731,6 +741,7 @@ MAINTAINER field selection options:
     --roles => show roles (status:subsystem, git-signer, list, etc...)
     --rolestats => show roles and statistics (commits/total_commits, %)
     --file-emails => add email addresses found in -f file (default: 0 (off))
+  --gitlab => print GitLab handle(s) if any
   --scm => print SCM tree(s) if any
   --status => print status if any
   --subsystem => print subsystem name if any
@@ -1049,6 +1060,8 @@ sub add_categories {
 		}
 	    } elsif ($ptype eq "T") {
 		push(@scm, $pvalue);
+	    } elsif ($ptype eq "G") {
+		push(@gitlab, $pvalue);
 	    } elsif ($ptype eq "W") {
 		push(@web, $pvalue);
 	    } elsif ($ptype eq "S") {
-- 
2.54.0


