Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C4FC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7I0l-0002xW-Na; Wed, 15 May 2024 13:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s7I0j-0002xI-Cl
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:01:50 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s7I0R-0007l9-Qe
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715792489;
 bh=DSHn+vg97afX3XX3guG5z3fIuluJ5IcWroMqwP7r8Bw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mUhWFoTIA20knw0ty8fmXP0MIt+0+CS1pjp068cVXEr/+myN+wgr1X4mCtImbVsat
 xx2kBh9uCz2bwRZTQ/akbIdYHL2eLrm7OzMafv3WLwweyTrZbfu3QGRoUbNEqk+yN2
 50HnySdAu2fnIAjug0CTvD7Jptho4SIcE7XtpJh3PLS9SSFr61ajW441nqfr6vqukV
 O+Mdr18tamv6ANGl+cm2Ni3+hYUk8hCoeLV2Z3X98GyCk4L12vdXmg8vLsiml6Se5S
 lnVQHuZ7LA/F4pH6FmkfafIQVQV+1kvr76oq7kJIDtJBCiQs2wf0/Cqug19rfR0nFH
 zSKDJMjBJFc0g==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id D498F3782157;
 Wed, 15 May 2024 17:01:27 +0000 (UTC)
Message-ID: <9c9e174d-079c-4186-8b01-95549167852c@collabora.com>
Date: Wed, 15 May 2024 20:01:25 +0300
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
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <58dfa1ce-320c-468e-9aed-fe1b092b92f8@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 5/15/24 19:42, Akihiko Odaki wrote:
>>> It may be better to actually implement unmapping instead of returning an
>>> error for consistency with the iov operation. Apparently crosvm also
>>> unmaps blobs with VIRTIO_GPU_CMD_RESOURCE_UNREF.
>>
>> Then I'll add back `async_unmap_in_progress` because resource can be
>> both mapped/unmapped on unref, and we'll need flag to know whether async
>> unmapping has been finished to do the final unmapping of the resource.
> 
> Such a situation should be already handled since unmapping in progress
> blocks all commands (not just VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB but
> literally all, including VIRTIO_GPU_CMD_RESOURCE_UNREF).

The async unmapping consists of 3 parts:

1. begin async unmapping with memory_region_del_subregion() and suspend
2. wait for res->mr to be freed and resume
3. finish the unmapping with final virgl_renderer_resource_unmap()

Parts 1 and 3 are handled by  virtio_gpu_virgl_async_unmap_resource_blob()


The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB is different because we know that
blob is mapped in the first place. Hence we can safely perform the part
3, assuming that parts 1/2 has been completed.

In case of VIRTIO_GPU_CMD_RESOURCE_UNREF, blob can be unmapped in the
first place and we can't do the part 3 because it will error out for
unmapped resource since parts 1/2 were not performed.

-- 
Best regards,
Dmitry


