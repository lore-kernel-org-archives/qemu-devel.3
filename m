Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697C2EDA681
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRKq-0006h1-Ut; Tue, 03 Mar 2026 10:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKm-0006dn-El
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKk-00028T-Ig
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772550409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IbVx6h7ufm4kk+pC5TYey/6wcKGTtrcPQQxztMIFIO0=;
 b=fQ+3BsCSm+Wdlv9lPgxBP/69axlFC7VqEJnEuna3u9DBZ/eSKKtFYFKnanpdMYGQ/PGn7R
 xraNgwino8lAVCenZsNtvnGho0/thhcQdBsmoZFl/q+RfFJOrgqtqWVznCB8pVvtXf0/lL
 8y/+bVjkFn5PfyQIQFHdfV7VMXBTDn8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-U6OnLtlTOzOpaaCBqbI4Fg-1; Tue,
 03 Mar 2026 10:06:48 -0500
X-MC-Unique: U6OnLtlTOzOpaaCBqbI4Fg-1
X-Mimecast-MFC-AGG-ID: U6OnLtlTOzOpaaCBqbI4Fg_1772550407
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B92EF1800378
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2026 15:06:47 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.225.185])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BC5F1800666; Tue,  3 Mar 2026 15:06:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 19/27] ui: remove redundant use of error_printf_unless_qmp()
Date: Tue,  3 Mar 2026 15:05:56 +0000
Message-ID: <20260303150604.2402872-20-berrange@redhat.com>
In-Reply-To: <20260303150604.2402872-1-berrange@redhat.com>
References: <20260303150604.2402872-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

The vnc_display_print_local_addr() method is intended to print the VNC
listening address on the console at startup, so the user can see the
auto-chosen port address when using the 'to=' flag. This is only called
by vnc_display_open() which is in the QEMU startup callpath. The check
for not being in QMP is thus redundant and can be removed.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 8bf14cf9a7..952976e964 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3578,9 +3578,9 @@ static void vnc_display_print_local_addr(VncDisplay *vd)
         qapi_free_SocketAddress(addr);
         return;
     }
-    error_printf_unless_qmp("VNC server running on %s:%s\n",
-                            addr->u.inet.host,
-                            addr->u.inet.port);
+    error_printf("VNC server running on %s:%s\n",
+                 addr->u.inet.host,
+                 addr->u.inet.port);
     qapi_free_SocketAddress(addr);
 }
 
-- 
2.53.0


