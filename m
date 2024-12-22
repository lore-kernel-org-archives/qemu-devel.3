Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14293E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 22:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPUnK-0002aU-1g; Sun, 22 Dec 2024 17:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tPUnH-0002aB-58
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 17:51:28 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tPUnC-0001Am-1Y
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 17:51:24 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2efd81c7ca4so2676336a91.2
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 14:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734907879; x=1735512679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9O5asO7pYq/pHHiRROp7oqru8ZWyu6V95BNoLY8F+aI=;
 b=UkQXKKfKGGRc66RZClX4a8y2hU1s/WGbQ/jL2NgFR/2d44VbMfBKTGsX5tc7V4AU0M
 2HOm9rasbfHbq4znZE3O5uOXCjrCsrBIys7XxlLsIXHk7C2l9CNEAou1jBnm4H5wbItJ
 p27pny1BgKINf5ooBzHFPNZCqPQNQ26n9DkQK3Z1llG6vuTiCuHnsnyw2nvvmnLIMxRk
 GT/Yb+ymQhJN/n5OywuT25xSCQDcCwoNiaWQ6tFx44HGJTKnu1Pxxg/RrlGsmtzavQgT
 yr2nYeoVhgr9Cc30snQ/YPgq0lcni6qz5+JKT5VO5RlzY9tUxCOezQwVI0VuvQAEgXnY
 Kw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734907879; x=1735512679;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9O5asO7pYq/pHHiRROp7oqru8ZWyu6V95BNoLY8F+aI=;
 b=KjqxCWZniQ7Fl7ehbHd9xRHUwRKFjkweO40MYdfp7njn3fPX5pf/IndSwyUQGc4rQU
 3T8I8It7RbCxQ+Td/XOrVuM7rFZhvZpkLREGjGx7hmo0fdJS92XZsCQoYZN7z7Ovai1J
 9ki8CjbZ5j5Rm3ch6kfYqr9pluEv/R/E6Rz5SKGAKVzMR8La4rXUsUUX8xGwjvOAS14G
 5oKIdLz1ONAHyVTs1smUVUK/9VhjzooWVFTFLyYgUeeDl5s6jq9hCKTr7V5Y22uy0xmH
 EMCClgqPjsFwNZvWUiNdw1IYfPKy5yok2hcuYMjcjTudq+Kn7JuH3AzzvpAChnEd+tMW
 KEzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4/vS5PsBYF/aOJq4m8vmDJDkuRPP368ID87F5vWQMHiL7ofa/ROpxb291nDZq0Ei1NO0Zjw7bDej4@nongnu.org
X-Gm-Message-State: AOJu0YyBn4ZLNK5ytf9m2aiMt6YjEurBJCYd1rwIuOBCLEU4dcZI2qdS
 oXIqUNtd71zYq44mm3NrazxOVkmaNy8B0rfCCcADx5zmrrBemAVhB5UiSmhg65s=
X-Gm-Gg: ASbGnctfd2rY21PV+oeEHIG3KirweQ2mUZz0z6vgIxInp3bSWOSvjGNJz6wQyWYEMjV
 IF2/xGwt8ayI22oNd5cMwwl3IDhMyrNHY8qIlqb8FnEoGZP0sm2qpIPq5CptyBEh/967Re+tWdQ
 S4a2iLsdVMvDXNae4fY19Nt75nwQXXbU538f1548Jz+YWoDLTpiokDjpYu/Bt+zr4ZE4gxofU+b
 SX8+TdfRc73yyM5RjxFVGorNsc6c6sGIahrQYmjo0Odfmpx3NoL5CrWXIDdFhrNx0gdTw==
X-Google-Smtp-Source: AGHT+IF6eO24UJw77C1AD54w7rcWghttUwpJzai3v1vqxSE6zf5Rr2e67jSZM3idN9hrI8bDUWI4zQ==
X-Received: by 2002:a17:90b:2d88:b0:2ea:7fd8:9dc1 with SMTP id
 98e67ed59e1d1-2f452e4c515mr15142434a91.18.1734907879206; 
 Sun, 22 Dec 2024 14:51:19 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d97casm61116385ad.138.2024.12.22.14.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Dec 2024 14:51:18 -0800 (PST)
Message-ID: <d0e08dc6-b4c1-4c14-9aff-5e726f04792a@linaro.org>
Date: Sun, 22 Dec 2024 14:51:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/bbv.c: Start bb index from 1
To: Michael Tokarev <mjt@tls.msk.ru>, ckf104 <1900011634@pku.edu.cn>,
 qemu-trivial@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, QEMU-Devel <qemu-devel@nongnu.org>
References: <20241217142413.148978-1-1900011634@pku.edu.cn>
 <514c2c90-4c0f-486e-857d-fa0360c47d38@tls.msk.ru>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <514c2c90-4c0f-486e-857d-fa0360c47d38@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

On 12/22/24 01:11, Michael Tokarev wrote:
> 17.12.2024 17:24, ckf104 wrote:
>> Standard simpoint tool reqeusts that index of basic block index starts from 1.
> 
> While this patch is a trivial one-liner, but the underlying issue requires at least
> a minimal understanding of what it is all about, what *is* bbv to begin with, what
> `simpoint' is.  I'm not sure it really is a trivial material?
>

This fix is alright.
This plugin generated data for a binary analysis tool (named Simpoint) 
that needs specific data named basic block vectors (bbv).

I didn't use it myself, I trust this change.

>> Signed-off-by: ckf104 <1900011634@pku.edu.cn>
> 
> Do we accept such SoBs these days?
> 
> Thanks,
> 
> /mjt


