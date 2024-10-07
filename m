Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8F9CFB446
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxpvz-0005Nd-4d; Mon, 07 Oct 2024 11:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxpvu-0005Al-1N
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxpvs-0002ZX-Gb
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728315958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWdSJqNTu1f2aCVErVpBxq7bLKJEcOtDRM7rNUFeIe4=;
 b=NkaRg+6yiv6wrS3AoXeaGTDCZRkHxThb7Ud+Alb663B3Elz0nyvPRFafQjmCoLVLZdkJte
 fcD0Civno63twb+NF0jokUDRcJZ3RRYQ9aAaUhD81cD9+rNeeywJS9GiccHrMO0u/ggpAz
 yCh0jdYJ4Jyz7ZgRGmUoV1iaHmFsI4M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-hIrEPruWPMezXKwrd_ZquA-1; Mon,
 07 Oct 2024 11:45:56 -0400
X-MC-Unique: hIrEPruWPMezXKwrd_ZquA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEE02196C40B
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2024 15:45:55 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0BD530001A0; Mon,  7 Oct 2024 15:45:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/3] scripts: forbid use of arbitrary SPDX tags besides
 license identifiers
Date: Mon,  7 Oct 2024 16:45:48 +0100
Message-ID: <20241007154548.1144961-4-berrange@redhat.com>
In-Reply-To: <20241007154548.1144961-1-berrange@redhat.com>
References: <20241007154548.1144961-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While SPDX-License-Identifier is a well known SPDX tag, there are a
great many more besides that[1]. This are around making machine readable
metadata available to the 'reuse' tool and similar for things like
author names, copyright owners, and much more. It is even possible to
define source file line groups and apply different SPDX tags to just
that region of code.

At this time we're only interested in adopting SPDX for recording the
licensing info, so detect & reject any other SPDX metadata. If we want
to explicitly collect extra data in SPDX format, we can evaluate each
case on its merits.

[1] https://spdx.github.io/spdx-spec/v2.2.2/file-tags/
    https://spdx.github.io/spdx-spec/v2.2.2/file-information/

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cd1ed90f4c..5ad2d4ca2e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1707,6 +1707,18 @@ sub process {
 		    &checkspdx($realfile, $1);
 		}
 
+		if ($rawline =~ m,(SPDX-[a-zA-Z0-9-_]+):,) {
+		    my $tag = $1;
+		    my @permitted = qw(
+			SPDX-License-Identifier
+		    );
+
+		    unless (grep { /^$tag$/ } @permitted) {
+			ERROR("Tag $tag not permitted in QEMU code, valid " .
+			      "choices are: " . join(", ", @permitted));
+		    }
+		}
+
 # Check for wrappage within a valid hunk of the file
 		if ($realcnt != 0 && $line !~ m{^(?:\+|-| |\\ No newline|$)}) {
 			ERROR("patch seems to be corrupt (line wrapped?)\n" .
-- 
2.46.0


