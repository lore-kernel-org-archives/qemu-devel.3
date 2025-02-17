Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FE8C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 09:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjxaT-0006vd-T5; Mon, 17 Feb 2025 04:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tjxaQ-0006vF-Tf
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 04:38:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tjxaO-0002Iq-FR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 04:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739785122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BL3J11jDAOtZMkoT3BA+cibVN4Qe+20Md/Ho1vLr314=;
 b=WV+XYeZ37Xi22mjJkogpSK4474X2P3iSJhP1UEUSYLB6gkBObYhMQQ8FQEFKncm0CpuvZ4
 qdN2ua17K3/gXqsSUGuHSIiqZ17ksy+U4Ks59hnDQZxOt/UEoCK/ePaoDClpYIqETjcw8k
 O1IEgDoL1G49at9NlCKCx+9njCtnL3E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-Tvuzv54XO4mS6INAxJ3a-w-1; Mon, 17 Feb 2025 04:38:39 -0500
X-MC-Unique: Tvuzv54XO4mS6INAxJ3a-w-1
X-Mimecast-MFC-AGG-ID: Tvuzv54XO4mS6INAxJ3a-w_1739785118
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4393e89e910so21665875e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 01:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739785118; x=1740389918;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BL3J11jDAOtZMkoT3BA+cibVN4Qe+20Md/Ho1vLr314=;
 b=Z4m9hGHTjxR+O3msd3uaOEGXYN7+HNchlYHhP7Qx4UKceWwsRyxiBrmywdccNyOXBR
 YgkwAADjEIuFGY9wEyLEGShQV2vYzbbDhehDErXhrLfllDxn7IE26a/VVyp+tAZV0ABg
 V520XL3f0pNCq+smK48++AEK+FFOcXAu45CxmBUZaO8++HyvWNt2sXOLR1FlHB6LVYFZ
 e7ZaTKWD+G8mAxUmZaLV/Xnn3VchzcVO+nhmgaljuCpnJVQa9yGUyHTgw9wtcdlE05Zm
 y2Fn3sfYLTn2SS2Uz+fT4HRQthGY2kf5Chd+aXAe35ZYC60vTsDIK4iyXEgQ4fJ/hkoe
 hugw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6qOUSuMCxyXpPJSONVCre2aKunmsaYOn9Jp5jFUC2Mnw8nuUV+4iIS40AoOKZwyE7/zEI/PGfEZNr@nongnu.org
X-Gm-Message-State: AOJu0YyEnLy4cPZvbcVw7ST0fixcwXyJzA04a+JKnygIltaYGclOfv1H
 eHaaTm8TiVzjQgthAYWXU5FPlc7EI49mEIKSR0+Bdwlj2Q1e4tYfwCwyZR9B9XiwxfY3DU2J8Q0
 eC7uMszQoRBFNOfxxLjy163Jzd/PxJMiMNcqB5UL7tr6krMVbT3Nc
X-Gm-Gg: ASbGncu8bLgMMFb0cjlhW/1Useh6MSGvN1UB7Xd2hlrUdflyDWDJ1kn9+AtH2l4hxeo
 K+fDKx0Ny+C0ltcmIo8qH1LT4SNd5KsnSvnUY5x1FXJlNmwoDzpxFrxpTnNvqAiT3hSjfXyNCCb
 xzyj1wMSBLl4QuXyjV9mqyqqOvl1u7d6BhG1xj9rxctrUjGjTvvKR5p48xdYe4Ni57/5dke0b5v
 FamYvXJ47PkXohE647q6cI1VdTE3pw6MOWYgzmL6ewJhqO0T611uVDjc60D7OBbObptII7GYv4p
 mVOC2gjNZtxKuBzOwCrlij4JhDnDNds640IyA7lL
X-Received: by 2002:a05:600c:3b03:b0:439:57b5:f8a0 with SMTP id
 5b1f17b1804b1-4396e739a6dmr63184395e9.24.1739785118269; 
 Mon, 17 Feb 2025 01:38:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnF9HUFdzyS1CiagMvf+jWwkU6Bob5opKPYea0+mSC0Is7DQlwJBrhCaMKlC2QDysQh/S0Ug==
X-Received: by 2002:a05:600c:3b03:b0:439:57b5:f8a0 with SMTP id
 5b1f17b1804b1-4396e739a6dmr63184085e9.24.1739785117811; 
 Mon, 17 Feb 2025 01:38:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ddbe0sm11893516f8f.39.2025.02.17.01.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 01:38:37 -0800 (PST)
Message-ID: <c614346e-a625-427e-a6a7-03a885e7fce4@redhat.com>
Date: Mon, 17 Feb 2025 10:38:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/33] vfio/migration: Multifd device state transfer
 support - receive init/cleanup
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <1fcf182307e8e1f67a3c226e62d26cad3a2f60d0.1738171076.git.maciej.szmigiero@oracle.com>
 <6c337aec-d004-4ede-a86b-0c934b275fa9@redhat.com>
 <1ab2d96f-f37d-466e-83db-0e3d39581bc7@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1ab2d96f-f37d-466e-83db-0e3d39581bc7@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On 2/14/25 21:55, Maciej S. Szmigiero wrote:
> On 12.02.2025 11:55, Cédric Le Goater wrote:
>> On 1/30/25 11:08, Maciej S. Szmigiero wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Add support for VFIOMultifd data structure that will contain most of the
>>> receive-side data together with its init/cleanup methods.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration.c           | 52 +++++++++++++++++++++++++++++++++--
>>>   include/hw/vfio/vfio-common.h |  5 ++++
>>>   2 files changed, 55 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 3211041939c6..bcdf204d5cf4 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -300,6 +300,9 @@ typedef struct VFIOStateBuffer {
>>>       size_t len;
>>>   } VFIOStateBuffer;
>>> +typedef struct VFIOMultifd {
>>> +} VFIOMultifd;
>>> +
>>>   static void vfio_state_buffer_clear(gpointer data)
>>>   {
>>>       VFIOStateBuffer *lb = data;
>>> @@ -398,6 +401,18 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>>>       return qemu_file_get_error(f);
>>>   }
>>> +static VFIOMultifd *vfio_multifd_new(void)
>>> +{
>>> +    VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
>>> +
>>> +    return multifd;
>>> +}
>>> +
>>> +static void vfio_multifd_free(VFIOMultifd *multifd)
>>> +{
>>> +    g_free(multifd);
>>> +}
>>> +
>>>   static void vfio_migration_cleanup(VFIODevice *vbasedev)
>>>   {
>>>       VFIOMigration *migration = vbasedev->migration;
>>> @@ -785,14 +800,47 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>>>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>>   {
>>>       VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    int ret;
>>> +
>>> +    /*
>>> +     * Make a copy of this setting at the start in case it is changed
>>> +     * mid-migration.
>>> +     */
>>> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
>>> +        migration->multifd_transfer = vfio_multifd_transfer_supported();
>>
>> Attribute "migration->multifd_transfer" is not necessary. It can be
>> replaced by a small inline helper testing pointer migration->multifd
>> and this routine can use a local variable instead.
> 
> It's necessary for the send side since it does not need/allocate VFIOMultifd
> at migration->multifd, so this (receive) side can use it for commonality too.

Hmm, we can allocate migration->multifd on the send side too, even
if the attributes are unused and it is up to vfio_multifd_free() to
make the difference between the send/recv side.


Something that is bothering me is the lack of introspection tools
and statistics. What could be possibly added under VFIOMultifd and
VfioStats ?

>> I don't think the '_transfer' suffix adds much to the understanding.
> 
> The migration->multifd was already taken by VFIOMultifd struct, but
> it could use other name (migration->multifd_switch? migration->multifd_on?).

yeah. Let's try to get rid of it first.
  
>>> +    } else {
>>> +        migration->multifd_transfer =
>>> +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
>>> +    }
>>> +
>>> +    if (migration->multifd_transfer && !vfio_multifd_transfer_supported()) {
>>> +        error_setg(errp,
>>> +                   "%s: Multifd device transfer requested but unsupported in the current config",
>>> +                   vbasedev->name);
>>> +        return -EINVAL;
>>> +    }
>>
>> The above checks are also introduced in vfio_save_setup(). Please
>> implement a common routine vfio_multifd_is_enabled() or some other
>> name.
> 
> Done (as common vfio_multifd_transfer_setup()).

vfio_multifd_is_enabled() please, returning a bool.

> 
>>> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>>> +                                   migration->device_state, errp);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    if (migration->multifd_transfer) {
>>> +        assert(!migration->multifd);
>>> +        migration->multifd = vfio_multifd_new();
>>> +    }
>>> -    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>>> -                                    vbasedev->migration->device_state, errp);
>>> +    return 0;
>>>   }
>>>   static int vfio_load_cleanup(void *opaque)
>>>   {
>>>       VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +
>>> +    g_clear_pointer(&migration->multifd, vfio_multifd_free);
>>
>> please add a vfio_multifd_cleanup() routine.
>>
> 
> Done.
> 
>>>       vfio_migration_cleanup(vbasedev);
>>>       trace_vfio_load_cleanup(vbasedev->name);
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 153d03745dc7..c0c9c0b1b263 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -61,6 +61,8 @@ typedef struct VFIORegion {
>>>       uint8_t nr; /* cache the region number for debug */
>>>   } VFIORegion;
>>> +typedef struct VFIOMultifd VFIOMultifd;
>>> +
>>>   typedef struct VFIOMigration {
>>>       struct VFIODevice *vbasedev;
>>>       VMChangeStateEntry *vm_state;
>>> @@ -72,6 +74,8 @@ typedef struct VFIOMigration {
>>>       uint64_t mig_flags;
>>>       uint64_t precopy_init_size;
>>>       uint64_t precopy_dirty_size;
>>> +    bool multifd_transfer;
>>> +    VFIOMultifd *multifd;
>>>       bool initial_data_sent;
>>>       bool event_save_iterate_started;
>>> @@ -133,6 +137,7 @@ typedef struct VFIODevice {
>>>       bool no_mmap;
>>>       bool ram_block_discard_allowed;
>>>       OnOffAuto enable_migration;
>>> +    OnOffAuto migration_multifd_transfer;
>>
>> This property should be added at the end of the series, with documentation,
>> and used in the vfio_multifd_some_name() routine I mentioned above.
>>
> 
> The property behind this variable *is* in fact introduced at the end of the series -
> in a commit called "vfio/migration: Add x-migration-multifd-transfer VFIO property"
> after which there are only commits adding the related compat entry and a VFIO
> developer doc update.
> 
> The variable itself needs to be introduced earlier since various newly
> introduced code blocks depend on its value to only get activated when multifd
> transfer is enabled.

Not if you introduce a vfio_multifd_is_enabled() routine hiding
the details. In that case, the property and attribute can be added
at the end of the series and you don't need to add the attribute
earlier.


Thanks,

C.




