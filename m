Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D7EC5321D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 18:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shCx8-000349-MD; Thu, 22 Aug 2024 14:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCx5-0002ns-AX
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:54:32 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCx3-0004BW-ON
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:54:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1724352854; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=I9AYmkQ6bYsTNXVU/M1etx312oB9VVpcpAlsD0oogjavoGbNRMlNXYCRonM2SVnAzYhzFIjwlE36a8FvRcofi4oSJ32wMSvZZ2xjqibhp0AhwswNtLmgrIF8XwOKAnPCrZTTCUvJu1+FetdTtnfjr8RadqUKGlnteY+VuXW1MFc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1724352854;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Qxv7cBLFiGVQiYZk4TakL4gSjINIf8MrbTBP22rjK6M=; 
 b=FsLg1egKsvltHPCyMkkkNoIK3uuzDenOQV/aJxJR3noI+TYfJ9Lm6Dt8Yix7p2vZTJHNhApepFRhUec6/dLNiazSP2CVRMhyFCMxERD3IlbcqEGemozZE6QhwhL0GTsyQFBS76wVvySk7/VhAElivjMbDwvfGqk8CvNo+mK1gUg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724352854; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Qxv7cBLFiGVQiYZk4TakL4gSjINIf8MrbTBP22rjK6M=;
 b=fxnWc2LTJ9hqMvrzg6E9/lbkobD3KQwnB4p1uOoZ/bN1Wv5X3E0asqDXVT6MGccw
 VKhF6/GMffiDctkZDxthWdrNSj55BirtlAyF6o2GLsZaNonpZoglSamYJK4Z47QXJUc
 xoLZ1QueAkoSJItJaD+QeubZg1AwSVcPoU/NsuT8=
Received: by mx.zohomail.com with SMTPS id 1724352852656351.31490724847504;
 Thu, 22 Aug 2024 11:54:12 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
Subject: [PATCH v17 10/13] virtio-gpu: Support suspension of commands
 processing
Date: Thu, 22 Aug 2024 21:51:06 +0300
Message-ID: <20240822185110.1757429-11-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822185110.1757429-1-dmitry.osipenko@collabora.com>
References: <20240822185110.1757429-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Check whether command processing has been finished; otherwise, stop
processing commands and retry the command again next time. This allows
us to support asynchronous execution of non-fenced commands needed for
unmapping host blobs safely.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/trace-events | 1 +
 hw/display/virtio-gpu.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/hw/display/trace-events b/hw/display/trace-events
index e212710284ae..d26d663f9638 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -55,6 +55,7 @@ virtio_gpu_fence_ctrl(uint64_t fence, uint32_t type) "fence 0x%" PRIx64 ", type
 virtio_gpu_fence_resp(uint64_t fence) "fence 0x%" PRIx64
 virtio_gpu_inc_inflight_fences(uint32_t inflight) "in-flight+ %u"
 virtio_gpu_dec_inflight_fences(uint32_t inflight) "in-flight- %u"
+virtio_gpu_cmd_suspended(uint32_t cmd) "cmd 0x%x"
 
 # qxl.c
 disable qxl_io_write_vga(int qid, const char *mode, uint32_t addr, uint32_t val) "%d %s addr=%u val=%u"
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 24608338d7ea..5015f17f9242 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1053,6 +1053,12 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
         /* process command */
         vgc->process_cmd(g, cmd);
 
+        /* command suspended */
+        if (!cmd->finished && !(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)) {
+            trace_virtio_gpu_cmd_suspended(cmd->cmd_hdr.type);
+            break;
+        }
+
         QTAILQ_REMOVE(&g->cmdq, cmd, next);
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
             g->stats.requests++;
-- 
2.45.2


