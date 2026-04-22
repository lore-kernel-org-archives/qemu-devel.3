Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143FDF9EDDB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFYoU-0006yj-Ri; Wed, 22 Apr 2026 10:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wFYo1-0006vF-Ls
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 10:43:59 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wFYnw-0006x5-Ch
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 10:43:57 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63MEhiRY075425
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 22 Apr 2026 23:43:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=JjXJoSatX5MFcLsUIgbLKV7aS9LICTHPYVTKte63KMM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1776869024; v=1;
 b=RcweuDkELQmRMus4QXxUjD1EwkMWJuu1BcsoMi0T5bpW2hfT8WtF7MmiY5o6UXk9
 Ev0t5PpFXqkdyC/h6WNC7Z8AHDPoxr1WG+MKgiJiO785qk5O+3ytpL4sbpjkOxj6
 R4nUJP5A5KJOE4g5FsrffGpcSH1Mfwz51J0XbyCF18AxCGM4jxnNB1wJqoblu0a5
 V/2JHpk62EtiTSxzYEGBDjtkQV6wgIYb3gy0gCEsPmAYhY1u3Zst1x728UoJ11pC
 xTtmIXdzrHjlUDA6qYWouJEVnU4AXfDGctVAUUNhY1H13NnBXPsKA3QfvuqMBZKE
 DHD4ywzDwQCBm0NLW6LviA==
Message-ID: <259416cf-1ab5-4f41-83fe-986b33c551b2@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 22 Apr 2026 23:43:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-10-vivek.kasireddy@intel.com>
 <a112aab0-df42-47b6-a5de-f6827321c8d5@redhat.com>
 <IA0PR11MB718579B3F8EFCB2C2E2D1E93F848A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <3434becb-639b-435d-a36a-71b5a3760ba2@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71851F5FD322F30FAD53D1F4F849A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <09f02fe2-63cb-4283-899e-4cffc5f60cf1@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185F5B516E3FAC39290B6A0F8232@IA0PR11MB7185.namprd11.prod.outlook.com>
 <e09e7494-8261-4ad3-a0c1-6dd41c163961@redhat.com>
 <2a5817c4-cb61-4867-9bdd-fbe68cf5601e@rsg.ci.i.u-tokyo.ac.jp>
 <137b5ae2-321c-4d69-9968-1442baed26bc@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <137b5ae2-321c-4d69-9968-1442baed26bc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/04/22 22:49, Cédric Le Goater wrote:
>>> May be the iov API is not adequate for this purpose :
>>>
>>>    int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int 
>>> iov_cnt,
>>>                                     size_t total_size, Error **errp);
>>>    void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int 
>>> iov_cnt,
>>>                                  size_t total_size, Error **errp);
>>>
>>> or the part validating the iov should be done before calling into
>>> VFIO:
>>>
>>>      if (iov_size(iov, iov_cnt) != total_size) {
>>>          error_setg(errp, "Total size of iov does not match dmabuf 
>>> size\n");
>>>          return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>>>      }
>>
>> The value of the "total_size" parameter is actually an internal state 
>> of virtio-gpu so I have suggested to move the check to virtio-gpu and 
>> remove the parameter.
>>
>>>
>>>      if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
>>>          return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>>>      }
>>>
>>>      for (i = 0; i < iov_cnt; i++) {
>>>          if (!vfio_region_lookup(iov[i].iov_base, &region,
>>>                                  first_rb, &offset, errp)) {
>>>              return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>>>          }
>>>      }
>>
>> The remaining checks, however, are VFIO-specific. `vfio_device_lookup()`
>> and `vfio_region_lookup()` translate the HVA/RAMBlock information into a
>> VFIO device/region, so moving them into virtio-gpu would require 
>> virtio-gpu to know about VFIO device/region internals.
> 
> 
> This likely means that the interface of these routines is not yet
> well defined :
> 
>    static bool vfio_device_lookup(struct iovec *iov, VFIODevice 
> **vbasedevp,
>                                   RAMBlock **first_rbp, Error **errp)
> 
>    static bool vfio_region_lookup(void *addr, VFIORegion **regionp,
>                                   RAMBlock *first_rb, ram_addr_t *offsetp,
>                                   Error **errp)
> 
> I don't think VFIO should to manipulate struct iovec. RAMBlock is
> questionable too. A MemoryRegion would be better.
> 
> Some ideas, in vfio_device_lookup(), replace in the interface 'iovec'
> by a 'void *' and :
>    rb = qemu_ram_block_from_host(addr, false, &offset);
>    region = vfio_get_region_from_mr(rb->mr);
>    *vbasedevp = region->vbasedev;

My assumption was that these helpers would remain internal to VFIO. From
virtio-gpu's perspective, accessing VFIODevice and VFIORegion
directly does not seem ideal, but the interface may be improved.

What do you suggest with vfio_device_create_dmabuf_fd() and 
vfio_device_mmap_dmabuf() to separate struct iovec manipulation from VFIO?

Regards,
Akihiko Odaki

> 
> 
> And no error enum please.
> 
> Thanks,
> 
> C.
> 


