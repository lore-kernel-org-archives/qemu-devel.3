Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515B6C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 16:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiyAo-0007Li-9y; Fri, 14 Feb 2025 11:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tiyAm-0007LG-Fe
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:04:12 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tiyAj-0006j7-Pz
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:04:12 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1739549033; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XInbwdX5djZV2Z0KFx8/ayhRQxXuqE5nbb1lklsvZ9h+jmNUpNGXcA9m4ViMDAA7f6azRE7ryU2XgiYAgKJL5K+MC56NcHtxFPL2U74iivswNaevzUHxRiB32s+mF8nsKsKdHJgazQC8Xdx4e96PZ1lcBDrU3+nkKCwro44EqOQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1739549033;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pNS0rqdQhnw2bYUdGhnkMFWQBOG/iqYO4P7N9z95eqQ=; 
 b=hzuvzF30EZUyHIYmzNF0cJSr55VWAx/xI3lFLWd6NuXuMmjxhHoqb3yAUDw6DkwLFh1SP/fOXMswA1UGWwAFFlIDjiUp45Lm8ZFIIjjXhOIK1aLxiNFA0njapFDmJx/+Vh4L+z+A6baBvj3atd8xROQRk2uvcRcf7/oKbL1x+ao=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739549033; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=pNS0rqdQhnw2bYUdGhnkMFWQBOG/iqYO4P7N9z95eqQ=;
 b=a3LLkHKfgGk352j/vdNgXcP2PvjD3QCsvQraX0JUB/xWxznFnoljedpOCP766Ls7
 6fzfywt19xD2TCh5T8X/IeexPuIQVOLu02u5MyFDN7AaoSHrxTkz9MIW5TfoyktFDo8
 PJJZIa1loIlyWZ8TcxpcnCMAqe/mHPzM/uVEhpN4=
Received: by mx.zohomail.com with SMTPS id 1739549031199302.96870677975323;
 Fri, 14 Feb 2025 08:03:51 -0800 (PST)
Message-ID: <f58d250d-3831-4ff1-a018-f62f9aeb2527@collabora.com>
Date: Fri, 14 Feb 2025 19:03:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Support virtio-gpu DRM native context
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <8734ggpped.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <8734ggpped.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/14/25 17:33, Alex Bennée wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
>>
>> Contarary to Virgl and Venus contexts that mediates high level GFX APIs,
>> DRM native context [1] mediates lower level kernel driver UAPI, which
>> reflects in a less CPU overhead and less/simpler code needed to support it.
>> DRM context consists of a host and guest parts that have to be implemented
>> for each GPU driver. On a guest side, DRM context presents a virtual GPU as
>> a real/native host GPU device for GL/VK applications.
>>
> <snip>
> 
> So first the good news. I can now get this up and running (x86/kvm guest
> with Intel graphics) and as far as I can tell the native context mode is
> working. With Dongwon Kim's patch the mirroring/corruption I was seeing
> is gone.
> 
> I can successfully run glmark2-wayland (although see bellow) but vkmark
> completely fails to start reporting:
> 
>   MESA: info: virtgpu backend not enabling VIRTGPU_PARAM_CREATE_FENCE_PASSING
>   MESA: info: virtgpu backend not enabling VIRTGPU_PARAM_CREATE_GUEST_HANDLE
>   MESA: error: DRM_IOCTL_VIRTGPU_GET_CAPS failed with Invalid argument
>   MESA: error: DRM_IOCTL_VIRTGPU_CONTEXT_INIT failed with Invalid argument, continuing without context...
>   MESA: error: DRM_VIRTGPU_RESOURCE_CREATE_BLOB failed with No space left on device
>   MESA: error: Failed to create virtgpu AddressSpaceStream
>   MESA: error: vulkan: Failed to get host connection
>   MESA: error: DRM_VIRTGPU_RESOURCE_CREATE_BLOB failed with No space left on device
>   MESA: error: Failed to create virtgpu AddressSpaceStream
>   MESA: error: vulkan: Failed to get host connection
>   MESA: error: DRM_VIRTGPU_RESOURCE_CREATE_BLOB failed with No space left on device
>   MESA: error: Failed to create virtgpu AddressSpaceStream
>   MESA: error: vulkan: Failed to get host connection
>   MESA: warning: ../src/gfxstream/guest/vulkan/gfxstream_vk_device.cpp:681: VK_ERROR_DEVICE_LOST
>   MESA: error: DRM_VIRTGPU_RESOURCE_CREATE_BLOB failed with No space left on device
>   MESA: error: Failed to create virtgpu AddressSpaceStream
>   MESA: error: vulkan: Failed to get host connection
>   MESA: warning: ../src/gfxstream/guest/vulkan/gfxstream_vk_device.cpp:332: VK_ERROR_DEVICE_LOST
>   === Physical Device 0 ===
>       Vendor ID:      0x8086
>       Device ID:      0xA780
>       Device Name:    Intel(R) Graphics (RPL-S)
>       Driver Version: 101068899
>       Device UUID:    b39e1cf39b101489e3c6039406f78d6c
> 
> I was booting with 4G of shared memory.

Thanks for the testing.

I assume all these errors are generated by the failing gfxstream. Hence,
may ignore them since you don't have enabled gfxstream.

> Later versions of vkmark (2025.01) fail due to missing the
> VK_KHR_display extension required as of
> https://github.com/vkmark/vkmark/commit/7c3189c6482cb84c3c0e69d6dabb9d80e0c0092a

This VK_KHR_display problem is only reproducible with your rootfs that
you shared with me. It could be a trouble with your build configs or a
buggy package version used by your rootfs build, more likely the former.

>> # Note about known performance problem in Qemu:
>>
>> DRM contexts are mapping host blobs extensively and these mapping
>> operations work slowly in Qemu. Exact reason is unknown. Mappings work
>> fast on Crosvm For DRM contexts this problem is more visible than for
>> Venus/Virgl.
> 
> And how!
> 
> With drm_native I get a lot of stutter while running and barely 100FPS
> (compared to ~8000 on pure venus). IMHO we need to figure out why there
> is such a discrepancy before merging because currently it makes more
> sense to use 
If you'd run with Xorg/Wayland directly without a DE, then it should
work okay. This should be a problem with unmapping performance that I'm
thinking about.

That unmapping problem is partially understood. Unmapping code works
correctly, but we'll need to optimize the flatview code to perform
unmapping immediately. Meanwhile, you may apply the QEMU hack below, it
should resolve most of the stutter, please let me know if it helps.

There is also a pending Mesa intel-virtio blob mapping optimization that
currently isn't available in my gitlab code, I'll refresh that feature
and then ask you to try it.

Could be that there is more to the unmapping perf issue in QEMU. I'm
investigating.

AMDGPU nctx is less affected by the bad unmapping performance. I expect
it will work well for you.



diff --git a/util/rcu.c b/util/rcu.c
index fa32c942e4bb..aac3522c323c 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -174,7 +174,7 @@ void synchronize_rcu(void)
 }


-#define RCU_CALL_MIN_SIZE        30
+#define RCU_CALL_MIN_SIZE        1

 /* Multi-producer, single-consumer queue based on urcu/static/wfqueue.h
  * from liburcu.  Note that head is only used by the consumer.
@@ -267,7 +267,7 @@ static void *call_rcu_thread(void *opaque)
          * added before synchronize_rcu() starts.
          */
         while (n == 0 || (n < RCU_CALL_MIN_SIZE && ++tries <= 5)) {
-            g_usleep(10000);
+            g_usleep(1000);
             if (n == 0) {
                 qemu_event_reset(&rcu_call_ready_event);
                 n = qatomic_read(&rcu_call_count);


-- 
Best regards,
Dmitry

