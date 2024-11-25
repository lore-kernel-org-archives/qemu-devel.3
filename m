Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FBED58D4C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZkO-0003VL-QN; Mon, 25 Nov 2024 09:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFZkJ-00037u-AL
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:07:23 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFZkH-0006nz-MP
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:07:23 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ffc1009a06so14694901fa.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732543640; x=1733148440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L0447YFcBRMDlI9ba9HXBwkyCRxekR5l41XUqVGmghw=;
 b=vlR5i1T5phyZKjz+wg1SjKYOZe9HfOX9lyxXrbsKY2s0jlikIi6iYlUV0YEHULtkLR
 1l0AHB9izkyvSEUwPcUQSggomu0it7dYtbeDJdsoKDGtwQxUQGrVlH+wLJsuOG1IzW+u
 mbXwvb3ljMb4/MMRitFnzvXxgAD3UiaogGaA/zAOjttzCL5x9mv0Sm3K1yynMPTdG6cc
 gUkl4DHdcwTgRlKBIrQAXmEz/cwaHQEngajHt6GFCZ1SqGhsZNtsoCpwS+CEzCxVWF/7
 iV5k04BzcxDnDyxLaNbN5qSaj3Ul6jU5T1yJLE+FX0UNNaBQqQKISjla2l8TjHsSfZsg
 lQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732543640; x=1733148440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L0447YFcBRMDlI9ba9HXBwkyCRxekR5l41XUqVGmghw=;
 b=M1A1gNptNDIUMYyeOORYE1UsNIXm4Zl06GSNKhJeQ4Xo/GBV4fqJ1GGVB3ggKSgg+i
 UDGzi00kZ4E8SxSBvk/q5y30hCo+kPmR9TnidgupGNiErMINg1xM6sDJ8d8x6hl8xhGM
 TpvKkJyhDy8K1IDR25iSaVvSZC8EbtnwDpWjONJhikO20GM41gw14cE/uyjYszitq/48
 A5OkYI5weYDT7Df9apA9EsEjN5bfMZ5TP9KWo8eR5ZyCVO9L9zdheNU/g0uWyXYLHny0
 pas+vJF2+yWG59aJw3rYbrI2dGwfNhLZ6x/orRKiTusnM/L5Jz17yiGEduWa9bsIC1AG
 NmDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMV8WDgBcTekFoZKJg3SXbJnDleny9593cT5y8DuX3FUb9S9kYU0rMtOcn+yY5mvXnYPBfL5pfx9ar@nongnu.org
X-Gm-Message-State: AOJu0YzFVGwJHkINGQGkJPj5x/j2P+aUhAVPnpQhpO7Fky2GlkeTKm75
 XM6InW8NPjsWAHzFeyIzd4rjAM4QeHu7kzuFC8fRpMjI8CCPFyVvB9qia+ukPy4=
X-Gm-Gg: ASbGncsatfUc+QkZgC55dK0suSqs2JFym61hHPPt+q18qh1KUCJ5h+w22IUeLi6bvl0
 S1Lk1WPFLI+EMBwGZM4m9WRU++zqFT6DxC9jDFSbH7SgU6EEyBRmX9aQd3dsiruN4PtojFk3IO6
 oRRnXUIt5wQuvLEXrNPPWpYDmWNb+ScaACJIXS2nfH45/kB0mukyvAPtZw9/XT2JpmmVfdqvi5H
 Izd4W8fVAdfhOUEZCVzJJanJAb2hYFo3d1LXPfe4gAFeasOv5MYLbF+fb3r0Zg/hw==
X-Google-Smtp-Source: AGHT+IFmlEXEEgK6XrULabuQbbr71LFbxg3DNrJfOch2N0c+PrBaFnM4zdcyIq9gWO9OdWAe9pl+mA==
X-Received: by 2002:a2e:a5c9:0:b0:2fa:fcf0:7c2a with SMTP id
 38308e7fff4ca-2ffa712e526mr85449331fa.24.1732543639749; 
 Mon, 25 Nov 2024 06:07:19 -0800 (PST)
Received: from [192.168.69.146] ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349c89a113sm65186785e9.21.2024.11.25.06.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 06:07:19 -0800 (PST)
Message-ID: <39533af1-57c0-4e6b-90f0-049cca884c1f@linaro.org>
Date: Mon, 25 Nov 2024 15:07:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci.d/cirrus: Remove the wrong CPU and RAM
 settings from the macOS job
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241125124342.187594-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241125124342.187594-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

On 25/11/24 13:43, Thomas Huth wrote:
> The macOS runner ignores them and always uses 4 CPUs and 12 GiB of
> RAM, so remove our setting to avoid wrong expecatations.

"expectations"

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .gitlab-ci.d/cirrus.yml | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


