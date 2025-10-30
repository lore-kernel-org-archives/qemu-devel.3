Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C15CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETzt-00034l-Bs; Thu, 30 Oct 2025 10:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETzA-0001w8-Tt
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETym-0001iG-40
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1HUW2bAUEctcyCyOr0Tl74VLm7ZQzbdaATf7DQ31s3Q=;
 b=aR19rvHXcnWZSM+EGvMaEF4D04xAl4XPrEMNRkSvn9yP8fUyMef7uk1T/mh176ViDgJNCn
 ZbIcTCzHlSBS1CZ1/zyKmoyUx1q5SdpxQC1I2Kbbu+FuHxL5xKZPNYWkyjLgFwHh9hkUFN
 pmenF7iC1P3whLpnr7o5pHpTLnmJ+9Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-De7n0kFXMTuzgLIIz1KOyA-1; Thu,
 30 Oct 2025 10:50:11 -0400
X-MC-Unique: De7n0kFXMTuzgLIIz1KOyA-1
X-Mimecast-MFC-AGG-ID: De7n0kFXMTuzgLIIz1KOyA_1761835810
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8C731834508; Thu, 30 Oct 2025 14:50:10 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4AACE30001A8; Thu, 30 Oct 2025 14:50:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 21/21] docs: creation of x509 certs compliant with
 post-quantum crypto
Date: Thu, 30 Oct 2025 14:49:27 +0000
Message-ID: <20251030144927.2241109-22-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-1-berrange@redhat.com>
References: <20251030144927.2241109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Explain how to alter the certtool commands for creating certficates,
so that they can use algorithms that are compliant with post-quantum
crytography standards.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/system/tls.rst | 68 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/docs/system/tls.rst b/docs/system/tls.rst
index 7cec4ac3df..03fa1d8166 100644
--- a/docs/system/tls.rst
+++ b/docs/system/tls.rst
@@ -345,6 +345,74 @@ example with VNC:
 
 .. _tls_005fpsk:
 
+TLS certificates for Post-Quantum Cryptography
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Given a new enough gnutls release, suitably integrated & configured with the
+operating system crypto policies, QEMU is able to support post-quantum
+crytography on TLS enabled services, either exclusively or in a hybrid mode.
+
+In exclusive mode, only a single set of certificates need to be configured
+for QEMU, with PQC compliant algorithms. Such a QEMU configuration will only
+be able to interoperate with other services (including other QEMU's) that
+also have PQC enabled. This can result in compatibility concerns during the
+period of transition over to PQC compliant algorithms.
+
+In hybrid mode, multiple sets of certificates need to be configured for QEMU,
+at least one set with traditional (non-PQC compliant) algorithms, and at least
+one other set with modern (PQC compliant) algorithms. At time of the TLS
+handshake, the GNUTLS algorithm priorities should ensure that PQC compliant
+algorithms are negotiated if both sides of the connection support PQC. If one
+side lacks PQC, the TLS handshake should fallback to the non-PQC algorithms.
+This can assist with interoperability during the transition to PQC, but has a
+potential weakness wrt downgrade attacks forcing use of non-PQC algorithms.
+Exclusive PQC mode should be preferred where both peers in the TLS connections
+are known to support PQC.
+
+Key generation parameters
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To create certificates with PQC compliant algorithms, the ``--key-type``
+argument must be passed to ``certtool`` when creating private keys. No
+extra arguments are required for the other ``certtool`` commands, as
+their behaviour will be determined by the private key type.
+
+The typical PQC compliant algorithms to use are ``ML-DSA-44``, ``ML-DSA-65``
+and ``ML-DSA-87``, with ``ML-DSA-65`` being a suitable default choice in
+the absence of explicit requirements.
+
+Taking the example earlier, for creating a key for a client certificate,
+to use ``ML-DSA-65`` the command line would be modified to look like::
+
+   # certtool --generate-privkey --key-type=mldsa65 > client-hostNNN-key.pem
+
+The equivalent modification applies to the creation of the private keys
+used for server certs, or root/intermediate CA certs.
+
+For hybrid mode, the additional indexed certificate naming must be used.
+If multiple configured certificates are compatible with the mutually
+supported crypto algorithms between the client and server, then the
+first matching certificate will be used.
+
+IOW, to ensure that PQC certificates are preferred, they must use a
+non-index based filename, or use an index that is smaller than any
+non-PQC certificates. ie, ``server-cert.pem`` for PQC and ``server-cert-0.pem``
+for non-PQC, or ``server-cert-0.pem`` for PQC and ``server-cert-1.pem`` for
+non-PQC.
+
+Force disabling PQC via crypto priority
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In the OS configuration for system crypto algorithm priorities has
+enabled PQC, this can (optionally) be overriden in QEMU configuration
+disable use of PQC using the ``priority`` parameter to the ``tls-creds-x509``
+object::
+
+  NO_MLDSA="-SIGN-ML-DSA-65:-SIGN-ML-DSA-44:-SIGN-ML-DSA-87"
+  NO_MLKEM="-GROUP-X25519-MLKEM768:-GROUP-SECP256R1-MLKEM768:-GROUP-SECP384R1-MLKEM1024"
+  # qemu-nbd --object tls-creds-x509,id=tls0,endpoint=server,dir=....,priority=@SYSTEM:$NO_MLDSA:$NO_MLKEM
+
+
 TLS Pre-Shared Keys (PSK)
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.51.1


