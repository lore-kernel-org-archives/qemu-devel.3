Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050D2C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQ3H-0001k6-1r; Tue, 03 Jun 2025 07:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMQ2K-0001SE-B9
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:42:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMQ2F-0007TV-85
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:42:31 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so8594565e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748950944; x=1749555744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UmoZ9fNr4AvoK6wUUDPseKtghIt3dxe4tMZYEV9zbxo=;
 b=dGz7SybGOP00kwWQIEgrm4vu+DebRJKONoTuLY7b2DSFkWh52CEBJI1rqZVwi/u0yh
 E/57LvsCizTa+JiHf8mIttRqVYWEjpKoNVERndSTPuVWBb4uscDAPtRx8DItg5UoMaQT
 M6qf365XlIUxDw1tkmJszeOez2dNJi7B+oKHxUSELnP7pgvLJxFaZD86HaZLqSYCsPeJ
 XDQU+J9Q8NzhHOPyD3naugHXIoha/xGem4VB6ay8mrEm5znxD8i9b+ElB6f3shaQ+GVw
 5YaAg9pZo+jBgQnt7ohI5x2P3xuQcbQOgeYRyO4qJ4BxE5G2UyvIYliw36DgNKhaFp2v
 0wXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748950944; x=1749555744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UmoZ9fNr4AvoK6wUUDPseKtghIt3dxe4tMZYEV9zbxo=;
 b=lRtaZILKwu1ICkliAFeNOZT+eM19+LvzVmSy0iXJSH4BGIBMxeaMEERzxWzqZb8pk5
 bSGkRFJEdx/JQK5Wn+YkxOXcM2Fw66Fl95LYirGFIxRD9W2i42enclrZ5uTKXauoRwHj
 PEnbCzKHRkv6WlisTRXULJhLhSCFahT02lAj9TLWq78vOOaRha3r/kgCcwF+c5ziuovE
 iL2jd9c8sgSiQ5x59gDlHXbGayc1aI5GzeXxAxsNVzSdT9hrPpTSOCK9q3+EVuV9rPd/
 rNFvDhxomsaVg1qH0q6wDoTC1TWEqx5waArgOBeOFgNnEidzyuaJCznLJzRduI3SJqer
 Ksaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWCMM3AIzlL5qM/8rYjEbFG1/4QE58S/NY6Uwg1JPObIH4QP0OIJrauYRowag+Cap08qoQVIsF+xWy@nongnu.org
X-Gm-Message-State: AOJu0YwOja8aMBc1mAmoU2MIOTCrIq3wSKxn/yzt6wmbiSaKPI5KyqoZ
 0ZDe1OV9EZFGnRtZg4+6eN3TvLzL7V0yDOOlQEQ/59XtJiKT1uR4/H7RNbXUG8ag4j4=
X-Gm-Gg: ASbGncuFn6+QW4LzcPYZ/apoTrlYJ73UqW73hOq/h5Y+BdMp+JVRbjaSzhMVECLd9q3
 /OZeLV5cR+527t/LCcZsGE3wt519Nw1794dbe5OMzAi/bsgVvT3DB3VROdDoei6yNjho8AmZjm6
 rtbdcRkEQ0GsyyphdyGSNEalzsnzn8q3R1OS3NDnMkhXV2APQBmCHQbN7ipWgmYePJ5F9Nploo5
 OF/047CLO1VJy1KvPlOWxMVB1pLQnivzutHO6z5PD+wUG1mhEnJrR5MyMEaTfZS8qS9XmF5SW2C
 ZyVaedbD+LXo4s+9iV5S+fgUTYyuzN1AsrUq9WLnhe9WKbyMfTIFlC/q+9+CGQsHyGP5vHsoleQ
 ahB7j00IDP5pd87iTvKLNuPPE
X-Google-Smtp-Source: AGHT+IEvjNen+rTWoar4afd5KSaAzOksLl/XYjWSifBHPlQ8SVlqKEaA2SfPpjc0m43lgzDd7xg/vg==
X-Received: by 2002:a05:600c:19d0:b0:439:5f04:4f8d with SMTP id
 5b1f17b1804b1-451e67b0480mr21077395e9.12.1748950943851; 
 Tue, 03 Jun 2025 04:42:23 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6ca46sm18384506f8f.31.2025.06.03.04.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:42:23 -0700 (PDT)
Message-ID: <1555ec0c-084a-45c1-8a24-f0555a3067df@linaro.org>
Date: Tue, 3 Jun 2025 13:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] hw/pci-host/raven: Use DEFINE_TYPES macro
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1746374076.git.balaton@eik.bme.hu>
 <30b02e0496b76d640f222cfac492d73dbcc2b099.1746374076.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <30b02e0496b76d640f222cfac492d73dbcc2b099.1746374076.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 4/5/25 18:01, BALATON Zoltan wrote:
> Convert to using DEFINE_TYPES macro and move raven_pcihost_class_init
> so methods of each object are grouped together.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 57 +++++++++++++++++++++------------------------
>   1 file changed, 26 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


