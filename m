Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46081E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 23:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJLdP-0003P4-OG; Thu, 05 Dec 2024 18:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJLdO-0003Oi-1e
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:51:50 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJLdM-0002pa-FJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:51:49 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-29e7516ee77so1072015fac.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 15:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733442706; x=1734047506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1K1UUAAPycuvo3k7OdGUNpRaHskryB+3uYoZ9vNA/As=;
 b=aakSbDzT2bt0ragDG67PCkibLqACQG09EoBOw2X55pUY+Gnc05ZGeIdtN4pQJ7p3Tr
 Ad7ntLAMCPNcnnb87Sxp6vBOFQG+xjuKdNZZISf6j3Kj3bSJosBccd78VSW1SEOgcH70
 b32BcrvVoLkLQwWDNysvkMw42gsYjnRcNNWP+w8/1/QRl3gDcZSd2nZNRPvED+x8dwqG
 /vov1KNQQvhSu1DNls86mxjxCvhETqrbauxWUBHJQEYF20TRcZ7kgfBNhFADw82hqiEs
 wj6cvvjjfmHJvyW7UB7RuDNTu3JV8fk5eKTGmXWCCcEm9rszxB70FTHbJinJ7NaAzwkH
 fGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733442706; x=1734047506;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1K1UUAAPycuvo3k7OdGUNpRaHskryB+3uYoZ9vNA/As=;
 b=Liz+uLXF2WOz/khjmaXvIKbQsVnPlv9NWiGzJMS42QbcQUaothHOtCZdIjnxLZ8hQ+
 2MaogTrz+3QYnmP3pu1p0meX62Es/vBxVAzMK1cHiS9dy44Oyw9ytLSIV5wf+xQTh1AH
 wntcxQLgosngibmejXVPDFHJe1Yw6opKudy2/Pe4jBqyqx8LwJd/EwMB+Mv53FeoLnO7
 lEFf8w/nMHHtV2xAVOvoCzh5VS9R+VaJdQMSoooKAOBa6OxQ5YvzX+QpepfKlsMotCVk
 LILsOYcqg/1nh2uxamxdNjB9P6mJemuycpZeQXTLaAXucPqQRMbw7rrINs6oXXBmZIhN
 EwBw==
X-Gm-Message-State: AOJu0YzBzzEGeDd7Hvpz/vTemZF2ZZ7r47eYF61cyTcruj6KOgPhf5iL
 vgLa55v3rLFcJce6ANY5ETT9zGbSZyaUrDT42DePD5w7mYEd5DpoJJN+BfXL2sc=
X-Gm-Gg: ASbGnctq+bISyaWtFi7CA/x2mYBde10bMs2pcFp9Rz6NnCgNb79zzyn6qHOd5IIgRJu
 42+2EeZ/FXH3kjkHphKrg1mIrz8/OTitxlWYXDu+8/vqh1Xf/8gxNvJevr1rjxF07ahr4Vn9njW
 3dqRZJLX020PWcO4Y9Z8WcCMpjdCnGuDPYRC4szg9tKbGeSN0YDZXOgz3uWWMxfHeDQeKD/zM7P
 P0eGjU4dDYOv41ywPF57AaNESUB/W5HpEjOw+kHLkAgGO6IRh8z1IsMHrwzHy0R9w5U+WWeXGcT
 AL3o8X/Wu3BVLw1UgfVlRPvMe3nO
X-Google-Smtp-Source: AGHT+IF9tCijy1YfMXohB0O+APlNGmsExWNhLDvgQxNE3rDlh2oq9VvhwZlr1UjHnS3Pl/CHfIO9iQ==
X-Received: by 2002:a05:6870:3d95:b0:29e:6117:bd45 with SMTP id
 586e51a60fabf-29f734d1022mr1160296fac.31.1733442706326; 
 Thu, 05 Dec 2024 15:51:46 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f5677528bsm586144fac.28.2024.12.05.15.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 15:51:45 -0800 (PST)
Message-ID: <edfa85a7-2963-46d8-8b02-4d22ec1aeee6@linaro.org>
Date: Thu, 5 Dec 2024 17:51:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
 <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
 <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12/5/24 12:30, Paolo Bonzini wrote:
> On 12/5/24 19:15, Richard Henderson wrote:
>> On 12/5/24 00:07, Zhao Liu wrote:
>>> The MemTxAttrs structure is composed of bitfield members, and bindgen is
>>> unable to generate an equivalent macro definition for
>>> MEMTXATTRS_UNSPECIFIED.
>>
>> I'm happy to move away from bit fields to uint32_t or suchlike to enable 
>> MEMTXATTRS_UNSPECIFIED be a compile-time constant.
> 
> Yeah, if we go from
> 
> typedef struct MemTxAttrs {
>      unsigned int unspecified:1;
>      unsigned int secure:1;
>      unsigned int space:2;
>      unsigned int user:1;
>      unsigned int memory:1;
>      unsigned int requester_id:16;
>      unsigned int pid:8;
> } MemTxAttrs;
> 
> to
> 
> typedef struct MemTxAttrs {
>      uint8_t unspecified;
>      uint8_t secure;
>      uint8_t space;
>      uint8_t user;
>      uint8_t memory;
>      uint8_t pid;
>      uint16_t requester_id;
> } MemTxAttrs;
> 
> is still decently packed and simplifies things a lot.  Zhao, can you submit that as an 
> independent patch?
Hmm.  I'd been thinking of uint32_t and hw/registerfields.h, but I have not scoped the 
size of that conversion.

But short of that, please use 'bool' not 'uint8_t' for those single-bit flags.


r~

