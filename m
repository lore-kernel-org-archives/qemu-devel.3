Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D1AC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXc1-0006w9-3N; Wed, 24 Apr 2024 04:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXbX-0005su-3n
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXbS-0003nj-78
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXLAsN/MjWVrTQesWQIb8lj4bZIyULexZMx0u8KANK0=;
 b=UCYKdlLgOz/Km603AA55deTGb5DNJf27q3UqRfH6lreiC1F7QUJw4IeFIFSREu7u9y6rSK
 EKeKOHBLZrRk3p8wLASQOrDvyClCOTT/op3kYeQuFkUs70StVJ6aL2Hs9SM9JJtnQeZDUV
 mdkQOlx0J4QTJlkQazUDewEOdwbdKxY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-0g-fZ5TLMgib_g2FIqKLoA-1; Wed, 24 Apr 2024 04:03:39 -0400
X-MC-Unique: 0g-fZ5TLMgib_g2FIqKLoA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48033834FB1;
 Wed, 24 Apr 2024 08:03:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25B49400EAF;
 Wed, 24 Apr 2024 08:03:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E07B21E65DE; Wed, 24 Apr 2024 10:03:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/10] qapi: Correct error message for 'vcpu_dirty_limit'
 parameter
Date: Wed, 24 Apr 2024 10:03:35 +0200
Message-ID: <20240424080337.2782594-9-armbru@redhat.com>
In-Reply-To: <20240424080337.2782594-1-armbru@redhat.com>
References: <20240424080337.2782594-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

QERR_INVALID_PARAMETER_VALUE is defined as:

  #define QERR_INVALID_PARAMETER_VALUE \
      "Parameter '%s' expects %s"

The current error is formatted as:

  "Parameter 'vcpu_dirty_limit' expects is invalid, it must greater then 1 MB/s"

Replace by:

  "Parameter 'vcpu_dirty_limit' must be greater than 1 MB/s"

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240312141343.3168265-9-armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
[New error message corrected, commit message updated accordingly]
---
 migration/options.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index bfd7753b69..d7a773aea8 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1286,9 +1286,8 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     if (params->has_vcpu_dirty_limit &&
         (params->vcpu_dirty_limit < 1)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "vcpu_dirty_limit",
-                   "is invalid, it must greater then 1 MB/s");
+        error_setg(errp,
+                   "Parameter 'vcpu_dirty_limit' must be greater than 1 MB/s");
         return false;
     }
 
-- 
2.44.0


