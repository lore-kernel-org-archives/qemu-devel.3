Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E41606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cToZl4gX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZFX-0007XK-4K; Wed, 21 Oct 2026 12:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFE-0007TQ-7z
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFB-0006Ue-Dd
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792600368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10yZLh8hPPLWb86UtjEQBBrvb3K+69MRCSe8pZYeX/Y=;
 b=cToZl4gXHyjgcVgSQakH1tiZJcFodsDiTXV/OGTR+in+lOmnqskP1azsRymuoXixQnIApQ
 kHl4Xk0JxmVetuephgsxLAAnB+zVOy5zaEdWkv8gWK+XQnqLYdskpl5nWMhCtfZMIjnriM
 b9XhSUh4fFvfrSiDS0kxsBpKkhPU0Eg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-gynGLf-qM4SnTryflJGB7g-1; Wed,
 21 Oct 2026 16:32:47 +0000
X-MC-Unique: gynGLf-qM4SnTryflJGB7g-1
X-Mimecast-MFC-AGG-ID: gynGLf-qM4SnTryflJGB7g_1792600366
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50EBF1956071; Wed, 21 Oct 2026 16:32:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D73518005B7; Wed, 21 Oct 2026 16:32:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3D6D91827598; Wed, 21 Oct 2026 18:32:40 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 10/10] backends/igvm: fix parameter area entries leak
Date: Wed, 21 Oct 2026 18:32:38 +0200
Message-ID: <20261021163239.1131460-11-kraxel@redhat.com>
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefano Garzarella <sgarzare@redhat.com>

qigvm_directive_parameter_area() allocates a QIgvmParameterData entry
for each parameter area, allocates the data buffer, and queues it in
the list.

At the end of qigvm_process_file() we iterate the list to only free
the data buffer of each entry, but never the entry itself, so all of
them are leaked.

Let's also free the entry itself and remove it from the list. We could
avoid the removal since the list lives on the stack, but it's better to
leave the list consistent.

Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20261021082459.72038-1-sgarzare@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 4b9d78630863..cf8b762d824c 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -1086,7 +1086,7 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
                        bool onlyVpContext, Error **errp)
 {
     int32_t header_count;
-    QIgvmParameterData *parameter;
+    QIgvmParameterData *parameter, *tmp;
     int retval = -1;
     QIgvm ctx;
 
@@ -1186,10 +1186,11 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
     retval = qigvm_process_mem_page(&ctx, NULL, errp);
 
 cleanup_parameters:
-    QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
+    QTAILQ_FOREACH_SAFE(parameter, &ctx.parameter_data, next, tmp)
     {
+        QTAILQ_REMOVE(&ctx.parameter_data, parameter, next);
         g_free(parameter->data);
-        parameter->data = NULL;
+        g_free(parameter);
     }
     g_free(ctx.id_block);
     g_free(ctx.id_auth);
-- 
2.56.0


