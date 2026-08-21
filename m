Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07270C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxQhu-000050-BC; Fri, 21 Aug 2026 10:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxQhn-0008Vh-04
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:58:51 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxQhl-0006qN-79
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:58:50 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so749404b3a.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787324327; x=1787929127; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T8I/Ukp1PHwzZvwyLyCsed3i7m1Uz5v4N3E2HhcCEOo=;
 b=acwFt9Pana9cQNm4vV6dIdxLLrnbqG+JDJrKAvalrj/sa0tWTv+Wa+zUW0cR5w6Uqv
 HaexaqNstOoSMynwwuggssM0aUdJugH+JVFYCB4TZi+G8CK6PxI/SuwYomAuhZ/VPXfG
 yChGASsWFLDMhNrtVQiQjUKcrmpuKbfrVohc5cJWhRQcZo20+BhlKwNvaU+4zAWIsWNZ
 2wUJIjsXpz79qak5M6IymYveTZE6w2IK9aJt0JslNsdSZQlaqZgPHuCm9WtPLeLfiFp/
 WG7Euu728gb53OJpwtW+cAjAcNw0M8wojOSGxMZm9M/rNKQfXBCwEBTgLj5jGaO80W8a
 +AJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787324327; x=1787929127;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T8I/Ukp1PHwzZvwyLyCsed3i7m1Uz5v4N3E2HhcCEOo=;
 b=naTBw2ihvp4Cgf4kkCUjLs28m0iNKvlQfWR/EfDOuvMChDwdyQ+/CZBPWjn+f0AsD5
 nNpj2UcgFsKp0xOHyWF10IoefXoQX0S+O5FLcV9plTMgOtK1QVO3HQzw93y2B3iycbBN
 EKfO/9uaU7OJmTTGceWkhqW3XDO9cCzASeSb4J5XPHTXQDzzrmR2n4yBMXDwxs4uQCBD
 egTNQbvuWI3FdMayV/CIPKV5rIryNRnSYvOplrECt4iPEOLaHUGgMlxrezwQ7Y1Bl52j
 P0QFy/RQlXJHowNOFrKqzffHLfGUmupadhTpKQhEHeftSJKoiYZT+aHfc6Qb43aBSA+0
 Ivbg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1Y0fk+8EAOiwrFv8TlXvL+1UzwFwRpHH9mc23uLxoq1M7nJyaRNiJV7kUF3l09qSL+5JIx+lwc/WX@nongnu.org
X-Gm-Message-State: AFuF++moGvtrlGSoNOZy0hLIw6OAcEBnhHPNT0oePWOvB7DLzg/gHhMa
 HiSI66fvSpAX+3Q1yaKaSVI9g9f5LnQ5oKq2KYhamQd5sTMxytcwnShtsXi/v01Z2T4=
X-Gm-Gg: AR+sD10Ktb4KmqyQXQaDwr71LwzzucSRKNjIkuyorjSKbQfKNNqqF3nfUA8hv6Fshvy
 H+if4KYx7fmGgl/HdA/IK1tJ3Jp9R5QY054Q7sTJ3Tu51lzYDg4sRmzIkGfDI70SXqcRrPpJVl7
 gI9lLjGWYSLMRK3wjA/hABu7Ywf18by9n5lNrz7P90ZILlLM3oCJovFoyrhaVqyvXgZP195rfYK
 llc+j5hXfHTvrN36vNFeOijr0q7suDxLHuAQFjReeuUpU7E5oXox/0LNRMHRhyo0FD0wGS1Kefw
 AJTqipRuDinIB96lWRMZOmuGGbRJEOJKNyT7798IEbKiFhADVoSW6hQaNh3M+dqI2G2sEcrW+E1
 sevua0S0rEJ4AWL1pI0a0Su+1TxcD8Nelli55I1dQHOZT1DnYkb+a0uMO5RYqg/qOzuSpzdDtf+
 WdMCwBFJpFfebcza8B68SwD9MXIqx0tDTN3kOz98mstvFIAQ8zFJvLai6bExc4DeSO2o5XQIRmS
 uhz
X-Received: by 2002:a05:6a00:4c91:b0:848:6447:e0a6 with SMTP id
 d2e1a72fcca58-851f9a4f019mr11600222b3a.9.1787324327519; 
 Fri, 21 Aug 2026 07:58:47 -0700 (PDT)
Received: from [172.20.6.168] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3392a96sm2988075b3a.20.2026.08.21.07.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 07:58:47 -0700 (PDT)
Message-ID: <5f354f42-bda9-4af5-b67f-c92943b5f57d@linaro.org>
Date: Fri, 21 Aug 2026 07:58:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/43] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/21/26 04:00, Peter Maydell wrote:
> Hi; here's a target-arm pullreq. Most of this is refactoring/cleanup
> work; there are also a few bugfixes.
> 
> thanks
> -- PMM
> 
> The following changes since commit f57fc2f7ce667b6527582862e69d526edd3ee0e2:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-08-20 16:01:59 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260821
> 
> for you to fetch changes up to 37c0a0059db0dd6f35945196ddb17684c458886a:
> 
>    hw/arm: xilinx_zynq: Store boot info in the machine state (2026-08-21 10:28:10 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * target/arm: Restrict arm_do_plugin_vcpu_discon_cb() to TCG
>   * hw/intc: Fix kconfig handling for gicv3 when TCG disabled
>   * target/arm: CPU refactoring to prepare for max-v8 and max-v9
>   * hw/misc/iotkit-secctl.c: fix AHB secure read
>   * target/arm: Fix SVE2 WHILEWR/WHILERW zero diff boundary case
>   * hw/arm/ax3000-soc: fix heap overflow from missing class_size
>   * target/arm: Implement AArch32 "disable Neon" and "disable
>     VFP D16-D31 insns" CPACR/HCPTR/NSACR trap bits
>   * hw/arm: put arm_boot_info structs into machine state struct

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

