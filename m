Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC5FD3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 15:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSzFu-00037s-Ut; Tue, 09 Dec 2025 10:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vSzFs-00037f-Pg
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 10:03:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vSzFr-000484-CH
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 10:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765292634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eLlqLUKO3wqo7D6CPsI4EAXpq5S6PcIAzNY4UvB+MZc=;
 b=J42/L+vU59J0RRUVCLXixrofslObB0FVk8qZXraJffNWoZeTOuKfHwwfLZWQ7l/x5IprWo
 VbVH619MlINbZQ8ETVSbEQmkttG12qqkQAuj7MOnqA4pCOnoNCt24Sc63bBcyH+8QXuIiR
 t+4no7IHAFrDI8LBzlQfo5x2k2XxBzw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-k5RkQG7rMZ2h6sPSjS0_oA-1; Tue,
 09 Dec 2025 10:03:52 -0500
X-MC-Unique: k5RkQG7rMZ2h6sPSjS0_oA-1
X-Mimecast-MFC-AGG-ID: k5RkQG7rMZ2h6sPSjS0_oA_1765292631
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F318F18001FE; Tue,  9 Dec 2025 15:03:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFD5930001A5; Tue,  9 Dec 2025 15:03:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] log: Fix result of strstr to 'const char *'
Date: Tue,  9 Dec 2025 16:03:46 +0100
Message-ID: <20251209150346.650473-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Assigning the result of strstr() to a 'char *' is unsafe since
strstr() returns a pointer into the original string which is a
read-only 'const char *' string. Newer compilers now complain when the
result of strstr() is not a 'const char *' :

../util/log.c:208:24: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  208 |         char *pidstr = strstr(filename, "%");
      |                        ^~~~~~

Fix that.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 util/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/log.c b/util/log.c
index 41f78ce86b2522b8b7072c8b76d8e18603142db6..c44d66b5ce78338cf1b2cd26b7503cb94d4570cb 100644
--- a/util/log.c
+++ b/util/log.c
@@ -203,7 +203,7 @@ static ValidFilenameTemplateResult
 valid_filename_template(const char *filename, bool per_thread, Error **errp)
 {
     if (filename) {
-        char *pidstr = strstr(filename, "%");
+        const char *pidstr = strstr(filename, "%");
 
         if (pidstr) {
             /* We only accept one %d, no other format strings */
-- 
2.52.0


