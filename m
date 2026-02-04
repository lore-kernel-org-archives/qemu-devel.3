Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8FEE9537D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaeE-0002YD-Ox; Wed, 04 Feb 2026 06:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaeC-0002ON-Kt
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:02:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaeB-0003Cy-Ai
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770202930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=stYoBmDqpFy0bzLkTHuEeUMZMLbMG6I0YuF8zRTmjmU=;
 b=cMXjbz4HHeV/a+uAQoKOGZMyPUBPsmO6TSinBy7wf5vzXIevD6sZTOL/5qvL4N0xga5r8S
 lWMvlf3Go63s38JQxhLXDz/dTmNbehu781J/ZNu1zdi7kBcujea+8LOI8fZ9vX5dSvLT31
 m4PL4iP8pus2wjue1haLTSSQsUFVxOA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-MT3pW8BxMz-5S862VE-ONA-1; Wed, 04 Feb 2026 06:02:07 -0500
X-MC-Unique: MT3pW8BxMz-5S862VE-ONA-1
X-Mimecast-MFC-AGG-ID: MT3pW8BxMz-5S862VE-ONA_1770202926
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48071615686so55481755e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 03:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770202926; x=1770807726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=stYoBmDqpFy0bzLkTHuEeUMZMLbMG6I0YuF8zRTmjmU=;
 b=tOLqmu+TDi98m/prPBGzRi2G7jtPioc2W9a3Uqdq8D7+ssPrrOp9Pc1OMBVwcr+FtE
 ger0cDuzwpCflyKDnWZK2pZVGa/VRlBx+0sbd7apn3SxleG4BJ7qa1FXJ3mW7+4TpPEc
 bUjwMBe901adJ+NlNeVSAwHDZDh8hRTNAv9uqI15N1cEDv5NuxcEekf4BeaM5+FtsYR5
 c5A/ne6uQKG3qP5kM0L/RqiPfuEZZyQPeaJfXvc72+4hVyvg3AzQ6pxc1BsrhuAHKzjT
 d+eVtw5xHSNmbpldeyUtiWdWLpxiTl6a5ZJHSjbbr23Q5KSORD2C+dd5mAb9GQAg3fmM
 2W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770202926; x=1770807726;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stYoBmDqpFy0bzLkTHuEeUMZMLbMG6I0YuF8zRTmjmU=;
 b=LscixGsmqcKrnY4srPrYK5OxK28FF8J4c/y0WGLLMNwUKKF+yZEg01sa/8Lyb96Pfv
 i3J+FKLGlSTG0vsG1k4uNM0wNNwYTev2oTBK/3lA6T9yZA6mPQIdNNevQvtAtMfT7Eas
 ZwYKLABkxa8Oyci++aCLUnYdI5wS3D4gUF2bYsQj3JMv6jvFNNEStreX419vCMEKXdxM
 V3jvPuryflhAy+YFNsmE1e9TnCGYzzqzAYWeP/63SEHgELLlVEiNS/v2O/ynEyThGC13
 07Yw0oHRjuR0XToxR4OuWN6kYjemR9hZiReHHCJVbfT1p26/7WtcM/JH+N4UomAt1t2K
 86ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+IzpSHaEtwIPQMmvywX7gjOhnTi5mAaOxCyReR/RHrZqv7X6nCt51Zl4w5cxPyMy9SVhkAXXC4Sdt@nongnu.org
X-Gm-Message-State: AOJu0YxaQ7IbFUPz9qsPwzTE1TnNw0VQdBaoISKJlaWBZ8ubuBXTGcET
 v2fzGNbsCBJpSam22fI5mhxNnkWzy0AYbdxtx7hfslLcvax7urvnGgQ5IIHEqtmW0DHoMlW+YBj
 isVmAor7oA7SPHT2BhUpoUrrvZz/zEFTmFYYFYKqsRDzbkXJLLuIJmM33
X-Gm-Gg: AZuq6aI3eP4qD3OJhtG1OdWkYoDVtBBRL/kNfshxNXkDMYYKRvp2MD0Yvz6jS8rKg+Y
 CGfrgFJQsusg2dBGN4HSLvcHTKBWioPQBwDSPJXLjlptkTTFBDLHwnON00RLdDgCfNZPTyg2e4J
 7wOiKKyL1QEIRbI6X6p8mVvcUhNdt9ayfzNAZen0ojvebPzYfSoCbQRw1HoZGcs4m4Vam85kV58
 UjbffG2118WEdT6F2gMw/gkVwAyiVlJB7jS2n7++OxU8ZNxaHBQHl6zLoFFIMCfDeGGjuu/i7eh
 ew68q4c8HBRNlSzZIXAiyST++DP9pURiIdV9cXZZ8QA/EyOq8dsMVrPv1vxnG06x0+Ff7hs9mmH
 RZU1QhtaVNMEfzLilBW9l9YJATkeb4w+Htqzg/SNr9n8yvQSb
X-Received: by 2002:a05:600c:1c28:b0:477:7925:f7fb with SMTP id
 5b1f17b1804b1-4830e93203cmr38810225e9.10.1770202925866; 
 Wed, 04 Feb 2026 03:02:05 -0800 (PST)
X-Received: by 2002:a05:600c:1c28:b0:477:7925:f7fb with SMTP id
 5b1f17b1804b1-4830e93203cmr38808305e9.10.1770202924171; 
 Wed, 04 Feb 2026 03:02:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4831093650esm53589965e9.15.2026.02.04.03.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 03:02:03 -0800 (PST)
Message-ID: <1a656700-8185-4b0f-b90b-795da131e110@redhat.com>
Date: Wed, 4 Feb 2026 12:02:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] kvm: replace RamDicardManager by the
 RamBlockAttribute
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Kanda <mark.kanda@oracle.com>
References: <20260204100708.724800-1-marcandre.lureau@redhat.com>
 <20260204100708.724800-6-marcandre.lureau@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260204100708.724800-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/4/26 11:07, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> No need to cast through the RamDiscardManager interface, use the
> RamBlock already retrieved. Makes it more direct and readable, and allow
> further refactoring to make RamDiscardManager an aggregator object in
> the following patches.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 8301a512e7f..b6a593d0863 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3124,7 +3124,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>       addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
>       rb = qemu_ram_block_from_host(addr, false, &offset);
>   
> -    ret = ram_block_attributes_state_change(RAM_BLOCK_ATTRIBUTES(mr->rdm),
> +    ret = ram_block_attributes_state_change(rb->attributes,
>                                               offset, size, to_private);
>       if (ret) {
>           error_report("Failed to notify the listener the state change of "


Reviewed-by: Cédric Le Goater <clg@redhat.com

Thanks,

C.


