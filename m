Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA27CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 15:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCJuH-0008Ey-9i; Fri, 24 Oct 2025 11:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCJuF-0008E3-Kr
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:40:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCJuD-0003NZ-To
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761320441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvAA3/dUluaCqtyyMtL7sm3tTucumU/mODLgAeMS2go=;
 b=Jh907bUXLrYngQasgwzPVqO5L6vHH50TlB98mCCzHmhUw3tiCnj8Tt9q3TWDZA+UG3+ZHc
 8um5RNUuP6nAYoOj0SuTs+xl37/x/N1FelOIgLh5qTKmx0TfNYhE2NmXPeh0QDatJWMbPU
 7D0kFKrMLq8GdGfqorZ5x83C5x4bgSo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-vOghYABaM2K6WqrMlCxMBg-1; Fri,
 24 Oct 2025 11:40:38 -0400
X-MC-Unique: vOghYABaM2K6WqrMlCxMBg-1
X-Mimecast-MFC-AGG-ID: vOghYABaM2K6WqrMlCxMBg_1761320437
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B40431800675; Fri, 24 Oct 2025 15:40:37 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F318319540EB; Fri, 24 Oct 2025 15:40:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 04/13] io: release active GSource in TLS channel finalizer
Date: Fri, 24 Oct 2025 16:40:15 +0100
Message-ID: <20251024154024.227978-5-berrange@redhat.com>
In-Reply-To: <20251024154024.227978-1-berrange@redhat.com>
References: <20251024154024.227978-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While code is supposed to call qio_channel_close() before releasing the
last reference on an QIOChannel, this is not guaranteed. QIOChannelFile
and QIOChannelSocket both cleanup resources in their finalizer if the
close operation was missed.

This ensures the TLS channel will do the same failsafe cleanup.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/channel-tls.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/io/channel-tls.c b/io/channel-tls.c
index 70fad38d18..ce041795c1 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -342,6 +342,16 @@ static void qio_channel_tls_finalize(Object *obj)
 {
     QIOChannelTLS *ioc = QIO_CHANNEL_TLS(obj);
 
+    if (ioc->hs_ioc_tag) {
+        trace_qio_channel_tls_handshake_cancel(ioc);
+        g_clear_handle_id(&ioc->hs_ioc_tag, g_source_remove);
+    }
+
+    if (ioc->bye_ioc_tag) {
+        trace_qio_channel_tls_bye_cancel(ioc);
+        g_clear_handle_id(&ioc->bye_ioc_tag, g_source_remove);
+    }
+
     object_unref(OBJECT(ioc->master));
     qcrypto_tls_session_free(ioc->session);
 }
-- 
2.50.1


