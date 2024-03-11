Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C22C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 03:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjWI6-0005n6-7V; Sun, 10 Mar 2024 23:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWI2-0005h5-Mi; Sun, 10 Mar 2024 23:25:27 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjWI0-00084P-Om; Sun, 10 Mar 2024 23:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710127524; x=1741663524;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EXIEbq8RUu3AQ/jzQwBooQoTcHTssVhpacUjMNBJKSg=;
 b=nyYj3iRt1J6g9yP9JZ8NhMo4kvZmsH/WfgSw4q6G8YFPps2LD7vZuAr9
 B+OeDPAubXlLvFMXxW+eHuzDfUbMgW4rWWElom0xEw/e0nJSDY1yeNk0w
 LFN1kNvmLftxgzWXOJ21+KIr+wHpEmqXjongJabzsbSMizCPMVgUSsAGY
 sDkwcMot70K+DROkND1IZvrcnQSU/1SspsTwQ5S69/PKdhuhtQVHk1/DB
 6ro+3c5wjQjlDhxcjHar7ATc9ZogiwKNLCvFTsPOrF3+ARd4m+EfYwrXS
 3ZAXKjR54WTZmueA2oNLTBcu0/eLJuBWC6RsD4DSBqdqKbwENththeJEP g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22229686"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="22229686"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 20:25:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="15593863"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 10 Mar 2024 20:25:20 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 13/29] block/virtio-blk: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Mon, 11 Mar 2024 11:38:06 +0800
Message-Id: <20240311033822.3142585-14-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
can't see this additional information, because exit() happens in
error_setg earlier than information is added [1].

The virtio_blk_vq_aio_context_init() passes @errp to error_prepend().

Though its @errp points its caller's local @err variable, to follow the
requirement of @errp, add missing ERRP_GUARD() at the beginning of
virtio_blk_vq_aio_context_init().

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/virtio-blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 738cb2ac367d..92de315f17f7 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1682,6 +1682,7 @@ static bool apply_iothread_vq_mapping(
 /* Context: BQL held */
 static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
 {
+    ERRP_GUARD();
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     VirtIOBlkConf *conf = &s->conf;
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-- 
2.34.1


