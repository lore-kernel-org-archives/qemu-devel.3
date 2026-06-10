Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02D5CD8C90
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXMWa-0006xN-LF; Wed, 10 Jun 2026 13:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXMWO-0006wT-7K
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:15:20 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXMWI-0006dG-TG
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:15:16 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-842848fd613so5973121b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781111713; x=1781716513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XQNsnyhKrOGPdcBiPMU11qWwYsamY32jQDLnCcgPa1Y=;
 b=WQ/evULNJWEjdnUsObr7Axm86UF5p4h/txPTsSu3aQN1GVEKNdGatpZPbRL9LUhzwP
 gFm7uD2hZyhz+mhURTGRAlMRdGjK8X0SWDc6cDQ+ioSi2KZO9taqsO7cu5pJbaudYkH/
 YiuxWR3iCguS4f/JKPO+WrYwcctZlQcAtHbffB07N4//hpfdMv1PiaRENlvs1Wc9Ilfp
 t1AL+auSrAU8if1TFxb+EvYY+GhSVL65Q2iZclZ7ePkoTytR1QucgDiYS6JpyLjyf2EE
 MfGTACHlc9LPCuOmY4yCm19D6EhIT0GcW92o/koJQOSvD3gonpDZX4B1bGKPDjlbcoP0
 qtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781111713; x=1781716513;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XQNsnyhKrOGPdcBiPMU11qWwYsamY32jQDLnCcgPa1Y=;
 b=i7A0jrBUNohFxdkOVJ0ANH4KzR26jR/RaZPpcjjVg4kgPaN04HSF6AGSOJRHCCGc4O
 MOEyp4bYlW4ni5iq9xqseWV8ceywhWvdkMxz1k/hFXjr70maco5CqPu4ki02rILFWrWr
 /EjAcMIMUUdC1AH01aKLlvFyWFfV4fMw4gW3jcOlQgl7CSCVFHjnqaAYhmVc9ZsBkuiu
 O2WaXjZ8SP2amPv+uXYW3eDN7DbExHoR1vbwnCpBHvysY8nTDZGONYOxKmU4k+iy9dak
 rCIo13FSxNlWVXRii2ykMX9DUrd4ijdPMi3oudYdwttPukPP1vcMlOM9sXQcO2NTcGbl
 Xciw==
X-Gm-Message-State: AOJu0Yw2quZcKZ7xt9K56uFyGRDrmb4BLhTHD99Hk+5hr7Vfq1H9V/jS
 GFN6kKp7Wjwlb1nLCtwvTmIvgWuC2Bz9h0IQbaatPK/eiIDn9VWYDQu5vPgcAOF9/ARB6vObRFG
 QrwphHZM=
X-Gm-Gg: Acq92OHj2TXHQhy8+XDCl2MTeaSoAx52SJd0ThsCedosV6s4zZ25HDUr3NsTGPoQCK9
 hUM2xkRfl63ljIZOc+AZUYwc7oqWEY3xYp9X6oZ/kdhN4N/vS0JD8Tf2il3rklNPlWUDVckl8SP
 nTRdWpZ4go2V7buzgFDFSpLGXX0E18cS42vzNvsmnquqF+cS4fyrdwY38jWJXMrFdnk1n1mb8OU
 JzlyfcuNk+E8bALY38DuzunagZR+nl1GzBULOLbPCPVskPXpor/jJEGLpz1DziJDlcIjdcT73oR
 p1KC+uJdsZ1l+yXFgbtZhv2Kh4siZ60fJDSJeKgURMG6T7lOwkfY/EjIaMDQyTKE6/KS36zVlWO
 O1hTMi9aIQyLv1g7vhIz6XqcgAlKmpoUZ9s18DF9Ar1o55i7UT2G1VijCtF3J4Jb55G3Aav+thy
 kUEhWp0ARzpZr4nPZB1RwmI9NvbI/1kdKDp715ARnbC739Dy8=
X-Received: by 2002:a05:6a00:8d6:b0:842:80c5:c420 with SMTP id
 d2e1a72fcca58-8430a784da1mr9545308b3a.40.1781111708357; 
 Wed, 10 Jun 2026 10:15:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-842824a1cb4sm30453809b3a.26.2026.06.10.10.15.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 10:15:07 -0700 (PDT)
Message-ID: <58db6024-1d80-4320-b92b-673f8d09ac5d@linaro.org>
Date: Wed, 10 Jun 2026 10:15:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] tests/tcg/aarch64/system/gpc-test.c: Basic test
 for granule protection check
To: qemu-devel@nongnu.org
References: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
 <20260603-jmac-gpc3b-v2-6-115c51936962@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260603-jmac-gpc3b-v2-6-115c51936962@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 6/3/26 11:26, Jim MacArthur wrote:
> * Sets up granule protection tables
> * Enables GPC and bypass windows
> * Performs memory accesses in the protected region to
>    check for allowed and disallowed reads.
> 
> Signed-off-by: Jim MacArthur<jim.macarthur@linaro.org>
> ---
>   tests/tcg/aarch64/Makefile.softmmu-target |  11 +-
>   tests/tcg/aarch64/system/gpc-test.c       | 165 ++++++++++++++++++++++++++++++
>   2 files changed, 175 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

