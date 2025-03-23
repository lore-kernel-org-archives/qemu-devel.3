Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5DEC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 21:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twSxS-0008Na-Is; Sun, 23 Mar 2025 17:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twSxR-0008LH-1g
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:34:13 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twSxP-0007TD-8m
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:34:12 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3913cf69784so3054266f8f.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 14:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742765649; x=1743370449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cyDreIrS20UylTmYp99SnLZ5o9SSoeIBiaO03EJImEA=;
 b=ph6RRmkafML91sYzeft/UITsytNZT/xBispLCufX4ur4pbePysBsrd9lQ7t8UvCsQi
 RQ/evYFCIv2nIpjeGNDXTXsgxua0VCW4J6huHdpjJr6mcF6jWhjx4K2/2f6TTz7eKQzg
 jkxeOr5yuBXLqYm76b/9eyeaPXo3AaNU9qxp5w6ogCwWAMzqqFHOn1oLQr76+ppPfTih
 DvnuGg7vWb5P7bLazOuXl53hq7SgNWObPnA4THfofJOvTlI1kHuZRezNjXkUytPLt6cd
 ygdLpr6yR3xIE8FJo9vgbr9yGvVgt2XO2WZbyzQODB361ULYbw/CI1DnwFZaWKWbxhWK
 KMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742765649; x=1743370449;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cyDreIrS20UylTmYp99SnLZ5o9SSoeIBiaO03EJImEA=;
 b=dNVp+calZ4BQ7/OgJJrlojaSqphaDjaixfv/GXXXxS3eNLmByhrYlhetXOgYnKi+eh
 ygs4fL5ki5ZmOoK6OjerNvKDwd4k/jWOJFFjyGpdKLZYe6ubsppqX6LGjEUCA+UZ+lOi
 XN8MO0u4KIPDOaOL69DCQn9GjP2wB7GjNl/L8YJIDgDMVVuzJlk5me4YtAKyuRN4HqS6
 qjfwQd2fqXWT7IPqYYxEmWnrIjO2Hc9YkXdNcwr4OIGw1xmxeEt00n23lMU8JLS0b4CR
 JP0IF6jqDrXmrSs/ZkVhbuIr+Wf/mDowEFMHDX1/qDam7f2uDG7lKAJRt+6jXaC+NSDg
 N1mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVRxZ8B0x2XqcbRfHHOyt0FafHZ7msvZU+SXdnU4K9biLNvvwXi6j1XK5F4Pmfo/PiNu26pRIw9HmC@nongnu.org
X-Gm-Message-State: AOJu0Yyw75GmX391BcynRFKZeojUPe60tZ6qxJ1JLRJWOS30tI6wR9D5
 kfNPhkdlkuhMfyZ22k+zJ5ZCoi3MCW987fxp9VJlz20ar9p+7kAN3AXCQ6AjUw0=
X-Gm-Gg: ASbGnctghvhyGmFDiPVDCvOuuN+BWmoGq+k9Cg8PbB+RXUsa0AvtXZwzdtlAcZoD79j
 jkEnLqoGK9dDfNnl61jP2MGy0YLzyouNLFx7vypXBNYOK6z7WvgHhzGoVVDC1rtEyWX4CaGSYqO
 AWsX+DRQoLaAaIbCVunOzIE7Q2di2qVMxdTDddJLT5rH3eAEPPPEEfwqdVALhzhXt6lSDy+VqHn
 UV+RCIP2MMaEowkKE9lecju9118jlkwN+VWH/j0aPJgkDIf0K8MBo/x65OeW+/QBbr+ZMhsSxWq
 wkh43asKugLgZSpf4J/SLqQtMiQ3ChX/gRmf1COkhYQXWQhQea1cw3gTzLLJaJJze64Oc/1Nf79
 wQWf+YMKcWsTVyMcSAA==
X-Google-Smtp-Source: AGHT+IFbtK9yjds1Wa6UG3wwq7xRKMBEj1izUNe7cksWMh9F8QZQMQtoLvHtdgcKHiZQTZlMw+yNSQ==
X-Received: by 2002:a05:6000:18af:b0:391:888:f534 with SMTP id
 ffacd0b85a97d-3997f902e48mr11100149f8f.20.1742765649461; 
 Sun, 23 Mar 2025 14:34:09 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9956b4sm8757376f8f.7.2025.03.23.14.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 14:34:08 -0700 (PDT)
Message-ID: <d5d44fa8-a747-4a45-ab4d-86908142285e@linaro.org>
Date: Sun, 23 Mar 2025 22:34:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] target/avr: Handle offset_io in helper.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-13-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250323173730.3213964-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23/3/25 18:37, Richard Henderson wrote:
> Prepare for offset_io being non-zero in do_stb.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


