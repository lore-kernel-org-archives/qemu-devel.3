Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2910C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmXH-0000bW-IV; Wed, 21 May 2025 12:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmXE-0000Z6-FN
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:16 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmX3-0006CC-TU
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:16 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ad572ba1347so503235166b.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845783; x=1748450583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKjH7CjiJYzujGe3Nf/k6lUsudRskeBEN8uYYCNZGto=;
 b=hS7saKN+TKifPLGgSQIyS5jGUcFyW1+wkl4bTu3T4dkPqQ58Qd/8QbBn6RKr2RMp2B
 FludBUFPBS1bk/QJZWLWHqyfr6dFBktPap3Eir2R8WVJJ4j6mKqfzVUcB9VSvJQAoPug
 l9y6vnwobqSYZCbTgEJODgeiYkIV8zPQLtaVTlOm36ZxUcU/hskc0JNkbOvFIEUQLzq0
 k8krPrIFw6l5HUnbPriWsAFTuO14hOwuEZCgvWEHEWVEQ5nbNc0CIMYfYMaFHfHuCVfo
 jLHQNKValezHMhN4HiKEPhd6Pt8YQQgoM5+sss0aHBcStfGMFGMHmyy6d+Ql8ugArUMf
 +fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845783; x=1748450583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKjH7CjiJYzujGe3Nf/k6lUsudRskeBEN8uYYCNZGto=;
 b=GTy6dG2UkpQAzjY4WfXOxqjJ8/XoUUDLZiHtNjUXHezXHor/ZPD6256pjsuQIDQPLV
 HIkWoYlErCS7EnQ/McOI9FFYaZTRXP8W4WwsDqGsXQRrObIU1cDEwLtA4r86G8uazSRd
 0SqIxP5GqoeuCPftog8iWjlCveD1uo/ok3xtCSlSwBga8bD3RfWxmMGdnmmjewscKAlb
 3HWCPwMFxaeQJa++2oQ6mBHzRozQNe3oBIFloyIkMC5kq79vbmGk8KPike/Pd0MPm6yF
 88eNbG/PeIahxL9GKCRMHpDbnwKtVEikCmLUq1h3gaz7mbNUwPNqK4/kCz8a5perHZLE
 FN5Q==
X-Gm-Message-State: AOJu0YypaXMNSpuxjFcIL60I2YiH1NKL++IlZpwABXVlJJ8iYLkbIWDb
 pwKZVSGJxMWoO4qcBIFSVk+bIscxI6VSiq+gkrSr0sKXN91viww3hHT4B5BzTIKdKjk=
X-Gm-Gg: ASbGncuwdeQEMP3SwsAHZRBlFAALMgsyz1JYWk0mljqz00RdbRgukLMqGAWI6jeiCTI
 zt0fO1frKRUlUf7gBWIGmzJZRL0gUQDV+sFsf/lEmdiJ7mcFXj5DMUG7tx6LQD4i7OmEkaY7w6f
 O8JXMz8sUZ9qmIBXhDVkjeFdXIAq5UePW2d36YgBdAEl2MimXaqP3QT+gYjf623b+sx2gPc7i/s
 DPTg+b9yQa1cZTVPnCUnm+07Z7WyyJYfE2KoEm37j06KeE9Gomc+7xX4UVtZQnJXt5DYk4Y9yda
 tTaQtcrqhBBHL+59uyty72IMdiF0oWFTEZBpACWpzbCqlepLB5X8bswGjZU6+B8=
X-Google-Smtp-Source: AGHT+IHMltgYjVzI6DdhAD5Bb0bdXPbcpoi6cVcQn52SQcGU0WHbpxhEOUICZPo5X8LhTxZX+fb7nQ==
X-Received: by 2002:a17:907:d9f:b0:ad5:8414:497 with SMTP id
 a640c23a62f3a-ad58414049cmr949162266b.16.1747845783333; 
 Wed, 21 May 2025 09:43:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-601e657a0b1sm5073214a12.45.2025.05.21.09.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:43:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 389BB5FA36;
 Wed, 21 May 2025 17:42:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 13/20] virtio-gpu: refactor async blob unmapping
Date: Wed, 21 May 2025 17:42:43 +0100
Message-Id: <20250521164250.135776-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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
index 8fbe4e70cc..32a32879f7 100644
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
2.39.5


