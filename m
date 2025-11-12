Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DBACCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 08:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ64j-0001Zk-M4; Wed, 12 Nov 2025 03:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJ630-0008Jn-Gi
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 03:17:47 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJ62x-0006pG-F8
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 03:17:46 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AC8HZte003262
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 12 Nov 2025 17:17:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=nDQeONniTkb7oG+vNVg9DGYHQxEdVJ+1AJfIZ8Jn7+Y=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762935455; v=1;
 b=SxZ19gXEouKR76WD4Ie7+szIureOS/HOf/GYMSWa1Xcft+WuPcfPD7GqsSSv3mmW
 lPP+tp3PgIZiTvCDNp7nd0k3ikgY8C7XmMdIC6PkH7Wrd/H2i3RC/a8pLrHzH2gz
 XGDMiDe6wChKwylHIlcYd5UFNOlzv3eLwr1PMImBYciyh+T1ja+vGkeplVJYLepL
 v1jLzIrQKnOsiYyMi/TQBbOPGYbxHu1KJyoq6qXgH6loYrbzGgi4QIRf5+BleYwW
 jz0ggKTIP5dH9uVssKZKHFxjRfcugjqIzUH2GL9GoxgmZ5XTM3pqSe0O52U8cH1q
 9l1OTIKIGoCoIpMzzPGCuQ==
Message-ID: <3c0fe9e8-7efa-4936-b5ef-5cabc4239cdd@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 12 Nov 2025 17:17:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-11-vivek.kasireddy@intel.com>
 <5c224e00-8114-4586-b502-3819770bc8ff@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71853FE6CD48B77FA586B628F8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <IA0PR11MB71853FE6CD48B77FA586B628F8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/12 13:26, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
>> associated with VFIO devices
>>
>> On 2025/11/09 14:33, Vivek Kasireddy wrote:
>>> In addition to memfd, a blob resource can also have its backing
>>> storage in a VFIO device region. Therefore, we first need to figure
>>> out if the blob is backed by a VFIO device region or a memfd before
>>> we can call the right API to get a dmabuf fd created.
>>>
>>> So, once we have the ramblock and the associated mr, we rely on
>>> memory_region_is_ram_device() to tell us where the backing storage
>>> is located. If the blob resource is VFIO backed, we try to find the
>>> right VFIO device that contains the blob and then invoke the API
>>> vfio_device_create_dmabuf().
>>>
>>> Note that in virtio_gpu_remap_udmabuf(), we first try to test if
>>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
>>> use the VFIO device fd directly to create the CPU mapping.
>>
>> I have just remembered that mremap() will work for either of udmabuf and
>> VFIO. That will avoid having two different methods and make
>> vfio_get_region_index_from_mr() and vfio_device_get_region_info()
>> unnecessary.
> IIUC, the name virtio_gpu_remap_dmabuf() is misleading because we are not
> actually doing remap but are simply calling mmap(). In other words, we are not
> expanding or shrinking existing mapping but are creating a new mapping.
> And, for dmabufs associated with VFIO devices, without having to call
> vfio_get_region_index_from_mr() and vfio_device_get_region_info(), I don't see
> any other way to determine the region offset.
> 
> So, I guess I'll create a new patch to do s/remapped/map.

I mean calling mremap() with 0 as the old_size parameter. The man page says:
 > If the value of old_size is zero, and old_address refers to a
 > shareable mapping (see the description of MAP_SHARED in mmap(2)), then
 > mremap() will create a new mapping of the same pages.

Regards,
Akihiko Odaki

