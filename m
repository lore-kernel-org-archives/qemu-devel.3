Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CCDC624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x18Yw-0002M1-JV; Mon, 31 Aug 2026 16:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18Yu-0002GT-Km
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18Ys-0008WJ-P2
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788207898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCP7UVj7lY6yPKsok5GRRYDTHAJpEfy9IihCRm+r6Qo=;
 b=Vbef/zPispNDYJdMb6MYFWnZD7LA1fqv03e3xChXtx2kYgrAffMv2lMaiyzdJcd3k2lIQo
 9lW7amw7cqqNqpPSbN13N7AiTQBTnjW73NCKnxyh8/SygNkR8oVEDLgfL1CCD3no5TOFBb
 amqOd0tjtYNCUYUpsA/U3amKvjBzxVA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-RVxOMb3bPMe3ej89Z94FQg-1; Mon,
 31 Aug 2026 16:24:54 -0400
X-MC-Unique: RVxOMb3bPMe3ej89Z94FQg-1
X-Mimecast-MFC-AGG-ID: RVxOMb3bPMe3ej89Z94FQg_1788207891
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC9C7191FCCC; Mon, 31 Aug 2026 20:24:51 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8290B1800347; Mon, 31 Aug 2026 20:24:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 zhenwei pi <zhenwei.pi@linux.dev>, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, linux-cxl@vger.kernel.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 linux-edac@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 33/43] qapi: convert trivial intro sections for crypto.json
Date: Mon, 31 Aug 2026 16:19:35 -0400
Message-ID: <20260831201945.287730-34-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/crypto.json | 100 +++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 64 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 6e3a98ff68b..5e395bc10c7 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -26,8 +26,7 @@
 
 ##
 # @QCryptoSecretFormat:
-#
-# The data format that the secret is provided in
+#     The data format that the secret is provided in
 #
 # @raw: raw bytes.  When encoded in JSON only valid UTF-8 sequences
 #     can be used
@@ -41,8 +40,7 @@
 
 ##
 # @QCryptoHashAlgo:
-#
-# The supported algorithms for computing content digests
+#     The supported algorithms for computing content digests
 #
 # @md5: MD5.  Should not be used in any new code, legacy compat only
 #
@@ -68,8 +66,7 @@
 
 ##
 # @QCryptoCipherAlgo:
-#
-# The supported algorithms for content encryption ciphers
+#     The supported algorithms for content encryption ciphers
 #
 # @aes-128: AES with 128 bit / 16 byte keys
 #
@@ -110,8 +107,7 @@
 
 ##
 # @QCryptoCipherMode:
-#
-# The supported modes for content encryption ciphers
+#     The supported modes for content encryption ciphers
 #
 # @ecb: Electronic Code Book
 #
@@ -150,8 +146,7 @@
 
 ##
 # @QCryptoBlockFormat:
-#
-# The supported full disk encryption formats
+#     The supported full disk encryption formats
 #
 # @qcow: QCow/QCow2 built-in AES-CBC encryption.  Use only for
 #     liberating data from old images.
@@ -165,8 +160,8 @@
 
 ##
 # @QCryptoBlockOptionsBase:
-#
-# The common options that apply to all full disk encryption formats
+#     The common options that apply to all full disk encryption
+#     formats
 #
 # @format: the encryption format
 #
@@ -177,8 +172,7 @@
 
 ##
 # @QCryptoBlockOptionsQCow:
-#
-# The options that apply to QCow/QCow2 AES-CBC encryption format
+#     The options that apply to QCow/QCow2 AES-CBC encryption format
 #
 # @key-secret: the ID of a QCryptoSecret object providing the
 #     decryption key.  Mandatory except when probing image for
@@ -191,8 +185,7 @@
 
 ##
 # @QCryptoBlockOptionsLUKS:
-#
-# The options that apply to LUKS encryption format
+#     The options that apply to LUKS encryption format
 #
 # @key-secret: the ID of a QCryptoSecret object providing the
 #     decryption key.  Mandatory except when probing image for
@@ -205,8 +198,7 @@
 
 ##
 # @QCryptoBlockCreateOptionsLUKS:
-#
-# The options that apply to LUKS encryption format initialization
+#     The options that apply to LUKS encryption format initialization
 #
 # @cipher-alg: the cipher algorithm for data encryption.  Currently
 #     defaults to 'aes-256'.
@@ -239,9 +231,8 @@
 
 ##
 # @QCryptoBlockOpenOptions:
-#
-# The options that are available for all encryption formats when
-# opening an existing volume
+#     The options that are available for all encryption formats when
+#     opening an existing volume
 #
 # Since: 2.6
 ##
@@ -253,9 +244,8 @@
 
 ##
 # @QCryptoBlockCreateOptions:
-#
-# The options that are available for all encryption formats when
-# initializing a new volume
+#     The options that are available for all encryption formats when
+#     initializing a new volume
 #
 # Since: 2.6
 ##
@@ -267,9 +257,8 @@
 
 ##
 # @QCryptoBlockInfoBase:
-#
-# The common information that applies to all full disk encryption
-# formats
+#     The common information that applies to all full disk encryption
+#     formats
 #
 # @format: the encryption format
 #
@@ -280,8 +269,7 @@
 
 ##
 # @QCryptoBlockInfoLUKSSlot:
-#
-# Information about the LUKS block encryption key slot options
+#     Information about the LUKS block encryption key slot options
 #
 # @active: whether the key slot is currently in use
 #
@@ -301,8 +289,7 @@
 
 ##
 # @QCryptoBlockInfoLUKS:
-#
-# Information about the LUKS block encryption options
+#     Information about the LUKS block encryption options
 #
 # @cipher-alg: the cipher algorithm for data encryption
 #
@@ -340,8 +327,7 @@
 
 ##
 # @QCryptoBlockInfo:
-#
-# Information about the block encryption options
+#     Information about the block encryption options
 #
 # Since: 2.7
 ##
@@ -352,8 +338,7 @@
 
 ##
 # @QCryptoBlockLUKSKeyslotState:
-#
-# Defines state of keyslots that are affected by the update
+#     Defines state of keyslots that are affected by the update
 #
 # @active: The slots contain the given password and marked as active
 #
@@ -367,9 +352,8 @@
 
 ##
 # @QCryptoBlockAmendOptionsLUKS:
-#
-# This struct defines the update parameters that activate/de-activate
-# set of keyslots
+#     This struct defines the update parameters that
+#     activate/de-activate set of keyslots
 #
 # @state: the desired state of the keyslots
 #
@@ -409,9 +393,8 @@
 
 ##
 # @QCryptoBlockAmendOptions:
-#
-# The options that are available for all encryption formats when
-# amending encryption settings
+#     The options that are available for all encryption formats when
+#     amending encryption settings
 #
 # Since: 5.1
 ##
@@ -423,8 +406,7 @@
 
 ##
 # @SecretCommonProperties:
-#
-# Properties for objects of classes derived from secret-common.
+#     Properties for objects of classes derived from secret-common.
 #
 # @format: the data format that the secret is provided in
 #     (default: raw)
@@ -465,8 +447,7 @@
 
 ##
 # @SecretKeyringProperties:
-#
-# Properties for secret_keyring objects.
+#     Properties for secret_keyring objects.
 #
 # @serial: serial number that identifies a key to get from the kernel
 #
@@ -479,8 +460,7 @@
 
 ##
 # @TlsCredsProperties:
-#
-# Properties for objects of classes derived from tls-creds.
+#     Properties for objects of classes derived from tls-creds.
 #
 # @verify-peer: if true the peer credentials will be verified once the
 #     handshake is completed.  This is a no-op for anonymous
@@ -505,8 +485,7 @@
 
 ##
 # @TlsCredsAnonProperties:
-#
-# Properties for tls-creds-anon objects.
+#     Properties for tls-creds-anon objects.
 #
 # Since: 2.5
 ##
@@ -516,8 +495,7 @@
 
 ##
 # @TlsCredsPskProperties:
-#
-# Properties for tls-creds-psk objects.
+#     Properties for tls-creds-psk objects.
 #
 # @username: the username which will be sent to the server.  For
 #     clients only.  If absent, "qemu" is sent and the property will
@@ -531,8 +509,7 @@
 
 ##
 # @TlsCredsX509Properties:
-#
-# Properties for tls-creds-x509 objects.
+#     Properties for tls-creds-x509 objects.
 #
 # @sanity-check: if true, perform some sanity checks before using the
 #     credentials (default: true)
@@ -552,8 +529,7 @@
 
 ##
 # @QCryptoAkCipherAlgo:
-#
-# The supported algorithms for asymmetric encryption ciphers
+#     The supported algorithms for asymmetric encryption ciphers
 #
 # @rsa: RSA algorithm
 #
@@ -564,8 +540,7 @@
 
 ##
 # @QCryptoAkCipherKeyType:
-#
-# The type of asymmetric keys.
+#     The type of asymmetric keys.
 #
 # @public: public key
 #
@@ -578,8 +553,7 @@
 
 ##
 # @QCryptoRSAPaddingAlgo:
-#
-# The padding algorithm for RSA.
+#     The padding algorithm for RSA.
 #
 # @raw: no padding used
 #
@@ -592,8 +566,7 @@
 
 ##
 # @QCryptoAkCipherOptionsRSA:
-#
-# Specific parameters for RSA algorithm.
+#     Specific parameters for RSA algorithm.
 #
 # @hash-alg: `QCryptoHashAlgo`
 #
@@ -607,9 +580,8 @@
 
 ##
 # @QCryptoAkCipherOptions:
-#
-# The options that are available for all asymmetric key algorithms
-# when creating a new QCryptoAkCipher.
+#     The options that are available for all asymmetric key algorithms
+#     when creating a new QCryptoAkCipher.
 #
 # @alg: encryption cipher algorithm
 #
-- 
2.55.0


