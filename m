Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50959C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwl2-0001uG-43; Wed, 19 Mar 2025 12:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuwku-0001pv-IO
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:59:03 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuwks-0006Wr-RW
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:59:00 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2255003f4c6so131621485ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742403537; x=1743008337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sk2fzWLVoyYBATG+j5WmWy9Xk6JevY86zGPzQBXKr7Y=;
 b=WW28yKahH1KDrZxIBGmRAyMiAeqcd7F7uwSCUvaotkg9b3zeJbcbxcYOVPR5xsD6pq
 xM/gXZSYmbEDn3DFG1t+VIq3xBFiQhIXx0i4rgPpunvSlLJByv1mVQHU6Fiubl+9TIZT
 J58N8D/nFvlcNLLmjanLPSPV8dGvQtvbZ5PDkOhh8cyuG8PTKr5Ht/W/Y1vptnirLTZb
 8r036bKSHC30Tv1bVXTE0kCGYT6ezu3Ow07TQuSF6uYgFRDyUkG1+F04goCVnTBABVit
 PtgLoUIq5zKC3GE8nZz72QdxGYldFv2Y5j7BMMNz88Bm86sZq5+rbrRj35elxYiBkDsq
 A8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742403537; x=1743008337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sk2fzWLVoyYBATG+j5WmWy9Xk6JevY86zGPzQBXKr7Y=;
 b=U18XFhWAWUIukgv6J7YaMvDhqyNTE6e5KLK6hWSwL3xX6scxs0whH1ogI0ga/WQ+Kb
 JMi+onv8WT9ophP8R6hGinMZ3L4wi258wzmT9DDpVB7vcagjsK7ii1gyAGK/Z/n0/XVP
 xhzESCmZeS/c5Offtq3OsWHmC9nTNBCi3ulf4qwJwFPI4gS27NVqF1cf13w1KBHKRTdY
 sGh/KFIgGPX7An3OQAAbbBy1y80XD2Q1NliFVS4fKM/IfU7KcVEfYHDuMmeRNzD8QP5x
 PJAzfdmzQth5g8cf8hdZyEYWKYDiZZXkDWrhiHupOneBxJ0GojkLQ4tUKDsZ/ScX2cuy
 2Alg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbL+wvM8+BaLsGzZRMLZ0tyWhNjE9CC6Y46BHAOaWOYak2v0MZICF8w8xbjPwFAJ/Zq56+2Zo5VwGl@nongnu.org
X-Gm-Message-State: AOJu0YyUo+531p1MybDQ1Je9fFX+thEEBjMcPQuVCngpUi7nTMWgkM/2
 dRhJkN0XbTLhmJuJIeNbmCTMRxkz+2i8eNwEBb74DOlvhZhKprLAjsN30NW97I0=
X-Gm-Gg: ASbGnct5FmAETaNmjxFGzhEO4K5j/zgu1LZBpnIhEjdq6A0SZDkzQReD2DWX5vQYA4f
 uGKRZPXFNt7IxUT+BQEWCPhoBFUxw9tg5zm1ZapcHx6fcOtoqPq5SabAjMI/7Wk5QQJK7Lm3KrA
 Gj4LSDy0tloOLDI8fU+g5AX/FL7QdqefGH1yHEUzXJxK7HngHW+TplTYPfI2Mob8236PrnwgsSB
 vSDccXjF3iTUnrIUE4YjA/I6K0+Eb6Y5u5oVzkJNzbLJ6J4xeJrl1JbZExve8zykODT+oxvP6SS
 fpdJy/BqJaqWS/QX/8zQ0SZ1dTWcmt/21SDlbxUG8jSyysTCH2J7PiPtISY9U6oId9R0J7d6iko
 3uFOiiSPN
X-Google-Smtp-Source: AGHT+IHK1BBRTbsoxcDf0i8PMOLHSLAgyE8vz5aEEEOyT732PIIFKSsBaSU3nmJwomtJRIAB51LQ9w==
X-Received: by 2002:a17:902:e88f:b0:224:255b:c934 with SMTP id
 d9443c01a7336-22649c96c69mr41278875ad.51.1742403537159; 
 Wed, 19 Mar 2025 09:58:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbe833sm117060165ad.183.2025.03.19.09.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:58:56 -0700 (PDT)
Message-ID: <64531a80-822a-4d90-8731-0e632e7f8da7@linaro.org>
Date: Wed, 19 Mar 2025 09:58:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/39] target/hexagon: Implement modify SSR
To: ltaylorsimpson@gmail.com, 'Brian Cain' <brian.cain@oss.qualcomm.com>,
 'Sid Manning' <sidneym@quicinc.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, "'Matheus Bernardino (QUIC)'"
 <quic_mathbern@quicinc.com>, ale@rev.ng, anjo@rev.ng,
 "'Marco Liebel (QUIC)'" <quic_mliebel@quicinc.com>, alex.bennee@linaro.org,
 "'Mark Burton (QUIC)'" <quic_mburton@quicinc.com>,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-6-brian.cain@oss.qualcomm.com>
 <017101db9763$41ae4ca0$c50ae5e0$@gmail.com>
 <IA0PR02MB94862E1C5171AC300C64DA1CBEDE2@IA0PR02MB9486.namprd02.prod.outlook.com>
 <026201db9839$f4bb6040$de3220c0$@gmail.com>
 <2712e0cb-72a3-4c39-82a4-4b5f6d4914b0@oss.qualcomm.com>
 <02ae01db98ed$6d15add0$47410970$@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <02ae01db98ed$6d15add0$47410970$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/19/25 09:39, ltaylorsimpson@gmail.com wrote:
> I caution against putting a level of indirection into CPUHexagonState for the HVX registers.  The HVX TCG implementation relies on an offset from the start of CPUHexagonState to identify the operands.  This would be a very significant rewrite if it's even possible.  I don't know if TCG's gvec code generation can handle random pointers or a level of indirection.


Not yet, it can't, no.

I've been extending it for random pointers because of Arm FEAT_SME2, wherein we have 
indirect addressing of matrix slices.  So we wind up with a pointer like

   &env->zarray + (env->xregs[reg] + offset) % size


> If the behavior is undefined, we can avoid the copies.  Then we just need some bookkeeping to check if multiple threads try to claim the same context (if that behavior is defined).  If copies are needed, we could keep the  hardware contexts as shared a shared resource.  Another alternative would be to track the current owner of a context and copy from the previous owner's {VQ}Regs to the new owners {VQ}Regs.

Depending on how you answer these questions, I could split out the TCG work.
But in the short term, copying context data might well be easier.


r~

