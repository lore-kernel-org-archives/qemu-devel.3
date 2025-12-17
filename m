Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C63D66B85
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 20:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVxps-0007Tp-Gk; Wed, 17 Dec 2025 15:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVxpi-0007Se-72
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:09:14 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVxpg-0000vf-Nv
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:09:13 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7d26a7e5639so6974644b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 12:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766002136; x=1766606936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0ge71fA/dlTIwcEIxu2n2XX0KQf6QzlUxl8yz5IbOR4=;
 b=dLk8dV55i0VunOQJ3WI8fXFhhhKb6R4QL3oe2BhMqMDGlN57uXJgcqJe9IBu/8FfTq
 iZLcX+xnXs1A4JODF33r5Q9o6FT+gaX/gHLfkpNzqlNvHMYNhrK2KVug7AbwD279BsG/
 Xi1D/PuUhyETpTrUs1D6pEGxuiuEaycm85WsbrxenO4Qk47ZY8F1At+7BvPbQ68zoEXs
 D4pDHMVA3OlZPd3hxaA+zmGXL69Yz7Yrk358a7XV5M8aYcHIA0goEzxpKOlPvP/rQm7c
 vB0VoVYVvyjKLJMbHLS4no5F2hzKSLzec/rPuu42DIJmjJYFGVySa393aFn7ysO5Euuy
 C+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766002137; x=1766606937;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ge71fA/dlTIwcEIxu2n2XX0KQf6QzlUxl8yz5IbOR4=;
 b=leWnMwT4MQRIK1cMtW0MeFWVWVPAmlZxT4GLLAQzWHMunVCqLLzP90HkoOYV0EN9mw
 4jiz+tNQ2nxoQQE/FSLCw2Lt8goV84QOBIW/vd+PqlEejc4/c9NhkNYUz1Ods1AMJZ3+
 ilDTLY46kLm8AUtuXiNP2v85He+UUwfS9wkY6ZM5FktwDQgHmv/lW3JMAWrZABGUEbwz
 tpwBiOArj30S1O84oPlJkydzgVSdm4Y40nKiownnPHav3cxjMwN8gnnYrMUJoQxSlazW
 46FdN2lMxy154/6PL4izmAwsHXU1/Qj07Fe7oJGnR7m5WR8Q6XrsCK3lZa1NDN+Ar7CI
 J0DA==
X-Gm-Message-State: AOJu0Yx7IQ1Xm0YMtQsp2ZYQwdgpW8XDHHg4OoCi/Yb1F5IR+VzYeXNo
 1+Q3suxiWZCwLGxxryXrzDtFfSt0FSXexCI2YV8xfmNHwN8euAXlI8CmPvxvdfYLOD9M4DiM14u
 xdEgmt0k=
X-Gm-Gg: AY/fxX4VHMCkpwkcohNHT41IhZ6AiUnQhEZa0DRf8o6yW63EgF5kdd1wV/H0QbVM0mr
 1XK1Afi23QX0tuzBl4ujF1burF2oWCnrISUGDJ79WsgBEZ4kAFo9IYuqszV0vO3HCsxoFArvMXk
 8rw3gR6708QP4obPwdzLhjp8dVxiXnW3stoXqjiyrXDL1DJci7HZbcn31FUE+vB+TWaj2wSSeKX
 ljwpvwBYY8EN9w8nPvrYvQqrbQUtjEKHQdEfvuKgtcSE0y2ONmmHZTwaMlDszOhrWXfnr7yIWMM
 tvcNILnS+SJpnoXhokL1yHP4YOEQGMPr/TiZURVmyCN+ggeeBsT9nS0CWnGAExywDCd21MVyihw
 JYI6mq12MfUdLZaZKGPMx1IeRWS0EKQ4rxkTP8nBBpgY0jEiewfKNMiOXNRddiNOhup6cLTSwbz
 hGKAnMvMgAwfxC/jLj75P4T5QFRufjUg==
X-Google-Smtp-Source: AGHT+IFZxfEXhxYPDamMbTceuK9JYb4JJu3Bp6hgpRnPo7w8QoSIJu/46gYr6F8SCjvTiwUuYpI4ug==
X-Received: by 2002:a05:6a00:4307:b0:7fb:f87d:a0aa with SMTP id
 d2e1a72fcca58-7fbf87da3b4mr5622918b3a.52.1766002136526; 
 Wed, 17 Dec 2025 12:08:56 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fe147635e5sm274288b3a.63.2025.12.17.12.08.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 12:08:56 -0800 (PST)
Message-ID: <c074a500-84af-4867-b52a-cd8a5ca22aa8@linaro.org>
Date: Thu, 18 Dec 2025 07:08:51 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] system/memory: Inline address_space_stq_internal()
To: qemu-devel@nongnu.org
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217143150.94463-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 12/18/25 01:31, Philippe Mathieu-Daudé wrote:
> As its name suggests, address_space_stq_internal() is an
> internal method which can be inlined like all the other
> ones in this file.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   system/memory_ldst.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

