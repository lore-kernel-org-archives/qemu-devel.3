Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB08FC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UqV-0001xp-2Y; Mon, 28 Apr 2025 16:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UqM-0001mP-HZ
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:12:48 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UqJ-00012o-IK
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:12:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so5356382b3a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745871162; x=1746475962; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Bbp1Zyzr3/k4834TbycDFkjzTjK/CdmW1/B0B0JyFU=;
 b=YbF4epYqQ8Bpy1aC7N5bLmF4MJRB5Itn3clK4yssOr+1qAZOPW3tNr37oNowTBBqTG
 8yP2l14lMk5EW+188bA6swzrV1ix77mLGQ4xByZAtSTPKdOKr+GnMwg43rEARiFrPkUy
 hs7xxXPnJCOHcTWpqeItWjdUxJHwM5NrulfOdI3jTJ2ADX1PcLz01yJSk25GiiBJ+T4M
 0AccetreJSumZWruZuBvcM6ZhaI7uQB+7yHfTF+eSczcLimwrY3udHP3MUKbTLML8jsl
 D6JzpiUtBwhYHZHYZ5i0z0GvHE7kz1p1eTljUge0UCCDDcQuSymVNyG1yJZQMtt5i1Y2
 MYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745871162; x=1746475962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Bbp1Zyzr3/k4834TbycDFkjzTjK/CdmW1/B0B0JyFU=;
 b=LnIY4W54KGYdVm6bk8v+slAaVLFz04m6T4KD6FshlX6PhlmJZYELY+oUv0Nu/hmMCF
 rqPH1bgFzHwNL5TwIhyd2zF5y3x68vCELpPxzuAnaJW/PosjBY1ciDZXlPtYzgKqGAH+
 SrG9A2syjYM4SZer22zPqiT7ibFbRRVlWfuo0DJoJetAMbXMVZs7smsp7lHf67yg/Jhg
 kMKXTcJCFQYJS8H9UVdlsBe7d1fXe1zNP+9MyOsOo+IQWXHLrmiOprIgrspw36aycccB
 VQayYK4dhcwNpTV7627zN94d+igWqjdRVJcpw3BGWoXNOAjoBXAzeOiuSUd27Sc7lvW0
 izrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1P6eZPaQz2OslvsviEPAmRBB4AAHwIodj/lJ0NEpeFVg0mr+OKvppZ5ogPH6N3obdGpVLodFMso6W@nongnu.org
X-Gm-Message-State: AOJu0YwIdG8q6Q8KHV8uvKU1R2aFWrZJyXXiNxT7GFDdc+3I3UZWVXpF
 y/XVsY6yfpVC5AoQKV0uw+G03OAIwf9Yyc32DJCozo2X/TAaZuwasXvT+VCFU1Q=
X-Gm-Gg: ASbGncupiJbm3wqfAZ1l8xYnPtHaZVTsuBE45lkiDxaIwl3mK5NtCL4MK/m3Mx/9+a/
 eKaBvXbf+AMZXMm+mukduj8EuqtNEyTr9nUc7WiDRRFzfNEzoxMVI7VDouLKfkuz/vDdAvNXUt1
 daXpW9Rw0vjTLIIaRZ2aAc1XfEoh+XooAggH+/qLNxO0C11zktnmFqDoZann5X9gFVbUZlK2VG1
 UbMnajIOBd5YksP8h9wXBh5/PBqXGI55cvIKnKuxsyPziwYaPRB+3TH6bycxA5I1CckUYvW2Ai4
 7ydsawjk+1fV1+KEB90KRmHtbRtqJ7fif6NBxnWVCuyIB2PRcT7hZSTLuAtI0DMU7R4Aa6jdX9t
 sjEIVnE4=
X-Google-Smtp-Source: AGHT+IGhWBvg0SS5BIR9B1eKJC20nLvWTqHeXf9bkSbMLf9xMnfsj+lAX2e66ZX67+PVnx9GNO1s2A==
X-Received: by 2002:a05:6a00:892:b0:736:532b:7c10 with SMTP id
 d2e1a72fcca58-7402722d7fcmr1468257b3a.21.1745871162040; 
 Mon, 28 Apr 2025 13:12:42 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25941d65sm8743626b3a.63.2025.04.28.13.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 13:12:41 -0700 (PDT)
Message-ID: <ff38607e-0b1e-45df-bbc8-fb4ae225239c@linaro.org>
Date: Mon, 28 Apr 2025 13:12:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] include: Remove "exec/exec-all.h"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250424202412.91612-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250424202412.91612-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 4/24/25 13:23, Philippe Mathieu-Daudé wrote:
> Since v2:
> - Removed CONFIG_TCG #ifdef'ry (rth)
> - Added R-b/A-b tags
> 
> Trivial series moving declarations around, emptying
> "exec/exec-all.h" to eventually remove it.
> 
> - Fix accel/stubs/tcg-stub.c headers
> - Include "accel/tcg/getpc.h" where appropriate
> - Extract TCG IOMMU API to "accel/tcg/iommu.h"
> - Extract TCG probe API to "accel/tcg/probe.h"
> - Remove "exec/exec-all.h"
> 
> It is based on "accel/tcg: Compile tb-maint.c twice".
> I had to fix its patch #12, so I'm including patches
> 12-15 in this series.
> 
> Based-on: <20250424011918.599958-12-richard.henderson@linaro.org>

Thanks, queued into tcg-next.


r~

