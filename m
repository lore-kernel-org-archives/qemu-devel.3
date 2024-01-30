Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C25C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUiz5-0006Wp-Gy; Tue, 30 Jan 2024 02:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUiyw-0006N7-3c
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:56:35 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUiys-0006oe-9Y
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:56:32 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3be7c2ed375so610010b6e.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706601389; x=1707206189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GyhKvu2Vuu5g85Yk/gh5j2SKNd9ylREXN2eRam9l8XY=;
 b=SS0DdmR8vzUAFLW+sFvg8ezmfSEfO4iD+vgnXwiwSUXL8ZdIpSdZR72Tx11YfJfTxf
 6yKsURza9CFj/yTiuzbJh5xOMwis7FuC/ij6EdJ3eDEp77L9WN7U4YkAvT83N04t5Bvy
 WVaR0zjeY/+p0wVY/CM/RVL1FWmC4i0rcu2BURwijiD0sgUqGlC0faaCZHWtGzVpJU5t
 yTjnNxkj2+5+E576mSl04Ququ2vtl60HqlkUxkzm9b/hOCWmR/sr/ib1aUBd1ZXZ2MbL
 GN1Q+0SbtJD0CY6Q0KdsLv0qRH2ILMPst2MrPVhHnCMn9+MpZC448n3/jhuMC2mgFQoN
 6oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706601389; x=1707206189;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GyhKvu2Vuu5g85Yk/gh5j2SKNd9ylREXN2eRam9l8XY=;
 b=H5uln9Zt1Y38HX+9BtrbhDpxHnT92LH8AWpJkOxZG9LQQ3mugPQibvIF+rl6mj1QRc
 9b4v9odIBRoZpjjXeZ/yOzTqhtmFAzJnuB4lxjGN81yQqxefuhEpBsbNL+mW8OK+nz4b
 8chGvucIQLGz3gDRrI9uG5leDpSmWE2880nEpicXJ9NOrrxxsOzpuezmVirhV+bto3t2
 Pqgm+s1JAlJMI2fNs6CB5DNK6WMS8dhnKMLkYVcwdkGyh2hxxqjEL1RTuXVCniuIdx1W
 iP2wn0riZMx/FqbOOBavuO+NPqY6LQtNvByITyCNsXzOSCDN6hTpjYot3N63ZFT94GVO
 Ar7Q==
X-Gm-Message-State: AOJu0YxVll8xSv6EclWhBScOe/849JJmr5XIMIknhCT37DshDqXzkZWZ
 Ha99cSutQYIcZ1YFbftRYmVdd9Aum02BE8aqKy3Ifp/U+87bNCatmqyfL5khByU=
X-Google-Smtp-Source: AGHT+IFnR+r2RoASsZvv37VifXjD2pKI1aJ6Y9aJFIX2LZDCqkCC/Qvu1j2Mp/2nofh5CoJeeoCJdQ==
X-Received: by 2002:a05:6808:601:b0:3bd:62ac:cd3d with SMTP id
 y1-20020a056808060100b003bd62accd3dmr7658056oih.47.1706601389070; 
 Mon, 29 Jan 2024 23:56:29 -0800 (PST)
Received: from [192.168.0.103] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 w22-20020aa78596000000b006db11bab9d9sm7055306pfn.202.2024.01.29.23.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 23:56:28 -0800 (PST)
Message-ID: <3b23e955-6bd4-448c-ac03-a320c55af72c@linaro.org>
Date: Tue, 30 Jan 2024 17:56:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/29] bulk: Access existing variables initialized to
 &S->F when available
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240129164514.73104-1-philmd@linaro.org>
 <20240129164514.73104-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240129164514.73104-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/30/24 02:44, Philippe Mathieu-Daudé wrote:
> When a variable is initialized to &struct->field, use it
> in place. Rationale: while this makes the code more concise,
> this also helps static analyzers.
> 
> Mechanical change using the following Coccinelle spatch script:
> 
>   @@
>   type S, F;
>   identifier s, m, v;
>   @@
>        S *s;
>        ...
>        F *v = &s->m;
>        <+...
>   -    &s->m
>   +    v
>        ...+>
> 
> Inspired-by: Zhao Liu<zhao1.liu@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

