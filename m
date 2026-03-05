Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17025EEF30A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 06:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy21W-0007we-3n; Thu, 05 Mar 2026 01:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy21F-0007rj-Vf
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 01:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy21E-0002PW-6i
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 01:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772691425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=74SDiqWct2r0bhgBpSk6cudpOiBSXrbpapw3gOAWyig=;
 b=CgP2QIpMlnqZDKY8IlHrX7jz9LVd2BINKK8RyZtkb2EedJeeu6gxqYneRqzZHBmLYrsBdg
 Zp3fZaAzJmCYhOyJRd5qyrjv99YFn6daqjaqBrLZ7hcptl6iV3b1IQJfoFsbSk43amZu2+
 np35sK8ckF0gpDi1M+jlCX4vjgbREH0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-4-IfzPAxOoGyHEBSKvdk7w-1; Thu,
 05 Mar 2026 01:17:04 -0500
X-MC-Unique: 4-IfzPAxOoGyHEBSKvdk7w-1
X-Mimecast-MFC-AGG-ID: 4-IfzPAxOoGyHEBSKvdk7w_1772691422
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A5A119560AA; Thu,  5 Mar 2026 06:17:02 +0000 (UTC)
Received: from [10.45.224.75] (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C8E83003E98; Thu,  5 Mar 2026 06:16:59 +0000 (UTC)
Message-ID: <b3620c18-9f11-459f-bc0f-62721807eaa1@redhat.com>
Date: Thu, 5 Mar 2026 07:16:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] pc-bios/s390-ccw: Add support for virtio-blk-pci
 IPL
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
 <20260304025917.2157032-13-jrossi@linux.ibm.com>
 <d359ade1-7e86-40c0-bfa2-6452fc48f69d@redhat.com>
 <c8b28b9c-51e1-44aa-93c4-c94846676b93@linux.ibm.com>
 <79fb74d7-4b42-4ffc-902f-2498e1de5a52@redhat.com>
 <5126b04a-dd1f-40ad-a720-4d2c3a7cb1aa@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5126b04a-dd1f-40ad-a720-4d2c3a7cb1aa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
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

On 04/03/2026 21.17, Jared Rossi wrote:
> 
> 
> On 3/4/26 9:39 AM, Thomas Huth wrote:
>> On 04/03/2026 15.29, Jared Rossi wrote:
>>>
>>>
>>> On 3/4/26 4:53 AM, Thomas Huth wrote:
>>>> On 04/03/2026 03.59, jrossi@linux.ibm.com wrote:
>>>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>>>
>>>>> Add little-endian virt-queue configuration and support for virtio-blk- 
>>>>> pci IPL
>>>>> devices.
>>>>>
>>>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>>>> ---
>>>> ...
>>>>> +static int virtio_pci_get_blk_config(void)
>>>>> +{
>>>>> +    VirtioBlkConfig *cfg = &virtio_get_device()->config.blk;
>>>>> +    int rc = vpci_read_flex(d_cap.off, d_cap.bar, cfg, 
>>>>> sizeof(VirtioBlkConfig));
>>>>> +
>>>>> +    /* single byte fields are not touched */
>>>>> +    cfg->capacity = bswap64(cfg->capacity);
>>>>> +    cfg->size_max = bswap32(cfg->size_max);
>>>>> +    cfg->seg_max = bswap32(cfg->seg_max);
>>>>> +
>>>>> +    cfg->geometry.cylinders = bswap16(cfg->geometry.cylinders);
>>>>> +
>>>>> +    cfg->blk_size = bswap32(cfg->blk_size);
>>>>> +    cfg->min_io_size = bswap16(cfg->min_io_size);
>>>>> +    cfg->opt_io_size = bswap32(cfg->opt_io_size);
>>>>
>>>> So it looks like you read a bunch of optional config fields here ...
>>>>
>>>>> +    return rc;
>>>>> +}
>>>> ...
>>>>> +int virtio_pci_setup(VDev *vdev)
>>>>> +{
>>>>> +    VRing *vr;
>>>>> +    int rc;
>>>>> +    uint8_t status;
>>>>> +    uint16_t vq_size;
>>>>> +    int i = 0;
>>>>> +
>>>>> +    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
>>>>> +    vdev->cmd_vr_idx = 0;
>>>>> +
>>>>> +    if (virtio_pci_read_pci_cap_config()) {
>>>>> +        puts("Invalid virtio PCI capabilities");
>>>>> +        return -EIO;
>>>>> +    }
>>>>> +
>>>>> +    if (enable_pci_bus_master()) {
>>>>> +        return -EIO;
>>>>> +    }
>>>>> +
>>>>> +    if (virtio_reset(vdev)) {
>>>>> +        return -EIO;
>>>>> +    }
>>>>> +
>>>>> +    status = VIRTIO_CONFIG_S_ACKNOWLEDGE;
>>>>> +    if (virtio_pci_set_status(status)) {
>>>>> +        puts("Virtio-pci device Failed to ACKNOWLEDGE");
>>>>> +        return -EIO;
>>>>> +    }
>>>>
>>>> ... so I think you should enable the corresponding feature bits in vdev- 
>>>> >guest_features[0] here? QEMU might be very forgiving and provide you 
>>>> with the fields anyway, but let's better play safe. Something like:
>>>>
>>>>     vdev->guest_features[0] = VIRTIO_BLK_F_SIZE_MAX |
>>>>                               VIRTIO_BLK_F_SEG_MAX |
>>>>                               VIRTIO_BLK_F_GEOMETRY |
>>>>                               VIRTIO_BLK_F_BLK_SIZE;
>>>>
>>>> ?
>>>
>>> VIRTIO_BLK_F_GEOMETRY and VIRTIO_BLK_F_BLK_SIZE are already set during 
>>> the virtio-blk setup.  I actually don't think the other two fields are 
>>> used, I jut swapped any fields larger than 1 byte.  I suppose the feature 
>>> bits should be enabled though... otherwise we could just just not touch 
>>> the unused fields at all?
>>
>> Ah, right, I missed the initialization in virtio_blk_setup_device(), so we 
>> should be fine here, indeed!
>>
>>>>
>>>>> +    vdev->guest_features[1] = VIRTIO_F_VERSION_1;
>>>>> +    if (virtio_pci_negotiate()) {
>>>>> +        panic("Virtio feature negotation failed!");
>>>>> +    }
>>>>
>>>> Maybe double-check whether VIRTIO_F_VERSION_1 has really been 
>>>> negotiated? Otherwise, what happens if a user runs QEMU with "-device 
>>>> virtio-blk- pci,disable-modern=on" ?
>>>
>>> I haven't tried running it with "disable-modern=on" (I will test that 
>>> next) but the config is big endian if I don't negotiate that feature bit, 
>>> and little endian if I do, which I think is the expected behavior when 
>>> VIRTIO_F_VERSION_1 is set.
>>>
>>> Just for my understanding, do you see something that makes you suspect 
>>> the negotiation isn't actually happening?  I will try running with 
>>> "disable- modern=on" and let you know the results.
>>
>> No, I think it's fine for the default case. I'm just wondering what 
>> happens when someone uses "disable-modern=on" ... I guess the code will 
>> currently behave in weird ways since the endianness is wrong ... thus I 
>> thought it might be better to check VIRTIO_F_VERSION_1 again and emit a 
>> proper error message in this case?
>>
> 
> I tried running with "disable-moden=on" and it failed very early in the 
> virtio-pci setup when trying to read the PCI configuration space.
> 
>     Failed to locate PCI common configuration
>     Invalid virtio PCI capabilities
>     ERROR: No suitable device for IPL. Halting...
> 
> 
> Actually that happens before we even try to negotiate VIRTIO_F_VERSION_1.  
>  From the virtio spec, it looks like the legacy interface requires the 
> common configuration to be in BAR0 (4.1.4.10), while we normally expect 
> BAR15 to specify the layout. Typically we need to read the capabilities 
> config in BAR15 to determine which BAR the common config is in, then that 
> location is used when negotiating the features, etc.  My guess is BAR15 
> isn't populated when "disable-modern=on" so it bails out when there is no 
> capabilities configuration.
> 
> But as far as I can tell it isn't an endianness issue since we are trying to 
> read single byte fields at this point anyway.  What are your thoughts?

Ok, having the error message "Failed to locate ..." sounds good to me, so 
I'm fine if you keep this patch as it is. I was just worried that we end up 
with the bios crashing in weird ways due to the endianness issues, and that 
you could not tell by the output on the serial console what was going on. 
But since we have a clear error message instead of a crash, I think we're fine.

Thanks for checking!

  Thomas


