Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33DCE7491A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 06:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYIHG-0006EH-Tb; Wed, 24 Dec 2025 01:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vYIHE-0006Dd-Aq
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 01:23:16 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vYIHB-0003Rk-7B
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 01:23:16 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BO6MRAk086557
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Dec 2025 15:23:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5oWER0jy3mj6tIHsvNrw7P0xCDHDczgTG9lqL9VOegc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1766557380; v=1;
 b=mqc27jsYvyjHxSSRHav6W1h4ZJChB5VIBWyo5b3SCNzprblSs9f2LlLZcgN9oTzH
 sPr+fuDxDW+SdTI4c8/LvBTQ3drtZyyITd2k6z8PQ6675V0jgprpps1eyxOYgQN2
 8kKVbdJiqROvLlfUQN2JRR5ssIN6itDUF4hxMdGRYLNTHY7zj9bSTihQOAf/7uaC
 StbGFMcoRCNgOIiLSZRSDwRFBcLYo7iOyLQgi1eup+LFFURn1IF0f8HrGjfa0Q0n
 N33vWnsEmKZOv90frMx3rWN6ty92KvOiE+uEJIc7GizSAO/VcxSDK3JAt30Qi1a9
 caVVG5MzRejw/SsAqbj8wg==
Message-ID: <f246dcbd-2a13-46e8-97cb-d6959d8115dc@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 24 Dec 2025 15:22:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/7] egl-helpers: store handle to native device
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-2-j@getutm.app>
 <3a401334-700f-4b11-b006-a93470d38a66@rsg.ci.i.u-tokyo.ac.jp>
 <CA+E+eSBOEzzb-aO2B_yWtJeoK4QGvjf=pB555+GGE2U0OH=vbw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CA+E+eSBOEzzb-aO2B_yWtJeoK4QGvjf=pB555+GGE2U0OH=vbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2025/12/20 1:11, Joelle van Dyne wrote:
> On Wed, Dec 3, 2025 at 10:31 PM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2025/12/03 13:07, Joelle van Dyne wrote:
>>> Make way for other platforms by making the variable more general. Also we
>>> will be using the device in the future so let's save the pointer in the
>>> global instead of just a boolean flag.
>>>
>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>>> ---
>>>    include/ui/egl-helpers.h      | 2 +-
>>>    hw/display/virtio-gpu-virgl.c | 2 +-
>>>    ui/egl-helpers.c              | 4 ++--
>>>    3 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
>>> index acf993fcf5..c239d32317 100644
>>> --- a/include/ui/egl-helpers.h
>>> +++ b/include/ui/egl-helpers.h
>>> @@ -12,7 +12,7 @@
>>>    extern EGLDisplay *qemu_egl_display;
>>>    extern EGLConfig qemu_egl_config;
>>>    extern DisplayGLMode qemu_egl_mode;
>>> -extern bool qemu_egl_angle_d3d;
>>> +extern void *qemu_egl_angle_native_device;
>>
>> I guess ANGLE will not be relevant for Metal and leaving it will be
>> misleading.
> What is your suggestion? This is just to remove "D3D" from the
> variable name. If you want to remove "ANGLE" from the variable name as
> well, it may be misleading because this variable is only used with an
> ANGLE EGL backend.
Looking the usage of the variable in your tree, I realized this variable 
may not be necessary for this at all.

There are two use cases:

1. To determine if VIRGL_RENDERER_NATIVE_SHARE_TEXTURE needs to be set.
2. To pass the device used by ANGLE to Cocoa.

Regarding 1, virglrenderer can simply pass MTLTexture whenever the EGL 
context is backed with Metal and Venus is in use.

Although your code is modeled after the code dealing with Direct3D 
handles, the functionality of your code is quite a different from it.

Direct3D handles are used to "share" texture with other processes in a 
zero-copy manner. It is an optional hint; dbus can fall back to use 
OpenGL textures if they are missing, and the other displays just don't care.

On the other hand, MTLTexture plays an essential role in your scenario. 
There are no corresponding OpenGL texture so no fallback happens.

The difference shows that the VIRGL_RENDERER_NATIVE_SHARE_TEXTURE flag 
is useful when dealing with Direct3D handles but not with MTLTexture. 
The absence of flag tells virglrenderer that we do not need Direct3D 
handle (because the dbus display is not used), and allows it to skip 
some code to convert OpenGL textures to Direct3D handles).

On the other hand, not passing MTLTexture in your scenario does not make 
sense because it prevents the scanout at all. virglrenderer does not 
have any code that can be skipped when the flag is absent. virglrenderer 
can simply pass MTLTexture in your scenario.

2 implicitly lets ANGLE choose a device, but this can be suboptimal. 
Ideally, Cocoa should instead choose a device because it knows what 
device displays the window. Cocoa should pass the device it chose to ANGLE.

To demonstrate the point, I updated my tree to use ANGLE's Metal 
renderer for OpenGL and to pass the device from Cocoa to ANGLE:
https://github.com/akihikodaki/v/commit/8f191a7d2c225fa601c22a783c24c81a3fda47fa

By the way, I had to make a few modifications to ANGLE, Epoxy, and 
virglrenderer to fix glitches when hosting glmark2 and Firefox on GNOME. 
You can also find them with the above URL if you are interested.

Regards,
Akihiko Odaki

