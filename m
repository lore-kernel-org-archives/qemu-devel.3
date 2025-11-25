Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD40CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 06:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNmQy-0001rf-JG; Tue, 25 Nov 2025 01:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vNmQv-0001qy-KC
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:21:49 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vNmQq-00035w-U8
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:21:48 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AP6LBND004818
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 25 Nov 2025 15:21:11 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=oBXA/r4zdXuNyo4es7iSOIz7EbFYy5vbyeBDMOUh9xE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1764051671; v=1;
 b=HZ/hLqNP4AXbjb2ZGE+T6LQOSvF/HsjiJEBNLrxASzCs48cQiZN18aJyA7I8R4dk
 RrSUDV307yasLBImn0JLPxLae1ep0Lh8Yg48JUhSJz/mWq7Nepzx12QDsQ4U7NLk
 4BbVN8dB7iW3b6aPiL4WVOiOipG38Iicqtz9Yce4k8UShXPQZs6jQfDbR/ooZOez
 5V3jo443pPzOU35vPPJplIozF2i0N5nra39JSBc4cyt29aETbYw+RXXvpV5MVoeH
 yl9fe7HTfNVcIFWFvnxULwh/DxQh+dmxchhOHa5UyH02q6aApvEtK1LGVORtacJS
 Ruk9ZP5PHO5PfdMH36WUUQ==
Message-ID: <d88cc89b-d796-4bc4-8c90-07da3b88cc7f@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 25 Nov 2025 15:21:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 5/7] virtio-gpu: Destroy virgl resources on
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
References: <20251120040632.4036204-1-dmitry.osipenko@collabora.com>
 <20251120040632.4036204-6-dmitry.osipenko@collabora.com>
 <94e92cb0-3e5a-48e3-bf3c-12d27c23c27f@rsg.ci.i.u-tokyo.ac.jp>
 <00064b47-ca94-4eb9-a443-bb2739ed885a@collabora.com>
 <2207c76d-a800-45e5-9acc-66e9d4cfa089@collabora.com>
 <09912e84-3db8-40b2-acdc-1ca62f861b85@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <09912e84-3db8-40b2-acdc-1ca62f861b85@collabora.com>
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

On 2025/11/25 6:54, Dmitry Osipenko wrote:
> On 11/20/25 18:02, Dmitry Osipenko wrote:
>> On 11/20/25 17:54, Dmitry Osipenko wrote:
>>> On 11/20/25 08:07, Akihiko Odaki wrote:
>>>>> +int virtio_gpu_virgl_reset(VirtIOGPU *g)
>>>>>    {
>>>>> +    struct virtio_gpu_simple_resource *res, *tmp;
>>>>> +
>>>>> +    QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
>>>>> +        virtio_gpu_virgl_resource_destroy(g, res, NULL);
>>>>> +    }
>>>>> +
>>>>> +    if (!QTAILQ_EMPTY(&g->reslist)) {
>>>>> +        error_report("failed to reset virgl resources");
>>>>> +        return -1;
>>>>
>>>> It shouldn't report an error if suspended.
>>>
>>> Could you please expand on what you're meaning by "suspended"?
>>>
>>> Suppose you're talking about guest's kernel suspension. There was a
>>> discussion on [1] RE a need to use `x-pcie-pm-no-soft-reset=true` option
>>> to avoid virtio-gpu resetting across S3 suspend-resume. This option
>>> works with virtio-vga, but not with virtio-vga-gl device where VM hangs
>>> on startup. So currently S3 doesn't work for virgl and needs further fixing.
>>>
>>> [1]
>>> https://lore.kernel.org/dri-devel/20250924194755.1265531-1-dongwon.kim@intel.com/
>>
>> Correction: `x-pcie-pm-no-soft-reset=true` works with virgl without
>> enabled hostmem. It's hostmem that doesn't work with the additional PCI bus.

No, I meant that virtio_gpu_virgl_resource_unref() may set 
*cmd_suspended true. If that happens, QTAILQ_EMPTY(&g->reslist) will be 
false, but it is fine so no error log should be emitted.

> 
> I'll add a clarifying comment to the code in v4 telling that virgl shall
> not be reset at runtime.

It is confusing what "runtime" refers to. This code doesn't care about 
S3 so such a comment shouldn't be necessary.

Regards,
Akihiko Odaki

