Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EDDD3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 01:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va1ml-0001kG-9p; Sun, 28 Dec 2025 20:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1mf-0001iz-6q
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:10:54 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1mc-0000Qv-PE
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:10:52 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-79018a412edso15810617b3.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 17:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766970649; x=1767575449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VM+dXPjP2uf4v7U82q8kZ6nrThL7k5cht7mlZ/pEo6s=;
 b=dJWjwIv055ftMx/YadlMFXxvMl6he/aJ5zxws6sPaT3bnT9TgUyeiPhrseFikjRbeC
 DfYJigbzpE4cvBtPqQjsVDOc6V/n6Pj2HrAoSDF2dsLcxGPuYQ6vOFiOjdvv57gG5h8z
 NSCjJXVEYEKOYsdwejiBMGFWLt/0VW03wpoi2gG50lBdVR9083wx44ucVYVFdQLROCXF
 rWWxmlqZsake0nJ3NZ66vT3S5Xpz9jcMySbPCBt+O4hu2WdX5j78PlfBOK3fg91mROSY
 kIioyqfj+FbK5wrOBXwtafNYN1fyngRZHT7SXCLWF3Af4F2gwrCpu1PE9zvgOBclw304
 d5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766970649; x=1767575449;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VM+dXPjP2uf4v7U82q8kZ6nrThL7k5cht7mlZ/pEo6s=;
 b=OMZ4HlaxcPoEhQ8x7DhT8uCk9MY0WhPrTyeC/RtvGx4xe3UhlEb9ZIg43IeFQLt7/I
 J4aa+6r+mg5AmVkaCs9MuEity+gcJsqZ5ZSJcBYCs4SoI3MWp/gq8fqcmbV/W8gwy5gL
 g8mOpGUpHr5kzvA5xXBKsTNS8KqUB7JzS8Nk1mUo1bhxTTdZ1AeSzouLq9gyghEfRi8Q
 2uvTfOf0De5GLcbvHJFtV/lugH8ZQnjvy/jpaJTHtrmn5MeDvyEhdOyTc8g/ZNzaRKbv
 4wyANnILpqyvgFGx+Q1kFdoAIFxSKwEbZZfB1mu57xdBHpEEdjPr+JTG/sTgN78i4wyV
 uP5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUugIUt16yaepsk+s61yQtuQElvU+EMM8Znytu1++U4tgofdDLHfCqxdhkZJZSm1LCMygByPpPbE1yH@nongnu.org
X-Gm-Message-State: AOJu0YwYNHZblUE8jLUWhrNKHReTEYtSZBp9eeAAhbYzN1Iz+cPF79Kh
 7noLlo543hpKJ9kBEMw5S41zH8llHCfB7rXYKtpTyzArS+DyL7pV3P4Rbmp/Gs8L+SY=
X-Gm-Gg: AY/fxX4BvG5IExUOiFqPWKbfr4cHNbxCtFkF6pcXUWL8hSnwQI3Jimyq6qJHlXC6r8x
 69nqA2llYQH/qorpdbYK7dYmdyGsu7Iw4sj61/Kx3svfDqyoy4TQMLVUMPb72RUNCivU2LTSgj0
 2iwmw7D0Vvf5a7Vvcc64ivfnNuTkKaqKTxZCpUrwKA3SuX4i0Swt6uCreZHli0Z7DJudVingaJF
 T88gv4crbu0r7n56F1+6p9V/5eVf+VmoqJfH+FSUfsHB3VjHoPyx5Eh7mBSDQ5+QrNy9TUjMzOb
 ueChXHzuoSGLHXtFlYpGPcXIvvTQSqN9jYxBarsyV8Dmr/GW5Lfl0Mee3tKC80SSWgI56WklYZw
 tr9DHPaIY89qa16A72BhHh3r8zf6gHesIJx1BaQ2TY0z+FjRcX+PCcI4ypD5ahCRHkXeUufZ515
 NMq4ySJGq9M6qb0VgPiSw+9H4gs5QMpnSF9ro6YKFj6c2rXhEwT2683JGCDR9IEIQbcXjc4Q==
X-Google-Smtp-Source: AGHT+IGD8xcWn6eo/jXAnVlAV1holHaQ4Wm403ubTy1WgOJb/zG8RwAJ8bmAdPMJv1lbRJ8rAczeeg==
X-Received: by 2002:a05:690c:4c0b:b0:78f:b785:94f4 with SMTP id
 00721157ae682-78fb78598cdmr234298407b3.1.1766970649401; 
 Sun, 28 Dec 2025 17:10:49 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-79032157c31sm8188727b3.40.2025.12.28.17.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 17:10:48 -0800 (PST)
Message-ID: <560fc0ca-1c46-48ec-9175-1c0a4f7ee9d8@linaro.org>
Date: Mon, 29 Dec 2025 12:10:37 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/25] system: Allow restricting the legacy tswap()
 'native-endian' API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-21-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224152210.87880-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112a.google.com
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

On 12/25/25 02:22, Philippe Mathieu-Daudé wrote:
> Guard the native endian APIs we want to remove by surrounding
> them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.
> 
> Once a target gets cleaned we'll set the definition in the
> target config, then the target won't be able to use the legacy
> API anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/tswap.h | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

