Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91024CED277
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 07:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy56B-0008AI-Jz; Tue, 08 Oct 2024 03:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy569-00089Z-Ne
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy567-0005bf-WA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728374254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=549Tiy8Y+tC10lhcSwCbkO0irpCNNvJ+QcGsoT9yqw8=;
 b=Zg9IgOUDRGdHiLz50JViWuacWkTkSgviQA3smDmFOra3VteNjhLlOS+KKbjz+qz/6UHE6N
 X9k/GLNqly6mSgMs0cQp/o4EMF9edovnGgBBrm5E0sqZeYj2oF8/JRqxbdVLYhF8naMP2Z
 roNSQQJBX5zjVkBZ4qGoKa+1OlNl4vU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-nnDn-o5WOuSOjmPdSJfniA-1; Tue,
 08 Oct 2024 03:57:29 -0400
X-MC-Unique: nnDn-o5WOuSOjmPdSJfniA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D81119560A3; Tue,  8 Oct 2024 07:57:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1DC5B300018D; Tue,  8 Oct 2024 07:57:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	berrange@redhat.com
Cc: kris.conklin@seagate.com, jonathan.henze@seagate.com,
 evan.burgess@seagate.com, peter.maydell@linaro.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 00/16] hw/misc/aspeed_hace: Fix SG Accumulative Hash
 Calculations
Date: Tue,  8 Oct 2024 09:57:07 +0200
Message-ID: <20241008075724.2772149-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

This is a resping of Alejandro's series fixing SG Accumulative Hash
Calculations. See [1] for more details. 

The goal of this patch series is to fix accumulative hashing support
in the Aspeed HACE module. The issue that stemmed this patch was a
failure to boot an OpenBMC image using the "ast2600-evb" machine. The
U-boot 2019.04 loader failed to verify image hashes.

These incorrect image hashes given by the HACE to the U-boot guest are
due to an oversight in the HACE module. Previously when operating in
scatter-gather accumulative mode, the HACE would cache the address
provided by the guest which contained the source data. However, there
was no deep copy, so when HACE generated the digest upon the reception
of the final accumulative chunk the digest was incorrect, as the
addresses provided had their regions overwritten by that time.

This fix consists of two main steps:
* Add an accumulative hashing function to the qcrypto library
* Modify the HACE module to use the accumulative hashing functions

All the crypto library backends (nettle, gnutls, etc.) support
accumulative hashing, so it was trivial to create wrappers for those
functions.

Changes in v5 (clg):

 - Changed documentation "non-zero on error" -> "-1 on error" 
 - Dropped qcrypto_hash_supports() in qcrypto_glib_hash_new()
 - Removed superfluous cast (GChecksum *) in qcrypto_glib_hash_free()
 - Reworked qcrypto_glib_hash_finalize() 
 - Dropped qcrypto_hash_supports() in qcrypto_gcrypt_hash_new()
 - Reworked qcrypto_gcrypt_hash_finalize()
 - Handled gcry_md_open() errors in qcrypto_gcrypt_hash_new()
 - Dropped qcrypto_hash_supports() in qcrypto_gnutls_hash_new()
 - Reworked qcrypto_gnutls_hash_finalize()
 - Handled gnutls_hash_init() errors in qcrypto_gnutls_hash_new()
 - Replaced gnutls_hash_deinit() by gnutls_hash_output() in
   qcrypto_gnutls_hash_finalize()
 - Freed resources with gnutls_hash_deinit() in qcrypto_gnutls_hash_free() 
 - Dropped qcrypto_hash_supports() in qcrypto_nettle_hash_new() 
 - Split iov changes from original patch
 - Handled qcrypto_afalg_hash_ctx_new() errors in qcrypto_afalg_hash_new()
 - Freed alg_name in qcrypto_afalg_hash_new()
 - Reworked qcrypto_afalg_recv_from_kernel()
 - Split iov changes from original patch 
 - Reworked qcrypto_hash_bytesv() error handling
 - Used hash->driver int qcrypto_hash_new(), qcrypto_hash_free() qcrypto_hash_updatev()
 - Introduced qcrypto_hash_supports() check in  qcrypto_hash_new()
 - Introduced g_autofree variables in qcrypto_hash_finalize_digest()
   and qcrypto_hash_finalize_base64()
 - Re-arrranged code in qcrypto_hash_digestv() and qcrypto_hash_digest()
 - Improved test_hash_accumulate() with g_autofree variables 
 - Fixed spelling in commit log 
 - Checkpatch fixes 

Changes in V4:
* Restructured patches so unit tests pass for each independently.
* Freeing hash context is now a void function.
* Added autoptr cleanup function definition for qcrypto_hash_free.
* Separated qcrypto_hash_update into qcrypto_hash_update and
  qcrypto_hash_updatev.
* Changed public hash functions to use afalg implementation correctly if support
  is enabled.
* Fixed accumulative hashing in afalg driver (pass MSG_MORE socket flag).

Changes in V3:
* Reworked crypto hash API with comments from Daniel
  * Creation/Deletion of contexts, updating, and finalizing
  * Modified existing API functions to use the new 4 main core functions
  * Added test for accumulative hashing
  * Added afalg driver implementation
* Fixed bug in HACE module where hash context fails to allocate,
  causing the HACE internal state to be incorrect and segfault.

Changes in V2:
* Fixed error checking bug in libgcrypt crypto backend of
  accumulate_bytesv

Alejandro Zeise (16):
  crypto: accumulative hashing API
  crypto/hash-glib: Implement new hash API
  crypto/hash-gcrypt: Implement new hash API
  crypto/hash-gnutls: Implement new hash API
  crypto/hash-nettle: Implement new hash API
  util/iov: Introduce iov_send_recv_with_flags()
  crypto/hash-afalg: Implement new hash API
  crypto/hash: Implement and use new hash API
  tests/unit/test-crypto-hash: accumulative hashing
  crypto/hash-glib: Remove old hash API functions
  crypto/hash-gcrypt: Remove old hash API functions
  crypto/hash-gnutls: Remove old hash API functions
  crypto/hash-nettle: Remove old hash API functions
  crypto/hash-afalg: Remove old hash API functions
  crypto/hashpriv: Remove old hash API function
  hw/misc/aspeed_hace: Fix SG Accumulative hashing

 crypto/hashpriv.h             |  13 ++-
 include/crypto/hash.h         | 119 ++++++++++++++++++++++++
 include/hw/misc/aspeed_hace.h |   4 +
 include/qemu/iov.h            |  27 ++++++
 crypto/hash-afalg.c           | 167 ++++++++++++++++++++++++----------
 crypto/hash-gcrypt.c          | 112 +++++++++++++----------
 crypto/hash-glib.c            |  92 +++++++++++--------
 crypto/hash-gnutls.c          |  97 +++++++++++++-------
 crypto/hash-nettle.c          |  81 ++++++++++-------
 crypto/hash.c                 | 161 ++++++++++++++++++++++++++------
 hw/misc/aspeed_hace.c         |  96 ++++++++++---------
 tests/unit/test-crypto-hash.c |  46 ++++++++++
 util/iov.c                    |  25 +++--
 13 files changed, 756 insertions(+), 284 deletions(-)

-- 
2.46.2


