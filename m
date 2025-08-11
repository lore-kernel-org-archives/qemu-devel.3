Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E96C88CB9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 13:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulSix-00087i-2g; Mon, 11 Aug 2025 09:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulSia-0007qi-PX
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:37:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulSiS-0005oE-Jd
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:37:37 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-459ddada9b1so41202055e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 06:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754919446; x=1755524246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=61UVH2KKk0CmY/yPgbpLG+mnzUg3aawQUaHxiU15sXw=;
 b=XVSCviJlu/h5MhYnJ/XYSTtD25cSytInMScLix1KHs+6paYNPFSVUIAhNaCFQgSYjF
 FZrVcjcGcuG4pdUrMjntRXbRXjAHCT8wpy9gZbWPgpmGwuT5hiuaf2GHqdGOlXAsAfgJ
 r3y5s5BWf5Oa8ZNiZVKfed6A/CaMrcpAc7ZUSIBRVh4kALyjyr8L2pM6fPd+Jea9UpWj
 luo5nqUybOehu0LwiIwQXv4pcoL/Dtc4OaZjspSjU25vY8SDRjOosQDX2nQ5LNKVDcoc
 fqe5xklNzgE8fqGclXyfM02IzoQw+PqSHgrDx+bt/4MhZOkWf5UsL77riLX9UVtDqeBY
 UdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754919446; x=1755524246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=61UVH2KKk0CmY/yPgbpLG+mnzUg3aawQUaHxiU15sXw=;
 b=AyriNtU+e0tm18hg40j7qwFhe1qmO2CUdbXNm9NWnruLGrw+AClslUi1htA7Bl1X6h
 i5BvtEJ5B87r6MGJkfIoAMhcdi+B+trRfTb7mFRoqbtSh+B+JVOC/2Dv/3TlROqcT0+J
 jFeRq6ur17pnpDTB4zrl2LXBPFe13XKfoN81NpTicTSDLdQlvsFpoWKjZ7WiVlu3q3ko
 RziFLbCv1vgPQFXOutN/qSUZNLHuRtycTMPoE2hoiGOV8L0UFWzUvFravGj2EwZW0ab4
 OIT9uFPIagN7un3PyEVPCxCFe2yTlRycfONoYPEkvLEXvZRhnpYTdyrtd/Qn/OIH+Xmj
 xo5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWllrwtqK0ev2koeTDemceMPbb0FKWC/x2uQc9hF80QNMGw7+94JUbEeoHu8ntYW/7GPhGF3C5bNc9J@nongnu.org
X-Gm-Message-State: AOJu0YxjmormxoTARfFn6Znclr0x4N6k9HdQpwq9G/c/B5DWwgGzNDPJ
 zl5se0o3quoTWvZxDSjvOmvddFEHGtxE1AV5w9Gg1BmHQaN835nCowbCidxWGd8QpNE=
X-Gm-Gg: ASbGncudhPqe7LNzFZkpsGp9LNiqcVTDO7B4KEkeNI6qERky7O6+2OBwFLvTZoOi9n3
 FV4r20/ujc2pWChWJrN5OR/3gr+0zIdxaVEHriP6DQLI/NS+9r9Olr+zVuNvwwlV8y2wshiRL6c
 92uuj6xaR0wCT6Z/4oolWiiVk7G8wSkMOxuRUWTDFDKCcEODwyvV1XC496dVNn4dH1kXo71SR4g
 pGrNACepuGPUqxbpAVHcWUmFewugYO3K/bH3LIvPbgrNJpidcJXQ6sxH/+zak+MPsVolIOpk/IK
 v0gL4uT4CJNUZQN6SU/OPvAPPWmWmg001CkS11CHerE6dEBRZl8L9uXVP90NlzajfJhKFIsiodg
 FcSmeGK85IxGJ2Pf1LuwCEJ4Im9M/JXZlaPJ9aoWTdxZxXO5cCqxy1ynxmZ2W9pIYxRtWfoU=
X-Google-Smtp-Source: AGHT+IF7FQMxR2KhhKeC+IJ5fu5/aL2ctmZCKbmWkRmdLlBkljgyTHyzigUkTEUbgsiPpRdvyemzCQ==
X-Received: by 2002:a5d:5846:0:b0:3b8:d32e:9222 with SMTP id
 ffacd0b85a97d-3b900b735bemr9904557f8f.38.1754919445648; 
 Mon, 11 Aug 2025 06:37:25 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3c33fesm41312421f8f.29.2025.08.11.06.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 06:37:25 -0700 (PDT)
Message-ID: <47807bc9-ad30-4c40-806a-effbc3f3038b@linaro.org>
Date: Mon, 11 Aug 2025 15:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/uefi: return success for notifications
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liwei1518@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>, qemu-riscv@nongnu.org
References: <20250811130110.820958-1-kraxel@redhat.com>
 <20250811130110.820958-2-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250811130110.820958-2-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 11/8/25 15:01, Gerd Hoffmann wrote:
> Set status to SUCCESS for ready-to-boot and exit-boot-services
> notification calls.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/uefi/var-service-vars.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


