Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9826EF46101
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f8K-0000DO-HB; Mon, 23 Mar 2026 09:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w4f8H-0000Cd-HP; Mon, 23 Mar 2026 09:15:49 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w4f8F-0000Jw-7g; Mon, 23 Mar 2026 09:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774271746; x=1805807746;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ddM/pjitc8NVTsdDeS8Pv9OSwi1iUt377WGLPo5NOz8=;
 b=E1QF57CUAVQGhIUfWEto4dTTedgCwOCuD/qsdvtbMUYi1Rv1yKV6oav1
 fpllVMW0A9ZapdvpEYp/s9EzuJ4GxFE6STQaErbQsJHBOObx6YGAqXeEY
 la4nSry0MeCwm6xiAiotzKTiDSiMBI1Hs22gQ17YRS3/edLZS8l2a64jj
 F5XyKsAIVVNGHXkcnLZVX6bWFQMx/uzkL8CFHrX1aPIOJeFwGfNqx5GJY
 pA+AqsPGIWV0WiZQjBTKa+sF/NsVsACff2u35LFNbRfWVwk6OkWa9lOUv
 rcMHwXDo5BfPEAdzkp2Aa/mo1WELLzDmgRiNhXSfqb4yHeG1X+jDXe27F g==;
X-CSE-ConnectionGUID: Vk5ZJXmAT46KiEBfaqIvnQ==
X-CSE-MsgGUID: rII2MZDfRSeWAdOIh/o7gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="97888917"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="97888917"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 06:15:40 -0700
X-CSE-ConnectionGUID: DLI9bQcCSKWlHoDe6PrILg==
X-CSE-MsgGUID: axayulZqQWO+o9BgDNMXZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="228748544"
Received: from junjieca-mobl.ccr.corp.intel.com ([10.124.242.111])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 06:15:38 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, yuri.benditovich@daynix.com,
 akihiko.odaki@daynix.com, qemu-stable@nongnu.org, junjie.cao@intel.com
Subject: [PATCH] virtio-net: validate RSS indirections_len in post_load
Date: Mon, 23 Mar 2026 21:15:31 +0800
Message-ID: <20260323131531.1976-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.53.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

virtio_net_handle_rss() enforces that indirections_len is a non-zero
power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
virtio_net_rss_post_load() applies none of these checks to values
restored from the migration stream.

A crafted migration stream can set indirections_len to 0.  Even if it
also clears redirect, virtio_load() calls set_features_nocheck() after
the device vmstate (including the RSS subsection and its post_load) has
already been loaded, re-deriving redirect from the negotiated guest
features.  When VIRTIO_NET_F_RSS was negotiated, redirect is set back
to true regardless of the migration stream value.  The receive path
then computes

    hash & (indirections_len - 1)   /* wraps to 0xFFFFFFFF via int promotion */

and uses the result to index into indirections_table, which was not
allocated by the VMState loader when the element count is zero (see
vmstate_handle_alloc()), resulting in a NULL pointer dereference that
crashes QEMU:

  #0  virtio_net_process_rss    ../hw/net/virtio-net.c:1901
  #1  virtio_net_receive_rcu    ../hw/net/virtio-net.c:1921
  #2  virtio_net_do_receive     ../hw/net/virtio-net.c:2061
  #3  nc_sendv_compat           ../net/net.c:823
  #4  qemu_deliver_packet_iov   ../net/net.c:870

The RSS subsection is only loaded when rss_data.enabled is true (via
virtio_net_rss_needed()), and the command path always produces
indirections_len in {1, 2, 4, …, 128}, so an unconditional check
cannot reject a legitimate migration stream.

Fixes: e41b711485e5 ("virtio-net: add migration support for RSS and hash report")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/net/virtio-net.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2a5d642a64..3038836098 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3427,6 +3427,15 @@ static int virtio_net_rss_post_load(void *opaque, int version_id)
         n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
     }
 
+    if (n->rss_data.indirections_len == 0 ||
+        n->rss_data.indirections_len > VIRTIO_NET_RSS_MAX_TABLE_LEN ||
+        !is_power_of_2(n->rss_data.indirections_len)) {
+        error_report("virtio-net: saved image has invalid RSS "
+                     "indirections_len: %u",
+                     n->rss_data.indirections_len);
+        return -EINVAL;
+    }
+
     return 0;
 }
 
-- 
2.43.0


