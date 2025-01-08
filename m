Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD1FE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdha-0003ym-VA; Wed, 08 Jan 2025 16:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tVdhY-0003xd-Lr
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:34:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tVdhW-0007xK-8g
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736372092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=41M+R/XKCImcVpiXngXcgQ/wxhxdyEth/DA3pcD/uAY=;
 b=V7i6lvz9QD7/LcH9zxqmwaKd5qPfKltKgmSWhzG2lAKe0d2OURjN/dH1e7NC7pdzMp7dV2
 OzQ+dHuTHHsdLDJW4jQYT8SFmXTvdRg3vn/p+ZgTQN6ZgUaE19+55qTJb9ZX5xmhJaFDse
 9l5Y3O+hzXNZjW4yafMbKEYkK/QG8dk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-BzmNOa6nO3eFxxoYxnCPbw-1; Wed, 08 Jan 2025 16:34:51 -0500
X-MC-Unique: BzmNOa6nO3eFxxoYxnCPbw-1
X-Mimecast-MFC-AGG-ID: BzmNOa6nO3eFxxoYxnCPbw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385dcae001fso81296f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736372090; x=1736976890;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=41M+R/XKCImcVpiXngXcgQ/wxhxdyEth/DA3pcD/uAY=;
 b=Yzmx0H0531Cq+oKbSXRcJyF0ZiZvWwODh7HX7vxKX3w6I0QEuVN2g3epAFEoBXrRnA
 Dm2rAz9EI2r8DJDArjLg1KGQK8w/kfXmUt1Cq2jNPszanFdAU96bCvUi5Vz5y7sX5I+Q
 BgYby5j7QL6XXxv5x6fW7B/Xr5sH7cB5jgMMOxZPDPoNrmPn73ANtM3YQXz06TDx7/tP
 e/VviIuDWf3NpzNUgs7OSxkOyXd0Boho8Gzb7T1Gpgg5MH2FfAty6mlOfVJUff/7eVkE
 EdvEovs+KZgc7qzQfkc5/Rg25N8ZWCmcRi2NjawQ7Ym7tEDGxRZqv69kL6+vkdQ/GSkg
 R+6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMJaw0S/WD1TWZMMoGWlvvPb6kMP6YxXsa+RcdG8aqF+W79aLCLh6AYz9k95bDWdJBrW7N/sHiWO1H@nongnu.org
X-Gm-Message-State: AOJu0YzHB9OST5A6CV4ABFwtgC6NTy0PQwVIKxBlDH7ek5OsNK3qENw8
 N2e+IdBw4ssDiEywp8DWdt4luxRH8szxLG3RU8N4swFQpCT+Wm6vrZDJ9Qex8J5mjLYpZ+H1JHf
 syijemHCnSNWhox3y7uv8aTILCQxjlh7UC8f/FcgaMyFyJ+JZUfVL
X-Gm-Gg: ASbGncuUzUdJbXrZm3UKdrKqVxwmUOX1LJsUwQnEXUAB7Sx3BD5xZLqhJaRt5ZSAC7g
 /kqKQ8f9tITSv0GoiWi0xztJOZJ2Z/6pHBteubQ5x3xrHDX8bP5t0dXminnPN9E/0QFKQP9eN+n
 d/jw8SAxThjoKMuK4YFRixgSr9nrOK3jDjX/VUY8+Pnp/aFEl25nAOafjxOV7LthbCfCXHV5YX5
 8SOdJjkDQsgkr7Dx7RvtD0B7PHFijs8yyFdvakRseGLQ1r8I7HaXaJ96o9jVPtYx1RH7JN4V1hX
 U7GH8J753FLHprEQEpKNQ9pdvEY2mXv0nAUogeFRw4K9uGOHa8gTWVpVEkr2QIZBKOt4GxPYyd2
 pM24ETw==
X-Received: by 2002:a05:6000:1a85:b0:385:e0d6:fb48 with SMTP id
 ffacd0b85a97d-38a872f6f22mr3585470f8f.7.1736372090213; 
 Wed, 08 Jan 2025 13:34:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb3cbHq2ETie7LVaxVOhPaqZj91QSORGfs8AUXFme7GEmdJD1HTMJ71G/up3Uu3f2wI8hTSQ==
X-Received: by 2002:a05:6000:1a85:b0:385:e0d6:fb48 with SMTP id
 ffacd0b85a97d-38a872f6f22mr3585426f8f.7.1736372089356; 
 Wed, 08 Jan 2025 13:34:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7?
 (p200300cbc70d3a00d73c06a8ca9f1df7.dip0.t-ipconnect.de.
 [2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e2f9sm55147455f8f.81.2025.01.08.13.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 13:34:48 -0800 (PST)
Message-ID: <a00d6d67-c0a1-4d54-9932-bf3b3a7054d8@redhat.com>
Date: Wed, 8 Jan 2025 22:34:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] hwpoison_page_list and qemu_ram_remap are based on
 pages
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20241214134555.440097-1-william.roche@oracle.com>
 <20241214134555.440097-2-william.roche@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241214134555.440097-2-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14.12.24 14:45, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>

Subject should likely start with "system/physmem:".

Maybe

"system/physmem: handle hugetlb correctly in qemu_ram_remap()"

> 
> The list of hwpoison pages used to remap the memory on reset
> is based on the backend real page size. When dealing with
> hugepages, we create a single entry for the entire page.

Maybe add something like:

"To correctly handle hugetlb, we must mmap(MAP_FIXED) a complete hugetlb 
page; hugetlb pages cannot be partially mapped."

> 
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---
>   accel/kvm/kvm-all.c       |  6 +++++-
>   include/exec/cpu-common.h |  3 ++-
>   system/physmem.c          | 32 ++++++++++++++++++++++++++------
>   3 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 801cff16a5..24c0c4ce3f 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1278,7 +1278,7 @@ static void kvm_unpoison_all(void *param)
>   
>       QLIST_FOREACH_SAFE(page, &hwpoison_page_list, list, next_page) {
>           QLIST_REMOVE(page, list);
> -        qemu_ram_remap(page->ram_addr, TARGET_PAGE_SIZE);
> +        qemu_ram_remap(page->ram_addr);
>           g_free(page);
>       }
>   }
> @@ -1286,6 +1286,10 @@ static void kvm_unpoison_all(void *param)
>   void kvm_hwpoison_page_add(ram_addr_t ram_addr)
>   {
>       HWPoisonPage *page;
> +    size_t page_size = qemu_ram_pagesize_from_addr(ram_addr);
> +
> +    if (page_size > TARGET_PAGE_SIZE)
> +        ram_addr = QEMU_ALIGN_DOWN(ram_addr, page_size);

Is that part still required? I thought it would be sufficient (at least 
in the context of this patch) to handle it all in qemu_ram_remap().

qemu_ram_remap() will calculate the range to process based on the 
RAMBlock page size. IOW, the QEMU_ALIGN_DOWN() we do now in 
qemu_ram_remap().

Or am I missing something?

(sorry if we discussed that already; if there is a good reason it might 
make sense to state it in the patch description)
-- 
Cheers,

David / dhildenb


