Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5D606A885
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QEqQoBKd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7Mq-00030H-La; Wed, 11 Nov 2026 07:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Ml-0002zO-K6
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:23:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Mk-0000ZS-1r
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794399829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZwCcB3cX28qoAvoTIzSD810qDfQrOekZQk10YH00LIM=;
 b=QEqQoBKdQahBAqGr36vrupu+S7+A0phtOFtAnNSyYbEf9ZdRHmqkGSQuQV/b0fmChIhGWc
 LW7WEutdPivTIouG9EsUm4VO403inirPFrNNd57+GReZ9qKdrM9nwIhQEFeDkEs31b2U2q
 pRNhcQuKGJSjbe/aE/tTJYssdHO7W2U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-dTFM5mSrOIilBanKqKjpbQ-1; Wed,
 11 Nov 2026 07:23:46 -0500
X-MC-Unique: dTFM5mSrOIilBanKqKjpbQ-1
X-Mimecast-MFC-AGG-ID: dTFM5mSrOIilBanKqKjpbQ_1794399825
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40D801954105; Wed, 11 Nov 2026 12:23:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5B391800545; Wed, 11 Nov 2026 12:23:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3DA9D21E6880; Wed, 11 Nov 2026 13:23:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH 2/7] backends/hostmem-file: Drop useless validation of
 property "mem-path"
Date: Wed, 11 Nov 2026 13:23:37 +0100
Message-ID: <20261111122342.634370-3-armbru@redhat.com>
In-Reply-To: <20261111122342.634370-1-armbru@redhat.com>
References: <20261111122342.634370-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A non-optional string property like "mem-path" cannot be null.  Drop
the useless check.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 backends/hostmem-file.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 08d0382d76f..1e8f8ae6aa8 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -48,11 +48,6 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     g_autofree gchar *name = NULL;
     uint32_t ram_flags;
 
-    if (!fb->mem_path) {
-        error_setg(errp, "mem-path property not set");
-        return false;
-    }
-
     switch (fb->rom) {
     case ON_OFF_AUTO_AUTO:
         /* Traditionally, opening the file readonly always resulted in ROM. */
-- 
2.55.0


