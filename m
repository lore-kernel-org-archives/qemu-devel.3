Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3755DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 17:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH40X-0005yy-Az; Mon, 19 May 2025 13:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH40U-0005yE-5F
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH40S-0001ZF-0J
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747674627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4E8rgHsQb3gq0oCSF5CNcRbOTsrBL7NcaTAez1HiMI=;
 b=Jrp4ty2ULgfSLVK5+AMIsIUdAqh05mZNV2DHOZQqURuUwyaQjKRa8iz0xyNND6iCYAgCKe
 V8YCbJ1ZQhnp2Fn3YtOQh0/3rNaM8tsJpQxBVZzp2eHoigR4BRyoFFkgv9k6s4CwAR6fdt
 gdrz30yapVYsJkwA7N+Lc8FzDu4/mxc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-ZwyzHGkYMzKgRRkXq5OogQ-1; Mon,
 19 May 2025 13:10:23 -0400
X-MC-Unique: ZwyzHGkYMzKgRRkXq5OogQ-1
X-Mimecast-MFC-AGG-ID: ZwyzHGkYMzKgRRkXq5OogQ_1747674623
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E856C180035F; Mon, 19 May 2025 17:10:22 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.50])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0BD219560AA; Mon, 19 May 2025 17:10:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 6/9] scripts/checkpatch: expand pattern for matching
 makefiles
Date: Mon, 19 May 2025 18:10:01 +0100
Message-ID: <20250519171004.352636-7-berrange@redhat.com>
In-Reply-To: <20250519171004.352636-1-berrange@redhat.com>
References: <20250519171004.352636-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

The current regex matches Makefile & Makefile.objs, but the latter is
no longer used, anjd we're missing coverage of Makefile.include and
Makefile.target. Expand the pattern to match any suffix.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e208222e75..2c8e8135b6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1454,7 +1454,7 @@ sub process_start_of_file {
 		my $permhere = $fileinfo->{linestart} . "FILE: " .
 			$fileinfo->{filenew} . "\n";
 		if ($fileinfo->{filenew} =~
-		    /(\bMakefile(?:\.objs)?|\.(c|cc|cpp|h|mak|s|S))$/) {
+		    /(\bMakefile.*|\.(c|cc|cpp|h|mak|s|S))$/) {
 			ERROR("do not set execute permissions for source " .
 			      "files\n" . $permhere);
 		}
-- 
2.49.0


