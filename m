Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32482ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfCF-0007Kn-5F; Mon, 09 Sep 2024 10:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1snfCC-0007Iv-TU
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1snfCB-0003FX-BW
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725891406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jksNmU8jQNszcUXuxuCVvEdlZbPxFM9mGiQf1mQGBk8=;
 b=cbHu028fy3JLStW2ozoTotAPSkdEg7JFnhELR2DnA452KiaJRGVXEUV4jG34OAf3Y/OJuN
 KrilohhiqYKeWwqj/+Nd2FNBbULOMA/V3BfK9uXHPS3cDH+o6NKwFqBakKMPG3wGxNkbKi
 R7O0PHF8YuOCEFuGF2bFJv0hE4oaTnQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-pQJONKklMN2byaGj354SEQ-1; Mon,
 09 Sep 2024 10:16:43 -0400
X-MC-Unique: pQJONKklMN2byaGj354SEQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 986D41955DCC; Mon,  9 Sep 2024 14:16:41 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.212])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F0C61956054; Mon,  9 Sep 2024 14:16:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 00/10] Crypto fixes patches
Date: Mon,  9 Sep 2024 15:16:25 +0100
Message-ID: <20240909141635.1459701-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit f2aee60305a1e40374b2fc1093e4d04404e780ee:

  Merge tag 'pull-request-2024-09-08' of https://gitlab.com/huth/qemu into staging (2024-09-09 10:47:24 +0100)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/crypto-fixes-pull-request

for you to fetch changes up to 10a1d34fc0d4dfe0dd6f5ec73f62dc1afa04af6c:

  crypto: Introduce x509 utils (2024-09-09 15:13:38 +0100)

----------------------------------------------------------------
Various crypto fixes

 * Support sha384 with glib crypto backend
 * Improve error reporting for unsupported cipher modes
 * Avoid memory leak when bad cipher mode is given
 * Run pbkdf tests on macOS
 * Runtime check for pbkdf hash impls with gnutls & gcrypt
 * Avoid hangs counter pbkdf iterations on some Linux kernels
   by using a throwaway thread for benchmarking performance
 * Fix iotests expected output from gnutls errors

----------------------------------------------------------------

Daniel P. Berrangé (6):
  iotests: fix expected output from gnutls
  crypto: check gnutls & gcrypt support the requested pbkdf hash
  tests/unit: always build the pbkdf crypto unit test
  tests/unit: build pbkdf test on macOS
  crypto: avoid leak of ctx when bad cipher mode is given
  crypto: use consistent error reporting pattern for unsupported cipher
    modes

Dorjoy Chowdhury (3):
  crypto: Define macros for hash algorithm digest lengths
  crypto: Support SHA384 hash when using glib
  crypto: Introduce x509 utils

Tiago Pasqualini (1):
  crypto: run qcrypto_pbkdf2_count_iters in a new thread

 crypto/cipher-nettle.c.inc     | 25 ++++++++---
 crypto/hash-glib.c             |  2 +-
 crypto/hash.c                  | 14 +++----
 crypto/meson.build             |  4 ++
 crypto/pbkdf-gcrypt.c          |  2 +-
 crypto/pbkdf-gnutls.c          |  2 +-
 crypto/pbkdf.c                 | 53 ++++++++++++++++++++----
 crypto/x509-utils.c            | 76 ++++++++++++++++++++++++++++++++++
 include/crypto/hash.h          |  8 ++++
 include/crypto/x509-utils.h    | 22 ++++++++++
 tests/qemu-iotests/233.out     | 12 +++---
 tests/unit/meson.build         |  4 +-
 tests/unit/test-crypto-pbkdf.c | 13 +++---
 13 files changed, 200 insertions(+), 37 deletions(-)
 create mode 100644 crypto/x509-utils.c
 create mode 100644 include/crypto/x509-utils.h

-- 
2.45.2


