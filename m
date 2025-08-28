Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87967CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOh1-0005GO-Ly; Sat, 30 Aug 2025 12:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkjz-0005fe-8n
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:05:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkjv-0003L3-9p
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:05:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b7d485173so5945665e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756418701; x=1757023501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u4K+eWzK88L/l8rxX7vzJ5F8HAu28QXPtpWi+TLyHio=;
 b=jQB3eShYAk6Ts1CQf8MGPyEBJGweiC16IJHEJmVKyVUasW7308566zVSBN+cXppi+Z
 JtzZ1UiYZCY27GPvcLbYutZ6bo/Lje2wzNsoUuydDpwUI7T4hQ3s/ocHKflMHJohlrOv
 FjxFwEDlR0DdXjfQ/mu1BIh1usJAI8YRm1SkAV4t0u8i882J/+UGWpfvwYzcMK3s7dWG
 +zI0dXFxYKSLPdKXMpAQlSxCxPlp5N3M1edNd9i3sdEKj2gcjqrIw+m7CM9Zit55LmOu
 mh2D01/OfqSwCN/rtde3dbGXG93RAdWUpjDI+kER7NkIWOT8Mll5E0PZBi13krgxDxZW
 lGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756418701; x=1757023501;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u4K+eWzK88L/l8rxX7vzJ5F8HAu28QXPtpWi+TLyHio=;
 b=ock6MI5qBquHvoDxNHRtlYvJxhPKwmFjF3ZL377g2rLt/I0C6AmvudAemGVUXUwSSC
 PLWMY4Y5ogmcAgBEF9rDGDGoKrd3kggpNFZxhlV+6C4Uhdfy12YKYATkoCVotTFJVGJg
 fGzKWJmSY3c03EIkpJqjxSaHf4FZatr08OFo9n6DTGudyO0su1oan8fLGH5i4FWXwjb0
 4fAX3+4SXQr/AKm/zMR4z33CWsF9pEBKO1CPK3a4X6M1EWK6MOUeYAZzWnXht3hL4vuu
 PmrKmFq5WwjdGct/5iAWDdNBOTs3uGLwslGelq7LXJeY0xi/qtxvlBF8MT/pmcgvholI
 MpbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkGvW7HRDejtm/oDXl6VTV28pWt6Y7UwAo5V782aD2wyfRPtmrjaE4Gba9UeYlHdxwoP50C0j7YDHb@nongnu.org
X-Gm-Message-State: AOJu0Yz+s01KTUT7wdGUNl1Elc9kcTDh7eD+UDcIxL2KNIzQSrOlwUI2
 Rd0I5eojI+nHN9XaAlZ4br+0DdtXrXoyQUxanoAooMRFxl4fEUnlHlrHhxhTzGMJWng=
X-Gm-Gg: ASbGncvldIb2gF9kIIGslNIFjx+EF2udFH06TnYdYaiMr+wEwcVD57pokmuH9epySKb
 /kqLa67RG1nBljcCulvadFPYM4LJmZVwinFzf3pWfeXUU2X2VdQz6HTvDmvv/CHQ+XfsCLJvcjv
 W812bt+ARLYWLRMsKA0ZWR9HQMUfTkeLW8p3Jjn8sLYNX2SNQnVs9lcOPOXqooD7gmIFzKhUPDo
 GsyrRNZ85fBP/x3ga08Q1d37QO6TCGOp5bjtKdP54m+3f2f8ltBSyLtAKw+dQbaRa/tX0E66p4a
 njgAZIuKACKVifOeLp+Rx4rCx91JuWEA7UhgjdS7CZ6aSSKMI7TIkEXTu0jZqYtFcA0KXfi5Oce
 HTQtjqQa1wlYzQ0LMJ/AeIZ1tI8fOmNsuF8EAm3PDmDXd8794Sk9bABULl2+rJrbQLg==
X-Google-Smtp-Source: AGHT+IEW8/4xQuWFGgJtc1ykUI19JormtQ244fCXfHvBPu8h+HzsOIGsiBq7ltSgFPUiu6HPXxH2mw==
X-Received: by 2002:a05:600c:4e90:b0:450:d37d:7c with SMTP id
 5b1f17b1804b1-45b517cb8b3mr199084225e9.21.1756418700647; 
 Thu, 28 Aug 2025 15:05:00 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5e5fsm814066f8f.27.2025.08.28.15.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 15:04:59 -0700 (PDT)
Message-ID: <03c4a8d0-6246-418a-b55b-d7047b7844c6@linaro.org>
Date: Fri, 29 Aug 2025 00:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 40/47] hw/arm/xlnx-versal: add versal2 SoC
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
 <20250822151614.187856-41-luc.michel@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250822151614.187856-41-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 22/8/25 17:16, Luc Michel wrote:
> Add the Versal Gen 2 (versal2) version of the Versal SoC family.
> This version embeds up to 8 Cortex-A78AE cores (split into 4 clusters)
> and 10 Cortex-R52 cores (split into 5 clusters). The similarities
> between versal and versal2 in term of architecture allow to reuse the
> VersalMap structure to almost fully describe the implemented parts of
> versal2.
> 
> The versal2 eFuse device differs quite a lot from the versal one and is
> left as future work.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>   include/hw/arm/xlnx-versal.h |  17 ++-
>   hw/arm/xlnx-versal.c         | 207 ++++++++++++++++++++++++++++++++---
>   2 files changed, 209 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

