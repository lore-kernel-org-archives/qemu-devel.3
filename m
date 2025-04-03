Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE14AC3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 17:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0OVE-0002hi-H4; Thu, 03 Apr 2025 13:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OVC-0002d9-5r
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:37:18 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OVA-0000n2-KN
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:37:17 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so1029448b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743701835; x=1744306635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z/SZP1JYTNRzNvenVX+iu8JQFP9ipaPCSD5exP5G678=;
 b=b/fERY7Bgq5DS6uthmaJHc15ewmiu6IM3jxWvlm3ivy9twD4Ut9t6zOoVu2bUo3caw
 t8HDOCPsjp5N4eNeovwFw3eD0PC8jMqhaUhHcBDJq6gsbsCcmrhgGB4UiGbBbtj2Ck2e
 yXFnxOtjk5MDbdDUKmBZydlcfncIzLrmztmahNsI1C6NJMahmGm5xu9u8+G9zyMxHhBo
 axMB+jW3a5+XlYMjKxMM41PV+XXEUtrm8kJhtWfaAkPlKZCaLzFxbJyXYrAmWBZXocti
 zWT4lCeHKjQFO9Sm0LVk83sCIrIdZQy7QfC7PfwLGFVc0oXc4J/DZzaz31Qc9hHWbf6f
 fV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743701835; x=1744306635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/SZP1JYTNRzNvenVX+iu8JQFP9ipaPCSD5exP5G678=;
 b=RSRB6SOlHVgwuNJ4NsdjFkLOVlaVOt/Eza1niHoxYN3oUSLYpfNvu7SF/fYAloYk43
 FofjtzfUWtesa9HxUfsw8fdGwKzednePpCdCERCjcCG/uw8T4GkxvDvjZ9ubIIV+b1dA
 gcxRjVvZE2Gbo3j7oTkKJzCq4qYeYmYP9N7qNab4NByHUem/PuSvSoDF7rDk3qb6XO04
 vwQYCeiE0Ij27P+4gMPeg8TUvZcCNnHSIYQd2wSYqcmkKmZa2RB3P1gaHl55UuemcjNK
 D4MaH6vIsQuPAaHOGH/Y0TdoNwwThshp2wvXqfIMhZQRHiYuISq3DsLj7MLnI4M/WP4N
 NuoQ==
X-Gm-Message-State: AOJu0YwfeubuAhx7m1aOg3O9qF+AGogi3oddKVXtkQD24U6vrJcir01G
 OW37sSyOYoPGCXV9HvehtH11CdCtPNtGT8URWQ2SHc5Qqr/nJhBxxZk7333/TBfrPl/uqY7PgJs
 9
X-Gm-Gg: ASbGncsNwA3ICfUZItOqTQADmLBIwFxHRo8a74XNs3N+UdjBjVFzO2U3UYXixHXoZTS
 9su8WxwVjq3u24H7dwbF4rtPWQmImCnsRlJVYSsQ9H1FLmB4A9FCy+rjXvZ81p4RAs91eNv2gys
 Py1lpypiL14KMz0Wcki2tiseEnNpnkYw2vpDDpWaruDIenuR+X6Fgxtf11HlhYI05ME81nxdZPl
 gF6WwU+DPiGfkpD/xnbHuJ0/LE69u+mpUNOEqOgCMvAN93fnMtPV4yMBIaILtpTdG2CCawo4kje
 cuFiMLM3V/rQ9GukTlziIW6g0kPZcP6lRcWHMwt9ASTO1LYdv7w2Z7g4NGVgn8ymqoThasA+4i3
 F+m0+D3brsbkWzb+QHVM=
X-Google-Smtp-Source: AGHT+IEFqRRkKjlIMpJq6y+Sa1GaonA72jDtLhGPSUP0uZg1AVav54sK3UC8OgWJ7k4UbtPxFOvsag==
X-Received: by 2002:a05:6a00:124d:b0:736:491b:536d with SMTP id
 d2e1a72fcca58-739e4b73951mr560158b3a.20.1743701834974; 
 Thu, 03 Apr 2025 10:37:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0deddfsm1780416b3a.162.2025.04.03.10.37.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 10:37:14 -0700 (PDT)
Message-ID: <12f30c39-53b0-4ca3-a823-48412ca380b8@linaro.org>
Date: Thu, 3 Apr 2025 10:37:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0? v2 07/14] hw/intc/gicv3_its: Do not check
 its_class_name() for NULL
To: qemu-devel@nongnu.org
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403151829.44858-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/3/25 08:18, Philippe Mathieu-Daudé wrote:
> Since commit cc5e719e2c8 ("kvm: require KVM_CAP_SIGNAL_MSI"),
> its_class_name() single implementation doesn't return NULL
> anymore. Update the prototype docstring, and remove the
> pointless checks.
> 
> Reported-by: Gustavo Romero<gustavo.romero@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/intc/arm_gicv3_its_common.h | 2 +-
>   hw/arm/virt-acpi-build.c               | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

