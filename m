Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4718FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wTw-00089y-Dw; Sat, 04 Oct 2025 03:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTu-0007wY-AM
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTo-00054x-4E
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so27187355e9.0
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562094; x=1760166894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WjAA0ZKsV0HNMZTuWF67HYAQCn7TgUHr1+L7jgzp7NQ=;
 b=UHVNoYtKT6Uv5Ym/9sfj8Ac3BeBIYz1kIdfBcutLVXUXXPbStCQNU2HCXiGUXeHGdW
 Xk70a6Ut2s2fCq2nDRi475w2WHCfFXDLmL623wSGjr/iHGP9RW9JYBtrH9bR41h1RIKV
 J0Ks/ayKZjLWuyl4Es8Fh5XFDQPa2Tt0RSUd9ICgWer84He5fPygsylgTNPNE1E6t5m0
 5FkqVzwk7i8pl0APcDtZpWhi5U9GJQkzBoay3bzMdl8n/ypfDzyxYQDIEi6VocWbwrsK
 gTFZ52n427ouspZrI7EDt+wbS6CEivT6A1ypkcMBRJjQIMxGCn4R1tqScx5FqtXPtneN
 qnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562094; x=1760166894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WjAA0ZKsV0HNMZTuWF67HYAQCn7TgUHr1+L7jgzp7NQ=;
 b=AlIUIETJkb/+RbsV/x7SW6yLlPVWF1nSs7mr57NkXTjib2joiomeetmmfkffWtUOPV
 dZJWEs9sOGtk+4YBVADKrRJgtH1W+C4H5B9fX8Rq2G2J5vp9r+9gd56hdOyrXD/IxMIT
 tkBRiuhB+pVS00wrxs63+ARtBjXvWq2pHTaxzLxLIP2DMRmfQPlYT0y6Pei2QrmI3zr1
 yHaZEEVweX5dGKJC1VakbHs7u/mQmjRfyTVP+24SKCgtmTp8q/puoyMyuWQZl1vZpJKh
 PVzEPQvgt12MSVzL+roK81gDMXCe4hvw9o2B8n40AndVY/yE9CdilQeATr1eXg8g+0+A
 Bw6Q==
X-Gm-Message-State: AOJu0YxA0YQOvdFqmCd5FJo1mhTFAGYqAw8voM0w+I7DkbgX40FVSS/U
 a6Mv1gAXsSjiK83eqgRKVm+zwr4dUPHYjTWz4jVNUtRbykis/nAl/tBzGJjVRxr/pkxiyyl+hy0
 /B2kD/cdYTw==
X-Gm-Gg: ASbGncsH8qApkSrN06EmmZ0gFHVA+c3A28Hz+aC0FE16UEOv5HQzGFDm2zEpaMOYaeh
 V62a6rKXjFOdAgieCaAVnmMCtkMVy61TWEu47BVzcIpsfh1YmVXJK4liC9yO/N0IPgIcNq1xzQo
 dBvc3EpVm4Yx+WH7iu2+ODEcZPBQQY5wwT1ScwpTsvp++eg0mJgL32Frue0ezxTzhZpykjsz+9d
 +a+pr4XHYd8cySWhvFvPB3W/cholHBuhBx3cKQsqBmw5Koo+RlnMa9ZWPsKPMctN5H4ddvN+UwJ
 nUGqGqb8hNaOQkTGcvgasF6lelLRE0s3U7FX4Ctm/GMqOcz4xvFSaorCvMD94H2rGhnnW/HmHWH
 Rh5keoZdPbqdW/Iwzqs6q7NOYHHhQOl5Dc2JCu48/mXMFoSQwwQjcDfEAcHlCIAlfzusdj/J40h
 AgsxNtzLZcrQFxISJ76Lq6/wfJ
X-Google-Smtp-Source: AGHT+IHHMX7AZ4u+BjQ44qtYAIiBbDVefmNgGcPtGhp7T398d1g2/q7co3IdOsg9ify2i5WmponQbw==
X-Received: by 2002:a05:600c:c178:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-46e71168c41mr34432305e9.28.1759562093996; 
 Sat, 04 Oct 2025 00:14:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a0204fsm162242475e9.14.2025.10.04.00.14.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:14:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/41] hw/virtio/vhost: Replace legacy
 cpu_physical_memory_*map() calls
Date: Sat,  4 Oct 2025 09:12:48 +0200
Message-ID: <20251004071307.37521-23-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Use VirtIODevice::dma_as address space to convert the legacy
cpu_physical_memory_[un]map() calls to address_space_[un]map().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-17-philmd@linaro.org>
---
 hw/virtio/vhost.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6557c58d12a..efa24aee609 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,6 +27,7 @@
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
 #include "system/dma.h"
+#include "system/memory.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
@@ -455,7 +456,8 @@ static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
                               hwaddr *plen, bool is_write)
 {
     if (!vhost_dev_has_iommu(dev)) {
-        return cpu_physical_memory_map(addr, plen, is_write);
+        return address_space_map(dev->vdev->dma_as, addr, plen, is_write,
+                                 MEMTXATTRS_UNSPECIFIED);
     } else {
         return (void *)(uintptr_t)addr;
     }
@@ -466,7 +468,8 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
                                hwaddr access_len)
 {
     if (!vhost_dev_has_iommu(dev)) {
-        cpu_physical_memory_unmap(buffer, len, is_write, access_len);
+        address_space_unmap(dev->vdev->dma_as, buffer, len, is_write,
+                            access_len);
     }
 }
 
-- 
2.51.0


