Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDCAE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOL2X-0004YG-Ir; Thu, 19 Dec 2024 13:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOL2T-0004Xx-Fd
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:14:22 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOL2S-0007u1-38
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:14:21 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2161eb95317so10816245ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 10:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734632058; x=1735236858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=of7XpVT/u+BLQidS/sIzJ1C1gBA65Ws8iko5Ava5nf0=;
 b=E1aUKz0jqi/fCFZMrnRd0IgDvxAtXLVJYn/VPg3UYFJiURL90sKewe/faI35nQQV3H
 UuNFruvKbYYRCQ16SpszkD9iYxYuBtmvy8abUp5cvV5rAciCRAWWh1WadpNc/AQq+A7E
 kkENH0SETDD0V0DIpYk3+jppKO+DFQlSIL0lEZTa2QJW+eLP2ENa8pAVRO7pEaVFe6GB
 BTerL1xPMdDRoAgcRbXhAeME5FETSQQB8xD5yj6T+1l0TgBNcFIufFUJt9Cv9Rkvnd+d
 KPH1+crG9sENbuc3LzNeOcMvYyfv49CfwY4cc6dnFsoghClEB/a57wr7FVNUChY4HW5b
 7sCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632058; x=1735236858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=of7XpVT/u+BLQidS/sIzJ1C1gBA65Ws8iko5Ava5nf0=;
 b=k8pFgo574dgSQV/h5KQCAJ+wkJJgQ1vshA+7vqslV8TC5+/iEiaKXCkk6LDKWthXXJ
 /jlKEPXQKtFY3Uy+E0rqJy/0bekgxxUAdDGM/Mvp5xkp0V1oOlXrcd7OTD73tfPct+n9
 QDKGoASpd9LSai6daIgxhj/iJfaINV07d7lfMX0yzl6931MyBJft5PNvFryjSJt5hXKG
 Er/S458V2W6BUGmysMzeR22jFe8dVIIpWbcYXwvqYVxsMuPdpYK4R36YIMDDGnbrjE/i
 KZqfHA6IzAykb4Q+6GURygcyJxm4FMdf1LH88NyonyQJoYwpsrGTCwHwoUA/vxYgIpzm
 L7AA==
X-Gm-Message-State: AOJu0Yw9u/WmAxFEwB+vReXIszScz560G0xV7Za9iYLlIya0SA/+4b56
 diIPgtiK2kfONhkjGbIrIbVWWEEggl3D4U93dD9d7ygJec2R3afr7YGJ1pdT6zAxvfXdv8APdiv
 G3ra6kw==
X-Gm-Gg: ASbGncvTvmV9llSXAKvhXpe5Rq5yOAn/U7GcS5YNTDsd8uVWhml+rSJau0BDsbXn2vw
 QW+/O4buJz/2LXg/OKssTpAAStSPPqKNO7wIXeGBDLK49JlMamvv4ONHbBzJmk6iYPJsrOkJcux
 LLB7JaKB0X1Zipl36OLXEnL58fcSHu++gPxSVqzgP356B3i02F6b/9JjawQjJTZgLsHNcNOcI2u
 j26AFC/+DRTwg+rICg4C2kRs3wHGru/mUQrKawpB08n0L3IqkzMxTGNjDzlFoIVo12G3JBQ7Ge0
 1Hil2BgCCriY1v9PPLjYsSSxf8j9V2iW9DK4ceNdPw==
X-Google-Smtp-Source: AGHT+IF5IwWz7w/J6yH2Q/YszOkk7x2C+fCC5w7vU8f2Zzf2s1Q/Yq1MNAzIIqlcYxhZ2wp7wUALlg==
X-Received: by 2002:a17:902:e542:b0:216:30f9:93d4 with SMTP id
 d9443c01a7336-219d966c0c3mr59303925ad.8.1734632058319; 
 Thu, 19 Dec 2024 10:14:18 -0800 (PST)
Received: from ?IPV6:2607:fb91:1ec0:c32f:435b:9081:64c9:3330?
 ([2607:fb91:1ec0:c32f:435b:9081:64c9:3330])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dca006fasm15338715ad.227.2024.12.19.10.14.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 10:14:17 -0800 (PST)
Message-ID: <bcbac22f-dbce-499d-8328-333b8760d77c@linaro.org>
Date: Thu, 19 Dec 2024 10:14:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] meson: Run some compiler checks using
 -Wno-unused-value
To: qemu-devel@nongnu.org
References: <20241218182106.78800-1-philmd@linaro.org>
 <20241218182106.78800-2-philmd@linaro.org>
 <D6F99DW9FQ1Y.268COFM41BN5X@gmail.com>
 <f2cd3c5d-cacb-49f7-afec-1e48e5a9a92d@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f2cd3c5d-cacb-49f7-afec-1e48e5a9a92d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/19/24 09:39, Philippe Mathieu-Daudé wrote:
> @@ -885,7 +885,8 @@ class CLikeCompiler(Compiler):
>                    dependencies: T.Optional[T.List['Dependency']] = None) -> T.Tuple[bool, 
> bool]:
>           t = f'''{prefix}
>           void bar(void) {{
> -            (void) sizeof({typename});
> +            size_t foo = sizeof({typename});
> +            (void) foo;
>           }}'''

As I mentioned elsewhere, sizeof is a compile-time constant.
The function wrapper is getting in the way.  This can be just

unsigned long foo = sizeof({typename});

I.e. initialization of a global variable, with no need for <stddef.h> or any other system 
header for size_t.


r~

