Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B56C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 10:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugKe5-0007GY-2Z; Mon, 28 Jul 2025 05:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKX1-0001In-49
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:52:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKWx-0006NB-RW
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:52:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45629702e52so17476665e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753696346; x=1754301146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VGRceZRZZfYS6UxT20GEWu8565G/iFukOwtRXyDLCc8=;
 b=mLTKo7r79+Mx78oJk9nFrYNj6Ub4R0rJpn/JKcW3i1tLZDYqpbUrTjoMARoAkM83ks
 a6PNbEtqubV/gw9F+DoQzLNPlRvg54e95nmVH9wZIejEZepPsjElniiUNLQ5qd3vRls2
 d/wyTua+jhHJwYwfMfXHhzIz4J1zFJeXM3ea9IWqcDlHWIzdClX5lC/+hcTruc3qEvIR
 VnLmjzX8cN9LfxIheD/6V3nsTHIyUJfLFYNpWh2IdNxvz2UToV9W6L1v6XKhNPWEksJh
 edNh8n+OIW0fqlXLojqKBu7Z4ASg8Uzjr2NQoewILFhGJHzfMeyT1u3CBEac4tL9Zlv5
 lOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753696346; x=1754301146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VGRceZRZZfYS6UxT20GEWu8565G/iFukOwtRXyDLCc8=;
 b=HAtRe7FSi+bmnTgKwtgq5mHpevLPlirGhX0aLDQ+Ey8xF/Mhia+qHR1Q7sxRS0SXiV
 d8XPyDslpaaQnr70pBVlHkYIpxo5s297076L1IqsJujluZNfjc5TETh1v0T/c6fxcQZL
 rxK07Kr4qwkHpcELf7+Rj+wlVQEIfdx8BGS5rXDrSYWuvXacYW/XMbWQo+mEAE7NwcPc
 yk0BeRtQ4vDvIp62brSiNQzqX4bP64/6A4vYxU/A2CDoTZDCtcYewFaGY5tnm1BRw8Jq
 TtqQndofcVx55w3qnrF4lx9qhDZRcZOw6Fq9J0nREn206qSnbVSfAIjc5NigOg9tJdhS
 hKSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOV3Pxc/pBjqxSZascJkKkewFFI34bwzOg/bqcL93WwIBtytr8OQ8fDa6yaapYJtYDBrlF5kwp4PmO@nongnu.org
X-Gm-Message-State: AOJu0YwRsplEOm2X7n/awDlilXp27FguAi1dgN+2vr/Q54ZDqDft8XtE
 48uLyM5TcFLtSTVGhYkSJimkHDtKJj8CkMZuZd8WYhYlNcYjo7mGO/obIU0TZt/o0/Y=
X-Gm-Gg: ASbGncs634x3aKqUkvV6HnWElO4+0TEvYvD/JzcaA0456xx72VpAjDjZ58o0KlZDa+/
 mN86KDNRjbMKN6XHBUZS3lnBpuB+pyRQu1cuPiWxJ0lp+TLGNzgp9G8mY8DK7sXA/lfuxb03V0H
 0gWoCVocDL7yoUaxWBFxUlGlLfN10mJBbAiYXiJLGfR/g9MtaqiUYaO5Fg84OY8e52bcls91CKI
 Y2rTfQMR5/0wGcX7IGo6lhDhMEYf3BuPBRu4vHPqbvQG43jbZTiFdh5vhN1GBjLUaGG9R1zRyLk
 hG2EmEyWRlb4dNsEnkJDuPlJxLe5x12y2wokMc5af0+mRdfmw2MQVTKBMg1vRVSB31tFwebFJJ9
 YjDTfhDDczw0PAQXwwh5+E40IkBhLCH4qr7adS5JRBRpFvRsEIvaUzHaNXynO6YuPzrznodpoo4
 5U
X-Google-Smtp-Source: AGHT+IEwpV6fcS1KmBoFD+JZRgDIQSMt17yWxruRPGKUANU4LTeN7a4rUFKV90c0FaILVUJpJ4sb5A==
X-Received: by 2002:a05:600c:1da8:b0:456:1bca:7faf with SMTP id
 5b1f17b1804b1-4587db2afc2mr64209815e9.16.1753696345804; 
 Mon, 28 Jul 2025 02:52:25 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587ac5816dsm92123285e9.17.2025.07.28.02.52.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 02:52:25 -0700 (PDT)
Message-ID: <37161b92-8619-462f-89e4-24438b282e84@linaro.org>
Date: Mon, 28 Jul 2025 11:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/sm501: fix missing error-report.h
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, qemu-ppc@nongnu.org, marcandre.lureau@redhat.com,
 berrange@redhat.com
References: <20250728090518.963573-1-chigot@adacore.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250728090518.963573-1-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 28/7/25 11:05, Clément Chigot wrote:
> "qemu/error-report.h" was previously implicitly included. This is no
> longer the case following 012842c075520dbe1bd96a2fdcf4e218874ba443.
> 
> However, the issue predates this change as `error-report.h` should have
> been included when the `warn_report` call was introduced.
> 
> Fixes: fa140b9562 ("hw/sm501: allow compiling without PIXMAN")
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/display/sm501.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!

