Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E98CE7AA3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smXWo-0006wo-62; Fri, 06 Sep 2024 07:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smXWl-0006m5-C0
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 07:53:24 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smXWj-00077Z-RB
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 07:53:23 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a86910caf9cso545650766b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 04:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725623599; x=1726228399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2tKmW5gOZezfkPf6H5O6iVC54IjBwBT81yUC/ENPlNE=;
 b=OImhnmS0oe/4J6wXj3lN5jnJCiMrJwNyrOfWp3GGlj0oieSIk7VxHmS6JfUclouvSY
 J1kWR9NFElQIp8uhlsfONtxDyCHuU0OYR8+zQa4NhE9j55z0UKeJvnTgVmMKycPlWv7N
 nLpfrHgfPZD1w7L2hTn/SFGh61IBeivDGOZr7uahspdYbMaLDaUVG5ZFjmieX57pf1+S
 pK7UOewhT7cp6nXXyANW4U8S20JyytbWLqRIiKw+6OJUlXfPbjRbNNZqlG4ZxgNrqWiD
 izDH5S5ur7+jao8HlZW/g9dqoFFIzI884a8W72ai7WXK7AhzLeOedUIMEwHmIrEWww3A
 IWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725623599; x=1726228399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2tKmW5gOZezfkPf6H5O6iVC54IjBwBT81yUC/ENPlNE=;
 b=NIPuiHP+MuQ0FSBybEBccTk99SzbC3tT8CJs30hzWkboJksejWVkbh+wAN0P2/xYi7
 5jhW6Y/W/xrDDRkuJkHyxrL6vKtNzN6oigVWNF4XnvrDagyv6gdf8BoVamze/MWO7hiv
 MlsbGGWwrevtx9MKtvy5pDg06Nmg8+UMWpyGFSXCovSgn8Ovt35kQi2q3CRV3o/mZWr4
 cR8fJPXqp+fQyMJsmpNuoaIEd9+1XHym+rOO5EZyzZ8nh4ikF/C6QwByER1rQmazZk16
 hSAUw8pdihEWFkrLWwaGmst++I1UI+sgLNs+CcYp7zCD5CZFeU9vQJ93UL6jYGmgGUgE
 sBRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXak0aFe2rf4vDJp+INty872BBS02KnUkdJGZ0uokptdU1GjIlXKvwwbVPqEGmjpqvKptW9NQc9BHqp@nongnu.org
X-Gm-Message-State: AOJu0Yx36V2jL2EfOAls6x53HdiyzhpT/x3i7gkeunvnueQQojceFlCk
 WkVV9OmfETrL1wNXwQ9p8Y/VfSNLO3SYJDg58gT/p00MXqhCZsQPBd8Sv3cqTIs=
X-Google-Smtp-Source: AGHT+IE8iVE+fE/dhFWJzhaVPKM8pYJ3ffPiHacy4xTRMN861ntlsAJV4c4K/vNApByp13zRenyD1g==
X-Received: by 2002:a17:906:4789:b0:a80:9c1b:554f with SMTP id
 a640c23a62f3a-a8a86442be2mr289007266b.27.1725623599156; 
 Fri, 06 Sep 2024 04:53:19 -0700 (PDT)
Received: from [192.168.55.118] ([80.215.236.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a6236d61csm265884166b.125.2024.09.06.04.53.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 04:53:18 -0700 (PDT)
Message-ID: <0fa93707-d092-4db5-a4a4-f000df881ccd@linaro.org>
Date: Fri, 6 Sep 2024 13:53:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/24] fifo32: add peek function
To: Octavian Purdila <tavip@google.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr,
 alistair@alistair23.me, thuth@redhat.com, jsnow@redhat.com,
 crosa@redhat.com, lvivier@redhat.com
References: <20240827064529.1246786-1-tavip@google.com>
 <20240827064529.1246786-2-tavip@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240827064529.1246786-2-tavip@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Octavian,

On 27/8/24 08:45, Octavian Purdila wrote:
> Add fifo32_peek() that returns the first element from the queue
> without popping it.
> 
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
>   include/qemu/fifo32.h | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/include/qemu/fifo32.h b/include/qemu/fifo32.h
> index 4e9fd1b5ef..77aab488ae 100644
> --- a/include/qemu/fifo32.h
> +++ b/include/qemu/fifo32.h
> @@ -140,6 +140,34 @@ static inline uint32_t fifo32_pop(Fifo32 *fifo)
>       return ret;
>   }
>   
> +/**
> + * fifo32_peek:
> + * @fifo: fifo to peek at
> + *
> + * Returns the value from the FIFO's head without poping it. Behaviour
> + * is undefined if the FIFO is empty. Clients are responsible for
> + * checking for emptiness using fifo32_is_empty().
> + *
> + * Returns: the value from the FIFO's head
> + */
> +
> +static inline uint32_t fifo32_peek(Fifo32 *fifo)

When respinning on top of Mark's Fifo8 work, please un-inline.


