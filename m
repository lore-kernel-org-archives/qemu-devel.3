Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0208FC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 14:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFZ8A-0002aN-DR; Thu, 15 May 2025 10:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFZ88-0002Zu-8k
 for qemu-devel@nongnu.org; Thu, 15 May 2025 10:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFZ85-00084m-04
 for qemu-devel@nongnu.org; Thu, 15 May 2025 10:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747317607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JeIVo8pFBhGwePw+lJWl1S6B17za87Izgj/+xZPl7/Y=;
 b=AvSXnwvtqfsuXAePJ2rEBz2v4qW/HIXa7ZXyodYcBO9DNQbf1LE+aC0Ff4dTCjaq+QZDJq
 c8+lNmT1jiz5l8RefUGUqeF7aMDuXE1IEJUMhb6ZlgBFcNeQDYMdKotTaJ9mds8Zto/f3s
 I3xMjm5S1CXGGFnsIj7FXLh3ui32tEk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-g7l3GDavMBa1VDWAxEYgGw-1; Thu,
 15 May 2025 10:00:04 -0400
X-MC-Unique: g7l3GDavMBa1VDWAxEYgGw-1
X-Mimecast-MFC-AGG-ID: g7l3GDavMBa1VDWAxEYgGw_1747317603
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED87D19560B1; Thu, 15 May 2025 14:00:02 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.135])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20B1C30075D4; Thu, 15 May 2025 14:00:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 8/9] scripts/checkpatch: reimplement mandate for
 SPDX-License-Identifier
Date: Thu, 15 May 2025 14:59:35 +0100
Message-ID: <20250515135936.86760-9-berrange@redhat.com>
In-Reply-To: <20250515135936.86760-1-berrange@redhat.com>
References: <20250515135936.86760-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Going forward we want all newly created source files to have an
SPDX-License-Identifier tag present.

Initially mandate this for C, Python, Perl, Shell source files,
as well as JSON (QAPI) and Makefiles, while encouraging users
to consider it for other file types.

The new attempt at detecting missing SPDX-License-Identifier relies
on the hooks for relying triggering logic at the end of scanning a
new file in the diff.

Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6adef12871..87050e6677 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1482,6 +1482,20 @@ sub process_start_of_file {
 # Called at the end of processing a diff hunk for a file
 sub process_end_of_file {
 	my $fileinfo = shift;
+
+	if ($fileinfo->{action} eq "new" &&
+	    !exists $fileinfo->{facts}->{sawspdx}) {
+		if ($fileinfo->{filenew} =~
+		    /(\.(c|h|py|pl|sh|json|inc)|Makefile.*)$/) {
+			# source code files MUST have SPDX license declared
+			ERROR("New file '" . $fileinfo->{filenew} .
+			      "' requires 'SPDX-License-Identifier'");
+		} else {
+			# Other files MAY have SPDX license if appropriate
+			WARN("Does new file '" . $fileinfo->{filenew} .
+			     "' need 'SPDX-License-Identifier'?");
+		}
+	}
 }
 
 sub process {
@@ -1780,6 +1794,7 @@ sub process {
 
 # Check SPDX-License-Identifier references a permitted license
 		if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
+			$fileinfo->{facts}->{sawspdx} = 1;
 			&checkspdx($realfile, $1);
 		}
 
-- 
2.49.0


