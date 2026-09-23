Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C82FC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Ty6-0008GR-0M; Wed, 23 Sep 2026 16:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Ty3-0008F7-Fk
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:53:27 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Ty2-0006vI-0j
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:53:27 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747eb79f6so6702365ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790196804; x=1790801604; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CHy1VLFHOQRUzgi9M34jWG7yjVB5sBh8F33ParmNj8w=;
 b=AxRGv6PXF6XGcmp6T+tq+0pRIs8ob12/ADaOgVMrtYpz6KmRYofamHZ1EmiiPlTeKZ
 A7N8o61iaVcgN39+6bfsn8FWhnptEB/NT2cSU2lhXZ95uwWYRybh0ecFoIWtZaE37q6Q
 KQsL8g3Nccfl+CfCdLfbzZgnH/wftlUJoZDSMFAEm1LYzq8fjDHjWfqUOniGZsKyZwiQ
 qY3AluBAblCf6Gb3KJ3Opcm09d7jMeYw7PXIXjVvsXJaEAV+gHdhix/CU4GQSxICMI3z
 qn3NKAR1W9avy34Ez4/bhKygV8ct7z9pL3LFCjq2yJlrFkkmPZXR1raE9OpGmoHGAuDg
 DYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790196804; x=1790801604;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CHy1VLFHOQRUzgi9M34jWG7yjVB5sBh8F33ParmNj8w=;
 b=orlK0Ny02UPYPBQZUsxb2tTbMJyLIdmwNp6A/Z0No5oJoa6rcFMYd1z4AO4YTqGbva
 S0Cy/N6vmDUU1cS0SC8mhnFnr6/I36wsUa0g0OAI17ylwE0vosvrWGAWSwZMNQbDgcXj
 HbnpFXcqjqpBhnAlU70gDiDxpOCWXxf2Ma82IsaqtTQ2l+3tLSjaIKIIqxbwCfUSgmmK
 yVdkert1+OMY9QtIFde5jQRFcYPMaKNOdVK+NZ2ENqC9LzvUsdpEob/xCKe/o6ptPYEA
 QH/7kNv0gT+iw8RQiQN+f/6DAklVdDfmgMS0oJBMeXcJO2WvC6gAfhr9TyQRpZ2Fi9kO
 vFNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+FTxstw+ZgqGsfEiX1lBu9uePWEkMePhDGVijwDRZSPGcds3LOZZHoZ7F0H7KPtyZq9Kipr0KwH/+@nongnu.org
X-Gm-Message-State: AFuF++kS6aBNlSyCuH/aBodi4bYHWDGadIjvCjQrsx8SkMeeiT0QWwLj
 DoVqNsII/DL4CUnRPfVKkKr/dUOdyPcqKXeIStTJM9VdQvVDjuGLEl9R2ddSXRF9F0g=
X-Gm-Gg: AYBFou0JN8HzKtgty5IE2VMj0OT9kl4VK9H5BcminPry8vzS4tjGZJ9bTskYJSxOtnG
 RQFTJWAAbm3nNG9wsMtWvMaH+WBRrtdIz/IhksWQep5esyxw/oYnP9CwiF0dJ0c89xHLegUgD0U
 /T5kIVC1MRxoQjzxLBltAp2XE+xBQIq83DYLYqUFH/rLx1lsY7mp1h5MR/uydEdQanPS4BKI9Qt
 g9Ku9tW3LRogMpT3SYXp7pGzr37v86ar+QCN/UJ4PJ/X0G18WRg2oKz4MoN+/+t8cfiGy4kdod+
 X5xHLuvbFY1S+YRdTbpfKWN4QpOjm59aAJgssKcIBAahucxNCN1xsA3zq7x9n56Uy0DOFPmnzcw
 apEIxx7XdeFSmMCH+myhbuAvT4JGSAU1mNHaUmyrjdREE4uAncB8Nc9AYQVz/Yv1qDMrP/Ee1fb
 rmVAj5PHkMLgj2RMv36MXT79VAY5xAu8Fu1mX9aqx8enQsJjTyY6OFI1Pd57NaSJxvlKaqhzeCH
 Ejqe2VHVO0YNmDUEPMLMUOpKU18rbFEIz2fpxMc
X-Received: by 2002:a17:902:c40e:b0:2dd:c0ff:e72e with SMTP id
 d9443c01a7336-2df7e0069ecmr2072105ad.64.1790196803818; 
 Wed, 23 Sep 2026 13:53:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5c7d82sm16422855ad.46.2026.09.23.13.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 13:53:23 -0700 (PDT)
Message-ID: <4ca64731-2491-410c-b746-72f928630742@linaro.org>
Date: Wed, 23 Sep 2026 13:53:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] target/arm: Drop uses of reset_ignore for banked
 AArch32 registers
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>
References: <20260907130223.3148989-1-peter.maydell@linaro.org>
 <20260907130223.3148989-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260907130223.3148989-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Some banked AArch32 cpregs set up a resetfn of arm_cp_reset_ignore.
> This is presumably in an expectation that some other AArch64
> register will handle resetting the underlying state. However
> this isn't true for some of them:
> 
>   * TPIDRURO's S bank is in cp15.tpidruro_s and this isn't shared
>     with any AArch64 register
>   * TPIDRURW's S bank similarly is in cp15.tpidrurw_s, not shared
>     with any AArch64 register
> 
> Remove the use of arm_cp_reset_ignore here; this means that the state
> for the NS versions of these registers will be reset twice, but that
> is fine because it will always be to the same value (and the
> cp_reg_check_reset() code will assert if we introduce a bug where the
> AArch64 and AArch32 regs disagree about the reset value).
> 
> For the MAIR0 and MAIR1 banked registers, doing nothing on reset is
> OK because they are backed by state that is always covered by the
> MAIR_EL1 and MAIR_EL3 AArch64 registers that will always be present
> if the AArch32 registers are.  But it's not consistent with how we
> handle all the other banked regs, so drop it here too.  Again, the
> cp_reg_check_reset() checks will catch any mismatches in what the
> reset value should be.
> 
> The lack of reset-to-zero for the S banked versions of TPIDRURO and
> TPIDRURW is very unlikely to have had any guest visible consquences,
> because these registers are architecturally UNKNOWN at reset and so
> guest code should be initializing them itself regardless.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

