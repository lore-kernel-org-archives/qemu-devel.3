Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEA3C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GOX-0003ah-QI; Sun, 06 Sep 2026 13:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOU-0003Wo-6F
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOS-00007F-0K
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRkTHA7nL5CynMi605WOYGVD6/d74MN8KfqAn0uX0n0=;
 b=IgaUxxqhBIga9RbI7Li+RikUNneD6Y2SBtFLx2bWMD430IrDCHRTqto099hEkrdEbWq7Ge
 +0Hc0N5bS4LiA7k7xe3cbfE1QXfBAUFbiGs+2YUq3KZBUzrPEChrmZ+RZ/L8U6tQn6UGL+
 Wt59NOqyyGdAbT+Gc5cEvFIVnpq7638=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-CywM9nRpMqaWlX-CfKkKHw-1; Sun,
 06 Sep 2026 13:10:56 -0400
X-MC-Unique: CywM9nRpMqaWlX-CfKkKHw-1
X-Mimecast-MFC-AGG-ID: CywM9nRpMqaWlX-CfKkKHw_1788714655
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15EE91955BD0; Sun,  6 Sep 2026 17:10:55 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 124E51955F06; Sun,  6 Sep 2026 17:10:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/40] qapi/crypto: Add ECDSA algorithm and curve id
Date: Sun,  6 Sep 2026 19:09:53 +0200
Message-ID: <20260906171021.26568-13-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The ASPEED AST10x0 Secure Boot Controller has a hardware ECDSA engine
that guest firmware uses to verify secp384r1 signatures. Emulating it
requires ECDSA support in the crypto akcipher framework, which today
only implements RSA.

Introduce a new asymmetric cipher algorithm, ECDSA, a curve identifier
enum (prime256v1 / NIST P-256 and secp384r1 / NIST P-384) and the
per-algorithm ECDSA options. This is the QAPI groundwork consumed by the
crypto akcipher backends in the following patches.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260901085238.995968-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 qapi/crypto.json | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 6e3a98ff68b3..cae2c678cb22 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -557,10 +557,26 @@
 #
 # @rsa: RSA algorithm
 #
+# @ecdsa: ECDSA algorithm (Since 11.2)
+#
 # Since: 7.1
 ##
 { 'enum': 'QCryptoAkCipherAlgo',
-  'data': ['rsa']}
+  'data': ['rsa', 'ecdsa']}
+
+##
+# @QCryptoCurveID:
+#
+# The supported elliptic curves.
+#
+# @prime256v1: NIST P-256 curve (prime256v1)
+#
+# @secp384r1: NIST P-384 curve (secp384r1)
+#
+# Since: 11.2
+##
+{ 'enum': 'QCryptoCurveID',
+  'data': ['prime256v1', 'secp384r1']}
 
 ##
 # @QCryptoAkCipherKeyType:
@@ -605,6 +621,18 @@
   'data': { 'hash-alg':'QCryptoHashAlgo',
             'padding-alg': 'QCryptoRSAPaddingAlgo'}}
 
+##
+# @QCryptoAkCipherOptionsECDSA:
+#
+# Specific parameters for the ECDSA algorithm.
+#
+# @curve-id: the elliptic curve to use
+#
+# Since: 11.2
+##
+{ 'struct': 'QCryptoAkCipherOptionsECDSA',
+  'data': { 'curve-id': 'QCryptoCurveID' }}
+
 ##
 # @QCryptoAkCipherOptions:
 #
@@ -618,4 +646,5 @@
 { 'union': 'QCryptoAkCipherOptions',
   'base': { 'alg': 'QCryptoAkCipherAlgo' },
   'discriminator': 'alg',
-  'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' }}
+  'data': { 'rsa': 'QCryptoAkCipherOptionsRSA',
+            'ecdsa': 'QCryptoAkCipherOptionsECDSA' }}
-- 
2.55.0


