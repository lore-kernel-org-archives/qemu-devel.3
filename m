Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947C2C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 06:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCv8r-0001Uk-5w; Thu, 08 May 2025 02:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCv8p-0001Ty-L6
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:53:59 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCv8n-0004Ry-Ff
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:53:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22fa47d6578so3129875ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 23:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746687236; x=1747292036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pYxMnRoZedvA/ep62BqWbJIDQkqEHhWEek3uqLADE1Y=;
 b=gvNsaI8v/nEIxxd2+WbYbxoTnWKfq8mpiIjR3IRCi0HLhn5C6gWQFW4elymSucQ8pt
 Gmhk7eB/Nog2Szr/7+j7PiJd0LsKi5yvBLAK6OpDW0I+2sF1zFEoTLiIQUlwNXz3t1pb
 JY6jyA4s0CdwhFLnik6tLFJdslXhlk7z6bGWhJIx7ZHijZww1YVdUmQkJgqWVjulK8hb
 NcCkoQ4MI04oma85FUZ6BdGZwwR49mhqmBPFtorW0n8YGMZ4q8TYAZY3mAtEmS1uZe+l
 jAMw3gAFNEMkBePs7eHcF3899lshFVmFa7bvOprJprKqUsLpng7Hgdn/cQpTn32EOKWR
 F1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746687236; x=1747292036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pYxMnRoZedvA/ep62BqWbJIDQkqEHhWEek3uqLADE1Y=;
 b=Ka+3o0MszE8wvnbyWQSxhm23Qx+Hz5Yi3aZdloXxkfWpdXdutUXMcp4u5s3oZqdmk/
 0bWHrgjZLbCrMPs/rLLTaRCDO2bMbw6Z+lPs8pLO6IOQLP0TiW6ry72SyV15/+htUDeE
 UyNEOQlV+btGMQaavvq1xBCORN4Nm9FJgs6/ZEiC2g4lgsBHxxdcQZIh7j7Bzs25jPQN
 Q98l5BkpiGpQkVTnicOjwROTFYGSVmn45+c7baPrC1TqedK4SkS1Vy6bvT9DbcHapx7m
 gXLLwmAYRU8eLkjrEaqTaapniDrc928NqZLYTdKqh0FtuStu1JsYhXP3xvzmbdZTRJJh
 6eEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAXmsPjZ3sy9zkd2bEzU8LpehsiVh4Q/l1GK/q0SFlnvsnO5rsLLNTD5Y2DagxE1ci25/HvQVfqvb2@nongnu.org
X-Gm-Message-State: AOJu0Yx3H1ujoy3OnfSuq9i6Q4s9ZxiI9AqtJX2s+PWaSKcGm/KnyZ5n
 koGLV5G8zASb4IWcRdmTVUAF6WrOBGSDBy0Y4oI7NiZZxsz+PvrhXiL+0EDVk2M=
X-Gm-Gg: ASbGncu0LCi9lOT5btDRN+lRxULR96L0QnUeqF1a0ACdllOwQtNrwDx7leK2fCiJKOw
 DPMP382CRd0Y0zIgk77hwplW0fc+g7PqXkG/XJd+3pEI3oM+ThHW1hR556Dp1FHBW5qQzjJfio5
 7fXUhNUP6o2iFZQIp0LQ+85yAULNdDIWp2EWheFtkSIX6HhBdXGoxj/iQTT3eHteU3a2iXS3a88
 cDjQ0gDYV85V8fX/WLTpIWj16mVGXS+3g1PedmgBZbbo2528vRll3QeJguxkKs2zOzuih3bGiBw
 c9Qjvt64ZoNubFEzCq11GO0jDJxPWuKl5sqHA/YYb6pXM8quWmHSzWi+nbYq+YLkNWYx0WVSNpY
 aUskL5fPV
X-Google-Smtp-Source: AGHT+IEcy7TzJVBSRJcD7PTGNF6tnGaqyHn8UeIRFlhFQC3zwNNN/4TiVpR4SJX7IVGXFDRr08qdtw==
X-Received: by 2002:a17:903:3ba7:b0:223:501c:7576 with SMTP id
 d9443c01a7336-22e5ea4945bmr88929615ad.12.1746687235667; 
 Wed, 07 May 2025 23:53:55 -0700 (PDT)
Received: from [192.168.69.243] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e15228fcdsm105838735ad.183.2025.05.07.23.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 23:53:55 -0700 (PDT)
Message-ID: <5fe18831-d9b8-4c64-883d-17b9c600ca61@linaro.org>
Date: Thu, 8 May 2025 08:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] qapi: introduce 'runtime_if' for QAPI json
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, berrange@redhat.com,
 thuth@redhat.com, Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250507231442.879619-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x631.google.com
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
> This new entry can be used in QAPI json to specify a runtime conditional
> to expose any entry, similar to existing 'if', that applies at compile
> time, thanks to ifdef. The element is always defined in C, but not
> exposed through the schema and visit functions, thus being hidden for a
> QMP consumer.
> 
> QAPISchemaIfCond is extended to parse this information. A first version
> was tried duplicating this, but this proved to be much more boilerplate
> than needed to pass information through all function calls.
> 
> 'if' and 'runtime_if' can be combined elegantly on a single item,
> allowing to restrict an element to be present based on compile time
> defines, and runtime checks at the same time.
> 
> Note: This commit only adds parsing of runtime_if, and does not hide
> anything yet.
> 
> For review:
> 
> - I don't really like "runtime_if" name.
>    What would make sense, IMHO, is to rename existing 'if' to 'ifdef',
>    and reuse 'if' for 'runtime_if'. Since it requires invasive changes, I
>    would prefer to get agreement before wasting time in case you prefer
>    any other naming convention. Let me know what you'd like.

Or rename 'if' as 'buildtime_if'. /s!

> 
> - As mentioned in second paragraph, I think our best implementation
>    would be to extend existing QAPISchemaIfCond, as it's really
>    complicated to extend all call sites if we have another new object.
> 
> - No tests/doc added at this time, as I prefer to wait that we decide
>    about naming and proposed approach first.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   scripts/qapi/common.py | 16 +++++++++++-
>   scripts/qapi/expr.py   |  9 ++++---
>   scripts/qapi/gen.py    | 56 +++++++++++++++++++++++++++++++++++++++++-
>   scripts/qapi/schema.py | 44 ++++++++++++++++++++++++---------
>   4 files changed, 107 insertions(+), 18 deletions(-)
> 
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index d7c8aa3365c..0e8e2abeb58 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -229,6 +229,8 @@ def gen_infix(operator: str, operands: Sequence[Any]) -> str:
>   def cgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
>       return gen_ifcond(ifcond, 'defined(%s)', '!%s', ' && ', ' || ')
>   
> +def cgen_runtime_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
> +    return gen_ifcond(ifcond, '%s', '!%s', ' && ', ' || ')
>   
>   def docgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
>       # TODO Doc generated for conditions needs polish
> @@ -242,7 +244,6 @@ def gen_if(cond: str) -> str:
>   #if %(cond)s
>   ''', cond=cond)
>   
> -
>   def gen_endif(cond: str) -> str:
>       if not cond:
>           return ''
> @@ -250,6 +251,19 @@ def gen_endif(cond: str) -> str:
>   #endif /* %(cond)s */
>   ''', cond=cond)
>   
> +def gen_runtime_if(cond: str) -> str:
> +    if not cond:
> +        return ''
> +    return mcgen('''
> +if (%(cond)s) {
> +''', cond=cond)
> +
> +def gen_runtime_endif(cond: str) -> str:
> +    if not cond:
> +        return ''
> +    return mcgen('''
> +} /* (%(cond)s) */

No need for extra parenthesis in comment:

   +} /* %(cond)s */

> +''', cond=cond)
>   
>   def must_match(pattern: str, string: str) -> Match[str]:
>       match = re.match(pattern, string)
> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> index cae0a083591..5ae26395964 100644
> --- a/scripts/qapi/expr.py
> +++ b/scripts/qapi/expr.py
> @@ -392,7 +392,8 @@ def check_type_implicit(value: Optional[object],
>                            permit_underscore=permissive)
>           if c_name(key, False) == 'u' or c_name(key, False).startswith('has_'):
>               raise QAPISemError(info, "%s uses reserved name" % key_source)
> -        check_keys(arg, info, key_source, ['type'], ['if', 'features'])
> +        check_keys(arg, info, key_source, ['type'], ['if', 'features',
> +                                                     'runtime_if'])
>           check_if(arg, info, key_source)
>           check_features(arg.get('features'), info)
>           check_type_name_or_array(arg['type'], info, key_source)
> @@ -642,7 +643,7 @@ def check_exprs(exprs: List[QAPIExpression]) -> List[QAPIExpression]:
>           elif meta == 'union':
>               check_keys(expr, info, meta,
>                          ['union', 'base', 'discriminator', 'data'],
> -                       ['if', 'features'])
> +                       ['if', 'runtime_if', 'features'])
>               normalize_members(expr.get('base'))
>               normalize_members(expr['data'])
>               check_union(expr)
> @@ -659,8 +660,8 @@ def check_exprs(exprs: List[QAPIExpression]) -> List[QAPIExpression]:
>           elif meta == 'command':
>               check_keys(expr, info, meta,
>                          ['command'],
> -                       ['data', 'returns', 'boxed', 'if', 'features',
> -                        'gen', 'success-response', 'allow-oob',
> +                       ['data', 'returns', 'boxed', 'if', 'runtime_if',
> +                        'features', 'gen', 'success-response', 'allow-oob',
>                           'allow-preconfig', 'coroutine'])
>               normalize_members(expr.get('data'))
>               check_command(expr)

Why can't we merge here the changes from patch 9?

-- >8 --
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 5ae26395964..f31f28ecb10 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -638,7 +638,8 @@ def check_exprs(exprs: List[QAPIExpression]) -> 
List[QAPIExpression]:

          if meta == 'enum':
              check_keys(expr, info, meta,
-                       ['enum', 'data'], ['if', 'features', 'prefix'])
+                       ['enum', 'data'], ['if', 'runtime_if', 'features',
+                                          'prefix'])
              check_enum(expr)
          elif meta == 'union':
              check_keys(expr, info, meta,
@@ -654,7 +655,8 @@ def check_exprs(exprs: List[QAPIExpression]) -> 
List[QAPIExpression]:
              check_alternate(expr)
          elif meta == 'struct':
              check_keys(expr, info, meta,
-                       ['struct', 'data'], ['base', 'if', 'features'])
+                       ['struct', 'data'], ['base', 'if', 'runtime_if',
+                                            'features'])
              normalize_members(expr['data'])
              check_struct(expr)
          elif meta == 'command':
@@ -667,7 +669,8 @@ def check_exprs(exprs: List[QAPIExpression]) -> 
List[QAPIExpression]:
              check_command(expr)
          elif meta == 'event':
              check_keys(expr, info, meta,
-                       ['event'], ['data', 'boxed', 'if', 'features'])
+                       ['event'], ['data', 'boxed', 'if', 'runtime_if',
+                                   'features'])
              normalize_members(expr.get('data'))
              check_event(expr)
          else:
---

Otherwise, patch LGTM :)

