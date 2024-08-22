Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D264C5320E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 13:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh8Bc-0004sR-Om; Thu, 22 Aug 2024 09:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sh8Bb-0004rx-L7
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 09:49:11 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sh8BZ-0001mq-Mn
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 09:49:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1724334534; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XJZAHExSBvvCOOix1sBuWxeX8cu6OHt6CelFV2Lmyt0jZSD8PHTiZHTTKze42ST0uUdVnFdQM+uIKacTzFbwblukbsvjuO5d7A4PXC6HL62D3MigwgLCBrEaZZxFpvEf9p4pcXg7XTKsQMtPbJLBdN9Wy5pzhIVKYlMJCyLDYYk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1724334534;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gy9bGPEjA67FUqqzV44hjj1gxDeO+ryLgD6smAXgUdE=; 
 b=eEvg7VsXJ+QyULEEYI3GzeLrEqMErXTMJ2EnL/11rD87noP/Q7ZdrlKQFvev6P9WWjdaw3sT+GqpqHdhlKxNMfKibfPF/QXthLGp0RY8szeB7FL6Grm5fWRsQIffVYg/dOvGE2CBFvVrz9Bm1nna+h+u/az45YGEHCT+Fbmuvtw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724334534; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=gy9bGPEjA67FUqqzV44hjj1gxDeO+ryLgD6smAXgUdE=;
 b=hn1vUHJfdU3cNGAunzoAKYREMh+4+aJFu3QISbfozV11xSJao5Yj/DjPgbneT5J7
 PzCB5teVTq7HwquvaAgXgvhf6+uDyZ1NXSjSHjUFhIhCi/kkbaRh+NcRfvDfojUKmv6
 2kzcoYZQv7epcytlehlAMuhAzemkmYPNEGQ7T+wk=
Received: by mx.zohomail.com with SMTPS id 1724334531773413.2433113737983;
 Thu, 22 Aug 2024 06:48:51 -0700 (PDT)
Message-ID: <6bc52976-ac1b-4c42-8fb3-d55166d21c83@collabora.com>
Date: Thu, 22 Aug 2024 16:48:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/13] Support blob memory and venus on qemu
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
 <20240701164449-mutt-send-email-mst@kernel.org>
 <877cc8n1ix.fsf@draig.linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <877cc8n1ix.fsf@draig.linaro.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/22/24 16:13, Alex Bennée wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
>> On Sun, Jun 23, 2024 at 06:23:30PM +0300, Dmitry Osipenko wrote:
>>> Hello,
>>>
>>> This series enables Vulkan Venus context support on virtio-gpu.
>>>
>>> All virglrender and almost all Linux kernel prerequisite changes
>>> needed by Venus are already in upstream. For kernel there is a pending
>>> KVM patchset that fixes mapping of compound pages needed for DRM drivers
>>> using TTM [1], othewrwise hostmem blob mapping will fail with a KVM error
>>> from Qemu.
>>
>>
>> I'd like to see a Tested-by from Alex Bennée for this -
>> he's been testing v14 last as far as I could see.
> 
> I've posted it on the top. Broadly x86 and Arm work on my x86 host. So
> far my Arm host only runs the x86 image with the AMD card OK.
> 
> I've updated my test images so you can try them:
> 
>   https://fileserver.linaro.org/s/ce5jXBFinPxtEdx
> 
> See the notes on the readme on how to run.

Thanks, Alex! I'll re-post v17 with all new acks/r-b's soon, will also
link your images in the cover letter.

-- 
Best regards,
Dmitry


