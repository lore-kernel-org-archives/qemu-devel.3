Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1612D33A20
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8OUi-0001XP-Oz; Tue, 05 Nov 2024 13:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8OUa-0001US-9e
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:41:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8OUY-0008Ff-3g
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730832083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uZ4/97SmpomEnnltNlh95cjr7Ge6OIBFD+q8nrdDMgM=;
 b=ABKhC3QaEBxm6qqsWmB57kb1kvn1jxHsiJ9+cP/4AbdgQUat343qMyC+n2HpTQicU0933q
 /ce4DDYrWbX18Zp79f9c09BJb25A9bkGp/TCxT6z5XaZAYBggZmHeEh1ex/yQvgNjw7f7x
 PFsYl+Xnu+wKpsqXhWhsLZHoCfSEGBc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-di0kT_BiOXKBermdHe0Jxg-1; Tue,
 05 Nov 2024 13:41:20 -0500
X-MC-Unique: di0kT_BiOXKBermdHe0Jxg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D9A6195609F; Tue,  5 Nov 2024 18:41:19 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00BED19560A7; Tue,  5 Nov 2024 18:41:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 0/4] Crypto fixes patches
Date: Tue,  5 Nov 2024 18:41:11 +0000
Message-ID: <20241105184115.381511-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

The following changes since commit 44a9394b1d272b53306d097d4bc20ff7ad14b159:

  Merge tag 'pull-nvme-20241104' of https://gitlab.com/birkelund/qemu into staging (2024-11-05 14:23:22 +0000)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/crypto-fixes-pull-request

for you to fetch changes up to a7e42752324a264439bef28da3ee3e2563cf0e16:

  crypto: perform runtime check for hash/hmac support in gcrypt (2024-11-05 18:37:18 +0000)

----------------------------------------------------------------
* Remove deprecated 'loaded' property from crypto objects
* Fix error checking of hash function in gcrypt
* Perform runtime check for hash functions in gcrypt
* Add SM3 hash function to pbkdf

----------------------------------------------------------------

Daniel P. Berrangé (3):
  crypto: purge 'loaded' property that was not fully removed
  crypto: fix error check on gcry_md_open
  crypto: perform runtime check for hash/hmac support in gcrypt

liequan che (1):
  crypto: Introduce SM3 hash hmac pbkdf algorithm

 crypto/hash-gcrypt.c            |  9 ++++--
 crypto/hash-nettle.c            | 14 +++++++++
 crypto/hash.c                   |  3 ++
 crypto/hmac-gcrypt.c            |  5 ++-
 crypto/hmac-nettle.c            | 11 +++++++
 crypto/pbkdf-gcrypt.c           |  6 ++++
 crypto/pbkdf-nettle.c           | 13 ++++++++
 crypto/secret_common.c          | 12 --------
 crypto/tlscredsanon.c           | 35 ---------------------
 crypto/tlscredspsk.c            | 34 ---------------------
 crypto/tlscredsx509.c           | 30 ------------------
 docs/about/removed-features.rst |  6 ++--
 include/crypto/hash.h           |  1 +
 meson.build                     | 39 ++++++++++++++++++++++++
 qapi/crypto.json                | 54 ++++-----------------------------
 tests/unit/test-crypto-hash.c   | 16 ++++++++++
 tests/unit/test-crypto-hmac.c   |  8 +++++
 tests/unit/test-crypto-pbkdf.c  | 16 ++++++++++
 18 files changed, 146 insertions(+), 166 deletions(-)

-- 
2.46.0


