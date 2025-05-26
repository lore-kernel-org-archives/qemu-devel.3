Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F45C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 11:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJWKQ-000856-BP; Mon, 26 May 2025 07:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJWKC-0007vT-G3
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJWKA-0004pS-8f
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748260136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vZPgxWPMSWWUV+3oUjq1r6Jckye4rPS/QqNFNYgWyVs=;
 b=jJM6CpXFEiIgTcyK0SUJ+mmh/YwOZ2XQ9CkFVeuP74LbiSaoFd1bKR1JZvJhhG8cIf7YPj
 qfNIcgYU1bFFt5uEjKFm5ZqQG4YC2EibuSQGUDChAoMmh8x1xPhwza67yYZbJ5lA3vmggl
 WGBm+5Q5cM57nr9sG2IvDfPdrJpiTIc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-gc0aZcgBPfq7rlMiCVYCiw-1; Mon, 26 May 2025 07:48:55 -0400
X-MC-Unique: gc0aZcgBPfq7rlMiCVYCiw-1
X-Mimecast-MFC-AGG-ID: gc0aZcgBPfq7rlMiCVYCiw_1748260134
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cec217977so12269715e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 04:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748260134; x=1748864934;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZPgxWPMSWWUV+3oUjq1r6Jckye4rPS/QqNFNYgWyVs=;
 b=bGjZ3sa6oGeWCqVEPvefFLKEu6DWBjzyYJ+LVsZvHENS0hTfhQQ20bbkC+0NQ6lQMH
 /aPfGTJTvBZWqhEy+SIY2mOWKrdqheg1GQw733RulAixZXyDAa1lyKFaVkDuz2iHdKU+
 1XgYamnySzt9MR//b6pLyUu8z7XylWOmDYv6852Ab0vmkPVXejCHTvM5EJKbUlJLl+hw
 gZJT1jeS4iAFqQ/vYSPYdhrpPqe6RYyQap+EO+LZdPyQCWDnJl1/NdjUXg/TJn/F6go4
 RoeK/UY1TLjqeul1TaL+4Apt1jxH55eLzGB0mWVZrhgBeJFp4X8wFGCTOzTUiWXQMx/u
 qcFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmwH+ZDzR2y5H7ql4OXGGw2XCtrTa9QlSW1O5fWC+TqcspbpTShCNVQaPIk9Tbjj0JGy7ZmWyTNzKt@nongnu.org
X-Gm-Message-State: AOJu0Yzfy4WdUf604xsLmZjr9OStx5juQicxgypANPoP2z9LGUT8VnwC
 0rvCrcGRnwLUr+qqhcEXI66a6SauAy5AiWLZM7Ev/xef5BNpa0surTKTRPKkeUBl/3niyoZP3GX
 mU8Y5KcpH8/FSWsN/VXqKgBzjzYJpPNAW/TpTZfCIO5Dhx9HY3NYuIpoY
X-Gm-Gg: ASbGncsED1wV6Q+BRJNsCoUFkRiADt5sP7SD4EUHRIEgT8960joF+6dKPweMq8M0Rr9
 jbDOVsybWEdXMcFQefUDXpie9cv3zacDRf2TFn3mfbLDBG4a6NkWTrWjuaDjzu3H7b6fDHZ4bvr
 Fssrq1x7fA4Ten2T4UMRlFscNQiW02OHiyymDwL3U53FP+f4J6oUiOtaSZOWKBayFRrz1KOGuvb
 xN3Y0LBRYBLAHwxAhaODA73IM1y0Yz0w6/819pvu4nq2l1xGnxej7xXO0RCOQopiBqf6Bq2X1lu
 gUZNq1uGRd8GZMzIKxnW+UVK3aLJUlbde+XtzXR4mTp2Aa6Zsg==
X-Received: by 2002:a05:6000:4020:b0:3a4:de01:e5de with SMTP id
 ffacd0b85a97d-3a4de01e749mr1065043f8f.59.1748260133900; 
 Mon, 26 May 2025 04:48:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEho35lUZSi8kyH3TNyHsK1TgTgWm8XnteUFnkSPwP4CBpVJ3HjYK0pFIVeRnZ/bQD7qRnb8A==
X-Received: by 2002:a05:6000:4020:b0:3a4:de01:e5de with SMTP id
 ffacd0b85a97d-3a4de01e749mr1065015f8f.59.1748260133482; 
 Mon, 26 May 2025 04:48:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f0554fsm232649265e9.9.2025.05.26.04.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 04:48:53 -0700 (PDT)
Message-ID: <53085b7d-ed47-4a3b-bb8e-3b92e24f2bc4@redhat.com>
Date: Mon, 26 May 2025 13:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/ppc: PowerNV machines expose a I2C bus
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
References: <20250526112346.48744-1-philmd@linaro.org>
 <20250526112346.48744-3-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250526112346.48744-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/26/25 13:23, Philippe Mathieu-Daudé wrote:
> Since commit 263b81ee15a, PowerNV machines instanciate
> a I2C controller, so expose a I2C bus. Express that in
> Kconfig, otherwise we get a configure error when trying
> to use '--without-default-devices':
> 
>    The following clauses were found for PCA9552
>        config PCA9552 depends on I2C
>        select PCA9552 if POWERNV
> 
> Fixes: 263b81ee15a ("ppc/pnv: Add an I2C controller model")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ppc/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index ced6bbc7404..0d017df83ee 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -29,6 +29,7 @@ config POWERNV
>       depends on PPC64 && FDT
>       imply PCI_DEVICES
>       imply TEST_DEVICES
> +    select I2C
>       select ISA_IPMI_BT
>       select IPMI_LOCAL
>       select ISA_BUS



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



