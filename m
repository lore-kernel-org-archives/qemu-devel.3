Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85308F55811
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSqF-0005Oz-Ge; Wed, 22 Apr 2026 04:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFSqE-0005Od-40
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFSqC-0006UX-QK
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776846107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WdBBKk1Aj7ayyKc/qEdtOA5E6yuicaTqE3yRCdojQmg=;
 b=FV42jnEQF7mgSzqQ+fG/nIl/tDEwvJfvPyWpW+5LoitGpr/kj0jI/m2mvt8kR9gF0WQoFQ
 Ue2g02Dv+Y0HNk/zIQgS6qC2mwZ9vNCt42prnNV21uZ7MYs7cxeondGvuOj7hFw1rIa7qa
 Y+jDi9gqV3doAMv0zR0MKo1RHAtZAtk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-QvMgZfvaNXOgxwMwIgo6MQ-1; Wed, 22 Apr 2026 04:21:46 -0400
X-MC-Unique: QvMgZfvaNXOgxwMwIgo6MQ-1
X-Mimecast-MFC-AGG-ID: QvMgZfvaNXOgxwMwIgo6MQ_1776846105
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48a5c837c44so632885e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776846105; x=1777450905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WdBBKk1Aj7ayyKc/qEdtOA5E6yuicaTqE3yRCdojQmg=;
 b=Q92Tbl2Qe3Zx1mcNgJLgDNPTvrtShoRO7US4rPZktpGdhFB8L5VpalBteoQxtDgf+T
 iGhC7zolI1FXT2IgKnOg7ktn7AqrJsI4/7TPTVvwFgL7AK31YpaU1gejjM8+dQK1Z+lW
 qUlJF/0/1XbVRNHspCaSUwDXomDGlUjYunF7QHCrCIz05k6nPS9fSy+3j02YN3fy4sHI
 YfLoxLHBe27WOgJiW5bYV03W81rPY8SkPFfwyxOoKYe4lkqHqbMA4j1kElBIxHGbBiMW
 oz9x6L1QuLmDVe47Bl7LDQ3+aBZMg9jYWWfHUnCoh5X3/habyj+QSBPK7KlTnlEH6GgB
 2P7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776846105; x=1777450905;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WdBBKk1Aj7ayyKc/qEdtOA5E6yuicaTqE3yRCdojQmg=;
 b=fR3EcLfhC23hkqoFVPL5+vPLwcO/fmqR/9fpLsx592hQFqz36DbbUYQrYacyeP/PTl
 j3fZmDw548htmD6AMbW9vWB/AMSeKi7B0tyy4GfHl6SLt8mH6IqdvrXGFTiGe3Hbzmps
 Cn/PefWXIcUcSXD9oUq56SNYMDY02sqC9DKJecE53F5fHA1xxAh94IIYPFoV8HltmQke
 lUFPWw4L3E2G9aYMJFI/C3dhwpssTDCuslKsdeVi72x8Xw5/F3fgQr5aFu1cmlY2GtrS
 xtMz1iBXeyOSkgm2yJncSAHyKKxQyBm0eqBiaYHd3KAg2SoZpEqCcP22lt50U+UJ0FGL
 xX9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZhKQ4wdrQHjc3QPMAnYg671VCSBTmUhVXYz4eVtsE/xetiICRqpYZzZ1PbnHB8QzgHzdfEXoGnhSY@nongnu.org
X-Gm-Message-State: AOJu0YxkkLeRT6B/PHWHc48PIPgl66dBQ8kj9m4FYk5Dw1K7a9vPgeqb
 XEAv4MMqrVo0aekwigsJNTZRB/UyGoEP4gAUPtr3BV+42EGFTwZ2uiflk+SglC5uHv+Amw2qWVO
 hXT0pYPdU6ch/Fs7WqR6eTrd269eISextIbxjH5oOJdkmfoJ1lE3K9MAb
X-Gm-Gg: AeBDietfkuwhF7c3bbwrikRKlvQUIfBmQR7I7kl9cUPOQETBGQdoLUDvAVO1J42aGSW
 51yN0HQElUBJB/q9pJq2Xsf2OGf6igf5xkHxe9jzV1XlhaY+I0CYhqiYAImKfIpDkvmSedQJ9On
 o2Uu8VgCfc2LY5mWqLvjONfXDh23rSkYepP1KNgsmlwYTdAJ2Wfg3ACje0yTvix6ZfSL6CHqRPO
 GIMChASy5Dpa6L2uOVBmPHZriFo21lrHwIg/qL2zj03xIlNrZdHfVEsiEN8CCmx8rDeZwwuPJPv
 tVbWl74u5R97XeooS7rCqnUn9fFD9eSuC1SJ+kc8Kai81thVa3lW5jykWk7eIDwxemfIrhq/alN
 ydlPGxXohARn9KMrDPKroZVmVh//Ngg==
X-Received: by 2002:a05:600c:628c:b0:48a:52d4:888c with SMTP id
 5b1f17b1804b1-48a52d48985mr130865865e9.3.1776846104571; 
 Wed, 22 Apr 2026 01:21:44 -0700 (PDT)
X-Received: by 2002:a05:600c:628c:b0:48a:52d4:888c with SMTP id
 5b1f17b1804b1-48a52d48985mr130865365e9.3.1776846104102; 
 Wed, 22 Apr 2026 01:21:44 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7b2716sm135867495e9.30.2026.04.22.01.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 01:21:43 -0700 (PDT)
Message-ID: <53a6ed6c-21ba-4da1-a157-41265d76b206@redhat.com>
Date: Wed, 22 Apr 2026 10:21:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] MAINTAINERS: Transfer FW schema specs section to
 Daniel
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>
References: <20260422080406.62638-1-philmd@linaro.org>
 <20260422080406.62638-9-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260422080406.62638-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 22/04/2026 10.04, Philippe Mathieu-Daudé wrote:
> Pass the torch to Daniel, but demote the 'Firmware schema
> specifications' section from 'Maintained' to 'Odd fixes'.
> 
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e651d18879a..5aceda193c2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3963,10 +3963,9 @@ F: docs/specs/fsi.rst
>   F: tests/qtest/aspeed_fsi-test.c
>   
>   Firmware schema specifications
> -M: Philippe Mathieu-Daudé <philmd@linaro.org>
> -R: Daniel P. Berrange <berrange@redhat.com>
> +M: Daniel P. Berrange <berrange@redhat.com>
>   R: Kashyap Chamarthy <kchamart@redhat.com>
> -S: Maintained
> +S: Odd fixes
>   F: docs/interop/firmware.json

Reviewed-by: Thomas Huth <thuth@redhat.com>


