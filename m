Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F116DCD8C85
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 07:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVlp1-0000zA-RE; Sat, 06 Jun 2026 03:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lhestz@163.com>) id 1wVloh-0000vr-9i
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 03:51:40 -0400
Received: from m16.mail.163.com ([220.197.31.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lhestz@163.com>) id 1wVlof-0002L5-F8
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 03:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=O0
 O1+QQfVocFk5cDJvMd7hn6pEnZ6yo4yY9ns81jzcc=; b=SnvqoYo8teuETCsTHe
 JydgcxAwrK/0pGs+Aa/3fCZvkEtOuB/CDfvEIgRgu/iqVzNiQAAqMOgVp+TzX7K6
 WUtIaGR39hMAvYgx69ceJPKUzzX1EpcHUWmXGZHKVTN33C4C0thHgTxFvhZuuFQL
 osMP0VkiloF55EGIcejzNw+Gw=
Received: from zinogre.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wCXn8yu0CNqsSoBBw--.35717S2; 
 Sat, 06 Jun 2026 15:48:00 +0800 (CST)
From: helei <lhestz@163.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, zhenwei.pi@linux.dev, mst@redhat.com,
 helei <lhestz@163.com>
Subject: [PATCH 0/1] hw/virtio-crypto: add akcipher keylen validation
Date: Sat,  6 Jun 2026 15:47:55 +0800
Message-ID: <20260606074756.43804-1-lhestz@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXn8yu0CNqsSoBBw--.35717S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRxnYYDUUUU
X-Originating-IP: [2409:8a00:18c7:4890:f871:89bf:55b1:618]
X-CM-SenderInfo: pokh23r26rljoofrz/xtbC9BDD7moj0LAoAgAA3K
Received-SPF: pass client-ip=220.197.31.2; envelope-from=lhestz@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

The virtio-crypto spec does not dictate a maximum length limit for 
asymmetric cipher (akcipher) keys. We added a hard limit which mirrors
the linux kernels's internal limit for akcipher keys (see 
keyctl framework and the add_key syscall).
Maybe we should update the virtio-spec and add a max_akcipher_key_len
field for virtio crypto devices.

helei (1):
  hw/virtio-crypto: enforce max akcipher key length

 hw/virtio/virtio-crypto.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.43.0


