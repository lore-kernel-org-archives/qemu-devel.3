Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2612ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Pb1-0005gJ-3g; Thu, 02 Oct 2025 16:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Paw-0005ZN-TU
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:08:08 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Pao-0001jm-Ph
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:08:05 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-77f68fae1a8so2012566b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759435673; x=1760040473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gL0xpwJVKDEF87rBOGH2e/3SaWeAc6VUM5HjcGW8o3g=;
 b=eHlC2UF8nrOoCppaP9mP/sz5sWPoXC8UXNgsOjJhncdvQF15zVFBzD25TxhygCy/c1
 GdWdj9jMLW+pk0u7t031YBNljryBDr+5XXHeDknV6mdwlRvdWrpLm+/qO/P+E2yz7YvW
 4pi5eGbpNN4jB7rHBIAgQ2HXLxpBXYRS3pGO3knXr09o1rm8saY9gsy/VxkU7BCG8SV7
 K02Ey4JnZc/Dca9YebtBCC/Eb9PqQ69qIJgfU7i5GWY0XLLbpWBP0D3SpKCzcvOv2ag0
 Td1aDA4QV2v2fbAgndHHQdluDZsJ9is+VbuweGiNDDg0oFiqVjLjkkf1Ay3aTgtOfq6a
 kq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759435673; x=1760040473;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gL0xpwJVKDEF87rBOGH2e/3SaWeAc6VUM5HjcGW8o3g=;
 b=Rrpf8yaTvdSo1gt6POsHC16HwO1y483lwErE1diIU8iQpqLqbsz+GUokvcR+B5FTmx
 BE0I/VSEu/cmmoDi+n9NgBwFz+6zMfjYBoObDHEwRorCTa6gZOwjo01VR3jVIgTC5+vT
 w9eKSSGbijC4BM7brSnz98o4a8j+FBu6uUv+ZhpLR7/nB+FRdoAzQRyH9ySk+fpwPzHP
 RqXH9jSts0H2vjodLvroAKFA3g+QobV1O4kKz0qUsn+pxiok+02w8BHS1EJkr/tWnI1n
 DhZqQ5Ir5c7OhrVmGiIXJFqQO9ov2fC5uyyx52tNeYpxu0KGzFB7QtEXBmhABBbVdbg/
 Jxzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjsbgISs5xso1K/ffpoS37SvaUBJ+ldFFC6JRIArxlvC9foQlQg8lQ6cg1dEbA0pNovjjeZKYF+KAP@nongnu.org
X-Gm-Message-State: AOJu0Yy6Pc4VaQMIkXBnBrenZ74uw0yWW+PKaV+fa+9hhalN6cPCw8ln
 QQ8OvUFjmhh2oVc/+7FGuUjYtcZW9C3Dgwq/UvniIW5r9z6XFnARtM2SQDqYnhUbZuo=
X-Gm-Gg: ASbGncvsHDCOI+qPjc4+1yGd7K64Qaq2zSn2MBYM0PHMb+Dde1pC+aZ0z6/wvrlkuwH
 nN70wPPXNfwiiWxrtcsyOf979XPODnZOAE4vEMoT+fV8KM7zVyGcoVluTM7UpOBu31oglgOH2Zz
 RpvyZ5gtEhGr+1akfZ4MxUJwqKayfdU4W9v7XHjG8+6c9zAOE9oDB/zUGMBDwqtQ+DYMbb3rB+r
 JDP4eW3Pp4yoRRFfmoHYsKYewx7c+3hD0H02mqG4Fd57HRFFeH8/Fyq38iHrsoe7ghvB1mXNKL0
 rAgtcyVPNvcuyxcHIt53hMF6J3rOmLKQZUDkjq8Gc+0zLCzLThTqaE0Fur0/QoJOk37XlOgy5nW
 EfnXNheT2AovCJK2WHmMMoylY/v5MxFh+xUGVg3HUGsztcJiAqMVmNhQ1nfzSkeE=
X-Google-Smtp-Source: AGHT+IHYWTJ/3yLPJXYEKEfGUChsV2Ssqjx/pIJqF8PNKkz7pHQqSfNOSeyHyrDkICfbb7bHq2WvXQ==
X-Received: by 2002:a05:6a20:914a:b0:246:7032:2c1d with SMTP id
 adf61e73a8af0-32b61e5e6fdmr814104637.23.1759435673160; 
 Thu, 02 Oct 2025 13:07:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099ad9405sm2675660a12.10.2025.10.02.13.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:07:52 -0700 (PDT)
Message-ID: <b6027bac-e56b-412b-9ca6-ed3c3e349b98@linaro.org>
Date: Thu, 2 Oct 2025 13:07:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/33] target/riscv: Fix size of priv
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-21-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-21-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> The priv field of CPUArchState only stores values in the range [0,3],
> fix to 8 bits in size and update relevant function arguments.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h        |  8 ++++----
>   target/riscv/cpu_helper.c | 10 +++++-----
>   target/riscv/machine.c    |  2 +-
>   3 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


