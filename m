Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B94CC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 19:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpB3n-0007sR-9i; Mon, 03 Mar 2025 14:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpB3k-0007s4-Nr
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 14:02:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpB3i-0000MA-Pt
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 14:02:36 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso30980315e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 11:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741028552; x=1741633352; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YJdILYjS92vbBZLe+zQZhOSlSZKz33bBiM4G3VaQU1Q=;
 b=cYjdR+gQAidSXEo/zOI1VE+26ukYRwQiHQc4oDrHGMYtPnmpzVOKUZ8TT2ohoVOdwV
 pWdLVcSApfHf9S8sfBaVCfb3bLu4ZFDK18BAXWAezrRCbFPiqxzKuzNehwsH6zb6UiQP
 /d8JuNaOoJCCZNjFYQ8fn2crIG6ALAbMof1mkro9oqXKuJuD/o+VTo6IfjE9UDpl+cgy
 /Cj7ofvX1Ak+1CLPRizTphZx+l6ZrEaMHhlGzDKFB3KcQR1ptapZHB3f6hnUhc6xckHe
 22NwQHwdaBnlTuFUhSqxefcQUknAi5xstvBXLevGumj0yuJvQIW+xWkezXK4Hvx+/k6K
 QPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741028552; x=1741633352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YJdILYjS92vbBZLe+zQZhOSlSZKz33bBiM4G3VaQU1Q=;
 b=LjmEjpaICvz3yKisD+5W2HY3Bf+kULv2D0UmBlYEnyVqhYaZNfoGtV4PsGXPxxTiyX
 tkkQiSITkP1ItFwWwHuhFUqaWlau3Gam0sovd/UUL9XgW0saqsd6ToykGhLFWjBtuQi/
 dwGm3A4pBJMaO6YQdgnqIfZ/bYZ//mcFULPkuHHxjjQQvi9Icy6YdLwEEUqvGrrY+Vm4
 jDr/ZvDCVVUczZVzKwcwaW317BfOT2MP2x4Brj0QqqVI1b92WzYDQFgBEStlpVYiMOtj
 RtHgtvLur5hbcXaD26jHXLhv5By1mH5GH85TsHwXOdPMnNrZHmsLvfr5ZOOz1vD5tsfv
 /bvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX3dPz2ObGmqN6J/OXoaEvXxNxvWrAP92kx89KYpxKbPqaFFzixGko7nZXCkgvcbQuYEwnu/M6Aq87@nongnu.org
X-Gm-Message-State: AOJu0Yw5+DT/CP6wmtCnbjxmg/qacDur8tx/319ZxaPj7QbCkdlbBfhC
 qBoNWOr8MSO/P2LJDJUu5OiN7dxOETCMk0nZWgV5li2h20zEKscTe1qG1XLCUVs=
X-Gm-Gg: ASbGnctTL9dxw224ikx5hvc12Bl5ak2ZMeIgamoWkgnsE9NFP7+TPoRDjAGcPb5BJut
 1tNpF/16YiSHXSIw82TK+2Ai18tdGxfV/OiZb7WXtBKh5Gj3nopF04pxczr6Vj/9LsOd5ySdPEW
 yc0xYkiDc2F1cmivy9YzXrv53cdbV2vCjyhZpIEGb5NMEYvnjQcLWTkMX4qOSMahdgqyp+S8bov
 2diAk2IBpeTfb4SDTZMGG78l6mw0P74YpUoyJ5lawBtHE05hyscs8khcMcEr7G/7kK+9nVthx0u
 mkHWbOjLM08udj8HOaj5XZnCcLg6B76oQbPlRCzSbigXCk1bgKo+FwKfV+RvzBbpZOC9iQQhKHU
 qKOMMqMwih9d8
X-Google-Smtp-Source: AGHT+IHafNZ+HMVam9xF7npXVCN2MTnVjapHom+MUD3QwDr7IQcbAQhKu2y3DviutzaloNi+m211eQ==
X-Received: by 2002:a05:600c:4592:b0:439:9e53:49d8 with SMTP id
 5b1f17b1804b1-43ba6772103mr129967945e9.30.1741028552617; 
 Mon, 03 Mar 2025 11:02:32 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba53943asm197379815e9.19.2025.03.03.11.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 11:02:32 -0800 (PST)
Message-ID: <b16c54c5-9680-4cb4-9819-c91873738aef@linaro.org>
Date: Mon, 3 Mar 2025 20:02:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 052/162] tcg: Convert shl to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-53-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-53-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        |  6 ++--
>   tcg/aarch64/tcg-target.c.inc     | 38 ++++++++++----------
>   tcg/arm/tcg-target.c.inc         | 25 +++++++++----
>   tcg/i386/tcg-target.c.inc        | 60 +++++++++++++++++++++++---------
>   tcg/loongarch64/tcg-target.c.inc | 43 ++++++++++++++---------
>   tcg/mips/tcg-target.c.inc        | 35 ++++++++++++-------
>   tcg/ppc/tcg-target.c.inc         | 42 ++++++++++++----------
>   tcg/riscv/tcg-target.c.inc       | 38 +++++++++++---------
>   tcg/s390x/tcg-target.c.inc       | 37 ++++++++++++++++----
>   tcg/sparc64/tcg-target.c.inc     | 27 ++++++++++----
>   tcg/tci/tcg-target.c.inc         | 14 ++++++--
>   11 files changed, 241 insertions(+), 124 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


