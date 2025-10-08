Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15823CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 11:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Slb-0000jS-5H; Wed, 08 Oct 2025 07:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6SlZ-0000jK-JV
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6SlS-0000M1-SL
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759924516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+p1z/OtqMtde6r75MPkwW6WZjxiEHU2eS7BelKggiNU=;
 b=VdCnvOfZI9D4n26AZUJ3XRtaqeCXRO2N72JFLC5ORZu0MZD5cuJRDBrJdeo//WddrqxzWs
 wBeQizN0rhhu6Ju38kV9nfIYXNFrhS1Fs7Ra3ovD7TUzGdMBy3MKFM/uVwKUNUJVEzWCnK
 9DHF9r6tA4UlbCSGahGQtSjjcMKcTdU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-lVKXJPOEPACNi8JgAiCzTw-1; Wed, 08 Oct 2025 07:55:15 -0400
X-MC-Unique: lVKXJPOEPACNi8JgAiCzTw-1
X-Mimecast-MFC-AGG-ID: lVKXJPOEPACNi8JgAiCzTw_1759924514
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e7a2c3773so3901445e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 04:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759924514; x=1760529314;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+p1z/OtqMtde6r75MPkwW6WZjxiEHU2eS7BelKggiNU=;
 b=mxxnKrpm6imOYD0pnPwQBt4doh1oAHMyhMJhtg1ObPzUQLe5n9YDUb/UUg1pDGj4jY
 zqfmttANlnxcrHcOSsvHH73N4kiLKtOWSKPKiEoGVZaihzvd0sx0bLUIHFlw/zQvzl/k
 b2IWMGWARtP9/Xq63FCuuNP/YlAzfPYQvoqP/QTvbyDDtQ9Dq4YmnxysgXbyDRFMR0ca
 SmLlcWjozOYqVfgCLoHChDvnhkbJoc9dtwTEVkosLWsRFPVTTJczHZRU228Njh6wQXPs
 G3NRH1BxGt0H0BYvkcsWQLtUnhOFKU/DbbkMi+C+/HlEkKzsRhBTMuMlThueYzI/Wyj8
 n5jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjY9hmcUoPB3oGhYKnLDVxKJhSmFZ41t3FTUBCohVuUg0Ke5GLRGsmkjzP0nhsO6V1TxtO9YQ+HtGr@nongnu.org
X-Gm-Message-State: AOJu0YwPHOluKPUvQTa3IntUEB4sd1dRJKEGTbP2YwELvUSMVaP/7la0
 D4JHYvSzeoaXQx/C4wqWtGetcavgIZ/IJJ9/ydv0Ah+RhwiGGFJ+7XA3kdIByMT7motj+p1O3Di
 w6yhV7k3/cNUv28ol2OJQ//CFfrl85k+ZtqhW3sUY4SfHM3Y8Ggk+rKsY
X-Gm-Gg: ASbGncsODnhRVty4qt4fYyBUrAVx9U5AZg5l2dg61lJVifJ95U8wlR+gQlgaVb+vM4p
 UIrkNHPw2osBcdsLgspNJleUrbpB0KzksJMnrMXwVyQXYPQFd0pITN6UoaTbDsziQzfkJMzJzPh
 GzHjdpklqcKvoKHc0dSssPs1j1+XZ54/a7f6y4c4Xy9iZInW2ElKky+vgMPMxmvI35mJhBt35J5
 VGbZl+ZmTD8L2oLhR3FtTlg5PSuRjdB0u8ZH0L1AHPmOJdn8asdn4qnjFNLLJKhj2QN5TqJr/MX
 pexIotxb+tnq+SwPgZTBpcah0cCGbYANa0FvkK2lZfUDAaupuCDr4XLjeE3WmPQg/RgRREYJWwK
 gxDDlW3/NNA==
X-Received: by 2002:a05:6000:3108:b0:3f5:3578:e538 with SMTP id
 ffacd0b85a97d-425829ee04bmr4479080f8f.21.1759924513895; 
 Wed, 08 Oct 2025 04:55:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3NT9Tgq5NGPdDZaAt8jbXpzsOUAm6fiAYI9FkC3MQB/VXo2Mcm9yLMwG/TkG3557jpe2E/Q==
X-Received: by 2002:a05:6000:3108:b0:3f5:3578:e538 with SMTP id
 ffacd0b85a97d-425829ee04bmr4479067f8f.21.1759924513469; 
 Wed, 08 Oct 2025 04:55:13 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9c07992sm39118855e9.5.2025.10.08.04.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 04:55:13 -0700 (PDT)
Message-ID: <bc904027-5b58-4057-8ef5-15e4ebcca767@redhat.com>
Date: Wed, 8 Oct 2025 13:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests: add nbd and luks to the I/O test suites
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
References: <20251008113552.747002-1-berrange@redhat.com>
 <20251008113552.747002-4-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251008113552.747002-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/10/2025 13.35, Daniel P. Berrangé wrote:
> This introduces new suits for running I/O tests on NBD and LUKS
> drivers, giving new make targets
> 
>   * make check-block-luks
>   * make check-block-nbd
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qemu-iotests/meson.build | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
> index 939a14ffae..5735d67c8c 100644
> --- a/tests/qemu-iotests/meson.build
> +++ b/tests/qemu-iotests/meson.build
> @@ -23,7 +23,9 @@ qemu_iotests_formats = {
>     'raw': 'slow',
>     'qed': 'thorough',
>     'vmdk': 'thorough',
> -  'vpc': 'thorough'
> +  'vpc': 'thorough',
> +  'nbd': 'thorough',
> +  'luks': 'thorough',
>   }

Before we do that, I'd first see a solution for the problem that I described 
in my series here:

https://lore.kernel.org/qemu-devel/20250910153727.226217-1-thuth@redhat.com/

which, by the way, contains a patch that is very similar to yours here.

Also not sure whether we should add "nbd" to the "formats" list - it's a 
protocol, and not a format, isn't it?

  Thomas


