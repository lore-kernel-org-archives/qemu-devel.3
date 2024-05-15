Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6733CC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7HfR-0002d9-As; Wed, 15 May 2024 12:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s7HfQ-0002d0-42
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:39:48 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s7HfO-0006f9-H6
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715791183;
 bh=iiGUOJjac+kuWa1nw+40HQi+OcpGus3azbgSQQy0Jt8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=2Dm5jNGUmtiHBmUPS8zLFZPv6RFvpYr1ZoNjJAyGLgGiod8msi1y9RCehJ9TCln02
 iQpvj2ZJvlI4UOhYmL9RM4TVTWZHAnnDbSxS3VYIU8qvj6uwYhFdkuQaYqgziFSjrU
 YZEA64pdG1xD3lqvbA3muhMCSevhLwit6a0lO8qQ8ASaieYTmLjUvFuN0lv1cyQ+xx
 Ud68fWiwWmPd4nfhwhGDlT6SvnRrLkxP+VkmwOYGU2vWrU0NxL/xbvLpYkGfFtTwB8
 DRhTl/W038NaCu+LOVwKY5bTsIJEYWnT1NYdYyWl2jbujEjTh9HFHMGgNjPmS6XK8Z
 t4OrBdQrTiaiw==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 836F03782157;
 Wed, 15 May 2024 16:39:40 +0000 (UTC)
Message-ID: <4b30a810-211a-4ef6-ac28-c144615b402c@collabora.com>
Date: Wed, 15 May 2024 19:39:37 +0300
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
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <727b125a-530e-4881-bde0-2215f62e155d@daynix.com>
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

On 5/13/24 12:18, Akihiko Odaki wrote:
>>     static void virgl_cmd_resource_unref(VirtIOGPU *g,
>> -                                     struct virtio_gpu_ctrl_command
>> *cmd)
>> +                                     struct virtio_gpu_ctrl_command
>> *cmd,
>> +                                     bool *cmd_suspended)
> 
> This parameter is not used as it returns an error if the resource is
> still mapped.

Missed to remove it by accident

> It may be better to actually implement unmapping instead of returning an
> error for consistency with the iov operation. Apparently crosvm also
> unmaps blobs with VIRTIO_GPU_CMD_RESOURCE_UNREF.

Then I'll add back `async_unmap_in_progress` because resource can be
both mapped/unmapped on unref, and we'll need flag to know whether async
unmapping has been finished to do the final unmapping of the resource.

...
>> +    QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
>> +
>> +    virgl_args.res_handle = cblob.resource_id;
>> +    virgl_args.ctx_id = cblob.hdr.ctx_id;
>> +    virgl_args.blob_mem = cblob.blob_mem;
>> +    virgl_args.blob_id = cblob.blob_id;
>> +    virgl_args.blob_flags = cblob.blob_flags;
>> +    virgl_args.size = cblob.size;
>> +    virgl_args.iovecs = res->base.iov;
>> +    virgl_args.num_iovs = res->base.iov_cnt;
>> +
>> +    ret = virgl_renderer_resource_create_blob(&virgl_args);
>> +    if (ret) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: virgl blob create error:
>> %s\n",
>> +                      __func__, strerror(-ret));
>> +        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> 
> reslist keeps the stale res even if an error happens.

Good catch

-- 
Best regards,
Dmitry


