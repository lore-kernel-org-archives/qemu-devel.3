Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4DCC52D71
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 16:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbNFr-0008GC-Ll; Tue, 06 Aug 2024 12:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sbNFo-00084r-NT
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:41:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sbNFn-00086P-3O
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722962502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0iuQZNPW8ck5a+j6YbvNF8m0zNRaEtmMueeXznvAAiA=;
 b=Lg5n6FeZi9nD7Ox5Yho+0brFTE0fZnBnT0cOft9oKFugtsgIPCO00fvCwKZo0e1tRgjBC8
 ygopjXEU5d9E/H3fs5HeKMlMIIDoFEZSUcxGeQ8RW3/IA96l7vtZPeVAnb2AIY1qNB72ds
 4e+JxIGKdGZYQZvmcto5rszKY5b9ezI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-ioA_WH6dOe-nO49JEWF0_g-1; Tue, 06 Aug 2024 12:41:40 -0400
X-MC-Unique: ioA_WH6dOe-nO49JEWF0_g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42816aacabcso6686155e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 09:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722962500; x=1723567300;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0iuQZNPW8ck5a+j6YbvNF8m0zNRaEtmMueeXznvAAiA=;
 b=dGjxYJ1pnR8cbhS9Ui8sQfytEqRCQY023rza3/haK76DhVYVaW+0QhzPYKGAFRoBND
 olH58T7EdG1Qj/o7NDMtV13E+Hj+Mm6EMt9h2D8BQzi5wWKPVQYVRPuN03Oqa+xfxlIP
 eh8mEHeEFG7tR2Xh92jjZIY7PSkchZRxOFKbD9HY94P+FiArbsWZRTLGYCE7iKjwb9pd
 rncP/uFaH+u3TseXg8TMfpIrbv6K6xKh6/+Jp16qgO3VdBVohCEa8YtyPWxWdv2PxZey
 ekIRkNN9GlQPl+8j8EdP8ALhsXVWQoNT4cRPEfGsDLBiWNOMZa/3SyuHy44TSt5BzsYt
 H5Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgu9FfnOWu/UIIj7jbfzawoQwBlNEbffU3Rc2UzE9voH6lmIm7nhlW2YGwc1iIIrEABgiaSp6JA47y7tRgPVjEkEGZ0Go=
X-Gm-Message-State: AOJu0Ywdhokz6513C9wP/Snn99SJxzGAhqmzIWYsVORA45XBblMJC0j9
 co3YhSJEEYhQ5m5AAggivowhtEovd7/+DT4gloRyWVoB2FxLq9hgb3fwQIapefZ370RjQZ35/yf
 4dQngNrOKoSWv4LZeiDtCFtcnKimhLYRW1yKCzTSwOywhsGPPTB9a
X-Received: by 2002:a05:600c:198f:b0:426:5c34:b19b with SMTP id
 5b1f17b1804b1-428e6b00c7dmr113827015e9.20.1722962499684; 
 Tue, 06 Aug 2024 09:41:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq7ZGshu4Cqrnm7hDFd6QWsTphm4cAeifrH3fFs4sC4QNgSRNuWkGc9j5Bo1lxSZUkmEEb/w==
X-Received: by 2002:a05:600c:198f:b0:426:5c34:b19b with SMTP id
 5b1f17b1804b1-428e6b00c7dmr113826835e9.20.1722962499168; 
 Tue, 06 Aug 2024 09:41:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af?
 (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de.
 [2003:cb:c73f:8500:f83c:3602:5300:88af])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm184047925e9.16.2024.08.06.09.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 09:41:38 -0700 (PDT)
Message-ID: <852c8a3b-f2bf-405f-bdab-4df4a910a619@redhat.com>
Date: Tue, 6 Aug 2024 18:41:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reset: Add RESET_TYPE_WAKEUP
To: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-3-jmarcin@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240806160756.182524-3-jmarcin@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 06.08.24 18:07, Juraj Marcin wrote:
> Some devices need to distinguish cold start reset from waking up from a
> suspended state. This patch adds new value to the enum, and updates the
> i386 wakeup method to use this new reset type.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>   docs/devel/reset.rst    | 7 +++++++
>   hw/i386/pc.c            | 2 +-
>   include/hw/resettable.h | 2 ++
>   3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
> index 9746a4e8a0..30c9a0cc2b 100644
> --- a/docs/devel/reset.rst
> +++ b/docs/devel/reset.rst
> @@ -44,6 +44,13 @@ The Resettable interface handles reset types with an enum ``ResetType``:
>     value on each cold reset, such as RNG seed information, and which they
>     must not reinitialize on a snapshot-load reset.
>   
> +``RESET_TYPE_WAKEUP``
> +  This type is used when the machine is woken up from a suspended state (deep
> +  sleep, suspend-to-ram). Devices that must not be reset to their initial state
> +  after wake-up (for example virtio-mem) can use this state to differentiate
> +  cold start from wake-up can use this state to differentiate cold start from
> +  wake-up.
> +
>   Devices which implement reset methods must treat any unknown ``ResetType``
>   as equivalent to ``RESET_TYPE_COLD``; this will reduce the amount of
>   existing code we need to change if we add more types in future.

^ That sounds like using this for x86 below should just work.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


