Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E277FCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBsNw-0003Ib-Rn; Thu, 23 Oct 2025 06:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vBsNp-0003Fj-85
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vBsNm-0004rt-EZ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761214640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=55665LDHlH2/K6s71Rp7vVH/8waNkeXUSCb3nmQ26Kw=;
 b=IjK4l3z3Ws4TbjqEgVOT5uXbZqainw249HNiLjttMHPMKj7KapDbUx6WjUYWoCVDvNdn4B
 yuUoeMcApk7XG+Nx0IVd0GHT3LaJTeJrtPAaOq+67NXFHeSmthVaQIgaBwSvp8YVlmCoLF
 8y7se8/xCkoFVPD4P5UaNcVzIL7B28U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-Eel_--nFOCijCsGRd2LFaQ-1; Thu, 23 Oct 2025 06:17:18 -0400
X-MC-Unique: Eel_--nFOCijCsGRd2LFaQ-1
X-Mimecast-MFC-AGG-ID: Eel_--nFOCijCsGRd2LFaQ_1761214637
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-471125c8bc1so5569745e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 03:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761214637; x=1761819437;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=55665LDHlH2/K6s71Rp7vVH/8waNkeXUSCb3nmQ26Kw=;
 b=Ebvkz5UGTD0s6QpYHY3H2sz6vD870liEle+Fw8HUEM0eAQSCSNHxX9SOMUuDldgor+
 nDSOMMLT6t655N4D0xCZHO5Nvy8MYMOQJ22h9CQT5GiuonPUbU0v822iIyLZsqtfhKIN
 9KI0YB1jcCKLcoFxVldzv8JpCegZgTTcban5vuE8ZrQXE0rlFVXjvq+HUnGNhR44ybGb
 1/LV1gQhhYfF3utX+nYVBwcS9+MP8gp07iVL6WL0W2eKglEjzx5EdOtUiV2Y7hkphv/Y
 nofiFW6npPfqhmR5QOd19grBtkR3W12BupBFy0A2cZ3uM50X5BVgcORUWWQwjWVoFFJv
 5TQQ==
X-Gm-Message-State: AOJu0Yz5TCLPI2mFm8y/dPRi/62x061zOW5m1HCwxp4cjiyWKGsoUcgw
 QPd+p2oHx/Mj2EfWrpJL+yGyq2oe2965jqqLDb0iajoZcRPezLci6t9P1Ccrw4m7AzUa/M1dlHb
 8Y05WROiE9i8QW36y6NhTRN76h3lgZijWKwBquU4UvuHLyy+O4UpPM6FW
X-Gm-Gg: ASbGnctS+O0fQ0AOX3/9wqXg4uE3Y000x3PBE8mw4MwPwluOoiYiaK0DfTQm+u9QjBb
 qN2NN1NGSMvpbV9GWgR8bECmAulEucGvMfnMr1YpRy2NnVJfA9DzMEG19zHm5KmFQdm5tDsZH8A
 0foQJnxTAVCvoVmHhQH1VTL/ddj1wJ8b5Zy1AmxPqrhjpUgzZymxONVgunZ5cg5ae4mHK0S9Pbe
 7JF+TJ/7hLw6bUfwUFfnHN9eMxNaX0OUgAAOTJyEx686c9SUamBPUlzsY5eLfcLWfgbHjt91fBk
 S5EwU05ODI6cGAi/I6tFQR2IGctukljtKKxXFTioHdRHcwFwUHrlzs2tXfAqkkuuAMFSu/Gc+kV
 1mAnlOtfjZJURguiLkjcUjF2W4UG27uzhnhClJXS+l0qiWlIqd/gutPbuB8Gm9TpK4DN5143Hkp
 dUXN08xh81hKPWskyLocUcGj/hA38=
X-Received: by 2002:a05:600c:4e86:b0:46d:996b:828c with SMTP id
 5b1f17b1804b1-47117879b8dmr155812545e9.10.1761214637261; 
 Thu, 23 Oct 2025 03:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa3bd34XZZZ7K2byhB5kt1AsQzhL1TcPM49/bHaiEhydcHGuIPKn2q+PCPLNQeKFYAshtjsA==
X-Received: by 2002:a05:600c:4e86:b0:46d:996b:828c with SMTP id
 5b1f17b1804b1-47117879b8dmr155812395e9.10.1761214636869; 
 Thu, 23 Oct 2025 03:17:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3?
 (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de.
 [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898cc930sm3758856f8f.33.2025.10.23.03.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 03:17:16 -0700 (PDT)
Message-ID: <ab265378-6e08-480c-92b5-640f84bc6706@redhat.com>
Date: Thu, 23 Oct 2025 12:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ram-block-attributes: Unify the retrieval of the
 block size
To: Chenyi Qiang <chenyi.qiang@intel.com>, Peter Xu <peterx@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gao Chao <chao.gao@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251023095526.48365-1-chenyi.qiang@intel.com>
 <20251023095526.48365-3-chenyi.qiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251023095526.48365-3-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 23.10.25 11:55, Chenyi Qiang wrote:
> There's an existing helper function designed to obtain the block size.
> Modify ram_block_attribute_create() to use this function for
> consistency.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
> Changes in v2:
>    - Newly added.
> ---
>   system/ram-block-attributes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
> index a7579de5b46..cf8f5f41966 100644
> --- a/system/ram-block-attributes.c
> +++ b/system/ram-block-attributes.c
> @@ -390,7 +390,7 @@ int ram_block_attributes_state_change(RamBlockAttributes *attr,
>   
>   RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block)
>   {
> -    const int block_size  = qemu_real_host_page_size();
> +    const int block_size  = ram_block_attributes_get_block_size();

Double space before the "  " can be removed while you touch this.

-- 
Cheers

David / dhildenb


