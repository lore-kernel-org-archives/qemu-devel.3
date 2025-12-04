Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14BAD1CDC2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 03:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQzgk-0001b8-V5; Wed, 03 Dec 2025 22:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vQzgg-0001an-Ku
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 22:07:22 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vQzgb-00017X-08
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 22:07:21 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5B436V6X059145
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Dec 2025 12:07:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=2E98TME7/rrLRRFciN2V8YfyAoGDDq1HrvHKi8ttB7c=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1764817624; v=1;
 b=v1NcpkiwyM7a4Jji6fx6cJ7DVogASbrFoXAYKLsAA90z20p9UkTMEgMjDGwHDidu
 kcv/3lrouroJVg4BOIWEy1GfCXh775+E6GJYq0L03eTX2G02rLzfmDFJIfyyJixp
 OcAJKbM0LFTtIJDb/fYldcXRhHHhs2N5pX1yvGKdd45VXcIU18f61Yfcki+YZCri
 766R42X+0LsyygLRsBrTBsamOpZDO6xXs4swMXr2DHCmA9BpfrqtarQApFIyuCc3
 3eYwGy/MMUXbQSRVNLxqcadHFMzll1ATC6DI27p65oTcn6vgIPF/Z+PinXYBAI1l
 kyDlbPvVgiTOIxKVNHE0Bw==
Message-ID: <7ffdd7cc-fd55-4f4f-b28b-eca45702c8d2@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 4 Dec 2025 12:06:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/7] virtio-gpu-virgl: support scanout of Metal
 textures
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-6-j@getutm.app>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251203040754.94487-6-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/12/03 13:07, Joelle van Dyne wrote:
> When supported, virglrenderer will return a MTLTexture handle that can be
> directly used for scanout.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   meson.build                   |  4 ++++
>   include/ui/console.h          |  2 ++
>   hw/display/virtio-gpu-virgl.c | 12 +++++++++++-
>   hw/display/virtio-gpu.c       |  2 ++
>   4 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index d9293294d8..05bad66376 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -832,6 +832,7 @@ version_res = []
>   coref = []
>   iokit = []
>   pvg = not_found
> +metal = not_found
>   emulator_link_args = []
>   midl = not_found
>   widl = not_found
> @@ -859,6 +860,7 @@ elif host_os == 'darwin'
>     host_dsosuf = '.dylib'
>     pvg = dependency('appleframeworks', modules: ['ParavirtualizedGraphics', 'Metal'],
>                      required: get_option('pvg'))
> +  metal = dependency('appleframeworks', modules: 'Metal', required: false)
>   elif host_os == 'sunos'
>     socket = [cc.find_library('socket'),
>               cc.find_library('nsl'),
> @@ -2591,6 +2593,7 @@ if xen.found()
>       ('0' + xen_version[2]).substring(-2)
>     config_host_data.set('CONFIG_XEN_CTRL_INTERFACE_VERSION', xen_ctrl_version)
>   endif
> +config_host_data.set('CONFIG_METAL', metal.found())
>   config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version()))
>   config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0])
>   config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
> @@ -4874,6 +4877,7 @@ summary(summary_info, bool_yn: true, section: 'Crypto')
>   summary_info = {}
>   if host_os == 'darwin'
>     summary_info += {'Cocoa support':           cocoa}
> +  summary_info += {'Metal support':           metal}
>   endif
>   summary_info += {'D-Bus display':     dbus_display}
>   summary_info += {'SDL support':       sdl}
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 25e45295d4..a45b524c57 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -134,12 +134,14 @@ struct QemuConsoleClass {
>   typedef enum ScanoutTextureNativeType {
>       SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
>       SCANOUT_TEXTURE_NATIVE_TYPE_D3D,
> +    SCANOUT_TEXTURE_NATIVE_TYPE_METAL,
>   } ScanoutTextureNativeType;
>   
>   typedef struct ScanoutTextureNative {
>       ScanoutTextureNativeType type;
>       union {
>           void *d3d_tex2d;
> +        void *metal_texture;
>       } u;
>   } ScanoutTextureNative;
>   
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 36c670f988..e091eb0c76 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -452,6 +452,13 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>   #if VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION >= SUPPORTED_VIRGL_INFO_EXT_VERSION
>           if (ext.version >= VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION) {
>               switch (ext.native_type) {
> +#ifdef CONFIG_METAL
> +            case VIRGL_NATIVE_HANDLE_METAL_TEXTURE: {
> +                native.type = SCANOUT_TEXTURE_NATIVE_TYPE_METAL;
> +                native.u.metal_texture = ext.native_handle;
> +                break;
> +            }
> +#endif
>               case VIRGL_NATIVE_HANDLE_NONE:
>               case VIRGL_NATIVE_HANDLE_D3D_TEX2D: {
>                   /* already handled above */
> @@ -1198,7 +1205,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>       }
>   #if VIRGL_VERSION_MAJOR >= 1
>       if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
> -        flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
> +        flags |= VIRGL_RENDERER_VENUS;
> +#ifndef CONFIG_METAL /* Metal does not support render server */
> +        flags |= VIRGL_RENDERER_RENDER_SERVER;
> +#endif
>       }
>   #endif
>   
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 43e88a4daf..9cf2c15a43 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1485,12 +1485,14 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>       VirtIOGPU *g = VIRTIO_GPU(qdev);
>   
>       if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
> +#ifndef CONFIG_METAL
>           if (!virtio_gpu_rutabaga_enabled(g->parent_obj.conf) &&
>               !virtio_gpu_virgl_enabled(g->parent_obj.conf) &&
>               !virtio_gpu_have_udmabuf()) {
>               error_setg(errp, "need rutabaga or udmabuf for blob resources");
>               return;
>           }
> +#endif

This check should be kept enabled. Blob resources cannot be created if 
none of Rutabaga, virgl or udmabuf is enabled.

Regards,
Akihiko Odaki

