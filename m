Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54920FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHOp1-0000O5-Lw; Mon, 27 Apr 2026 12:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHOoy-0000MJ-47
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:28:32 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHOov-0005Uj-Gn
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:28:31 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so7789329f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777307307; x=1777912107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lapVIV5YtBRg6C4v29HcHGAO148vT8m0Xk98WzWDokc=;
 b=rJ5W3AS05iXMnNf/Yg0G/0knXp+M/vkhHQmH19VxBhk0CaKC1F5kR+wXiicJbgpxM/
 TBmXCZ4W5okH6gtwFYk+M7cHoO5+rrWJ6Zim0uGPKzVUtnxuceBD7Q0KBjFcGWIFhPeK
 hAMEF9xgQIq3OdOq3be1iu6Cs+Wr9J1nYrOfMn3YD46XSz6fxVkeDNFihtHFSybNS50+
 PL/eYH6xSUT8NQEdZlqqAAKTrjXqqxnm3ivwKtN7iFvC6PzapOhUOnO3odoaXq1P9GgX
 VuhN37pMJMqKQdZYZXfOwox8tZ86YzbmSkmJOMPqjJWwjdR5r4v+ljYPx399jEflqVOo
 /Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777307307; x=1777912107;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lapVIV5YtBRg6C4v29HcHGAO148vT8m0Xk98WzWDokc=;
 b=qT9Ojr9DXf3bGZj2VrfBDmLhxep8OWg01lMQQDgcbdJaj1r1caYuWMzLm0997OTHXO
 VzXWzxKApfgamTC1Ifd0/pGiESqFskF3iKZQ5m0/HKjH02DWv5nk4g9oH3RnNH71HJpr
 jY7+JUsQy6Inv3cdZKcn6VpGYGMyPgKa1NMZAvy9l/OwByewjOBZisx2k1kNKBooPWUA
 HiAe3k+1hmDkJrlskJZPiZiR2/0R2s5vbYnpb7gLAxCYRDrS8RxqzSJKniXKzogTSYPX
 5NnDfjEmrt9sJ4K3Z3goPrXBHrMK6hhvXyxigkZNEqTJiIBSluMWaKzpIyPoOMllYKoW
 Dg7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+blox9slAjOk0rFXuu1oKAO7MvFytBiMEtVtdIKJnje1k/tvfJPfWHV/hZ3FQuEhEoSOUbJRLMLYEf@nongnu.org
X-Gm-Message-State: AOJu0YzDjAHytJmZMsn8XUs23cYcTAGSTx0GLEsnn/qZTc1ouhOQjDS6
 uCZgmoF2OomuLGVKHmb8Rd/ULiorBlNU6FFzJ6nqb7Tc7paDIGL+aa160RZYMdicH4E=
X-Gm-Gg: AeBDieuGj1QPx9TywOREPECpbs3EzrzE86HkS4czd/a9+A2HCGfqNZF4ehg2NwGG49h
 My7xztQfURSHOvNa5s1KbC3yqDeDu6la9nNRPoTfWlLJ9bBa/Ima8BDW4y9Q/3DLdG3gXYAnnes
 VluSqRY9g+GEIVCO4jrLtXE/gyRvZ8uhX208BQ83E1FXrRShOttmW4hL6e1i64TV0gH6jdCBSHO
 xD4KK7sSHdTytnsztlFdwrKIhE7n18b6yZGpSUpvMhB+cXQ4HaWIGEb9+NxCg9X3t7xV7Rgf0AB
 FrZHFWkaPRUUjj65U7ZZFaqwCE7jsUe3JJxYjAAp7Z7ViFoxGG7W9POQ8GPsONXFYyHyUUIluP9
 OGlyWfblaNseeQTM6K2Z8qkxyhvDmCaT7YNpK9sRnF1gZB/BlJ8hjnIxNwM5rs0V0QT42kjWn2k
 q0PABFMbmk7YgTzw66/B4HpdfxNov5+ni29FwfztrGnsYO1Uj55kSz9JtfRdXM5oZTEi3EM4yy0
 hhu
X-Received: by 2002:a05:6000:2dc8:b0:43d:6fce:3ef with SMTP id
 ffacd0b85a97d-43fe3dd2b9cmr68379195f8f.21.1777307307400; 
 Mon, 27 Apr 2026 09:28:27 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1365sm86301467f8f.7.2026.04.27.09.28.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 09:28:26 -0700 (PDT)
Message-ID: <d30a622b-fa95-4ff3-a142-fd2442c8d777@linaro.org>
Date: Mon, 27 Apr 2026 18:28:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/84] fpu: Drop parts_silence_nan
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/4/26 15:38, Richard Henderson wrote:
> Use parts{64,128}_silence_nan at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 12 +++++-------
>   fpu/softfloat-parts.c.inc |  6 +++---
>   2 files changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

