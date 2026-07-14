Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7226EC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjal4-0008Kb-Qf; Tue, 14 Jul 2026 06:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wjal2-0008KE-VE
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wjakz-0003Fb-QK
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784026377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2PTzILu9qclnqywy4EwJ0RRR+3PTplTn770qnj4URY=;
 b=ZGk1YCtL6SrAj8QGAe1I7l3fvKyHKvQQCfF9PT7ftPSsxqhdaze+zeASX3jzcFWeTImg+Z
 fWJxL1p/2Q75dlhT6Qrv6FY0JRpMih21G0rQBHpyF1mrT91IHRQq5IX6/g45y5L5COH4WA
 mPXjqBuCKwc1e3qFP4IlkQKs10dikIY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-aCRqS7ydP8uAvezyjzqIhg-1; Tue, 14 Jul 2026 06:52:53 -0400
X-MC-Unique: aCRqS7ydP8uAvezyjzqIhg-1
X-Mimecast-MFC-AGG-ID: aCRqS7ydP8uAvezyjzqIhg_1784026373
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38dc4401dc7so1001140a91.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 03:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784026373; x=1784631173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a2PTzILu9qclnqywy4EwJ0RRR+3PTplTn770qnj4URY=;
 b=CEf8hjVFbVo7PxO006jBtayhKpU4k3ew6xYTvZlA6ZzG+WDapgRpEmJg2skbrh5C4k
 N86v8EvYiC33QJMU+1ACR1pKUqd2HnrV9e7oxFPGeMZAiLaJYHDEfFEAPht3IzZaVVVi
 zhVn2w0jYUUH5XRJnYhzSA+Mv6zE3x6pvLJ/Qh/vea+qda4JkIZogrC0fOS/Tv96rohq
 43M6zM1vFolxn1OCZVVP9iq53BCaHJzVKkwtxh1oeVN1n1y2polImGZuv41eV683WO/q
 xpTEg9au0ay/8MS15FWDnHK8nu5E+r731Q8SFgL1jlk8Byk5Lk+BnSDgZ6gyMgx22OdW
 3XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784026373; x=1784631173;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a2PTzILu9qclnqywy4EwJ0RRR+3PTplTn770qnj4URY=;
 b=jxaeXJswVaVCc+chLFF1WN1TtT8ot8uZBtZlFNMEkTSlzbQkk/CMlNFdVUpYitadtr
 D/rPvaKtalPNMHX6DglD4LSy7eQprfDDFtFn1+OTCASHPTcncIVdpKj5cNyTcia4csnN
 vwzRybycFjCOZGQmgSHtguj408EOIfWYjqtTesFPdByUOvmvj4qQtr/U8LMpDt+LvWkF
 ExWykVaiiOSaYLuMMkb2KMTk9VnV96oej3Z9NSbCNg+tVaxpmmnEOl7bDyFP17PurUtc
 AXUBR9wS2jC5sq0vx6t6sjVAkx3OIoaWB5kb8M0k4mHV2tY8EVrDpbz3l8KsF/2vPn6X
 VLQA==
X-Gm-Message-State: AOJu0YzwwRJT7AkVzsJwGPjZEAS5tv6oeaLAGWP3dYefrWLFSIpmRXJQ
 uD5nD7x5w6QUVZ7oi1DxnE5/haZHX0kgM+1xwaLdL/qa31gjcnF7VanD7XaVA/pxjJWrCJIZDrh
 YUcbrHc2vU/aXLGqxzx+/ytmlIL/U+m04p3NGSuc+A/LskITNs/emhA/G
X-Gm-Gg: AfdE7cmojOOe2RlSUyO0pv6uY7Foj3v5wwRzZqg59XpUTWYrm/KtOtCWD5SAkFeWCoA
 oWsuarnpDIJNfIhC1xsa1fUiKigZweMJheitQPf6YtbI3y6E+b1yiKrMrMs89CWLDdAPQ0Dy94P
 bdqGNewi4FqJ84xysmhKIum1YYgLz0IsUogYnI3jwlgLq94VR5VJoUIhYQnENrlxfCIJT6TOHvz
 R2XAsN6BchMdSmZ6rEc4cQqbb/mT55bSJrCeR4ZNbXqDa0vDdjGgoI7/rG8XVrv333sco1XmCa/
 P4O5/z6ZwvR6Cwp0yCZ1FC7XwRp/wmN8Fj5AKpStQIVxAoJfh4VG0Qlax08gp/HdN4ate+V6g9/
 UA98wfRu1X7foVeuwyV55IMVvtynqXPRXqRufIkbl84TYRa9Tq6i2oA==
X-Received: by 2002:a17:90b:3e44:b0:38e:21da:9257 with SMTP id
 98e67ed59e1d1-38e21da9302mr743564a91.37.1784026372673; 
 Tue, 14 Jul 2026 03:52:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3e44:b0:38e:21da:9257 with SMTP id
 98e67ed59e1d1-38e21da9302mr743524a91.37.1784026372146; 
 Tue, 14 Jul 2026 03:52:52 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e172cf625sm1297479a91.7.2026.07.14.03.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 03:52:51 -0700 (PDT)
Message-ID: <47136344-8e15-498a-a4fb-0dbbb0c71861@redhat.com>
Date: Tue, 14 Jul 2026 20:52:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 10/25] hw/core/loader: Add a ROM loader notifier
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-11-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-11-mathieu.poirier@linaro.org>
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
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Add a function to register a notifier that is invoked when ROMs get
> loaded into guest memory.
> 
> It will be used by Arm confidential guest support, in order to register
> all blobs loaded into memory with KVM, so that their content is moved
> into Realm state and measured into the initial VM state.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   hw/core/loader.c         | 15 +++++++++++++++
>   include/hw/core/loader.h | 17 +++++++++++++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 5cbfba0a86d2..b3d769bec5cb 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -74,6 +74,8 @@
>   #endif
>   

The (edk2) firmware for the realm guest can be specified by the legacy
'-drive if=pflash' or '-bios'. The memory region corresponding to the
firmware image specified by '-bios' is recorded by the newly added notifier
and populated to TF-RMM properly.

I don't see how the memory region corresponding to (edk2) firmware image
specified by '-drive if=pflash' is recorded and populated to TF-RMM
accordingly in this series. So I guess '-drive if=pflash' isn't supported
yet?

Note that I didn't give '-drive if=pflash' a try yet.

>   static int roms_loaded;
> +static NotifierList rom_loader_notifier =
> +    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
>   
>   /* return the size or -1 if error */
>   int64_t get_image_size(const char *filename, Error **errp)
> @@ -1201,6 +1203,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
>       return mr;
>   }
>   
> +void rom_add_load_notifier(Notifier *notifier)
> +{
> +    notifier_list_add(&rom_loader_notifier, notifier);
> +}
> +
>   /* This function is specific for elf program because we don't need to allocate
>    * all the rom. We just allocate the first part and the rest is just zeros. This
>    * is why romsize and datasize are different. Also, this function takes its own
> @@ -1242,6 +1249,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
>   static void rom_reset(void *unused)
>   {
>       Rom *rom;
> +    RomLoaderNotifyData notify;
>   
>       QTAILQ_FOREACH(rom, &roms, next) {
>           if (rom->fw_file) {
> @@ -1290,6 +1298,13 @@ static void rom_reset(void *unused)
>           address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
>   
>           trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
> +
> +        notify = (RomLoaderNotifyData) {
> +            .addr = rom->addr,
> +            .len = rom->datasize,
> +            .as = rom->as,
> +        };
> +        notifier_list_notify(&rom_loader_notifier, &notify);
>       }
>   }
>   
> diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
> index d9431e8a8d12..94cf6ad2e26b 100644
> --- a/include/hw/core/loader.h
> +++ b/include/hw/core/loader.h
> @@ -342,6 +342,23 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
>   ssize_t rom_add_vga(const char *file);
>   ssize_t rom_add_option(const char *file, int32_t bootindex);
>   
> +typedef struct RomLoaderNotifyData {
> +    /* Address of the blob in guest memory */
> +    hwaddr addr;
> +    /* Length of the blob */
> +    size_t len;
> +    /* Address space of the blob */
> +    AddressSpace *as;
> +} RomLoaderNotifyData;
> +
> +/**
> + * rom_add_load_notifier - Add a notifier for loaded images
> + *
> + * Add a notifier that will be invoked with a RomLoaderNotifyData structure for
> + * each blob loaded into guest memory, after the blob is loaded.
> + */
> +void rom_add_load_notifier(Notifier *notifier);
> +
>   /* This is the usual maximum in uboot, so if a uImage overflows this, it would
>    * overflow on real hardware too. */
>   #define UBOOT_MAX_DECOMPRESSED_BYTES (64 << 20)

Thanks,
Gavin


