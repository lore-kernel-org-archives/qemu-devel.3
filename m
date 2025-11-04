Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD53CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGHX5-0003q3-Qv; Tue, 04 Nov 2025 08:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGHX2-0003ol-1h
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:57:08 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGHX0-0002Lk-91
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:57:07 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-640aa1445c3so4383702a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 05:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762264624; x=1762869424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VRsOoPM0mNn8ftcVoh9+t4MpNBniP6KCVcUPsgeLcnY=;
 b=u+o9Mrmj2MJRwjPdJdE3EYHMeOubTfaEL8FGnfIHeBuDNVb3VSUitNsAZ2DWA15bue
 BxPmqD8PHhgXuJq0VU87RCogu2BkDHeuYciI1+Qw82BgpWoNTjvFJ/wwRse8lDDMmwRL
 pWaF0/jGvrhZROC7lt0jcuS1nqci+PIzdQWFIHuEKexBa0Hk2XYtZnC+lWUKWU5Bdqwp
 EgbC2xKOVu+67V6/PS5X6krPgUl5lxjq7PvdNr9qEL2PFSd9jjOTXQeqxIEH6fRy2lH0
 h126H0cj3SqJ42eOdQupMP+sVxdvrtcAaNQopBGA185LvI2lXf5pvZYlYn9FKMohbEtU
 HaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762264624; x=1762869424;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VRsOoPM0mNn8ftcVoh9+t4MpNBniP6KCVcUPsgeLcnY=;
 b=VoCwe0ld6X807LJfsYb762rA/FkLH60yFY7zghqncAf2QO2A/+rc2Jz7z6FIvhI96H
 r2WGIygrtOpn1ExqOOvyFiuf7s2FV8/RfVj/o7sj7SMaMwYe4LozMUwtLFcpOE8ROYsK
 dIpl7jhpPysplNt0m2PgUq0B785mqJVP6QHf5vjg0k+L0ff6tL2PeLMsHOR2R7hQrNzC
 PNUAfhGz9nYHuZd6a+wenA2z0rcuB1OaS5dZXCzCGNI0ME0dRsDRDStSqsshkX0Z2zEd
 GeQvg7zGk3QtamoB2CfyvdqKWM4sGlQBR1NEh2nwEbz4hivR7ffjJSC9B3MfRhk8z4QY
 AwHA==
X-Gm-Message-State: AOJu0YylP8GmlNioRF8mZoXsAr1aet0W4KZ+CNNpH9O2VHx3GTJGQ2OB
 VhY8ELiBbXYX244D3jfog+2WD91rkEy/lz6DErbHTfwKdfV/CWqwbpdGFEjAtTVC2iIGyOvdA+m
 xWI8z8YA=
X-Gm-Gg: ASbGncv+9/mUVPkdye2BkkPomDwTcHAvl7foSEGNRhdLsyY2XMxNHLfZtVACqhRnuxx
 agRU+ivYaTojf7OLp9mo2uj/Fok6RzXSY2Y7LFklJ3c/Of77XL1rVc/HuelRkPYeBxfgs8qLrDw
 ai2l1RwDk5BOcZiVY1YSVoF91JcgMOMQLaR3UOiOPgTdXjIFfVJR8/+6O5Stl9CBEKOWhEgPp7b
 40++i+eZUkiuUWuw6cPK+L1hiuK90lWCU/nrNzO1DbRfXEGieT1fkHHDuv/XNNMMpk2lneMMhsJ
 LsVEsZP9nNGd+bfROn0uSfCPqodefeu4g1FOjWx+X1GBZrmG9E+GI4EnpOtWu2u51lRFH+ExtUU
 UfSCzLmKfAHsnWAsyNxaGLk4co6mBdPw2niWLDfhL/r7C3wdF4pJ8dXzRlLZkUSVmNybpIuu4qY
 2cBIphFC00x6h8VYc0uo5d98tVuIGpXc2OB10Fvg==
X-Google-Smtp-Source: AGHT+IFv34yruFIT6T1d3s39MbqYCctgJA+tAIegVGoYQv689oIQoTZulvXbR1vxmCdWKbMm0KQmEg==
X-Received: by 2002:a17:907:6d1b:b0:b43:3dcf:b6c3 with SMTP id
 a640c23a62f3a-b707062eca7mr1503693166b.49.1762264623760; 
 Tue, 04 Nov 2025 05:57:03 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723fa038e0sm224513466b.54.2025.11.04.05.57.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 05:57:03 -0800 (PST)
Message-ID: <a5e8c475-add2-4f08-a828-48ed131982d7@linaro.org>
Date: Tue, 4 Nov 2025 14:57:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 0/7] Accelerators & CPU patches for 2025-11-02
To: qemu-devel@nongnu.org
References: <20251103132205.73931-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251103132205.73931-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x531.google.com
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

On 11/3/25 14:22, Philippe Mathieu-Daudé wrote:
> Since v2:
> - Dropped qemu_hexdump() unit test
> 
> The following changes since commit a8e63c013016f9ff981689189c5b063551d04559:
> 
>    Merge tag 'igvm-20251103--pull-request' ofhttps://gitlab.com/kraxel/qemu into staging (2025-11-03 10:21:01 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/accel-cpus-20251103
> 
> for you to fetch changes up to 6c5571e72aed54194a1a07799d8c23c90b5f229e:
> 
>    rx: cpu: fix interrupts check in rx_cpu_do_interrupt() (2025-11-03 14:15:57 +0100)
> 
> Following checkpatch.pl error ignored:
> 
>    8/9 Checking commit 46f767bd6814 (tests/unit: add unit test for qemu_hexdump())
>    ERROR: unnecessary whitespace before a quoted newline
>    #59: FILE: tests/unit/test-cutils.c:3662:
>    +            "s is \n";
> 
>    total: 1 errors, 0 warnings, 56 lines checked
> 
> ----------------------------------------------------------------
> Generic CPUs / accelerators patch queue
> 
> - AccessCPUState::thread_kicked atomically
> - Fix bql_locked status with condvar APIs
> - Document cpu_memory_rw_debug()
> - Rename init_clocks() -> qemu_init_clocks() to avoid name clashing
> - Fix QEMU_HEXDUMP_LINE_WIDTH logic
> - Fix interrupts check in rx_cpu_do_interrupt()
> ----------------------------------------------------------------

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

