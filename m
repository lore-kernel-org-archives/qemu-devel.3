Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4677AD43367
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 03:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTtlq-0007VC-E1; Thu, 11 Dec 2025 22:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vTtll-0007Ue-PM
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 22:24:39 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vTtli-0001wc-Bj
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 22:24:37 -0500
Received: from [10.200.7.128] (p99249-ipoefx.ipoe.ocn.ne.jp [153.246.134.248])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BC3O1JF023345
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 12 Dec 2025 12:24:05 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=fjQTBQwyfZoKmkfgZgmdaThOu1EiOKUNUzjNv3/L1iA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1765509845; v=1;
 b=HuvDPvT9PDeVuwkisE1m8Pklaa6+sgz8Hgk2ntGqmcETgaTUQjhcep8v6nSP1WSY
 3O0zYEW6+8L3T8ou44rwByqckmQmAlHNU4OpCn1zq/4ZIDlpmJuzUYO8e6p8AMl1
 S//EmJL4dIn15onAS16pZRmuxu8fgtoJtXWivP/wSagokGNSBHjWsvzER8UwyGb3
 dg761fcBfHjmDYXmKge2S5PFO4olVTw0Xh9+GQZjiIGtpw6dRCCKGfKUei9J85X4
 t5elydFAYSVaSfPIN9RyUGqYvlv0R/jmbZtSNz/QrKjfQQIq7Anuf7hGn5HAwdZb
 xfE8FFUUAFfoBgYzW3bS2g==
Message-ID: <da19ffdc-b357-4494-aeba-7d1f6aeb8ce3@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 12 Dec 2025 12:24:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu: create drm fd based on specified render node
 path
To: "Irshad, Luqmaan" <Luqmaan.Irshad@amd.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Honglei Huang <honghuan@amd.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "luckmaan21@gmail.com" <luckmaan21@gmail.com>
References: <20251205184906.110927-1-luirshad@amd.com>
 <06bd2abd-e554-4ec8-8ffb-256d33af95c0@collabora.com>
 <56728682-8ab9-498e-acc5-c31ba83642fc@rsg.ci.i.u-tokyo.ac.jp>
 <BL4PR12MB94840D89E2584BA81151D5189DA1A@BL4PR12MB9484.namprd12.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <BL4PR12MB94840D89E2584BA81151D5189DA1A@BL4PR12MB9484.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/12/12 1:30, Irshad, Luqmaan wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]

Your keep sending message with this "Internal Distribution Only" mark. 
Can you remove it? Perhaps you may ask Honglei Huang, who is also from 
AMD and work on virtio-gpu/QEMU.

> 
> Hello Akihiko,
> 
> I just had a brief conversation with Pierre-Eric, and I believe the use case is slightly different than the one described.  For virgl, selecting using DRI_PRIME only would suffice because QEMU and VirGL (both using OpenGL), both rely on the driver to pickup the GPU.

DRI_PRIME is used for EGL, not OpenGL. EGL is agnostic to rendering APIs 
so it works for Vulkan too.

> 
> For Native context however (this case) there is no GL driver use from virglrenderer side, which is why we inform virglrenderer using the callback functions instead.

Now I understand the problem you are facing; virglrenderer does not 
respect the EGL display for DRM native context, which is the problem 
that needs to be fixed; adding another callback function only works 
around it.

Fortunately, there is EXT_device_drm_render_node, an EGL extension that 
allows virglrenderer to query the underlying render node from the EGL 
display, which can be used for DRM native context:
https://registry.khronos.org/EGL/extensions/EXT/EGL_EXT_device_drm_render_node.txt

Consuming the EGL display, you can exploit the render-API-agnostic 
nature of EGL and ensure DRM native context will work consistently with 
VirGL and Venus. virglrenderer will be able to use the appropriate 
render node chosen by Mesa, and if you want to choose a render node by 
your own, you will be able to use the rendernode property of headless 
displays or DRI_PRIME for the other displays; no need to set another 
property for virtio-gpu.

Using EXT_device_drm_render_node on the virglrenderer side may also 
benefit other VMMs that use virglrenderer.

Regards,
Akihiko Odaki

> 
> Sincerely,
> 
> Luq
> 
> ________________________________
> From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Sent: Thursday, December 11, 2025 9:19:22 a.m.
> To: Dmitry Osipenko <dmitry.osipenko@collabora.com>; Irshad, Luqmaan <Luqmaan.Irshad@amd.com>; qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> Cc: mst@redhat.com <mst@redhat.com>; alex.bennee@linaro.org <alex.bennee@linaro.org>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>; luckmaan21@gmail.com <luckmaan21@gmail.com>
> Subject: Re: [PATCH] virtio-gpu: create drm fd based on specified render node path
> 
> On 2025/12/08 9:49, Dmitry Osipenko wrote:
>> Hi,
>>
>> On 12/5/25 21:49, Luqmaan Irshad wrote:
>>> Added a special callback function called virtio_get_drm_fd to create
>>> a render node based on the path specified by the user via QEMU command
>>> line.  This function is called during the virglrenderer callback sequence
>>> where we specify the get_drm_fd function pointer to call back our
>>> new function, allowing us to pass the fd of our created render node.
> 
> I guess what you need can be achieved by specifying a render node for
> the display. Headless displays (egl-headless and dbus) has the
> rendernode property for this. For the other displays, Mesa should choose
> an appropriate render node, and it can be overridden with the DRI_PRIME
> environment variable:
> https://docs.mesa3d.org/envvars.html#envvar-DRI_PRIME
> 
>>>
>>> Based-on: 20251116125641.2255794-1-dmitry.osipenko@collabora.com
>>>
>>> Signed-off-by: Luqmaan Irshad <luirshad@amd.com>
>>> ---
>>>    hw/display/virtio-gpu-gl.c     |  4 ++++
>>>    hw/display/virtio-gpu-virgl.c  | 17 ++++++++++++++++-
>>>    include/hw/virtio/virtio-gpu.h |  1 +
>>>    3 files changed, 21 insertions(+), 1 deletion(-)
>>
>> Do you think it could be possible and worthwhile to make QEMU's EGL
>> display to use same GPU as virgl automatically? I.e. we tell QEMU/EGL
>> which GPU to use and then virgl will use same DRM device that backs EGL.
> 
> As far as I understand, it is already ensured that virgl uses the EGL
> display QEMU uses, and I think that what you want. Opening a different
> render node and passing the node to virglrenderer breaks it.
> 
> Regards,
> Akihiko Odaki
> 
> 


