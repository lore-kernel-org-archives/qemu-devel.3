Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F95E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 18:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL4eE-00043F-L4; Tue, 10 Dec 2024 13:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4eC-0003wv-Jf
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:07:48 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4eA-00027o-Qh
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:07:48 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71de0a43937so975740a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 10:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733854064; x=1734458864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OftDPk6XhWs7KS4awrmFBNEK5eyiQDSSRzc4xi8vJbc=;
 b=MyJWtuPumMVixD1bvKwnIXFqTuTiGwvr2QUCy9URnaiDyG/Ib4bYsWpPRm3SdMd9/H
 fhMWp+FH5S5GaKeRbyG9T28BCYgjk92FwQt0MS4zxqJA0oOVumroGTGXCTra+RMYG4jd
 DEkvLgx9dxQ3eJHpsMlE38WYNsO28p9kvVma22JVsOupp7b7oYWhFTkOYOXy8qn5hV3I
 SsntYUym7leUfvttjz8kMyrHn7Z1MIp+/WAGDq1VXJzjT00qEYWJlCkpSKlHIGHQT36x
 G7n4U4vFUX51FS8K3M+uuitJTxwb6xFzdXjGf9scNN2pcCTu0v5id3YDBER1KEsigo5m
 cLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733854064; x=1734458864;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OftDPk6XhWs7KS4awrmFBNEK5eyiQDSSRzc4xi8vJbc=;
 b=GrTA6D0fskqXMmrs22fj6WdxClr93GVxhqnDZYFHVIc02R/m8iEBsbX5vCw7jIQZ0B
 c4l0Xr2R9jDylV1h4Ozb62BJ2jmE30z4gPMh85a8+cjvTGe8AecB986VfrWOaMrHlx0Z
 PfKu3gp/7oQChu7kxCr5W6UXs7juuz6D5vgAQ+smGbyRxyDTdmXrijRK4a6EOUpxYEcF
 5d7QGR+BCgB9lfKX/XCerEkFCy2Uke7QYSZ/BcC+X0KFAa7+//f0UPhYOk14/v52qCz6
 uBIKRSsMYUHRafni0jeonAz/hycTBPAi0x5sOh0fQrbFjSA+fF4KRGCVd3TJN5HB+dkw
 Vz1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ2d6HtVK4sT14dMr6yFxnHXs/O/MS92QQbBCU61VVQagfWjZnz7NPTYTxZvt2PSEBKIrgGmSnyRdk@nongnu.org
X-Gm-Message-State: AOJu0YyZvIRIZ9rcR806OrTHPSVO+d6UvKnzTq5XFBrB7Re95Y+MjsNb
 35pTWmiTbkJKUS4SaTavZ75sy0njS5z6epPLDr+ffnS0lHxs8m7fHlZmEbKtg1o=
X-Gm-Gg: ASbGncv3fM7jIWVxHiI1VhoLuLneLAbS79EfRegkjTlvgNymWr16ndTCMh/siCTX+jt
 PlvS8G7yuUX2iBQPj9uuGndH397Xg2HAeqIG5Dx4FL2qMBPdcf9ZP2VeBK35ez9m9wENGH76Ts2
 wOmTFdp6581C+DNwdZLcSC5vbKoqCYwDmU6gR0arfGe2cRfg08rd2BrHjCcCxxYfT0cSPk0nMfO
 JF1PpR3G/5sMaiqLbCd2MOVTK1F1FLg55GG0MdbLaIiVXDvCzw+yHmFw0XeHYLMAYGJQKE=
X-Google-Smtp-Source: AGHT+IHjFG2x490iHqAR5yNnyZGYAeI9CCGRBXxGVkTIwMm8Sz4F3EX1ltnb7ZNPbSz4niMTafEgFg==
X-Received: by 2002:a9d:3e04:0:b0:71e:eb1:f75a with SMTP id
 46e09a7af769-71e0eb1fbb0mr943635a34.21.1733854063978; 
 Tue, 10 Dec 2024 10:07:43 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dfb48c19csm922045a34.64.2024.12.10.10.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 10:07:43 -0800 (PST)
Message-ID: <0b3bdfa8-78d5-4d4e-8331-1502c85a7eef@linaro.org>
Date: Tue, 10 Dec 2024 12:07:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] target/arm: Move some TLBI insns to their own
 source file
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
 <20241210160452.2427965-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241210160452.2427965-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

On 12/10/24 10:04, Peter Maydell wrote:
> target/arm/helper.c is very large and unwieldy.  One subset of code
> that we can pull out into its own file is the cpreg arrays and
> corresponding functions for the TLBI instructions.
> 
> Because these are instructions they are only relevant for TCG and we
> can make the new file only be built for CONFIG_TCG.
> 
> In this commit we move the AArch32 instructions from:
>   not_v7_cp_reginfo[]
>   v7_cp_reginfo[]
>   v7mp_cp_reginfo[]
>   v8_cp_reginfo[]
> into a new file target/arm/tcg/tlb-insns.c.
> 
> A few small functions are used both by functions we haven't yet moved
> across and by functions we have already moved.  We temporarily make
> these global with a prototype in cpregs.h; when the move of all TLBI
> insns is complete these will return to being file-local.
> 
> For CONFIG_TCG, this is just moving code around.  For a KVM only
> build, these cpregs will no longer be added to the cpregs hashtable
> for the CPU.  However this should not be a behaviour change, because:
>   * we never try to migration sync or otherwise include
>     ARM_CP_NO_RAW cpregs
>   * for migration we treat the kernel's list of system registers
>     as the authoritative one, so these TLBI insns were never
>     in it anyway
> The no-tcg stub of define_tlb_insn_regs() therefore does nothing.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

