Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20422C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPS-0006HB-SB; Tue, 11 Aug 2026 12:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpP4-0005Zd-Hf
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpP2-000144-Vm
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1yTdfg76t+CUyVNOdpO2wTjXcgd2+FDORGFwiMv+I0Q=;
 b=H7+/OVY+SLwAKvFSgIS/6ff5hReuWKbDVcOWGd2GTJq04AEDXOwkmPi6rZH6APn4AszKKj
 A3r+GUPakHZAELnWgtgX+UhVwKo36K/FoqcpDcb99wyB9/56IkaxCExH305bpeRq0xAvTQ
 EZ7pov6xygqVpmUGA8S+yX5FQH+QoNw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-FHsWrG5gNsakPywJ4_waGQ-1; Tue,
 11 Aug 2026 12:32:22 -0400
X-MC-Unique: FHsWrG5gNsakPywJ4_waGQ-1
X-Mimecast-MFC-AGG-ID: FHsWrG5gNsakPywJ4_waGQ_1786465941
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F636195608E; Tue, 11 Aug 2026 16:32:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2C73195DF91; Tue, 11 Aug 2026 16:32:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 74/83] crypto/cipher: Add GCM to QCryptoCipherMode
Date: Tue, 11 Aug 2026 18:29:29 +0200
Message-ID: <20260811162938.1403216-75-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce the GCM cipher mode so authenticated encryption can be built
on top of the existing qcrypto_cipher API. GCM is an IV-based mode, so
register it in mode_need_iv. No backend advertises it yet, so it stays
unsupported until a backend and the AAD/tag helpers are added in the
following patches.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260811060115.1849266-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 qapi/crypto.json | 4 +++-
 crypto/cipher.c  | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 2b55befef977..6e3a98ff68b3 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -121,10 +121,12 @@
 #
 # @ctr: Counter (Since 2.8)
 #
+# @gcm: Galois/Counter Mode (Since 11.2)
+#
 # Since: 2.6
 ##
 { 'enum': 'QCryptoCipherMode',
-  'data': ['ecb', 'cbc', 'xts', 'ctr']}
+  'data': ['ecb', 'cbc', 'xts', 'ctr', 'gcm']}
 
 ##
 # @QCryptoIVGenAlgo:
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 229710f76b46..64c2339d1798 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -66,6 +66,7 @@ static const bool mode_need_iv[QCRYPTO_CIPHER_MODE__MAX] = {
     [QCRYPTO_CIPHER_MODE_CBC] = true,
     [QCRYPTO_CIPHER_MODE_XTS] = true,
     [QCRYPTO_CIPHER_MODE_CTR] = true,
+    [QCRYPTO_CIPHER_MODE_GCM] = true,
 };
 
 
-- 
2.55.0


