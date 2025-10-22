Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F156CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBe50-0001iX-9k; Wed, 22 Oct 2025 15:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBe4j-0001bM-FE
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:00:46 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBe4h-00066f-RF
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:00:45 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-784807fa38dso66326607b3.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761159642; x=1761764442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xNtQODdDeKe2RwUnE/y4c0CBppMhFRfl2cE43QP9v1g=;
 b=Gpk4WkGFDE+Fo/LkEpv0na76AzQtjGkOC4YfwJaJq/GBF5rbKllywjUwVpYmqSRThI
 hDbt5sDLMRchyeET/EDvxkEgA+hdDxzXxXVbQNyCbXgNdo9kn70tOLWAbIG+UzAoQzgO
 T5rdRWFEfJm6+Gd1eCQfv2UhOKIcZLkG4vr2c0kRVcSY3x15KMdW4DS8vUwFQ9tjUV+x
 3xVBuF4S1kw6/A2GQmos5RPVh3dtc55bRAWfwR8n4ewHuCbNMzaOzMKOGULdz1bc+tmB
 RNNIdxHUUV55SAlqLxpXCuBoi/ml+KKw/7cB9/NCr5XNqMS4Jru7B6mZPDbtBqXxtRVh
 AcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761159642; x=1761764442;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xNtQODdDeKe2RwUnE/y4c0CBppMhFRfl2cE43QP9v1g=;
 b=WdQWWoVgEQXmVYxvMnStzquf0p1QqU8sOdNBxUOfR7ZtH+s3yUC5m4Z8PgR4GeI5Yw
 eTpbga5sZnX+re3LWPFhD15BhWNtt2SYH540UC+0vcJwaj25+ko0ZvHM//egBOM0SU8Y
 Z/1xawfCqnI+9Ud90JnqU7htwx08F1CO6hy3hpg4gy4uTTLHlKLaqxJjPonDn1aVmR5N
 8Z/lNj1Qkwdn2H9o9WNvyTkDEVpXN72Yvd8PmcpjZp6u/B2RMxoEvDYrPrn0G8Qq8A5j
 AGZHU24nBDTbcVLuldH2zVDoKf52K1eH6nQbyKvUeDfV9x0nH7VEX4FKsOanaPKj3gI9
 NHMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvxad42V3uCh7pAiKt/pRKbMxP4qDC7rUsvqCN6QLmikMz3zMXSBHQvjWvyuQcpW9eJcbxeoOFOenq@nongnu.org
X-Gm-Message-State: AOJu0YxyytWk1TxXN+b+SoLFgUftvaCdxlJZFph3mbpkSIVLfRbrg6qP
 DzsNMmuoASYSORw0K1lJvBS70IJwSEWERutx0LtxvVr+umd4OzUmN//bhJDRXuZtI58=
X-Gm-Gg: ASbGncsq6EiecpaLNsTMBrLUZ+Doa0HND7YKcCvrXAuwbAlGl5RE6ztZ27DLMEcUrd9
 O/M0/yZYaH6qkr9seGKboGpRcMwyh1CYJJYUqFwwmU4cWUl8iMeaDaqjYeECfyRzZwWmkC9K/28
 AGj5qyOY4vk7w538CCW9VK16sBnsqkXY6hIQEUJIlxreyoErBBXlQovNq+MhpjNVkhpRZE5eSFz
 wnHksDnVBJhFlR2ZBRDVAZPr6Tt7mOoLfYBO34qujMsNjghEKXRWER2PmOZi47KRo5o+WnXwu04
 ML1jCmBuLgUVUo/zZGRwGBdG2esxmbbXls94X0ti17NRIFfN200YUPuKMKtzkLylQcVan3Fac3s
 NNh8GrWdP9lv9Xi+5UZESy+ZJqBxydBkoHfu8pvJsRNaOBJGGRxMJ7sax0lsJt4TzOGWZsEwpND
 fcQFDxc2uxcSCjKTego7cctkc8E6BLJC0HDp1SdwvZ3jkNiHCwxdef7NaNZVOCADdX3DA49MM=
X-Google-Smtp-Source: AGHT+IFb11/9qSj3V54bLxAyxEZ1F23hfaAVA2M8romJN7f78DRLtGsSPRK19RX3HDwIDWwOrtD4hA==
X-Received: by 2002:a05:690c:608a:b0:785:c770:fd97 with SMTP id
 00721157ae682-785c7710004mr18956107b3.69.1761159642337; 
 Wed, 22 Oct 2025 12:00:42 -0700 (PDT)
Received: from ?IPV6:2607:fb90:5ec2:421a:7b72:4f29:1f36:27f3?
 ([2607:fb90:5ec2:421a:7b72:4f29:1f36:27f3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-785cd6c8a46sm89647b3.42.2025.10.22.12.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 12:00:41 -0700 (PDT)
Message-ID: <a6755f4f-1d65-488f-8f02-a3851c058d17@linaro.org>
Date: Wed, 22 Oct 2025 14:00:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] hw/hppa: Require SeaBIOS version 19 for 715 machine
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
References: <20251017200653.23337-1-deller@kernel.org>
 <20251017200653.23337-10-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017200653.23337-10-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112d.google.com
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

On 10/17/25 15:06, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Require at least SeaBIOS version 19 before adding the 715 machine.  This is
> required, because the machine inventory of the 715 is provided by the SeaBIOS
> firmware.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   hw/hppa/machine.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

