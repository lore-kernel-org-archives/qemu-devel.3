Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5B0C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9O5n-0000o4-HX; Mon, 28 Apr 2025 09:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O55-0007w3-CM
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:32 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O51-000383-PF
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:30 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5f4d0da2d2cso9075162a12.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745845166; x=1746449966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKjH7CjiJYzujGe3Nf/k6lUsudRskeBEN8uYYCNZGto=;
 b=cl+CayrqVe7kYwRjwjmXUfAHlGUdAlVCrQtCN5cfz96GFuZBUonHRfSuv/uLLthijW
 /SR6yproRGQq5LheSyDYJfXEqmENLDWv4rNJ8gtxLdLtAks8H4Xf82Zq9C+7XyNqAl2t
 BsPuuNJJPwxx31DSRW/s5AMKhwxfJ8Ow/qqwFCkALETvDod0W2LO2+6m5cT/zTphAuo7
 YGXMQiPtIr/C1u7ezfjXcDp+k1g1puBEihbKCO0dIZa3G/+FhEmbP+v/qy/ch1+t2v1y
 hyUbokhXcju6qB+wrFu39CCw06C4UI3MFwbUCh8BbLTFfE9shk5wd77O9V09PrEMHRy8
 +dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745845166; x=1746449966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKjH7CjiJYzujGe3Nf/k6lUsudRskeBEN8uYYCNZGto=;
 b=tmzjz4FwodlToJyyvIT1eYB9M3Za9gh8KXwY5OAzh6G0b90CijU6gsUn6ctVrpl3PK
 CFh8aYZBcDxAdra8JpFcXdolSQKO4M4i7pK6m36FIr7p2dU6Ayxjpqo4T9EjVHz3dlRE
 1BywSyqLKd4pWKB0GtQfm6FMHzLoFIIflsQLELlbqR+F66yxjQFLG0Ppdt1R2HMPZsKF
 G4jtAk6dRID+4vsIBMIGA1J2L3B705jCi3wd96/T2Enn5p0KRfZxjHXduELr3gxhCKFr
 7wI0U3UsaebCdjpL231teG2YBuIMzTZvV9m8OEFzI6KXBhXs9J6niKqJCX6xp0OAn/P8
 0qyw==
X-Gm-Message-State: AOJu0YyKpV1z6kbh33oWZaFlNd+UHjQLmeSKWWU2tOUgW+EXXyzAwVIA
 zUkpVwXrQTDjUYNpHsYHsdYMyJsayWDWC78RCWYbe8dFJmBYQBvQgOFmeKMshL0=
X-Gm-Gg: ASbGnctgIqtGd/3xeRFioDcdwJ8cvavOW1OGLck8n2qx1cFDAwKPno2j8pA0uLYDus7
 q9CksAeSgjPmkNreuOlqdph/UYB1YaBbHR+LRxzXO55GrCF8Vc3Ng0kqF8UHVzdWXudF1wdytp1
 ytsuZZ2ishMZ8Y9jBN3xNiJ4EV5pKbrzxZ4Tkb21gA4CcFbZ3hYzkn59zO7OFw4Mx1jnWSitM6/
 iIx3O643ge0BP5wjZRlnwkEWJG6ZBEGP54FMFKRKoYwYAcL6T1xt8zWCG8a0WiO5All/NsxM4cE
 H7iT7fEeHEXmqtOzwGZ5NOU6WYwXXIhbgw7LXd7baG8=
X-Google-Smtp-Source: AGHT+IFI6sakvRkl8l7J1+4pra5qOODJop85Rq3jH2KxHpnfZEwRJhi+UJS1JldBP+uLhunWDdL2Gg==
X-Received: by 2002:a05:6402:2345:b0:5dc:c9ce:b022 with SMTP id
 4fb4d7f45d1cf-5f7395efc3cmr6818100a12.9.1745845165661; 
 Mon, 28 Apr 2025 05:59:25 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f7f83ef5f1sm979766a12.21.2025.04.28.05.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 05:59:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 18C605FAF1;
 Mon, 28 Apr 2025 13:59:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 9/9] virtio-gpu: refactor async blob unmapping
Date: Mon, 28 Apr 2025 13:59:18 +0100
Message-Id: <20250428125918.449346-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428125918.449346-1-alex.bennee@linaro.org>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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


