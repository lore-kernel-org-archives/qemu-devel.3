Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224CBC27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 16:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEtWK-0005wV-UG; Wed, 05 Jun 2024 12:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sEtWJ-0005wB-Ei
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:29:51 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sEtWH-00074y-2I
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1717604985;
 bh=4VQ0aV5mhu56XhNk9fFYU1vu46Ez9YWFR0pRCXisW0g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=M20gVdRYNHPIRQGe5oOpK1td6llU9OXWId5YLRR8NTx/Nt5hQW60d2Pz9wWnZohuA
 g4ue7SBpcgQt8ANQC7U1gRJlxeUtlcwLgR/5HTpQeXHYdzONT/Wn9jZedKa5kwLuzB
 jgTHKjLBkugZfVkuQGeyVKQ++Sisa1CQD7dCgQWXYo6P3Ziuuo2dQbKwHGnhZxRFxx
 kCZjhNk9Wt9wq0PpZHFLEYCRQ2SbtleUsnuWyqwAXwEGHhmyj+vWTIWGGOwcexWoOH
 UZilbK86/h+1cM+p2OHcVAJSj3ZjO59Zw/QnLDbTqTXuCJzEpHejXBLE9seX6OROxu
 4yETI8VAaHxmg==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8371E378065F;
 Wed,  5 Jun 2024 16:29:43 +0000 (UTC)
Message-ID: <159a69c9-11b6-4240-b3c9-b5b8f50bb441@collabora.com>
Date: Wed, 5 Jun 2024 19:29:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/13] Support blob memory and venus on qemu
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
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
 <87o78zi9wb.fsf@draig.linaro.org> <87jzjni569.fsf@draig.linaro.org>
 <f7b1d066-4636-49b0-b921-ea01b20b2c00@collabora.com>
 <874jaqi5m0.fsf@draig.linaro.org>
 <6bc5a3fc-8fbc-4449-a5e6-cd654655be35@collabora.com>
 <874ja7fnut.fsf@draig.linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <874ja7fnut.fsf@draig.linaro.org>
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

On 6/5/24 17:47, Alex Bennée wrote:
....
> I'm guessing some sort of resource leak, if I run vkcube-wayland in the
> guest it complains about being stuck on a fence with the iterator going
> up. However on the host I see:
> 
>   virtio_gpu_fence_ctrl fence 0x13f1, type 0x207
>   virtio_gpu_fence_ctrl fence 0x13f2, type 0x207
>   virtio_gpu_fence_resp fence 0x13f1
>   virtio_gpu_fence_resp fence 0x13f2
>   virtio_gpu_fence_ctrl fence 0x13f3, type 0x207
>   virtio_gpu_fence_ctrl fence 0x13f4, type 0x207
>   virtio_gpu_fence_resp fence 0x13f3
>   virtio_gpu_fence_resp fence 0x13f4
>   virtio_gpu_fence_ctrl fence 0x13f5, type 0x207
>   virtio_gpu_fence_ctrl fence 0x13f6, type 0x207
>   virtio_gpu_fence_resp fence 0x13f5
>   virtio_gpu_fence_resp fence 0x13f6
>   virtio_gpu_fence_ctrl fence 0x13f7, type 0x207
>   virtio_gpu_fence_ctrl fence 0x13f8, type 0x207
>   virtio_gpu_fence_resp fence 0x13f7
>   virtio_gpu_fence_resp fence 0x13f8
>   virtio_gpu_fence_ctrl fence 0x13f9, type 0x204
>   virtio_gpu_fence_resp fence 0x13f9
> 
> which looks like its going ok. However when I git Ctrl-C in the guest it
> kills QEMU:
> 
>   virtio_gpu_fence_ctrl fence 0x13fc, type 0x207
>   virtio_gpu_fence_ctrl fence 0x13fd, type 0x207
>   virtio_gpu_fence_ctrl fence 0x13fe, type 0x204
>   virtio_gpu_fence_ctrl fence 0x13ff, type 0x207
>   virtio_gpu_fence_ctrl fence 0x1400, type 0x207
>   virtio_gpu_fence_resp fence 0x13fc
>   virtio_gpu_fence_resp fence 0x13fd
>   virtio_gpu_fence_resp fence 0x13fe
>   virtio_gpu_fence_resp fence 0x13ff
>   virtio_gpu_fence_resp fence 0x1400
>   qemu-system-aarch64: ../../subprojects/virglrenderer/src/virglrenderer.c:1282: virgl_renderer_resource_unmap: Assertion `!ret' failed.
>   fish: Job 1, './qemu-system-aarch64 \' terminated by signal     -machine type=virt,virtuali… (    -cpu neoverse-n1 \)
>   fish: Job     -smp 4 \, '    -accel tcg \' terminated by signal     -device virtio-net-pci,netd… (    -device virtio-scsi-pci \)
>   fish: Job     -device scsi-hd,drive=hd \, '    -netdev user,id=unet,hostfw…' terminated by signal     -blockdev driver=raw,node-n… (    -serial mon:stdio \)
>   fish: Job     -blockdev node-name=rom,dri…, '    -blockdev node-name=efivars…' terminated by signal     -m 8192 \ (    -object memory-backend-memf…)
>   fish: Job     -device virtio-gpu-gl-pci,h…, '    -display sdl,gl=on,show-cur…' terminated by signal     -device qemu-xhci -device u… (    -kernel /home/alex/lsrc/lin…)
>   fish: Job     -d guest_errors,unimp,trace…, 'SIGABRT' terminated by signal Abort ()
> 
> The backtrace (and the 18G size of the core file!) indicates a leak:

The unmap debug-assert tells that BO wasn't mapped because mapping
failed, likely due to OOM. You won't hit this abort with a release build
of libvirglrenderer. The leak likely happens due to unsignalled fence.

Please try to run vkcube with disabled fence-feedback feature:

 # VN_PERF_NO_FENCE_FEEDBACK=1 vkcube-wayland

It fixes hang for me. We had problems with combination of this Venus
optimization feature + Intel ANV driver for a long time and hoped that
it's fixed by now, apparently the issue was only masked.

-- 
Best regards,
Dmitry


