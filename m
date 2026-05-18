Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BBECD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOms5-0003Y3-Ib; Sun, 17 May 2026 21:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOms4-0003Xn-1L
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:34:16 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOms2-0006jq-JF
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:34:15 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-83d5bbef760so671759b3a.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779068052; x=1779672852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HDL0GQxppearVdP6YOco5wIPx1jWw6Ju++WDDskYbEQ=;
 b=BwVWxQpTjlK457VTCyybgtU5IIKQlTKQ4cYFfHLIn+0e9H5+fPuiJoc85lShVfC7CT
 3IHiWad0MkDxfNoCkZXYwSTjoutNHsqOszLbPwCY1huCnNnVXk/lprZ4koyMbcfhnL2J
 YFK3iFXiv7XXqB/TYkO/iyYSmBdv+D8Qqpljb6G3NXAc9ZO+EAhARGDpSedxsplKbDQz
 Nojdlsmy0yT1uoeAwr2UiOoJFIsvf7zlRIBeV9Bc0peSXwZV9iDto/+QzLt0PzY76+Dw
 vkCvGa2Sei0Q21Vq8r+23N2AJ1x3bNigl3WbI6wSOeNRcMriHhfYbbTxBwiYVPquCZVW
 P0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779068052; x=1779672852;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HDL0GQxppearVdP6YOco5wIPx1jWw6Ju++WDDskYbEQ=;
 b=FBUaqV3rt/aM3yNWqe/v3lSb8TgifmsWz1qptbmbJMLhKpscFlqXtHMad08xUB+kqY
 2ZC2eqxxI/CQOTZY76VVzAZ+b+oGWqOLNS5aMDvxLmoZtQ5bI6dgeyDQMqsy9qDJuZkA
 wsPm7Obr4dtwyakrrs9GlYql2/aQ2PAh/TCT7I//4YzZpa14Dnpadc10q5V6MXkp8YBw
 nqQtZDWkgASuqu9G+9fNkU++SutO0s7ZqH7lE31YyCm26OEVzNwNxr5IU0V3hEPlOsFN
 jdR731OpdkYuTVF9WW0GX0e2RxrU4TOwiEyfbjMYxb2N0OmylwuL78CA/QqC8dt8N3km
 kivQ==
X-Gm-Message-State: AOJu0YyaVhrk7zFrEu3Mcsy39vjBiRa7K2gEO+VfVWmMhgA2iDIB6EJo
 Xh6Xa+NthBlDXnYMiKM+n6T62wiKOyLCnS1lw/9UHn3YFmfeQe+QOlvYAajckH9bC0xJbprRKIu
 UO+bS
X-Gm-Gg: Acq92OFIFZSLT/I+Udus8UM1E4JPe8y2MxT0Ts9RTrALdZi8qEgPtOwvDU+nbhbJP2y
 Fn/gljXv6ywdFFXCXf/coYUECtbB1N4Bj0vvS65WYuBad5h56nh1WTuhJyUuwVtw93/oIWxee+V
 Z/tgp+z0+N+vumzMo1ro2zlphi5l2tzFojaMzsrnF2f91k1xxiJAvUm6dC6eWdJ+D7e3qHLSmBS
 uyBexNS3GYyWjuB9pYlxPD0scWkGVToXjFkw93+e/o3Tx+yLYF4PQbpHwC3xBV9IrqqRt+6VPCK
 XKEAGqHrcQYPWUV+vf6bnObz9MeQnondURUaWhgNSRP5/gFrqxkHn1WW4MFlltw0UDCqcBL9Jpz
 0wOAgykfeSV+n7nzg+rv7PBKmjb9OT2CWsqJDtO/b4J7/6r7/mF0ULpv+JpLCUoZm4XJUlOV7tY
 08AHMJH/Ojhp5P3/ezlEnuzNs1cBXanFCM4jEbSTn4uvU+eSU=
X-Received: by 2002:a05:6a00:391e:b0:82c:24d5:63e6 with SMTP id
 d2e1a72fcca58-83f33bfdb1amr13713567b3a.15.1779068052245; 
 Sun, 17 May 2026 18:34:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f196660easm12360368b3a.11.2026.05.17.18.34.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 18:34:11 -0700 (PDT)
Message-ID: <2e07e97d-e05c-4f5d-9101-84b43f2903b6@linaro.org>
Date: Sun, 17 May 2026 18:34:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 33/35] target/mips: add Octeon CvmCount RDHWR support
To: qemu-devel@nongnu.org
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
 <20260514-mips-octeon-missing-insns-v2-v7-33-226686be4ce1@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-33-226686be4ce1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 5/14/26 10:37, James Hilliard wrote:
> Octeon exposes CvmCount through RDHWR register 31. Add the Octeon-only
> decode path, enable the corresponding HWREna bit for linux-user, and use
> an unsigned mask when checking HWREna so bit 31 is handled safely.
> 
> For user-mode emulation, return host ticks as a monotonic counter source
> suitable for existing Octeon userspace code. In system mode, fall back to
> the existing CP0 Count value.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   target/mips/cpu.c           |  2 +-
>   target/mips/helper.h        |  1 +
>   target/mips/tcg/op_helper.c | 13 ++++++++++++-
>   target/mips/tcg/translate.c | 11 +++++++++++
>   4 files changed, 25 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

