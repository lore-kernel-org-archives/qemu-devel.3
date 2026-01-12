Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFDBD232D3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfEHY-00086h-I7; Mon, 12 Jan 2026 04:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfEHW-00082n-F5
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:32:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfEHU-0000f8-Hh
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768210331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z37XISjcFfZPjbA/fxnPLdEIsFbOOm+w5+3q8IXblo4=;
 b=UhfCpJGrhCLfxemiDBLnrsXAaf/KoEWfbPV3sPTOCKHea5PQEJa8W3azjDkB0eOBpqfryN
 QqYAQz/TPr/GDV4xS4A4/L4BEmYOLeOSVUjLrJrKp+a/30SYb2EkpaX7IzRaGN1Zt/OKSg
 VKS7q2c5Lkzd9pQ2tvzHjLePWWtgPsQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-N4gs6Jv-OcCCHTKVNq2inA-1; Mon, 12 Jan 2026 04:32:09 -0500
X-MC-Unique: N4gs6Jv-OcCCHTKVNq2inA-1
X-Mimecast-MFC-AGG-ID: N4gs6Jv-OcCCHTKVNq2inA_1768210328
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so38236225e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 01:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768210328; x=1768815128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=z37XISjcFfZPjbA/fxnPLdEIsFbOOm+w5+3q8IXblo4=;
 b=roIK575a7j36xdOmyEWW3rIg7RN8+0qYsRMhToP4rid7ce0QM523RHDgAh7dkX6e/p
 xi/uZj51SPkyj5jP8ZDksDpdw7baEdPX3kDV/BG1TAXby1twwj5JYx5ji5F98ychf4SN
 8G6j12utjDxBir98CO9uOvFVmP5sdPKcT6JRfX7uYbXbp7uCpQgVFB/Sa1KDXEHoTG6G
 qDmVuX532xiNnryVN2M8mnqlRSe/eWFff7NqlmUWaz9Ku11yel5dd5g/KWK+GdXQROxe
 dcxsWMN1bgX1bHpSRjhTcQN/Qa7UQGRaQSeq9zudnGI8Thi/UvLxUcjllOMHC7awpIVL
 Pffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768210328; x=1768815128;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z37XISjcFfZPjbA/fxnPLdEIsFbOOm+w5+3q8IXblo4=;
 b=O5K+pIDsiV/9XMxZPXCQGj9wmjzzyyESgOhFxQNXw1Folp0j6270LGQq0dmKVXtxP5
 ez7XaKuV/HEUL2ddUx0I5TTtZeBSh8b1wdx1GU0oJxrsNLBzMI/YgLI+96yncoEwnJi4
 jhMJw9tuMJkW7Q9y0Zb25N3G3uw5yO0hI8M8NCgjFzyX8ViQAYke0GA2cTEzcHQG3oG0
 G+b6luZiDjYnvnzhRcrVJG8Bh2jT0feORTn7WVRWkmsBcDogLoWzS3GNNdoLl3SPGKbX
 nXNTx74yuI5WhjZ9tua+c25MWXvy2eFKgXSxwI1GmqjqFosS1eWJGCz9wl0J224+h3XA
 zOxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTF/BQo2/isFm4yYssjp8lHJCt4nqjSoFDqYED986q+DaTwqXTzV56u0MmT61+yqTe0Pau4JKO1n4Q@nongnu.org
X-Gm-Message-State: AOJu0YyacCbMhxtPOd0ZkXgHw2OKFea87Yes9FVKQBkPqjYYp/+KEKhq
 /keHJsQF9YJiyeqz7h/ndFIcIkQPDOm9bp9wWOtv2C5AFO3/73mrqoddo0sth8wCLgPC6tuaHrE
 AQlj7ViveKySmcug8/0oSYxNHpp1zqXOVKJwL92WQE86Bq3+TB7fCB75h
X-Gm-Gg: AY/fxX6spGiT9b7cMWukA5ZMnSvhuekqMo9IBLCUKCjjHEbanUJEoD+VYuX1BIRkY2U
 fmmE/5Xda/rLQTCX65lDSafxCZk5rzP3ze/Z6+QCgfO0hgbkLwnXpip01gfNzAgrfnesv2daEOi
 PaH4LYFjxtlXcom/vgB2Ds08fosQymIw1uKzH48bBikbh+cNQGtDblUY527vNC92xdDqrN5N0PR
 zWXeog7uQ6Ays7aQDsNlameCrTh7vL2XmfBmZaLZx1AHutP3IEpird8gxKZ5Vjq/aLz7DhtzTqe
 SPywQsFUkPGScUaNDAJjsoO8EaNrYw2Y9LrA+pNGmiRR0a6MLDHi1K5qRLg2rLuI8MoDmumznIn
 Ek9UwLz8=
X-Received: by 2002:a05:600c:3484:b0:479:2a0b:180d with SMTP id
 5b1f17b1804b1-47d84b20fd7mr202090885e9.11.1768210327873; 
 Mon, 12 Jan 2026 01:32:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw5VT7Z/yk+u6LKiS+CQ9MPGjDU0Fzf1KVcFeoO4PXZKuVC7NBsHU/6MPG3UTkmUiNp4k/og==
X-Received: by 2002:a05:600c:3484:b0:479:2a0b:180d with SMTP id
 5b1f17b1804b1-47d84b20fd7mr202090565e9.11.1768210327489; 
 Mon, 12 Jan 2026 01:32:07 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6953fasm336595095e9.5.2026.01.12.01.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 01:32:07 -0800 (PST)
Message-ID: <0d46c208-0b8c-4984-a26c-7c584c86eb7e@redhat.com>
Date: Mon, 12 Jan 2026 10:32:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] target/s390x: Use address_space_ldl_be() in
 read_table_entry()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-3-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260107130807.69870-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 07/01/2026 14.07, Philippe Mathieu-Daudé wrote:
> Keep address_space_read/write() API to access blob of memory.
> When the access size is known, use the address_space_ld/st()
> API which can directly swap endianness.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/mmu_helper.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 026502a3e40..9ee1d778876 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -108,6 +108,7 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
>                                       uint64_t *entry)
>   {
>       CPUState *cs = env_cpu(env);
> +    MemTxResult ret;
>   
>       /*
>        * According to the PoP, these table addresses are "unpredictably real
> @@ -116,13 +117,9 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
>        *
>        * We treat them as absolute addresses and don't wrap them.
>        */
> -    if (unlikely(address_space_read(cs->as, gaddr, MEMTXATTRS_UNSPECIFIED,
> -                                    entry, sizeof(*entry)) !=
> -                 MEMTX_OK)) {
> -        return false;
> -    }
> -    *entry = be64_to_cpu(*entry);
> -    return true;
> +    *entry = address_space_ldl_be(cs->as, gaddr, MEMTXATTRS_UNSPECIFIED, &ret);
> +
> +    return ret == MEMTX_OK;
>   }

  Hi Philippe,

this patch seems to break "make check-functional-s390x" ... looks like there 
is a bug somewhere, please have a look!

  Thanks,
   Thomas


