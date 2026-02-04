Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C609DEA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniC2-0003jO-3h; Wed, 04 Feb 2026 14:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniB6-0002xO-0U
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniB4-0008BC-FO
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aMlqbmSKooP03sc2CostLcGLDMkW4cYnire/pDDEN4k=;
 b=Cy9WruY1y7K0WTJNo3hjZvLKpVgEjF4GxR6JllK1ytkylzU+bfPXEw+Ey29xYQ7T7uXFYI
 ZU2MW0e1Nzn1l32626nJvqotXLNog+HMC+iiztGffqK6G7Wlklv47Qn+ZoXBWjrP2s+pfe
 Tj+UTqkCujQtvn3ilAOkydLOCJ6v/Wc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-7ayJdR8fPDS9HAl1poTmXw-1; Wed, 04 Feb 2026 14:04:36 -0500
X-MC-Unique: 7ayJdR8fPDS9HAl1poTmXw-1
X-Mimecast-MFC-AGG-ID: 7ayJdR8fPDS9HAl1poTmXw_1770231870
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-483129eb5ccso1267515e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231870; x=1770836670; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aMlqbmSKooP03sc2CostLcGLDMkW4cYnire/pDDEN4k=;
 b=iqO4VUXZPcSPVxSRgtiwJ+5n7rr2S6DtXLsRILQtMK6vyG+XCRJtxztiK+sM0TRKRi
 Wr0X/XLi+SExsAK255DX1R4sJFv0x4duEMKkZ7WsdoV/ip3fQjc3XkfC2coSWOAtdzbG
 in32Xs0Oqd0VRVonv0Dr/I8zP4Jb6voYIOkrkHPNEUOE0cPPP97TG8y6RGD+AY0/MG0b
 VVdLFMIAdw8VpFQ1q9KJfo7oKMX/wpMijxvjAeP/WtXH2qQzpM5qA2zlO2NbnZoUebx1
 EPt0QKVsIblA4woWqY/9F87r22TMUUF86aZccj3ypBu2tNMPMEHZ6IvgTCHDOdvnGqkO
 Zohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231870; x=1770836670;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aMlqbmSKooP03sc2CostLcGLDMkW4cYnire/pDDEN4k=;
 b=nTogCuIEECoBcheWHgROhUHDomkertHdFC3PQXh1r0t1nAfC4wakepdvEiuKnviPzk
 3P5AlEJOQPiyTERCB8l8/H3tfvmiy/mVCuhmBh7mO1qUWuAe6qCJQTkakw0BEuN/fbZF
 GBnmuOZRgCX1+jmgfnpd6hPG1W8245O/6wR2Wku9G148xa0Q/QA8PhG9or4rlY7Egdhm
 fJNc3rN/i3zdQ04Zv7IUAizJMxfYJjybx079jbu3qNLQuRbIoPNFdvWXeRfiRl6y8pA7
 Ay7MCzFUQIWfUJWM6yxsk6C5GN4ilzKXuTh0E+waNHhshElsG6Evp52CYBMFchXMIG14
 6w6g==
X-Gm-Message-State: AOJu0YxqwXKzpkH4HKE70h6MEuhBPAxQqiVmq+1YWCubcHXt67+4HZhj
 fb/YHWsHS6co12nFvUC8IjU8WtSVcyQOKhXBbCkexZCj2dqX+0cxSWuT+19lmEORv2iZf42UIfo
 zttpdTCTYpKaLCUnV1b7vykczRtf6jcSKWsBnAzsKBReETR0SVvF7A20pTanH9/RHZzD6ChfzKX
 SBB05Lqkq6rZ2hieYRCw63gNf+xWG7NkPRCA==
X-Gm-Gg: AZuq6aJUKe99XYALUcHS97tfUT9ViYQS0akudGaCDylxf27Dh2iYdAv0iR7JDTo81C1
 aIKXc972NHWF7WUZ/j1S40OyRgF1mdgbaAghO9qBnpcLoRQ7Tc48M1zZ/IGViJZyb3qZ2xVkz/C
 FZScv0X+BaqgFHXiZZZiMGR/9zJZ8Q2LGe3lmrBZqOV3jI19d/Oq1gIKmJN+vt+RdW6DU+A7Bfz
 pkG0lMAHZ/uFGAqQn2E6o9Z/idoXhi0HyWsIDZYoVjOn2D4FtEldxBVnzGnoOpX+IJMu5JWrGuf
 k2tXDmzv8qCdf03cHUNs0+6I/+CF3qh9Qiup5Dr2+xw39zSSNfVrR7iVZ6LYD8zZciIn0l4jKAL
 DOLtNIxLIH7zKI4KEB4/UwJLNlhk03RpUvg==
X-Received: by 2002:a05:600c:190a:b0:480:4a90:1b06 with SMTP id
 5b1f17b1804b1-4830e9b7a3cmr51073185e9.34.1770231870026; 
 Wed, 04 Feb 2026 11:04:30 -0800 (PST)
X-Received: by 2002:a05:600c:190a:b0:480:4a90:1b06 with SMTP id
 5b1f17b1804b1-4830e9b7a3cmr51072675e9.34.1770231869491; 
 Wed, 04 Feb 2026 11:04:29 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830ec4a76esm43230005e9.1.2026.02.04.11.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:29 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Honglei Huang <honghuan@amd.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 43/51] virtio-gpu: fix error handling in
 virgl_cmd_resource_create_blob
Message-ID: <3aa1e2730e60a54e497a13f6af98bee3390a1074.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Honglei Huang <honghuan@amd.com>

Fix inverted error check in virgl_cmd_resource_create_blob() that causes
the function to return error when virtio_gpu_create_mapping_iov() succeeds.

virtio_gpu_create_mapping_iov() returns 0 on success and negative values
on error. The check 'if (!ret)' incorrectly treats success (ret=0) as an
error condition, causing the function to fail when it should succeed.

Change the condition to 'if (ret != 0)' to properly detect errors.

Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
Signed-off-by: Honglei Huang <honghuan@amd.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260113015203.3643608-2-honghuan@amd.com>
---
 hw/display/virtio-gpu-virgl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 6a83fb63c8..741728cabb 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -705,7 +705,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
         ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
                                             cmd, &res->base.addrs,
                                             &res->base.iov, &res->base.iov_cnt);
-        if (!ret) {
+        if (ret != 0) {
             cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
             return;
         }
-- 
MST


