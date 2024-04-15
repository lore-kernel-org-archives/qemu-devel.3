Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3AAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 08:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwHJP-0000Xc-Tv; Mon, 15 Apr 2024 04:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rwHJC-0000X4-M3
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 04:03:24 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rwHJ8-0000OM-5E
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 04:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1713168194;
 bh=s9LtQ6PntmmMwnWOhdAl2IohReYw1Qb3zV6oh+AuaVg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Qz0XMyF8yEChezBSko3Av3V+ExNLk9akPkPeRg2AyFQE+1qkZDPPMhYyHqeIwbcef
 j/m/meGLuz77X6Y2P2VTO8YYy+L2HruTbRnWyBUlEiG9DseGTQLcnxyGiQxnuJVsUQ
 QZ1/7QJOEjFzX8/fAXCD7kjpB/7Tn7x2AI66kzRcghH/2y6pqXCEb86VeoJNO6q6Ly
 fWP8bY5GtsJkDz4W2ooar2Yq95ikc8HanYaYoWfc8T5SX2lpeOW3r3QSXlRkSg3xec
 Eq5dNjhG310SwQ5LwdFDLGj641l2fFnmCtcawKHPA1GZ2BO8jNtWs4mraYAJ+vedwP
 mpVxg571EOoSA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5F69F3780894;
 Mon, 15 Apr 2024 08:03:12 +0000 (UTC)
Message-ID: <918fb26b-72e9-446a-841b-810eb983dabe@collabora.com>
Date: Mon, 15 Apr 2024 11:03:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] virtio-gpu: Handle resource blob commands
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
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20240411102002.240536-1-dmitry.osipenko@collabora.com>
 <20240411102002.240536-8-dmitry.osipenko@collabora.com>
 <29a55f63-593e-46d0-8dfe-f55e2b2de7ac@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <29a55f63-593e-46d0-8dfe-f55e2b2de7ac@daynix.com>
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

Hello,

On 4/13/24 14:57, Akihiko Odaki wrote:
...
>> +static void
>> +virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>> +                                     struct
>> virtio_gpu_simple_resource *res)
>> +{
>> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
>> +
>> +    if (!res->mr) {
>> +        return;
>> +    }
>> +
>> +    memory_region_set_enabled(res->mr, false);
>> +    memory_region_del_subregion(&b->hostmem, res->mr);
>> +
>> +    /* memory region owns res->mr object and frees it when mr is
>> released */
>> +    res->mr = NULL;
>> +
>> +    virgl_renderer_resource_unmap(res->resource_id);
> 
> Hi,
> 
> First, thanks for keeping working on this.
> 
> This patch has some changes since the previous version, but it is still
> vulnerable to the race condition pointed out. The memory region is
> asynchronously unmapped from the guest address space, but the backing
> memory on the host address space is unmapped synchronously before that.
> This results in use-after-free. The whole unmapping operation needs to
> be implemented in an asynchronous manner.

Thanks for the clarification! I missed this point from the previous
discussion.

Could you please clarify what do you mean by the "asynchronous manner"?
Virglrenderer API works only in the virtio-gpu-gl context, it can't be
accessed from other places.

The memory_region_del_subregion() should remove the region as long as
nobody references it, isn't it? On Linux guest nobody should reference
hostmem regions besides virtio-gpu device on the unmap, don't know about
other guests.

We can claim it a guest's fault if MR lives after the deletion and in
that case exit Qemu with a noisy error msg or leak resource. WDYT?

-- 
Best regards,
Dmitry


