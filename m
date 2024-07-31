Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23007C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZBSQ-0001qX-W0; Wed, 31 Jul 2024 11:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZBSP-0001pY-Sj
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:41:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZBSN-00056R-Qt
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:41:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4281f00e70cso26739335e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722440498; x=1723045298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZ10jbqGcmWPbSCdFNpYZxcGrhjEM23ozxTz71ZPu1U=;
 b=ypuQwVmsIkcGCS40v++HpFFC6BRvdf2eyT4ylkd1dj0EYwBgR8bAjuzs7ITqp8KB6G
 J9gK5079Gq4vCVufqnNvl+/ctBE3nQZKB50EsgpupM+4iCIOAco36gvkLhPgi3Muaa/S
 sgi8+eHhTAonXpXcFCu5u18T1Y3XM2emMqghs2tdyL62SCFNmwcRSD6QTxYR3mYP7hSU
 hOQp88PjOHkyU7LUmfnQDB8enTIidMLRt3ZYY5U5mR7b5WFvW5Tky/22qrbJL/AUQKyJ
 trBMcCrzwD6hkaeCi1iBA6qVHdVRsQsvJFPjvMi2/BX/DRvO+hegxuCxIeG0VLrzo6o1
 NqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722440498; x=1723045298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZ10jbqGcmWPbSCdFNpYZxcGrhjEM23ozxTz71ZPu1U=;
 b=jf/3dvzdHRFlET/xrIElQyfDMLD1M5tSN2rv4d5PEbneIL1JVYIo+F+/GDkS/+RX+p
 qkxhviMaG28+D1d40kbMJcH8zgDVdL3t8gz7cfMbudTs7ZsQS1BSYNznefux9NOBwGkY
 hlmar7Eg2mM6VJxrdLrFk/8NJk1SL9hg38IbomVF3oGSnYxd6dDRsvDD4dJ6w707at0S
 OcAn+fnIcWtMFIFZyIWmczRJJS1gwUe5RP7DSVBB8xuQmDkzEpTUd6BgvPgN5mVnZ02p
 /6JXUC0KsbGkyGsDWTJEJkNiw9RY0JqnPTwnREUk6s1g1OEoqjpwZRuE0OXx2yFBOzOj
 Fk5g==
X-Gm-Message-State: AOJu0YwBHkImlEG6/re/Xej7hPKPEweySQ2RUs3ZzKzqGd0buRBRpoLs
 bhn95zCbMZ3ccsRaLJZR/1fRqKnOGi9XQLWtvZG22CRMS2fHN/XAOHLaSCXhf4Cf9zCizbp7BX4
 p
X-Google-Smtp-Source: AGHT+IHF2TCyvbBkTlG+hT5aJajNMLdrRz+Kpskcp6h10iWANi/Nt0LyRs2k9ClTXs8QrHgk+LboGA==
X-Received: by 2002:a05:600c:a03:b0:427:9db3:46ad with SMTP id
 5b1f17b1804b1-42811dd1a29mr91291585e9.23.1722440498129; 
 Wed, 31 Jul 2024 08:41:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bba283fsm25201295e9.46.2024.07.31.08.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 08:41:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/3] hw/display/virtio-gpu: Improve "opengl is not available"
 error message
Date: Wed, 31 Jul 2024 16:41:34 +0100
Message-Id: <20240731154136.3494621-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731154136.3494621-1-peter.maydell@linaro.org>
References: <20240731154136.3494621-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

If the user tries to use the virtio-gpu-gl device but the display
backend doesn't have OpenGL support enabled, we currently print a
rather uninformative error message:

$ qemu-system-aarch64 -M virt -device virtio-gpu-gl
qemu-system-aarch64: -device virtio-gpu-gl: opengl is not available

Since OpenGL is not enabled on display frontends by default, users
are quite likely to run into this. Improve the error message to
be more specific and to suggest to the user a path forward.

Note that the case of "user tried to enable OpenGL but the display
backend doesn't handle it" is caught elsewhere first, so we can
assume that isn't the problem:

$ qemu-system-aarch64 -M virt -device virtio-gpu-gl -display curses,gl=on
qemu-system-aarch64: OpenGL is not supported by the display

(Use of error_append_hint() requires us to add an ERRP_GUARD() to
the function, as noted in include/qapi/error.h.)

With this commit we now produce the hopefully more helpful error:
$ ./build/x86/qemu-system-aarch64 -M virt -device virtio-gpu-gl
qemu-system-aarch64: -device virtio-gpu-gl: The display backend does not have OpenGL support enabled
It can be enabled with '-display BACKEND,gl=on' where BACKEND is the name of the display backend to use.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2443
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/virtio-gpu-gl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 952820a4256..49cb61edd23 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -107,6 +107,7 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
 static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
 {
     VirtIOGPU *g = VIRTIO_GPU(qdev);
+    ERRP_GUARD();
 
 #if HOST_BIG_ENDIAN
     error_setg(errp, "virgl is not supported on bigendian platforms");
@@ -119,7 +120,12 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
     }
 
     if (!display_opengl) {
-        error_setg(errp, "opengl is not available");
+        error_setg(errp,
+                   "The display backend does not have OpenGL support enabled");
+        error_append_hint(errp,
+                          "It can be enabled with '-display BACKEND,gl=on' "
+                          "where BACKEND is the name of the display backend "
+                          "to use.\n");
         return;
     }
 
-- 
2.34.1


