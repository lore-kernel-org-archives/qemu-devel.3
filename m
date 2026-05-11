Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D144CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 11:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMOZB-00068V-BU; Mon, 11 May 2026 07:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMOZ8-00068D-Mc
 for qemu-devel@nongnu.org; Mon, 11 May 2026 07:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMOZ3-00008a-Ba
 for qemu-devel@nongnu.org; Mon, 11 May 2026 07:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778497963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=biDOJU/4uDY8XQVLX8vji2RrDLcf7kNzlfgt6BFNVhA=;
 b=EtJl/S/9kQRiNXUG2DXYXjugbgNtPM9UyTASQI6TuHouQAtUJPIYd8UkRGdivxBNEi67oQ
 RfhK0Nq7rXiSc8N/9BMnzMi785MpeDmmT581QzTMKslZTlyKHP7P9KqxuvQFDvmyqn0U9t
 LS6lnJD3NbGpyAkQuT37FgDAfDcI3Vc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-7w3R9QS1OfCLB_K7nkKNTA-1; Mon, 11 May 2026 07:12:41 -0400
X-MC-Unique: 7w3R9QS1OfCLB_K7nkKNTA-1
X-Mimecast-MFC-AGG-ID: 7w3R9QS1OfCLB_K7nkKNTA_1778497960
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48d1bc85bb3so21451625e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778497960; x=1779102760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=biDOJU/4uDY8XQVLX8vji2RrDLcf7kNzlfgt6BFNVhA=;
 b=NAjdFVPTVPxzZdWRtvl/ZZNkDKCN8mFm2JHTrs630/CM1OARlkatUvzGdLXa+nIBTQ
 ZDcL4xO5kW4vxlANQVv/m+UrQYU/iFUHXozyaQ/kP2jiWf+xALAxoYj58pqcugBWkQyI
 GmX8TZ/q0ozE5VHu4oTrcYWg1nrSouUhlwFLfxd6Ik/YZ14lDu5/gFXbEPoLcu7y6iTr
 sLKqWU25rcqajtYMtO5LpAmKVaVh+mu3fUV3fjr2rWzVCigR2i4DE4QfL1sh4imuuyk4
 //gK56cfJqLT7uyqqDKRirPg/O1M7JW0bhwef//Giu8vcAc0sORZ37F8vR89kOWTUTyM
 rTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778497960; x=1779102760;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=biDOJU/4uDY8XQVLX8vji2RrDLcf7kNzlfgt6BFNVhA=;
 b=Q9ke4+XLd0Um8bPYNhK6RSd3VKGUwmnnb+uwEtEkEXM6YEs9fUzLAyxJ5Vhdr2z25c
 RZrvBEOJ/CrmPyEMwC2OxoOSLcU3PvynlhFsaBhiToct4iZWYyFx3vGktLLeb3GeD8k3
 2eR5OGbY3VIuuP7baMKAHUo+mc7el7VVvTXumcAsfYh6xPUtB2HgzH7BEbwAkdT5ZsX6
 /QSTM8o+CX6WCW2qf9nnZu7xk6JLCbatWmxlrNKg+IZOFj4Xj8htOqnA1rAGl00saFiy
 970EWWV+26wwgziTJwchfFD4zMhjljr7Bj/eeeoDAfcTN8v9wSU3bd/mivYNlFrTHSLS
 7vIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RKaJwVlzQAlTMaI6sRoL5yB/YOHCua82Ip+lQ1NOpZjhPTg3FZJVcrYvohoM2F2ebQtxPW7Zi9buO@nongnu.org
X-Gm-Message-State: AOJu0YxPHHXySK7W8CRqW83t12jc64NWNh6dnptwLz5DE7ffDYyB9k9z
 sFYMJ3yw/6vwGD8JhAbJR+aOvGR4IOfoGLAtiDZkjEEQPhJUJjyVM/CG89DPEwRRUzkZCL7DGzr
 o2HIGcz496Rex0c+EoJ4eKJf8a24gcyG8I6Lu5IUasRpa3QMigfBVZAlc
X-Gm-Gg: Acq92OHFcbn1f19nQ8ss3c1GGvueSz9NOUPe3KqQUab5LGiExQqlCOO8fYsXsJErDvG
 stS1BI4Gk+k8f+5EM3/1c5eKYX+Nh56c63Ivd6CdGKyyIWgHGX6vPu9Gss5dujxvuOyzPoalmj2
 W4nIiAAXwIH6hxKTuNL+V7hnfl1TqeTVky6AixgqSrNCwvLJUnvU0icjRZtoXwBaPk8S2dBa7KJ
 cmsbkYUHBTaN+4Gb4jPOHx63hwBv2GwNJ81yjr6y6KZ501J3NpQVSL5ZwcvLynqrYn+iPCaiKwD
 NylMozD33sB9mRLIO/2yOnXnk2O6cWR0XrA4TceSoC1lRk2z7QzaApGf6XJidVbd81C7dkOUEEl
 6cVCkow419xZxsUCZYg9zyY4hT3kIhv5uy7IaUF0m2oPe5JahDQI1TeVUixAo
X-Received: by 2002:a05:600c:3e10:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-48e5e0089e0mr285525035e9.13.1778497960266; 
 Mon, 11 May 2026 04:12:40 -0700 (PDT)
X-Received: by 2002:a05:600c:3e10:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-48e5e0089e0mr285524485e9.13.1778497959720; 
 Mon, 11 May 2026 04:12:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6db0fed0sm62298445e9.25.2026.05.11.04.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 04:12:39 -0700 (PDT)
Message-ID: <d2c85596-9a9b-406a-b3fe-f4c871f489ed@redhat.com>
Date: Mon, 11 May 2026 13:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/46] hw/fsi: move OPBus address space init to realize
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
 <20260504-qom-tests-v2-33-ef7e3dc94f7a@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260504-qom-tests-v2-33-ef7e3dc94f7a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/4/26 13:35, Marc-André Lureau wrote:
> The OPBus instance_init initializes an AddressSpace, registering it in
> the global address_spaces list. When a bare OPBus object is created
> and destroyed (e.g. by qom-tests), there is no finalize to remove the
> stale entry, leading to a heap-use-after-free when a subsequent
> flatviews_reset iterates the list.
> 
> Move address_space_init to the bus realize callback and add the
> corresponding address_space_destroy in unrealize, following the
> NubusBus pattern. Also fix the memory_region_init owner from NULL to
> the OPBus object, so the MR is properly parented instead of dangling
> under the "unattached" container.
> 
> Fixes: eb04c35da2c0 ("hw/fsi: Aspeed APB2OPB & On-chip peripheral bus")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/fsi/aspeed_apb2opb.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c
> index b9d72f3ecf6..36092468391 100644
> --- a/hw/fsi/aspeed_apb2opb.c
> +++ b/hw/fsi/aspeed_apb2opb.c
> @@ -348,15 +348,37 @@ static void fsi_opb_init(Object *o)
>   {
>       OPBus *opb = OP_BUS(o);
>   
> -    memory_region_init(&opb->mr, 0, TYPE_FSI_OPB, UINT32_MAX);
> +    memory_region_init(&opb->mr, o, TYPE_FSI_OPB, UINT32_MAX);
> +}
> +
> +static void fsi_opb_realize(BusState *bus, Error **errp)
> +{
> +    OPBus *opb = OP_BUS(bus);
> +
>       address_space_init(&opb->as, &opb->mr, TYPE_FSI_OPB);
>   }
>   
> +static void fsi_opb_unrealize(BusState *bus)
> +{
> +    OPBus *opb = OP_BUS(bus);
> +
> +    address_space_destroy(&opb->as);
> +}
> +
> +static void fsi_opb_class_init(ObjectClass *klass, const void *data)
> +{
> +    BusClass *bc = BUS_CLASS(klass);
> +
> +    bc->realize = fsi_opb_realize;
> +    bc->unrealize = fsi_opb_unrealize;
> +}
> +
>   static const TypeInfo opb_info = {
>       .name = TYPE_OP_BUS,
>       .parent = TYPE_BUS,
>       .instance_init = fsi_opb_init,
>       .instance_size = sizeof(OPBus),
> +    .class_init = fsi_opb_class_init,
>   };
>   
>   static void fsi_opb_register_types(void)
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



