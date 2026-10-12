Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB29CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 23:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPaZ-0003Jj-G6; Mon, 12 Oct 2026 19:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetan.singh.foss@gmail.com>)
 id 1xGPaX-0003JC-6A
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:37:49 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetan.singh.foss@gmail.com>)
 id 1xGPaV-0003lw-Is
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:37:48 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cc1c9879395so700317a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 16:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791848266; x=1792453066; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ExAvaGATDi0IBoh6G0O8yYnelKRVZXGI7Vry/l2zxrg=;
 b=ULHbEed4Xr+SNTxltxCwjis15e4xtEj6FSo5L9EkOLeS3aQRo9u0EOqx3b3LkJvBsI
 ylfX/6PPS+VSP4ktq8TVBhBAenTZYP1jFVZ/2XuZZLMSRG9kqr3qzSduqZ7SejDWGZyE
 uSnzbD6Y55oS1bqsLaHrjsqI7m0/z8JS/KozRa3uRQEKzMWLEonw2eQo7nG+nJi8mfm+
 RG9cBYxb9X9BQts3ZVMw7b20JwJabMdQ1s1h63xRvA1zfh33WmETbDVfr/lMDyUm0Mx5
 Y4PmkH+eWhB/mHugTp36YMCq2/ODE5fkYdBiPNiMODDXu72qBsKkqArkzCeaH3ruLkRT
 GFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791848266; x=1792453066;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ExAvaGATDi0IBoh6G0O8yYnelKRVZXGI7Vry/l2zxrg=;
 b=P4wf3NoNQ6nMSe4fP4ofkv9Mxo6QlXvEYcJTz4JOpbamV/p7TBjUeTDXCuYx7np8k8
 5g8hllIijDZUNIJwzvKo4HSSiJ9lecesgOyE4xzf1ea5wHf1OJ6Qr7zn0IlaQjEb9E+i
 zcIiJ3tF8jqRc/xAdMWn4zcBZtXIn7h/vOkET/c77zTrUeW6MxrR+hVUYJgD1wI9xg45
 C7Pb9am9ONpyD74KY4/yk2XgKsDSQyquPfuO932Vtr7qrommVHNkbC1WEncb18doXP5E
 gGgE0gJjb3iIH2gruFYjF9pzka0EQshXk2wah+rw6L3oeKrIuyBNcExpgc7PHq8QgQbP
 +vmw==
X-Gm-Message-State: AFq9FYL96cDc/KRgMo26xy+pjqizto8keccPl1XjOnIh1o0vWUCm5VbZ
 /FWoFxn/O+Uzqj/GHCOWzjjRrBjN6UfM4+4Xj8hBO8P86cWNRDjvhzs/+RUMeAAw
X-Gm-Gg: AYBFou1z0e1G2BXoQFOJHqS1zzJwDdRO/Q+AiRxcXIL7SlW0Qzqy/6gutYQ2T1ERCYo
 SRKDjIMIqPn7yl38NvVDSGyoFN9o/uqsMEle4oVZsjOPXjIBKewY1wcfvz45rLgKTV7+xHBj2gY
 Q47bzMBd8v5Fg90Xq6pWyaZlVPsru9Aj446W9L60c08kF6MvbIbb5XLxIyVe9VfjJJoEUPXmUJu
 nKdHpnvLZj1L3E+zzlW0bayjzdTErovCATD3uCoABi27uV/0RaPqB7izb/PxMvJBFcDDNwdChxN
 nmft0wxvcGzWkwKTcAo5zD8/2bKP1WkdJSWQdbfeQEtJh2YnlO0WsmbFJ3jyGNxoq0XwvOqf6is
 lGEsqDwaWujMgk6BtNq/rT/YFjV/ZVdm3koENHdJ6Gm97nuqpCLXFfyIWXCl5CLYPP0YZY4fpr/
 2C1tTQi7RTmaz1dstLoXeI3XRI9ONAzqofNsH/ZQLvDgplYeXA6jJ7Gs7ZLxGGhFS6dYAl0pmZa
 SrrpngED8I15bWXK98vA8sLHu6/aZHUCGVEKXOdtIgzbGpQHU1Tz904OwyGXJR+f4eDU3BJ5TjR
X-Received: by 2002:a17:90b:1d49:b0:3a8:5d57:a5eb with SMTP id
 98e67ed59e1d1-3ab3ab5a60dmr7231097a91.15.1791848265749; 
 Mon, 12 Oct 2026 16:37:45 -0700 (PDT)
Received: from Skynet.localdomain ([2a00:79e1:2e00:ea01:6aa4:3285:e76a:44d2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371e2833sm19206944a91.17.2026.10.12.16.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 16:37:45 -0700 (PDT)
From: Gurchetan Singh <gurchetan.singh.foss@gmail.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 Gurchetan Singh <gurchetan.singh.foss@gmail.com>
Subject: [PATCH] virtio-gpu-rutabaga: make sure ctx_ids match
Date: Mon, 12 Oct 2026 16:37:42 -0700
Message-ID: <20261012233742.6389-1-gurchetan.singh.foss@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=gurchetan.singh.foss@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The ctx_ids need to match as well as the ring ids for
proper signaling.

v2: add r-b tags

Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Signed-off-by: Gurchetan Singh <gurchetan.singh.foss@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 3aafa4dc66..edf7b62703 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -902,7 +902,8 @@ virtio_gpu_rutabaga_aio_cb(void *opaque)
         }
 
         if (signaled_ctx_specific &&
-           (cmd->cmd_hdr.ring_idx != fence_data.ring_idx)) {
+           ((cmd->cmd_hdr.ctx_id != fence_data.ctx_id) ||
+           (cmd->cmd_hdr.ring_idx != fence_data.ring_idx))) {
             continue;
         }
 
-- 
2.55.0


