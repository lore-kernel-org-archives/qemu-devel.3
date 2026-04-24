Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB91FDEE28
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 01:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG5Um-00081P-7s; Thu, 23 Apr 2026 21:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG5Uj-00081H-SN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 21:38:13 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG5Uh-00044Q-NQ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 21:38:13 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-8a016799d2cso81003256d6.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 18:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776994688; x=1777599488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Js9eMwKF2A8UNeyLePPydO44TG0mXyfsBSMVBdTdFME=;
 b=bX7Vzu7WBYb4kf41r527IpQVfgYYzS3YzhX1+9NVPZsv+qkBua15/1s3vjWIKmT+ap
 HiyUj1Y5NNSytHUVKOv5itlOdflyRLvE0QDFmLppTCI5AcSMups6TuvliwWp9vO8uSaX
 m03Cr/cHJNoGuLHwi/k62Q3qE1HcND7G5RvV5cVapdiKNB9UICaLys/CwRmm03B1S4U0
 xJza92Tkw46bviSkBgslkWrOo1yEppqII5Kp8gFY4TPwFAufcxrMCd8015fFq/t2NDr8
 q5ElP24giiHDbLG2SCJ7Kgn8/mKxemz1qQveyk86E6vywfLrM4D47jrms4pqzFqyK+YT
 rR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776994688; x=1777599488;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Js9eMwKF2A8UNeyLePPydO44TG0mXyfsBSMVBdTdFME=;
 b=KvUiy4d2pBgHubYARoLhKmB7xAXoERWZDwwkXekwgvste/ssK4jB3gJ+yBFn7fAujh
 wOahtryHGOKGXsrlcX3WCIrQ3iB//fAjGJHxJgxCGXihqbCYsXASSKFA9FGRRLjvktQW
 bllhgPSKxE2SuTUQaovzvyHVl2Pf2M2YJ4hwP9U2VLJ0oiyy+S0UpVZrw5D5MBqk59OS
 7szgPUMtxhJag5r90ery1m9DwNxVq0iCNuWxVoRebyKJgDW8T4OX0UCc12AkR6MeITYy
 hvg2kPQhlABONAsQQOKFXb10o5NX4O1bi3k8VoQ1yKbfNYZLCiAHVJW5DZac5DRNoxTB
 X6fw==
X-Gm-Message-State: AOJu0Yy36+CfA013rNOTOpDcghdwfUdaMtBGe5lM0FlakdOgMC88hcl1
 tMPaLVszdGTDUcQuZKt+XbwmyUFd/ZEazFBl0jAxEwGcCsfLV4bD7ucYN6+azEKaC4+BnVtd1qk
 c4tWrnys=
X-Gm-Gg: AeBDieu4U7/DIbygLkGa2dTe3c7EgA0ZzqBnw88nwCIZuCpyYmoFIbOZstx7vyYYFQR
 kVXdFn8HZoeQhU05qr0OzhePEP/xq+vhyGa7gSEN6MxiqFoTHT2xnBfXWHLJNr5wHwV+S1TYTcj
 REVjgVDC9PgaYjaFTN4E5BdM2yfZMBKRBXHs5pbjD/EiSLrBuahY3k51LusZXWl0rF13MZK6Ywq
 BK3R8Wl8W6wpBDjsXOE9kpGO0fQ3cSHN4VmM7YwgDB6LUlm+FMmMBYQzfCJ2Lr8F6PXtWj+EU9D
 xMf4uue1adJrESHUF0eQWxsveuZ3Ea18z7/3I13a4BZfPqYsZEr0oHFjPzA1U0sj85FebZD7zn3
 woqo7kpfGXPuZtrERZYwRhFp5cvX1O6jsyUDYYX/y8VpUxWv/QJGcqGhy2/g1g9K30bEb+Na68b
 l+JZ8Pqxc+l4qxcE3y9us0s04q3Iqh8dacV/RAnklKwCPwhgN/azivApUgZWr53lpd+cfg048=
X-Received: by 2002:a05:6214:5016:b0:8b2:cc1:8981 with SMTP id
 6a1803df08f44-8b20cc18ce0mr78848236d6.37.1776994688425; 
 Thu, 23 Apr 2026 18:38:08 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.190.12])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae97347sm170065166d6.41.2026.04.23.18.38.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 18:38:08 -0700 (PDT)
Message-ID: <bc481b23-6a74-460a-bf50-36a3497da1c1@linaro.org>
Date: Fri, 24 Apr 2026 11:38:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] tests/tcg: introduce a lib dir for aarch64 system
 tests
To: qemu-devel@nongnu.org
References: <20260417164328.1009132-1-alex.bennee@linaro.org>
 <20260417164328.1009132-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417164328.1009132-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf33.google.com
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

On 4/18/26 02:43, Alex Bennée wrote:
> We are about to add some more helpers but lets start by adding a
> simple wrapper for reading and writing system registers.
> 
> Do note the subtle switch of ordering for write_sysreg() which matches
> the change the kernel made sometime in 2021 (see 272a067df in linux.git).
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tests/tcg/aarch64/system/lib/sysregs.h    | 22 ++++++++++++++++++++++
>   tests/tcg/aarch64/system/vtimer.c         | 23 ++++-------------------
>   tests/tcg/aarch64/Makefile.softmmu-target |  3 ++-
>   3 files changed, 28 insertions(+), 20 deletions(-)
>   create mode 100644 tests/tcg/aarch64/system/lib/sysregs.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

