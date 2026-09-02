Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75572C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 05:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1drf-0002Iv-RB; Wed, 02 Sep 2026 01:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1dre-0002IM-1n
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 01:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1drc-0001Jw-K6
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 01:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788328223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WX+fsdVFyY7mNVSxue30xKMvfzY/BteS/Iu/6gPfflY=;
 b=gRDYm8XdJWgAnhyv672mwj+Um4OuFsknVWypXhC0hcBqtR7CvzTSI1jm7VC36Zw8j9mq+7
 5pvtKrX9ZmrBOKA/nrj0RLhc7NheWx0jRLiHE2xQf1ck73REOHqjeq0YlRdNMWdWFiqM+I
 OOF5UvsMN8mdAi6dXmeKdhz1Tf4NzC0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-jeaD635NMeeB5sbk91YyYQ-1; Wed, 02 Sept 2026 01:50:22 -0400
X-MC-Unique: jeaD635NMeeB5sbk91YyYQ-1
X-Mimecast-MFC-AGG-ID: jeaD635NMeeB5sbk91YyYQ_1788328221
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so5792675e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 22:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788328221; x=1788933021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WX+fsdVFyY7mNVSxue30xKMvfzY/BteS/Iu/6gPfflY=;
 b=mN30+I/KU604TVt26fkXquaby5yL3HG9gHmeZsPLftCeWBvAZK1zo+BeZxKGfTduxD
 CCqHPOGZOTQHarwBMRYVNJIdJKOGP36VUassITLwa1hNr2ov3KLmcEFY7682f/WkGM9G
 8ibugu5VOBtCgZ7VYQDKzJKnTn1wl7wZyEdb4KBicI179WM8Id5qnj4OCkPVO2AatmJ2
 KHf7zuxAaBx+jNOOHovkepQil25tro87mhcuOw/Etl3lNsGOVEMiXvNTAPUMF+JI/0I5
 UZc2xqH5k9n+OtddeSf+oEG7WgZHevoP6cA19RZqVUb/Z86/4q5h+UkoNDgVeJi4kNtw
 G8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788328221; x=1788933021;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WX+fsdVFyY7mNVSxue30xKMvfzY/BteS/Iu/6gPfflY=;
 b=j5cvL3lWirKKKG1LDDih/n/olCWeek/D71BshRHLagRCIb5gm+Q5Gh35I8H7OwCnGi
 dQiHbTe6TaPJxJvWtRO8H4xexu/JYc2Iv6z08tklCC2iG13hZpKuTmKupnN6Huw1+DAB
 UF/iTnrNR6Wxgzva5b0hogX3qrzZNIvhqF+c40gWLEJerL3ECx6nU9DpzFu9E/yemD5w
 lz/TqXykEbuQ86fa7CccIAZHQqeiK0hS4YIW5TGTkpzBR7Wnc/RSYg8iwBmY8OGtNIr+
 sNvn1Kdvmw+KWGklp6e4mGr+4P+Fyn3lfF2b4iZI7pZnF24aj+XFy/tgLKz1iPd/UCPz
 pUYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMjUAZ8h/pVA54LQj2vmsOT4nJhuxiJZP4NXrKH1n8QQQKwmL2BzBchG5Yc5nHckqkCxQkjwV6Nq6q@nongnu.org
X-Gm-Message-State: AFuF++nCqMPD6wTqAKhU2hXL4K9BRLbZ7fNS/Lbw7ihFSSRjdnbk25PT
 8D5WDbov6x91gM59S1z5LvqsLde/6N/Sg4pfsHLjnmMc5g3lNhzTCn/hoOgS3/+eonDq9VOYCAh
 n+59iD+vZGsd93H02FnVEAIH+5o06LuEnZRgwZ2e/Vvg+f9+TEO69KXBf
X-Gm-Gg: AR+sD10zwGIAmdku6dOMLHGkE4i4CqjCA8LhL8pCilOb4RPbtgrf32vSCxggwlJFoxL
 1IIH5FBzngtD8JMMQb2++gzTQ7vzZxBb+0QiB1TYPLcgu0ky1DnwHlJqDXRW4bweNnwrD4BSiHO
 pABt49fnGPv00l52GHChSh/sOP7xm31OXUm8a9VKXXi6P0eVXUMsWqOvJK/ZlEUYI2mmV6vjnRq
 30nA094O20rsFOx/fcyxHP+5kytHq3+PdPFyX6eR9ewYquuEIMXTK6EugM24dpRy5cRYb4irthR
 PbbR6beRzngjS4LQYOG1hPwNewSJZlc3qbq7uKPsFT+POj7+MPOdMZYPMXqy09VuTEcWNuQVId/
 kovgAGBRhINyBOuKmUgaAb8gXESkCwpIGMGfFBd4=
X-Received: by 2002:a05:600c:1987:b0:49b:4d64:bbc4 with SMTP id
 5b1f17b1804b1-49ce58211demr34431075e9.8.1788328221211; 
 Tue, 01 Sep 2026 22:50:21 -0700 (PDT)
X-Received: by 2002:a05:600c:1987:b0:49b:4d64:bbc4 with SMTP id
 5b1f17b1804b1-49ce58211demr34430565e9.8.1788328220809; 
 Tue, 01 Sep 2026 22:50:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4?
 ([2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce4a804sm141038755e9.15.2026.09.01.22.50.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 22:50:20 -0700 (PDT)
Message-ID: <8456b922-05be-47d3-9a97-de61ef773ae6@redhat.com>
Date: Wed, 2 Sep 2026 07:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH v2 14/25] hw/arm: catalina: use the real TMP75 model
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Emmanuel Blot <eblot@meta.com>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
 <20260731-sanmiguel-bmc-locator-v2-14-1266926ba769@free.fr>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-14-1266926ba769@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/31/26 12:45, Emmanuel Blot wrote:
> The Catalina BMC instantiates several ti,tmp75 temperature sensors. Now
> that hw/sensor/tmp105.h provides a proper TMP75 model, drop the local
> TYPE_TMP75 alias (and its guard) so the board instantiates the accurate
> device rather than a plain TMP105.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/arm/aspeed_ast2600_catalina.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
> index 33e75338ef..928e140b21 100644
> --- a/hw/arm/aspeed_ast2600_catalina.c
> +++ b/hw/arm/aspeed_ast2600_catalina.c
> @@ -22,12 +22,6 @@
>   #define CATALINA_BMC_HW_STRAP2 0x00000800
>   #define CATALINA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
>   
> -/*
> - * Guard the alias against the TYPE_TMP75 that hw/sensor/tmp105.h now
> - * defines.
> - */
> -#undef TYPE_TMP75
> -#define TYPE_TMP75 TYPE_TMP105
>   #define TYPE_TMP421 "tmp421"
>   #define TYPE_DS1338 "ds1338"
>   
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


