Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1FDCCA476
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 23:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4pRS-0005BA-8v; Fri, 03 Oct 2025 19:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v4pRM-0005AT-2s
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 19:43:56 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v4pRI-0001RK-1g
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 19:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759535032; x=1791071032;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GFQktaHaeMNxr4Gzk8EWLUyy62UH9jwbsez8oBwHtkY=;
 b=lYBEcmrpTJ1CHdypRVnu0Z5MRzKDY9TzSOFPeqQAa4yNm0YNj6nSZUaq
 543vCmAXRwTMp4BZHUcbXLGwZGk+CvAVd1P1k3ReMreEYNONCY4nrAal7
 SaC0efgq+WNtAgFlre19rquLQi38r6wZo8nw24UOXznBYLIhuvp/iTULS
 S8BiNvw+Bdt4CEpwnSmCMbyfUn7gXDLDQMN74CT8yK5OpOFVsl/im5hyk
 TBPcctENJzRitYBQcVzKpCAe+cJBu1AxRA3drYr+5O7dWQ3j3p/2ni+SS
 yswscZWIqfIcvWL2IVyfCk9gcYAZfvKyEXIOQRbq35Bb2U+1/RSiuyFiF w==;
X-CSE-ConnectionGUID: EmRL5n5+TTG7eomig4wTqA==
X-CSE-MsgGUID: D8inTk9cRgWJaBVDCKVsow==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="61705029"
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; d="scan'208";a="61705029"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 16:43:38 -0700
X-CSE-ConnectionGUID: SzukUfDhTneV39LdeoOMhg==
X-CSE-MsgGUID: 1fDUYTw6R7eHG35EtjDwAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; d="scan'208";a="179428143"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 16:43:38 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v1 1/7] virtio-gpu: Recreate the resource's dmabuf if new
 backing is attached
Date: Fri,  3 Oct 2025 16:35:54 -0700
Message-ID: <20251003234138.85820-2-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003234138.85820-1-vivek.kasireddy@intel.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There are cases when a blob resource's backing might get detached
and re-attached again such as when the underlying object is getting
migrated in the Guest. In these situations, we need to obtain a new
dmabuf fd, which can be done by calling virtio_gpu_init_udmabuf().

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index de35902213..70e8757128 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -937,6 +937,10 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
+
+    if (res->blob_size && res->dmabuf_fd < 0) {
+        virtio_gpu_init_udmabuf(res);
+    }
 }
 
 static void
-- 
2.50.1


