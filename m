Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521D1C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 12:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s52ty-0002A2-Qv; Thu, 09 May 2024 08:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s52tv-00029f-Lx
 for qemu-devel@nongnu.org; Thu, 09 May 2024 08:29:32 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s52tt-0006C8-GZ
 for qemu-devel@nongnu.org; Thu, 09 May 2024 08:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715257763;
 bh=qn6h4FrjvgbyJKON+1eyO0aA0YCNOuUvhRDlvIbmTRs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=d7G5MO1y9yEJ8F6pjnN052iA/8UwyU7+iPP7VPtQwqjVQH16nuEjXrElvC5mtqHKp
 YHlGZShhjWqCHXFOH3nOBTE1+IfNb8Bp+DFAB6eVrorYdqYID+dfNC02D7JbXZG7ce
 QHwseHlmxjpVpJCN2ZePUj8h36wl4M/QhAqvjDafAEUFpAQb2Sl3xPr3FBL1t3kima
 ETYUMY27WUXlhwHSZ8aJU62sMWMQ0o/IVEAVEmGpoyb3UrXucMUPH7d8D/UUlQJ+Ot
 NuRbzVSk+yT7ZDp3it6I1rlrX81MCQ7QOSxbqLM2opqycYUSoLtYZMq8MPQRvjsr94
 Nk6VITR1B31jA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9A3F037810EF;
 Thu,  9 May 2024 12:29:21 +0000 (UTC)
Message-ID: <1847a882-2199-4d1b-b86a-832a9d33d283@collabora.com>
Date: Thu, 9 May 2024 15:29:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/11] virtio-gpu: Handle resource blob commands
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240418190040.1110210-1-dmitry.osipenko@collabora.com>
 <20240418190040.1110210-9-dmitry.osipenko@collabora.com>
 <2c5a0b2e-58ef-4766-baea-5df98fa6fc2f@daynix.com>
 <51b45c53-b7d3-4f3c-984c-44a94e6cf5af@collabora.com>
 <a0808d93-fb2c-4663-bd5b-8ae06e813492@daynix.com>
 <b4d78255-cc83-482b-a9f6-781c1b795ee9@collabora.com>
 <48d03070-6002-4953-aa09-47ae72b8f291@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <48d03070-6002-4953-aa09-47ae72b8f291@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/5/24 09:47, Akihiko Odaki wrote:
> On 2024/05/02 4:20, Dmitry Osipenko wrote:
>> On 4/27/24 08:52, Akihiko Odaki wrote:
>>> On 2024/04/24 19:30, Dmitry Osipenko wrote:
>>>> On 4/19/24 12:18, Akihiko Odaki wrote:
>>>>>> @@ -61,6 +61,10 @@ struct virtio_gpu_simple_resource {
>>>>>>         int dmabuf_fd;
>>>>>>         uint8_t *remapped;
>>>>>>     +    MemoryRegion *mr;
>>>>>> +    bool async_unmap_completed;
>>>>>> +    bool async_unmap_in_progress;
>>>>>> +
>>>>>
>>>>> Don't add fields to virtio_gpu_simple_resource but instead create a
>>>>> struct that embeds virtio_gpu_simple_resource in virtio-gpu-virgl.c.
>>>>
>>>> Please give a justification. I'd rather rename
>>>> virtio_gpu_simple_resource s/_simple//. Simple resource already
>>>> supports
>>>> blob and the added fields are directly related to the blob. Don't see
>>>> why another struct is needed.
>>>>
>>>
>>> Because mapping is only implemented in virtio-gpu-gl while blob itself
>>> is implemented also in virtio-gpu.
>>
>> Rutubaga maps blobs and it should do unmapping blobs asynchronously as
>> well, AFAICT.
>>
> 
> Right. It makes sense to put mr in struct virtio_gpu_simple_resource in
> preparation for such a situation.
> 
> Based on this discussion, I think it is fine to put mr either in struct
> virtio_gpu_simple_resource or a distinct struct. However if you put mr
> in struct virtio_gpu_simple_resource, the logic that manages
> MemoryRegion should also be moved to virtio-gpu.c for consistency.

Rutabaga uses static MRs. It will either need a different workaround or
will have to move to dynamic MRs. I'll keep using distinct struct for now.

AFAICT, its a lesser problem for rutabaga because static MR isn't
subjected to the dynamic MR UAF problem that virgl has. On the other
hand, rutabaga is re-initing already inited static MR object on each new
mapping, that looks like a bug and it will need to move to dynamic MRs.

-- 
Best regards,
Dmitry


