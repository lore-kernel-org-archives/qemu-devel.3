Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C1DCD98D2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 01:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZf7v-0002ed-0k; Tue, 16 Jun 2026 21:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wZf7s-0002eA-6F
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 21:31:32 -0400
Received: from [115.124.30.124] (helo=out30-124.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wZf7n-000112-00
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 21:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1781659861; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=ovRrQ727cgvVcegfLcK/70kffIOGrzNGAzU5N5QXC0Q=;
 b=eSuke4WCLvwe198MCB3sRWUNHEUm3rXv/gwARIDLBiHKf76VySPIdLm8VPpXFenBnMdpSHyEChHXoJT8jhS9WUmxPUhaZFrUMgYOGOWXjDm9aexnBx/6bb88pU+OemL/gdxVGjiItvqNtkWUQZg/vIgj6/KpCA+RLryDKM9spak=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R411e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0X516JT0_1781659859; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X516JT0_1781659859 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 17 Jun 2026 09:31:00 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: kdutta@redhat.com
Cc: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	mst@redhat.com
Subject: Re: [PATCH v8 2/2] Implement VirtIO Network Notification Coalescing
Date: Wed, 17 Jun 2026 09:30:59 +0800
Message-ID: <20260617013059.99468-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260613223513.865744-3-kdutta@redhat.com>
References: <20260613223513.865744-1-kdutta@redhat.com>
 <20260613223513.865744-3-kdutta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.124 (deferred)
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

On Fri, 13 Jun 2026, Koushik Dutta wrote:
> +        VMSTATE_UINT32(rx_coal_usecs, VirtIONet),
> +        VMSTATE_UINT32(tx_coal_usecs, VirtIONet),
> +        VMSTATE_UINT32(rx_coal_packets, VirtIONet),
> +        VMSTATE_UINT32(tx_coal_packets, VirtIONet),
>          VMSTATE_END_OF_LIST()
>      },

These new fields are added directly to the main
vmstate_virtio_net_device fields list, which breaks both forward and
backward migration:

  - Forward: old QEMU produces a shorter stream; new QEMU expects
    more fields and fails to load.

  - Backward: new QEMU emits extra fields that shift the stream
    layout for older QEMU.

They should go in a subsection with a .needed predicate instead:

  static bool has_notf_coal(void *opaque, int version_id)
  {
      return virtio_vdev_has_feature(VIRTIO_DEVICE(opaque),
                                     VIRTIO_NET_F_NOTF_COAL);
  }

  static const VMStateDescription vmstate_virtio_net_coal = {
      .name   = "virtio-net/notf_coal",
      .needed = has_notf_coal,
      .fields = (const VMStateField[]) {
          VMSTATE_UINT32(rx_coal_usecs, VirtIONet),
          VMSTATE_UINT32(rx_coal_packets, VirtIONet),
          VMSTATE_UINT32(tx_coal_usecs, VirtIONet),
          VMSTATE_UINT32(tx_coal_packets, VirtIONet),
          VMSTATE_END_OF_LIST()
      }
  };

and registered in the .subsections array of
vmstate_virtio_net_device.

Regards,
Bin Guo

