Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78FED2AB2F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5l3l-0004dy-8M; Tue, 29 Oct 2024 08:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3a-0004bN-6n
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3Y-0007TL-Go
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4314c452180so43846415e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730203839; x=1730808639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAiNUZHWMY8UPn2mHH/EVqrwGLL5X/il2luCyizrIjs=;
 b=FK6JgtKQsYObCyuXCrI080FboH2GbVw/cI6lr8P+SaJdB8kJNs/iBbOuPd2ZCgiYEP
 E0IWFfJTbnsQdvuqyvQN54ztitsNk7svIpwYcFa6muaRrZo+oUdaq1t+8GhPGhnP0onv
 4lmSFCedeweDAvKdCHgDpcyegwCglKwfZoI25rcfunqIXaC8kF/kg82dkuWomimtiFBH
 J9YQjcZkCqlgzdyQYSJe1V4gph7L2Wmg6JM/fxgz+/HoN0DxNjtMMEpshZ18GbwNvVI2
 LMeS6v/JGr0A/j+5dh6sQLW7hH8vHEciGQKVruc/70rBMwkyyoxYo23HvCtWiPzv3bdU
 88zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730203839; x=1730808639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAiNUZHWMY8UPn2mHH/EVqrwGLL5X/il2luCyizrIjs=;
 b=OFY0ph0Sj7q2HHyhlNc+fGPfqLPZEdQCDoeTpMoGnywAzA1qbU7bKJXXF1zkh5Bs67
 swxsDC8/IzK/PArO6NhogLROAQrYrYaMjj+gVH7ja9XYru8X//Luj++fbk+RYHaENPjH
 yoX/DM6dnX+MPyPNOEyzXbKysQDLikmA4pw3FkDPdZ+QgwIaF2KqwtlB1+Iq2wxDwNHj
 /kptpgPKcMtd29aBq8pViGqrHxZx0ZQClSBkqPXZnXDZdNTVB7N1voOnV+bYmHFyL3tt
 BiBleMdpyYPTrPKNo/P37rCeQL66a60VNWffmcF65C4n0DFQDIJdaO5+VuQF8I+rGzu/
 h76g==
X-Gm-Message-State: AOJu0YzrgwK+aCjkiZ379UruQTO0GC3dgvG3JlH08ODSOGtqdazJgIte
 bEtGAlcwZ+QyYPAaoZe4EbN/a22//uINb3Hi5SCwvNe+ePbT21Pn/D5Bvtl0uIo=
X-Google-Smtp-Source: AGHT+IF7BCWI/k6P5D2Ck0Xl7Krdiq5Z9IKVhqN3OLmyEIxGf3bQW6MEnpfkFa/42Psmp6+3qqDeqw==
X-Received: by 2002:adf:fc83:0:b0:374:adf1:9232 with SMTP id
 ffacd0b85a97d-3817d636aecmr1454300f8f.19.1730203838951; 
 Tue, 29 Oct 2024 05:10:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b3bde6sm12349602f8f.40.2024.10.29.05.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:10:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6B09C5FB4D;
 Tue, 29 Oct 2024 12:10:31 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 10/13] virtio-gpu: Support suspension of commands processing
Date: Tue, 29 Oct 2024 12:10:27 +0000
Message-Id: <20241029121030.4007014-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029121030.4007014-1-alex.bennee@linaro.org>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Check whether command processing has been finished; otherwise, stop
processing commands and retry the command again next time. This allows
us to support asynchronous execution of non-fenced commands needed for
unmapping host blobs safely.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20241024210311.118220-11-dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 3d9679c1ef..180d882f0a 100644
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
diff --git a/hw/display/trace-events b/hw/display/trace-events
index e212710284..d26d663f96 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -55,6 +55,7 @@ virtio_gpu_fence_ctrl(uint64_t fence, uint32_t type) "fence 0x%" PRIx64 ", type
 virtio_gpu_fence_resp(uint64_t fence) "fence 0x%" PRIx64
 virtio_gpu_inc_inflight_fences(uint32_t inflight) "in-flight+ %u"
 virtio_gpu_dec_inflight_fences(uint32_t inflight) "in-flight- %u"
+virtio_gpu_cmd_suspended(uint32_t cmd) "cmd 0x%x"
 
 # qxl.c
 disable qxl_io_write_vga(int qid, const char *mode, uint32_t addr, uint32_t val) "%d %s addr=%u val=%u"
-- 
2.39.5


