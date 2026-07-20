Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A347EC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlhna-0007t6-Dg; Mon, 20 Jul 2026 02:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wlhnQ-0007ro-F0
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 02:48:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wlhnL-0007LZ-Ss
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 02:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784530085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PO8Fm4mt0VLaoOLS1XjuTB7cdvLtsrhFUoulsYxdlGw=;
 b=T79vULVkoi29Tc23F19Iq15OS6ih80Wa96srUIHPLL+v78nPK6TVSXjdAWl6SBdmgg1C2n
 YK/L1lwkVeHp0a0rf4k5zURJKGMlpPGX7dNptye2BlJHf6wPFL6cJ9mZXyq+5bzeXMweyW
 HZ3HiU3yq4LCOsi1U+G/Dim+ijLnk1w=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-LPv6YdZjNAuddmVSMzsbmA-1; Mon, 20 Jul 2026 02:48:04 -0400
X-MC-Unique: LPv6YdZjNAuddmVSMzsbmA-1
X-Mimecast-MFC-AGG-ID: LPv6YdZjNAuddmVSMzsbmA_1784530083
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6deso7863472b3a.3
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 23:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784530083; x=1785134883; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PO8Fm4mt0VLaoOLS1XjuTB7cdvLtsrhFUoulsYxdlGw=;
 b=t50fadJphBi07swynXPLjPMRrvs52M/VIQ973Y4The5iyNQJfNLeJWkuwfDJ4EYIZi
 OAqOjDcT71JHvH38QRX5LyXV3qELA2zeKmYAULAbPW/XN8/lBNznwemMWFYzGLVTqO4x
 i0RKbfBg1laBAFMMe/0szug5VZN0AG8PluNGADPNp3AMv65sh3aBm06mhqbkOEq6fUPS
 dv0EdoI/k72FslxIKc9uekHnwZUk1PRpnqMNkiRc2RxnaGRSfdMAs229P0zljFx69wQh
 0p9X4aKPISnmwbt1HDjC/U0J2Iw4drCBLFwyRml45pWkj5YBZRsBc+Ubu1dEH2xv3rpZ
 xDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784530083; x=1785134883;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PO8Fm4mt0VLaoOLS1XjuTB7cdvLtsrhFUoulsYxdlGw=;
 b=sToUyR5a3Y+ed/AHlOyHkQxTULhg8ciuLwfp9Ng736tWaN8dyYXBVVrYLsVJ5FAEuq
 f9HV7EZ6ph3Kjnu1qGNDiedCUB9Wa+50sOMF6Sq2y9ujX1PV0rKLC+LX3Iy0qvVraDHt
 UokIVjr8MeWpRrASaOZscQScozeB81EvoWmfE2+3Uep0wj82xfUNVqXT/VCA98fM+8Gv
 ZdnSVPtoCceXgWy9mc/Kp/JysAk6OQg6aSIFD0450JfrPkVHieKTsOb/Hf2bUpTY4MtZ
 8D7I7M+F9G9M3PhKQpioKLxuES9s0CLdCEhtDCG2uCbi3XjAtr+7bSiyPX411XAB7GtJ
 +67g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrCDYGY4LzgARu9cmxzFWlRwaKxIv2iaCz5U1tlwHOQB2DJQ3pLOPS3Qs3HUta4J+Uwkdp76tsuBvHk@nongnu.org
X-Gm-Message-State: AOJu0YxP8ynH13KDHLw8Sr6kbr0GnTXyRwuDbAr6F2oemZPx+/Npbcz4
 bDeGgFUWs1H6XRoU9eEe8PcURRWv942c5CqpMw6JZyghkR48MbPt/LI3D8uZKDi2IxmzG/yDgOG
 5j53hbLt9mP325JZwmJR10sHQB9W4BSySnLStnKb00vacff90bIk63fxC
X-Gm-Gg: AfdE7cmzwgszQpRWVhzlJ11cFjU/MnjO5daYW2Bii3kf6EikzhhSuLjukyJlZHyLM7Z
 ptOM3lz67Edq/az2Y15BKbKaIivvkHIHruQjJc/dsWGvXeLEhNcSFYsaDf1i4n25MkP3t/o/JLv
 YfO7vzsHcDb8tobG6PDeMHgv5BixRrXGXLjHaakqMSv0DpKSl/Cg9mKU3y0oojfZo4oLqTozerh
 x1dphgegc0Phed8bJRsXzK+KUqX0VuOmF0QAqqnEshQxD0PYbu6ut4xjQ1d9LhhQEML56Lo1hk9
 iE0YqaOfoq753HrnUQF2J4sipk7jrKQT8Y0o36qMdWFHlGH1tQwoc52hmFwiCqxZTemr4AidRh4
 jmufu8zGueZvY3+SdpuK78Z+OoM+oDUQn6/4pcpJ/dOQ=
X-Received: by 2002:a05:6a00:391d:b0:848:65fa:542 with SMTP id
 d2e1a72fcca58-84c29494771mr11796855b3a.53.1784530083149; 
 Sun, 19 Jul 2026 23:48:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:391d:b0:848:65fa:542 with SMTP id
 d2e1a72fcca58-84c29494771mr11796824b3a.53.1784530082638; 
 Sun, 19 Jul 2026 23:48:02 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84c2adc7adasm5227178b3a.19.2026.07.19.23.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jul 2026 23:48:01 -0700 (PDT)
Message-ID: <2ad36e97-63d7-4464-b909-2a28d496e887@redhat.com>
Date: Mon, 20 Jul 2026 16:47:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 10/25] hw/core/loader: Add a ROM loader notifier
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-11-mathieu.poirier@linaro.org>
 <47136344-8e15-498a-a4fb-0dbbb0c71861@redhat.com> <allIviFWgoKgDob1@p14s>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <allIviFWgoKgDob1@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=gshan@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/17/26 7:10 AM, Mathieu Poirier wrote:
> On Tue, Jul 14, 2026 at 08:52:43PM +1000, Gavin Shan wrote:
>> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
>>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>
>>> Add a function to register a notifier that is invoked when ROMs get
>>> loaded into guest memory.
>>>
>>> It will be used by Arm confidential guest support, in order to register
>>> all blobs loaded into memory with KVM, so that their content is moved
>>> into Realm state and measured into the initial VM state.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>    hw/core/loader.c         | 15 +++++++++++++++
>>>    include/hw/core/loader.h | 17 +++++++++++++++++
>>>    2 files changed, 32 insertions(+)
>>>
>>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>>> index 5cbfba0a86d2..b3d769bec5cb 100644
>>> --- a/hw/core/loader.c
>>> +++ b/hw/core/loader.c
>>> @@ -74,6 +74,8 @@
>>>    #endif
>>
>> The (edk2) firmware for the realm guest can be specified by the legacy
>> '-drive if=pflash' or '-bios'. The memory region corresponding to the
>> firmware image specified by '-bios' is recorded by the newly added notifier
>> and populated to TF-RMM properly.
>>
>> I don't see how the memory region corresponding to (edk2) firmware image
>> specified by '-drive if=pflash' is recorded and populated to TF-RMM
>> accordingly in this series. So I guess '-drive if=pflash' isn't supported
>> yet?
> 
> Please give '-drive if=pflash' a try and let me know how you fare.  Edk2 is not
> part of the bootstack I'm currently testing with but I know of configurations
> where it does work.
> 
> I'll add it to my list of things to do if it doesn't work, though I may not
> address it in this patchset.  We'll see how busy things get.
> 

Ok, I don't think '-driver if=pflash' or the 'pflash0' property of the virt machine
aren't supported any more due to [RFC v1 21/25], where the 'pflash0' property has
been removed.

   [RFC v1 21/25] hw/arm/virt: Use RAM instead of flash for confidential guest firmware

- Tried to boot the realm guest with '-driver if=pflash' and I was told it's not supported.

   qemu-system-aarch64: -drive if=pflash,format=raw,unit=0,file=/mnt/edk2/Build/ArmVirtQemu-AARCH64/RELEASE_GCC5/FV/QEMU_EFI.fd,readonly=on: machine type   does not support if=pflash,bus=0,unit=0

- Tried to use 'pflash0' property, and I was told it's not supported either.

   qemu-system-aarch64: Property 'virt-11.1-machine.pflash0' not found

So the only option to specify the firmware image is '-bios', which worked for me.

Thanks,
Gavin


>>
>> Note that I didn't give '-drive if=pflash' a try yet.
>>
>>>    static int roms_loaded;
>>> +static NotifierList rom_loader_notifier =
>>> +    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
>>>    /* return the size or -1 if error */
>>>    int64_t get_image_size(const char *filename, Error **errp)
>>> @@ -1201,6 +1203,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
>>>        return mr;
>>>    }
>>> +void rom_add_load_notifier(Notifier *notifier)
>>> +{
>>> +    notifier_list_add(&rom_loader_notifier, notifier);
>>> +}
>>> +
>>>    /* This function is specific for elf program because we don't need to allocate
>>>     * all the rom. We just allocate the first part and the rest is just zeros. This
>>>     * is why romsize and datasize are different. Also, this function takes its own
>>> @@ -1242,6 +1249,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
>>>    static void rom_reset(void *unused)
>>>    {
>>>        Rom *rom;
>>> +    RomLoaderNotifyData notify;
>>>        QTAILQ_FOREACH(rom, &roms, next) {
>>>            if (rom->fw_file) {
>>> @@ -1290,6 +1298,13 @@ static void rom_reset(void *unused)
>>>            address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
>>>            trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
>>> +
>>> +        notify = (RomLoaderNotifyData) {
>>> +            .addr = rom->addr,
>>> +            .len = rom->datasize,
>>> +            .as = rom->as,
>>> +        };
>>> +        notifier_list_notify(&rom_loader_notifier, &notify);
>>>        }
>>>    }
>>> diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
>>> index d9431e8a8d12..94cf6ad2e26b 100644
>>> --- a/include/hw/core/loader.h
>>> +++ b/include/hw/core/loader.h
>>> @@ -342,6 +342,23 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
>>>    ssize_t rom_add_vga(const char *file);
>>>    ssize_t rom_add_option(const char *file, int32_t bootindex);
>>> +typedef struct RomLoaderNotifyData {
>>> +    /* Address of the blob in guest memory */
>>> +    hwaddr addr;
>>> +    /* Length of the blob */
>>> +    size_t len;
>>> +    /* Address space of the blob */
>>> +    AddressSpace *as;
>>> +} RomLoaderNotifyData;
>>> +
>>> +/**
>>> + * rom_add_load_notifier - Add a notifier for loaded images
>>> + *
>>> + * Add a notifier that will be invoked with a RomLoaderNotifyData structure for
>>> + * each blob loaded into guest memory, after the blob is loaded.
>>> + */
>>> +void rom_add_load_notifier(Notifier *notifier);
>>> +
>>>    /* This is the usual maximum in uboot, so if a uImage overflows this, it would
>>>     * overflow on real hardware too. */
>>>    #define UBOOT_MAX_DECOMPRESSED_BYTES (64 << 20)
>>
>> Thanks,
>> Gavin
>>
> 


