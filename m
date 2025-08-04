Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59860C87FD1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 21:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj34F-0006kV-1h; Mon, 04 Aug 2025 17:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj34B-0006fl-EP
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:50:00 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj349-00079U-TT
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:49:59 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76bdea88e12so2981852b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754344196; x=1754948996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KgdWfMbL4V54JLQh0HqVHAH//hZXfiEzUYE2kxQsGVY=;
 b=VATRkj8VHUUct4xPP4YZIPeE5tC3EWSnGwJeZGHSCad4bGcZv9rgW7BoyPoHO1Chd4
 NeHY1jZuUE6TgXavKNd3nsHSjUa2SEw7SxvR9FM8lx+8A/3LLWdkOGlGYVWvekgQEouH
 3BndZhlXmEgqdlWwisxyL4ibf5QM6zZzCoBs9vCz0Cv3aRCeXcICU04aqdwGrRXzYAZA
 Uc9vUb9jA8qTHOSoY8m5BqbfjP1criRmSmEiF1vYPV5vMYYFEHpnwes3UAclUn/+XKlG
 q2QtptMoLdGsIsdMOQ3wGe6DQ2ktoyBhyFkNTbiSUlsz/hBOMooqdcAGFBjWGGVaw4VA
 4qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344196; x=1754948996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KgdWfMbL4V54JLQh0HqVHAH//hZXfiEzUYE2kxQsGVY=;
 b=SUyti2+qV35EX3xzlTxTlCsSUidXnFQxcxALy06N3f1oadQnD2QP8LjG2FoWzlAbcO
 nO4H8LZnhIwMPWkUpox0yQj2n2SH7XlvpAkW+fJfmZlN/2st/+FtFklZQ0Anb+qBzsmQ
 euBF+rBjJProQij3Fn0NKSG0dgSAMY19uCsOim7wUhBW3DNfbMy8TW0kSWJryK28jHzT
 CI8Ml37q2eKcf7j2B80bcoSa6QcP8ub2z5jEs8PiOXen37Zu5t7Z3H5tGeVUZGkFNIMu
 OpRcLhJMzPUFX+f9iIMTjbUzq9Pc96BXfaQVCVWupdaPTfN4tSxmhNFUBTe8r8/z3Mwa
 LaNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkRIgeshxihDp/Z38wIJr+N8t76CcfAhaFE6tVvz/lTrFPTG2AgmHPbFeTs3idGWAXiVHJScwc9RCN@nongnu.org
X-Gm-Message-State: AOJu0Yydc3SaDXON5d1wfpBv/KRHgfE5Yk1xl9zNAUzav5lq+xrRJPUM
 6mlIVwel7qseKeAhtwOIjUaiK7DDs8MTnHz1eVPCYEtKfM8SR5peXUHUPlhGuGTA1Qo=
X-Gm-Gg: ASbGncu+pFMIIrdey8Vl7qh3iCIaT3sWcp3rst6e9kiY0AbeYBvtAGZFyM10+zUABlU
 kF5YeMa49G0SlLO4MTC/U7d3auZTXO+kudDr3Wb8rcBCmiCR2nzxGhWkZ5qrOZoBkpbzSslioDa
 C60roLhCnS8KKkVroDqXcGgBa9ZohMwCKOdWXENJ2+O405Nl1+F3uydHKefeo5iJ2OzQnpNDJRw
 KEuykK2IjlFDijBw3DhQcLBc60JrAU027VtRmwvboZNLeXQapMMqwyfB8E1xK3l+TjpgCswpO6Z
 jaNCUR0mfYo2ZrM1si13SmIyDqlLU15jrcb2ebJJ0wDbXhvskkJuTYUuSpS8DencSokkaQRbZoT
 IenCRdz7wUZaQc/7fFT0NrVzEuJvmstjTCDk=
X-Google-Smtp-Source: AGHT+IEGG04X8Kac2f8KNJk4BDQPadRgzpgy24E+2juoxXQaNjymo4LJ4oeHn/6hhcvA+3SvD0kNyQ==
X-Received: by 2002:a05:6a20:9183:b0:23f:f934:19b9 with SMTP id
 adf61e73a8af0-23ff9341e86mr13525426637.14.1754344196544; 
 Mon, 04 Aug 2025 14:49:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f474sm11233819b3a.4.2025.08.04.14.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 14:49:55 -0700 (PDT)
Message-ID: <9bda719a-9169-4f7f-8218-c65bd7c53e34@linaro.org>
Date: Mon, 4 Aug 2025 14:49:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/17] whpx: interrupt controller support
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-9-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250804142326.72947-9-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt.c                      |   3 +
>   hw/intc/arm_gicv3_common.c         |   3 +
>   hw/intc/arm_gicv3_whpx.c           | 261 +++++++++++++++++++++++++++++
>   hw/intc/meson.build                |   1 +
>   include/hw/intc/arm_gicv3_common.h |   3 +
>   5 files changed, 271 insertions(+)
>   create mode 100644 hw/intc/arm_gicv3_whpx.c

It would definitely needs another pair of eyes, which is more familiar 
with GIC topic, but patch looks good to me.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

