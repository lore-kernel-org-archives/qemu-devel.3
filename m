Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A398CD2E008
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 06:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRPRa-0000XC-BV; Fri, 05 Dec 2025 01:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRPRY-0000W0-Ez
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:37:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRPRX-0002ue-2g
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764916641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gAOTv5L1oE60VcoU/Qgi0Z0CkKSsrcMdP4pNYGHKat0=;
 b=KigMceRQUkWGLJXxqchmSznM0Ymf2VpaAPKK9oCSOJt6IknKLUuzN5NLXhUz7EzJ7Y7Gg3
 KWsaAkaDvTxu05k1ckuZ5NPE0YwlCAxSUWO5aEGU4Udc7+xWD6Jp/fNMyKp4hRW3UYSLbV
 vpq/NTP29beV8aPTbTJ85WHol1e8Rrs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-AWwvN6d-M_yxjxElY3Z-Ag-1; Fri, 05 Dec 2025 01:37:18 -0500
X-MC-Unique: AWwvN6d-M_yxjxElY3Z-Ag-1
X-Mimecast-MFC-AGG-ID: AWwvN6d-M_yxjxElY3Z-Ag_1764916637
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47799717212so10307575e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 22:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764916637; x=1765521437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=gAOTv5L1oE60VcoU/Qgi0Z0CkKSsrcMdP4pNYGHKat0=;
 b=d0lFgKbGzebQVlVUHGoBB/RmPAt/YDejNBGBUFAJlwtouwZezWjF4TgRuAcZzztW1F
 f9ir1W0Nme0rCfe9NDDHskAb34m0bc9KjMoag+pjZkkvCoWkE7qkiBNjjlXTlktBrInh
 4Y5unzvvSYtZWuCUfo/STQtiHM7E1uvNfUAMaiHkD7OdMP1F5+O2wXUPmQBX0l6grvD/
 LobjYcALmaVWOOWz3BZ8+iKdEIGwtLI1N49Ju/xxUaINV7pGsvjNaBIf2Mxq8mysA5Du
 DcgEhqDa738SwqS7iu1yLMCJjFU/j7FDeVqy0nDFcjLMFDFYLvzduBGHW3QTFlIlQSlL
 221A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764916637; x=1765521437;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAOTv5L1oE60VcoU/Qgi0Z0CkKSsrcMdP4pNYGHKat0=;
 b=VzlB4Gyo0P+n1biY8L16rxX4fjm72b0Vyxh3T2v75jIOuiw8FrBRy8129Nb3G03B3F
 gb63AdZ92bb0Y7+7WO5KJDwiC1vMU2RNA7zW/XLIvSi+gfdhWnqFRTcTkm5TJdcxmJX5
 S3kpQSGRt8bnGEl+jwhQ6Aqwvm2n6yd6kyQCQnLQq3OfBTPhuZehpHvBZwaMowk/HaSb
 o6vLJWnPuPkWKSvu5aTiHkBkDfkUYZ+dmGjMgOZ4xDaa7Fl5VF+TAmnXtO/TSpWb5xgJ
 pH5eGHgnlWldBvcc17Aov30u9Wvbv5fPG/z22ALey1KN8QEJA+Wcvlut/hBS70g/iDeG
 iD3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCURUS08Ont+fFoDiVWqbDWFBK/LQj3FUVG7O3j/vA1w5TX3tmVac48beIiIyGggklIHW7QPxXkb5+DL@nongnu.org
X-Gm-Message-State: AOJu0YwriiDX9BU26W6AWDwrLgqHUBs6ve3d/Nrlx8fMUPFY2bGzlaNq
 CuunMq4BDBKGSqlw3tsKLNglCZnbHL5gGsTIuHNL5Qf3btQ/U4hl6dtp5pU/GSgwVi0xQ7uS2eP
 lpDrmeLVMrvdoAStTdTsURD1wdUlCPnDiIiCsgnbQE6WleFyF1dbSK1Xo
X-Gm-Gg: ASbGncsBtT3kkT+Q/rWk4snCXrLcPw5aalMAzZkivL3f5iF3jANJZIKeoC/DgU7Yeq5
 7/dFZVGZMfAoKtqIeQ9/ZBeWbRlvGJ1wtF9Fkxcv8CkF7i5+zczJHpNaAz08xaiIAlIQ4lLvnnl
 eHolBv2549HgHX3FfTF1gK/OeCybqtKv1xSBIBXUHDobvQKPeq51Ck9EvEmK7PJRVt+hY44Ji3w
 rDQ3tZCeLSH4SoK4SN4GGXOnsH4OJ9PYB53jgS/bCAUY/MLQ+1AbNRtqJqrvdZ67UkTIIWHTNP6
 5QL8j5x7EjjyK9aaQU5CHwvbYi2haP4Bv6LkwOTL2GQzq5UpvVVOMBYNKUj4HNKfVfkNvYrU4Az
 QaE0iFtU=
X-Received: by 2002:a05:600c:1ca0:b0:477:7925:f7f3 with SMTP id
 5b1f17b1804b1-4792aef1a2bmr98822805e9.14.1764916637016; 
 Thu, 04 Dec 2025 22:37:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfNaBlmLSjk7k7Oc1ng3C1gCY69a6n+pbW0InCLzICZ7GqX8Hao+49lY8b0AlhpJuO3t23Bg==
X-Received: by 2002:a05:600c:1ca0:b0:477:7925:f7f3 with SMTP id
 5b1f17b1804b1-4792aef1a2bmr98822515e9.14.1764916636620; 
 Thu, 04 Dec 2025 22:37:16 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479311ece7asm65507235e9.12.2025.12.04.22.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 22:37:15 -0800 (PST)
Message-ID: <f077e5e1-53b7-42d8-b457-90fdf775c71b@redhat.com>
Date: Fri, 5 Dec 2025 07:37:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] tests/lcitool: add nettle to the minimal deps
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
 <20251204194902.1340008-6-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251204194902.1340008-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 04/12/2025 20.48, Alex Bennée wrote:
> Technically we don't need a crypto library to do the base build but
> I couldn't see an easy way to skip iotests which would otherwise fail.
> Besides libnettle is a fairly small library even if its not the
> fastest crypto implementation.

I think we added checks to some of the iotests in the past already to skip 
if the crypto stuff is not available? So I think it might be better to fix 
the related iotests instead.

Which test is failing for you?

  Thomas


> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/lcitool/projects/qemu-minimal.yml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/lcitool/projects/qemu-minimal.yml b/tests/lcitool/projects/qemu-minimal.yml
> index 2a1ac51d402..eebdc23e682 100644
> --- a/tests/lcitool/projects/qemu-minimal.yml
> +++ b/tests/lcitool/projects/qemu-minimal.yml
> @@ -18,6 +18,7 @@ packages:
>    - libffi
>    - make
>    - meson
> + - nettle
>    - ninja
>    - pixman
>    - pkg-config


