Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D3ACEBF92
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHGS-0006Mf-PP; Tue, 18 Nov 2025 03:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vLHGQ-0006M5-QB
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:40:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vLHGO-00011h-FQ
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763455233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Xc+rUORU/lDSsD05uqBuPegrD+R7PY0yCHLp555auoQ=;
 b=Fl2L+eNBtfBM1GXUsogIz1XXAza6WX0ZJoW5HCK+39S0fEv8NzeUP9ssSQAuO7J4/SOr6i
 WLsD3lXUJlupKtzSu48N1ifiMqeBmRDQyJaZnmXqJ0N8NrI+X1mle9EgidDs+E8VNle358
 1eEhRqGRQ++AJBv6gezVS3QkbJDvFn4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-e-qlioinN4KqVAVlaapjzg-1; Tue, 18 Nov 2025 03:40:31 -0500
X-MC-Unique: e-qlioinN4KqVAVlaapjzg-1
X-Mimecast-MFC-AGG-ID: e-qlioinN4KqVAVlaapjzg_1763455231
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso40535375e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 00:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763455231; x=1764060031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Xc+rUORU/lDSsD05uqBuPegrD+R7PY0yCHLp555auoQ=;
 b=fYEblbH6XO0BKuH6DANuEDJq8kUK1oZ3tNQkRJnb0cbMA4ulQwAsNaM/INd36I2NdA
 OgKOfkzs1s/ziuVrmUTve7z0CsmWguwxDXdruKb81otJ6AvuiIFEYn7gSYtk0+i0yH0o
 wxzwcTfUBOaOLogsc1Xf41SuggXKmlPVsDU7J0L95yPl2UuzFNUqzR6DyG9oFbZA3DVj
 4HK2plSaNh53F1oO066qvs4wGw47kcu0xLM8oiRl3GyyutoszKEcSK5i+0BsZIqjZZ2o
 0koRCCzlJ/sowfqXYMA4L670Y+awtvWjY5ociSNopd7lnvDySg1A82vYkYK27BJK9NGv
 jxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763455231; x=1764060031;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xc+rUORU/lDSsD05uqBuPegrD+R7PY0yCHLp555auoQ=;
 b=siksuwHlf4rEepoPnjstKmKCy3lSpWNX8ONBJdyJ+AyKBXkyQ/85FK2/tdaz6tDoWv
 O8MAl7JSH8SACQW09RoHt2Lz9UyC16o581LmzjwwH8kWYorLgPhfPX0DwScISjH+jNc2
 i8HWFWnPQp3NXHCnmglG5EG53WH1sUu5f8daocjzy4KnAXByAG4InjkhI+zr6VP0GQ74
 Ug4rNQpeVOkGEd/jYFp5eYlUuQZjKaI1xPmvGKUu9psL03wBUMk9i7DBpD0p3STuaqXv
 9lzpgMW5nS/yK0IjbkKmNwJrbolYhNdmASC/JQglrT4loqyAOW5L1UU3K+4y19Ez6I8h
 BcoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXwkiXa0Wm+mO61Lo+3gHjMVTgWmNVcUhJ3OzVezvoSEHllq4valYQXuMfGlFnh7Nq+qh4FSeTbw7j@nongnu.org
X-Gm-Message-State: AOJu0Yyjb2tiJl2YtHZnD4CPs21TFTFuBD6VTHC8YYN18yL/aMkPF91b
 aAkfo/YAINc1oE2mXcRQDEpThqqwsmo1OiPC8QXqRPIDiMJ1TCh+bIsmNxz087dRUtB3s5YDIAI
 RDiqUNdMnBZ9Or+EWAHnNjkgp7pfVqA2SxkHABq3gZZoflDRKjyzx7iqC
X-Gm-Gg: ASbGncuJN5sb7kZgTkym7sGic+9sxZ6TmU11FkZ7eIbQPNFtsbFHYjSFZRVR8AiQ7C0
 KG/P3dGYuqnyP1g2MqJVfoZQdWxcKYgDI5FF+Xwvu307wTKd5aH6VGPtt0mHTdaEQKHaKQoIFJJ
 0Pg0EblFGIn8WsgapP9Ddy1eRus8XhssM1uKdFayVONVrMHHkfBgWibUTqOs8+hgwg2xAZ9pDFs
 7HLCsItUb2bIYxR34y7Jx0MEHXbtwBdxp0NSbT0AP3vVfMpg+Mrn/BYknf2+wjGp20SeW4XRqmE
 JYGF/5pEByg2ANoy6InPYCD6X9YUmvpSPmoEeD22qWPWx+tC+cILdz3dWKLhOyPvtjpKaq/PQUf
 Zl1cOViJnKBg29YpOzIpgLONRyiFvgUuPgF67ug==
X-Received: by 2002:a05:600c:c4aa:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-4778fe88fefmr124785755e9.32.1763455230710; 
 Tue, 18 Nov 2025 00:40:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyrvOiL4BmkcISzRVoJavVtTTU7RuwLK86VGvVo9szTgFKbs3SAUgRRf7QahLhC7yhhqFjBA==
X-Received: by 2002:a05:600c:c4aa:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-4778fe88fefmr124785515e9.32.1763455230245; 
 Tue, 18 Nov 2025 00:40:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47799768409sm182266765e9.3.2025.11.18.00.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 00:40:29 -0800 (PST)
Message-ID: <47896f3c-8ef9-4a8c-84d0-1a76e22853da@redhat.com>
Date: Tue, 18 Nov 2025 09:40:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ioapic: fix typo in irqfd check
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
References: <20251106115010.1141851-1-pbonzini@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251106115010.1141851-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/6/25 12:50, Paolo Bonzini wrote:
> Not registering the IEC notifier results in a regression with interrupt remapping
> when running a VM configured with an intel-iommu device and an assigned
> PCI VF. At boot, Linux complains with :
> 
> [   15.416794] __common_interrupt: 2.37 No irq handler for vector
> 
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Analyzed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/intc/ioapic.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

I had sent :

	https://lore.kernel.org/qemu-devel/20251106105148.737093-1-clg@redhat.com/

Anyhow, let's get one merged asap,

Fixes: 638ac1c78457 ("hw/intc: Generalize APIC helper names from kvm_* to accel_*")
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index e431d003117..38e43846486 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -216,7 +216,7 @@ static void ioapic_update_kvm_routes(IOAPICCommonState *s)
>   #endif
>   }
>   
> -#ifdef ACCEL_KERNEL_GSI_IRQFD_POSSIBLE
> +#ifdef ACCEL_GSI_IRQFD_POSSIBLE
>   static void ioapic_iec_notifier(void *private, bool global,
>                                   uint32_t index, uint32_t mask)
>   {
> @@ -434,7 +434,7 @@ static const MemoryRegionOps ioapic_io_ops = {
>   
>   static void ioapic_machine_done_notify(Notifier *notifier, void *data)
>   {
> -#ifdef ACCEL_KERNEL_GSI_IRQFD_POSSIBLE
> +#ifdef ACCEL_GSI_IRQFD_POSSIBLE
>       IOAPICCommonState *s = container_of(notifier, IOAPICCommonState,
>                                           machine_done);
>   


