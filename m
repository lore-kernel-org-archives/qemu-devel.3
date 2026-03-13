Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA12106FD9B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 07:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0xAp-00065H-FQ; Fri, 13 Mar 2026 03:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0xAm-000651-TW
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 03:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0xAk-0007Pp-N4
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 03:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773387781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Sz7qoIjBTYhWH19r+POGAqKJi+nNddIa3gyqJCdrzmo=;
 b=Q0pPKtZ063pDMYhDZeSRag2L/cCM9iEz/Uo0Abtvok1bWTxY1iFYu9btMfMec2M9bwl3q3
 IkOjzR6zgnXzqvFmDsFKB7RCXAF2Sr5l4g+ZmIA1oC7klnnzZU9AQbPdSBvXACM6MSVOiE
 Umjfcovks7kT/N6a7vVbmwujo2lmBy4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-P_dlBnPxP2eS9012g6MSpQ-1; Fri, 13 Mar 2026 03:42:59 -0400
X-MC-Unique: P_dlBnPxP2eS9012g6MSpQ-1
X-Mimecast-MFC-AGG-ID: P_dlBnPxP2eS9012g6MSpQ_1773387778
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4853b0af42aso25021155e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 00:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773387778; x=1773992578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Sz7qoIjBTYhWH19r+POGAqKJi+nNddIa3gyqJCdrzmo=;
 b=g2B2gcjrLHEwU54qmo4m8j+jEzY3riFb6dT3rwOcZeMhIbprqtsBoxwSeHrOJHqVzq
 ckWBQ8bATJZ2CFTm2QxG2GQxKL7yPnSqbp4tkDXtSirW9Edm9/+cLLN6eVjuuLFM1nbp
 X5/aH5BmfZ0OANuUpH1PJn5+QMe3p6Ods/mGXF8f0yX5dmNcU8XdJbIe+36m/85CD3CC
 HS0EHq/7tIqZNY0O9HLDnLRqD2zPlKGA01/R6lAjjMhdm+8hWb3qqdCgSuFI8gXvIYZY
 qlRS79GYx0snSW2+pGOZHk2mcQYHaX92qtpGRDBxM1w2KNwDyysLF//F2n+YvdbC3qyI
 Gifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773387778; x=1773992578;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sz7qoIjBTYhWH19r+POGAqKJi+nNddIa3gyqJCdrzmo=;
 b=LyNhZYecvIZAUS6/njgKUd0qJkqPicZUduMmNAr2KMuzSb23f8dwAFDVbHhFW/EnbE
 SdzFBueLwT8fnW0Ku3SEUZth044kFNXcORTz8cnyA76lehcQ7x8ki64eYv9X3yYMEXn7
 pVcKOjzmBiMnDvVZ8UGB02LxgGr67axnR/BWJL8Mb6bCU5C0Tm7TRU52yUQYC+pmmCPo
 P8VrQamW+HyiQLZXdxgl5baXXdKrMU7IuoRg2vrBiQZ/DUI0fp4X+knZAHzgS8Cqcyug
 M/HuFaEuSb4ddj09qmlSSeI/I/QeWh1btgMFnSeNcsF/gOTO947np0hqg+JdtoG1wqgi
 iRFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKB9bNUZiIvb9Ns7xi3MdpLmBsbGdFPj+oeNLxOjcZTGebQtaGY+uJ9xiRxHBR4HKvGGeVK0V1tQga@nongnu.org
X-Gm-Message-State: AOJu0YzBHCNafBjkzPEy6dp+gt/4kvGDa5tzhNfxo1uGQrM2sK014G8M
 P+Ea7UhWovHlddJR8jhEY++BoyQl/EtXZW3ZrfGsS9pZv3nsd4EReTjkFnMdEKSy5oc+DzI+kx1
 eljw43dWXK3QOjmYPkpEsD03zmbmpK/8aPVxFzq78VmMw90q1xCQ5DGPX
X-Gm-Gg: ATEYQzzxDaHFLFo4MzJ9lzUimQliZEs71Qwy2F6c9ZRxsFGZUxhC46ZTxVADty5Cp7C
 WB69/josv0v9tNYKMJ9e/k2e+xq7cVjG7PY/9dR9F+BqUst4Z7liFujK0347nxrRQv30DKnFaRZ
 XqEiu7lNVx86cbIVcS85FLraGr/EyMxiwOYuwMsP0dw8ih0k3muw+8/MUDpGILVPLriYxK0yJL5
 PEOQMzeRl9IBYudSkT4K/isoTwXPRQI3H+u4X7FqOIrL/N6CcuXKxL0+d7yfgKDgBBs5s+STwRP
 sIUc77InL3kwF2mFzimOsZDzJCX8q8ER7PZaiXC30Zh3bUBS1myLNje3GPt/8YCA/tX1bJE0ECv
 j4kpnS+f01DDUpBehIvfdTwq2zvAHOiZunGt/zfmKvahXZsSac8vSiU8KEaS9
X-Received: by 2002:a05:600c:1e28:b0:485:3e19:9e01 with SMTP id
 5b1f17b1804b1-4855670e7d2mr29011975e9.28.1773387778217; 
 Fri, 13 Mar 2026 00:42:58 -0700 (PDT)
X-Received: by 2002:a05:600c:1e28:b0:485:3e19:9e01 with SMTP id
 5b1f17b1804b1-4855670e7d2mr29011645e9.28.1773387777734; 
 Fri, 13 Mar 2026 00:42:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aba60esm326309895e9.5.2026.03.13.00.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 00:42:57 -0700 (PDT)
Message-ID: <482e9094-78ae-4387-96f8-e254a14333f4@redhat.com>
Date: Fri, 13 Mar 2026 08:42:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] hw/vfio/helpers.c: extract kvm helpers in
 kvm-helpers.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-3-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260312224449.1605071-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/12/26 23:44, Pierrick Bouvier wrote:
> Because those functions use kvm specific types, they need to be isolated
> in another source file.
> This allows us to link kvm-helpers only in configurations with
> CONFIG_KVM.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/helpers.c     | 172 -------------------------------------
>   hw/vfio/kvm-helpers.c | 192 ++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/kvm-stubs.c   |  27 ++++++
>   hw/vfio/meson.build   |   2 +
>   4 files changed, 221 insertions(+), 172 deletions(-)
>   create mode 100644 hw/vfio/kvm-helpers.c
>   create mode 100644 hw/vfio/kvm-stubs.c




Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


