Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B91C0218F
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 21:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc9xx-0000Z9-Mo; Sun, 26 Jan 2025 16:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc9xw-0000Xn-Gq
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:14:48 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc9xu-0007id-OI
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:14:48 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ef760a1001so6543955a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 13:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737926085; x=1738530885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dM482TolBOr/dYb2pXuY2SYJtabVGHzvURXSW1TjI40=;
 b=EW5QVXJDzlPKt7uDkgOwcHnHWR5FioUVdH95HqC2zGt+1GlD/TsWn45AHq0foKxRHE
 OXWp+4wQLjnrRFBQGWDyCU2U0UeY28M57wqz3OJoBcvIlkNCceaezmgBq5hMpSiibIqO
 EuXuoDUtRgsAXzik2ynkqAZLP3cFhmn5h6FtkFXPDec/hKaZ8Hj3fFg4w6ZBs8Y2nNJl
 3qSMA5VlvQNwRtyYqQIw2S71q/Ux/Jq/lLZnfErtzcg6lwfRYJZZ0t/L49Rgtq73wHQg
 Zyr1OboX0LdYfjFAjI6nvIJ8rJmEvdBKMhdbVjDSDrZ3IJ7ygCAI/73fKDYEpIxBS7w7
 c4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737926085; x=1738530885;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dM482TolBOr/dYb2pXuY2SYJtabVGHzvURXSW1TjI40=;
 b=mzhxoI3QvkPbvzeqHDKXuOx4F77qh8bRJkqz3QnplNOPLesCNcn4eF+bqpX2aQ3SV6
 55NNRy3aV4AbKKG8sYrOHdOP2ghrN4QIBCHCTuc/zlV4u9Kvsp82xUvLS9T5CC5j62tL
 nhdoa8+YwsfkHu+Dd3pN4/wohwFPmyWVYOvghIkS6ig7VvrKhV6lB3/iwTBUN4u6j3hD
 dsd1MBE+6xNozGgHF9G2T2e2ASfeb3xhuOk6vc4poGAuAhiL+KBFzU5DfDI5TEiTA6l+
 XtgFL6+AKLg6Z3jiJz91G21h9twn7U9ErkDfw6NlvHQFlPHFI5OGrpxYJcu8ya12L64Z
 dfSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhd/mx+kODnfDOwYnmUvUrXd6NdpoliPeNGHpDO61jWcT8OL0WoN1+yTrg/xovdKaRo8dNaa7C1/7k@nongnu.org
X-Gm-Message-State: AOJu0YzFydbVwJSEsJXDIr8h2e99x/vDJ1Fc80S+hdSsF7M/xgdOFzmX
 Jn2MO4Fc+KR0CuEOt+AZjh7P6SSiZ/HZMRgSDLgpo0iLmgLxc+A1bUOfihV3QIU=
X-Gm-Gg: ASbGncsrMT51qGBrFWSI/WNJv2Ms9+OWM1PCFhCCBmJUw90w3S07YUmi5rM6VWgb9Qz
 pRDjtX1V2gF8h5lXf07QHi2Y+la6DuW5tZvH4bE8dqljVBQjLZV5KqyqZUi0FFvNGB3/JMsnxVz
 IXzyPZZWXxWWm4MRlJTLRLK33MVD8EkhCOwhZk2UuHz54yvjkWU4m4mw9EbJ6SS610Er55cXSS2
 W1M3mxdbWK6l2CrURGY7wa6KtNiBPFXtLp+bCs5eSciwBHyWkj06BfqmHTWLxAdNMS/cXDI4MT5
 YHNUYnEWmIpTuyxxpfv9oN70SmjvIWcSXcAI60YH+nz/FtY=
X-Google-Smtp-Source: AGHT+IE1AaZn04VsAmZoovvHskfFwwHs+/I0v2XJVpXr12XD+Jd8EH5sfL0xlHcxmhZL8x5QsccIOQ==
X-Received: by 2002:a17:90b:2f50:b0:2ee:fdf3:38ea with SMTP id
 98e67ed59e1d1-2f782d32c45mr47771107a91.23.1737926085217; 
 Sun, 26 Jan 2025 13:14:45 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb193e1sm5644337a91.42.2025.01.26.13.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 13:14:44 -0800 (PST)
Message-ID: <f7c1590d-5c61-4408-92c9-7241aed2c6be@linaro.org>
Date: Sun, 26 Jan 2025 13:14:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] cpus: Fix style in cpu-target.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-16-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250123234415.59850-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/23/25 15:44, Philippe Mathieu-Daudé wrote:
> Fix style on code we are going to modify.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   cpu-target.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/cpu-target.c b/cpu-target.c
> index 6d8b7825746..a2999e7c3c0 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -47,12 +47,15 @@ static int cpu_common_post_load(void *opaque, int version_id)
>   {
>       CPUState *cpu = opaque;
>   
> -    /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
> -       version_id is increased. */
> +    /*
> +     * 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
> +     * version_id is increased.
> +     */
>       cpu->interrupt_request &= ~0x01;
>       tlb_flush(cpu);
>   
> -    /* loadvm has just updated the content of RAM, bypassing the
> +    /*
> +     * loadvm has just updated the content of RAM, bypassing the
>        * usual mechanisms that ensure we flush TBs for writes to
>        * memory we've translated code from. So we must flush all TBs,
>        * which will now be stale.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

