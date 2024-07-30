Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A131CC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 08:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYhxN-0008GW-S8; Tue, 30 Jul 2024 04:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYhwt-00069i-1m
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:11:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYhwd-0001Jf-In
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722327054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0JopmNllRYFEMaPc67cAs60A4W60BVFuQXpNv3T5Ac=;
 b=NFfdMLEo6KvH79i7x4HNZCl5eKM4xJcPthBc3NN1fOMzNzIJyrtABjx5XJ0Ubex4cPuAAR
 Z1b4oAC0y+zALG24porQr2YpJ9Hhly/JbDvA+dYlKS43VFRQDWYqfJYG885VxOuHgr7dkF
 Pzbm9qr3+cWylA0cd7sNZ/dCdQzHtZ8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-g7u-qIc5PzuKfrYDUWx8NA-1; Tue,
 30 Jul 2024 04:10:51 -0400
X-MC-Unique: g7u-qIc5PzuKfrYDUWx8NA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8E8F1955D50; Tue, 30 Jul 2024 08:10:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35FDD3000198; Tue, 30 Jul 2024 08:10:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1B7E921F4BA1; Tue, 30 Jul 2024 10:10:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, andrew@codeconstruct.com.au, andrew@daynix.com,
 arei.gonglei@huawei.com, berrange@redhat.com, berto@igalia.com,
 borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com, den@openvz.org,
 eblake@redhat.com, eduardo@habkost.net, farman@linux.ibm.com,
 farosas@suse.de, hreitz@redhat.com, idryomov@gmail.com, iii@linux.ibm.com,
 jamin_lin@aspeedtech.com, jasowang@redhat.com, joel@jms.id.au,
 jsnow@redhat.com, kwolf@redhat.com, leetroy@gmail.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 michael.roth@amd.com, mst@redhat.com, mtosatti@redhat.com,
 nsg@linux.ibm.com, pasic@linux.ibm.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, peterx@redhat.com, philmd@linaro.org,
 pizhenwei@bytedance.com, pl@dlhnet.de, richard.henderson@linaro.org,
 stefanha@redhat.com, steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH 17/18] qapi/cryptodev: Drop unwanted 'prefix'
Date: Tue, 30 Jul 2024 10:10:31 +0200
Message-ID: <20240730081032.1246748-18-armbru@redhat.com>
In-Reply-To: <20240730081032.1246748-1-armbru@redhat.com>
References: <20240730081032.1246748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

QAPI's 'prefix' feature can make the connection between enumeration
type and its constants less than obvious.  It's best used with
restraint.

QCryptodevBackendServiceType has a 'prefix' that overrides the
generated enumeration constants' prefix to QCRYPTODEV_BACKEND_SERVICE.

Drop it.  The prefix becomes QCRYPTODEV_BACKEND_SERVICE_TYPE.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/cryptodev.json             |  1 -
 backends/cryptodev-builtin.c    |  8 ++++----
 backends/cryptodev-lkcf.c       |  2 +-
 backends/cryptodev-vhost-user.c |  6 +++---
 backends/cryptodev.c            |  6 +++---
 hw/virtio/virtio-crypto.c       | 10 +++++-----
 6 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
index 60f8fe8e4a..65abc16842 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -31,7 +31,6 @@
 # Since: 8.0
 ##
 { 'enum': 'QCryptodevBackendServiceType',
-  'prefix': 'QCRYPTODEV_BACKEND_SERVICE',
   'data': ['cipher', 'hash', 'mac', 'aead', 'akcipher']}
 
 ##
diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 6f3990481b..170c93a6be 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -68,7 +68,7 @@ static void cryptodev_builtin_init_akcipher(CryptoDevBackend *backend)
     opts.u.rsa.padding_alg = QCRYPTO_RSA_PADDING_ALGO_RAW;
     if (qcrypto_akcipher_supports(&opts)) {
         backend->conf.crypto_services |=
-                     (1u << QCRYPTODEV_BACKEND_SERVICE_AKCIPHER);
+                     (1u << QCRYPTODEV_BACKEND_SERVICE_TYPE_AKCIPHER);
         backend->conf.akcipher_algo = 1u << VIRTIO_CRYPTO_AKCIPHER_RSA;
     }
 }
@@ -93,9 +93,9 @@ static void cryptodev_builtin_init(
     backend->conf.peers.ccs[0] = cc;
 
     backend->conf.crypto_services =
-                         1u << QCRYPTODEV_BACKEND_SERVICE_CIPHER |
-                         1u << QCRYPTODEV_BACKEND_SERVICE_HASH |
-                         1u << QCRYPTODEV_BACKEND_SERVICE_MAC;
+                         1u << QCRYPTODEV_BACKEND_SERVICE_TYPE_CIPHER |
+                         1u << QCRYPTODEV_BACKEND_SERVICE_TYPE_HASH |
+                         1u << QCRYPTODEV_BACKEND_SERVICE_TYPE_MAC;
     backend->conf.cipher_algo_l = 1u << VIRTIO_CRYPTO_CIPHER_AES_CBC;
     backend->conf.hash_algo = 1u << VIRTIO_CRYPTO_HASH_SHA1;
     /*
diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
index fde32950f6..0dc4b067f5 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -230,7 +230,7 @@ static void cryptodev_lkcf_init(CryptoDevBackend *backend, Error **errp)
     backend->conf.peers.ccs[0] = cc;
 
     backend->conf.crypto_services =
-        1u << QCRYPTODEV_BACKEND_SERVICE_AKCIPHER;
+        1u << QCRYPTODEV_BACKEND_SERVICE_TYPE_AKCIPHER;
     backend->conf.akcipher_algo = 1u << VIRTIO_CRYPTO_AKCIPHER_RSA;
     lkcf->running = true;
 
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index c3283ba84a..e33fb78521 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -221,9 +221,9 @@ static void cryptodev_vhost_user_init(
                      cryptodev_vhost_user_event, NULL, s, NULL, true);
 
     backend->conf.crypto_services =
-                         1u << QCRYPTODEV_BACKEND_SERVICE_CIPHER |
-                         1u << QCRYPTODEV_BACKEND_SERVICE_HASH |
-                         1u << QCRYPTODEV_BACKEND_SERVICE_MAC;
+                         1u << QCRYPTODEV_BACKEND_SERVICE_TYPE_CIPHER |
+                         1u << QCRYPTODEV_BACKEND_SERVICE_TYPE_HASH |
+                         1u << QCRYPTODEV_BACKEND_SERVICE_TYPE_MAC;
     backend->conf.cipher_algo_l = 1u << VIRTIO_CRYPTO_CIPHER_AES_CBC;
     backend->conf.hash_algo = 1u << VIRTIO_CRYPTO_HASH_SHA1;
 
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index fff89fd62a..76dfe65904 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -74,7 +74,7 @@ static int qmp_query_cryptodev_foreach(Object *obj, void *data)
 
     backend = CRYPTODEV_BACKEND(obj);
     services = backend->conf.crypto_services;
-    for (i = 0; i < QCRYPTODEV_BACKEND_SERVICE__MAX; i++) {
+    for (i = 0; i < QCRYPTODEV_BACKEND_SERVICE_TYPE__MAX; i++) {
         if (services & (1 << i)) {
             QAPI_LIST_PREPEND(info->service, i);
         }
@@ -424,11 +424,11 @@ cryptodev_backend_complete(UserCreatable *uc, Error **errp)
     }
 
     services = backend->conf.crypto_services;
-    if (services & (1 << QCRYPTODEV_BACKEND_SERVICE_CIPHER)) {
+    if (services & (1 << QCRYPTODEV_BACKEND_SERVICE_TYPE_CIPHER)) {
         backend->sym_stat = g_new0(CryptodevBackendSymStat, 1);
     }
 
-    if (services & (1 << QCRYPTODEV_BACKEND_SERVICE_AKCIPHER)) {
+    if (services & (1 << QCRYPTODEV_BACKEND_SERVICE_TYPE_AKCIPHER)) {
         backend->asym_stat = g_new0(CryptodevBackendAsymStat, 1);
     }
 }
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 5034768bff..0ab8ae3282 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1008,19 +1008,19 @@ static uint32_t virtio_crypto_init_services(uint32_t qservices)
 {
     uint32_t vservices = 0;
 
-    if (qservices & (1 << QCRYPTODEV_BACKEND_SERVICE_CIPHER)) {
+    if (qservices & (1 << QCRYPTODEV_BACKEND_SERVICE_TYPE_CIPHER)) {
         vservices |= (1 << VIRTIO_CRYPTO_SERVICE_CIPHER);
     }
-    if (qservices & (1 << QCRYPTODEV_BACKEND_SERVICE_HASH)) {
+    if (qservices & (1 << QCRYPTODEV_BACKEND_SERVICE_TYPE_HASH)) {
         vservices |= (1 << VIRTIO_CRYPTO_SERVICE_HASH);
     }
-    if (qservices & (1 << QCRYPTODEV_BACKEND_SERVICE_MAC)) {
+    if (qservices & (1 << QCRYPTODEV_BACKEND_SERVICE_TYPE_MAC)) {
         vservices |= (1 << VIRTIO_CRYPTO_SERVICE_MAC);
     }
-    if (qservices & (1 << QCRYPTODEV_BACKEND_SERVICE_AEAD)) {
+    if (qservices & (1 << QCRYPTODEV_BACKEND_SERVICE_TYPE_AEAD)) {
         vservices |= (1 << VIRTIO_CRYPTO_SERVICE_AEAD);
     }
-    if (qservices & (1 << QCRYPTODEV_BACKEND_SERVICE_AKCIPHER)) {
+    if (qservices & (1 << QCRYPTODEV_BACKEND_SERVICE_TYPE_AKCIPHER)) {
         vservices |= (1 << VIRTIO_CRYPTO_SERVICE_AKCIPHER);
     }
 
-- 
2.45.0


