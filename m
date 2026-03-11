Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAC2FD88DF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09kb-0000Rg-IA; Tue, 10 Mar 2026 22:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kY-0000R1-UG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:42 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kX-00063p-F0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773197801; x=1804733801;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mSJwk8OL8GT7Kwlz7h7yRvXBaRvRP8lpklTQLrCYMRk=;
 b=PppFxtVgyPiNtRKn9KACANBu+XsnGxjyE+/BYyf1CDQ4TE+ZJrBAbFIj
 en2BacvWDHf2kh/B9WzNlW+y54/DMMgfcjRo+5EGxiUfDUB0f0zCilUUs
 PY/GCkoIwgkDKfQh6tj+SjtV79nJZQ9uHM0E+CxUqdTbQRan6RHrzAvyU
 3Bld1f8s33n9Dard5pQf5/JTTDEctW/BR0US1TiuKzObEf0tcUCYjxPbx
 bMYDXUY022ADFC3ZnpVvulUtAv7vMjSj0xi9/WXcqAdiCs7bixCqzkqhe
 8FtoWVYTdNjZQZXL20o0Ybu6pGjLS9EIa5sYzs/HACEndVKRMrPOZvwI2 g==;
X-CSE-ConnectionGUID: JtilJA2LThmTwTwkIS63Dw==
X-CSE-MsgGUID: 3YZFQ850RpyGx2J+Oc7PEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="76867887"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="76867887"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 19:56:29 -0700
X-CSE-ConnectionGUID: lzIuSis2TJ+54P99TFWxRg==
X-CSE-MsgGUID: iK0dK+yPT7W8kJqfjUuBQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="215611433"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 19:56:29 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v11 01/10] virtio-gpu: Recreate the resource's dmabuf if new
 backing is attached
Date: Tue, 10 Mar 2026 19:50:43 -0700
Message-ID: <20260311025340.1335673-2-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
References: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

There are cases when a blob resource's backing might get detached
and re-attached again such as when the underlying object is getting
migrated in the Guest. In these situations, we need to obtain a new
dmabuf fd, which can be done by calling virtio_gpu_init_udmabuf().

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 643e91ca2a..f20111fa57 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -937,6 +937,10 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
+
+    if (res->blob_size) {
+        virtio_gpu_init_udmabuf(res);
+    }
 }
 
 static void
-- 
2.53.0


