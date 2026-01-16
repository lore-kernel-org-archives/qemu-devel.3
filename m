Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6E9D4A604
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vge1M-0005YP-VD; Fri, 16 Jan 2026 02:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vge1G-00050y-Qj
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:13:18 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vge1E-0001Kz-Sx
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:13:18 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so14920825e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 23:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768547595; x=1769152395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oCTK9jGMUUuo4/vBVviw/ESPLEsvqG3hgTOmY/je7dk=;
 b=KPiz65e6cnvGTj6ikDqa2t9xcd9JJ0S6GgelrMCNzWhI6dwURtAuOo1qLPMzkfX4HN
 0FeE401y/rtVIYoMbjGZl08ZzLCywdQmtVq2VNI/WOYJH0fU441BGeWjvW0YDpWHH4Hx
 8Bahpq/WT4s6Ekyn65FFKAbWg1gbauRwuKIs9X2kdhAEpsulP6fZca0XJNbgyxHvTg58
 QqC2rVK/hkdJTsVmFyHf5PdQWyk3bSGVkkzi9dNQOYjo9OnS5SBf4q5SV2yFE7AtKAoo
 QfcbFEUWOCLFDcIQSwh2x1nTLZnTRhn2hYcsVu6IJKydERo4XGyRjho+XlrRmy4Dfby8
 tjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768547595; x=1769152395;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oCTK9jGMUUuo4/vBVviw/ESPLEsvqG3hgTOmY/je7dk=;
 b=DnoHMDRVIVcdzLMwRVT1X7mc4Wvsrl+Hu8QkRXfhhnP/53agILeOSHkwh3Sduhfmhw
 rQIdDmLnt0UBy9xTGVtPj05CzOqUE6egeCtN/lxm2uesOY0UvPrIy795b9a6lV2JKnSS
 K1jGpLkpUEuhxl6kcTY5ihpG8+EXdsn7vxqdIQ9N5GAhSJOuJisPOaMlDhj+j9vw0LpW
 PimBYJQU6aoe42BQhc0FyftpYjQ7yT8XeHgNI0hB04Z0IIiOJwQAYiYh8iuR39antmyt
 jAbYXyvhkbDY3gvID43Wr6RalAIWFsXiHDH1DMhVUBsoC+BYcDdFS1pBJnfs3dqKEOSX
 029w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy0bF9PQH1wAAqoKsPh4oBTeLCicj5wbH4zWXq5iyk18IRaCYRelZ2O/BQ+JOYgD6Sfq9fDhzKYUGh@nongnu.org
X-Gm-Message-State: AOJu0YxURuRdnszmFloes+MsoeRGMnp40+HunT17DEbtMPGSgj62tabx
 94r/nnE+1mWAYswdjCzMzcAGmkmnpbl18FXY6nmEKznVohru3IUjS0KzcCW3zemWY1M=
X-Gm-Gg: AY/fxX54eZ2Q9TAF1EtxFFg+KAS1q+14CIu0VPtchPtgCMQdp4ghvggwvgcVyHsNv4N
 TyF/pLFPAk6GYrDjeI46aeqDkQ+JYfyELMLWRLlmY4r3oyiUBEjh6OAnXzIx15J0k+2YG6DXnrN
 qUk68Jyv+pv0keEfj14jNeGZuBzBY87JflBKDe4P8GtEgg85b3B6AIs45DJpMZLK9uaQldIZeTs
 HirxD4gxsNlB4zMd19t+bLtY2XV+ZO+aUb3vk8vkB2PYHl7Yb5il1FujbVhz8DuNlJp0irDb/zT
 xzeTpAtmD87WpUWBkKeavYQaa6khDlb6y/QHdbamo2SQGXR5yX3eH78/2/vHNElOViS+EV2sF9B
 d6sXM8YUISh/Mcbuv0o6KxCRaEDAXlm89eQtDvQSYZgK5DFNeMuCtSov4kvPec7gdf8+oTT0Js6
 lIpwZY0os85JUL3+HpgRHMWEYq3rR8BG8T7aEpMWt6/IlKUHsf0l5phg==
X-Received: by 2002:a05:600c:1c05:b0:47e:e952:86ca with SMTP id
 5b1f17b1804b1-4801e2f28edmr24196395e9.2.1768547595240; 
 Thu, 15 Jan 2026 23:13:15 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428ac749sm84270105e9.5.2026.01.15.23.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 23:13:14 -0800 (PST)
Message-ID: <f8f6a95e-f684-4612-ab1c-a062a3fec6b5@linaro.org>
Date: Fri, 16 Jan 2026 08:13:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] gdbstub/user-target: Convert host errno to GDB
 File-I/O errno
Content-Language: en-US
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Dominik Disconnect3d Czarnota <dominik.b.czarnota@gmail.com>
References: <20260116014612.226183-1-yodel.eldar@yodel.dev>
 <20260116014612.226183-4-yodel.eldar@yodel.dev>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116014612.226183-4-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 16/1/26 02:46, Yodel Eldar wrote:
> Use host_to_gdb_errno to convert host-supplied errnos to their GDB
> File-I/O remote protocol values, and use them in F reply packets.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2751
> Reported-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
>   gdbstub/user-target.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

