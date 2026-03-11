Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15CFFD88E3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09kd-0000TS-MF; Tue, 10 Mar 2026 22:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kb-0000S6-Pm
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:45 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kZ-000648-Bh
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773197803; x=1804733803;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8DjDopZg0XVik4k1ICxjRmt2mb1IxbLdY763BFKsh0Y=;
 b=D+pSZ3VW2SuBu7eaZm+cVuYhBps0LWj4UTbf/EQtHbQUkJHGXwMc5yeQ
 1KwaEjYDvQUqveoZ4OqKuImG9uJsyC3KsKv1WTRHfVSZtnRZE6I4vhMJ+
 bzbPo5Jq5Ni6BhuDenHHFBdMyLoaRg8g0hRrCCXr7fuXKn22+OrSe2kCu
 zF0zb5E9wgRkeDf4zTkkyJqMQNGOww00oj9y1H77Jt8FZoo9S9m/ZIyGu
 Po2P9YBbPia+yRLTBjRYuNZAQGTsBh0WNoAAPyZGqo40bLlUIu146SUg2
 cOZXBhDnEK2GUBce9HcIgebCf1vqavEIzHdMATVp42WBLNYk0G75oWFkP A==;
X-CSE-ConnectionGUID: vYFyM+xlRM28nvLhlECXSQ==
X-CSE-MsgGUID: KvBd13DJQQylbKcauPjp/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="76867904"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="76867904"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 19:56:29 -0700
X-CSE-ConnectionGUID: qEAhxsBsS+6scMEUggt5/w==
X-CSE-MsgGUID: goaiGQl4RKqtFPSb8iBh+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="215611441"
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
Subject: [PATCH v11 04/10] virtio-gpu-dmabuf: Remove rcu_read_lock/unlock from
 virtio_gpu_create_udmabuf()
Date: Tue, 10 Mar 2026 19:50:46 -0700
Message-ID: <20260311025340.1335673-5-vivek.kasireddy@intel.com>
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

There is no need to wrap the call to qemu_ram_block_from_host() with
rcu_read_lock/unlock as we already hold a reference to the memory
region that owns the ram block. Note that, the reference was obtained
via dma_memory_map() while creating the mapping.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index c34d4c85bc..0782bcf3a1 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -43,10 +43,7 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
                      sizeof(struct udmabuf_create_item) * res->iov_cnt);
 
     for (i = 0; i < res->iov_cnt; i++) {
-        rcu_read_lock();
         rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
-        rcu_read_unlock();
-
         if (!rb || rb->fd < 0) {
             g_free(list);
             return;
-- 
2.53.0


