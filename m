Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5235BCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0z2d-0007Cm-IT; Tue, 23 Sep 2025 05:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0z2Y-00079e-Nv
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0z2M-0000QV-U0
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758618613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0RTR14tGDCK7KLNx1SfxdzthJ+BwqbXRuDzYoEM00k=;
 b=PReCgSX04mIcvqP0Ke5FMs32NaPJGTkqWq4XcMRreAMQdz95DQYlPrixsuiMuxxlUC9L7K
 kR2bQYmQzZbnigPLewHmvyCvpmXsU9A7lp/Hr8lC6eVy7j7DJSa4cH5gotjyT1wkYoJdqa
 /tbM9YrokEH2bG2EtRBRTFEMQuxIFBE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-z_eREtWXNlW8Mbw1qgg_uw-1; Tue,
 23 Sep 2025 05:10:07 -0400
X-MC-Unique: z_eREtWXNlW8Mbw1qgg_uw-1
X-Mimecast-MFC-AGG-ID: z_eREtWXNlW8Mbw1qgg_uw_1758618607
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D64B219560B5; Tue, 23 Sep 2025 09:10:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37C46195608E; Tue, 23 Sep 2025 09:10:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6F8C721E66E1; Tue, 23 Sep 2025 11:10:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org,
 vsementsov@yandex-team.ru
Subject: [PATCH v3 09/13] ui/pixman: Consistent error handling in
 qemu_pixman_shareable_free()
Date: Tue, 23 Sep 2025 11:09:56 +0200
Message-ID: <20250923091000.3180122-10-armbru@redhat.com>
In-Reply-To: <20250923091000.3180122-1-armbru@redhat.com>
References: <20250923091000.3180122-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

qemu_pixman_shareable_free() wraps around either qemu_memfd_free() or
qemu_win32_map_free().  The former reports trouble as error, with
error_report(), then succeeds.  The latter reports it as warning (we
pass it &error_warn), then succeeds.

Change the latter to report as error, too.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/qemu-pixman.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index ef4e71da11..e46c6232cf 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -288,7 +288,10 @@ qemu_pixman_shareable_free(qemu_pixman_shareable handle,
                            void *ptr, size_t size)
 {
 #ifdef WIN32
-    qemu_win32_map_free(ptr, handle, &error_warn);
+    Error *err = NULL;
+
+    qemu_win32_map_free(ptr, handle, &err);
+    error_report_err(err);
 #else
     qemu_memfd_free(ptr, size, handle);
 #endif
-- 
2.49.0


