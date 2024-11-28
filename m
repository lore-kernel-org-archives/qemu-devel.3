Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5EED70DE8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGil2-00046I-Eh; Thu, 28 Nov 2024 12:56:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGikw-00040z-JT
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:56:49 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGiks-0006ay-7t
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:56:44 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4668486df76so9938051cf.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816601; x=1733421401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gbk9zNTRWvQ0kfNgS/UtygsUp9mFp6nynvWCnTKiKK8=;
 b=Mp/pXiik8WcneVaJTl0f8JHavtBKXFvRA+fNEzAWXg2KbeSOTbkWXp0GhaRsTdFJlg
 YDY7Tj2O1RlnTcjYpuBMe9EOJMw2zZzQCWy8yy4ioszuWy3r9w2eCsuAkevGIubO1jRx
 RZf5KPudujAmc8Q9HNEVjsZ/VcVPCjMzjKvs66+/O3f6hl7MQYGWHYNuX0E+t2FbhneA
 YKMfziRU+Daalk3h+LqtDnusPtvElgXUI/QhThQXeQQ0vl9h0zS+ftLs9rNXFIvybtk4
 zcoxt47PJQ/gPCERvorhvKv3zr5fxQeUH568r93guwsuZp4N8gDyukz+kTP1riNiJg0j
 kK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816601; x=1733421401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gbk9zNTRWvQ0kfNgS/UtygsUp9mFp6nynvWCnTKiKK8=;
 b=abKT3pDdXUyMpXMIl2rlaFZbIQFTSmCu2kd7/E2zk/z1BkvsB3QjDxbngI8SdCCtmc
 GP5M4Bb+20DH55NPvkev8sPBcEyCWM1dT4LNJq4Y/QHXIonJgjKwzXUimdx2Jq50uffF
 /5ZWhqzkDnrkdSaNqezDKbMXixac3gV6YrgxAhiCIPZeAV6si8LWRYJmiaUZZZvNqDNC
 u1PEHxAgGkTysPGJnolZpwrpEjhZ13PckexjipNKoTdqheQzR3zwLY0K3sAFrbqic0M5
 cnsMJJHDmGbHnpQPGxoHmKgYn9ZQvcdgW/ApIOZHPEupOOFkgFh2gzf8xvdMEAAk3uuK
 oISQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlEW9uHlTRWQAbSf/gDr4tvcGcVMz+bHhFvoHwDAZCOhRemQoKMcRy128fP5RmV6m2HIqSwCv41zUi@nongnu.org
X-Gm-Message-State: AOJu0YwZ08dc6T/NHSIL6qhy24kgPfH+jRwRiZ1IE6LLhEdXRdFVEuYm
 0RncDQl7NYPIh4GmZIOtgcwAz/uurRE4OCbPqZE6FWOH/ZhNHqolT8yFsW8+GF4=
X-Gm-Gg: ASbGncvrYYPvdRMsKcztGPK+UnlI+iPVi4T6fvC4Hf5KhPXO9b27oUp75s8pmH6RzRP
 p+O2+UbteZpCDvLbL9RV9n6YwwWApvAqY/2opPD2HT6GCINVAB7S1PEEKWhej4uaW1PKqNoCTK6
 V91PqIS5Lns4C+T5KxgnAxXl8SMQHGRa1SAYqdgl4t0eB1FMyffkJNgeg2UQT1y1NLDIyj7coef
 b34ndUkJaIUcIYAqh6Jlo7towCudRteRWcUcwk7S6H6e+0naNC/66x9DnaAj2bv6R8=
X-Google-Smtp-Source: AGHT+IHLCUfnxR7Z3kUMRStVUMmM1R9Z0tKfrLSt7BWbIuQ13j+8m8q1B0qj5+CnTZLUd/ADEKsmQA==
X-Received: by 2002:a05:6214:2a3:b0:6d8:8256:41d4 with SMTP id
 6a1803df08f44-6d88256543bmr2300066d6.19.1732816599710; 
 Thu, 28 Nov 2024 09:56:39 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d87fe890a3sm2256766d6.29.2024.11.28.09.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 09:56:39 -0800 (PST)
Message-ID: <c70c6938-6b65-4506-9ddf-e353a00f14dd@linaro.org>
Date: Thu, 28 Nov 2024 11:56:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 23/25] target/i386: Set Float3NaNPropRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-24-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x832.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/28/24 04:43, Peter Maydell wrote:
> Set the Float3NaNPropRule explicitly for i386.  We had no
> i386-specific behaviour in the old ifdef ladder, so we were using the
> default "prefer a then b then c" fallback.  This is very likely wrong
> for i386, but in this refactoring we don't want to make a behaviour
> change, so we leave a TODO note.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/i386/tcg/fpu_helper.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
> index e9de084a96d..b62719dead1 100644
> --- a/target/i386/tcg/fpu_helper.c
> +++ b/target/i386/tcg/fpu_helper.c
> @@ -180,6 +180,8 @@ void cpu_init_fp_statuses(CPUX86State *env)
>        * against the manual.
>        */
>       set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->sse_status);
> +    /* Similarly the NaN propagation rule is likely wrong. */
> +    set_float_3nan_prop_rule(float_3nan_prop_abc, &env->sse_status);

Per my response to patch 11, this is correct.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

