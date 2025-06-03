Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E61C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPRU-0001Ge-3N; Tue, 03 Jun 2025 07:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPN-00081P-Dy
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:17 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPJ-0002BY-DE
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:16 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-606b6dbe316so305035a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948531; x=1749553331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EpuBo3M1LF3MK0WBrtfymjZZWtx+efkCf6X7TVPwYV0=;
 b=AyhYFqKo8QC9KznxrYcSRmByFxkUctO2/SIOd/Rk6S0C1ljC6yH3tqEpUXbcSNm6BJ
 DvhgvXSdWB4AELrA4xviovQam2WCTUSQQcJPtWGCE9v06uCAKm1SND6UHpaL/X2j5GqY
 Out1iHiOCshTvI5838QV/wlHZHPNzQ6jq6ufhia0wvbQ68378iznrI40HvVRWdwtZuLf
 tomoNItYAPdsYryZoz5m2h70dXDGpkd/QTIQlNRh6LcVL4mF9GMoQNhr9b6+PZe32RFk
 bivQBGMPxlPh6YiKYF+9+MVtSQZw0gpW9gQP1VXa7IHA6FhfD9fvZmpRlBa+PEeEQbdf
 Rjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948531; x=1749553331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EpuBo3M1LF3MK0WBrtfymjZZWtx+efkCf6X7TVPwYV0=;
 b=hOXWO5etZlS0BCgpa+bagTaYN0rpDylReZLWk/hPEPKQeHCqXjtoNnLFefCRiSqFCO
 PDYScreLF51zGAY5qeT9AOB8hWx+42BP7OECCWt3JExIPkcb4FDaeh7cdjCm7KRKNr8G
 kBqQdHm58YNNxH99HVtWNxsPRFUlfSqyFbY4ZYebVbzeYG20cR+PMUqR5YdOVLwYcVNx
 2y5OSffCEvwM2XOEsxjde2q0XiWiLezloevawNByNtTRXe0iIz98uUS5d0IU0bXQ3w8P
 I+9/yyfAktbd2zcPCK6ZPRrfuaZFnYBd02FSZUGb2ayKIioSlLZz7ndq6t5lRpwCEt4t
 Oljg==
X-Gm-Message-State: AOJu0YzSPp2droc43sDDAaZ1FjO3uIozk21zxoXRt2aDLxCZuYtP24mX
 5mSBbVi3bqe2vDxoZQqdqNss+vVMc4WVcGHUwbEiFrNTcms89MNKZhOZvyvhbJSNwJ0=
X-Gm-Gg: ASbGncuz/uiUPpft5o1I4PBK8noJjQTbFwGMMlxIY0ktNWi7DxF1pGHKQFyf/jcdWej
 HOiSvtC74tAz+6281oMIBj/ozI105RMReSFSipgujMNFMsEi4ZTMVZm7H/1tiDUJVV8BAnorbI4
 Myrww8rbJP3kPSF3K8qYwMjcMa3ZtozgbsURs8qnf+RF23qP2/GEVBVplYfupxsROyOzOvsVXfU
 e9X+n15RDw1dm7KD/BknnjNyyqrBglP7TwaxUSuFraRDVf+1+B2dXwYbxHyi8jYijVcIuZSRRK0
 wSb3miyLlpH0eC4/UTr76B2Q9OMt5mk4Jz7Q0OMzeiBpPccUMPjK
X-Google-Smtp-Source: AGHT+IHqZ9PkgmJ2mTy37pYmaLvHCClDPgXBCZvvzlG81L9eOqnjf8vhFWYeYO/K5dbCgNwWasrA+w==
X-Received: by 2002:a17:907:9443:b0:ad8:a7d8:efab with SMTP id
 a640c23a62f3a-adb322863d1mr1509040866b.22.1748948531467; 
 Tue, 03 Jun 2025 04:02:11 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5e2bf051sm929136666b.122.2025.06.03.04.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D41875F9E7;
 Tue, 03 Jun 2025 12:02:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v4 10/17] virtio-gpu: refactor async blob unmapping
Date: Tue,  3 Jun 2025 12:01:57 +0100
Message-ID: <20250603110204.838117-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Change the 3 part async cleanup of a blob memory mapping to check if the
unmapping has finished already after deleting the subregion; this
condition allows us to skip suspending the command and responding to the
guest right away.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250410122643.1747913-4-manos.pitsidianakis@linaro.org>
Cc: qemu-stable@nongnu.org
---
 hw/display/virtio-gpu-virgl.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 71a7500de9..b4aa8abb96 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -155,7 +155,32 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
      *    asynchronously by virtio_gpu_virgl_hostmem_region_free().
      * 3. Finish the unmapping with final virgl_renderer_resource_unmap().
      */
+
+    /* 1. Check if we should start unmapping now */
+    if (!vmr->finish_unmapping) {
+        /* begin async unmapping. render will be unblocked once MR is freed */
+        b->renderer_blocked++;
+
+        memory_region_set_enabled(mr, false);
+        memory_region_del_subregion(&b->hostmem, mr);
+        object_unparent(OBJECT(mr));
+        /*
+         * The unmapping might have already finished at this point if no one
+         * else held a reference to the MR; if yes, we can skip suspending the
+         * command and unmap the resource right away.
+         */
+        *cmd_suspended = !vmr->finish_unmapping;
+    }
+
+    /*
+     * 2. if virtio_gpu_virgl_hostmem_region_free hasn't been executed yet, we
+     * have marked the command to be re-processed later by setting
+     * cmd_suspended to true. The freeing callback will be called from RCU
+     * context later.
+     */
+
     if (vmr->finish_unmapping) {
+        /* 3. MemoryRegion has been freed, so finish unmapping */
         res->mr = NULL;
         g_free(vmr);
 
@@ -166,16 +191,6 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
                           __func__, strerror(-ret));
             return ret;
         }
-    } else {
-        *cmd_suspended = true;
-
-        /* render will be unblocked once MR is freed */
-        b->renderer_blocked++;
-
-        /* memory region owns self res->mr object and frees it by itself */
-        memory_region_set_enabled(mr, false);
-        memory_region_del_subregion(&b->hostmem, mr);
-        object_unparent(OBJECT(mr));
     }
 
     return 0;
-- 
2.47.2


