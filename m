Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE0DE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 22:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIyAe-0004Os-IF; Wed, 04 Dec 2024 17:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIyAc-0004OR-7v
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:48:34 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIyAa-0003dB-NC
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:48:34 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21583cf5748so2800425ad.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 14:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733352511; x=1733957311; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fQCY2Bfjo/BJXVCiqwOMtNMrqKhTkrl1N+PYKrRq6bQ=;
 b=YI8Wl4pRjwwSKSecZgIudECIFJGSao4fgBDDcNQmJRUUqhIvIu8LbxhlPkrpL2L/bG
 Qq8WbhwrzHNoFED0sXirxCFjrhhmk4Nx/fcEt9lQ/wO++0wTAG/EYBEvJ8ooBaWRBcgy
 P4QqpJ5VZpx00s0OykU9gn2BU3RhQ/X+BZWd6qp+8v3qK5Sw7F3lxoWZBvU+a50jVolA
 7rx84gUYsyn8J9T7sCq8VsMkNbn7eYcXPrfGT5INXTngOJOUFJUlUi0OX2EBN/eNcAZn
 wBVg41OByh4P9poO/3hgz1bDLbDmE75Ub/m2BoliC0K2gg9F+a1flKQYgFFlOxWen472
 mnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733352511; x=1733957311;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fQCY2Bfjo/BJXVCiqwOMtNMrqKhTkrl1N+PYKrRq6bQ=;
 b=NqZfgTENLD+AFTXDCp99tW4XqnWHcJkLyOb0TKvaXHnXoCEJ2Q1HZ9Rji+ZQwYGam8
 AnG5RvBpFnuVJdWGGD9AfORL1c3p69fDd/He4tcPlGhhzo3krs694PiAoCCtCuFYqe3t
 DXb8unFWKeayNClpFvjx7+46NfDEfsXrSyAel+qdE7UU+dXe1OhE2N9Y1Pv9EGivGf9i
 8OwoWKDoNZcxkvHiAQfO71lTPf/M1pr+nzCOP67cQ/EIzi8aD38K2fJVo0VjxhMvotaM
 fyO0YYZilUMR5QnEysr7OHUpNV6XZe1ZedFxHp8rIxat/cRmo97gSwekVjAjTZjSWOau
 etrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+k8zwJwxG2sntp0X+qmOomb/YUHqfNfGK2EOwB00zBsW970AaUoW1x98dy5sH4q4z49RKWkAYTtdF@nongnu.org
X-Gm-Message-State: AOJu0YwhD800DgiUl39xgUc6y4Nartq5bBjL0KY3Eke/vAXiooE+9QXd
 za8xbr2gonbBhYLz8vlFWgdnCUKDQW/2z9fftbfnzzTJyt+GiSJKoF3EiTY6kXc=
X-Gm-Gg: ASbGncuHiHdJxibsaIAwDyPrH4oT5SKWhwsKFObuQqJlYkH1wR5+Cd4U/baI+omNOiE
 +f61arTr6wsHsR+p8a7slua7ZxQsCbXvyGr1Qy3/Y0qhiC+MmWq3gmpFVBTDIJdHmIw6FwAG71r
 s3G5wnyZK3WySmsRpupW04hq1ulwtzYElZgvak0D56r7Y3UdZ3zSXQACBqN0UyudKQRb3v8rpeK
 Rco29krEiwlXHwd/sxOFtMSsinNmKpWDgjWFmXkcIf83Knm9jM4oof2QYHCbP9tPY3giW9H/EaK
 IA0p3zQD39UfWSQNQvoMKw==
X-Google-Smtp-Source: AGHT+IHjBXPJHlLNzob1SuGcYO5EtxmToJA9tEc6XKs8EIM5GjjPF+NCNnC3rs7vD1ZxLWjfMGSaHw==
X-Received: by 2002:a17:902:ce83:b0:215:a2af:44ca with SMTP id
 d9443c01a7336-215bd16f932mr98536315ad.37.1733352511087; 
 Wed, 04 Dec 2024 14:48:31 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8e3e899sm578805ad.34.2024.12.04.14.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 14:48:30 -0800 (PST)
Message-ID: <2bb0e7ff-e051-4f25-8379-82a648955c88@linaro.org>
Date: Wed, 4 Dec 2024 14:48:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/11] target/alpha: call plugin trap callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <ac63748891b7bd24b8ccec1d0cfb54986eaf8b3d.1733063076.git.neither@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ac63748891b7bd24b8ccec1d0cfb54986eaf8b3d.1733063076.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/2/24 11:26, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for Alpha targets.
> ---
>   target/alpha/helper.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 2f1000c99f..acc92402af 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -25,6 +25,7 @@
>   #include "fpu/softfloat-types.h"
>   #include "exec/helper-proto.h"
>   #include "qemu/qemu-print.h"
> +#include "qemu/plugin.h"
>   
>   
>   #define CONVERT_BIT(X, SRC, DST) \
> @@ -326,6 +327,7 @@ void alpha_cpu_do_interrupt(CPUState *cs)
>   {
>       CPUAlphaState *env = cpu_env(cs);
>       int i = cs->exception_index;
> +    uint64_t last_pc = env->pc;
>   
>       if (qemu_loglevel_mask(CPU_LOG_INT)) {
>           static int count;
> @@ -429,6 +431,16 @@ void alpha_cpu_do_interrupt(CPUState *cs)
>   
>       /* Switch to PALmode.  */
>       env->flags |= ENV_FLAG_PAL_MODE;
> +
> +    switch (i) {
> +    case EXCP_SMP_INTERRUPT:
> +    case EXCP_CLK_INTERRUPT:
> +    case EXCP_DEV_INTERRUPT:
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc, env->pc);
> +        break;
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc, env->pc);
> +    default:
> +    }

Does not compile with clang:
../target/alpha/helper.c:442:13: error: label at end of compound 
statement: expected statement
     default:
             ^

>   }
>   
>   bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)


