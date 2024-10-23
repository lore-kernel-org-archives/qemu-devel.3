Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503AFD2E01B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 07:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Vpb-0006XT-NG; Wed, 23 Oct 2024 03:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t3VpZ-0006X4-ON
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t3VpY-0007RZ-4M
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729668655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nLAbOW5noKWYdqiOCxdBnOzCCEaEY6Bx0acXsqpyM84=;
 b=GAypL6dNJ2crG8ebdgHajwCUGKlU3tF8f33dXsX5DvbrISbE6f8irWeBOxdVshHgaX7wqU
 of7dYXdOlripVCdyKkMJRkQ3JTrDQ5JFjR8PCWvXcYc3AR78XB/C2RGijhyRV30nhp0h/R
 LPaaMTKWUGHJiRqGfs+hc1+64roPNW4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-N_xMshPaMa-VABdlBZOzLw-1; Wed, 23 Oct 2024 03:30:53 -0400
X-MC-Unique: N_xMshPaMa-VABdlBZOzLw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d563a1af4so3161685f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 00:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729668652; x=1730273452;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nLAbOW5noKWYdqiOCxdBnOzCCEaEY6Bx0acXsqpyM84=;
 b=TWin18vrey6wnHEo212avCUV9gwiku0v4g6x9ZgirlUosdSxFNdDpEHlQMk/jjSCen
 4B10yUFSvuURcjuTGtCB+/0K53UyU6NGalMTPS0ftU8tP2Uqd5AjPns+bfAW8Z/vz8Xh
 nTPxCYDQYJYRhdcRJBfw/Xk5rc4BKzgYW/16l/BhFEsev4aG9dVMkfmuzwDeGSPib1kY
 /KPIxxXGfw4+DcbhRs5SWBIUhATrYsypkww0AStkpNRMWl0Er20Gb5R459SGT5FwineZ
 6HsynHPn9zO5bTax0CHKt3JKo01lArKbslU2EZPT22BbWKmG7tsi6STk/JoDHJSO/Aur
 8zvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPD+tvu/qoqhg/wiCG1zCk8cUz0mkGjObtRqxOWUdsf92WjzelbJ03nBGzXmR7ykkqdq3f2SbQkg97@nongnu.org
X-Gm-Message-State: AOJu0YyuzPjHZqQnh1kCOFj6LRy5mhO5KWrtmh/FoeI6oP9geMnuKdUh
 KI3/5LzmyF/O/IXz25n80OooLAidpX7Rwp1sBqd383cLa9oFksbjUk5BxpdGk7+2IHWEXgIsSAd
 QVamjGZc8YxtfX+OdljvQc5TgG+/lanvpOit6kvxXDcyaTWV2FoZ+IVhjLx7y
X-Received: by 2002:adf:fc89:0:b0:37e:f1ed:67e8 with SMTP id
 ffacd0b85a97d-37efcf1febemr910545f8f.35.1729668652081; 
 Wed, 23 Oct 2024 00:30:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElQufGspeuo8s52Js73KdBiTAVmxS+0bm1ueIZyZW3Xk3w29r46GilaYuIg/XFCvKU6PmSYA==
X-Received: by 2002:adf:fc89:0:b0:37e:f1ed:67e8 with SMTP id
 ffacd0b85a97d-37efcf1febemr910514f8f.35.1729668651465; 
 Wed, 23 Oct 2024 00:30:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:cd00:c139:924e:3595:3b5?
 (p200300cbc70ccd00c139924e359503b5.dip0.t-ipconnect.de.
 [2003:cb:c70c:cd00:c139:924e:3595:3b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43186c15684sm8218015e9.39.2024.10.23.00.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 00:30:50 -0700 (PDT)
Message-ID: <0cda6b34-d62c-49c7-b30c-33f171985817@redhat.com>
Date: Wed, 23 Oct 2024 09:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] system/physmem: Largepage punch hole before reset
 of memory pages
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>,
 peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: joao.m.martins@oracle.com
References: <ZwalK7Dq_cf-EA_0@x1n>
 <20241022213503.1189954-1-william.roche@oracle.com>
 <20241022213503.1189954-4-william.roche@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241022213503.1189954-4-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_PRE=0.001 autolearn=ham autolearn_force=no
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

On 22.10.24 23:35, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> When the VM reboots, a memory reset is performed calling
> qemu_ram_remap() on all hwpoisoned pages.
> While we take into account the recorded page sizes to repair the
> memory locations, a large page also needs to punch a hole in the
> backend file to regenerate a usable memory, cleaning the HW
> poisoned section. This is mandatory for hugetlbfs case for example.
> 
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---
>   system/physmem.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 3757428336..3f6024a92d 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2211,6 +2211,14 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
>                   prot = PROT_READ;
>                   prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
>                   if (block->fd >= 0) {
> +                    if (length > TARGET_PAGE_SIZE && fallocate(block->fd,
> +                        FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +                        offset + block->fd_offset, length) != 0) {
> +                        error_report("Could not recreate the file hole for "
> +                                     "addr: " RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
> +                                     length, addr);
> +                        exit(1);
> +                    }
>                       area = mmap(vaddr, length, prot, flags, block->fd,
>                                   offset + block->fd_offset);
>                   } else {

Ah! Just what I commented to patch #3; we should be using 
ram_discard_range(). It might be better to avoid the mmap() completely 
if ram_discard_range() worked.

And as raised, there is the problem with memory preallocation (where we 
should fail if it doesn't work) and ram discards being disabled because 
something relies on long-term page pinning ...

-- 
Cheers,

David / dhildenb


