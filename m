Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B48C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 17:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKLgW-0007RJ-BI; Thu, 20 Jun 2024 13:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sKLgU-0007PX-3P
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 13:34:54 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sKLgS-0000df-0o
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 13:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1718904886;
 bh=sSwbi5Sr00dyvJujaidY8U/BQcfYOIqmpLfPY0XdX7Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WTeDItdZAts+WmVpr58sef2ojjJ7ChGk6tkvYFX7HKVmsDHVclrIbiAVw/KMt4xS9
 bA7+oieW0iQzl0epJdX5+G9mjAlGb+ELjJBXnLGPBcOh6ngkO8nCnmuKWWbRTQ4u5P
 Wu1a36MlvotMUItL42mYTfC0bQX3h53dqlrCkNAwZuuRD1bGJ2x2t6L7Sdsgwm4lzh
 jOvKuEiTnsOG3Nc7V72wfp67drgI/mGAvNHuozg2BG/SlfA27dxWL95uLPnJuAWXtp
 a+yIzijnTRfRcSGSGcP1IydF3pdYp14zWHiRYFpzZNl8AWhFTxXlVuNsxDh3CZwyxc
 mrQvZQlylll0g==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id AC52337810CD;
 Thu, 20 Jun 2024 17:34:44 +0000 (UTC)
Message-ID: <f9880609-741b-4d18-b9b0-a9b3c28c930b@collabora.com>
Date: Thu, 20 Jun 2024 20:34:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/14] Support blob memory and venus on qemu
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240616010357.2874662-1-dmitry.osipenko@collabora.com>
 <87bk3wdea9.fsf@draig.linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <87bk3wdea9.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/19/24 20:37, Alex Bennée wrote:
> So I've been experimenting with Aarch64 TCG with an Intel backend like
> this:
> 
> ./qemu-system-aarch64 \
>            -M virt -cpu cortex-a76 \
>            -device virtio-net-pci,netdev=unet \
>            -netdev user,id=unet,hostfwd=tcp::2222-:22 \
>            -m 8192 \
>            -object memory-backend-memfd,id=mem,size=8G,share=on \
>            -serial mon:stdio \
>            -kernel ~/lsrc/linux.git/builds/arm64.initramfs/arch/arm64/boot/Image \
>            -append "console=ttyAMA0" \
>            -device qemu-xhci -device usb-kbd -device usb-tablet \
>            -device virtio-gpu-gl-pci,blob=true,venus=true,hostmem=4G \
>            -display sdl,gl=on -d plugin,guest_errors,trace:virtio_gpu_cmd_res_create_blob,trace:virtio_gpu_cmd_res_back_\*,trace:virtio_gpu_cmd_res_xfer_toh_3d,trace:virtio_gpu_cmd_res_xfer_fromh_3d,trace:address_space_map 
> 
> And I've noticed a couple of things. First trying to launch vkmark to
> run a KMS mode test fails with:
> 
...
>   virgl_render_server[1875931]: vkr: failed to import resource: invalid res_id 5
>   virgl_render_server[1875931]: vkr: vkAllocateMemory resulted in CS error 
>   virgl_render_server[1875931]: vkr: ring_submit_cmd: vn_dispatch_command failed
> 
> More interestingly when shutting stuff down we see weirdness like:
> 
>   address_space_map as:0x561b48ec48c0 addr 0x1008ac4b0:18 write:1 attrs:0x1                                                                                                    
>   virgl_render_server[1875931]: vkr: destroying context 3 (vkmark) with a valid instance                                                                                       
>   virgl_render_server[1875931]: vkr: destroying device with valid objects                                                                                                      
>   vkr_context_remove_object: -7438602987017907480                                                                                                                              
>   vkr_context_remove_object: 7                                                                                                                                                 
>   vkr_context_remove_object: 5       
> 
> which indicates something has gone very wrong. I'm not super familiar
> with the memory allocation patterns but should stuff that is done as
> virtio_gpu_cmd_res_back_attach() be find-able in the list of resources?

This is expected to fail. Vkmark creates shmem virgl GBM FB BO on guest
that isn't exportable on host. AFAICT, more code changes should be
needed to support this case.

Note that "destroying device with valid objects" msg is fine, won't hurt
to silence it in Venus to avoid confusion. It will happen every time
guest application is closed without explicitly releasing every VK object.

> I tried running under RR to further debug but weirdly I can't get
> working graphics with that. I did try running under threadsan which
> complained about a potential data race:
> 
>   vkr_context_add_object: 1 -> 0x7b2c00000288
>   vkr_context_add_object: 2 -> 0x7b2c00000270
>   vkr_context_add_object: 3 -> 0x7b3800007f28
>   vkr_context_add_object: 4 -> 0x7b3800007fa0
>   vkr_context_add_object: 5 -> 0x7b48000103f8
>   vkr_context_add_object: 6 -> 0x7b48000104a0
>   vkr_context_add_object: 7 -> 0x7b4800010440
>   virtio_gpu_cmd_res_back_attach res 0x5
>   virtio_gpu_cmd_res_back_attach res 0x6
>   vkr_context_add_object: 8 -> 0x7b48000103e0
>   virgl_render_server[1751430]: vkr: failed to import resource: invalid res_id 5
>   virgl_render_server[1751430]: vkr: vkAllocateMemory resulted in CS error
>   virgl_render_server[1751430]: vkr: ring_submit_cmd: vn_dispatch_command failed
>   ==================
>   WARNING: ThreadSanitizer: data race (pid=1751256)
>     Read of size 8 at 0x7f7fa0ea9138 by main thread (mutexes: write M0):
>       #0 memcpy <null> (qemu-system-aarch64+0x41fede) (BuildId: 0bab171e77cb6782341ee3407e44af7267974025)
..
>   ==================
>   SUMMARY: ThreadSanitizer: data race (/home/alex/lsrc/qemu.git/builds/system.threadsan/qemu-system-aarch64+0x41fede) (BuildId: 0bab171e77cb6782341ee3407e44af7267974025) in __interceptor_memcpy
> 
> This could be a false positive or it could be a race between the guest
> kernel clearing memory while we are still doing
> virtio_gpu_ctrl_response.
> 
> What do you think?

The memcpy warning looks a bit suspicion, but likely is harmless. I
don't see such warning with TSAN and x86 VM.

-- 
Best regards,
Dmitry


