Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A51D0EE01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 15:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNvAt-0003uo-VL; Tue, 25 Nov 2025 10:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vNvAV-0003sl-CW
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:41:34 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vNvAT-00085W-LY
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:41:27 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1764085268; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Z8HwlZd65I9d6OfL+fAqD8ITliUXqoOp2gUeuR73SOz6iuXvEA2c+lpsyj4CmHUix79fkluGwVl2fQcGreDxKZG61hNh2ownqKmImoENpXBIsWqGlZyxPJAYdecang+TTY32G1dpZzfd8FJ8PxFlCOkr/GXHvLIdHo+Ui1Q7bpM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1764085268;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=O6hDttOZtjRkjf/KT4fbvagLMqeDfvwoygKtZanHEPQ=; 
 b=iBjDhVmUxbHBIZr0ihc7vjqkfuA5TM7ioGnxG/uWu/jlEBu3HyX/BXiqxYJw9YG0mZv7jdfRLSZ9VWJsgjX7LKHiMlir3lF7q4rapCMfgk55A6nYvW8zsnMtcBLxswFT6fIB8PsTSIz4qjf2UEo7gUuM6b/ptRe8tgfOL6cSYSI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764085268; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=O6hDttOZtjRkjf/KT4fbvagLMqeDfvwoygKtZanHEPQ=;
 b=Gb6wdoqF4QDzvC/4mYt0gITIbHbtkuLb6b1wcROQmgBKYOtbWnchnK8HxArStJRi
 SUWgN0WI5Cp+gGq2ZbmHFCEPa6+mNxLEr3N+gdOZKisjBiyJ6IOOQb/0uSGfz6HNpyi
 1vDXJHMRl2sFil18puom5QHlr+8Dmvp7FmAdAa8s=
Received: by mx.zohomail.com with SMTPS id 1764085266152444.65801180902463;
 Tue, 25 Nov 2025 07:41:06 -0800 (PST)
Message-ID: <98d60063-b66d-4fc3-b187-b3ea1121c523@collabora.com>
Date: Tue, 25 Nov 2025 18:40:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/7] virtio-gpu: Improve
 virgl_cmd_resource_map_blob() error handling
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20251125023517.177714-1-dmitry.osipenko@collabora.com>
 <20251125023517.177714-4-dmitry.osipenko@collabora.com>
 <87wm3e725r.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87wm3e725r.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/25/25 15:00, Alex Bennée wrote:
>>      if (ret) {
>>          qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map virgl resource: %s\n",
>>                        __func__, strerror(-ret));
>> -        return ret;
>> +        return -1;
> If we are using errno's lets use the defines rather than -1, should this
> be -EPERM?
> 
>>      }
>>  
>>      vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
>> @@ -789,7 +789,16 @@ static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
>>      }
>>  
>>      ret = virtio_gpu_virgl_map_resource_blob(g, res, mblob.offset);
>> -    if (ret) {
>> +
>> +    switch (ret) {
>> +    case 0:
>> +        break;
>> +
>> +    case -EINVAL:
>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>> +        return;
> which isn't what can come here. I see EOPNOTSUPP not being handled either.

When error comes from external virglrenderer code, we don't know exact
reason it fails. Using -1 allows clear distinguish of external vs
internal to QEMU errors.

EOPNOTSUPP and everything else that doesn't have a directly matching
guest code falls into the default error handling returning
VIRTIO_GPU_RESP_ERR_UNSPEC to guest.

-- 
Best regards,
Dmitry

