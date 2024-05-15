Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48F6C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7IED-0002Z8-2o; Wed, 15 May 2024 13:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s7IE9-0002Vx-KV
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:15:41 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s7IDw-0004Ir-3i
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715793326;
 bh=3Aa95QguIKyPB/ffY8QK2/FAnKp1Khv8+aj6d0aF0Jg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Zpx8Raqxqp+LdWf9kjifl5/CvInN1hCFgMehLvVjJqBKf2gVRkMvoYxvUGh4h2E86
 BQz2fC0r3ViUBu0ePcnwft90XvP5SCsR3m1YadTdwosJJ32rBsWHjSwGV0oSiGrrO7
 BsoFJPhWxuL9B2POF1D3HQL8ls5Y6sVEt/84anref3aaaaieQTsFEGIgiC9yxyk3aw
 hkwmk/Pk8fs9lRCJghqQXpWi4lFc0rGllgOXYCEXKt0Qib34OysNbHkUL+F3loGbHh
 gSsLWtwOii9oHgpXqNnFAvcyvGN77TRqghvxk2ytFtCEmVo83BLmjgCx9wF6tF03EW
 ZL1/fEITd7e5w==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0EB5B3782157;
 Wed, 15 May 2024 17:15:23 +0000 (UTC)
Message-ID: <8b26ac10-40b3-4654-8123-ce07e9dff9d9@collabora.com>
Date: Wed, 15 May 2024 20:15:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/10] virtio-gpu: Handle resource blob commands
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
References: <20240511182251.1442078-1-dmitry.osipenko@collabora.com>
 <20240511182251.1442078-9-dmitry.osipenko@collabora.com>
 <727b125a-530e-4881-bde0-2215f62e155d@daynix.com>
 <4b30a810-211a-4ef6-ac28-c144615b402c@collabora.com>
 <58dfa1ce-320c-468e-9aed-fe1b092b92f8@daynix.com>
 <9c9e174d-079c-4186-8b01-95549167852c@collabora.com>
 <5b20d3dd-1749-45ba-baa7-a8c21d79f839@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <5b20d3dd-1749-45ba-baa7-a8c21d79f839@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 5/15/24 20:04, Akihiko Odaki wrote:
>>
> 
> VIRTIO_GPU_CMD_RESOURCE_UNREF should also call
> virtio_gpu_virgl_async_unmap_resource_blob(). I guess that's the
> original intention of having a function for this instead of inlining the
> content of this function to virgl_cmd_resource_unmap_blob().

Correct, previous patchset versions unmapped resource on unref.

In v11 I dropped unmapping from unref to avoid adding additional
`async_unmap_in_progress` flag because normally map/unmap will be
balanced by guest anyways.

The virtio-gpu spec doesn't tell that resource have to be implicitly
unmapped on unref. In a case of Linux guest, it actually will be a bug
to unref a mapped resource because guest will continue to map and use
the destroyed resource.

-- 
Best regards,
Dmitry


