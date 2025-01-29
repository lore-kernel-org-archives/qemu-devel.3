Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47110C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcxFd-0001nv-Rc; Tue, 28 Jan 2025 20:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcxFb-0001kt-6J
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:52:19 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcxFY-00066d-Rg
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:52:18 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216395e151bso3310275ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738115532; x=1738720332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D64jGEEyBGtk6LYPrT5Ztk8EvEwBKnRd8hkOogNWys4=;
 b=SRYegu0dADZIJwBCrsnJXxmwwoDKicAuqVJJKNmJjCqzGUQ7Pp/45J3zAXXfFCO3eZ
 PrbZpN9K9UbceXESGjo7iXPldygbzi6xIjx/bnyNIKepGvFPZ3bFqcCzXLkz32EeAFGz
 DhccqlR/aMZggolkZp6xRN20YaqI1OxvM3y9AAI3z1+1xvgWswPsJ5TiLBtsUvQpT4yy
 z1QrShlvD6ni7CzDfA9JjaDROqRkj23Gyuvl8Q7Ksa772jSp73AWMarnRKG/9vvRRLav
 J2mLVBlEVFo8MuuIg70/h9mzryOtaeIGbKmiYi2DeJkxmzp+8t7toQjJDgyp7GQHLknj
 TOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738115532; x=1738720332;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D64jGEEyBGtk6LYPrT5Ztk8EvEwBKnRd8hkOogNWys4=;
 b=sUFoK6oxzl4uyQpCCckt3yyx866wnT7iHXA/6k7o9tMqERVUul7AxCrm0id/pWi0og
 g3Uu/lMuDD5cm2eLdTimE2zTxPJFsY5Pi8swqrJH9b+ozPDABZTTYRXhoiNR5ixN0ZyL
 59G6/TdIS1ARpJBQBNZPcWBskL4k5SXATW3pW5z/KDKhwhgBYA5cp8OcFWO3M34x8pm9
 OgiPdXMqsqieVxzUDjWr46y4DqblsL1XoYNxDM+rylkSUOMdwVvRWK+jrxVFvAznP+8u
 3X3NrEPbISN/c5lESHmOlFVxJX8HTapZhtnwHU5mcICYCALJvzIVxYX1zug0HUj2WTRH
 efVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1KH7IU4PbWsskBe03HXLOzHKU21svKdAQSgQhiHNk5WxguJGn6mMksslcod2qfGuTv/nSZeL+jhwD@nongnu.org
X-Gm-Message-State: AOJu0Yyd8CXenDIRBxTOdSIQREKce0Al4mjD+p6Bbv8dRHnelAxmaSBT
 ++TveBXJqr1SsmDCSJar0rmsI9EIarfRiE/gjjbC5L16S/Zhoob40D2V8FzW6ak=
X-Gm-Gg: ASbGnct4fPwavH7zEaRQWJaQ/q35su0SWnXSYh9h++r5k3SAfJ25KgXj74I0zqVikV7
 RTaYnrM6Jgu1lvLv3TqG6mPaRK9d8IErShHoZxi7JLzLccpUeHOf2ZqV03iXU5gPGZZ9jY57cZO
 geZpM+bo0cK6GZDuJV7Wxx1s0ML8EVQfYC3v9tUj6EQPK8+8L6maJ/fOBM57L6oD7lXmSWg3ley
 vkltdjaVfdryTao35ZbiIIeReP4yddbB13Til68RcnlG8tLTUmkGTO1zet+jePP/XKpBFWSVxuE
 Zv7WY9/uAL/g25WdwEFNFI4FPUjKBwybo5S3GNfPwWpCatM2ARNFF8FXIQ==
X-Google-Smtp-Source: AGHT+IEcANCNxz86k9MIEbqr6EjDX3w5KxQwaiMTdb305WjXmIXV/4RB33x5t39ljXZIKmE03CirPw==
X-Received: by 2002:a17:903:1448:b0:216:6284:8a00 with SMTP id
 d9443c01a7336-21dcc43a6a4mr85464665ad.2.1738115532503; 
 Tue, 28 Jan 2025 17:52:12 -0800 (PST)
Received: from [192.168.0.4] (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414115fsm89057585ad.152.2025.01.28.17.52.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 17:52:12 -0800 (PST)
Message-ID: <34f4e42f-b08a-42dd-ad11-f720f6d8a440@linaro.org>
Date: Tue, 28 Jan 2025 17:52:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/hppa: Implement space register hashing for
 64-bit HP-UX
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20250128224817.24715-1-deller@kernel.org>
 <20250128224817.24715-5-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128224817.24715-5-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/28/25 14:45, deller@kernel.org wrote:
> +    if (ctx->is_pa20 && (a->dr == 2)) {
> +        /* Exit TB to recalculate gva_offset_mask on %dr2 */
> +        ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
> +    }

Where does this update happen?  I think you've missed that step.


r~

