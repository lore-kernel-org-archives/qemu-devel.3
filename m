Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BE5C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 20:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNI6I-0002e2-8z; Fri, 28 Jun 2024 16:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sNI67-0002WI-0A
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 16:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sNI5r-0004FT-26
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 16:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719606072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fX+K4Mqfyu4CsB5OyQlW4mZlWMAvX9ay1be/fqxHjeQ=;
 b=IjyKVGCuLX0aJciY8JwB+ha/ZHX1HiTMLoM3lRGOffExJr4P1dqGjnReJ6WQjLxXgNRi9F
 opSZjMJMOtO27JelvG4ZkXQUs/9ZTahgdPa6EuJG6W4PU33L5BhrDEZlf2o6Gd/Q6/KK4V
 K7rV4hAe7LHF+kx8GqPgWF9vxFyiNI8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-eUDN8NaRMz6sDQuvm2RxNA-1; Fri,
 28 Jun 2024 16:21:09 -0400
X-MC-Unique: eUDN8NaRMz6sDQuvm2RxNA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDA621944D1D; Fri, 28 Jun 2024 20:21:07 +0000 (UTC)
Received: from sparse.com (unknown [10.47.238.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89481300021A; Fri, 28 Jun 2024 20:21:01 +0000 (UTC)
From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Nir Soffer <nsoffer@redhat.com>
Subject: [PATCH v3 0/2] Consider discard option when writing zeros
Date: Fri, 28 Jun 2024 23:20:56 +0300
Message-ID: <20240628202058.1964986-1-nsoffer@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Punch holes only when the image is opened with discard=on or discard=unmap.

Tested by:
- new write-zeroes-unmap iotest on xfs, ext4, and tmpfs
- tests/qemu-iotests/check -raw
- tests/qemu-iotests/check -qcow2

Changes since v2
- Add write-zeroes-unmap iotest
- Fix iotest missing discard=unmap

v2 was here:
https://lists.nongnu.org/archive/html/qemu-block/2024-06/msg00231.html

Nir Soffer (2):
  qemu-iotest/245: Add missing discard=unmap
  Consider discard option when writing zeros

 block/io.c                                    |   9 +-
 tests/qemu-iotests/245                        |   2 +-
 tests/qemu-iotests/tests/write-zeroes-unmap   | 127 ++++++++++++++++++
 .../qemu-iotests/tests/write-zeroes-unmap.out |  81 +++++++++++
 4 files changed, 214 insertions(+), 5 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/write-zeroes-unmap
 create mode 100644 tests/qemu-iotests/tests/write-zeroes-unmap.out

-- 
2.45.2


