Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0A9C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk1j9-0004XI-M0; Wed, 15 Jul 2026 11:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wk1j5-0004Rb-Jz
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wk1j4-0003J3-5Q
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784130044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9XVUA1DYk68WU40xhaLZ0hERsnYIbdHDQLYZpF97ME=;
 b=h/JT9rGrMb6PELj64Iw3NSTQ02wzoYaiAjFON2JaAdq2+c+P0bofEutrnjiNgcDIVBmRF1
 CMuYo+XyEmfJ8lZLMm9m2tLDwyX/b4TrL7FlsEF3WMb1Hf64ZGcklaGrlzItYm90O/hV7H
 USHt6CoHRvmxGTbvywUb8XV8nxBdjmw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-ENIBUgdRMRCr4fwAlzZJIQ-1; Wed,
 15 Jul 2026 11:40:39 -0400
X-MC-Unique: ENIBUgdRMRCr4fwAlzZJIQ-1
X-Mimecast-MFC-AGG-ID: ENIBUgdRMRCr4fwAlzZJIQ_1784130038
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC73C1956063; Wed, 15 Jul 2026 15:40:37 +0000 (UTC)
Received: from berrange.com (unknown [10.44.34.221])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 118451800576; Wed, 15 Jul 2026 15:40:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 2/2] get_maintainer: add ability to report Git Lab handle
Date: Wed, 15 Jul 2026 16:40:29 +0100
Message-ID: <20260715154029.1216464-3-berrange@redhat.com>
In-Reply-To: <20260715154029.1216464-1-berrange@redhat.com>
References: <20260715154029.1216464-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

With the GitLab mapping files from the previous commit, the
get_manitainer.pl script is now able to report the gitlab
handle for each maintainer/reviewer when displaying output.

For example:

  $ ./scripts/get_maintainer.pl -f hw/scsi/lsi53c895a.c
  Paolo Bonzini <pbonzini@redhat.com> (supporter:SCSI, gitlab:@bonzini)
  Fam Zheng <fam@euphon.net> (reviewer:SCSI, gitlab:@famzheng)
  qemu-devel@nongnu.org (open list:All patches CC here)

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/get_maintainer.pl | 51 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 76be402e11..9679f27413 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -365,6 +365,31 @@ sub read_mailmap {
     close($mailmap_file);
 }
 
+my %gitlabmap;
+
+read_gitlabmap(".gitlab-map-auto");
+read_gitlabmap(".gitlab-map-manual");
+
+sub read_gitlabmap {
+    my $mapfile = shift;
+    open MAP, "<$mapfile"
+	or die "cannot open $mapfile: $!";
+
+    while (<MAP>) {
+	next if /^#/;
+	next if /^\s*$/;
+
+	if (/^(\S+)\t(.*)$/) {
+	    my $handle = $1;
+	    my $realname = $2;
+
+	    $gitlabmap{$realname} = $handle;
+	}
+    }
+
+    close MAP;
+}
+
 ## use the filenames on the command line or find the filenames in the patchfiles
 
 my @files = ();
@@ -1068,6 +1093,18 @@ sub email_inuse {
     return 0;
 }
 
+sub gitlab_handle {
+    my $name = shift;
+
+    $name =~ s/"//g;
+
+    my $gitlab_handle;
+    if (exists $gitlabmap{$name}) {
+	return $gitlabmap{$name};
+    }
+    return undef;
+}
+
 sub push_email_address {
     my ($line, $role) = @_;
 
@@ -1077,10 +1114,12 @@ sub push_email_address {
 	return 0;
     }
 
+    my $gitlab_handle = gitlab_handle($name);
+
     if (!$email_remove_duplicates) {
-	push(@email_to, [format_email($name, $address, $email_usename), $role]);
+	push(@email_to, [format_email($name, $address, $email_usename), $role, $gitlab_handle]);
     } elsif (!email_inuse($name, $address)) {
-	push(@email_to, [format_email($name, $address, $email_usename), $role]);
+	push(@email_to, [format_email($name, $address, $email_usename), $role, $gitlab_handle]);
 	$email_hash_name{lc($name)}++ if ($name ne "");
 	$email_hash_address{lc($address)}++;
     }
@@ -2026,10 +2065,14 @@ sub merge_email {
     my %saw;
 
     for (@_) {
-	my ($address, $role) = @$_;
+	my ($address, $role, $gitlab_handle) = @$_;
 	if (!$saw{$address}) {
 	    if ($output_roles) {
-		push(@lines, "$address ($role)");
+		if (defined $gitlab_handle) {
+		    push(@lines, "$address ($role, gitlab:\@$gitlab_handle)");
+		} else {
+		    push(@lines, "$address ($role)");
+		}
 	    } else {
 		push(@lines, $address);
 	    }
-- 
2.55.0


