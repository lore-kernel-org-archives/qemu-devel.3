Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B19C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHrr-000415-Dv; Tue, 06 May 2025 08:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrW-0003Vj-HS
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:31 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrR-0003s5-IG
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:29 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so1046532066b.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536244; x=1747141044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKjH7CjiJYzujGe3Nf/k6lUsudRskeBEN8uYYCNZGto=;
 b=owVp5fRVuSINMBQFWHvzQsHz1+HZEKIMZpc9qwVCGMpdMsOfKAGO5BKvAsE+QCZl3/
 jxWzeY3xaqX1BQHFPlIgHfAtY2tMb5qPqTZ4EnrrzJuZ9a+n5zxxy1i8NMGG09CGQRpR
 gGIMuPczdaFyCm+3LgYzjqZWMkQfkLy6qvgjcKXE9S4l+Mfu9sChPtHO1l+l75ELW0nl
 5AmsWwAYfaqkbGnffBrfbTLYs1HQpbfL6Rnjd2j0LgU1b1s1mJDctXSFJ1/z4uwAG+Jm
 y42JIyT5QTfLIk/EQghkGzmP6J4DTpbhKgtApVDEV3rxsnUtQPb7oQC7N1B8ETlogQOm
 y2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536244; x=1747141044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKjH7CjiJYzujGe3Nf/k6lUsudRskeBEN8uYYCNZGto=;
 b=oJGGoNWVTC8LVQx4z7GLXiWx3iK5Op2aJ2o3Orbv1qK/wXRVJd5G66qRoecoOG4BIL
 kZuh8k8qd0mI0UqdAMSFNmrDpkWAl9rRKd7YR5QTYq0hDNiPmL47KW0n/w9511JQ1+uP
 GPw38T3eP2JeNA/RdVO5U2Ul3rZU1sZVOZ8CEQ+C91YOujktW5st1YcIG6sZ4XzHf4B7
 ck36imintd2c2Gm7jQXnpV68E2DtfiD1mo2ytGaN4lbAkAP8yTW2qNcE91rJZM+TZhXw
 G/CCQ3xfdoIRnPSHq+YGpx0doVgFBTkvoJOwUjQ/m1+grI0RTBBGfCQVZ+ej0V8axiz5
 ipAw==
X-Gm-Message-State: AOJu0YxBIE+a/UW6Lwuq8cRvgN2yHnM7Cgfbtraq7JtS+Ur+cMM5n7sN
 FZ5HEn/0hTcfTtPEcdigU3PBvtofjXDK2lczbkBnyYP0Eat/UIZ06bKg9uv5cc0=
X-Gm-Gg: ASbGncswqDXsb+VQOA33t2Vebk9BaESbEkFghsrr5woDl8gLP54yyw1Qr1tvbZkTtVc
 1W1z9vxsPXtm+fbdLd1SsB/bsQTxnFHxGS1tUwBVHjs8MHjPz9wB25l/ZGpDNJOzwTeo2PTkBAu
 Cn6JUXEuow6AT/el2vzixLCEja6o3aayu1/kZOshyS3aW5KGbt5NJdJ/h5E6YqwiAASVzeF8KJ3
 B974ivbRVMeW3iSl/Al2sbVVD7j4V3Gd0NpzOOGw9egpRtHLu2/eIgIUT3lD1iMigQub9xXZDJQ
 diQl0CnS4hOq4gv+pwXH/jaX0Mcx/Mr0hNvs31V7SXY=
X-Google-Smtp-Source: AGHT+IG/OqvbSG2d0HsujNT9bPpGWeArwtBgY+tCjKGCadq5kw5UDuVqVFa6WynLdNSUMq56jf1y+g==
X-Received: by 2002:a17:907:7d8d:b0:ace:4ed9:a8c1 with SMTP id
 a640c23a62f3a-ad1d459a590mr261451066b.30.1746536243741; 
 Tue, 06 May 2025 05:57:23 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad18914d067sm700737666b.3.2025.05.06.05.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 05:57:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 275705FADA;
 Tue,  6 May 2025 13:57:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 11/14] virtio-gpu: refactor async blob unmapping
Date: Tue,  6 May 2025 13:57:12 +0100
Message-Id: <20250506125715.232872-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506125715.232872-1-alex.bennee@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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


