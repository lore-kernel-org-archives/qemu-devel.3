Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30E7E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLpHC-00061N-Pl; Thu, 12 Dec 2024 14:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLpHA-0005yq-2I
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:55:08 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLpH7-0005C3-Uu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:55:07 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-72739105e02so1182443b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734033302; x=1734638102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mXGd6AIcfrNuVW+SUAT/Ekdz9Dv6erTw5OO57f7FcEA=;
 b=EC+SNH6kecpqKORexpUE5vMblg3d2neeRwNW+NxwkI8pHeOaetfnJV6JEB9t8hDGwA
 dzuhOxT7Wik9wpnl3Aof/vZXms/0JBBkSZgVDDGW2poWdnJJ1KLmBtaDWtXxsoDrfy/P
 lfi/1raSsinLlxZHn1MALf4EI8BmFooWmJ7y1GTwUrpSBWVhuTJuyMmedlW28GjDYyh8
 pDvlWyL7yTxR/XQNBGgzhT3ornZmGLxS1IrCzvqU5YXzoXJXYOz7lkevS2K7oljJh8w7
 jIT0MZKJVjmQycveI73uLCeJwkJMS0CsRnDSNHjCH33Zav05pPO3jFFYkYzJbJMK4rfq
 HTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734033302; x=1734638102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mXGd6AIcfrNuVW+SUAT/Ekdz9Dv6erTw5OO57f7FcEA=;
 b=io0zcvmII82VZ7UFQRarSI61BsQLuuyuMgLlSF5oxr61Qa4dMLqYdIDSJYIWRpTmWb
 wE0L6I5jahPUGtW1qcwNDfG4mspAT3jP0pfytROtnVLbMbuUh74NrPysVRqPiXjwLmNE
 yRNS53vX0kM2vcJaj2oDUn/Q2swZ3mXTTCe42/iJD9R03vf151g8Jq42aX8MN3FSatJB
 f0kOo1pS126khvTJX0qY0ackClRM3VAzqiTffVRy4n5CV7Cz0BV+ZHRENDCmSE1L1dwc
 DvqX1y4alRBixKBD3PNDi5+sUWwpS3SM+OOq0b9V6XAmKzs0QQ5cyvRi1bLq+BVyDeYc
 lJGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFo0jcYi+dSbMI+KxZyeVKRCEg1bnTQxRl9lMBdqllDcXZUUDmKIxDwcl9lsmIT5KLv8vxxp/W4O+e@nongnu.org
X-Gm-Message-State: AOJu0Yy2tSxhqm05W9WTFmiPS4kTWb2jWazXJjvu5d+qmWQj4HkC3xAJ
 mxAEAz/XD6NExSAjYmGY9s7KZCW1IzA4IplDaIoOhjEacqgVls+0x6OFSZ181m4=
X-Gm-Gg: ASbGncvrpNEaRkY+Km1eNzOo9UBVjGQm/aJ9iP7oftZJx8tD+iCYxpuUpS34NlOx0Qg
 LxIpScNEorP16eUslxDRKYcucGHz9eD577v4TJTajzFR5dTQbM10Xe/7Ytu0JG4N3R8hFnebCNM
 okh+f00MU7RtgyOwaOLsKo5okpABUV9YzIRs/NM27cutqXxlK4pK7QNxZ57uGTT0RwW8Nm3zUVx
 e+HF6sO6j3pJzYu8ym5AWA/v57gDrSZBGWrrumCJ55c6cLjBOY7gBJ5TagGOVAILTEqeg/mZw==
X-Google-Smtp-Source: AGHT+IEccyDzWFBmR7kUugnEzmxhF3lkYPf7SKDnArLx8NSX6O9d0K5574dWmUBBp14+r8LBJ0d+Ew==
X-Received: by 2002:a05:6a00:21ce:b0:726:41e:b32a with SMTP id
 d2e1a72fcca58-729069547bfmr2261078b3a.4.1734033302689; 
 Thu, 12 Dec 2024 11:55:02 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725e67c2759sm8353413b3a.17.2024.12.12.11.54.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 11:55:02 -0800 (PST)
Message-ID: <925369cc-aa5b-438e-bbf6-c9692251af59@linaro.org>
Date: Thu, 12 Dec 2024 13:54:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] accel/tcg: Move 'exec/translate-all.h' ->
 'tb-internal.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212185341.2857-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 12/12/24 12:53, Philippe Mathieu-Daudé wrote:
> "exec/translate-all.h" is only useful to TCG accelerator,
> so move it to accel/tcg/, after renaming it 'tb-internal.h'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/internal-target.h  |  2 +-
>   accel/tcg/tb-internal.h      | 14 ++++++++++++++
>   include/exec/translate-all.h | 28 ----------------------------
>   accel/tcg/cputlb.c           |  2 +-
>   accel/tcg/tb-maint.c         |  2 +-
>   accel/tcg/translate-all.c    |  2 +-
>   accel/tcg/user-exec.c        |  1 +
>   accel/tcg/watchpoint.c       |  2 +-
>   8 files changed, 20 insertions(+), 33 deletions(-)
>   create mode 100644 accel/tcg/tb-internal.h
>   delete mode 100644 include/exec/translate-all.h

Move it into accel/tcg/internal-common.h rather than create a new header.


r~

