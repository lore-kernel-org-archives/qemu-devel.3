Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8258BE88D63
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8m3c-0002bj-Ue; Fri, 03 Apr 2026 17:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8m3b-0002bX-Rp
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:27:59 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8m3a-0004QQ-Co
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:27:59 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35dac556bb2so1459650a91.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775251677; x=1775856477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6RGD2l8TvmqrGHVHFDU1cAEPa/nvWWAOXIZ0zVBc/BY=;
 b=KrD58CKk9pQayvAePFvUWWu0NggZtfUwYHp7DUybK05IqpAnCZPMxV9IcTq/ONB+zQ
 ltSb5STRSzzJr362eENUx9Lsj+ZrRzZ/A7920ISEbS2Mxb/6Cy0N32d6v7mybAtqa0Rk
 SnF95ZUXRI0nAWilUW47LEQyKPO9j6LROLY/DXq5FeNnERMWoyb/AtiJLQqFrP7L54F1
 nBYxtcdxkty0f1gKGxUx83fG1l47q1qYtwsz90TL04mjSjE7Qq3vVd8SyS6ymHqdBKVl
 2It2G8PUJEXhbp4ttlng3jiDXmYiTYyNu/NmDCeXsPTHK23GUCXKCB9JtTDzOn+JScdc
 Uzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775251677; x=1775856477;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6RGD2l8TvmqrGHVHFDU1cAEPa/nvWWAOXIZ0zVBc/BY=;
 b=VAXtINArzFDAmhvne2i9fF+8CJBnyTM0I9HbTloRr6LAGcTn72EZFrQ3d8fAsXnSY1
 xw0RhJ6mdm8pDKAvzQDgR7Q16g+MPcy578RJTMBtAbXSEILg0BMAboho9Jjb6brTOpaW
 2mkQbx9F6S5kYLPLtEHHIOxgeSIB3g4ODC8UFwQ8fzc/FljD5FtXOkXnLK/wWLocL8Yz
 lDah0ea9G2FO34dCV7W4PZT9HX54fZX82/6geLbFs60nnlWIdjOzyxTMAaAth2S1u/sf
 tyeaXr85Dpzlb+Dy1d0T9mc6hkxCuXpkckrqVtrAeZeRol1+bxCttyflNiH29JSD4CY1
 x59w==
X-Gm-Message-State: AOJu0YxH+DEpoAV56nWsWj08J1tBtOdZe4EU3Z41mWCwmB2QasyWiPgK
 xgbpCxt6D48C3uNWod958g0pIfQgX/eAGAAsFbzd8b/XEIu7oW6y9f7mxSqut2PtCNdAcyKyBOy
 +YsVEHNU=
X-Gm-Gg: AeBDievPRcj9w4m0vAF8dKPNjQ/1gjMUj0MItcfblxXBgDmt/BZ5pQ9XqnfGDCC/Xzq
 mzfAHPfEKNWRlZLaYxc8/1b7UHY0eptKp6wdGLxa1VVkWk4cq7jWB4xIYV5fbLHbugIDCqqO9lb
 5OoYhF6Vw7A7ICzUqRJk/hzOp9fHwxaw6fTBUVrcOtGEZgq7/OCizi4/zLasIrVO6S2lXNByab5
 Y8Za0hTagsL+s3KXZastceTUFUHWHzK8X+xnCsfxFx18lTHG9uGHILRncDV8LInwsimjZqsz2AK
 X1PVdNbWTJGMyOacJON3gOG4XtWWFkb+JqomVDCF5L31OS2CVDpmH69CnNxrhwAOB9enrr5Zl54
 hmubbCGaOrMeTDZWGKcAdKBSiWLYFs1aoA8SEowxnk+TCsDroXVuaZcydeyD+1H9cm7QH0P8jZ/
 e2hpt1JX6aRbrd52MDUfw6DFU5sV89dYWcsJrisPPQb207FTz1/haM+7mBSGBEapX3bss=
X-Received: by 2002:a17:90a:d406:b0:35b:a656:a60e with SMTP id
 98e67ed59e1d1-35de68952f4mr4167971a91.10.1775251676490; 
 Fri, 03 Apr 2026 14:27:56 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd367bfb1sm6646375a91.10.2026.04.03.14.27.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:27:56 -0700 (PDT)
Message-ID: <b15dcf6e-020c-44b6-8592-6a4279a37aaa@linaro.org>
Date: Sat, 4 Apr 2026 07:27:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 3/8] accel/kvm: Expose all non-target specific
 declarations
To: qemu-devel@nongnu.org
References: <20260401201753.92290-1-philmd@linaro.org>
 <20260401201753.92290-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401201753.92290-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 4/2/26 06:17, Philippe Mathieu-Daudé wrote:
> None of the declarations guarded within the COMPILING_PER_TARGET
> checks use target-specific declaration. "cpu.h" is not required
> since some time (maybe commit 4fb54de823e "meson: build target
> libraries with common dependencies"). Remove the restrictions.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/kvm.h | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

