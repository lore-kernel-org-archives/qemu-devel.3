Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB49C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 12:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJAFl-0003fQ-Rz; Sun, 25 May 2025 08:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJAFi-0003To-5s
 for qemu-devel@nongnu.org; Sun, 25 May 2025 08:14:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJAFf-0004GC-Ij
 for qemu-devel@nongnu.org; Sun, 25 May 2025 08:14:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a37ed01aa0so1403884f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748175289; x=1748780089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HC4+8jv2HrKM09LaPMBSXOMG6oZUIk57suQ7NRJvMLg=;
 b=AVKHYg0pROCl9CNmsOCytNdsQt9xDLm337A7Dkqv0MVPxoAm1QOCZ3cNgJDfzyokXs
 DODQcCEI9gsQgacjKaMacdHxRgT8uoRaURGhpB6/nX5k6j8jIjFKdDTptAcTXMuw5K2c
 Hd6gQ55Dyg5YnVDYxq4c1i0dcIHKwqwP6xEnEL4USBmciopHO+q6Ury8ecbykr3pyqHj
 fB7Y5oj59g8KabpdDfz9vrPjFuxN9PHmFwwWkzkUHcfdpBKFa1hNp6YQR5/fXM9UKK9Q
 P26jN4vaqpsDDQcbnpCbVci7AiQaOduCMn2QHCsUtx6i+9rPyTt6vhKnTg44VCNBeZM/
 m/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748175289; x=1748780089;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HC4+8jv2HrKM09LaPMBSXOMG6oZUIk57suQ7NRJvMLg=;
 b=PA9+eKbuZZo5P2JV/kvzSvyX14eOzE3Zdwt4Gneh7Ue/es4x59iQB9ec7znrWY27Lq
 pV+53qZueGex2bp5VVNKOrwADjFGu98n4NAlrCjyFXxHTPHWKFRZcIF5UE1CzuoNwKG5
 8HL0nyNSOiWG7LlaOrdCBwWqQHy0JmIeVLQq0qCSwiFvsW22wLwuDyp6Qsz7UOn2pdk4
 o7lK1PhTwwU5G2SCP0Vuorf48wZFIPv548Iq985n1bp62L94eY7leLLmStBtg7FGYmtf
 hizRQdTj9hDsrxVwSheYnn5EeOUix5i/tazBlcdwm0x2JOsLbWkSIoIQykyu/m5hTB6/
 3Mfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAQeqAaBwrCM6vlbH1mYNB6qoYaBI1riRHg9BNor9Vw0JYAjPblRZeG7+qlbOmeM8dlQFcJP0a4cjC@nongnu.org
X-Gm-Message-State: AOJu0YwZ0WpfKDSOiE7MIyWNZ7w3L7Rolw6COfhUjlil7BLL82nOd0ia
 1dFWvSER2TVisD54t3QF+N9pkwyLPq33OHvnbHq88NAMJz4EPOyWtJDBYXBl8u+gVZES5r9h6Sf
 ZRKLzG6o=
X-Gm-Gg: ASbGnct/EP8hs9LbB5IRNBBEJtps8tA1f9CHvuJJb33PgWIgdFelcPAd+HFF+Wxjlo7
 u+WSFWPy7AYyeQnmv/3XgtiC9/HO4IVM7JhMeeNkCq/C+HGeZbyi6L3LCAQwf+K4F6npRnkPOuE
 ZrRA5N0SpSyLCeFpprAMlqNnpPCslUUmiLOgp/75COi0ATwTR7iKbfZQHVm0avGzxwih3ZfAhNt
 xwxeSdqZxNiGfQvQ3XN3bhuH7ZTzdtQm343CjcpxoRj69o9JuToa5v6r9mUvoxckY/N/YHGqTC7
 TLrkQ6VzxAWJrDweobJ0SyZ+n7qjEyuGvXlsGh+xZVWYZ/CIzvTL54R1vgLNRlYOYw==
X-Google-Smtp-Source: AGHT+IHfXhGiTOmcSX1CORQi7Tzy9Q0+xoycaTwGzx2H8N3RG1YbnxhJZX5tdWp5Q8048Ug+HEJQIQ==
X-Received: by 2002:a05:6000:2082:b0:3a0:7b07:157 with SMTP id
 ffacd0b85a97d-3a4cb4280e1mr4554851f8f.9.1748175289304; 
 Sun, 25 May 2025 05:14:49 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f3dd9c65sm214598535e9.39.2025.05.25.05.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 05:14:48 -0700 (PDT)
Message-ID: <f140b06d-53c7-4d32-ab95-1327d2659a37@linaro.org>
Date: Sun, 25 May 2025 13:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/25] target/alpha: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <a5ec8863418a946530d167677184d40319470af2.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a5ec8863418a946530d167677184d40319470af2.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for Alpha targets.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/alpha/helper.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 096eac3445..a9af52a928 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -27,6 +27,7 @@
>   #include "exec/helper-proto.h"
>   #include "qemu/qemu-print.h"
>   #include "system/memory.h"
> +#include "qemu/plugin.h"
>   
>   
>   #define CONVERT_BIT(X, SRC, DST) \
> @@ -328,6 +329,7 @@ void alpha_cpu_do_interrupt(CPUState *cs)
>   {
>       CPUAlphaState *env = cpu_env(cs);
>       int i = cs->exception_index;
> +    uint64_t last_pc = env->pc;
>   
>       if (qemu_loglevel_mask(CPU_LOG_INT)) {
>           static int count;
> @@ -431,6 +433,17 @@ void alpha_cpu_do_interrupt(CPUState *cs)
>   
>       /* Switch to PALmode.  */
>       env->flags |= ENV_FLAG_PAL_MODE;
> +
> +    switch (i) {
> +    case EXCP_SMP_INTERRUPT:
> +    case EXCP_CLK_INTERRUPT:
> +    case EXCP_DEV_INTERRUPT:
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> +        break;
> +    default:
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
> +        break;
> +    }

Having read the whole series now, I think it would be better to change the 
TCGCPUOps.do_interrupt interface.

Instead of having each target call qemu_plugin_*, instead have each do_interrupt return 
the discontinuity type, or 0 if the interrupt is blocked so no state change.

Change to cpu_handle_exception would be of the form:

     if (qemu_plugin_discon_enabled(cpu)) {
         vaddr from = tcg_ops->get_pc(cpu);
         unsigned ev = tcg_ops->do_interrupt(cpu);
         if (ev) {
             qemu_plugin_vcpu_discon_cb(cpu, ev, from);
         }
     } else {
         tcg_ops->do_interrupt(cpu);
     }


r~

