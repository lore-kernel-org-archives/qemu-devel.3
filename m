Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A761606A331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H6YBZ2eP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPpN3-0007l1-2Z; Sat, 07 Nov 2026 17:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xPpN0-0007ju-Te
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 17:58:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xPpMz-0002WV-55
 for qemu-devel@nongnu.org; Sat, 07 Nov 2026 17:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794092324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ed41uV7/MDec/L7nxah8JDQN7dNidJNpoC1RnOdFGOU=;
 b=H6YBZ2ePWaXPOYuGMgToPM8FtnvqAXRCkBCKn2P+sz/M+CX0hHnxKvUnW4zMkY7wqydT0B
 ZEKReHFds0YZJo4vHd9ZTdfJhmALe/1j1ZvsG+xIz4Lf+js/GDeX3L3UOs2z0rh6Rb4Uw8
 KAPrIYA2Khhn5K043XD+v+Cs2a8pfI0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-wT33DzpxPBmWO4BYcSE3oQ-1; Sat,
 07 Nov 2026 17:58:42 -0500
X-MC-Unique: wT33DzpxPBmWO4BYcSE3oQ-1
X-Mimecast-MFC-AGG-ID: wT33DzpxPBmWO4BYcSE3oQ_1794092321
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45CBE1956094; Sat,  7 Nov 2026 22:58:41 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB8D61956087; Sat,  7 Nov 2026 22:58:39 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, berrange@redhat.com, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 1/3] docs: Mention security considerations for NBD
Date: Sat,  7 Nov 2026 16:54:36 -0600
Message-ID: <20261107225834.778738-6-eblake@redhat.com>
In-Reply-To: <20261107225834.778738-5-eblake@redhat.com>
References: <20261107225834.778738-5-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MARKETING_PARTNERS=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MARKETING_PARTNERS,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document a policy that NBD connections should strongly consider using
TLS and x509 certificates to filter out untrusted clients.  If a
malicious server or client can trigger a QEMU assertion failure on a
plaintext connection, but can be trivially mitigated by enabling TLS
to weed out untrusted partners that would violate the protocol in the
first place, then I prefer to treat the bug as a lower-priority issue,
which our policy states can be fixed without an embargo.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/system/security.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index e211fdd2344..7b422d51472 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -320,3 +320,24 @@ encryption and authorization control policy on client connections.
 In summary, the monitor console is considered a privileged control interface to
 QEMU and as such should only be made accessible to a trusted management
 application or user.
+
+Block device network protocols (NBD, NFS, etc.)
+'''''''''''''''''''''''''''''''''''''''''''''''
+
+When using QEMU to access remote storage over a network (such as QEMU
+acting as an NBD or NFS client) or to provide remote storage access
+(such as QEMU acting as an NBD server), it is important to realize
+that an unencrypted connection can allow an external process a
+potential attack vector over the network port. When possible, QEMU
+should be configured to require TLS to prevent a man-in-the-middle
+attack, as well as use x509 client certificates with the
+tls-creds-x509 object set with 'verify-peer=on' to check that the peer
+is allowed to connect. It may also be worth using 'tls-authz' to
+filter which certificates are allowed if the CA issues certs more
+broadly.
+
+Proper hardening of network connections can prevent the use of
+untrusted clients, and is therefore a factor when considering whether
+a malicious network partner that intentionally violates the
+communication protocol to trigger a QEMU bug can be treated as a lower
+priority bug.
-- 
2.56.0


