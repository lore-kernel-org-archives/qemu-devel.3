Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B721C3ABAA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 08:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9gaT-0004fY-Hp; Tue, 29 Apr 2025 04:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1u9gaQ-0004ef-Io
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1u9gaO-0007zO-F3
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745916302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yQwcFmkup7eha73PQkLk9mBCMp56Qy83GkVMk21IJus=;
 b=QL2CuNsXSBUWyJDqkSgeiUTdQQryaPFHz2MNhb9w9aqERcWcvi8fU3ApkIY9fIWwZy/LgH
 h5l+r/Rs1nxUdyCFz9bbNr7LDhUuW0DPU3P2GtAzd+GtZHziBYeXf2Lup6URfE13oM9+S2
 B1f/h+a/Jyfce2xQn26flfRn08dCz7c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-TM8E06biOJW9p9bL5jxdvA-1; Tue, 29 Apr 2025 04:43:48 -0400
X-MC-Unique: TM8E06biOJW9p9bL5jxdvA-1
X-Mimecast-MFC-AGG-ID: TM8E06biOJW9p9bL5jxdvA_1745916228
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3913aaf1e32so2438515f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 01:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745916228; x=1746521028;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQwcFmkup7eha73PQkLk9mBCMp56Qy83GkVMk21IJus=;
 b=FdwmXJiigha+FLw3Ab5W0akGFzX+dBccAvSwFIXr9rDVME9NOmf7giF1cRShZeKAe2
 kwt6EVF+bsRI3MYyk2S6fCKwpOFH4ShFg+cJ8kY+Z8lSys+7SpEAOBx2kCsEXb4mfvj9
 m/ltg3pNdEjvQ3xLjorg0U8M8ijHBlbB0XjMxGainskL+VE0jNFyU88HbvPIhYHxIo6T
 D6nnZsdOl1okB3iNVRA3+C2UKSDCuJPdZBjeFjPN9o3JJllOPzhDN4pvqOWSYzEuEqO4
 eNnqQXSfQDBUudYTBtt30HKPD9Vkd3qdajMErAwAj/96P07r2u384JhwnZPCat2h5tBa
 swFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYQFnrXmg4NZyQQmp8vA3YXQKzwtXNEk+5tAtQwIngPN+bQXqxJy2zE9yak0DNSXl8PDI8KuDRp0u1@nongnu.org
X-Gm-Message-State: AOJu0YyYT1hArYtJ+xJJl6m6aHMwPNUyumpdXcZ5Z98gg+r9rJjZXaXS
 Yd8zGY9FWjQtQtPIs2BQ2i8dchbwQ2Ho2x5SA2yIqtZwmgsQ0yo9RY8zFnKVf0W2FDyhGkScPaX
 FFyqEX2AINufsG5XI2NwDuB6770wnYlUmecfuO2mb6Y9HaJFvpFrK
X-Gm-Gg: ASbGncvlDUKQWrS1ec23rRgoJPjr+nr1qL5DTuYFgZqfogYtRPjOjdLmtBCD39x0MNg
 PddD+FhBFvyLitylvjfwR5upaxLknDd8dIFaWBsRxzzPz7uxfVOWKaDMVIAoVodpsxIi6FnBIrD
 okiO/voyT4ts1Rp1AVuEqljmTN7eBZJOI5sxDVkA27CS9+sv5SGj/54hQteGtAP8ZosKhZL9N0V
 ZRaTUhts3xKJdw/HAaJfGRiJ6zLPoF9kpCVsyGUylUOUYE6ILo5hRe8OSTyNoRVz1/Ur76rgOYM
 OJG3UlhLZzLJmJntQWYSCvsZcQMP/xEGiBZTODNIvr8ggDiugTI=
X-Received: by 2002:a05:6000:1845:b0:39c:30fc:20 with SMTP id
 ffacd0b85a97d-3a0894a7f46mr2176004f8f.37.1745916227714; 
 Tue, 29 Apr 2025 01:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLfxPkf0EX4mxo8gs+5qZfyZ/AEEn/hLllC9pJjtBuKTAlS4Q6/gYLTLtKt3Q07L9aYOShyA==
X-Received: by 2002:a05:6000:1845:b0:39c:30fc:20 with SMTP id
 ffacd0b85a97d-3a0894a7f46mr2175990f8f.37.1745916227376; 
 Tue, 29 Apr 2025 01:43:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d1e19e1sm179445905e9.0.2025.04.29.01.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 01:43:47 -0700 (PDT)
Message-ID: <6d6a30c8-4165-4bde-b2f7-c09a8e3b84da@redhat.com>
Date: Tue, 29 Apr 2025 10:43:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/libqos: Fix UBSan misalignment finding
To: Nabih Estefan <nabihestefan@google.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, farosas@suse.de, sriram.yagnaraman@ericsson.com,
 akihiko.odaki@daynix.com
References: <20250428212041.1301050-1-nabihestefan@google.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20250428212041.1301050-1-nabihestefan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 28/04/2025 23:20, Nabih Estefan wrote:
> Running with `--enable-ubsan` leads to a qtest failure:
> ```
> ../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned address 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment
> ```
> Instead of straight casting the uint8_t array, we use memcpy to assure
> alignment is correct against uint32_t and uint16_t.
> 
> Change-Id: Ibd2bc3d870ea37bcbaf2e459806a22ae17464049
> Google-Bug-Id: 391659542
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>   hw/pci/remote_pci.c      | 0
>   tests/qtest/libqos/igb.c | 8 ++++++--
>   2 files changed, 6 insertions(+), 2 deletions(-)
>   create mode 100644 hw/pci/remote_pci.c
> 
> diff --git a/hw/pci/remote_pci.c b/hw/pci/remote_pci.c
> new file mode 100644
> index 0000000000..e69de29bb2

It seems you are adding an empty file here.

> diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
> index f40c4ec4cd..f31b1a7261 100644
> --- a/tests/qtest/libqos/igb.c
> +++ b/tests/qtest/libqos/igb.c
> @@ -103,11 +103,15 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
>       e1000e_macreg_write(&d->e1000e, E1000_RDLEN(0), E1000E_RING_LEN);
>       e1000e_macreg_write(&d->e1000e, E1000_RDT(0), 0);
>       e1000e_macreg_write(&d->e1000e, E1000_RDH(0), 0);
> +    uint32_t safe32_address;

We generally don't mix variable declaration and code.

> +    memcpy(&safe32_address, address, sizeof(uint32_t));
>       e1000e_macreg_write(&d->e1000e, E1000_RA,
> -                        le32_to_cpu(*(uint32_t *)address));
> +                        le32_to_cpu(safe32_address));

I think you could use instead ldl_le_p() instead.

> +    uint16_t safe16_address;
> +    memcpy(&safe16_address, (address + 4), sizeof(uint16_t));
>       e1000e_macreg_write(&d->e1000e, E1000_RA + 4,
>                           E1000_RAH_AV | E1000_RAH_POOL_1 |
> -                        le16_to_cpu(*(uint16_t *)(address + 4)));
> +                        le16_to_cpu(safe16_address));

You could use lduw_le_p().

>   
>       /* Set supported receive descriptor mode */
>       e1000e_macreg_write(&d->e1000e,

Thanks,
Laurent


