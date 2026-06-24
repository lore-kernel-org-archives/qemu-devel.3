Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E19ECDE003
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMjp-0004qa-HR; Wed, 24 Jun 2026 08:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcMjn-0004os-FB
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcMjl-0003zA-WD
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782304189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P2QdCCjs7Pn7jPyGOG0RIC6ESJuOJcHGoFwsMP/iqpI=;
 b=SwFqFn6xfQBa15zPFmCZzqn6C1JbbB9CTiQPbPTS2n6gWvdSyqIcPEG2WctnaAhqjHueN6
 DKwV0oW007AwfPc+Khmfd0ymed1qc2z2QTeFHcL9pScm5QPsEbx6Ynu/+1Z3wDX8pTE//3
 Yc7Bn/fYpKTbWMY/IoJVpN0QpcmWrqc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-MNpvrW2YP9-FKcXCNsqCeQ-1; Wed,
 24 Jun 2026 08:29:45 -0400
X-MC-Unique: MNpvrW2YP9-FKcXCNsqCeQ-1
X-Mimecast-MFC-AGG-ID: MNpvrW2YP9-FKcXCNsqCeQ_1782304184
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 908E91805A0D; Wed, 24 Jun 2026 12:29:44 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2CDD180049F; Wed, 24 Jun 2026 12:29:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/2] get_maintainer: add ability to report Git Lab handle
Date: Wed, 24 Jun 2026 13:29:36 +0100
Message-ID: <20260624122936.2706393-3-berrange@redhat.com>
In-Reply-To: <20260624122936.2706393-1-berrange@redhat.com>
References: <20260624122936.2706393-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 scripts/get_maintainer.pl | 42 +++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 76be402e11..1f518b6792 100755
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
@@ -1077,10 +1102,15 @@ sub push_email_address {
 	return 0;
     }
 
+    my $gitlab_handle;
+    if (exists $gitlabmap{$name}) {
+	$gitlab_handle = $gitlabmap{$name};
+    }
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
@@ -2026,10 +2056,14 @@ sub merge_email {
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
2.54.0


