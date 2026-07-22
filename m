Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3330BC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWbz-0000gK-BU; Wed, 22 Jul 2026 09:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmWbh-0000We-Gn
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmWbe-0005al-Hh
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784725403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RLdaxiDMILvREuSRxCx8V8sFaIWwW+Di4I//9XZXM1Q=;
 b=i76JXMuT6R3+tSj7Saq10bVKRKA1anXIXY6i680RNDwr74vcGhuFoDWKXXnb5QEFiF04zj
 NVHdWXp3yRD4JLOWxINOGjNlvIDN58wja6FvojWT+QQfY0Y9SPzA6HfcvA+gQF7ODtAl96
 SLI3H0lalJFwT5s1NHT1lmCzgOD5k0s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-0Ft_aQIcPEmPNEk1wr5dFg-1; Wed, 22 Jul 2026 09:03:20 -0400
X-MC-Unique: 0Ft_aQIcPEmPNEk1wr5dFg-1
X-Mimecast-MFC-AGG-ID: 0Ft_aQIcPEmPNEk1wr5dFg_1784725399
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4954fe32d6eso25364055e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784725399; x=1785330199; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RLdaxiDMILvREuSRxCx8V8sFaIWwW+Di4I//9XZXM1Q=;
 b=P1nvWzropsxgSMBsNKUreejyGJaU05N0xG0U1CDCe4b4hkGrr1eqDl4Ri3KpGDBnWo
 vr+79UzSqemFm9IOZe2PViIqmcgBRb6weZ3sKmj0hx9SHdBFAkWIouCPyGIjaamiayPT
 E3ixcYbpgowrvQUrsAaqPTF+zuEH1O0bzds7m2f/PqQeQdGL97y2Rwab0VFQxlSBV7sZ
 iXEOntUklEyyWFskN1ma5VkNNfxq6Fzq8YmXjAuThuwL8IMXT/rYJshIe6kGWdXyOyL+
 nfoTL8mwHXUUR1kSWoaofvvxs6spMlkjl3HxOMFAqSkTek2YayOPZbIj3hEH62jM0Ziv
 xd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784725399; x=1785330199;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RLdaxiDMILvREuSRxCx8V8sFaIWwW+Di4I//9XZXM1Q=;
 b=G6puXKWqtnTEgOUt3hyc0Uz9sIkYdCn35jE78DZFFbaTyLkYexFFaphp1brKykNAIh
 Wo/gHp+vn1gEYBw3HQiAHKdAjqBgYnGzdXH5zYTc/S7SaxzlzNqioJzCkyaZNWtqtY+7
 rQvyJXNCl9gE9AqHnl7or5Q/hXdDLEnCu7I0C9dggZD5qS3DD9++XHNTw8fiT7IVInCq
 GeHvIchsciUsUjhItnzOcRTSNEtR1n2VMN4MgJF7HMqMvDhcUr5yMZ7r+lEIcetLtlAN
 rmBTMAOFTg4IV5+qt+NnpCFva5w/Ds6H7R06LXIngX8WqbVIOtzK+ZA/0NNEf+O9NHnI
 Vjqg==
X-Forwarded-Encrypted: i=1;
 AHgh+RorJJDAb15xUsa00Uxj9LDSIwNKyCu99c7opbix5aRMzE3pNUrAZfX8zAI137MbIq12/hdE8aRmdn9b@nongnu.org
X-Gm-Message-State: AOJu0Yx4gKOFl8cizsYvZtHlPl39fzRAqOiZwe1nXMZgq0K4ZKxa10T+
 +Z0ZZYFQeYo/AWACVAG/zMWLcQaLNu9JktuZmT9mAaokfqtYpuO+YJXVgPRQl+H9NCcwRr8iUtS
 RTSW/CFhuWaK4PihE1iN8yG6WxWojHOgELTeRpS0wwavKxRS5u0RZ4fXZ
X-Gm-Gg: AR+sD114CTEwMKL54FVmJOBLXtp7FPZqjtfHb8NupzGe5kJ2vutddkmS5Fkutn5SWmx
 hoU3vRJlEjuQDkEbctfudBmYApLIWz67hSDUs0NB8ibAjtajkcQdmBI0ofLJpekaR2uLlTA3YJj
 GU+KLOSbIG5SHCYk2Cgfhp/PfiXLqLfZtGgBFQQ4FRRpqT2Ue//qfWZPpXUBwdsT3ifzkUHpKdq
 30Q7ZggB0x1PZKfc+wmr1CwknAtPf7lmxn4CQOKvqe4BVmnLLPgxtzueylCBu3Zx7Tn4WT30tQj
 M/0Y2ieU/ywLBTyQUgshNTLKFzCXJyfp1ZPrYYvfLG2YEDP2Ii8RGeZy/CztOzi/enwvVXuuf1Y
 YR4LHGE17/F3fOFUDxe1P8+Y6VQ4CH39lOxaMwk4=
X-Received: by 2002:a05:600c:4503:b0:493:c84c:2b57 with SMTP id
 5b1f17b1804b1-4954a513f99mr251981715e9.29.1784725398834; 
 Wed, 22 Jul 2026 06:03:18 -0700 (PDT)
X-Received: by 2002:a05:600c:4503:b0:493:c84c:2b57 with SMTP id
 5b1f17b1804b1-4954a513f99mr251981235e9.29.1784725398360; 
 Wed, 22 Jul 2026 06:03:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm150531475e9.3.2026.07.22.06.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 06:03:17 -0700 (PDT)
Message-ID: <7421bba8-74d2-4e8f-ad4c-a4c06df1a385@redhat.com>
Date: Wed, 22 Jul 2026 15:03:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 11.1] crypto: deprecate the AF_ALG crypto backend
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 devel@lists.libvirt.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260722115701.716516-1-berrange@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260722115701.716516-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/22/26 13:57, Daniel P. Berrangé via Devel wrote:
> Linux 7.1 has deprecated the AF_ALG crypto backend:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a67afb1884ba815079bd43d5c998e155e03b08b6
> 
> And has documented it to be always slower than userspace crypto:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5624ea54f3ba5c83d2e5503411a31a8be0278c1e
> 
> as a result of dropping support for zero-copy and hardware
> accelerators:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7524070f26d8d347c26787dc297fb844baa26abf
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ffdd2bc378953b525aca61902534e753f1f8e734
> 
> The main use case for the AF_ALG impl was to improve the performance
> of virtio-crypto with the cryptodev-backend-builtin driver. In
> practice this did not matter since 'cryptodev-backend-lkcf' can do
> offload to the kernel via the keyctl syscall, and 'cryptodev-vhost-user'
> can offload to an external process which can optionally integrate with
> hardware accelerators without kernel assistance.
> 
> The AF_ALG backend has no user visible configuration options at runtime,
> it is unconditionally tried with any use of the cipher APIs. So it does
> not strictly have to go through the deprecation process, however, it is
> left available initially in case there was an unexpected use case that
> relies on it which may be faster with old kernels before the above Linux
> commits.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/about/deprecated.rst | 21 +++++++++++++++++++++
>   meson.build               |  6 ++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0c656a968f..54b2662752 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -416,6 +416,27 @@ ABI is long-obsolete. We are therefore deprecating both OABI support
>   and NWFPE emulation, and they will be removed in a future QEMU
>   release.
>   
> +Build features
> +--------------
> +
> +Crypto AF_ALG backend
> +---------------------


   Crypto AF_ALG backend (since 11.1)
   ''''''''''''''''''''''''''''''''''

?

With that,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> +
> +The use of the AF_ALG backend for cryptography has been deprecated
> +with no replacement.
> +
> +The AF_ALG interface is deprecated by Linux 7.1 and all support
> +for hardware accelerators has been removed. It will thus always be
> +slower than userspace crypto due to the overhead of copying data
> +to kernel space. The GNUTLS, Nettle and GCrypt libraries supported
> +by QEMU all include a variety of hardware optimized crypto
> +implementations which should suffice for typical needs.
> +
> +For the virtio-crypto device, the 'cryptodev-backend-lkcf' backend
> +can offload some operations to the kernel via the keyctl syscall,
> +and the 'cryptodev-vhost-user' backend can offload the device
> +backend to an external process which can integrate with crypto
> +accelerators.
>   
>   Backwards compatibility
>   -----------------------
> diff --git a/meson.build b/meson.build
> index 164328ded8..02cbe6445a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -5053,3 +5053,9 @@ if not actually_reloc and (host_os == 'windows' or get_option('relocatable'))
>     message('QEMU will have to be installed under ' + get_option('prefix') + '.')
>     message('Use --disable-relocatable to remove this warning.')
>   endif
> +
> +if get_option('crypto_afalg').enabled()
> +    warning('Use of the AF_ALG crypto backend is deprecated, ' +
> +            'since Linux 7.1 has deprecated the AF_ALG interface ' +
> +            'and removed its ability to use hardware accelerators.')
> +endif


