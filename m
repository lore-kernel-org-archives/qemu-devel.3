Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97725C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 14:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSeQD-0004Mp-4i; Wed, 24 Jan 2024 09:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1rSeQA-0004MJ-1m
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 09:40:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1rSeQ8-00061Z-6y
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 09:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706107202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XT53JLMsm9q9tNGztQTxRA1bMzyUdQZzokx6dbxj0Wk=;
 b=ODYuZv2vQPyAHXR1QmeQZOqCvXs8HRg1liAOvCRcCgzmV+GZ7zwoGpo5eKUkpppXhP0qW/
 vCu0TVzD4vU4AvdW3yEDwvQ7xFKe6DUl0YZYJzkZc6quPty8eiGM9QnyFsn7b/6kmd4bm0
 i65VJQx1BxSCxJYP/adHZQd7uSNPY80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-qI6vGugAPLGFHoljyH9AwQ-1; Wed, 24 Jan 2024 09:39:59 -0500
X-MC-Unique: qI6vGugAPLGFHoljyH9AwQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2ED2185A788;
 Wed, 24 Jan 2024 14:39:58 +0000 (UTC)
Received: from [10.39.195.127] (unknown [10.39.195.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 536C0492BFA;
 Wed, 24 Jan 2024 14:39:57 +0000 (UTC)
Message-ID: <e5a4478e-c7f9-c639-690b-9eeb7c62212e@redhat.com>
Date: Wed, 24 Jan 2024 15:39:56 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] target/i386/host-cpu: Use iommu phys_bits with VFIO
 assigned devices on Intel h/w
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>, Yanghang Liu <yanghliu@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
References: <20240118192049.1796763-1-vivek.kasireddy@intel.com>
 <9462383d-3e42-460e-b721-8371d35e29a6@redhat.com>
 <7982b791-3333-473a-b42b-fbcf21f153cb@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <7982b791-3333-473a-b42b-fbcf21f153cb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/24/24 13:58, Philippe Mathieu-Daudé wrote:
> On 24/1/24 12:53, Cédric Le Goater wrote:
>> On 1/18/24 20:20, Vivek Kasireddy wrote:
>>> Recent updates in OVMF and Seabios have resulted in MMIO regions
>>> being placed at the upper end of the physical address space. As a
>>> result, when a Host device is assigned to the Guest via VFIO, the
>>> following mapping failures occur when VFIO tries to map the MMIO
>>> regions of the device:
>>> VFIO_MAP_DMA failed: Invalid argument
>>> vfio_dma_map(0x557b2f2736d0, 0x380000000000, 0x1000000,
>>> 0x7f98ac400000) = -22 (Invalid argument)
>>>
>>> The above failures are mainly seen on some Intel platforms where
>>> the physical address width is larger than the Host's IOMMU
>>> address width. In these cases, VFIO fails to map the MMIO regions
>>> because the IOVAs would be larger than the IOMMU aperture regions.
>>>
>>> Therefore, one way to solve this problem would be to ensure that
>>> cpu->phys_bits = <IOMMU phys_bits>
>>> This can be done by parsing the IOMMU caps value from sysfs and
>>> extracting the address width and using it to override the
>>> phys_bits value as shown in this patch.
>>>
>>> Previous attempt at solving this issue in OVMF:
>>> https://edk2.groups.io/g/devel/topic/102359124
>>>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>> Cc: Cédric Le Goater <clg@redhat.com>
>>> Cc: Laszlo Ersek <lersek@redhat.com>
>>> Cc: Dongwon Kim <dongwon.kim@intel.com>
>>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>>> Tested-by: Yanghang Liu <yanghliu@redhat.com>
>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>
>>> ---
>>> v2:
>>> - Replace the term passthrough with assigned (Laszlo)
>>> - Update the commit message to note that both OVMF and Seabios
>>>    guests are affected (Cédric)
>>> - Update the subject to indicate what is done in the patch
>>> ---
>>>   target/i386/host-cpu.c | 61 +++++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 60 insertions(+), 1 deletion(-)
> 
> 
>>> +static int intel_iommu_check(void *opaque, QemuOpts *opts, Error
>>> **errp)
>>> +{
>>> +    g_autofree char *dev_path = NULL, *iommu_path = NULL, *caps = NULL;
>>> +    const char *driver = qemu_opt_get(opts, "driver");
>>> +    const char *device = qemu_opt_get(opts, "host");
>>> +    uint32_t *iommu_phys_bits = opaque;
>>> +    struct stat st;
>>> +    uint64_t iommu_caps;
>>> +
>>> +    /*
>>> +     * Check if the user requested VFIO device assignment. We don't
>>> have
>>> +     * to limit phys_bits if there are no valid assigned devices.
>>> +     */
>>> +    if (g_strcmp0(driver, "vfio-pci") || !device) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    dev_path = g_strdup_printf("/sys/bus/pci/devices/%s", device);
>>> +    if (stat(dev_path, &st) < 0) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    iommu_path = g_strdup_printf("%s/iommu/intel-iommu/cap", dev_path);
>>> +    if (stat(iommu_path, &st) < 0) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (g_file_get_contents(iommu_path, &caps, NULL, NULL)) {
>>> +        if (sscanf(caps, "%lx", &iommu_caps) != 1) {
>>
>> nit. This should use a PRIx64 define.
>>
>>> +            return 0;
>>> +        }
>>> +        *iommu_phys_bits = ((iommu_caps >> 16) & 0x3f) + 1;
>>
>> Please use 0x3fULL
> 
> or:
> 
>            *iommu_phys_bits = 1 + extract32(iommu_caps, 16, 6);

Huh, interesting; I've never seen this recommended before, even though
it comes from a very old commit -- 84988cf910a6 ("bitops.h: Add
functions to extract and deposit bitfields", 2012-07-07).

I thought only edk2 had BitFieldRead32() :)

Laszlo


