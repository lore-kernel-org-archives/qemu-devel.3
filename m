Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F5DC55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 14:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wryer-0001Kr-DT; Thu, 06 Aug 2026 10:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wryep-0001KQ-6d
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 10:01:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wryee-0002sD-Dd
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 10:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786024862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DFcL6nzSk9FNZsidYdsO8PLizlUEBGBpBkAdJfXNnQU=;
 b=a3joMVz7aKFrCBVtSMto4wUtq9NwoHJ4xmfd8oJLYlsSuZJ+Ke89Vuy/px7gaGSalnPZLv
 +rtDvdNTWtk6VrngOBHKmWBAyQFzZ/65Ny4LxrKzdfe/iWW73L+ZI3MEYEQ8tPp26QYaWk
 rmP19GKj3cX4G1wVAO+GzUcWBdTP8kA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-zPl3qMnHM4GohIqJFiz1gQ-1; Thu, 06 Aug 2026 10:00:59 -0400
X-MC-Unique: zPl3qMnHM4GohIqJFiz1gQ-1
X-Mimecast-MFC-AGG-ID: zPl3qMnHM4GohIqJFiz1gQ_1786024859
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso2827700a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786024859; x=1786629659; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DFcL6nzSk9FNZsidYdsO8PLizlUEBGBpBkAdJfXNnQU=;
 b=BwfON41DSjsU8gES82oOnA4kpgRFniMmo+iwPj8AZlHgvzzVYYxh0kNZIcrAcgLXFV
 ekvZqYaD/uKUtWXViyhEEdeMkmNoWGVrgfLgBsveQVD8EkIBNVg06Dxt9U2aplWIX3Ke
 sV50VQdiDffksBgsAo7hDbOor8XEBqlEYwX3m5GGI+SBL41Xd7SxlkSv+YueuQ/WCI2r
 j5pZFudnj/tmaytgemKZxT4n1DvAzIAPbp6e0VRAkUN/ej31qPPWAjcP1p0G08mrXPjG
 Bp5lnBxvPaph6dG0UoE7ORSQ8qqEJQn8hPx69I1Vx7dZG+qgr24lrzCo3XyE9c1q81eF
 i9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786024859; x=1786629659;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DFcL6nzSk9FNZsidYdsO8PLizlUEBGBpBkAdJfXNnQU=;
 b=WfUzT6UoY+bj8TexeXHF0nZLpZam2v5yDGef6FkPzjFEXoCrCBFbGjzrnEyIg/DKZs
 ZY45RNalTPislbAn8sJx+ISPFZHUn+aVZSUEaEkBdRdiqrZPHEzsvLIuVLw1adgNJ/e8
 Ce88gAZxiZDr7hU5e9vYGzVfs1/gIIE2QGnc67hby1upIJVhNo5xMWRRY5BuT3QYMNN9
 mkRf/iAVPHW5ayzVWRHstRUU+E6xsiUYHqDmGw5SfkVNOAUGCWsFU/p41IwlLFG0TLZr
 EpNB9PpZUXhuR5jq4TXpe7fcWyFVLce01EJej2pxfgAL6hXHT16dnSxsXborKIdOmzSJ
 EmgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpiZ5pUxJKA8qXMJrZ9A2FrzzVwN1J7QOR6MS0M0h6r6e32HhgTWF/aesS/ZS4oGNhYgIAdBDxK9I6O@nongnu.org
X-Gm-Message-State: AOJu0YySwWRjyHDVCnxRlbEcntvrzziw0sLyPs33Ruo2BuBw/+bgiNMW
 GttrZmu39dz7EgeO0a2eDtYt43FldhKOCVXv0GNdjkC2yYvrj0ghtylzWrV/fkFcfARIGjM85tl
 uKEFzz+m3pUxQBLNjdF4kL+4l17fT/JRaTqPd2UbgmGjXvkcdkqh4K/UT
X-Gm-Gg: AR+sD12P2HFRb3xXrXGigDzoU3oTsr07tAeqROem4mkBnshEHuYcbXp6neudDmt4lsn
 fWo0qATrsfiOcXnqval2iv3oATXYkzjjdDrRPWlXYQQTEj1TkjTpIs1fPdgEfzAfQOyoKR45cif
 2ANELsx5k0U7y+kNaK0yFUZqZ/5LNp4v8cKQeVQ/j5CCZDGx+mU8T4dBztg0nlcL8oGz/sQ/X24
 KLrgFSB/xu1FlTeTh3VO+FfD4b6p9LSO38KLIDHVY3828vuG8Nf7jeoy/Gg50EOaztCw9mavQIz
 YW3VgdWURq/vNPQ2LcowatDF/geywT6xp9GSRATTYqJoI0+nEEsTMo1MHnz3c1vMqOJQ/ESX4NM
 S/LXaoGX8YNWB1y/iIKtPdG3DrT5zlNQqzl49rODpcHouQXTQuhj8/g==
X-Received: by 2002:a05:6a21:687:b0:3cb:7b9d:9869 with SMTP id
 adf61e73a8af0-3cb85f4a600mr19423377637.35.1786024858360; 
 Thu, 06 Aug 2026 07:00:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:687:b0:3cb:7b9d:9869 with SMTP id
 adf61e73a8af0-3cb85f4a600mr19423217637.35.1786024857687; 
 Thu, 06 Aug 2026 07:00:57 -0700 (PDT)
Received: from smtpclient.apple ([106.219.133.98])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca63ce12sm30779122c88.5.2026.08.06.07.00.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Aug 2026 07:00:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3 2/9] igvm: track memory regions
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CDBE831E-F919-4E1F-802B-64D34D20634A@redhat.com>
Date: Thu, 6 Aug 2026 19:30:42 +0530
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alexander Graf <graf@amazon.com>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <19BDF5F1-68AA-46A6-BB8E-043F694AF851@redhat.com>
References: <20260730071254.80695-1-anisinha@redhat.com>
 <20260730071254.80695-3-anisinha@redhat.com>
 <96ad911f-6f07-4616-b911-617dde2f12de@csgraf.de>
 <C1C5D784-4C75-4FE6-BEEA-F879C73E0D7B@redhat.com>
 <CAK3XEhPmh0jtSK=zZ5SjBzT6c_P6J7JW2B42k5cJzOK-vyOkKg@mail.gmail.com>
 <CDBE831E-F919-4E1F-802B-64D34D20634A@redhat.com>
To: Alexander Graf <agraf@csgraf.de>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 6 Aug 2026, at 12:59=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 1 Aug 2026, at 7:57=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>>=20
>> On Sat, Aug 1, 2026 at 5:58=E2=80=AFPM Ani Sinha =
<anisinha@redhat.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On 31 Jul 2026, at 3:28=E2=80=AFPM, Alexander Graf =
<agraf@csgraf.de> wrote:
>>>>=20
>>>>=20
>>>> On 30.07.26 09:12, Ani Sinha wrote:
>>>>> From: Gerd Hoffmann <kraxel@redhat.com>
>>>>>=20
>>>>> Memory regions added by the current IGVM needs to be tracked so =
that they can be
>>>>> freed when a new IGVM is loaded.
>>>>>=20
>>>>> Reviewed-by: Ani Sinha <anisinha@redhat.com>
>>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>>>> ---
>>>>> backends/igvm-cfg.c            |  1 +
>>>>> backends/igvm.c                | 20 ++++++++++++--------
>>>>> include/system/igvm-internal.h |  6 ++++++
>>>>> 3 files changed, 19 insertions(+), 8 deletions(-)
>>>>>=20
>>>>> diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>>>>> index e1f09855f6..38438a7b1e 100644
>>>>> --- a/backends/igvm-cfg.c
>>>>> +++ b/backends/igvm-cfg.c
>>>>> @@ -65,6 +65,7 @@ static void igvm_complete(UserCreatable *uc, =
Error **errp)
>>>>>    IgvmCfg *igvm =3D IGVM_CFG(uc);
>>>>>      igvm->file =3D qigvm_file_init(igvm->filename, errp);
>>>>> +    QTAILQ_INIT(&igvm->memory_regions);
>>>>> }
>>>>>  OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, =
OBJECT,
>>>>> diff --git a/backends/igvm.c b/backends/igvm.c
>>>>> index 534032fed8..9e7c90d386 100644
>>>>> --- a/backends/igvm.c
>>>>> +++ b/backends/igvm.c
>>>>> @@ -220,7 +220,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, =
uint64_t addr, uint64_t size,
>>>>>                                  int region_identifier, Error =
**errp)
>>>>> {
>>>>>    ERRP_GUARD();
>>>>> -    MemoryRegion *igvm_pages =3D NULL;
>>>>> +    IgvmMemoryRegion *imr =3D NULL;
>>>>>    Int128 gpa_region_size;
>>>>>    MemoryRegionSection mrs =3D
>>>>>        memory_region_find(get_system_memory(), addr, size);
>>>>> @@ -254,23 +254,27 @@ static void *qigvm_prepare_memory(QIgvm =
*ctx, uint64_t addr, uint64_t size,
>>>>>         */
>>>>>        g_autofree char *region_name =3D
>>>>>            g_strdup_printf("igvm.%X", region_identifier);
>>>>> -        igvm_pages =3D g_new0(MemoryRegion, 1);
>>>>> +        imr =3D g_new0(IgvmMemoryRegion, 1);
>>>>> +        imr->mr =3D g_new0(MemoryRegion, 1);
>>>>>        if (ctx->machine_state->cgs &&
>>>>>            ctx->machine_state->cgs->require_guest_memfd) {
>>>>> -            if (!memory_region_init_ram_guest_memfd(igvm_pages, =
NULL,
>>>>> +            if (!memory_region_init_ram_guest_memfd(imr->mr, =
NULL,
>>>>=20
>>>>=20
>>>> Please make sure to track them with owner set to =
OBJECT(ctx->machine_state).
>>>=20
>>> This will not work as the owner will have to be of TYPE_DEVICE not =
of TYPE_MACHINE.
>>=20
>> Looking closer, these memory regions are subregions of system_mmeory.
>> system_memory is initialized with owner as NULL in memory_map_init().
>>=20
>> memory_region_finalize() says .,,
>>=20
>> Here it is possible that the MR has:
>> mr->container set, which means this MR is a subregion of a
>>    container MR. In this case they must share the same owner as the
>>    container (otherwise the container should have kept a refcount
>>    of this MR's owner).
>>=20
>> And then there is this assertion:
>>=20
>> /* Must share the owner; see above comments */
>>       assert(mr->container->owner =3D=3D mr->owner);
>>=20
>> So i think the owner should be NULL.
>>=20
>> I think that means we should garbage collect system_memory and its =
sub-regions?
>=20
> I looked at this deeply and I believe this change triggers the mr =
cleanup:
>=20
> diff --git a/backends/igvm.c b/backends/igvm.c
> index da09e6195c..44cf74dfc6 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -1124,11 +1124,9 @@ void qigvm_cleanup_memory(IgvmCfg *cfg)
>         memory_region_del_subregion(get_system_memory(), imr->mr);
>         vmstate_unregister_ram(imr->mr, NULL);
>         QTAILQ_REMOVE(&cfg->memory_regions, imr, next);
> -        /*
> -         * imr->mr will be freed when all references to the memory
> -         * region are dropped. Freeing it here will cause memory
> -         * corruption.
> -         */
> +        /* this triggers MemoryRegion cleanup */
> +        object_unparent(OBJECT(imr->mr));
> +        imr->mr =3D NULL;
          ^^^^^^^^^^^^^^^^
I suppose that is unnecessary as imr is getting freed right away.

>         g_free(imr);
>     }
> }


