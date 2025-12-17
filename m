Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF37D609D5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfJh-0006uG-Mc; Tue, 16 Dec 2025 19:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfJg-0006tD-2l
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:22:56 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfJe-0005BT-Dl
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:22:55 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0c20ee83dso37059945ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765930973; x=1766535773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0GeIN8L3ngtfeuK2pGocAHhhSy46naAJYZnNGFVsLP4=;
 b=L1470/px1XPaqxNXsc6ukAjXmRwFkHJovnXWOKhxipUmGv0ddfm96FCmFalDky/iqd
 /FCog7z9B/eDfbKjGCC9wpteeaNmJ3MJS9djYAli3Y6++K8htYqkm7V86Kjy0dRV53qm
 mOgfm1TBy4syT59YtjstCOqPsKWWQU/0hy2Z5b+Die89ynovU06vto0fHkSN7k012bVB
 7sHFfQLi5ZmTj0zwmEqJeaG0h632ZbLhTpcGOitIIl9DzBlF8KmWO686EH4+LxgzLTuj
 jiWiugXB6AdUNaCIm1UiTBgn89KbD3+FVSDuxk7kybgsfRqqGjAIPvEAMenBeqmM4mKe
 5sKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765930973; x=1766535773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0GeIN8L3ngtfeuK2pGocAHhhSy46naAJYZnNGFVsLP4=;
 b=GNCtynnz6I+lT92tgQ5Kr76wHq7ry6HsaH9nQhBlh25Nh13iQ+nR8Tv2j3LHLHBO3e
 Fm4SL2m0oYOHw5xETFvxhcJTR/pW5pDTjGKA/DRgS/0IcoT1TDuLjtNG7ATaeFVmD96f
 fa7u7jarynLlWGgFJUeGsD3YcjTfPd06tlSpzSHZ0trM1SX98dGlsiqv+tvmB4Rwjr7E
 M8oeHt+8VlMXpvP8xjDuBvJFpIwYPr8rT2snZefFc3LDKMPM2JZs20wfUOTg7acgBDS3
 d1YuUvNdO3j9qn2VCbwnOXWQTlUWymrMa7ffPP1f5gL8NlUiSfd5q0/Kj7fbZtgHV1Hj
 UN4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhn/SVp0iKqV82A0Agq0dgOqO/3jaCrTTp3boBQ2qLgTJuhdU4CTpkoJjwDzYvujqzt1KBfyIXknUo@nongnu.org
X-Gm-Message-State: AOJu0YyCEbXh8Hf2nPyNyzkCb811qbRRSnI64Mz251t9O16llT1NfztS
 oUt1ub9/k5a6af37XqyxKbaHarv7fE3uKtuCk2RL3uXqtatW7PBSV9aBYe0LiwEzFG3KF/DBOSY
 O91xZkpg0/A==
X-Gm-Gg: AY/fxX4m7N6XkCfioZEQUB0tGpGg4XyhFImEULwH2k6xmZ8vUX3fEkcrhB3D446b1jO
 YZz3eops+CxaK9jZa8LjVfCTGRn5K3sfl2tN0gXmwDSGVvcRy8nx8pSDASuaf/j1dUgY6aKM3qT
 9EtsDLw+vDhm0tDOfhL5/ALvySROqj3Kl4keibrPZnpAhcPrJvH6CuOsmlBolYt001S88QtuwXD
 5urJkXGGRUAOcJSLFQeEuBbcDBNuEf5kBtHD8I67arQ05AYsraIZVQrSaBAus4BYJAN5ZS0r5FS
 y+HgSNL6NIqoFs+T9s/85+5Wq479ntgAx32scAM8mFhK42oiehDBRBVyre1wg4KQ+C8rwifVFH8
 p5I920AnqkvB/Cdx6K+9AvMRThp/8dG/CrSGkDGPWCAYoRGWYSbC4+M/8aDwvtvfu0dTkXIzfQj
 u8IeXl4KjYKwYi/YBfiNCbOxkJlOd4zjKQtFD3ORTd6BDK8fyM5dE3AhJ+OuvzdR4LHw==
X-Google-Smtp-Source: AGHT+IFeYx8KV/NeyzszG8QlXrBR3HxrvPGyC9CACbeQlbEbiUB/daiUGXjTkqW3giq7SH2DWsKxIQ==
X-Received: by 2002:a17:903:1aac:b0:298:5fde:5a93 with SMTP id
 d9443c01a7336-29f23c677edmr155134555ad.32.1765930972691; 
 Tue, 16 Dec 2025 16:22:52 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a0ad49454csm101629295ad.10.2025.12.16.16.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 16:22:52 -0800 (PST)
Message-ID: <a05894f4-4998-4b5d-bcc6-6ee4d2bae5d0@linaro.org>
Date: Tue, 16 Dec 2025 16:22:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] hw/riscv: Filter machine types for
 qemu-system-riscv32/64 binaries
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-3-d24a4048d3aa@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-3-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 12/16/25 3:51 PM, Anton Johansson wrote:
> Register machines able to run in qemu-system-riscv32,
> qemu-system-riscv64, or both.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   hw/riscv/microblaze-v-generic.c | 3 ++-
>   hw/riscv/microchip_pfsoc.c      | 2 ++
>   hw/riscv/opentitan.c            | 2 ++
>   hw/riscv/shakti_c.c             | 2 ++
>   hw/riscv/sifive_e.c             | 2 ++
>   hw/riscv/sifive_u.c             | 2 ++
>   hw/riscv/spike.c                | 2 ++
>   hw/riscv/virt.c                 | 3 +++
>   hw/riscv/xiangshan_kmh.c        | 2 ++
>   9 files changed, 19 insertions(+), 1 deletion(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


