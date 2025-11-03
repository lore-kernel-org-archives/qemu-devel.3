Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A3BCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuoS-0002d5-Vy; Mon, 03 Nov 2025 08:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFuoN-0002Lv-2J
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:41:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFuoE-0004mK-L1
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMOnFs37bd9OkUmQnLjQkOBLu2AvkT/NHTBzwDCM7sA=;
 b=hVyBcHiKnD5VXauN62ImPVqLYXYICmZoQ0KlvKuOXT+nDMCucJhBkZPgR9LYzqAA6khdIS
 oaNGPvX+gz69s+4JyR7AZBS5F1ojLN2vMWODynhD572kgPp/gO+eUMlpre3/xbm5LG8p82
 lMidbGiED1BG7qys5E+Pddzy8YtXzfc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-SGQMprmjNru8xsnniRRXHg-1; Mon,
 03 Nov 2025 08:41:14 -0500
X-MC-Unique: SGQMprmjNru8xsnniRRXHg-1
X-Mimecast-MFC-AGG-ID: SGQMprmjNru8xsnniRRXHg_1762177273
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CDF01955F04; Mon,  3 Nov 2025 13:41:13 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD09C1800576; Mon,  3 Nov 2025 13:41:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 32/32] docs: creation of x509 certs compliant with post-quantum
 crypto
Date: Mon,  3 Nov 2025 13:37:26 +0000
Message-ID: <20251103133727.423041-33-berrange@redhat.com>
In-Reply-To: <20251103133727.423041-1-berrange@redhat.com>
References: <20251103133727.423041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


