Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C56C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 16:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3V0-0002ss-3n; Mon, 19 May 2025 12:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH3Uy-0002p9-IQ
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH3Uw-0005ke-U5
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747672674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3v48TWij8rjIJBWVr32ofNj1KQbwMmnbi8Jfg7B65Q4=;
 b=DnnSwCB5+UUmG+pzC8WybEyQ04Sh3yMSF5MareXadRhD9LZSYij6KmsxgkMoWSz1BMjTB/
 XVdCQyn90Gs/KIdpeodOcahk3IQdvfVsD1lvIOP066q81gpOVZqUziCVoTQDYr2H15iKUz
 GlrPgTQ8MXKnUpiuVpZW12wIv1yh9qA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-bjJLirAaMsKFUaOPYEyiMA-1; Mon,
 19 May 2025 12:37:51 -0400
X-MC-Unique: bjJLirAaMsKFUaOPYEyiMA-1
X-Mimecast-MFC-AGG-ID: bjJLirAaMsKFUaOPYEyiMA_1747672670
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6EB8195608C; Mon, 19 May 2025 16:37:50 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.50])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E03AC19560A3; Mon, 19 May 2025 16:37:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 9/9] scripts/checkpatch: reject license boilerplate on new
 files
Date: Mon, 19 May 2025 17:37:21 +0100
Message-ID: <20250519163721.347322-10-berrange@redhat.com>
In-Reply-To: <20250519163721.347322-1-berrange@redhat.com>
References: <20250519163721.347322-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

The previous commit mandates use of SPDX-License-Identifier on common
source files, and encourages it on all other files.

Some contributors are none the less still also including the license
boilerplate text. This is redundant and will potentially cause
trouble if inconsistent with the SPDX declaration.

Match common boilerplate text blurbs and report them as invalid,
for newly added files.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index dc2c3e6aa1..691c267a8c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -365,6 +365,17 @@ our @typeList = (
 	qr{guintptr},
 );
 
+# Match text found in common license boilerplate comments:
+# for new files the SPDX-License-Identifier line is sufficient.
+our $LICENSE_BOILERPLATE = qr{
+    licensed under the terms of the GNU GPL|
+    under the terms of the GNU General Public License|
+    under the terms of the GNU Lesser General Public|
+    Permission is hereby granted, free of charge|
+    GNU GPL, version 2 or later|
+    See the COPYING file
+}x;
+
 # Load common spelling mistakes and build regular expression list.
 my $misspellings;
 my %spelling_fix;
@@ -1497,6 +1508,13 @@ sub process_end_of_file {
 			     "' need 'SPDX-License-Identifier'?");
 		}
 	}
+	if ($fileinfo->{action} eq "new" &&
+	    !exists $fileinfo->{facts}->{sawboilerplate}) {
+		ERROR("New file '" . $fileinfo->{filenew} . "' must " .
+		      "not have license boilerplate header text, only " .
+		      "the SPDX-License-Identifier, unless this file was " .
+		      "copied from existing code already having such text.");
+	}
 }
 
 sub process {
@@ -1799,6 +1817,10 @@ sub process {
 			&checkspdx($realfile, $1);
 		}
 
+		if ($rawline =~ /$LICENSE_BOILERPLATE/) {
+			$fileinfo->{facts}->{sawboilerplate} = 1;
+		}
+
 		if ($rawline =~ m,(SPDX-[a-zA-Z0-9-_]+):,) {
 			my $tag = $1;
 			my @permitted = qw(
-- 
2.49.0


