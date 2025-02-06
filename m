Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B94C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg8t1-00045p-Qe; Thu, 06 Feb 2025 15:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg8sx-00044c-7T
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:54:07 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg8su-0005qp-GN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:54:05 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21670dce0a7so33072865ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738875243; x=1739480043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hXyOI1gSI2MGWHadCADiK6fWARlPhToSyKEMYP0zr0o=;
 b=zTrwZVcwHK5DSEqW0ZYnWoMXymVyqZHraFGd2J0D9b9gf0/pCicZStUeLoYIFAhhSl
 ss+fAFH0MZQeaedYTgaAy0oRWZHL9jGBMr6EPT4KOz0oLXVhz6thPdeBu1A2kSg8lmhX
 arIYEJyI6+ddy80J/Nlq53y4F0sr2DUcdR6fEa0P0s/KGQrvjZEm7BgWdWhS932Ui7iC
 EBno9ctSpxXx2qj9r2otAuO1N9ELD4jSgSx+HnTDytpI/h8QeXAb5BxSrfaRb1qgL99c
 PoNZu05nZF5UAFm3q5xBT60nmvoV1OjXNl/Q3xusUqgIH+Bj+r6XLo3VYDYQEkgD4LN0
 lQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738875243; x=1739480043;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hXyOI1gSI2MGWHadCADiK6fWARlPhToSyKEMYP0zr0o=;
 b=fxJ0cGaQESFyM1EKUnUBHDLm2XvLwDUpgWSt4YsQXxTS52aZvKAEdlE2cVMYG+ya9J
 s20Av6xr9LI/Gh33exus/cIzJGVzZ4dMxE4dQKrb/WXu4xIQepaDU0AD81pepuoA/DEV
 I5uZIKU1qUCWxhm1Yzf3+cBUg6rOC7vhGOcxwGMlEInxni2gct6TeDDoc2zAQyMEStGO
 eY0tQGUf/Tb32Tm45NmK8vJtuiScKKQ3LiZrZbxBqB50LQ3eNa4gf6niBuffqjYHDubn
 q5WuCRr+oXZ5rcnQkxYqzyg9Z5SI2znjDLroFwgmp8n10Z/+8BkqdCM6Cs+9itA0oKaF
 hDTw==
X-Gm-Message-State: AOJu0YwKomiGigHnPhuFldnCqkrNbuzT88Xv49kFL0JQyW+622mnzjA0
 rBYzqpUa2ECfi+VEmlfIxo3qXAV4Zzk+oSCV1JEqVqLYOk7Z3iUCWEJCe2z1Rt6APcCTBZZ5lvZ
 1
X-Gm-Gg: ASbGnctbk9z/TEeVCmlWEu2we5nJCnnBFkcdqAF4pF1y+5qUxxj5k9+4Ta0KNLHGdQh
 SxmX8ovTnLWjyxJ6p2shd9cdDAYnW+XDobEDT++Au68QG5095q8JMohlikozyWwhhWNJo6ykMfx
 g23PIl8LUMdTPMrUnE8JFqVJKCgG5S9k31Qk4qGDG9zrl8PYhYUmjAJgCJhvXxerWL5OcL09jmG
 3DEh6ITtNaV048KT2uMW+4mogd+h/L9rX9OZlzzNrj4lPE/hLQ6n/lZaFjQ4hwvNITnX5IR1AhG
 Xt76nuYN6AZoe1soRE9zeGQDM5ZD2Veg2hgHo5i/1lwPh1SqMKh3Ugg=
X-Google-Smtp-Source: AGHT+IEPAjiIsUQJNZFX8ImUk+/vGv2GTcp5C/xvZoRTqM+iHX+5Vv6dRngA0F1sJbPjOu/02p2ljw==
X-Received: by 2002:a05:6a20:394c:b0:1db:ff9d:1560 with SMTP id
 adf61e73a8af0-1ee03a3d25amr1487870637.18.1738875242913; 
 Thu, 06 Feb 2025 12:54:02 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c161d4sm1760658b3a.140.2025.02.06.12.54.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 12:54:02 -0800 (PST)
Message-ID: <22bf0ed3-a2e3-427f-983b-da31f760d473@linaro.org>
Date: Thu, 6 Feb 2025 12:54:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] MAINTAINERS: Unify Alistair's professional email
 address
To: qemu-devel@nongnu.org
References: <20250206181827.41557-1-philmd@linaro.org>
 <20250206181827.41557-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250206181827.41557-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/6/25 10:18, Philippe Mathieu-Daudé wrote:
> -M: Alistair Francis<alistair.francis@wdc.com>
> +M: alistair.francis<alistair.francis@wdc.com>

Well this isn't right.


r~

