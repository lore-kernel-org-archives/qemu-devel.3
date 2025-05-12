Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1850C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 14:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEU5N-0002Kr-FF; Mon, 12 May 2025 10:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEU5K-0002By-7L
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEU5G-0006Y7-G7
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747059885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0Szk+cN0DcNKc50/pukhB4IlHMMuEZDq/eVjygOyXxc=;
 b=BEiT25QYPhX4gAGp9TnfsMpkIBP/n5itx5DKsW6o7sFgyHlgsYxGvqlqSwYk3voq+2/Jn4
 USUUbglIoe0w5S2oatRtP21NxCzKx/j+YYdKP/ZgM+HaI80c2egeocb1Ze+46NkD1JOZBJ
 YfLG8UOH72Ed8J4rJVPhKEmJt2+uR5I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-FsNE7mnyP32CDOck9ftRMA-1; Mon,
 12 May 2025 10:24:43 -0400
X-MC-Unique: FsNE7mnyP32CDOck9ftRMA-1
X-Mimecast-MFC-AGG-ID: FsNE7mnyP32CDOck9ftRMA_1747059882
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 930161955D79
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 14:24:42 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.162])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7876519560A3; Mon, 12 May 2025 14:24:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/4] crypto: fully drop built-in cipher provider
Date: Mon, 12 May 2025 15:24:35 +0100
Message-ID: <20250512142439.1101159-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Changed in v2:

 - Addressed various unit tests which blindly assume AES was always
   available

Daniel P. Berrangé (4):
  tests: skip encrypted secret tests if AES is not available
  tests: skip legacy qcow2 encryption test if AES is not available
  tests: fix skipping cipher tests when AES is not available
  crypto: fully drop built-in cipher provider

 crypto/cipher-builtin.c.inc     | 303 --------------------------------
 crypto/cipher-stub.c.inc        |  41 +++++
 crypto/cipher.c                 |   2 +-
 tests/unit/test-crypto-block.c  |   7 +
 tests/unit/test-crypto-cipher.c |  13 +-
 tests/unit/test-crypto-secret.c |  28 +--
 6 files changed, 74 insertions(+), 320 deletions(-)
 delete mode 100644 crypto/cipher-builtin.c.inc
 create mode 100644 crypto/cipher-stub.c.inc

-- 
2.49.0


