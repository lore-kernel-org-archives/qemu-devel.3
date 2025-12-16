Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26E6D5E374
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 14:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVW3R-0005Xq-S1; Tue, 16 Dec 2025 09:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vVW39-0005WE-BD
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 09:29:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vVW32-0002x4-UZ
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 09:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765895339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7uWAdbHVg7wYY6vQfeMr3T/aQ7yLR/z8gVU97jqv3M=;
 b=IPOnYUlFGBZrAL28MC4CGrViChos3mUMpkPexfWQoF+fYOd3iQM9vgt1qUUqTISibfADyg
 1hx0a69Z1xeJpiWubHYlcYFppgT4da50qNHRHYqmOwckfi8tONPx6d6XKiVHVoqxsGsKzj
 njhgl0/6vO5p3LA9E+bKOOclT01Y1Dw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-MZV2r5hjP7K2Tw0n-Co14A-1; Tue,
 16 Dec 2025 09:28:55 -0500
X-MC-Unique: MZV2r5hjP7K2Tw0n-Co14A-1
X-Mimecast-MFC-AGG-ID: MZV2r5hjP7K2Tw0n-Co14A_1765895334
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 610641956063; Tue, 16 Dec 2025 14:28:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91FA819560A7; Tue, 16 Dec 2025 14:28:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/4] monitor: Fix const qualifier build errors with recent glibc
Date: Tue, 16 Dec 2025 15:28:42 +0100
Message-ID: <20251216142843.519084-4-clg@redhat.com>
In-Reply-To: <20251216142843.519084-1-clg@redhat.com>
References: <20251216142843.519084-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

A recent change in glibc 2.42.9000 [1] changes the return type of
strchr() and other string functions to be 'const char *' when the
input is a 'const char *'. This breaks the build in :

../monitor/hmp.c:589:7: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  589 |     p = strchr(type, ':');
      |       ^

Fix this by changing the type of the variables that store the result
of these functions to 'const char *'.

[1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20251215101937.281722-4-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 monitor/hmp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 34e2b8f748b425e1e4446e8e64aa25b1433d1162..a3ee02e52cda530508b170c4c5e8357b304f7df6 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -577,10 +577,11 @@ static const char *get_command_name(const char *cmdline,
  * Read key of 'type' into 'key' and return the current
  * 'type' pointer.
  */
-static char *key_get_info(const char *type, char **key)
+static const char *key_get_info(const char *type, char **key)
 {
     size_t len;
-    char *p, *str;
+    const char *p;
+    char *str;
 
     if (*type == ',') {
         type++;
-- 
2.52.0


