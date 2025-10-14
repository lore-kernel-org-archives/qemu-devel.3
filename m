Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DD1CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 11:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cxZ-00081J-SP; Tue, 14 Oct 2025 07:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxU-0007w9-5x
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:48 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxQ-00082q-U4
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:47 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b5a8184144dso226900466b.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 04:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760440362; x=1761045162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAZRcsAaL30fN5Qz7yHgxQKCt54WMH308w8bbB7E+lY=;
 b=rYhwtaqpZtLqLnrl+/9Y2vC5boHmx/5ffnSLhL6lpgg/c8kgsPiB69NfejUyJ7s6m2
 utNkKG7kX5wi801QCHuu9r/Ue5t3bmmuOxwERuTREc9gfuTVH/Nfsoo2pV2pKAqpT1rc
 dIQ0x+0HN+zMxQgVEwr6WyR7fiEmx+2SoMYyk164NjayckucEA15/2b8PdTXQIP7lWYk
 /yNa+Cg6kKPxP86YJFmUpFrSkcUqK7sfmxXVMKJYdDHxbJlVjPUuyAuZNWEanWkCqtDF
 MLi+u45AHfMoLSMRdQcCmyOkMvhlZ5DVtYqEseVe2PpA318Fg8TPlVouAN3M/HJQXlGg
 TSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760440362; x=1761045162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAZRcsAaL30fN5Qz7yHgxQKCt54WMH308w8bbB7E+lY=;
 b=GWxp7pAxvkE4M71gOA7ilE+bai3Djb4hJtsZoBAvsLpaPUmmOjUh8wOqHvXJAP1XBc
 23Dl5ytwafLA/8jpx+HAwlwEKJa+X7bc+7AQY+xvxTenZdWMnHcqJ71iFFoS4vRcVD4V
 IwYES/6/WIYWsrCfiAz44bKAgk6mw2fem+AiEbbBKo3CeLsCxWlZV1vlJBAKlotDIwgW
 KStSFHyKvRXpo2/0Q2U4O/1hXIKxOqJXmFX9wRTUqDLkXDI4dI/640FuEz/2Y6W9ZkaO
 lTIhmtNGrhSIpvXoelRALANQq2OXbXFS032/l8uF0nogbxLTBb3CaqYmClc3WBnwIlMy
 uRDQ==
X-Gm-Message-State: AOJu0YywDuUcxern57EICX6cyFYkuh2bojoGxIuvF314VIrBNlAy7igy
 ANmNzzTnwYBhiqXFigxHwVZKGquPlfwjFeoBWNOoZxMXGW9o/jawOHP7xHAwldGRi6Y=
X-Gm-Gg: ASbGncsp4U7+MgF6GG88NV9RZbz4Eeec24KbDZE2BgASQ7NRhVXbFUUfpENmkxnxUqc
 vsZf6LC9WzoO9a01jxguNl4OgrL8oznc0QH30lm2hweIDrOPtzJ5Va1/26b55IzmZXvrO5J1/Iy
 onQdW+K3OpJ3WLHda1PEj8crQR8RDcBqk/P71eadtpLjwdKRXUXpgP/IaXVYSi8VCZMIjie68jH
 6gXpGdD9+IMww4z2h3P93eWficxkKW7oc0c1uvDGmPNtAk79sfIcaC1VRDVazY/nG8qdweH1Qf9
 zwF3BWMCX1FJXl8ag/lecNQHncTfvX/negVgAwiNBYcymApfW+4Zy5dFw+eTy/MNWYB3d2cPAa5
 nYzZz6bY5Kv0pMumx7ZKEX/jFszL7nTWiAynhU7Odx5F06wp1Zypj27Um
X-Google-Smtp-Source: AGHT+IFVXyLrrvBRZT/J/qaDHRbM0I9ePEsN/28+MCU2GmuP0HW7ViCf25WLBGBLB0aeHHwEPL3cmQ==
X-Received: by 2002:a17:907:9409:b0:b50:893f:6fb8 with SMTP id
 a640c23a62f3a-b50acd2d7a7mr2565014466b.63.1760440361776; 
 Tue, 14 Oct 2025 04:12:41 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d8c12b9dsm1128553466b.45.2025.10.14.04.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 04:12:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9AC735FA31;
 Tue, 14 Oct 2025 12:12:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 6/8] virtio-gpu: refactor async blob unmapping
Date: Tue, 14 Oct 2025 12:12:32 +0100
Message-ID: <20251014111234.3190346-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014111234.3190346-1-alex.bennee@linaro.org>
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-11-alex.bennee@linaro.org>
---
 hw/display/virtio-gpu-virgl.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 0ef0b2743fe..ca7c607bf67 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -159,7 +159,32 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
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
 
@@ -170,16 +195,6 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
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
2.47.3


