Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F37C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 15:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to2YG-0006G2-Ov; Fri, 28 Feb 2025 10:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1to2Xy-00061J-6T
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 10:45:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1to2Xw-0005HG-F1
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 10:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740757503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1TLwLqRnUwlQCiUxhyBFdFzCjlU7pdun46uVo3UdpUc=;
 b=bdZygahf/oDfuD66fwZXb2DmEbXxiWwyvFR6zws1KIw9hB7oWXHYPK7QnVKtHC5zkIvHEX
 ctEvpXpUVt0e3jUuBfm49f+by8DHpJFGfWtMQx9Ivt+EzIioNl5LfLP5mDl+JmEG+WIARk
 ObmJCNAJBvd+KF637CwZes0X/uwypqc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-wcVHfcuYPfGDKTslciU00A-1; Fri,
 28 Feb 2025 10:45:01 -0500
X-MC-Unique: wcVHfcuYPfGDKTslciU00A-1
X-Mimecast-MFC-AGG-ID: wcVHfcuYPfGDKTslciU00A_1740757500
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 365E5180034A; Fri, 28 Feb 2025 15:45:00 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB11C19560B9; Fri, 28 Feb 2025 15:44:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/3] scripts: forbid use of arbitrary SPDX tags besides license
 identifiers
Date: Fri, 28 Feb 2025 15:44:50 +0000
Message-ID: <20250228154450.3185564-4-berrange@redhat.com>
In-Reply-To: <20250228154450.3185564-1-berrange@redhat.com>
References: <20250228154450.3185564-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
great many more besides that[1]. These are mostly focused on making
machine readable metadata available to the 'reuse' tool and similar.
They cover concepts like author names, copyright owners, and much
more. It is even possible to define source file line groups and apply
different SPDX tags to regions of code within a file.

At this time we're only interested in adopting SPDX for recording the
file global licensing info, so detect & reject any other SPDX metadata.
If we want to explicitly collect extra data in SPDX format, we can
evaluate each data item on its merits when someone wants to propose it
at a later date.

[1] https://spdx.github.io/spdx-spec/v2.2.2/file-tags/
    https://spdx.github.io/spdx-spec/v2.2.2/file-information/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 8995d2c391..83b59fb443 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1714,6 +1714,18 @@ sub process {
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
2.48.1


