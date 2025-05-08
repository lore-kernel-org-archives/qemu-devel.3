Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5DDC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 06:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCv0g-0001W4-0j; Thu, 08 May 2025 02:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCv0F-0001Lc-3d
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:45:08 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCv0B-000373-1R
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:45:06 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22c3407a87aso9164485ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 23:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746686698; x=1747291498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yfy5mykHWj27pG6feaUCRB9yiGjzfhsOa5Lf4n7V74w=;
 b=DOYPXXnknU4xANqSu68h3TtTkbWhAkA487Y1coxGvF4d+T4Va+7JBF2kNBnBLr5Q3j
 ytfmKAs37PSnQixV8aWIMWWyOqTglHPhlZN1vFVmOCAobTxQ3dg9LqR8NA/+BRYCv5Gu
 buC+DDke8dlDobJI1j/lh/RgDpisQ+gPsV6a/jGCcO/WzQq9stjqaGUDIHqvSVI9yVbF
 p8sVaqQ04Z71tgVJfBXNpN9+xDvXrIrgjmDcjHUOukFpmgrOk9+jYlVohqN8XT2C5XAW
 eSc05EQhVUJCDSZUvBuPRf40d3tVjz49ebiXmNokmVeppKikhZg395dceJqMxpCobNLC
 jTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746686698; x=1747291498;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yfy5mykHWj27pG6feaUCRB9yiGjzfhsOa5Lf4n7V74w=;
 b=q/0jU8vq26j6m3BojqZcx+ZOujBjsRrMgdUF3fRCe/fKbazLxeaEkCMxLkA+41+8Ad
 Fvog0LBjIyl6qd8rCyFJQGHs7FCDyVJ9etzOqKhG2nms1DgqBY5nWsFhG3srsfguwEv5
 Y/ozj5X/0qo401YPQJtqjtKxEAjIp18SiBAi2468jcVFTAjx5OcoOxH12qQDjSL+ZLfs
 doNdEsPyzTKmcqi2Ry12yuvq1RyuI7dA+udeD9K85AbUw/hv0gni3MZ3IR0ekx306lec
 Xw/mKaDeWjiAB3lHszaMUTnE3flFoJ+WF6v8Z0qJmpYPFFQTu5XOgR4hW+19bk3vLxTO
 CWtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXb/xrUo1jeJg1u04Slp/C+Rzq4Bq46oOg70YBHkoBpbFPlKrYpqQsrfV5345FZkrj9fkO7Qsyt7DQ@nongnu.org
X-Gm-Message-State: AOJu0Ywei7d3eEzWOXktAB7GEmBKX3Vp7WNqJxx0jbX8vjqBFL6iJP3v
 RPY+PvTKy6RP+jUsYtsSyp9vVm2QzQA1MN2/aPe1o5epCohClJ5yfh/onJHrhTM=
X-Gm-Gg: ASbGncvmNzjjzkHMm0n65nGf0vwhzCwlURbRu1KZP+zkgjU2Z66J2N8fvberaiFmW2o
 B15BFfl+s4m83fQe4T4rbFhVgcNgmENz1HfW9kfrJvf0b46pb+EOwvPfyixWPPK4mRJ9XRyS53s
 i4cCoHmEBMvC9uIfjze8MGI/H5VdOMF9VHMyDMgpj7yaHRdNAvfZavpY74zNvJKR9bIUY3LbWuv
 Opl9PCCEcYYEvkPeXrZDkHjURQ436JqmMbdT2HSnHv2rIbIz5bH8ysP56K843QvsKnjz9/3ATPn
 DcSKnfU3+uwsd1w4rUfU4AQ17PraOPklgs3ER47Zh4Av0ua3AFAvuSzm1iSNScUdM6S8tmjtkX4
 9l8IMhIdHhktMbI8LH+A=
X-Google-Smtp-Source: AGHT+IFKe68c8IGRkXvQrj1mrBsPZUMmqpQehnTGFli/dsXyBQbOyiKW6zZGX0watg2p7Yi9H7x6kQ==
X-Received: by 2002:a17:902:ca0c:b0:22e:1a41:a6de with SMTP id
 d9443c01a7336-22e8dc8f32fmr24127615ad.32.1746686698339; 
 Wed, 07 May 2025 23:44:58 -0700 (PDT)
Received: from [192.168.69.243] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152204desm105163815ad.140.2025.05.07.23.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 23:44:57 -0700 (PDT)
Message-ID: <5aa46045-c344-495f-a9a2-692a1102bbaa@linaro.org>
Date: Thu, 8 May 2025 08:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] qapi: transform target specific 'if' in runtime
 checks
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, berrange@redhat.com,
 thuth@redhat.com, Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-10-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250507231442.879619-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62b.google.com
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

On 8/5/25 01:14, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   qapi/machine-target.json | 84 ++++++++++++++++++++++++----------------
>   qapi/misc-target.json    | 48 ++++++++++++-----------
>   scripts/qapi/expr.py     |  9 +++--
>   3 files changed, 81 insertions(+), 60 deletions(-)


> @@ -378,13 +384,18 @@
>               'typename': 'str',
>               '*alias-of' : 'str',
>               'deprecated' : 'bool' },
> -  'if': { 'any': [ 'TARGET_PPC',
> -                   'TARGET_ARM',
> -                   'TARGET_I386',
> -                   'TARGET_S390X',
> -                   'TARGET_MIPS',
> -                   'TARGET_LOONGARCH64',
> -                   'TARGET_RISCV' ] } }
> +  'runtime_if': { 'any': [ 'target_ppc()',
> +                           'target_ppc64()',
> +                           'target_arm()',
> +                           'target_aarch64()',
> +                           'target_i386()',
> +                           'target_x86_64()',
> +                           'target_s390x()',
> +                           'target_mips()',
> +                           'target_mips64()',
> +                           'target_loongarch64()',
> +                           'target_riscv32()',
> +                           'target_riscv64()' ] } }

I'd keep target_riscv() for "any RISC-V".

target_arm() and target_aarch64() could be merged as
target_arm_based()?

> @@ -272,7 +272,7 @@
>   { 'command': 'query-sev-attestation-report',
>     'data': { 'mnonce': 'str' },
>     'returns': 'SevAttestationReport',
> -  'if': 'TARGET_I386' }
> +  'runtime_if': { 'any': [ 'target_i386()', 'target_x86_64()' ] } }

Suggested as target_x86().

>   
>   ##
>   # @GICCapability:
> @@ -297,7 +297,7 @@
>     'data': { 'version': 'int',
>               'emulated': 'bool',
>               'kernel': 'bool' },
> -  'if': 'TARGET_ARM' }
> +  'runtime_if': { 'any': [ 'target_arm()', 'target_aarch64()' ] } }

Up to here:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> index 5ae26395964..f31f28ecb10 100644
> --- a/scripts/qapi/expr.py
> +++ b/scripts/qapi/expr.py
> @@ -638,7 +638,8 @@ def check_exprs(exprs: List[QAPIExpression]) -> List[QAPIExpression]:
>   
>           if meta == 'enum':
>               check_keys(expr, info, meta,
> -                       ['enum', 'data'], ['if', 'features', 'prefix'])
> +                       ['enum', 'data'], ['if', 'runtime_if', 'features',
> +                                          'prefix'])
>               check_enum(expr)
>           elif meta == 'union':
>               check_keys(expr, info, meta,
> @@ -654,7 +655,8 @@ def check_exprs(exprs: List[QAPIExpression]) -> List[QAPIExpression]:
>               check_alternate(expr)
>           elif meta == 'struct':
>               check_keys(expr, info, meta,
> -                       ['struct', 'data'], ['base', 'if', 'features'])
> +                       ['struct', 'data'], ['base', 'if', 'runtime_if',
> +                                            'features'])
>               normalize_members(expr['data'])
>               check_struct(expr)
>           elif meta == 'command':
> @@ -667,7 +669,8 @@ def check_exprs(exprs: List[QAPIExpression]) -> List[QAPIExpression]:
>               check_command(expr)
>           elif meta == 'event':
>               check_keys(expr, info, meta,
> -                       ['event'], ['data', 'boxed', 'if', 'features'])
> +                       ['event'], ['data', 'boxed', 'if', 'runtime_if',
> +                                   'features'])
>               normalize_members(expr.get('data'))
>               check_event(expr)
>           else:

Changes in scripts/qapi/expr.py seem to belong to a previous
patch (existing or not).

