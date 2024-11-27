Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB38D609A7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 08:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGDDk-00086z-M0; Wed, 27 Nov 2024 03:16:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGDDj-00086j-9X
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 03:16:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGDDh-0005r4-J5
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 03:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732695379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3cZUspyUA5D5FfxlB4sB4fGlqDNchANkL1zko7BEkHk=;
 b=Gg2+KK8uMHZkwIjTqofGGP6dVf1sgrlSRkn46bzCsulh1dtcM19zTo8dCZKEyEYKEElGzx
 L6TL4j46KBnuZDkPSQhK29s6EjHIGxwd4lmcs+RPxyRuGiuO8z0OFSvbeDXm2j1Wy93u9J
 UWXnqR2ldZ+qwLZhYasUzkEoFss967A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-WKc-y6RsOem0-HJpRuxbzA-1; Wed, 27 Nov 2024 03:16:16 -0500
X-MC-Unique: WKc-y6RsOem0-HJpRuxbzA-1
X-Mimecast-MFC-AGG-ID: WKc-y6RsOem0-HJpRuxbzA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3824ab6674eso3073486f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 00:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732695375; x=1733300175;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3cZUspyUA5D5FfxlB4sB4fGlqDNchANkL1zko7BEkHk=;
 b=lMsX/NlmsAfE31DtA4eTPNekwQQbKaBeflcWKMkvKtUM4JSx3tIjqO6jttCA/DbsTW
 7OaQ4Dl809TifCJS8yoFjn0IfwWtKLnNBMP2ca/fXIE//HhkcqzBwCD3PE9c00xnAKlx
 R1hG2DMbXF0v3AUJ7BLactDRv9+cqWQP6PGjiiSbJVhvgUOTqYa8QSpfglJtLpWOlKOn
 t4L6JaCF3eQyl67p0228ZZEpFnw4fNQ6mVzcpEbFEhS5QFssu24lq61P07vUm2/R5dpL
 FPFoNmb8B8qhVgrGxCPJeYnAYIYP54uGlgspQeMGIuvfb1cll4meIH4u7/wOi+w5rlan
 wwoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhPAvM/sjmelA2GmE1uv0Dmgo+kuVelShehtPXmmT47YAl7OMEKkpCspIOLk2qPlePseWODkjptb2U@nongnu.org
X-Gm-Message-State: AOJu0Yz6BMhSNzCUuaBVrUwFN9UZ1DfnUgaKu3AjTVIakc/PKSuxvf/9
 rpNomeW5UlszQknQpac/pbh83OBXVN4oNRp0MFRkFwCsyT95Y3gPogy6wafTSQ2cBfj76MjlWix
 ipOTqoLWOqGCgSYM3+T+66E9iSX+v9QLpNpgXfZMtZu4t2shONKOj
X-Gm-Gg: ASbGncu3kPnHlOh6ewqWKH9hQJijCKb5fCgKh60reJJl8Ni8b05Z7DPQ4vddBTTjxl+
 pIqJRzwuNarYgtbACJaPmZGg9OA0m2nyAwgdqUjP11vpRC2wqrZaED3rrAv0zNCCBWOfaDcqTlF
 +1KsNjBtOiXpU9OLYvc1HTQEtILQJMd0mYvPTx+Yv+kvxYTB2wMaVTAAAx1yUQFCixJ7v6nru/0
 PWSFATzmp1cf53Vrbbcsb7PmSmF11VyHxGfQB/hOcgy5LLUr6xCe9ZPzSKxXgV7DEgVce6IVX3C
 yO7qFw==
X-Received: by 2002:a05:6000:2a9:b0:382:5141:f631 with SMTP id
 ffacd0b85a97d-385c6ebe29cmr1397147f8f.29.1732695375293; 
 Wed, 27 Nov 2024 00:16:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGj3iHAo3IG+di1fkBA2wOHiyarpV6oCSscu5ojC+bgdIgHM7LVCJV3oCnSTyyJCVIC3mAHrw==
X-Received: by 2002:a05:6000:2a9:b0:382:5141:f631 with SMTP id
 ffacd0b85a97d-385c6ebe29cmr1397126f8f.29.1732695374953; 
 Wed, 27 Nov 2024 00:16:14 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-143.web.vodafone.de.
 [109.42.48.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedf40sm15403455f8f.98.2024.11.27.00.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 00:16:14 -0800 (PST)
Message-ID: <68b86f41-978c-4d20-8bfd-7c3fb8856c53@redhat.com>
Date: Wed, 27 Nov 2024 09:16:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Fix the running test case causes
 loongarch64 to hang
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Song Gao <gaosong@loongson.cn>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, peter.maydell@linaro.org
References: <20241127013438.2206426-1-lixianglai@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241127013438.2206426-1-lixianglai@loongson.cn>
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

On 27/11/2024 02.34, Xianglai Li wrote:
> There is a bug in the process of resolving the serial port base address
> in the fdt of the loongarch VM UEFI. When both serial port information
> and rng-seed information are chosen in the fdt, there is a probability
> that the serial port base address cannot be resolved correctly.
> This problem can be fixed by updating UEFI.
> 
> issue link:
> https://gitlab.com/qemu-project/qemu/-/issues/2686
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: <peter.maydell@linaro.org>
> Cc: Xianglai Li <lixianglai@loongson.cn>
> 
>   tests/functional/test_loongarch64_virt.py | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Thanks, this seems to fix the issue, indeed!

Tested-by: Thomas Huth <thuth@redhat.com>


