Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058F3E6F06F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 17:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6vGf-0004NZ-5U; Fri, 01 Nov 2024 13:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t6vGb-0004N9-4x
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:16:57 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t6vGZ-00077z-Ce
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:16:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1730481405; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cm9ak3fMspKs+f7O61GFjddn+YdPC80KC3XfPPUTvc1vVERvhg+G+UOMhZmYLbscvtiZzD/d61sX4WzlzuX0PchyF6ycHlMwtPu546UT5kv/C6U0wpn5OSUxqjFbq4pWiwxtNXKTf7qHuhRx1mGPsn7ngeoH9kO9VmQtuGtBT38=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730481405;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tFaI98k+gyDVX8fKhmgnsj/RclYjF7CBxFVPNkFQBeI=; 
 b=EhfrMTJ3nd/Z/CXYepXpPTKr4u4dCukSZhZsT2PbjY4yme6vpVeYcZhp80MS1Olp7notRmXc32kljMWk+NLpcs4FAFgJVY8qFbeak5W7/6KreXUkfbVdZ/Ic484o2A/1DeJbHh0cvIOH+Be8KTGoUwIgUuUbahl8y8/khVYIaI8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730481405; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=tFaI98k+gyDVX8fKhmgnsj/RclYjF7CBxFVPNkFQBeI=;
 b=kFandDuFe0XR4XCMBeCkcR4uRGBNLPniDFQ3ktCDBKRTKFe9s6Tsa3OdcL6GWR+7
 pQP3wufAclEdQQ60JrBbGl1A1958S99QadLqQIDzNqHf/zVv4X9OgDleT1G2D4QMylG
 Cy5240MwkJW71luyQx5FP6bs0Y6PNCZcVwY1CNAM=
Received: by mx.zohomail.com with SMTPS id 1730481403678601.4553389928219;
 Fri, 1 Nov 2024 10:16:43 -0700 (PDT)
Message-ID: <90d62010-efa0-4fd8-b66c-53113e46a042@collabora.com>
Date: Fri, 1 Nov 2024 20:16:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] virtio-gpu: Handle virgl fence creation errors
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
 <20241024233355.136867-5-dmitry.osipenko@collabora.com>
 <871pzwk1ym.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <871pzwk1ym.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/31/24 13:21, Alex Bennée wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> Print out error messages when virgl fence creation fails to aid debugging
>> of the fence-related bugs.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  hw/display/virtio-gpu-virgl.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>> index eedae7357f1a..3c564683820b 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -892,6 +892,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>>                                        struct virtio_gpu_ctrl_command *cmd)
>>  {
>>      bool cmd_suspended = false;
>> +    int ret;
>>  
>>      VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
>>  
>> @@ -990,7 +991,16 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>>      }
>>  
>>      trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
>> -    virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
>> +
>> +    /*
>> +     * Unlike other virglrenderer functions, this one returns a positive
>> +     * error code.
>> +     */
>> +    ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
>> +    if (ret)
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: virgl_renderer_create_fence error: %s",
>> +                      __func__, strerror(ret));
> 
> braces please. Also if ret is only used for the if leg you might as well
> combine it:
> 
>   if (virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0) != 0) {
>     qemu_log_mask(...) 
>   }

Ack, wish checkpatch warned about braces

-- 
Best regards,
Dmitry

