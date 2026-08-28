Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2706DC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0664-00078G-Ol; Fri, 28 Aug 2026 19:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0662-00077k-Q9
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:34:54 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0661-0000Mp-9O
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:34:54 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso1163682a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787960092; x=1788564892; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F8TWmo8sr3bieVhCBcueaP9oG3MX7rTqQzoogX1Oqac=;
 b=ZCBN8/8P8WRl6GGXy/D1jErzByNJ/cLcPjWhJIk7xxCPqzhxPvGr/qO6cUs6loOisc
 IjH8YrfZXlZ2lRcWzyfKD0woHgvUDmUrxiatvT09RWyD/pyisdAJwYZiy83eBagtGTYy
 g6nAHL2zNE5es60UFaF8n2Hf2JkNXlFOEEGu/LlfCdwb44Tcd76t2fQpx7dwiY4/wwK2
 Smog4d9z4HQj5TrAz5SEBhm5dHh1NkpxJhso8nfwli5MySmZM1p0taF6a+ZHXSkBleio
 PS8l6fG68xCXB0j8gYmyXpfXWxvc4YpVDEAxYTs6rvU1HuAqratz8JXZUnlxz0IKj/u8
 4cPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787960092; x=1788564892;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F8TWmo8sr3bieVhCBcueaP9oG3MX7rTqQzoogX1Oqac=;
 b=M6lCDRkzGsnLnGiYwo/nJc+JwoK66GEIj9HcC349dlZ71bw30p+HjZiqpjGbqjQoXp
 LaZPPUKSLRGiOPKOoerNFDbf2/XlnfpDDsphpsQiIIcL/EgBtT0WQ4Gef3CiePDFAXx5
 4RWqpUcDM/6rTMq+Hwn4SbBj2g4VYTc97S1NkvKZBPrHUKb4HL/KnPscLYIyNEBuw/N4
 y4gfl9ijMztpIBt9cslypLc9SHPaoMKNBMgrK8cIM6sboMHJEdToYWNGscQ5vjtBuPqF
 z7Hg7dl5/9MabcKBJc+RAhnaSPOK2wDHuZPUaDPw+Ep92QT5Fdy4O+KajioPzcCFGlmi
 cfgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7ioJmD6eoKVJ1eEXDPat0qlW4kT3uvDf2+OnAiRUTMr1FSlXyTq8XG3MR38u24ZNtenbCLsbLgUww@nongnu.org
X-Gm-Message-State: AFuF++mJfGkgIX2dukO49LumE2j5XhxwJRf+iR2b78Aw+UCwLh8v0+bP
 cEwHH5p69ezKTa+zbWH8SngadszsCkaYwoStXEsZYGXPiJIzYTDYL3S+70M2YMar6H4kWIYE0pW
 potxQ
X-Gm-Gg: AYBFou0CkAv3pE3smunGmHHIyrj28jAmJlURTpBKj+d8CBRYeI3H1tFT8iZk7Z8FbQR
 1BZJ1kRoL9ogIilI5SL5VQqHx0OuJo6BsflcpYeG8VcREUP0iDGB97/vgakMVltOFuo5UVU4sJm
 z6cM8JOBJPuBoKHmm5Oes7VYK1UAt6oEsRWTCd1SiKpubIzZb+BbrsMIyhGfbv8UNbfXG92iK/G
 JYFQnkSF9G2NL8XC+hQZJUnuYJSZkoVE9G/HsQlF2r08BPOI/14CDp0BKd3meGKy0m/UzUkFnf2
 HuVHJXJTw0iJOZJuRGnYi3se0BqWXI14+abh8FWtDSW/ORTYXM4jBeTKYSp7FSpQ2hzOBjABTXl
 W8Lmi2GknLATxi4dVNniL1wJOGusLT3jeYnDalK0Hx78NZPt21XWYt0lkk3J9KXIGm2iQMIbyJP
 SxYFdqo53yjPuCUyAyCuyMBEU/xYqmZyDwW3Ld5RyfCHUdixRPZAY0HxXssWJe03cZftLqt1bOL
 8wuYa+vdjYa+MCxdCMfzO2juh9+WNM=
X-Received: by 2002:a17:90b:1804:b0:398:9c00:29ef with SMTP id
 98e67ed59e1d1-3989c003c55mr3253375a91.23.1787960091702; 
 Fri, 28 Aug 2026 16:34:51 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm480688a91.1.2026.08.28.16.34.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 16:34:51 -0700 (PDT)
Message-ID: <54ba3e0a-0b90-46f2-8f2b-b254c39742b5@linaro.org>
Date: Fri, 28 Aug 2026 16:34:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/41] ppc-for-11.2 queue
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 8/27/26 23:06, Harsh Prateek Bora wrote:
> The following changes since commit 0a1ebd448b38afaa118597cbb633dbec24ef74d3:
> 
>    tcg/loongarch64: Fix compile issue LoongArch host (2026-08-27 11:04:01 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.2-20260828
> 
> for you to fetch changes up to fe511b25417e01f1fdb50dc8ce158db0b7522705:
> 
>    target/ppc: Add self as maintainer for PowerPC TCG CPUs (2026-08-28 11:09:28 +0530)
> 
> ----------------------------------------------------------------
> PPC patches for 2026-08-28
> * TCG Improvements (decodetree migrations and ISA 2.07 flag updates)
> * Compat mode fixes for nested guests
> * XIVE fix for pending interrupts post migration
> * MAINTAINERS: Chinmay transitioning as PPC TCG maintainer
> 
> Checkpatch errors can be ignored as suggested here:
> https://lore.kernel.org/qemu- 
> devel/846d7958-6515-4e4e-8c15-513e282aaaa3@linaro.org/

Applied, thanks.

r~

