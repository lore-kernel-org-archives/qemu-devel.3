Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89919D41C3E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 14:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vThW5-0001zN-UZ; Thu, 11 Dec 2025 09:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vThVz-0001yP-5c
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 09:19:31 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vThVw-0003Nt-3e
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 09:19:30 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BBEIkvv023554
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 11 Dec 2025 23:19:07 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=m2s869iBlkShzk/nwHsmWGl9IthmgPEKj/hkZieFq0Y=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1765462747; v=1;
 b=iqrg3upqXTF8b0mmpj1dPPLbzICUS7Yw4LiGRcS33rI0yqV0BPlIx428rJt8adVX
 ZVrjN4tZ6IyvT5RD/aIyqGdq0HjzEFzKLFxKFOLqguBHw/CymdyxJWFpz8Q6MkLK
 +8Ma841UkOABS7yyaXS0Cqq3YsDYouu5fxwjV7Dvl479aTUI5+BCLptuN7KQUwbz
 rURWhVTmkn46nN70F9OMeoLQtUTc7+vC1G71OerniIHar0EL/R882ewuQ3W/bs9m
 VeSbSCm2U8JQaZm9F2tJivHKlrrr7UOvZLlrLPW3FCFhQtxJLVkOq5Fh4CO6uXp/
 yAWgMbeTBTSKMQzflyEl8A==
Message-ID: <56728682-8ab9-498e-acc5-c31ba83642fc@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 11 Dec 2025 23:18:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu: create drm fd based on specified render node
 path
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Luqmaan Irshad <luirshad@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, pierre-eric.pelloux-prayer@amd.com,
 luckmaan21@gmail.com
References: <20251205184906.110927-1-luirshad@amd.com>
 <06bd2abd-e554-4ec8-8ffb-256d33af95c0@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <06bd2abd-e554-4ec8-8ffb-256d33af95c0@collabora.com>
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

On 2025/12/08 9:49, Dmitry Osipenko wrote:
> Hi,
> 
> On 12/5/25 21:49, Luqmaan Irshad wrote:
>> Added a special callback function called virtio_get_drm_fd to create
>> a render node based on the path specified by the user via QEMU command
>> line.  This function is called during the virglrenderer callback sequence
>> where we specify the get_drm_fd function pointer to call back our
>> new function, allowing us to pass the fd of our created render node.

I guess what you need can be achieved by specifying a render node for 
the display. Headless displays (egl-headless and dbus) has the 
rendernode property for this. For the other displays, Mesa should choose 
an appropriate render node, and it can be overridden with the DRI_PRIME 
environment variable:
https://docs.mesa3d.org/envvars.html#envvar-DRI_PRIME

>>
>> Based-on: 20251116125641.2255794-1-dmitry.osipenko@collabora.com
>>
>> Signed-off-by: Luqmaan Irshad <luirshad@amd.com>
>> ---
>>   hw/display/virtio-gpu-gl.c     |  4 ++++
>>   hw/display/virtio-gpu-virgl.c  | 17 ++++++++++++++++-
>>   include/hw/virtio/virtio-gpu.h |  1 +
>>   3 files changed, 21 insertions(+), 1 deletion(-)
> 
> Do you think it could be possible and worthwhile to make QEMU's EGL
> display to use same GPU as virgl automatically? I.e. we tell QEMU/EGL
> which GPU to use and then virgl will use same DRM device that backs EGL.

As far as I understand, it is already ensured that virgl uses the EGL 
display QEMU uses, and I think that what you want. Opening a different 
render node and passing the node to virglrenderer breaks it.

Regards,
Akihiko Odaki

