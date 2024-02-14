Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24A6C4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 02:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra4bx-0007DT-Ku; Tue, 13 Feb 2024 21:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ra4bv-0007D2-Qu
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 21:02:55 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ra4bs-0001Po-Nx
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 21:02:55 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1db5212e2f6so2482285ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 18:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707876171; x=1708480971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F4NpJ1sL1f1yj9DfJ/kwKIp7cjo1y5QG4ch4UAe/D6Y=;
 b=ovMY4Um3sAZf37YZBqWR/+Nokd6d5KrbGBvNBKqh8jlYsQ2R1fWLd6af7Ho1MffrDm
 8E3W2l41cM2wAEhGRhE/l7Oa6K43Gb2omf9NpgHBbalJ2zaurBZgZ2DpSARTIfWjAL9g
 C4LPl9+WvPXmG7WrvyqpsSsXXg5yKK+Ns3n7xiTjLkpM8kENLD7vT3GkgO2gYXmmR+ml
 zK5CbHNbuzVCTfhbBmSKu2sgX0YA9X0TsPsknqPnk/0Gkuh9VUG7hLfD4SxinLq66SoT
 59bAj+Ba6hk54wkGIrrwBSu9iQeu8cZsZf+bu7sXZGpSmR1Jke69mJ/UMc5/D+B11tTH
 OJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707876171; x=1708480971;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F4NpJ1sL1f1yj9DfJ/kwKIp7cjo1y5QG4ch4UAe/D6Y=;
 b=d1X39kZGfjeqnvWvMH5dGL/DdrPV4fdtBoHHaCfUQdXVM/nOxiT9HHXJSbdhF1YKGk
 5Y9l3+pQhXiQdZJ8ICptNykV5iu5kCZiwBKHJc604rFhhQ440q51REghbfQBCf5my9UF
 cdZpBSpGAz/gb6a0KTvrUTLGg7+U0f+eBMR4MyKHm2LsshLWAkFlzNMg4sxyXmUp2kWS
 FBeL23tgiz+UOciFNCUwxlTD4hp2pCtEq3fmp8dplXsNRCpKC3duyQG9gap01u/kIV/G
 PBsP5BQT5v5cvJHPF8KmftAh5ZxnmSKr049SVA8IxjKDiJ8mweScArbvoBH2nKtHSfFi
 BIRA==
X-Gm-Message-State: AOJu0Yzm4nopNNu/cdXfhp1/80QtZSGFycWTodOnHoCi32GzSb68Y9bT
 /ygbUIjX6o5vcYTPOBO0WClCogCKDPpG/fNP0OEPF2qi3zihlPbtubGhKfjH9Z91Of5mf5J8Kkm
 o
X-Google-Smtp-Source: AGHT+IHA/0SNfpEVSxjJMeB/K9vxZHYDvhs3B+bC6H+5SlOBBiVMkZoFO+8L+3gxrx7L2iHVYkzT3w==
X-Received: by 2002:a17:903:244d:b0:1db:4961:2234 with SMTP id
 l13-20020a170903244d00b001db49612234mr1062572pls.30.1707876170727; 
 Tue, 13 Feb 2024 18:02:50 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 k12-20020a170902f28c00b001d8b8bf8e45sm76527plc.37.2024.02.13.18.02.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 18:02:50 -0800 (PST)
Message-ID: <a76a4b4b-694b-4408-92a4-97821e1787bd@linaro.org>
Date: Tue, 13 Feb 2024 16:02:47 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PULL 0/2] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240214012533.453511-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240214012533.453511-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Dangit, PULL.

r~

On 2/13/24 15:25, Richard Henderson wrote:
> The following changes since commit bc2e8b18fba33f30f25b7c2d74328493c0a2231d:
> 
>    Merge tag 'hppa64-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2024-02-13 13:56:46 +0000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240213
> 
> for you to fetch changes up to e41f1825b43796c3508ef309ed0b150ef89acc44:
> 
>    tcg/arm: Fix goto_tb for large translation blocks (2024-02-13 07:42:45 -1000)
> 
> ----------------------------------------------------------------
> tcg: Increase width of temp_subindex
> tcg/arm: Fix goto_tb for large translation blocks
> 
> ----------------------------------------------------------------
> Richard Henderson (2):
>        tcg: Increase width of temp_subindex
>        tcg/arm: Fix goto_tb for large translation blocks
> 
>   include/tcg/tcg.h        | 2 +-
>   tcg/arm/tcg-target.c.inc | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)


