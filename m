Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64A2C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 19:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2G0E-0007KF-AF; Wed, 01 May 2024 15:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s2G0C-0007Ju-Dy
 for qemu-devel@nongnu.org; Wed, 01 May 2024 15:52:28 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s2G0A-0000zv-Uv
 for qemu-devel@nongnu.org; Wed, 01 May 2024 15:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1714593144;
 bh=rgXCEk7E0aZlKU5fvxPriFR12/SRtJ/2EJOxMdt2j4M=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=nVVdmv8XGk6SCGVue46wKCsOyZjo89xwyFDqaPMKq6Aj+ukCTDgvH48Eq08Fov/vz
 kBk5HHt88Er9NYaF55pTtTwtbmjunK/5X8YY3ZWjPVTIpM4AVBcrP3+o7dJGkAQFXB
 orOtLdQ3PsNKHIAeM83TTSX1hO7TIVf2TAYZInFAzjayHC/YIv9LtHiWSeDMyUPQ6s
 iSxpN/Pto6XpRBbTVOAAWu+gTLASfVUBKzkziM0REEcg08mtmX9FkTWy8Aa0da37iJ
 Qx4t+3WEaSdsMrtmipVY9/odwvaTVVaYnHSKPwmfHx6J6zoJNv1Tfhyuz/sWF9V+SK
 gQEQ/+uloY4NQ==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id CB6B83780629;
 Wed,  1 May 2024 19:52:22 +0000 (UTC)
Message-ID: <25e07a71-c597-43f9-b800-dde16ecfc358@collabora.com>
Date: Wed, 1 May 2024 22:52:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/11] virtio-gpu: Register capsets dynamically
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
References: <20240425154539.2680550-1-dmitry.osipenko@collabora.com>
 <20240425154539.2680550-10-dmitry.osipenko@collabora.com>
 <557f5ddb-4326-48bc-b34e-bda9d51cadcc@daynix.com>
 <490016a8-965b-497b-9c12-5202d135407a@collabora.com>
 <66cd0301-7e92-4c0c-9dfa-fb1a4a13b607@collabora.com>
Content-Language: en-US
In-Reply-To: <66cd0301-7e92-4c0c-9dfa-fb1a4a13b607@collabora.com>
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

On 5/1/24 22:38, Dmitry Osipenko wrote:
> On 5/1/24 22:31, Dmitry Osipenko wrote:
>> On 4/27/24 10:12, Akihiko Odaki wrote:
>>>>   int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>>>>   {
>>>>       uint32_t capset2_max_ver, capset2_max_size;
>>>> +
>>>> +    if (g->capset_ids) {
>>>
>>> Move capset_ids initialization to virtio_gpu_virgl_init() to save this
>>> conditional.
>>
>> Capsets are used before virgl is inited. At first guest queries virtio
>> device features and then enables virgl only if capset is available.
>> While virgl itself is initialized when first virtio command is
>> processed. I.e. it's not possible to move to virtio_gpu_virgl_init.
> 
> Though no, capsets aren't part of device features. I'll move it to
> virtio_gpu_virgl_init, thanks.
> 

Number of capsets actually is a part of generic virtio device cfg
descriptor. Capsets initialization can't be moved without probing
capsets twice, i.e. not worthwhile.

-- 
Best regards,
Dmitry


