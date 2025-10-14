Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B44CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 11:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cxf-00084E-5D; Tue, 14 Oct 2025 07:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxV-0007wO-NI
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:51 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxT-00083F-AC
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:49 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63b9da57cecso3758842a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 04:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760440363; x=1761045163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNsz/B9ZMuWBA6zhxt/zXKcHrrm+1gb8tG46YN/TcvU=;
 b=Ces9/lPweWELXf9PXDcPfj/9dgflVIwS6zzheGdImwQCQZNn4kZhmgv0xnTGu5g/Kt
 r6tRQA/fOFt9NXpNC2/j6Zner3X7SU3P4h1ILv9gRJZ4cw+CWd+mVicJLef4eXNMLxPH
 csDyJU2eJwGh869S96fznokYV+4qXZam2Zscad8TfLRX6KM60VCLr+cTBZZu+bUEl4v7
 fkfRhaufhBcDay0cM31+ruSDDPw4itTYQZqE1ddFHTyaaEp57Ie2dylnyMEDvTqrUop4
 RVqwRy2RmQkPiYeioIkFnZ5X6xOLvyqD38LArUlIYivodh63dzT9b7DwaQd2790aLPUF
 UYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760440363; x=1761045163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNsz/B9ZMuWBA6zhxt/zXKcHrrm+1gb8tG46YN/TcvU=;
 b=t05+rZa75TNeCiYhk2GCMDjR21R2DlCSWzcd+t7dp8QqdR1Qm/cW8SbfxUrvv9ePQW
 0oXX+aiHg1m/tcl+Xt74jvMdWsTl8ZvawLFpEqNIBCygZ8vS5ZNVsCAHhLDj2HB+XWVQ
 K4+top8iKcnrQ2xRL4VIjaKwUxdxPwg2DKGap0uyoXm7rGM0917Cj7wmX19Ydbngps0z
 UnS9xG7Map4IoCA2HUjO9fg6JdFa3PFWQwypyzqLYav0tLRss/BWYGsimeDWs6rIXSwG
 804fpEhq5aYV0uaGDNQdFIWqH0aMWdUUVmKizUCtvZeEFmtiWIgihLrPaYmOseH6PXIT
 Kb5A==
X-Gm-Message-State: AOJu0YwmR5bBmEfzxXFmKoEjSQTyKpyjjiEtnRvI2jYbQzP7HiWrHWE3
 hTIyfd2vMOunvhI+dsd+V/TwJgVxed3sUSM8BcWUI5HG3cJoAYNa4P/Ycgg78PKlYns=
X-Gm-Gg: ASbGncvPIpY31xDkMYkqU00RVQ0rZF9MIg4pHyon+GoICFT7ui2KH/v9YgJ9/FmOybp
 UcD3gfd8x0GtCeZC8PJ+JZylYgL1M8cH/vMD9II8V4j3sK2Sypvec1Kg9mvcfCAHvkIhddEdGjM
 Mh1MMKQiKrALVIBcifW6hJd9fsk8momC52Hdv2laJtRP1f+5aRDpmR3hBqCRcUU2IExabg89ZkX
 n9RG3TYgoM9UUoYd7ZbcNA+Isxyci2R6N48aMp6V2DU5Q3OGBy0OkgwixOlGY8v1RwAbFkxF0xx
 J6xVayEN66IwKHnTGZuxpSWQYWUmKaBHqL/B/iCsNv4KPlwm443HCEEhAvfEQSL3shhaRh4s7Os
 bfSJSb83w26+dU0etVebHkZJlD8bYeOHCOu+Oe45eysCO+TNSFEaQZbtV
X-Google-Smtp-Source: AGHT+IHeaehqiUFmtqcm0+6ZnsjB4TAQBHlmiSHEXNd/c9jqhHQkwBwtmTahsdnyRaHFBFD35pTWVQ==
X-Received: by 2002:a05:6402:26c8:b0:63b:dfab:6d5f with SMTP id
 4fb4d7f45d1cf-63bdfab6f6emr562709a12.5.1760440363122; 
 Tue, 14 Oct 2025 04:12:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a52b7164dsm10774803a12.21.2025.10.14.04.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 04:12:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B14175FA53;
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
Subject: [PATCH 7/8] virtio-gpu: fix hang under TCG when unmapping blob
Date: Tue, 14 Oct 2025 12:12:33 +0100
Message-ID: <20251014111234.3190346-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014111234.3190346-1-alex.bennee@linaro.org>
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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
index ca7c607bf67..d880adc8ab0 100644
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
2.47.3


