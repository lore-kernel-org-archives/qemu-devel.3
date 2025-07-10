Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A56C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 18:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZwPI-0005h4-Sp; Thu, 10 Jul 2025 14:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvvS-0000Wx-Hd
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 14:23:18 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvvQ-0004hJ-Fq
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 14:23:17 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-735a6faec9eso673409a34.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 11:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752171795; x=1752776595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9o7JsylpjJEVzYsy8dmJfkIyT1APuAqdOViAFub/ff8=;
 b=FNJC19waSeGJ5FSQgFypqIGhxB/Vmf73T5DpOQ1S9APKUxz51SaZMS0MhLdKxJE1xW
 gSbOinDpt1sSBC6ZFjRJXMID4Sl8GaXMZc+5HHT2jnPSp78UlyN3+LLYPALFUAPUivIg
 1bwN95dbpvBEx9egabr7DeQRW2u6UoUyHSI67caqr3uNC7FXUMsPPW7ZzjSgDWYVXDKY
 ON49v+LBScGb8IHXiulWNQIW24u0FIoOk+Pnn+3UTgu1z4mVulXJptkUEf6CYL3iUb0h
 0wmAE3FPAuVTjw8UnS7FD+1lvl/WLm2FLkRBh+1OR3cVf6GxQvamPv7ATq3SvElx7uBh
 5cNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752171795; x=1752776595;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9o7JsylpjJEVzYsy8dmJfkIyT1APuAqdOViAFub/ff8=;
 b=fweiHfrDLKLjg83oIN1ppgDSDkGbgJmItRzfvsYewkox+6uu65X0tyn27AsR6IS338
 oJ5HoMrMoxQYemfjVgjroJs6rw9X/zwxsFqW0s4r9HJGpXZjIxBviwOaZVySm4AlEV1e
 a9sM3W7cSDHlGswBrjp02dwqJRyzUMzjiaVdLjGVGhUTArBRDHWaax4U+2sME6tfY4uN
 e0dIlS6S0WXo+AnKMZO1xBb6DC1ZdKeWz0Ngnt/WABX+iojmMlE28vIWpObagQlqf7p0
 0ohwUg0P0MkguurC5Deu33xXHtKW05fmVKG6X7fYjPw8YTWWsCwmx6Qe1g1xEiOjfrur
 cndQ==
X-Gm-Message-State: AOJu0Yyrm4bu677YP7anpn42Ej5f0VMLr6IQXp5EFFUAzuyRv5ge7bRk
 V+X49mXpABGJinouy+RVqCHlcvAQQjuhRu/ZriJVuNBIINOSSJGNjXDB4SD0UeE19m+i8FBPYI1
 qUHaIvo4=
X-Gm-Gg: ASbGnct1MDKfi4SCRC/fca6QvskVVfxE4S7qcTJGmkyY5h3p4BbbATm0q90a3wzSrwx
 TWA+S+Exq2B4ukWUuZbKwgSg6oroFcZdQJaxJtdU0BodpGhEN79H8h6Dxn8TW29RUgiDl1j45ur
 zMAYvj3flF5ND2KASOFBzm16QrEArA9c6hEjfC1yNlOPR9vPWLbCHNA7x1lBqvWNoFzmt+eVCty
 ATDPiWetGCq4xI7PlZ1NFB1++WvPf0u+tdZFq5FI8mi3VEtEdcJwXLPungTEL24wYwLly+s2Doz
 VsLtUpA66uwdkcg9o7ZtHy5j2/F18LXpu//KpmGkrOjmWzzWrkt6cf5UEy5KNJiImb/It4aozwz
 TS6Q=
X-Google-Smtp-Source: AGHT+IHJd8F1VfkcBD17O/YlVuI9R+Wy4fofSxgemACR4eCPXLvVG2RtP3ApiBlcksg9xkHfmX/Niw==
X-Received: by 2002:a05:6830:6805:b0:727:3f3e:53bb with SMTP id
 46e09a7af769-73cf9f349b7mr417866a34.24.1752171794544; 
 Thu, 10 Jul 2025 11:23:14 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf1088d61sm290206a34.19.2025.07.10.11.23.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 11:23:14 -0700 (PDT)
Message-ID: <7f143802-f582-46ee-b7bc-988b2b9b8e98@linaro.org>
Date: Thu, 10 Jul 2025 12:23:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Correct encoding of Debug Communications
 Channel registers
To: qemu-devel@nongnu.org
References: <20250708141049.778361-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250708141049.778361-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

On 7/8/25 08:10, Peter Maydell wrote:
> We don't implement the Debug Communications Channel (DCC), but
> we do attempt to provide dummy versions of its system registers
> so that software that tries to access them doesn't fall over.
> 
> However, we got the tx/rx register definitions wrong. These
> should be:
> 
> AArch32:
>    DBGDTRTX   p14 0 c0 c5 0  (on writes)
>    DBGDTRRX   p14 0 c0 c5 0  (on reads)
> 
> AArch64:
>    DBGDTRTX_EL0  2 3 0 5 0 (on writes)
>    DBGDTRRX_EL0  2 3 0 5 0 (on reads)
>    DBGDTR_EL0    2 3 0 4 0 (reads and writes)
> 
> where DBGDTRTX and DBGDTRRX are effectively different names for the
> same 32-bit register, which has tx behaviour on writes and rx
> behaviour on reads.  The AArch64-only DBGDTR_EL0 is a 64-bit wide
> register whose top and bottom halves map to the DBGDTRRX and DBGDTRTX
> registers.
> 
> Currently we have just one cpreg struct, which:
>   * calls itself DBGDTR_EL0
>   * uses the DBGDTRTX_EL0/DBGDTRRX_EL0 encoding
>   * is marked as ARM_CP_STATE_BOTH but has the wrong opc1
>     value for AArch32
>   * is implemented as RAZ/WI
> 
> Correct the encoding so:
>   * we name the DBGDTRTX/DBGDTRRX register correctly
>   * we split it into AA64 and AA32 versions so we can get the
>     AA32 encoding right
>   * we implement DBGDTR_EL0 at its correct encoding
> 
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2986
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/debug_helper.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

