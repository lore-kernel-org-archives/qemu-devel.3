Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EFEC36002
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 23:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twUXF-0003YI-4M; Sun, 23 Mar 2025 19:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twUXD-0003XP-2d
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 19:15:15 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twUXB-0001ZS-19
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 19:15:14 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so24676135e9.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 16:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742771711; x=1743376511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yq3Zi1gBO4vKwYp5BSd5GvM9w35M9GdzFC97akK5K2U=;
 b=TDZLATE7aL9g5KzwJGIoWTg3IJCuSETB58PgCHUxHEUMMfWQHF7o38+IDYv/iC/INW
 YPlP5QU4R/LOIvBqHo0+/BVVAV3JOT4jE2kn0MYtiFCRUTQHKUJYv2yCqU0mMKGnLBgV
 QvnbL3acMk58MBH9RoLAN3ksTQ6kidzrrT9j5AuMl9/Lj/wXKuQJWIRDmzuXxnFF6mgc
 jUDB5tam1iLg14gZa9BG7vWf8HDj6YECFVsYolB/ea063xSgcnaX5/a3OyTXCExqIzK8
 4PdD+iDAQ24snZHLqO5kWJmvJdPxYEJnFij94fgKmkrCX9ed3j1VA8UbtZA+HLHrlObW
 2wyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742771711; x=1743376511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yq3Zi1gBO4vKwYp5BSd5GvM9w35M9GdzFC97akK5K2U=;
 b=Ka+34EoZie+rdFxm70BtFXVq8Pk64e6cxgBzCoXVBnaVgIucDQMwXekRB/gEVICrNX
 6sPtNrw/18bJOdLxyGWeoMFUc+L4N5aMGIsSfVhyA3sDJ7QyNqoiSa3gWQPFt7ui0Jje
 N9ktxadygF23J2zjOoPFkYWLcHtiSYGlLD2XE92QVHrhqnXO+bV73nRiDSDh7wB/s/74
 +aNo9ZEx9k3xx/oUnFBa7cS6/EmQHGAqNI5bjaNOHc0Kuf579YAEgB/l3loTmp0rjmOu
 N4GoUOAQJUiw7HJuv05q0BWZDI/FFnQnWCkBOSjKcPg0n4c44yhLj+0mVpRpwdx6xSTU
 XzqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9CTLUCknq2WrZr9aYSr6yN8VskLiosfmMbjcebr3FIPSKPoMT/xYhFWiALntF59QBS5+c+z4sfxCR@nongnu.org
X-Gm-Message-State: AOJu0YzzBBvfC5FhfsB91eMW4Th7SAgjZ9phvXOSZbrETRpXehznmwJn
 8evPLP1NNtRE8FgYbSse9W3cIZBt7ONZ5nY2gAZt7sEDEnmcN1YfeyZHBiZn0eY=
X-Gm-Gg: ASbGncspp+/igidO2Ewc+7rbC4zmUyZC+go+YuYMvWoTu6DMB0XZAUpf03QrXwxyCX5
 qTcc3nng1KqzfOJLqTq5yU4xw255fHtvsujm8M97ivt1vCRLfoEDG44fbYjcOpP5wCq4dTd2U7f
 iID+gTGjdr06hRFyrj1Fg0DATduSOxYdRfxMQH3lrOegDUvFKLkQGNTzb0eYsyyDO8GhG8MDpYa
 XPHoZThuuQoMyCAGZeqe/aAyB9CoPPtqpTtaD8HIQiP7wmrD/pSAj/aoO4kFDRTowAsGH+8zuTA
 bYnd4EC2dXjpnEAGvQZ4O4llKloukPfUqDboNGjRo9Lh4TTnSJEaFkRgi/x0TEPTiokm8pf8SRU
 p341EnDjow41YVRmqKg==
X-Google-Smtp-Source: AGHT+IHAPqOoxEt5UPQMh6NFBxEKhyMvYHlFGPydQWvn4mgeFNXXORu5pnFpjDTD3HfBAeoXLL3Cwg==
X-Received: by 2002:a05:600c:3c9b:b0:43c:fffc:786c with SMTP id
 5b1f17b1804b1-43d50a319a3mr99012985e9.19.1742771711000; 
 Sun, 23 Mar 2025 16:15:11 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed4cbsm153413005e9.34.2025.03.23.16.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 16:15:10 -0700 (PDT)
Message-ID: <b7e007a2-7e68-4d75-b3e7-9e0cce2fc698@linaro.org>
Date: Mon, 24 Mar 2025 00:15:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 4/4] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-5-philmd@linaro.org>
 <8cc6f6a4-b868-4dc8-bc14-25b438ad62a5@linaro.org>
 <5bd8498c-b5ff-4fb1-94d7-a2efa2f20fd9@linaro.org>
 <cc7d5557-0e0a-b7df-1eab-8f9d86444d2b@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cc7d5557-0e0a-b7df-1eab-8f9d86444d2b@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 23/3/25 23:13, BALATON Zoltan wrote:
> On Sun, 23 Mar 2025, Philippe Mathieu-Daudé wrote:
>> On 23/3/25 20:07, Richard Henderson wrote:
>>>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>>>> index 28fbbb8d3c1..ed79cc1a6b7 100644
>>>> --- a/target/ppc/cpu_init.c
>>>> +++ b/target/ppc/cpu_init.c
>>>> @@ -7490,6 +7490,7 @@ static const TCGCPUOps ppc_tcg_ops = {
>>>>     .translate_code = ppc_translate_code,
>>>>     .restore_state_to_opc = ppc_restore_state_to_opc,
>>>> +  .mttcg_supported = TARGET_LONG_BITS == 64,
>>>>     .guest_default_memory_order = 0,
>>>
>>> Similarly.  I'd be surprised if ppc32 can't use mttcg, really.
>>
>> Per Cédric on IRC our ppc32 implementations are single core,
>> so never tested for mttcg.
> 
> We're just trying to implement more CPUs for G4 mac99 and tested it with 
> -smp 2 and it seems to generally work but we need to implement more of 
> the Mac hardware for this but we could already run Mac OS X with two 
> CPUs and mttcg and Linux too if we add a delay on boot when second CPU 
> is started (it may need implementing timebase control as done on the G4 
> Mac to avoid that but if it gets past that it seems to work). So please 
> leave this enabled. Not tested does not mean it does not work so only 
> disable if there's a known problem.

This patch aims to be a no-op (no logical change), so does not disable
it since it is already disabled:

$ git grep TARGET_SUPPORTS_MTTCG master -- configs/targets/ppc-softmmu.mak
$

Enabling would come as a distinct patch by someone with good
knowledge of the architecture, so not me :)


