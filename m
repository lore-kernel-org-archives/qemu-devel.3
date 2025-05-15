Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40D9C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 14:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFZ8D-0002ax-KU; Thu, 15 May 2025 10:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFZ89-0002a5-J4
 for qemu-devel@nongnu.org; Thu, 15 May 2025 10:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFZ86-000857-Bx
 for qemu-devel@nongnu.org; Thu, 15 May 2025 10:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747317609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mflY1Lwpkm9HezKk09xW5TZteq3I7eD4udb269k+Byg=;
 b=UGKtDaRvs86gM6W4f/T/tNJPW0ropTmpGOM5Ox2F2kcoB2IFSPWPnjacFNb4S5MGfCrfjy
 GZrIKtiIS2fQ7rvV0k4eLzemu2lkxbW+A2yghEVrK8QmDxlZqyOfha5BZmM6fbOudJ6+Nl
 CJ+HvNqLqltvX6NBGOu62eTon7INxck=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-nUNDiZuPObq37r0F8H7myQ-1; Thu,
 15 May 2025 10:00:06 -0400
X-MC-Unique: nUNDiZuPObq37r0F8H7myQ-1
X-Mimecast-MFC-AGG-ID: nUNDiZuPObq37r0F8H7myQ_1747317605
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15DB318001CC; Thu, 15 May 2025 14:00:05 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.135])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D13230075D4; Thu, 15 May 2025 14:00:03 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 9/9] scripts/checkpatch: reject license boilerplate on new
 files
Date: Thu, 15 May 2025 14:59:36 +0100
Message-ID: <20250515135936.86760-10-berrange@redhat.com>
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

The previous commit mandates use of SPDX-License-Identifier on common
source files, and encourages it on all other files.

Some contributors are none the less still also including the license
boilerplate text. This is redundant and will potentially cause
trouble if inconsistent with the SPDX declaration.

Match common boilerplate text blurbs and report them as invalid,
for newly added files.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 87050e6677..cb1942c021 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1496,6 +1496,13 @@ sub process_end_of_file {
 			     "' need 'SPDX-License-Identifier'?");
 		}
 	}
+	if ($fileinfo->{action} eq "new" &&
+	    !exists $fileinfo->{facts}->{sawboilerplate}) {
+		ERROR("New file '" . $fileinfo->{filenew} . "' must " .
+		      "not have license boilerplate header text unless " .
+		      "this file is copied from existing code with such " .
+		      "text already present.");
+	}
 }
 
 sub process {
@@ -1798,6 +1805,15 @@ sub process {
 			&checkspdx($realfile, $1);
 		}
 
+		if ($rawline =~ /licensed under the terms of the GNU GPL/ ||
+		    $rawline =~ /under the terms of the GNU General Public License/ ||
+		    $rawline =~ /under the terms of the GNU Lesser General Public/ ||
+		    $rawline =~ /Permission is hereby granted, free of charge/ ||
+		    $rawline =~ /GNU GPL, version 2 or later/ ||
+		    $rawline =~ /See the COPYING file/) {
+			$fileinfo->{facts}->{sawboilerplate} = 1;
+		}
+
 		if ($rawline =~ m,(SPDX-[a-zA-Z0-9-_]+):,) {
 			my $tag = $1;
 			my @permitted = qw(
-- 
2.49.0


