Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2092AC982D4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 16:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgmWp-0000rB-1F; Fri, 16 Jan 2026 11:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgmWc-0000nh-I8
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 11:18:14 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgmWa-0005Sw-GB
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 11:18:14 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60GGGinu010611
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 17 Jan 2026 01:17:12 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=u9pVgkMP4NgwsmM9D/ByUQ6Jj7PVyDSQvI4cyQB1oL4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1768580232; v=1;
 b=NKlSTV/ZtReH6WHtOLpBHdbcwiV+08SHKiQxtTBfP8NcNmNBc8YJM4Ak644uA8hC
 V3W16WtE7wKZ6KjdujdnkyDichX3C89be0sqTdQt1+aRIUdrF82VSNnsWeMsXnic
 LekqmRomMxr4Or0G//YDqcl2hLU+ajMx5Y6WWeUXriC02MIfZVwDcqcejzlUvEdE
 V8urZXphGPSE3wOkbgRgTxRJEB0eprFHm0Myf6eqXD77p2gP/G78M2eMBYmCM6+G
 bX0AVeQfwzimdDBVsE4X/HzjF7wTBOv3uxyQ7fbSav35IsfJ2TSU+FnmVyz8iDKJ
 f7wDKh1QvtUh2g3iKEVZmg==
Message-ID: <8096931e-65cd-492e-b26f-ec439bd8ac0e@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 17 Jan 2026 01:17:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 4/5] virtio-gpu: Destroy virgl resources on
 virtio-gpu reset
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yiwei Zhang <zzyiwei@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>,
 Rob Clark <robdclark@gmail.com>, Robert Beckett <bob.beckett@collabora.com>
References: <20260112225246.3526313-1-dmitry.osipenko@collabora.com>
 <20260112225246.3526313-5-dmitry.osipenko@collabora.com>
 <98a2cbaa-582d-43bf-b59a-7a0e75c486d5@rsg.ci.i.u-tokyo.ac.jp>
 <a00c0a85-be88-449f-bdde-0f49ebc0a7f9@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <a00c0a85-be88-449f-bdde-0f49ebc0a7f9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/01/16 22:08, Dmitry Osipenko wrote:
> On 1/13/26 07:47, Akihiko Odaki wrote:
>>> +void virtio_gpu_virgl_resource_destroy(VirtIOGPU *g,
>>> +                                       struct
>>> virtio_gpu_simple_resource *base,
>>> +                                       Error **errp)
>>
>> An error reporting rule described in include/qapi/error.h requires
>> functions that use Error to return a value indicating success or failure.
>>
>> For this particular case, I think it can simply return what
>> virtio_gpu_virgl_resource_unref() returns, without having errp.
> 
> The error reporting arg is added here because resource_destroy()
> callback of VirtIOGPUClass requires it:
> 
> ```
> vgc->resource_destroy = virtio_gpu_virgl_resource_destroy;
> ```

I missed that line. That is my fault.

> 
> The include/qapi/error.h says "Whenever practical, also return a value
> that indicates success / failure". Hence, the returned value is optional.
> 
> I don't quite see how errp can be avoided.
> 
> Perhaps you're meaning to add virtio_gpu_gl_resource_destroy() that will
> be local to virtio-gpu-gl.c. Will change this in v10, otherwise please
> clarify more your suggestion.

Let's keep this way. The error handling infrastructure intentionally 
allows to specify NULL when you don't care the error, so we don't need 
another function to dismiss the error.

