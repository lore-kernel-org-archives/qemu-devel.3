Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F222C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 10:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzZtO-0007I4-7X; Wed, 24 Apr 2024 06:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rzZtM-0007Hl-5t
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 06:30:20 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rzZtK-00062E-7j
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 06:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1713954615;
 bh=Ed7Qh8TTuz8FwJVjHqw6PLd42KC97mNpUxPtreeK7Kg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KIb9eu1p5sKkAw6y6HGtFhghwPcrEVhrnVAVLbfQQs5zl/1V3In/jS209hMQwbfLr
 CPVuNb92mFqLCVgpNe9pQPk8POpUf5/gDc9sHXfDfNDOz7gn8A4uyyf7KTRz6uufhX
 gbRG7aLLaXlzb5MRa+dnw/VnZZqdbIHby7TOLqcrjAfkihZZ/eIzD7BB0XTlYyKt7x
 JlmqX2CoRZfIYebYcF5rLMtHYq/IfodtKy8xeWMRRo2W4uq+56MyL/RULWKz3iEpvN
 x4ij7/euYbbmuqH7h67bj552IqY7sm9EyhQGzZHzGeFJihMnA7Inf34kSAX3FYDSQF
 oUVFBXSSSeA+A==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3A9AD378000E;
 Wed, 24 Apr 2024 10:30:13 +0000 (UTC)
Message-ID: <51b45c53-b7d3-4f3c-984c-44a94e6cf5af@collabora.com>
Date: Wed, 24 Apr 2024 13:30:10 +0300
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
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <2c5a0b2e-58ef-4766-baea-5df98fa6fc2f@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
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

On 4/19/24 12:18, Akihiko Odaki wrote:
>> @@ -61,6 +61,10 @@ struct virtio_gpu_simple_resource {
>>       int dmabuf_fd;
>>       uint8_t *remapped;
>>   +    MemoryRegion *mr;
>> +    bool async_unmap_completed;
>> +    bool async_unmap_in_progress;
>> +
> 
> Don't add fields to virtio_gpu_simple_resource but instead create a
> struct that embeds virtio_gpu_simple_resource in virtio-gpu-virgl.c.

Please give a justification. I'd rather rename
virtio_gpu_simple_resource s/_simple//. Simple resource already supports
blob and the added fields are directly related to the blob. Don't see
why another struct is needed.

-- 
Best regards,
Dmitry


