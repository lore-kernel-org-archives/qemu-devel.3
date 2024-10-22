Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2813BD2C547
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 12:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3E9a-0003cQ-NE; Tue, 22 Oct 2024 08:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t3E9Z-0003ZG-0z
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:38:25 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t3E9W-0001Nm-J9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:38:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1729600683; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=edv8dkEYoFmUwh85Ydt3zRWqTRr/Ip9tVCycFRKeB/A7AMNW6Jc4nPJbIUeliH5NFOd8kztNgeJ0bkctBWD5gtHHzsZa22E1Ls57v+YirOabqJfijCSlSknTpnB/hrWzAxeGLVpp81hBhEAQAf6QsRtqKF6np+G16pzAXP1ocpc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729600683;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6J50PJOZIPGSLdFd8IWuD2qqZS6vhXHQAG3o2pInTvU=; 
 b=Fxywr0rBMuAuvu3GBrkkENGGrMIcHhEW6oWgJM8Yl40yIPfY3bOnnWqLy5hVcaOIhTruZKotZHUGDTwiAMC0/noedOBNyrCUBlxOR5pUHnAh9PUPmYj3sOpKaR2IlqVvYkscRxt89VVZllrg9S/Ij/OXHibK+StsOxFi9GgbMgw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729600683; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=6J50PJOZIPGSLdFd8IWuD2qqZS6vhXHQAG3o2pInTvU=;
 b=Hi6Za+psp6hu6FZ+LkszFsWzz6rldZWvwI40p8PKyhTNduXS14Ohg1GG8QhjzPEW
 +6kbQ34fn4NUBsGa/6PB0DnrZrXfaXhQyNk8EFFBneWquuKyL9j/+9wPg3U6Nbd/YXI
 mnriaPn5awtHzWkAVCgSCzCXFGmw0oagqn7R9C0w=
Received: by mx.zohomail.com with SMTPS id 1729600677103775.0694160909555;
 Tue, 22 Oct 2024 05:37:57 -0700 (PDT)
Message-ID: <44929f04-f45f-45ff-bd0b-e1a955fad34a@collabora.com>
Date: Tue, 22 Oct 2024 15:37:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] virtio-gpu: Support asynchronous fencing
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
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
References: <20241015043238.114034-1-dmitry.osipenko@collabora.com>
 <20241015043238.114034-6-dmitry.osipenko@collabora.com>
 <9362f8ac-5616-4f6d-b424-3a2b679c2141@daynix.com>
 <f79ebab7-fe1c-419d-89d5-6238b0b36ba5@collabora.com>
 <c02c2bb3-c5fe-4675-bfc5-2b99fbf78f42@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <c02c2bb3-c5fe-4675-bfc5-2b99fbf78f42@daynix.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/22/24 08:11, Akihiko Odaki wrote:
> On 2024/10/19 6:31, Dmitry Osipenko wrote:
>> On 10/18/24 08:28, Akihiko Odaki wrote:
>>>> +static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
>>>> +                                      uint32_t ring_idx, uint64_t
>>>> fence)
>>>> +{
>>>> +    VirtIOGPU *g = opaque;
>>>
>>> What about taking the BQL here instead of having a QEMUBH?
>>
>> That will block virglrenderer thread writing the fence, which in turns
>> might block other virglrenderer threads.
> 
> Looking at virglrenderer's source code, the thread writing the fence is
> the only thread it creates. Otherwise virglrenderer's code should be
> executed only in the QEMU thread calling virglrenderer's functions,
> which always holds the BQL. So taking the BQL here will not interfere
> with another thread.

There are other problems with that BQL approach:

1. virgl_renderer_context_destroy() is executed from QEMU's main-loop
and it will terminate the virglrenderer's fence-sync threads which at
the same time will take the same BQL if fence fires while VM is shutting
down and then this condition will result in a deadlock.

2. In a case of vrend, the fence-sync thread uses a different GL context
than the QEMU's main-loop vrend thread. Feels like too much potential
problems with GL context switching here. We shouldn't be able to jump
into QEMU's GL code from a non-vrend GL thread.

Too many complications with the BQL approach for a little benefit, IMO.

-- 
Best regards,
Dmitry

