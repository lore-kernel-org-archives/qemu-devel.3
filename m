Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782A7C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 16:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3Uq-0002lo-13; Mon, 19 May 2025 12:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH3Up-0002ld-2H
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH3Un-0005ji-HG
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747672664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h+dWRobRDbXf8iBk4tZlIYJHZdaGNMwO4PK4On7eRJ8=;
 b=DlIbTshw8m0SJ8taw62yAvmLjVEBVQGyWVaklq9QH/lyz/kpZn1vbWldvJkEYbCWlEN6nc
 OEd7GWbm4YsaHaCmQmfM7CvtJaavdhjvwc/xuNR+wOu8qfEaAa3+wOPKNMBYntUDxR5Crv
 jmzqN1m8yC0ugmocTnb7gHp9NruOcFQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-X_X-p9OyMB2N81h7YgHVFQ-1; Mon,
 19 May 2025 12:37:41 -0400
X-MC-Unique: X_X-p9OyMB2N81h7YgHVFQ-1
X-Mimecast-MFC-AGG-ID: X_X-p9OyMB2N81h7YgHVFQ_1747672660
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04AEC1800773; Mon, 19 May 2025 16:37:40 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.50])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD30619560A3; Mon, 19 May 2025 16:37:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 5/9] scripts/checkpatch: use new hook for file permissions
 check
Date: Mon, 19 May 2025 17:37:17 +0100
Message-ID: <20250519163721.347322-6-berrange@redhat.com>
In-Reply-To: <20250519163721.347322-1-berrange@redhat.com>
References: <20250519163721.347322-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

The file permissions check is the kind of check intended to be performed
in the new start of file hook.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 60c26dca06..e208222e75 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1448,6 +1448,17 @@ sub process_file_list {
 # Called at the start of processing a diff hunk for a file
 sub process_start_of_file {
 	my $fileinfo = shift;
+
+	# Check for incorrect file permissions
+	if ($fileinfo->{action} eq "new" && ($fileinfo->{mode} & 0111)) {
+		my $permhere = $fileinfo->{linestart} . "FILE: " .
+			$fileinfo->{filenew} . "\n";
+		if ($fileinfo->{filenew} =~
+		    /(\bMakefile(?:\.objs)?|\.(c|cc|cpp|h|mak|s|S))$/) {
+			ERROR("do not set execute permissions for source " .
+			      "files\n" . $permhere);
+		}
+	}
 }
 
 # Called at the end of processing a diff hunk for a file
@@ -1719,14 +1730,6 @@ sub process {
 
 		$cnt_lines++ if ($realcnt != 0);
 
-# Check for incorrect file permissions
-		if ($line =~ /^new (file )?mode.*[7531]\d{0,2}$/) {
-			my $permhere = $here . "FILE: $realfile\n";
-			if ($realfile =~ /(\bMakefile(?:\.objs)?|\.c|\.cc|\.cpp|\.h|\.mak|\.[sS])$/) {
-				ERROR("do not set execute permissions for source files\n" . $permhere);
-			}
-		}
-
 # Only allow Python 3 interpreter
 		if ($realline == 1 &&
 			$line =~ /^\+#!\ *\/usr\/bin\/(?:env )?python$/) {
-- 
2.49.0


