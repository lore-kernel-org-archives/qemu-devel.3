Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3487FC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBObt-0006DM-Uw; Sun, 26 May 2024 20:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sBObs-00063u-12
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:53:08 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sBObp-00049m-Nm
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1716771183;
 bh=sjvyDXL9oGqZgPBndBoT4mo/86dK/pzQetbHc3lIqnk=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=ybwj4TwamfgzT5IfOj9DGRkIzZU4vASPCeENF7DNuhB1BwckHYiHpRz0SjIt2hUCK
 1Rf0q5Txg7j2J8A5rNtg0CqQFeixW33oghEG9UrEQy7OZIgbvqifkRM/QIS78nw1HS
 0Q1Kqw3HRvowdb1kI85koX/lQfNRv/75Wj0J7DLd4+Q4kDJqHkBJhnSSLomCR38pJl
 Il0xz02IKew+Ms/BiUPBo5XhxwYRnCx2iljumExhXQPC2jPGKX2NV1/rqR5oPCZ97d
 fYf4llbz94/dgeVovtbSAhSY++xx1EQyrfS0sBwtp1cmrIw2BO2cA/ummEwB8XDHaX
 vZJ0wzWho4OIA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id F2CFD378001E;
 Mon, 27 May 2024 00:53:01 +0000 (UTC)
Message-ID: <c540bd3d-72c6-487f-9f58-9d1c35630766@collabora.com>
Date: Mon, 27 May 2024 03:52:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/13] Support blob memory and venus on qemu
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
Content-Language: en-US
In-Reply-To: <6bc5a3fc-8fbc-4449-a5e6-cd654655be35@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
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

On 5/27/24 02:46, Dmitry Osipenko wrote:
> On 5/22/24 12:00, Alex Bennée wrote:
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>
>>> On 5/21/24 17:57, Alex Bennée wrote:
>>>> Alex Bennée <alex.bennee@linaro.org> writes:
>>>>
>>>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> This series enables Vulkan Venus context support on virtio-gpu.
>>>>>>
>>>>>> All virglrender and almost all Linux kernel prerequisite changes
>>>>>> needed by Venus are already in upstream. For kernel there is a pending
>>>>>> KVM patchset that fixes mapping of compound pages needed for DRM drivers
>>>>>> using TTM [1], othewrwise hostmem blob mapping will fail with a KVM error
>>>>>> from Qemu.
>>>>>>
>>>>>> [1] https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@google.com/
>>>>>>
>>>>>> You'll need to use recent Mesa version containing patch that removes
>>>>>> dependency on cross-device feature from Venus that isn't supported by
>>>>>> Qemu [2].
>>>>>>
>>>>>> [2] https://gitlab.freedesktop.org/mesa/mesa/-/commit/087e9a96d13155e26987befae78b6ccbb7ae242b
>>>>>>
>>>>>> Example Qemu cmdline that enables Venus:
>>>>>>
>>>>>>   qemu-system-x86_64 -device virtio-vga-gl,hostmem=4G,blob=true,venus=true \
>>>>>>       -machine q35,accel=kvm,memory-backend=mem1 \
>>>>>>       -object memory-backend-memfd,id=mem1,size=8G -m 8G
>>>>>
>>>>> What is the correct device for non-x86 guests? We have virtio-gpu-gl-pci
>>>>> but when doing that I get:
>>>>>
>>>>>   -device virtio-gpu-gl-pci,hostmem=4G,blob=true,venus=true
>>>>>   qemu-system-aarch64: -device virtio-gpu-gl-pci,hostmem=4G,blob=true,venus=true: opengl is not available
>>>>>
>>>>> According to 37f86af087 (virtio-gpu: move virgl realize + properties):
>>>>>
>>>>>   Drop the virgl property, the virtio-gpu-gl-device has virgl enabled no
>>>>>   matter what.  Just use virtio-gpu-device instead if you don't want
>>>>>   enable virgl and opengl.  This simplifies the logic and reduces the test
>>>>>   matrix.
>>>>>
>>>>> but that's not a good solution because that needs virtio-mmio and there
>>>>> are reasons to have a PCI device (for one thing no ambiguity about
>>>>> discovery).
>>>>
>>>> Oops my mistake forgetting:
>>>>
>>>>   --display gtk,gl=on
>>>>
>>>> Although I do see a lot of eglMakeContext failures.
>>>
>>> Please post the full Qemu cmdline you're using
>>
>> With:
>>
>>   ./qemu-system-aarch64 \
>>            -machine type=virt,virtualization=on,pflash0=rom,pflash1=efivars \
>>            -cpu neoverse-n1 \
>>            -smp 4 \
>>            -accel tcg \
>>            -device virtio-net-pci,netdev=unet \
>>            -device virtio-scsi-pci \
>>            -device scsi-hd,drive=hd \
>>            -netdev user,id=unet,hostfwd=tcp::2222-:22 \
>>            -blockdev driver=raw,node-name=hd,file.driver=host_device,file.filename=/dev/zen-ssd2/trixie-arm64,discard=unmap \
>>            -serial mon:stdio \
>>            -blockdev node-name=rom,driver=file,filename=(pwd)/pc-bios/edk2-aarch64-code.fd,read-only=true \
>>            -blockdev node-name=efivars,driver=file,filename=$HOME/images/qemu-arm64-efivars \
>>            -m 8192 \
>>            -object memory-backend-memfd,id=mem,size=8G,share=on \
>>            -device virtio-gpu-gl-pci,hostmem=4G,blob=true,venus=true \
>>            -display gtk,gl=on,show-cursor=on -vga none \
>>            -device qemu-xhci -device usb-kbd -device usb-tablet
>>
>> I get a boot up with a lot of:
>>
>>                                                                                                                                                                              
>>   (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed                                                                                                          
>>
>>   (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed                                                                                                          
>>
>>   (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed                                                                                                          
>>
>>   (qemu:1545322): Gdk-WARNING **: 09:26:09.470: eglMakeCurrent failed               
>>
>> In the guest I run:
>>
>>   meson devenv -C /root/lsrc/graphics/mesa.git/build fish
>>
>> to bring in the latest Mesa (with virtio enabled). Running vulkaninfo
>> reports two cards:
>>
>>   ==========                                                                            
>>   VULKANINFO                        
>>   ==========                                                                            
>>
>>   Vulkan Instance Version: 1.3.280                                                      
>>
>>
>>   Instance Extensions: count = 14
>>   -------------------------------
>>   VK_EXT_debug_report                    : extension revision 10
>>   VK_EXT_debug_utils                     : extension revision 2
>>   VK_EXT_headless_surface                : extension revision 1
>>   VK_KHR_device_group_creation           : extension revision 1
>>   VK_KHR_external_fence_capabilities     : extension revision 1
>>   VK_KHR_external_memory_capabilities    : extension revision 1
>>   VK_KHR_external_semaphore_capabilities : extension revision 1
>>   VK_KHR_get_physical_device_properties2 : extension revision 2
>>   VK_KHR_get_surface_capabilities2       : extension revision 1
>>   VK_KHR_portability_enumeration         : extension revision 1
>>   VK_KHR_surface                         : extension revision 25
>>   VK_KHR_surface_protected_capabilities  : extension revision 1
>>   VK_KHR_wayland_surface                 : extension revision 6
>>   VK_LUNARG_direct_driver_loading        : extension revision 1
>>
>>   Instance Layers: count = 2
>>   --------------------------
>>   VK_LAYER_MESA_device_select Linux device selection layer 1.3.211  version 1
>>   VK_LAYER_MESA_overlay       Mesa Overlay layer           1.3.211
>>   version 1
>>
>>   Devices:
>>   ========
>>   GPU0:
>>           apiVersion         = 1.3.230
>>           driverVersion      = 24.1.99
>>           vendorID           = 0x8086
>>           deviceID           = 0xa780
>>           deviceType         = PHYSICAL_DEVICE_TYPE_INTEGRATED_GPU
>>           deviceName         = Virtio-GPU Venus (Intel(R) Graphics (RPL-S))
>>           driverID           = DRIVER_ID_MESA_VENUS
>>           driverName         = venus
>>           driverInfo         = Mesa 24.2.0-devel (git-0b582449f0)
>>           conformanceVersion = 1.3.0.0
>>           deviceUUID         = 29d2e940-a1a0-3054-0f9a-9f7dec52a084
>>           driverUUID         = 3694c390-f245-612a-12ce-7d3a99127622
>>   GPU1:
>>           apiVersion         = 1.2.0
>>           driverVersion      = 24.1.99
>>           vendorID           = 0x10005
>>           deviceID           = 0x0000
>>           deviceType         = PHYSICAL_DEVICE_TYPE_CPU
>>           deviceName         = Virtio-GPU Venus (llvmpipe (LLVM 15.0.6, 256 bits))
>>           driverID           = DRIVER_ID_MESA_VENUS
>>           driverName         = venus
>>           driverInfo         = Mesa 24.2.0-devel (git-0b582449f0)
>>           conformanceVersion = 1.3.0.0
>>           deviceUUID         = 5fb5c03f-c537-f0fe-a7e6-9cd5866acb8d
>>           driverUUID         = 3694c390-f245-612a-12ce-7d3a99127622
>>
>> Running weston and then vkcube-wayland reports its selecting "GPU 0:
>> Virtio-GPU Venus (Intel(R) Graphics (RPL-S))" but otherwise produces no
>> output.
>>
>> If I run with "-display sdl,gl=on,show-cursor=on" and the same other
>> command line options the results for vulkaninfo are the same. However
>> vkcube-wayland gets a little further and draws the initial cube on the
>> screen before locking up with:
>>
>>  MESA-VIRTIO: debug: stuck in fence wait with iter at xxxx
>>
>> where xxxx grows each time it prints. On shutting down I see some virgl
>> errors interspersed with the systemd logs:
>>
>>   [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 (command 0x209)
>>   [  OK  ] Stopped systemd-logind.service - User Login Management.
>>   virtio_gpu_virgl_process_cmd: ctrl 0x209, error 0x1200
>>   [  475.257111] [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 (command 0x209)
>>   [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 (command 0x209)
>>   [  OK  ] Stopped target network-online.target - Network is Online.
>>   [  OK  ] Stopped target remote-fs.target - Remote File Systems.
>>   [  OK  ] Stopped NetworkManager-wait-online…vice - Network Manager Wait Online.
>>            Stopping avahi-daemon.service - Avahi mDNS/DNS-SD Stack...
>>            Stopping cups.service - CUPS Scheduler...
>>            Stopping user-runtime-dir@0.servic…er Runtime Directory /run/user/0...
>>   [  OK  ] Stopped avahi-daemon.service - Avahi mDNS/DNS-SD Stack.
>>   [  OK  ] Stopped cups.service - CUPS Scheduler.
>>   virtio_gpu_virgl_process_cmd: ctrl 0x209, error 0x1200
>>   [  475.357543] [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 (command 0x209)
>>   [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 (command 0x209)
>>   [  OK  ] Stopped target network.target - Network.
>>   [  OK  ] Stopped target nss-user-lookup.target - User and Group Name Lookups.
>>            Stopping NetworkManager.service - Network Manager...
>>            Stopping networking.service - Raise network interfaces...
>>            Stopping wpa_supplicant.service - WPA supplicant...
>>   [  OK  ] Stopped wpa_supplicant.service - WPA supplicant.
>>   virtio_gpu_virgl_process_cmd: ctrl 0x209, error 0x1200
>>   [  493.585261] [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 (command 0x209)
>>   [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 (command 0x209)
>>
> 
> I've reproduced this with qemu-system-aarch64. Vkcube works for a second
> and then stops, Qemu compeltely gets frozen after closing and re-running
> vkcube. Doesn't feel like this is a problem with venus, but with arm64.
> For now don't know where is the bug, will take a closer look.

Interestingly, on another try vkcube now works with no issues.

-- 
Best regards,
Dmitry


