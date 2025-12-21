Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4828E6748D
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 02:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vX9QM-0002a5-K9; Sat, 20 Dec 2025 21:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1vX9QK-0002ZY-Cv
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 21:43:56 -0500
Received: from out-188.mta0.migadu.com ([91.218.175.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1vX9QH-00045a-5Q
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 21:43:56 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1766285012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IRg3p8i4HZQ6mSzKOE3PuAbmaq8RgOc2XDIWbqTfEcE=;
 b=QRrhmR3uDLGebkXMLcuH68+igwclR78ib6OqVAg3ZL4L71+9cLitd7B3gkC1ihsvc+gi6z
 fLrDga5PXBxfDJkND7IbFTtPKpUYWvP5WpefinDIh9dYyB4NDCBYEbBKlRODEdowm9sy1o
 zGVzQ6i/5Z//ud0OjrHmsVvI5K2NZrE=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, arei.gonglei@huawei.com, mcascell@redhat.com,
 nakamurajames123@gmail.com, zhenwei pi <pizhenwei@tensorfer.com>
Subject: [PATCH v2 0/2] Avoid QEMU OOM on huge request from guest
Date: Sun, 21 Dec 2025 10:43:19 +0800
Message-ID: <20251221024321.143196-1-zhenwei.pi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.188; envelope-from=zhenwei.pi@linux.dev;
 helo=out-188.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: zhenwei pi <pizhenwei@tensorfer.com>

v2:
- Fix possible overflow
- Append tag "Fixes: CVE-2025-14876" in commit message

v1:
Fix two issues in this series:
- Verify asym request size from device level
- Limit the maximum size for cryptodev builtin driver

zhenwei pi (2):
  hw/virtio/virtio-crypto: verify asym request size
  cryptodev-builtin: Limit the maximum size

 backends/cryptodev-builtin.c | 9 +++------
 hw/virtio/virtio-crypto.c    | 7 +++++++
 2 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.43.0


