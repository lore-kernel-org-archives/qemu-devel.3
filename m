Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22049D148B3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdkJX-0007qL-LP; Thu, 08 Jan 2026 02:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdkJV-0007ou-TO
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:20:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdkJS-0000Ik-Id
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767856802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+sagmGHkSM0ihRxuTwd+fjwrPEC78hUQNuRhuNd37yY=;
 b=DDhLa4BVxO826ExFTL6GwVga/uW/dPrhIt+ihY1KbNlaKF3KavqEfIE9GaEdI1Cs1lmI3R
 E/1Z1JF4sM+7488QTGlLc//skqftZ/jQJw++vXvdtfKZ7MUjK1nf3jCp29chBxgoOfX4z9
 fJOS5B5QBiquSF6CQ/TP/TI+eEPSX6Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-ma862l9XPxap9f-lvFM-lg-1; Thu, 08 Jan 2026 02:20:01 -0500
X-MC-Unique: ma862l9XPxap9f-lvFM-lg-1
X-Mimecast-MFC-AGG-ID: ma862l9XPxap9f-lvFM-lg_1767856800
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42fd46385c0so1603833f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 23:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767856800; x=1768461600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+sagmGHkSM0ihRxuTwd+fjwrPEC78hUQNuRhuNd37yY=;
 b=flodSHnheA5Jtga+dC1VfSUUFiS6GKR/95VwhoNAhoEvPRKf2eGpcOHLn0ukqfwhXS
 3DCTmzXXfPYGoAHpxjwI1alyP3O2PMN81aVYmSclA5TTaD+4KEao7SiDLD5HaQWwn+8M
 8r3LVtZkAdechBi4XuBN+8jFoXmH3z+psRP4OPlDM8e3IiSM0Sd9pyM/yCv+LDXYTDiB
 H1wXYMZjRDmqsILl8PXVuzrWdCdSdJDcaLYcVZZXSb/kc/OovZDwmOm58EtgbswM2gdM
 0B4ezyoGI71jmViltBtOXkw7/McDnnixPRt/KH0+zLFmIGhluPRGvhlLEWCACLPOQRL/
 w8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767856800; x=1768461600;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+sagmGHkSM0ihRxuTwd+fjwrPEC78hUQNuRhuNd37yY=;
 b=YgYFsdjDbX/oK2/7n2QQ06LZlF3CqXAWRvv77NRAaBLLLgNAJmqyLbsq5WLfL5ZU5N
 xLb6EfyoaGs4uzwcZz7g8sHCJnlEcF4gQkpxa5bZyx/+E+AB7RI/9Fmwp2HfzjeATBJv
 Ut7iMFkkoKJJUndQd11JhCLqqCcNszT0MvAXsnnOCxMylIbU63K6IRoWc2BtyPRL6GKC
 bUJ8ltYGsn8iLK/RTbyvq97+j6zTg2tTReUZ2nd1noSaMOZBIyrju0uXDGmYJTM1Boc2
 Vq27JMWgCMtTaH3H6IQ6HOwRgZeRYP2JwNOa0J4e578DnXAHYdEdnxtwIFHyl0N0ssa9
 wlQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Kbgin08W8Q6QDWQCy+OtEQ2L8Rknniu0ujByH2X3GVl1Vey5/HVyTVKJYH4sMD6yFf09cz3sG62z@nongnu.org
X-Gm-Message-State: AOJu0YwwfObVVyqtpLpiIDxUKrx1aTwe8mimPZc1Lqvp/HwvHhsbYlsX
 d3A5hi5IauMQ96ECrPyMCEJfZaVfOUtABxMHX8AJ3t5MrC6O83Z8VwFE9M7IPmon4VIf1l99+m/
 YunXckNTY1Bhz70lsw0TrLULMva/YnBmmmDR24weOELSn9+hu2c5hE2YW
X-Gm-Gg: AY/fxX49i5jFw1JgDFSMdHbhxy7s/bYF0+IgeMhYZXu6BEn3LB19hacCftcIUMQBL4R
 SU2/rrAXcxnm7p26Vwge5KEIGJuHq/THWjWgtGXzU6gtMDJ+D+biWYCa1qTb9Yqv/Fuvhja737a
 hA3kYLxrA7xkrj6GnsvyfVEAolIaOYlsRy5pgcI9+k57ovgrjvtQRbwTO6tqIPCw6ywU2IhuDYm
 hePRz9tG9GVcFPtsVHevbTAxtIi9zSHKzua67oLzOHcVX28p1lXwBCjreOFXcr+9agYd9eFHZdy
 7OuqnOOIvN751oi8Nmh8t16G/jQna02ox5z2x/Wbie06WnjN6z9cw9e3GTZvPXW8GWnzJharjVZ
 GQjevRO4=
X-Received: by 2002:a05:6000:40dc:b0:430:f790:99d7 with SMTP id
 ffacd0b85a97d-432c3643478mr6969577f8f.27.1767856799974; 
 Wed, 07 Jan 2026 23:19:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAbBt/hmwnpFekBInE/hXqdCfZF5flSYhyWnVyeL3vXCUjlekhUWRRZkOODGJuRMCv0ulZDA==
X-Received: by 2002:a05:6000:40dc:b0:430:f790:99d7 with SMTP id
 ffacd0b85a97d-432c3643478mr6969551f8f.27.1767856799580; 
 Wed, 07 Jan 2026 23:19:59 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e175csm14633564f8f.14.2026.01.07.23.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 23:19:59 -0800 (PST)
Message-ID: <65855c31-482b-4a36-8666-8d2a44ec3cd1@redhat.com>
Date: Thu, 8 Jan 2026 08:19:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] target/s390x: Restrict WatchPoint API to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260107130807.69870-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 07/01/2026 14.07, Philippe Mathieu-Daudé wrote:
> By inverting the 'tcg_enabled()' check in s390_cpu_set_psw()
> we can let the compiler elide the s390_cpu_recompute_watchpoints()
> call when TCG is not available. Move this function -- along with
> s390x_cpu_debug_excp_handler() which was introduced in the same
> commit 311918b979c ("target-s390x: PER storage-alteration event
> support") -- to a TCG specific file to avoid compiling dead code
> on KVM. This restricts the WatchPoint API calls to TCG.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/s390x-internal.h  |  2 -
>   target/s390x/tcg/tcg_s390x.h   |  5 ++
>   target/s390x/cpu.c             | 30 ++++++------
>   target/s390x/helper.c          | 38 ---------------
>   target/s390x/tcg/debug.c       | 85 ++++++++++++++++++++++++++++++++++
>   target/s390x/tcg/excp_helper.c | 32 -------------
>   target/s390x/tcg/meson.build   |  3 ++
>   7 files changed, 108 insertions(+), 87 deletions(-)
>   create mode 100644 target/s390x/tcg/debug.c

Reviewed-by: Thomas Huth <thuth@redhat.com>


