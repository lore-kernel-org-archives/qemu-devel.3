Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAE3C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3no-0005z5-4c; Mon, 03 Mar 2025 06:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3nm-0005yE-75
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:17:38 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3nk-0005zm-El
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:17:37 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390eebcc371so1454776f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 03:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741000654; x=1741605454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ksoU/1VaaUZoU4mlJMyeK7SgX3TqGsl9Aloetr5IUqE=;
 b=CFmX87EdCKf4fzqJRH5wWeOMua3JCSlhTjdp8mTpKXmfrB1po8B8uEiVzC0w935UhR
 qM0zJcGyM+b9aN4qvgyRmlaqLnNbue1ZUQVIuntGjEsPnY/dXfbz2j9MrxvGpUzMvPTV
 nJVkVKX8L/CP4WAVKWKiVt3zR82c65/en6b4KOmQE2rtPT/tOGe9yKuXpzdlgvr+pvXd
 HZD6mYz7QDCAIm2FvJDNp2Wbxn4iOMOgqODpGx39LjR7q3/5vGzq4knQcgiy2FNnb9r7
 oAHFyH5qZHw4RFHLBJvCRI2ccdMA1cAdvknls5h9DlkjG+Ti2NN1YAYk+tTRxktIL7hI
 mexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741000654; x=1741605454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ksoU/1VaaUZoU4mlJMyeK7SgX3TqGsl9Aloetr5IUqE=;
 b=Wwqj5JwzDLl8uWzWJjoXmYL8GHwmh73GiTykzyQjfWVTlDoJL9QPsQs8tZ5a6f7+2I
 CKaxXR1s5ve8VEe6zwSROuLhQeskCuY/2NEJSI4HFfcx//70I3h1iZYdMZr6zgb6Ooqf
 DMkvvDfgG3HFEJh30SCrexNXTR99b/C+jP94gTX2EKPpO7KEccVW7ssuDZSOgdavqq9o
 23x28JYAeq2jiE4RDSLmafLNllB/A6NFEgBtSlwfGnPWo//hn8SsOWm1zVADE3mMGD//
 8IP75FbqZ3Jy5S8myTt6FkgLzmqn5c7KmEeBoLvsBq25zkq5gzWEgAaQCVcA71Kr5YDL
 3dKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqSnnWQLywinnQC5HYLRZgJ+kA4RwTyaghnd0gMlmvjPwh+/x7voE/YTakmurkuQFcT175pJBSIKH5@nongnu.org
X-Gm-Message-State: AOJu0YxsvcQnMT0bKn8ZwRrRmzspFMzgh2QbNec8JUs18dRNFyHh6UKS
 f3S8KZzmd3yiKOisZg8Ej+wptA+0hPpsmltL81S7QmNz5RCHx2S/fCowvO9jDwk=
X-Gm-Gg: ASbGncu7XbMeZCt4uOxbn1DCF6OSpLyzNvVd0XFiaZ+EkK8jgX+rZMdy4NrajD3G4u9
 dwR1GaNnJOfsggB5kq2jGqZANtWkTg6ilml0YcyyNBHkd9J/WAxDHikOQZ7HHqquwHzFulyp2Jx
 I96cV5UK9+CrWZBYPoW7XoO9bVgY6ILtWsIadfTwN183eFIXdOUf/taLEJyzTBgn5xD0kLNkp56
 4e1jJaM1hG9Tk2mQ1heCMixzC9BdN31+uhRb6dvEJIANxOYWl+gRbcv7UpWYYPHDio1Q1+sm1/S
 VS40ACZ9EW0ipXcu9VVBteeiFpMrj6LYFiWeNg9yxLB7ZS5gm0qq6HltaY3lzD0CSD1ZJ3wjM4U
 YL/WN6GQssFFO
X-Google-Smtp-Source: AGHT+IE7ngIsRlx5L3hN66wpGqu3+tbDy7pNvGI1MOyasUFWWTsKqEGeJsTvbrNvVpffBG3tvl0OKw==
X-Received: by 2002:a05:6000:1864:b0:390:f2f1:2a17 with SMTP id
 ffacd0b85a97d-390f2f12bd3mr11302562f8f.53.1741000654333; 
 Mon, 03 Mar 2025 03:17:34 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b6d31sm13949369f8f.42.2025.03.03.03.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 03:17:33 -0800 (PST)
Message-ID: <0256b5de-12f9-4c13-bbff-e7fcf593f542@linaro.org>
Date: Mon, 3 Mar 2025 12:17:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net: ftgmac100: copy eth_hdr for alignment
To: Patrick Venture <venture@google.com>, peter.maydell@linaro.org,
 clg@kaod.org, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au
Cc: jasowang@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250227154253.1653236-1-venture@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250227154253.1653236-1-venture@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Patrick,

On 27/2/25 16:42, Patrick Venture wrote:
> eth_hdr requires 2 byte alignment
> 
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
>   hw/net/ftgmac100.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)


> @@ -1028,6 +1032,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
>   {
>       FTGMAC100State *s = FTGMAC100(qemu_get_nic_opaque(nc));
>       FTGMAC100Desc bd;
> +    struct eth_header eth_hdr = {};
>       uint32_t flags = 0;
>       uint64_t addr;
>       uint32_t crc;
> @@ -1036,7 +1041,11 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
>       uint32_t buf_len;
>       size_t size = len;
>       uint32_t first = FTGMAC100_RXDES0_FRS;
> -    uint16_t proto = be16_to_cpu(PKT_GET_ETH_HDR(buf)->h_proto);

The LD/ST API deals with unaligned fields, would that help?

     uint16_t proto = lduw_be_p(&PKT_GET_ETH_HDR(buf)->h_proto);

> +    uint16_t proto;
> +
> +    memcpy(&eth_hdr, PKT_GET_ETH_HDR(buf),
> +           (sizeof(eth_hdr) > len) ? len : sizeof(eth_hdr));
> +    proto = be16_to_cpu(eth_hdr.h_proto);
>       int max_frame_size = ftgmac100_max_frame_size(s, proto);


