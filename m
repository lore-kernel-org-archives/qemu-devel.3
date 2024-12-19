Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4395EE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 09:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tODBL-00076J-5f; Thu, 19 Dec 2024 04:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tODBI-00075k-G2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:50:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tODBG-0004zm-Ir
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734601853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NNJZuJyKikThfwte+XAulQKKdxoWJ4lxBfWdbwx8iuw=;
 b=i4D3QXe2CzGtGqhwpFL3ozgobIWtIJ4H7bbXcGH8ugdb//BivuMaT7S1CW4oM2ToxtooF3
 icjrZphLFhmVnqgCkjJMv0QJTWuB3aYA/d7F6MPVt/obVd4uji+fZlc+jHcg0s34SKWBgx
 QE5fIStU3YTHg6DPi1YqcBi0EDYP3+E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-V30wnaUzNkOw1vmgrcqV7w-1; Thu, 19 Dec 2024 04:50:51 -0500
X-MC-Unique: V30wnaUzNkOw1vmgrcqV7w-1
X-Mimecast-MFC-AGG-ID: V30wnaUzNkOw1vmgrcqV7w
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-46791423fc9so10847641cf.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 01:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734601851; x=1735206651;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNJZuJyKikThfwte+XAulQKKdxoWJ4lxBfWdbwx8iuw=;
 b=QNpP/1X4RrgDWs6wqrnBCmS32ELbra4z9soRB8Nfwo9MHHVZ82ZD+bufAWiv6CkG/z
 Vsdegs51N8o6Wwnp95h3KsQ5kyWMm8pFJ5YuPma1UN+0pslMEpCVhJCKALJmmPNKq8R+
 Sexf8BVMZbhphQTTPvsKbX3cOaC/8TRsFynrT5ErkVJRG0KXv33jH2HUkZbV/W7i5MsB
 LSFFkhhbTlvHVD8jvO+unJgvPvdp3SMalHzLeMAmKgFK4XUHOUhiPneQwsGypYT1+t8P
 TNKjAI51fz7GRO7ZZ9DKv1gWkemO3QIc669We5okCJNheao2PH6YKaJQeYDSd6uEuTby
 xO6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5XxNXkndvZjdePxV1ZiG3drQLIjPrm+/mUtXWOHzEgovzoKwso3yrhTZubdjPjqHc+F52Oipe9SXT@nongnu.org
X-Gm-Message-State: AOJu0YxSPukJh0rrG4muBABpRuP9QenVPiChBzEskcpRFmNpx0fqV4n3
 AVpL4KvTDunWEXYXCbMaCOHfWh6AP1ov4GWBu2eSF/d+rjNQHj7zwYNy+s2LnrTRMk6NAFJYHg2
 bTJZCcHQlWN5ANCgyTDPRuPm2c4t4i4C/Tmmhs1K/e0DEH8GhOErc
X-Gm-Gg: ASbGncuKo5KzA5Y4C0rp/C3O6jHnuLmmSWhPmsecj9gflfVj4cxJp5Xnh80p31iQ0gb
 dx1wz6W86eBzEkUPF1yxI/DgrqF3hPXqAoOKt34UQxcYTK/05sDE4Q3ZgFSc4ebg9l6uoaNLwpE
 7oCKow4Y40q+OgnN6aJ/m/tq/0r39edQliyptZrHiDSeDCZkAq/NQQVzQR3FG7KX9+nh4da06K3
 zueu0jaMqcdSQIniUeblD0pHf4eoiDgMFSB/i3lxEFjfO398SCY3w7O7Gl4LNynVRxAQc3FnYKX
 4rhSUtl9bCk2mkVnjUE=
X-Received: by 2002:ac8:5710:0:b0:467:62ab:6ec5 with SMTP id
 d75a77b69052e-46908deba22mr87793981cf.19.1734601851257; 
 Thu, 19 Dec 2024 01:50:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdnGWvCY+G3o9WjIGUYclt5OViPkYDxN2RQ0OZgzP/BDKjZvDbMEefrJl0tmbIKmj2bkNH3g==
X-Received: by 2002:ac8:5710:0:b0:467:62ab:6ec5 with SMTP id
 d75a77b69052e-46908deba22mr87793671cf.19.1734601850871; 
 Thu, 19 Dec 2024 01:50:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e6778f5sm4332561cf.28.2024.12.19.01.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 01:50:50 -0800 (PST)
Message-ID: <248fbb62-3433-4a38-b93d-afcf88205e3d@redhat.com>
Date: Thu, 19 Dec 2024 10:50:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/24] vfio/migration: Multifd device state transfer
 support - send side
To: Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <4f5c33b97be09fcb4e1885073e31c5e930a39ad0.1731773021.git.maciej.szmigiero@oracle.com>
 <51279885-5229-4c5f-93af-d1214dd65f90@nvidia.com>
 <06360868-95e3-46e2-8960-51348025a1b7@maciej.szmigiero.name>
 <1ea676b5-c52a-4745-b5ce-f0376b1e6473@nvidia.com>
 <8f38a345-ad63-4168-907e-ac1cf736b2d1@maciej.szmigiero.name>
 <Z2BkbkF6P-2MHNN2@x1n>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z2BkbkF6P-2MHNN2@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On 12/16/24 18:33, Peter Xu wrote:
> On Thu, Dec 12, 2024 at 11:53:05PM +0100, Maciej S. Szmigiero wrote:
>> On 12.12.2024 15:54, Avihai Horon wrote:
>>>
>>> On 11/12/2024 1:06, Maciej S. Szmigiero wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 9.12.2024 10:28, Avihai Horon wrote:
>>>>>
>>>>> On 17/11/2024 21:20, Maciej S. Szmigiero wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>
>>>>>> Implement the multifd device state transfer via additional per-device
>>>>>> thread inside save_live_complete_precopy_thread handler.
>>>>>>
>>>>>> Switch between doing the data transfer in the new handler and doing it
>>>>>> in the old save_state handler depending on the
>>>>>> x-migration-multifd-transfer device property value.
>>>>>>
>>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>>> ---
>>>>>>    hw/vfio/migration.c  | 155 +++++++++++++++++++++++++++++++++++++++++++
>>>>>>    hw/vfio/trace-events |   2 +
>>>>>>    2 files changed, 157 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>>> index b54879fe6209..8709672ada48 100644
>>>>>> --- a/hw/vfio/migration.c
>>>>>> +++ b/hw/vfio/migration.c
>>>>>> @@ -771,6 +771,24 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>>>>>        uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>>>>>>        int ret;
>>>>>>
>>>>>> +    /*
>>>>>> +     * Make a copy of this setting at the start in case it is changed
>>>>>> +     * mid-migration.
>>>>>> +     */
>>>>>> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
>>>>>> +        migration->multifd_transfer = vfio_multifd_transfer_supported();
>>>>>> +    } else {
>>>>>> +        migration->multifd_transfer =
>>>>>> +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (migration->multifd_transfer && !vfio_multifd_transfer_supported()) {
>>>>>> +        error_setg(errp,
>>>>>> +                   "%s: Multifd device transfer requested but unsupported in the current config",
>>>>>> +                   vbasedev->name);
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>>>        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>>>>>>
>>>>>>        vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>>>>>> @@ -942,13 +960,32 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>>>>>>        return !migration->precopy_init_size && !migration->precopy_dirty_size;
>>>>>>    }
>>>>>>
>>>>>> +static void vfio_save_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
>>>>>> +{
>>>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>>>> +
>>>>>> +    assert(migration->multifd_transfer);
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Emit dummy NOP data on the main migration channel since the actual
>>>>>> +     * device state transfer is done via multifd channels.
>>>>>> +     */
>>>>>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>>>>> +}
>>>>>> +
>>>>>>    static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>>>>>    {
>>>>>>        VFIODevice *vbasedev = opaque;
>>>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>>>>        ssize_t data_size;
>>>>>>        int ret;
>>>>>>        Error *local_err = NULL;
>>>>>>
>>>>>> +    if (migration->multifd_transfer) {
>>>>>> +        vfio_save_multifd_emit_dummy_eos(vbasedev, f);
>>>>>> +        return 0;
>>>>>> +    }
>>>>>
>>>>> I wonder whether we should add a .save_live_use_thread SaveVMHandlers through which a device can indicate if it wants to save its data with the async or sync handler.
>>>>> This will allow migration layer (i.e., qemu_savevm_state_complete_precopy_iterable) to know which handler to call instead of calling both of them and letting each device implicitly decide.
>>>>> IMHO it will make the code clearer and will allow us to drop vfio_save_multifd_emit_dummy_eos().
>>>>
>>>> I think that it's not worth adding a new SaveVMHandler just for this specific
>>>> use case, considering that it's easy to handle it inside driver by emitting that
>>>> FLAG_END_OF_STATE.
>>>>
>>>> Especially considering that for compatibility with other drivers that do not
>>>> define that hypothetical new SaveVMHandler not having it defined would need to
>>>> have the same effect as it always returning "false".
>>>
>>> We already have such handlers like .is_active, .has_postcopy and .is_active_iterate.
>>> Since VFIO migration with multifd involves a lot of threads and convoluted code paths, I thought this could put some order (even if small) into things, especially if it allows us to avoid the vfio_save_multifd_emit_dummy_eos() which feels a bit hackish.
>>>
>>> But anyway, that's only my opinion, and I can understand why this could be seen as an overkill.
>>
>> @Cedric, @Peter:
>> what's your opinion here?
>>
>> Is it better to add a new "flag" SaveVMHandler or keep handling
>> the multifd/non-multifd transfer difference in the VFIO driver
>> by emitting VFIO_MIG_FLAG_END_OF_STATE in
>> vfio_save_complete_precopy() and vfio_save_state()?
>>
>> Note that this new "flag" SaveVMHandler would need to have
>> semantics of disabling both save_live_complete_precopy and
>> save_state handlers and enabling save_live_complete_precopy_thread
>> instead.
> 
> If it's about adding one more global vmstate hook (even if only used in
> vfio), only to conditionally disable two other random vmstate hooks, then
> it isn't very attractive idea to me indeed.

We will need the 'multifd_transfer' VFIO field anyhow (not sure why it
is not at the device level yet though). So I guess it is fine to keep
it that  way. However, I would rename vfio_save_multifd_emit_dummy_eos()
to something more explicit like vfio_multifd_complete_precopy().

Thanks,

C.



> 
> PS: when I look at is_active (which is only used by two sites but needs to
> be invoked in literally all the rest hooks, and I doubt whether it could
> change during migration at all..), or has_postcopy (which is weird in
> another way, e.g., should we simply forbid pmem+postcopy setup upfront?), I
> doubt whether they were the best solution for the problems.. but that's
> separate questions to ask.
> 
> Thanks,
> 


