Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B38ED15DB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2v8i-0004It-9a; Mon, 21 Oct 2024 12:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2v8a-0004EF-Oc
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2v8Y-00046H-42
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729527605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCkNVtJTAVI1FHpQy5PGeq16FqGsHq8JIrqTyGDIGiU=;
 b=c7K30AcuzD5G+FHQ5tsfVmohCr9srpgRjsnNaZ0cJbjluGVlk3GgSK1ws12gcJ+7VdbyIM
 y3XB7rV8pDlv+BXkg3DbZVKd0y7zZ06CsjSWg8w58+26/QtNRHac3hdBiAAG7r9ltV7Xuq
 91xekR+AQRqUoZa2BjliE+Ibh56H8os=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-SddFnKUoMOGRYLQ_KIjjSw-1; Mon,
 21 Oct 2024 12:20:03 -0400
X-MC-Unique: SddFnKUoMOGRYLQ_KIjjSw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C52A21955F79
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 16:20:02 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46AEC1956056; Mon, 21 Oct 2024 16:20:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/6] ui/vnc: don't return an empty SASL mechlist to the client
Date: Mon, 21 Oct 2024 17:19:52 +0100
Message-ID: <20241021161957.1431919-2-berrange@redhat.com>
In-Reply-To: <20241021161957.1431919-1-berrange@redhat.com>
References: <20241021161957.1431919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

The SASL initialization phase may determine that there are no valid
mechanisms available to use. This may be because the host OS admin
forgot to install some packages, or it might be because the requested
SSF level is incompatible with available mechanisms, or other unknown
reasons.

If we return an empty mechlist to the client, they're going to get a
failure from the SASL library on their end and drop the connection.
Thus there is no point even sending this back to the client, we can
just drop the connection immediately.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc-auth-sasl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 47fdae5b21..7d9ca9e8ac 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -674,6 +674,13 @@ void start_auth_sasl(VncState *vs)
     }
     trace_vnc_auth_sasl_mech_list(vs, mechlist);
 
+    if (g_str_equal(mechlist, "")) {
+        trace_vnc_auth_fail(vs, vs->auth, "no available SASL mechanisms", "");
+        sasl_dispose(&vs->sasl.conn);
+        vs->sasl.conn = NULL;
+        goto authabort;
+    }
+
     vs->sasl.mechlist = g_strdup(mechlist);
     mechlistlen = strlen(mechlist);
     vnc_write_u32(vs, mechlistlen);
-- 
2.46.0


