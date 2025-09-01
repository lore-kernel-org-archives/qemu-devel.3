Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A18CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3L6-00064T-M1; Mon, 01 Sep 2025 08:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3L4-0005z4-JG
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3Ky-0005ew-P4
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756728511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=L/8AVTUZcFiQdhcB+bIxr4rVv/251UNsF28ctT64Eqs=;
 b=eOrG5ZYpmkmwQEGbXsT3ogI1Q+FxNgq6WSOjGOvcfjzIbQghTe0bL6CcrVB8zh6CYwz4pL
 sUBXtqOJU5pb1ONlIJS4G0XUjtUzVlWTjS5evjuLjgSqCcBu4v0OUEQyw3xnoA2++jbDXz
 Uyi/KxtkH5XUe6C1zHNrgz9HO2Z2rHU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-duGAsvHmOeuWcEevtU4Wfw-1; Mon,
 01 Sep 2025 08:08:27 -0400
X-MC-Unique: duGAsvHmOeuWcEevtU4Wfw-1
X-Mimecast-MFC-AGG-ID: duGAsvHmOeuWcEevtU4Wfw_1756728507
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13C6E195608B; Mon,  1 Sep 2025 12:08:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3D6E180047F; Mon,  1 Sep 2025 12:08:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 17E6421E6925; Mon, 01 Sep 2025 14:08:24 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 01 Sep 2025 14:08:24 +0200
Resent-Message-ID: <87plca4bpj.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Mon Sep  1 13:19:06 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9CA4B21E6925; Mon, 01 Sep 2025 13:19:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 2/3] i386/kvm/vmsr_energy: Plug memory leak on failure to
 connect socket
Date: Mon,  1 Sep 2025 13:19:05 +0200
Message-ID: <20250901111906.2403307-3-armbru@redhat.com>
In-Reply-To: <20250901111906.2403307-1-armbru@redhat.com>
References: <20250901111906.2403307-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

vmsr_open_socket() leaks the Error set by
qio_channel_socket_connect_sync().  Plug the leak by not creating the
Error.

Fixes: 0418f90809ae (Add support for RAPL MSRs in KVM/Qemu)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250723133257.1497640-2-armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/vmsr_energy.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index 58ce3df53a..890322ae37 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -57,13 +57,9 @@ QIOChannelSocket *vmsr_open_socket(const char *path)
     };
 
     QIOChannelSocket *sioc = qio_channel_socket_new();
-    Error *local_err = NULL;
 
     qio_channel_set_name(QIO_CHANNEL(sioc), "vmsr-helper");
-    qio_channel_socket_connect_sync(sioc,
-                                    &saddr,
-                                    &local_err);
-    if (local_err) {
+    if (qio_channel_socket_connect_sync(sioc, &saddr, NULL) < 0) {
         /* Close socket. */
         qio_channel_close(QIO_CHANNEL(sioc), NULL);
         object_unref(OBJECT(sioc));
-- 
2.49.0



