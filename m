Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C83C2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYbq-0007ss-MQ; Sun, 04 Jan 2026 19:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYbo-0007rj-G9
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:38:08 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYbm-0000rc-UD
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:38:08 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a110548cdeso181794075ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767573485; x=1768178285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zNVkkkA9MGF/ped4nZC8MUqNrM6qfumeg1TW8aUntjs=;
 b=KVqvOXgkzHf70/pf2A5i8wyZ7VOXTY2jQcI842zRc4k/CfYzE7ukSFHTF/6cDMmu04
 +4PAa9aoW8MAFW+wJM/8c0Qe/zP2N+VF3Jo3ttg5L77TBe0qLvkLN2pSU/RJu5QobveS
 SJhaClsYP8eKACp9Le9Hp3pSx4jpFG6p+blNuMZsijhS+sEkEUXHK9gzCo+DqL8l4TME
 YV4qLQfMkJ8dNJI4iFf3fB0eWDzSLqS93YtIqX9F7pP2FiMwR2kqaatb+q3x+dnxGVkY
 oetXPpwWFUJ++Vj/i0w4XsmRZf+WaIL8SNzTuGX78j/YuL12eFgA1bDTmjl6n/WSuktB
 9Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767573485; x=1768178285;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zNVkkkA9MGF/ped4nZC8MUqNrM6qfumeg1TW8aUntjs=;
 b=tx5zoGpKiO9l/kacvMMurbAuwYkYs7zuFu8Zp19ose0DM+zV7PXFeUxy0sK/hK9lGG
 MJ/NOaeTihh6Aj4DRKztE2Qqi9MF321w/6CnWwQa5Bdhk8dVMAd9Mtt8W+yuK2N5YdTu
 4KTQPCi1aqxsrYLdqFp5qX0Y6bUM3IEOGbi6fSYgz6nTIp59KxLG+n8uqGiXAxA7lVFL
 CXrgyPh0dCLU0OuYqrvCKMClGWo928sFloGYsECywreRj/PL4oWB04+aViGd5/XzRRak
 PkSqFHlrdWa9IxMrQI/ojJWw5Q8zqTQbG6e7fFhXmdM+xmQM20FRx/6zGR0Kxgw3hPVr
 vi3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8NpffKZAXiD9NJv9N8m6l22skrzRcA056LzTDjvNBgMc6YXS+r22K8KK36IyXDLZii18qqwUFuTAP@nongnu.org
X-Gm-Message-State: AOJu0YxaBi/ZZeiToaeXngsK1oHFbXVAyCdSDCKg5+/BDCM3WpZSA3Pe
 SPGKztvKkusPf+BjDsdtAQOu3Mt0yi2Get6buyHU2Fpp+4AKJQSa2Fwt9QdyvXbBv4w=
X-Gm-Gg: AY/fxX4JzyCrDeM+jirPbcwv99ilbMtmL83LnT+56hdnekwKYEw6bMM6MezmCUiGCdb
 rn1y8LnnTVAuWM+AS1H4IFkqMUtxM8cv40686YsdqVt7pnTJxGVeOUZv0a51G+mR8gNxOZ9HLoE
 VPgLnweGrjk5FXByKS0hrVpw8FLXpJ1Az4s068EJvLVcGI1yvzWv+s0Yk2UG4dYUUTKT19uqMSP
 618XxokrafkPckOLgf8ZkLTpJEU7KhsszvROPx3Q44YJ+2/rhviMSmAARZ+k92uf3QlFlesta4v
 xf/xO/tktn4uyZiTmaNZuojqWvQ/tgiwmj+vOwmayK2phAiFhZM+GR1QSrykBIjcMSP9QmCdnO2
 BDxKoa9AQs0cIC7eclq1t0/eoA3zEUJoqicaH/ReLAmyWndxC71UBDlM+NyRKJ76G/orfltKUb5
 TGtrLqcSyTY4q5M15urOkYhm7XmyiBmH855oGMtCK5
X-Google-Smtp-Source: AGHT+IGF03tT4TqGRlX4/6lCfvJC7N3Lu5nHQ65cb0wsNBtW2HLinr/S1tbNwIfizvysUlJ5o4xnqQ==
X-Received: by 2002:a17:903:228b:b0:2a1:3895:e0d8 with SMTP id
 d9443c01a7336-2a2f2a5934dmr376023065ad.60.1767573485354; 
 Sun, 04 Jan 2026 16:38:05 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d4d88asm425051815ad.48.2026.01.04.16.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:38:04 -0800 (PST)
Message-ID: <4c980190-839b-49af-bcaa-4becefc300e3@linaro.org>
Date: Mon, 5 Jan 2026 11:37:56 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] configs/targets: Forbid SPARC to use legacy native
 endianness APIs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224162642.90857-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 12/25/25 03:26, Philippe Mathieu-Daudé wrote:
> All SPARC-related binaries are buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   configs/targets/sparc-linux-user.mak       | 1 +
>   configs/targets/sparc-softmmu.mak          | 1 +
>   configs/targets/sparc32plus-linux-user.mak | 1 +
>   configs/targets/sparc64-linux-user.mak     | 1 +
>   configs/targets/sparc64-softmmu.mak        | 1 +
>   5 files changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

