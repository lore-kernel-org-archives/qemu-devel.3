Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF49CD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOfGX-000273-Or; Sun, 17 May 2026 13:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOfGS-00026o-5M
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:26:56 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOfGO-0003p3-2g
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:26:55 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2bd8c4aa911so16314265ad.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779038809; x=1779643609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tcCxoDkBkYJHWH/amTOpcAWrPp0fn8NCYthn5//+3vM=;
 b=efaREnB45Vc5PoxEgMIIn1ipAE29SgMsHccWDXFCppVlFlNq9cMMn/PpMGnyg6NzTl
 aHDrVLcoMe1xNx5beNZkL3OV0KX87iw8jy7vrv+qCJBxSPIIKPXMjsa89je7pitp1A2e
 fMXPsqbVEBGsdVMqTgKxZ6zNM3UhgjT+b57ABH4lF8q6DDX4BXMwkQRzF1V6cnn1axW7
 3qBrYsT/rmeL4wfk4g7BUBl7LH+LC8PtUm97lp2VVhWAGuA4d2uHQpIqTyO1dmqHirR5
 fefudv9jqV421C6iETS6PcJjcQWj20p3Tk7dxhN3xhdL2Uk6tbYdxtbNIGMi1GaIua6c
 ISBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779038809; x=1779643609;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tcCxoDkBkYJHWH/amTOpcAWrPp0fn8NCYthn5//+3vM=;
 b=NnPgAX/vQ1Zqjo53//dJF4sg6zIxedBcWX5FvNq8Z9XSlzv841TOu7exRwE66Acs4F
 3E3PlvRK4gkcNqA7pW0qmucx/NJDvtrYNWHQuNDDes/8etk6FWeGd10T06hq1JVdHjHh
 EmD8rZ6oSRH/BfCxVmTwx0g/gPtLTqTN+nd35Pm/mjNHY9Fvg/nArK/zjMpefdTfVPI6
 rDHWVQNP0p7XdJBc9VUMzA4uqzeOptrJgEuygTW1Rq28yYRKpYmmiw3BGfj5b5XDCK83
 A+cFKedVqNHvFZmG0A0XqhLfkvCSRbcNVqWcDE1fp+f38hfL9tYyBhH3O+AeGEYs0rHh
 LNbQ==
X-Gm-Message-State: AOJu0YwbC2TfeDLBGGSGqdViiHV9rhDQSW3CnbFKjkBCQ7uOB+qPMwtn
 oE0EK03XWWNST4IDtD7VrEg8Zh9CG/dZaMfmGw8zLVFXhcnYMkYhiAT2c16YWgcsWbq5m4RbNTT
 yVhdg
X-Gm-Gg: Acq92OHi/7dTEQnZesIaWqD20hn5MJSwGkRTWeW8UT3tdfUxvle+m63L0WJNC/ruk6x
 jwmqFUG9LkFAMUqBgGF0ui3MfJA7sKFlZu2Jx7KkAYhKF4UYFnH0yjSexCNRH+HvXOwdLIKG0ps
 ho7sqHSR0PS18IYRpFEo7jTjtxChDLyk13Jc9Nq3i8xbsichHj2sCd2lkPPlqDqSZScUzc0gh7p
 Sa6wmYkmwOFTGbytz/yJtlAr/wQSRANtNw0bTMosX28YFBizwqe8iDi1RquboXHxZRskCVqFfTx
 tRe/m34ma2Kj64o04zbaDR0tHJA4/w4OH0eraiTkN4zXj5KIJGtq3L32cL6hI/N6pVUhYD3o8EV
 tFQwvGIAgw9V+9tQ+jbV3ueDL9qUKpbjZTbZo0AhfL49HASKVbY+8Y++A90J0FB0cC00a1FWY7E
 lq7+hmNGX5ykECz5PEb9EDTatpVjc7LyeqIYSV
X-Received: by 2002:a17:903:40d2:b0:2b4:5f69:715d with SMTP id
 d9443c01a7336-2bd7e8f07f3mr131504105ad.25.1779038809176; 
 Sun, 17 May 2026 10:26:49 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5b568cefsm125283335ad.0.2026.05.17.10.26.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:26:48 -0700 (PDT)
Message-ID: <e94dba05-3457-45ff-9ce3-15dd26b12da1@linaro.org>
Date: Sun, 17 May 2026 10:26:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/35] target/mips: add Octeon MTM0 instruction
To: qemu-devel@nongnu.org
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
 <20260514-mips-octeon-missing-insns-v2-v7-15-226686be4ce1@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-15-226686be4ce1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
> +static void octeon_reset_mtm0_mpl_state(void)
> +{
> +    TCGv_i64 zero = tcg_constant_i64(0);
> +
> +    /*
> +     * MTM0 defines MPL1 as zero; model the architecturally unpredictable
> +     * MPL2/MPL4/MPL5 lanes as zero for deterministic emulation.
> +     */
> +    octeon_store_mpl(1, zero);
> +    octeon_store_mpl(2, zero);
> +    octeon_store_mpl(4, zero);
> +    octeon_store_mpl(5, zero);
> +}

Thanks for the CN71xx docs.  The fact that MPL1 is cleared with index 0 makes sense, for 
backward compatibility with CN5xxx.  It's tempting to set the others to 0xdeadbeef, but ok.


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


