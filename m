Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBD4C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 06:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHyy5-0003g1-Bq; Thu, 22 May 2025 01:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHyy4-0003ft-HO
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:59:48 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHyy2-0005Cx-I1
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:59:48 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-231d4679580so53153605ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 22:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747893584; x=1748498384;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ll92QMKsFRvpgTuMWBg4qCrKu3QQgX5gI3lF9iL3GEo=;
 b=naBnW9GSHZY/3l2H7nJmkvxLBfdVCtuc561EwDU/F78Mg9cR/Wi88gCiEpwxEO/80M
 lFjcFlAgJXs4xZFjTrX06Q71LBqAwVdGo8uVILeeISae9NpO1L4s00CsuSjgcrm2V244
 jqryRitzEdA80mmH1hiRP9TEsu04oHaSgUKADHz+ToKIeSacsWnK/U1HWAZbrWcGVf7G
 d9cKw/U+UR8AwSijQ7HNqGNxdH6sCgFbAEPaRRY+iusf+qBPqStNSMpgEoU1rM9lkadL
 6tteVbT9LORwvmBt/aNUFSCiw+jFKU5EA/37xyem6vVaW0jcgBaPmVMG5DWNg+Olorbo
 uKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747893584; x=1748498384;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ll92QMKsFRvpgTuMWBg4qCrKu3QQgX5gI3lF9iL3GEo=;
 b=J+te+PoWLqkOrt7r/ZL6W17MysKK4rWLmA57GfjLTm7TXpjYM6kYrVkMOkUhvm4/d/
 t1PUl5qtV/rfTS4MWXEu+MRslYNNkQ+bj7qfxXRSOu0ZMlmANXFyApGlgTc6NDGVaLYm
 3kxmbe61l1vgbXxHNVPz7XecpfGbcdwSOWXNRPgntgcwC07MuOKXLvSih1+jxxCbj4pK
 y5eLQ3oEWfY8CmuR/ch9GJphs0SFK2aOaE2PQ6HpU5l4kGL64mefdAPVjLdECiO317n/
 BYmizc8bc0Be25HaXgawk9Orf5R8R54AKdv/E1ad9V+wwoDcF+nYfAVs4/f/We9KIjUw
 4BoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB3An+jbLK1KP2RVBAAjgVkvv9K4uZPLFB03w1FpQewpfw+j99Uv4OqrBhlJmZhNY/WEaOl61go7tZ@nongnu.org
X-Gm-Message-State: AOJu0YxWUdrs1ZJPV+4mESDg6UTX6yFdG0om6ccS9bQFcOjVc9+buH4Q
 sOMKWtijRsuwbNCnrNasrGpfKn/X4rKdfRMw183Q3ilykcehA0FfbUau/mIDZt54wIA=
X-Gm-Gg: ASbGncvxCS6YOB4WcszC2hGwntie/mNI1klMnEivrp3rIOZu5cNKcKa97sHN41MHhMg
 rs1eTPJRoZebv06qzNYd4t3o3/pv9+tQJRtb+UTpLgKoyXvAW9hLPQ2/WTpgGf5U/O3xOLBg/6S
 tNghRX//lzDcw57bhVpAzEbpje+n04VQRx1bkJzYoGy2HbIfk4LiQqNgxhM4H8OggEPG6hujMfz
 Cmh25mulayRtX02zAceIGoAMPAsqIE/0QJewDlBZB7EffwkzP7UFzymIPrV+/bV4HaUwbC+I6Sx
 6GlDu4BOqUcK5z/oIrakWSorDumJT+RhdcGng42imz6vifA00jF4zji+Gxfraw==
X-Google-Smtp-Source: AGHT+IGqHP9wyaMp3uwJkuTClRkae6ROCcsTqoUUE6+5eCLIu6eiqb3c0BDe7KQlQ/vmAS8jOcKP8Q==
X-Received: by 2002:a17:902:c948:b0:22f:c91f:d05f with SMTP id
 d9443c01a7336-231d45c99c7mr354621945ad.46.1747893584297; 
 Wed, 21 May 2025 22:59:44 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebb0f5sm101672865ad.192.2025.05.21.22.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 22:59:43 -0700 (PDT)
Message-ID: <4d300cca-3ac2-4072-a35c-0b6aef970b26@daynix.com>
Date: Thu, 22 May 2025 14:59:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/20] virtio-gpu: fix hang under TCG when unmapping
 blob
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-stable@nongnu.org
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-13-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250521164250.135776-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/22 1:42, Alex Bennée wrote:
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
> This commit fixes an indefinite hang when using VIRTIO GPU blob objects
> under TCG in certain conditions.
> 
> The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB VIRTIO command creates a
> MemoryRegion and attaches it to an offset on a PCI BAR of the
> VirtIOGPUdevice. The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB command unmaps
> it.
> 
> Because virglrenderer commands are not thread-safe they are only
> called on the main context and QEMU performs the cleanup in three steps
> to prevent a use-after-free scenario where the guest can access the
> region after it’s unmapped:
> 
> 1. From the main context, the region’s field finish_unmapping is false
>     by default, so it sets a variable cmd_suspended, increases the
>     renderer_blocked variable, deletes the blob subregion, and unparents
>     the blob subregion causing its reference count to decrement.
> 
> 2. From an RCU context, the MemoryView gets freed, the FlatView gets
>     recalculated, the free callback of the blob region
>     virtio_gpu_virgl_hostmem_region_free is called which sets the
>     region’s field finish_unmapping to true, allowing the main thread
>     context to finish replying to the command
> 
> 3. From the main context, the command is processed again, but this time
>     finish_unmapping is true, so virgl_renderer_resource_unmap can be
>     called and a response is sent to the guest.
> 
> It happens so that under TCG, if the guest has no timers configured (and
> thus no interrupt will cause the CPU to exit), the RCU thread does not
> have enough time to grab the locks and recalculate the FlatView.
> 
> That’s not a big problem in practice since most guests will assume a
> response will happen later in time and go on to do different things,
> potentially triggering interrupts and allowing the RCU context to run.
> If the guest waits for the unmap command to complete though, it blocks
> indefinitely. Attaching to the QEMU monitor and force quitting the guest
> allows the cleanup to continue.
> 
> There's no reason why the FlatView recalculation can't occur right away
> when we delete the blob subregion, however. It does not, because when we
> create the subregion we set the object as its own parent:
> 
>      memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> 
> The extra reference is what prevents freeing the memory region object in
> the memory transaction of deleting the subregion.
> 
> This commit changes the owner object to the device, which removes the
> extra owner reference in the memory region and causes the MR to be
> freed right away in the main context.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20250410122643.1747913-3-manos.pitsidianakis@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>   hw/display/virtio-gpu-virgl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 71a7500de9..8fbe4e70cc 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -112,7 +112,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>       vmr->g = g;
>       mr = g_new0(MemoryRegion, 1);
>   
> -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> +    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
>       memory_region_add_subregion(&b->hostmem, offset, mr);
>       memory_region_set_enabled(mr, true);
>   

I suggest dropping this patch for now due to the reason I pointed out 
for the first version of this series.

