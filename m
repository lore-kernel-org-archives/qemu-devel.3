Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CBDCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 01:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5wqH-0003jm-2x; Mon, 06 Oct 2025 21:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5wqF-0003jW-Ku
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 21:50:15 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5wqE-0005cx-0h
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 21:50:15 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ee1221ceaaso4189664f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 18:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759801812; x=1760406612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sea4eoeDEINz7GWqV1uH5ZtGuONXFWLREOAIhHVqXLM=;
 b=KrWHbqOrTZ9c9Xt6l5UO0b4Xd59z6c7m9VG+IQPZPJgSb33xvCEkCD+a6OUrjPj6U0
 v0QmstsjTJx/ju7NN5htCOd6/hDa7+EA4AKhV1PUCqaIXIK2fofn80N0zG1MnsoZFuV+
 /WotH+0S5xJhhJjwlWUAVhRIIo49VQKRlORtHzBqCI8HN40Ae3FjHxd4M1WFmQqNhNGP
 LMMqrDoO+zIXlC+PCsmxpBMFhgAETHr8S4J2WEqWjpw2zXWZy6i2UBYxKUa0rTrj3Z0O
 Vg3gcJLJhBCVic0CueEsPR4SJFLlqmeg8uBf3v+xXIuG0831Ht+Q9DXCenmO6n/wns8F
 KTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759801812; x=1760406612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sea4eoeDEINz7GWqV1uH5ZtGuONXFWLREOAIhHVqXLM=;
 b=eiNL38Wkb/h7jM2sJbe1Nu2azLDnH7UNz/SNQ0LwrYZ+htUqEyhg6mw+PC+bfFpd/U
 2CyhFuPK+lrVXvXauyOXx8QUnZgyotM2gbahAdZObCirnG47TVTtDcbC8YWiylwYAkIJ
 eWDCtXYA3LXq//sujcJbb2USvDetqImk5HOUk3NxwiplmXk5YIpLXJBuRcoQEed5ulAm
 beHnjzcNz1XowFSin9vcTQ+cqLMM7iNaeOKr3wW5ol5eaeIFwrMBqlUt3YR7doobsC56
 99uT+LGp0YO/yVySHifq1iEKsn/tNR/QJ2GY9wIywcZ8Qrt3WKbpSs80MOvPB/t4pg42
 xkBQ==
X-Gm-Message-State: AOJu0YyRtevAc8sIPwinw8dCWradmbalNJgmFWMbSjUD3V2ofcXVKApx
 A6TzQn00Jeto3DX4g63hAapoFR+DdVeXH67UEYJ0Az73Q+0boZX/srBqfUPjLmeXWwzq+1T+LRK
 TKhtXF+HfAA==
X-Gm-Gg: ASbGncsGVXkC2bBONsF9Q5L9O/MPtvvXu/+x9zfSNPHAfF6lPWWbfcjlmSJdk9yi5k8
 +JzbPEBmA7w5rBLnJFM+89wdqhrcVkoozcUwcDFiOHS822Z1QegVjGoi06yY4h7u90R88HtAeCS
 Ndq2DYdWRzf44uVNu1UKYg4elOKW8FQSBvWCZ+vNfRgTD80kjoGV5SZf2AZ2VvRWRKqfpEM6dkF
 aaduvJi6rXy9frSHB36+Sc3q0dSDPtMV7Z1tJ+ThUiMpd9SOuODUso10p2RAoVkepVFUtg+Oxmx
 GVDjoZGK3qUEQOSuNFDW+UZpfAKO1+qJdbgSaW4ue+WTTSSooRvaCBl42rGfJCG2/pBoCGQhOEk
 eSkOQUiLaf1LiNH6Ne+OVa09ayAY71AyTMat4YJK+/EKhq2o3Qwnjfd5PI+8P0eGU2Qfh0BWyRg
 J0XLnEHCl29IO7eTYJMVXzjUUb
X-Google-Smtp-Source: AGHT+IGifm83xTxzgQZ9Mg1Zs9RMD2TVGheREPMlDInR+kT4DJNDT0TDw6EhdoRUaIXANXObO8lqWQ==
X-Received: by 2002:a05:6000:3105:b0:3f9:1571:fdea with SMTP id
 ffacd0b85a97d-425671b28b5mr10279086f8f.44.1759801811873; 
 Mon, 06 Oct 2025 18:50:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0846sm23414159f8f.45.2025.10.06.18.50.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Oct 2025 18:50:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/41] hw/virtio/virtio: Replace legacy
 cpu_physical_memory_map() call
Date: Tue,  7 Oct 2025 03:49:58 +0200
Message-ID: <20251007014958.19086-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007014958.19086-1-philmd@linaro.org>
References: <20251007014958.19086-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Propagate VirtIODevice::dma_as to virtqueue_undo_map_desc()
in order to replace the legacy cpu_physical_memory_unmap()
call by address_space_unmap().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-18-philmd@linaro.org>
---
 hw/virtio/virtio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index be73753b59f..153ee0a0cf1 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -32,6 +32,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "system/dma.h"
 #include "system/iothread.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "virtio-qmp.h"
 
@@ -1632,7 +1633,8 @@ out:
  * virtqueue_unmap_sg() can't be used).  Assumes buffers weren't written to
  * yet.
  */
-static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
+static void virtqueue_undo_map_desc(AddressSpace *as,
+                                    unsigned int out_num, unsigned int in_num,
                                     struct iovec *iov)
 {
     unsigned int i;
@@ -1640,7 +1642,7 @@ static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
     for (i = 0; i < out_num + in_num; i++) {
         int is_write = i >= out_num;
 
-        cpu_physical_memory_unmap(iov->iov_base, iov->iov_len, is_write, 0);
+        address_space_unmap(as, iov->iov_base, iov->iov_len, is_write, 0);
         iov++;
     }
 }
@@ -1842,7 +1844,7 @@ done:
     return elem;
 
 err_undo_map:
-    virtqueue_undo_map_desc(out_num, in_num, iov);
+    virtqueue_undo_map_desc(vdev->dma_as, out_num, in_num, iov);
     goto done;
 }
 
@@ -1992,7 +1994,7 @@ done:
     return elem;
 
 err_undo_map:
-    virtqueue_undo_map_desc(out_num, in_num, iov);
+    virtqueue_undo_map_desc(vdev->dma_as, out_num, in_num, iov);
     goto done;
 }
 
-- 
2.51.0


