Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A143BEF9008
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpX5-00074j-Jm; Wed, 04 Mar 2026 11:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpX4-000737-EM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:57:10 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpX1-0003xn-8N
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:57:10 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-65f980cea07so10544936a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643422; x=1773248222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZE+DbnvVFmXd+2ruIxq3RTojaKZzSNmRAGkBSCjGF0=;
 b=aUa524PBYhCMQ1J9QDFCf2JMklSgmUr9dsnxXRboGwTSIejjtyT0iSqwuHAYDbTVeu
 nF+J98zRxZhYKDHCytJgTxdorJ4d4Ee42jPwAkAdmEWtBkKtY1NQauuKc3rjefkdsHIO
 wYPquJuI5bGoNzXaeMk75Ne/bl6jjIqM5G/NzjGDyvV80bGgh1tc274QSrIyEfvN8nVO
 d+UUVU8mgDNMoy8oKEywdEeGjmWNBhsMfDEkQb13EOWSPwsRHvKDxF/3pJwzZfi/pPN1
 dt1iKlcTeABgh+6vZN0QFHhtbwOIKPTMEVFCdymxXwzniHmMs498wqlcGLexY+QUmXtw
 hSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643422; x=1773248222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dZE+DbnvVFmXd+2ruIxq3RTojaKZzSNmRAGkBSCjGF0=;
 b=Jia5bLsrDEpQqfNZvU2gD3sZs/JZFMNbQmG8fKGUg6okfYCQC/oBtEF/WVlu8jrbFa
 JI89hjL+hwl7afLD1q8nyampTRf8wL4/bOrfjpIhkzc6bvlNZR1HY2ehTlBu497BIrIE
 xEzp7rfkEkd01shkHzBZO+O+Ggv7Agl4UmJMsdoVkv3eZ+Ia2ZrThUoOWvhzNOW9IdPx
 UhO/m4falzBLomba8j7Xnrc49xvhuBl7PnSKcSWXDKT0ZNt+AmAKwThHBfXx3UtwY1qs
 8QLjVDdTIiwLq20vR0W5rOEQcs1kaa9DqeBn/RXVieJ4px7mov4S5Yt9d/fN7wdME6cy
 eALg==
X-Gm-Message-State: AOJu0YxKA66OscSRw7sXnAiWfHXxyeNuvBehNPPVE9r3Q3KJja5MOehG
 vZGP1MQD6jCLTUxJVhqynH6Oujk8nsclMwYY/sFyE8eWBiBABIosocAw7CoKTUHF26E=
X-Gm-Gg: ATEYQzxSqApEHVUZhxkiD2o17m7s11/f9W3MGmbaA+7GadgPoCkfHQNwQDr6/hpB+Oh
 ljJ7p1wDxS2F8cwc5PwRGzc0B/xB9zQQglIRWPCTlWudT/3Nxf5VRuuU5P/TlK37pPWUyyJVCFE
 HIu2X6QNtfvXq9yehjMP3M/l3B7SsxK/2ziLxboX5yXbQyC62wRCbkx8FnCETWCPAzN/a1xhhOb
 v5BxxVgXTF4s12wPFbkKy18nQ+Q9jBMTHTkAgIwKM0A6QNrxTNJhMEAGecRoBB9lXnyyK5WGDgU
 VuWwX5zYBmBCHfSdxhcL3gvU3/Iuy95ZZLJN2M5tdhwLwzB+0ZWE7N4Gir7uIYAEAQ/mxGMkAU+
 onQOfeIsxXyF+qphaUOZMEvgMaGdUfPvx3QRkiVTu5LAgiNsx6zOE0KL2U6nAydMz72GGrsZ6Ey
 jHDrqaFB40NmjPbWaZMfAyNiA1tbkiC+uemQ==
X-Received: by 2002:a05:6402:440b:b0:658:b87a:6eba with SMTP id
 4fb4d7f45d1cf-660f00d29bemr1530969a12.16.1772643422461; 
 Wed, 04 Mar 2026 08:57:02 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-660ce1727d2sm1469813a12.27.2026.03.04.08.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:57:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 41A815F832;
 Wed, 04 Mar 2026 16:50:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 17/20] virtio-gpu: Validate hostmem mapping offset
Date: Wed,  4 Mar 2026 16:50:39 +0000
Message-ID: <20260304165043.1437519-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Check hostmem mapping boundaries originated from guest.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-16-dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index abf7c176a65..f4d1113827e 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -791,6 +791,7 @@ static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
     struct virtio_gpu_resource_map_blob mblob;
     struct virtio_gpu_virgl_resource *res;
     struct virtio_gpu_resp_map_info resp;
+    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
     int ret;
 
     VIRTIO_GPU_FILL_CMD(mblob);
@@ -804,6 +805,15 @@ static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
         return;
     }
 
+    if (mblob.offset + res->base.blob_size > b->conf.hostmem ||
+        mblob.offset + res->base.blob_size < mblob.offset) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: failed to map virgl resource: invalid offset\n",
+                      __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
     ret = virtio_gpu_virgl_map_resource_blob(g, res, mblob.offset);
     if (ret) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
-- 
2.47.3


