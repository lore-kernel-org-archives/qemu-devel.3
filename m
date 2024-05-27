Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BE9C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBckj-0005qw-Gx; Mon, 27 May 2024 11:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBckh-0005pl-JQ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBckf-0007Yr-BP
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716825548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DBH/BKkg2AKdhL5JbEwE0g+O1Vu2j3IEE0BlLeL/LiM=;
 b=YkX0+HE2aiCfsyWE02b06P2QPO7gsDRklpX6YPidF6n3g/8DKfy+VPoqqmaZQKn4k4Lcvy
 TN0wuaXEp13qldJRlK+r7tB5EAr354suY6DrtN//7Vl2ZUHEx9qxL7Q2g4p/Hs11NJ8DQx
 1dr3i8zXIq4ck5nucJzlGxHHj2qbFOo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-FLnJkieINJumCzGSaSFLzA-1; Mon, 27 May 2024 11:59:07 -0400
X-MC-Unique: FLnJkieINJumCzGSaSFLzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D52C1101A525;
 Mon, 27 May 2024 15:59:06 +0000 (UTC)
Received: from localhost (unknown [10.39.195.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2138E105480A;
 Mon, 27 May 2024 15:59:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/2] block/crypto: do not require number of threads upfront
Date: Mon, 27 May 2024 11:58:49 -0400
Message-ID: <20240527155851.892885-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The block layer does not know how many threads will perform I/O. It is possible
to exceed the number of threads that is given to qcrypto_block_open() and this
can trigger an assertion failure in qcrypto_block_pop_cipher().

This patch series removes the n_threads argument and instead handles an
arbitrary number of threads.
---
Is it secure to store the key in QCryptoBlock? In this series I assumed the
answer is yes since the QCryptoBlock's cipher state is equally sensitive, but
I'm not familiar with this code or a crypto expert.

Stefan Hajnoczi (2):
  block/crypto: create ciphers on demand
  crypto/block: drop qcrypto_block_open() n_threads argument

 crypto/blockpriv.h             |  13 ++--
 include/crypto/block.h         |   2 -
 block/crypto.c                 |   1 -
 block/qcow.c                   |   2 +-
 block/qcow2.c                  |   5 +-
 crypto/block-luks.c            |   4 +-
 crypto/block-qcow.c            |   8 +--
 crypto/block.c                 | 116 ++++++++++++++++++++-------------
 tests/unit/test-crypto-block.c |   4 --
 9 files changed, 85 insertions(+), 70 deletions(-)

-- 
2.45.1


