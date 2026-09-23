Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A785C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9U0G-0001a2-Ld; Wed, 23 Sep 2026 16:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9U0B-0001Y4-G3
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:55:39 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9U09-0007AU-UN
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:55:39 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d91c22d27dso5608325ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790196936; x=1790801736; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wM0kPJYKtXdJoPtEM/sjyDev4gFkAOekaDOCSGsoMXc=;
 b=O8U3M8R79vVNrPtVtcuqJSXvyt2AdzZkTNzlAcyedptNeHDQqG2dURuRah62AxjIeM
 0oKBYQtWDPyX/d/MnnbSS7OsdDrBY6z3s6Gdcn1C76zwRNp5M47uxWIi3nA/MytPw82U
 NFbbJmegJIwZzP8P9Q9J7xEWUafujwrZNEc1hU89/RIZWrNIaW76+rIkyIt+dbNyhGj2
 U2PGn9gV1792FsAobJn308+CR4oLcTiyx3ydkeC2b1FYYo9BjARO0eVk5/6qBgMEID/G
 OhWZjtn1tNHRL1OzVLvYC08R9/0tOyVCUQxPbkkxMPett5OR9JkXnKUERbhd8OCnr0F5
 ++SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790196936; x=1790801736;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wM0kPJYKtXdJoPtEM/sjyDev4gFkAOekaDOCSGsoMXc=;
 b=vbs6/yZxCEMoZM4OVXvVXS6YQCtj8IOwLPncHBo+IlseG4GWFGrUfrbbluKIFFGGMl
 dTak/O++DQxVUnE8yE4KSmZMjbwAEYHWTWZZdWUn0PEt3MJzGRAdHoKzFhJ63+q+gUEw
 xyusqPSmaxWayhxN41kZ2GvcbLi8Xik9K4Gfdxce1t+1FMYbSPnijBZ2U2WFLvz4SWGG
 FUKjkXUxdiby+R4OFBCiH2lVOcQ7h8dAPQWi3EcrUKTzWfwnGdKdnMn3SLDdkHZcwc0c
 hWl9oEjOADudwzMEzFvW6Bb7a0iQYEIAmaNSfKr7vet6SzpRoGvlOuFMyogfJa6dpDnN
 2RrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByW6wCHDtRjOln2uEqu/UlPf4WkeLoUgs+GLiOG0tRsdpv8bsBt4mY0jz3K6iVsqoIk1aP4pp10MfUH@nongnu.org
X-Gm-Message-State: AFuF++mSKtqy1T2c3z7kDl06iEe29ZOWT+oj2j/6Vqo4epXc1wzm/Wx6
 PaZgg7L6q3TWqN/UUlYDHTdc8edhQkCtGF372xeLKVBEZm1Qd4Sk8KlIY998OeRW7q522dMwQSO
 jtYrj
X-Gm-Gg: AYBFou0ZbdOUcdO8BBeOAYgw3R9JWrRl5mXaacCSTdw8L+utk1gLZNCWo9eln7WslJc
 MscYTarwu60nXHYMlwEzLark4abxKncqq4XJIJxSsPAbRap0UYqEtrOELFHliH29qeAAEui4Nko
 cjJJKtbsde/xxKTAoOhQSu9j/RNYDg7LrFPsTvrtU4zfj0c3rc2kkhjENrHcYYaQe1KKaCsebPp
 PBCbZQBSRKT8+ViwBitykgeoc+unSUQ1+byi4KezUdfEENl9jsXKkYOXSUMCCOnPyw67JU2PMGj
 g5NqquVA/GsVmeNTEWsVhCnMo6kI6RKzOVl+42Ud1T2guJMOXusXVIvpoC5F4LpALqg9iE9j2o9
 XJdYtXX5eZd+e86ECEMd/0Pp3OYShH+oHnuWkViCcpNfEfdl+bNvYcBObFPy7wfXLdR+qeTDqSF
 ddQK67lhCtbI+2Bj5lCzRe+88Bv8gtNsSJlw8HAmxtnP565VflL9iCK9/z2t0RukxpHVNP5VZSn
 EjIBfEYRpnx6otfbaRCulXYqV82Qkteb+9p9Tlj6dpgpTK1W0k=
X-Received: by 2002:a17:90b:4d09:b0:39f:d323:c988 with SMTP id
 98e67ed59e1d1-3a098dff5e3mr214678a91.48.1790196936458; 
 Wed, 23 Sep 2026 13:55:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc75f2228a2sm1630634a12.4.2026.09.23.13.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 13:55:36 -0700 (PDT)
Message-ID: <84dbe3af-4ebf-40aa-b760-8294d8cfe686@linaro.org>
Date: Wed, 23 Sep 2026 13:55:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] target/arm: Don't register 64-bit TTBR0, TTBR1 for
 PMSA
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>
References: <20260907130223.3148989-1-peter.maydell@linaro.org>
 <20260907130223.3148989-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260907130223.3148989-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/7/26 06:02, Peter Maydell wrote:
> We register the 64-bit versions of TTBR0 and TTBR1 in
> lpae_cp_reginfo[], marking them as ARM_CP_ALIAS because the AArch64
> definitions in vmsa_cp_reginfo[] will handle their migration.
> 
> However, this means that we are also defining these registers as
> present in the Cortex-R52, which is a v8R PMSA CPU.  v8R does define
> AMAIR0, AMAIR1 and the PAR, but does not have TTBR0 or TTBR1.
> 
> Split the TTBR0 and TTBR1 definitions into a new lpae_vmsa_cp_reginfo
> which we only register when we have both LPAE and VMSA.
> 
> This is a migration break for Cortex-R52 CPUs (which we don't use in
> any versioned machine type).
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> Detected because we ended up with the CP_ALIAS TTBR[01] registered
> but not the TTBR[01]_EL1 cpregs that handled the migration.
> ---
>   target/arm/helper.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

