Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838ADD10380
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t450q-0001oW-R9; Thu, 24 Oct 2024 17:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t450p-0001iP-87
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:04:55 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t450n-0002FY-FZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:04:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1729803878; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Lsj1xYlDhYQGgGtopDdx0n6zEHoP3pkgdLI1/44cMuMcuYDqXegmmx1iQ1XcOt61QcH5IpSSlPJ5/QmIyo9bJdtMu+wRzxYFvdx8YR28hNxnbqJrcNsoO8oUPfnh3A6o5ve8T/t3d6BAJeixqq0emd8x3WUGyaRtJZpx8tyQ/1M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729803878;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=B9dqE2Q92PHmyRQiWBnegvxqPsQF0auCPja8E9GgfVw=; 
 b=GlShYe/uC90e9PX3D5VniqXp1xMw2PFAn3IfT0Vaam4dehAorpk2AjQ6MVu7K71d2WZwvYD1gDzrKbN2hH3HewgXps/f8rfmMVTKrAAWHzMfW2ZUvB9Jb7EnTO59OngHZm2+ay9auBzSVdfkLoyGyC1H4D6NO9LFAz/VPlvL4I4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729803878; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=B9dqE2Q92PHmyRQiWBnegvxqPsQF0auCPja8E9GgfVw=;
 b=BYqHIGEqti2tn2NNSIaYVGra5tq4nojGwOFUD8LZGEk9RTzFE2kBOb1DwtvfkxSS
 AlYzu6NFnAsLHRML05dSZP1hRd3xdjc552zwo5jmcQUv8iuqD4msQLBwsYgbOuy4LhW
 DrCBPSleQD93Lh53khYRr/BFrPIUHxA8YQS9KIM0=
Received: by mx.zohomail.com with SMTPS id 1729803876230592.7220546956228;
 Thu, 24 Oct 2024 14:04:36 -0700 (PDT)
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
Subject: [PATCH v18 10/13] virtio-gpu: Support suspension of commands
 processing
Date: Fri, 25 Oct 2024 00:03:08 +0300
Message-ID: <20241024210311.118220-11-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024210311.118220-1-dmitry.osipenko@collabora.com>
References: <20241024210311.118220-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 3d9679c1ef98..180d882f0a49 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1034,6 +1034,12 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
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
2.47.0


