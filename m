Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000EBF33A6E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9KL-0002MT-IW; Thu, 05 Mar 2026 09:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vy9KI-0002M5-5v
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:05:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vy9KG-0007pd-G8
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772719515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sj7t5sYEdl/rrqhMX84JuozAOPc9rHFA0SqMD36Pfy0=;
 b=TClb2KlCIV5VnwfnyzPt86ttdiyXB34Z80Pg0Vw3HcChCnjJ0pgn0j/Cu+XNzZMOXJayYC
 WWCyNocuYplO5CR2DiiYFuhQ0UvhGoCL0SKNnELXjgHIEWufDKvvN0wNxnuQb/wrdCeo42
 Pt2sg3wOzaJ4aIHnpI+uPAzi2GLpInI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-InPZo3eXNc--eS3BOyg0FQ-1; Thu,
 05 Mar 2026 09:05:12 -0500
X-MC-Unique: InPZo3eXNc--eS3BOyg0FQ-1
X-Mimecast-MFC-AGG-ID: InPZo3eXNc--eS3BOyg0FQ_1772719511
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82B25180057B; Thu,  5 Mar 2026 14:05:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 099B01958DC7; Thu,  5 Mar 2026 14:05:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B43921E6880; Thu, 05 Mar 2026 15:05:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 2/6] scripts/checkpatch: Fix MAINTAINERS update warning with
 --terse
Date: Thu,  5 Mar 2026 15:05:04 +0100
Message-ID: <20260305140508.218316-3-armbru@redhat.com>
In-Reply-To: <20260305140508.218316-1-armbru@redhat.com>
References: <20260305140508.218316-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We recently improved the MAINTAINERS update warning to show the files
that trigger it.  Example:

    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
    #105:
    deleted file mode 100644

improved to

    WARNING: added, moved or deleted file(s):

      migration/threadinfo.h
      migration/threadinfo.c

    Does MAINTAINERS need updating?

Unfortunately, this made things worse with --terse, as only the first
line of each warning is shown then.

    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

became

    WARNING: added, moved or deleted file(s):

Adjust the warning text to

    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
      migration/threadinfo.h
      migration/threadinfo.c

so we get the exact same warning as we used to with --terse.

Fixes: 1d745e6d9635 (scripts/checkpatch: use new hook for MAINTAINERS update check)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260109071217.2326194-1-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3a9557417f..6f270becdc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1473,9 +1473,9 @@ sub process_file_list {
 
 	# If we don't see a MAINTAINERS update, prod the user to check
 	if (int(@maybemaintainers) > 0 && !$sawmaintainers) {
-		WARN("added, moved or deleted file(s):\n\n  " .
-		     join("\n  ", @maybemaintainers) .
-		     "\n\nDoes MAINTAINERS need updating?\n");
+                WARN("added, moved or deleted file(s),"
+		     " does MAINTAINERS need updating?\n  "
+		     . join("\n  ", @maybemaintainers));
 	}
 }
 
-- 
2.53.0


