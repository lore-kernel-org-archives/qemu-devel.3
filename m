Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDF3C3ABC0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHri-0003j3-89; Tue, 06 May 2025 08:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrT-0003Qr-Ps
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:27 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrQ-0003rO-Aw
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:27 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac2dfdf3c38so1019526966b.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536242; x=1747141042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vC8n191P5j8mUKL+6H7GfxpWwzkXlFDtmwixiEivZfA=;
 b=O9bX+vmQ7gmoTKDTsai+semI13YbChAKizm11M0oKduL4B0mCx2e0BTdCXX2T/v64a
 3JyYWChF/tEenkHnnZGB9ZEk8nv65yC76NH5WHsvcrDPMMuZgdPr5pcx55dFlIXrNJRY
 SjmmDAQQoOzoK2dbPSe7gi89N3wQvXYYQ43E9gQyEY45DosUvO7K+LeYawWZ7oIjhwpM
 yBuY7Hnq/5PPwHVevYCTsI8YNDbb4/ry99tzDc6HswSgGdzH1JucWJcoY4iVnyiXCSXF
 w3ysd6u8USGYuMJdDSBghI7ct0D+NwjWxjKHqVd6oNbJct+jVstQ0hOi3Lfui4N5S5Dq
 r6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536242; x=1747141042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vC8n191P5j8mUKL+6H7GfxpWwzkXlFDtmwixiEivZfA=;
 b=iE31u25n9yJLYV03LQGylWrSUCFd0HhomiWhyfXI2Zo6muP6U+EfGxMYAU7y3uYic9
 gXhW2T5Nl3rCTy5Dr55BbC5G55pW/NuW2sMxmyJGKSkzBnpfJAM8IXoz8sCUmm2zCqV8
 wcjwXRmSTIVX9JM+MJzK36qEam4E4gb4k2uWDEogBQLRcKuRu6zOmoCyxHHvM87OXpjx
 DfwStrvzz1KZKVBaKZvC0xa9fDuxha7Kvpx7PsGu1nIOsuWUxFyON9dP2PtE0zKfPRml
 qkjiph7+1Eu8yxVUmTdJq5HlZqqXLD7uhzoEXkYcWYcZP6ol8cfwBBvwT4PXpbYhqtET
 KWWQ==
X-Gm-Message-State: AOJu0YzDByWO62jKj+UJJ86xI16ScR0PIBsrYBTK5e39orTPmA+yWAwh
 McDJCVvVmuvNvT42WwXcyFFWoHc7aYnozEO8fd27Ir6oeFv8WJYHfpLwXmIhFDk=
X-Gm-Gg: ASbGncvmta6lx3QZrQeXNyLpymE5tXkTwJ+mQEl3Mcafa7jjF5ib0ladKGG8+mfjTvX
 /5M38RUAUhY2oztjYWtDku/3Js1HOP1hUe7dqEuda3nlaclsMsBwuW9pvyDzJUqggBi2szPnGw7
 6Zyz3jfhKHKFTkYA7LRXOzyPt/e6ovgWQdZE2UbagLwbBX7WWKejJPh9iW2vfuWyUkgXZayFGlb
 rD06PSCCwYVjlYID3aDwFAp57xrOqrETXEdwdfLvron7rbCcXZ5hfKYLqG02G59dSfQtCMgx+1F
 IgXRR1h/gsOnBHhS6qR/Zy5CzeRzcncebtPMWFcwn3k=
X-Google-Smtp-Source: AGHT+IEx5OIwXzNRcCZt/soahwzNz5FxIcFaFN+CHi0XTr9o8pKKnlGNm/CPGjhhiD7GpKGuQiMbuw==
X-Received: by 2002:a17:906:40d1:b0:acf:c:22ca with SMTP id
 a640c23a62f3a-ad1d346eb02mr234030866b.1.1746536242292; 
 Tue, 06 May 2025 05:57:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1895410b2sm687743266b.181.2025.05.06.05.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 05:57:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0ED035FAD9;
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
Subject: [PATCH v2 10/14] virtio-gpu: fix hang under TCG when unmapping blob
Date: Tue,  6 May 2025 13:57:11 +0100
Message-Id: <20250506125715.232872-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506125715.232872-1-alex.bennee@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

This commit fixes an indefinite hang when using VIRTIO GPU blob objects
under TCG in certain conditions.

The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB VIRTIO command creates a
MemoryRegion and attaches it to an offset on a PCI BAR of the
VirtIOGPUdevice. The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB command unmaps
it.

Because virglrenderer commands are not thread-safe they are only
called on the main context and QEMU performs the cleanup in three steps
to prevent a use-after-free scenario where the guest can access the
region after it’s unmapped:

1. From the main context, the region’s field finish_unmapping is false
   by default, so it sets a variable cmd_suspended, increases the
   renderer_blocked variable, deletes the blob subregion, and unparents
   the blob subregion causing its reference count to decrement.

2. From an RCU context, the MemoryView gets freed, the FlatView gets
   recalculated, the free callback of the blob region
   virtio_gpu_virgl_hostmem_region_free is called which sets the
   region’s field finish_unmapping to true, allowing the main thread
   context to finish replying to the command

3. From the main context, the command is processed again, but this time
   finish_unmapping is true, so virgl_renderer_resource_unmap can be
   called and a response is sent to the guest.

It happens so that under TCG, if the guest has no timers configured (and
thus no interrupt will cause the CPU to exit), the RCU thread does not
have enough time to grab the locks and recalculate the FlatView.

That’s not a big problem in practice since most guests will assume a
response will happen later in time and go on to do different things,
potentially triggering interrupts and allowing the RCU context to run.
If the guest waits for the unmap command to complete though, it blocks
indefinitely. Attaching to the QEMU monitor and force quitting the guest
allows the cleanup to continue.

There's no reason why the FlatView recalculation can't occur right away
when we delete the blob subregion, however. It does not, because when we
create the subregion we set the object as its own parent:

    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);

The extra reference is what prevents freeing the memory region object in
the memory transaction of deleting the subregion.

This commit changes the owner object to the device, which removes the
extra owner reference in the memory region and causes the MR to be
freed right away in the main context.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250410122643.1747913-3-manos.pitsidianakis@linaro.org>
Cc: qemu-stable@nongnu.org
---
 hw/display/virtio-gpu-virgl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 71a7500de9..8fbe4e70cc 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -112,7 +112,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     vmr->g = g;
     mr = g_new0(MemoryRegion, 1);
 
-    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
+    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
     memory_region_add_subregion(&b->hostmem, offset, mr);
     memory_region_set_enabled(mr, true);
 
-- 
2.39.5


