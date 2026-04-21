Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFBBF327A8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 06:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF4Gh-0000eP-Te; Tue, 21 Apr 2026 02:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF4Gb-0000b4-Pt
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 02:07:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF4Ga-0007bL-4t
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 02:07:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso16076965e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 23:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776751642; x=1777356442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rWDzxyw7zjdzFcuaBPFt9fsYVUdO/8HTNbKbGg5sr68=;
 b=Qhcsx+/1HGOmIMuqnH8XoHwCOPpM5A8Tu7n1eV5EE4D10TegReyz3nYgRZEzEFcCk5
 GWY1ljzIyilrgJPu6NukgCVGziUXK7QBQgCa1epLuDZQ3p5u+ZbsMYMyTYrtq6BkOqPL
 Cz84bU221VjbwZ6go/rM0xgzifSJMteV6BIfaODjiFp/QbJOqTKLqul9A7VgvnhdGTSN
 Cjp/nuDNN9hdwYxQS88vspS1wN43amapy3mZH0AVsWaQJ81rR7d5E0yZAAtJ28rMGuuO
 teZBRUlUfnKBsuz+B6jHHIxY9IMT21WdLBmlclRHDoJyWZg6ogIpgsBnjszM3YaK3LEg
 Ut8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776751642; x=1777356442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rWDzxyw7zjdzFcuaBPFt9fsYVUdO/8HTNbKbGg5sr68=;
 b=jjGdHBCmpbo3DqEppevz/XyxEVMjmxtueKJZmUBfebMZeD2jbCaYffb/ryt9lsMuSh
 /TpCVKcEq8/NkUbCsS157IG0bezWL1kEer3wHiVLLvmgYrEVp6Db5zWNn2KDNMhRdxPP
 TG7ni9dqq1b9jOEgn2mPTmhiKDL92gYWQ8hVBL3rLbGtASCeUDJh8n0qWnTnkEzyOFcM
 kdGb435s6VtAbfi8kRrgjWOMV39+ir9N8ApnZy7lM11Nkw9HV5erC7rMwtnG708VtLqT
 M30kHEaoWuaiWtuSu09PjCH+nywfYUfWrH6XnIFiO/ghGWe2KrL5MtDhNk0fEqipBmww
 aIIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tD+jkaR7kVV+OE3+lSyi5dAT6sM74ZEi//T+/4wwMKVgwR4wRzyCoqfrCUl2MmA0NheM1IWAHPQhH@nongnu.org
X-Gm-Message-State: AOJu0YxMWWxqTzjY1ow2wONp+yCrvPLJSKDNncEF6C8mpHRaSfRb47i0
 1kPJPkDfVbKK2zSILCxBSxilIS3FKUPcKu2Y6Y7sMRPQHn8i/qYibhsUyO4jJ5dV3wk=
X-Gm-Gg: AeBDievTlzlk4lslllWopfSjZVgi+rgPLBA1+Ic2wGKGiQHandYic1cfES3K6Bn1uE5
 gn+i3Z7ppc6G+mEZty30NUSnoQXx39ew1ITeQa3hKgYTLhKbfOg5yETeUeR5nzz4SElnQ4Swd99
 PZ80J0hhq89A4BadW8ZvetPS5MTmimPjP3XNVsh5uZR4peCIUyRUGKW1sx8Cv2AfkxdSncsILWP
 BHy73OsG6YZGfn2xD8FivlBpNV5Qm/p2XFLDrpb62pYzCj8h3gOobfFiduAJJx+QFpQ/47HMscP
 ho4FBpllCqEQJsySFXIlWA/yVm5Br2y4CJvOXBQD4uHCfLTGScuyY3oQgaHdwnhXVosku+SiJB4
 +mO2oyILWeqmzelMbABhV7AAKKhvvlK1EuCt1Rz4e4Iv/XKrwNpRU6X0yoPx77RzvTjEcsIPXlX
 D+BYCMKVgBQu2UFGd8zLBo1N6296H0B5Xxj5Iiteuo1ZcFOx2GP3AUOcZuuu14KTElnmOIZQx9h
 gJA
X-Received: by 2002:a05:600c:c0c8:b0:488:ab1d:dcc5 with SMTP id
 5b1f17b1804b1-488fb787ba3mr180059155e9.27.1776751642062; 
 Mon, 20 Apr 2026 23:07:22 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb79ecb9sm144382675e9.8.2026.04.20.23.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 23:07:21 -0700 (PDT)
Message-ID: <cc4087cf-1ddc-42b2-a58a-a95ecd7be42a@linaro.org>
Date: Tue, 21 Apr 2026 08:07:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] hw/riscv/atlantis: Integrate i2c buses
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-13-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260421053140.752059-13-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 21/4/26 07:31, Joel Stanley wrote:
> Now that we have the DesignWare model we can add buses to the
> tt-atlantis machine.
> 
> Provide a fixed clock in the device tree so that the Linux driver probes
> without WARNing.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v3:
>   - Add device tree clock
> v2:
>   - Correct count from 4 to 5
>   - Fix headers location
>   - Use HWADDR_PRIX to be consistent
> ---
>   include/hw/riscv/tt_atlantis.h | 13 +++++++++
>   hw/riscv/tt_atlantis.c         | 53 ++++++++++++++++++++++++++++++++++
>   hw/riscv/Kconfig               |  1 +
>   3 files changed, 67 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

