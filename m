Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C752F8DFCB
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDUQ2-0005ue-UF; Thu, 16 Apr 2026 17:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDUQ0-0005uM-NB
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:38:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDUPz-0002LZ-43
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:38:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b8efed61so356375e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776375513; x=1776980313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HKGPiNifk9FDEGyvQkGz1zmdc2/gjCRhfZWQ/72xnDY=;
 b=rAyatHBz8nX/2vtN6uBzQ/lV2dB1D52sj4B9X4d1E6VtOYTrH0ad2toPMtXydAAXQp
 0I0j65Qbbxswn8NM+NiwUS3JIQrRCEOcJ2QBwLNHgefg5d+MmC9H1g64YFC721YY19L5
 IiBTSyZyjyEX5aRf07Mj49z4EVC/7Rbnt3P5iZxzQW8j/9/Oo72hoQpgOyFXVCbQ/gS5
 JEoLgTdawBj/z7rqwOlUUiyRT0ZiV8ZTnHZshdG/vDzk7WfA5dinY6H/FIFxkl51n8Iy
 uZaSa4mugjmZeXkDDnF+s2iB/ONQF8qV5I7A69GYo9X25sfcDa5rvDwBKLd3r1sc0VI2
 TkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776375513; x=1776980313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HKGPiNifk9FDEGyvQkGz1zmdc2/gjCRhfZWQ/72xnDY=;
 b=Voooj18cbQc6/f8h5uPlEohAGxvgXm66z3wcuDxCbHrmkPusVbECpuqnM30+wmNvSF
 0pHAWWh3tWlgx/xVDh0JrspVG3BuHHuJ9AsEqXWHrEANraMRhG5aaFx0pUwir9XwLMZ6
 RgyE0cnajCxuBqgYskWEd9hTapuAOw3vW5CSbg5U9d/DzGP1dQnCM6e0zRI4w5BuisNg
 yH5Z/mbRngjBoAnRD/qdMw1J2AfHG8k9PEeNuY00FxR3k/sMnx+Dq5Ks002p690FPbOb
 +/uxSnObOLOdGaeLFUDVtOdWjVq5jGfTkfQBj3s6vN1IcDsy80Dg8L5RaxsMjtVhuVBp
 NF7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pS/OjIiriqXNPXK7b3qGhrQoE6tcBYetwFsmwlcImf6aM6NBHnQNBz4omn4Z1xjsmKlnR7O0IrtlC@nongnu.org
X-Gm-Message-State: AOJu0YzSY6ns3tR8FUFb+dPA1Y/S8lLUpj2Kl48XBwPyZhdHEH0DygNF
 0bEU6QX6fHIN840Evw9BWKB+gWS5Ave9Ai57riY6p6gcJI5i2M6lbgIpu1yRuvrZulw=
X-Gm-Gg: AeBDieszwducxstUA13l1co0OwFLakJaiWszZk5XqGqxWDzwJW3nm4yHlfyl2AvSWJx
 SRp2R0m1kQ+RAUtwdm1x5pWGxH3oXOhQZwGo0oO0y49cttaW72DmFZUNrceB8PDICXK5s1UtTU3
 5lCXhB2OQb4zCHvNis6OkiLKhOsz20ojDAUi+ztmaFNc60DpzAg6ITjIXGjnyE4OiSFK6sE7+3j
 nQXoCHLdVDx+r/5sFk0hZyYwiW+9KL8craxarwHWdt9i9LclcTQ9SR19sopU8She4BIrBKz46Sb
 ldhz5EPqc6xASf+VdK1LCVZ0gi/tqYxoVOV09DgifLIcSVNVP2f5Gf2JmN8iYpm/aJCgP3WIr3w
 EfSUFmDrDjWDdMnr93uqfT0ItBASZY83+QBWZQ9xvkrNZKJRW0ejCOf8QIBaOFIo/g/CGNQzCdA
 ZmcAfDgVc2BQG7QnK5FL/+kLizuvEG3c8gIQukWP1kimw+utO3NRrCcTKCUNwU4I5PMRZksPMAC
 XPJ
X-Received: by 2002:a05:600c:3ba0:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-488fb8b91a7mr1306105e9.12.1776375512712; 
 Thu, 16 Apr 2026 14:38:32 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f581bc3asm79725155e9.6.2026.04.16.14.38.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 14:38:32 -0700 (PDT)
Message-ID: <54e1b7a2-9591-418d-a54e-5e6524282c71@linaro.org>
Date: Thu, 16 Apr 2026 23:38:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] hexagon: print info on "-d in_asm" for disabled
 IEEE FP instructions
Content-Language: en-US
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
 <1bdc772e4a795ecd9f5bf2b7e7143cc4b297318c.1776339451.git.matheus.bernardino@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1bdc772e4a795ecd9f5bf2b7e7143cc4b297318c.1776339451.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 16/4/26 13:38, Matheus Tavares Bernardino wrote:
> When cpu->cfg.ieee_fp_extension is off, IEEE FP instructions don't get
> executed. Let's print that info on the "-d in_asm" output to help users.
> This will generate an output like the following:
> 
> 0x00020e30:  0x1f82e1c0 {       V0.sf = vadd(V1.sf,V2.sf) (disabled: no ieee_fp) }
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>   target/hexagon/cpu_bits.h  | 3 ++-
>   target/hexagon/printinsn.h | 2 +-
>   disas/hexagon.c            | 3 ++-
>   target/hexagon/cpu.c       | 2 ++
>   target/hexagon/decode.c    | 4 ++--
>   target/hexagon/printinsn.c | 7 ++++++-
>   6 files changed, 15 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

