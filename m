Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9F0C531CA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmspv-0008N2-QT; Thu, 23 Jul 2026 08:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <82bc736158e827e05d4b55da27c39d42e2062e96@kylie.crudebyte.com>)
 id 1wmspv-0008Mo-23; Thu, 23 Jul 2026 08:47:39 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <82bc736158e827e05d4b55da27c39d42e2062e96@kylie.crudebyte.com>)
 id 1wmspt-0001Al-Aq; Thu, 23 Jul 2026 08:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=fiFS+g8SAw7nN+LFMTTpbECKPKO+FDmv1qXXgasae1c=; b=iSuwu
 e4+Xz9MAmc4tGpzE7OPjxwBlM0Gqtkk1TK4HZSkBKO9U1Sv9NM7U57Mj2jL0UkGFCzu67z9HhaCCZ
 vlAOUmHukUyRPz0Mi9xCkjENuidDVFpms7G+uXKWj/0P/MBQvtmHTpgFwH15dfJI/GmdYMN4fmt4h
 WLcDSo8mLD381mVHoi1aFvVo+/vcCp/WedCGwxM2bQHXKGy+WbXboNMQU+WsqNe/eYe8WNZQOT2dW
 ZK6TEeSjBF7BSj4vkXGMKZDCHbG8q48V2lJqs/Y3qz5T+cqudd5RJlnHBmPjmhCn5q94k2n88XWK5
 Qqgjy6BUowZ3tA+JYGtUTuSp1v+Zv+XVz1ar9jJ9/fLLc8lBy6pLSZ/xBvizukBIesiW4qiKDo/RZ
 d5PS5tB7QDmo5JM6+JAMVE2tnoAtH8e9/QLYR+jE2xm/X7X2EprEtNSdMNUqxNHQmBSKpm9MVif+c
 em4RYbL5+w4z7ZylEFywg/JxQNnNhyo5gbFJyrUqvV6y1WW0EbDNoiP4p1xJ3pfvcD5gzZf5HfInf
 hxoEhi9ksOuepndwFKLCcHlcLtA4yjeA6z12NGD5rhghWhafpvgDYWyVqKtjJog2W7cXm5VIX3RzL
 3ZmLXAv5bud5/wE4+sZihHA4/V+a6YhMJ8bHGCTlZ5idDj96FOZH35BT2GeEfM=;
Message-ID: <cover.1784809978.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 23 Jul 2026 14:43:24 +0200
Subject: [PATCH v3 0/2] 9p: fix guest-triggered Treaddir/ACPI eject UAF
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jia Jia <physicalmtea@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=82bc736158e827e05d4b55da27c39d42e2062e96@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A guest can trigger unplugging 9pfs server's virtio-pci device via ACPI
eject. As a consequence the device is unrealized, server's internal state
is freed while pending coroutines would still have access to them, causing
a potential heap-use-after-free.

Overview Patches:

 - Patch 1: this is the core fix, that drains all PDUs (i.e. coroutines
   that handle individual pending requests in parallel) before freeing
   server state.

 - Patch 2: fixes a similar identified issue with the Xen transport, even
   though not triggered via ACPI, it is also prone to UAF, plus a resource
   leak.

v3:
  - Patch 2: set s->transport = NULL in v9fs_device_unrealize_common()
    and make the idempotent check just guard the v9fs_reset(s) and
    v9fs_device_unrealize_common(s) calls in xen_9pfs_disconnect() to
    prevent a NULL pointer dereference.

v2: [ https://lore.kernel.org/qemu-devel/cover.1784392605.git.qemu_oss@crudebyte.com/ ]
  - Patch 1: Make Jia the official author of this patch.
  - Drop prev. patch 2 ("hw/9pfs/virtio: disable hotpluggable property...")
  - Patch 2: defer explict xen_9pfs_disconnect() call from error paths of
    xen_9pfs_pdu_vmarshal() and xen_9pfs_pdu_vunmarshal().

Christian Schoenebeck (1):
  hw/9pfs/xen: drain in-flight PDUs before xen-9p disconnect

Jia Jia (1):
  hw/9pfs/virtio: drain in-flight PDUs before virtio-9p unrealize

 hw/9pfs/9p.c               |  1 +
 hw/9pfs/virtio-9p-device.c |  1 +
 hw/9pfs/xen-9p-backend.c   | 17 +++++++++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.47.3


