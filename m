Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3336606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jMkqdB25
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQoAx-0005Cd-C2; Tue, 10 Nov 2026 10:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQoAv-0005Bs-2f
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:54:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQoAm-0007Uc-C6
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794326051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjq0g7PfM1si5mYsg+08PaNrq04MGNvVa7fbtl+n3lI=;
 b=jMkqdB25KVaJAZEM18jZSTTg/i4/Ul8BMuRo3UlT+GhGVeh5lM2rGqIcv25iCxoX/dAiSH
 jtKIrkAsyY4080wArU1jB9OKfJ1BC3XaEzJXRYekLaweKxSrSFodZYm6aDzFWlNS23pt65
 bALk5D9emQFAGcfyp86YXOfWMpS9ceI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-c9X2lviKOfGjFM6qQHZBuw-1; Tue,
 10 Nov 2026 10:54:05 -0500
X-MC-Unique: c9X2lviKOfGjFM6qQHZBuw-1
X-Mimecast-MFC-AGG-ID: c9X2lviKOfGjFM6qQHZBuw_1794326045
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B299A180034A; Tue, 10 Nov 2026 15:54:04 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD14544D; Tue, 10 Nov 2026 15:54:02 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, berrange@redhat.com,
 stefanha@redhat.com, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 1/6] docs: Mention security considerations for NBD
Date: Tue, 10 Nov 2026 09:53:57 -0600
Message-ID: <20261110155356.1520433-7-eblake@redhat.com>
In-Reply-To: <20261110153121.1516536-8-eblake@redhat.com>
References: <20261110153121.1516536-8-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Document a policy that NBD connections should strongly consider using
TLS and x509 certificates to filter out unwanted clients.  If a
malicious server or client can trigger a QEMU assertion failure on a
plaintext connection, but can trivially have risk mitigated by
enabling TLS to weed out unknown partners (so that a full-on attack of
QEMU would first require chaining some other attack to convince a
"trusted" client to break protocol in the first place), then that
reduces the CVSS-BE score of the QEMU bug. In turn, our policy already
states that low severity scores can be fixed without an embargo.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: more wording tweaks, since even a TLS-authorized partner cannot
be considered 100% trusted, but is reduced risk.
---
 docs/system/security.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index e211fdd2344..e30f771731a 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -320,3 +320,26 @@ encryption and authorization control policy on client connections.
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
+that an unencrypted connection can allow any external process a
+potential attack vector via the network port. When possible, QEMU
+should be configured to require TLS to prevent a man-in-the-middle
+attack, as well as use x509 client certificates with the
+tls-creds-x509 object set with 'verify-peer=on' to check that the peer
+is allowed to connect. It may also be worth using 'tls-authz' to
+filter which certificates are allowed if the CA issues certs more
+broadly.
+
+Proper hardening of network connections cannot prevent a client from
+violating protocol, but does increase the complexity of an attack,
+because a malicious actor must first find a way to convince an
+authenticated client to send the bytes that will trigger any QEMU
+misbehavior.  Use of a hardened connection is therefore an
+environmental factor used in determining the risk and severity of a
+network-triggered bug.
-- 
2.56.0


