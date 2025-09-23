Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4506CCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0sUl-0002Xb-0r; Mon, 22 Sep 2025 22:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0sUi-0002Wc-TW
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:11:05 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0sUb-00009a-Le
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:11:04 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-77f1f8a114bso1909739b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 19:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758593445; x=1759198245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s4+SlQx+DMzy+4DCfZxmwJDvy0AC/rcKOjjhVaXW8is=;
 b=tROlP25o3avZ87b0NeJBAMaT+xBEw+VFa242Un5ERN5NItxt0UNcMl7tSwuj4chFLO
 OxuUPHpLTDu4R122GM/8DhY0RnxoKbkCtR0dAlj25HbURnK5HkYGAP23bSn++yzhOTuV
 py2KK+yV8xsMRF64CsLF9lVu042YRFBXSG04Py1PS7DP/DY7aMBqNfevMMOLsNQwCZTV
 9Sb5fUFnga3lm78AjnYZober51M9l3Z1dvpnC99FNr3yNZs2LRRr3DOFGuRdkkX9k+zU
 XyBQGotbuLcQZ/KcNsXLDJ53WKDKkcSea8jB1NBtq46OjJdoQZ6PoDgUTk09RgLFX0Ta
 G7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758593445; x=1759198245;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s4+SlQx+DMzy+4DCfZxmwJDvy0AC/rcKOjjhVaXW8is=;
 b=HuW/5Qnw3brbVOzGlznPNYnmsQyhmh0VG8E6afqmrhKX78VqV1sbYT89DZwC9xf5yf
 c3l5v6kZDsvvOW/ZPTkqxux0UyCH2RTS9igoyDpifwsy3gCVqprim6l/Q1gPqZpOBmKq
 X6Ik+9wAGKeVFOA9LtiptyfEef7EmXWbuBCJ/FPEj7QXzQ7VsrbUTS54gxX2mPwCvjrc
 fmXOQqlj2t27oAb+74mLnoTRE+mPdPy4g+hyM0eZM8JJIxaK9JYYg4ibLyzFzL8MA8l3
 bsF7TOs5gFyI5zLj8krZG0nj7VANK71CTwj9PtYVW8Ib5FlFPtLQ6Sut3WqF8HVj3DBN
 H+vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhUhyJUu4+0yizfbltgOOFhGBMhscGbTC6Yp4DgO2hg4KF1ykDRtPm5ls3rqfbAf31HS6QnKH/v8xH@nongnu.org
X-Gm-Message-State: AOJu0Yz7DnY/glD54Als5hqRiYczxo1REH3f/R3c999a9peJnByrex/I
 uXx8DlS9q/rT9a19E/Fg9IZZpTbWf5u0QUJ/98RpVVHRz0mvV8tww6ARpuM/PoPmbvc=
X-Gm-Gg: ASbGncvvIuaJZwCM+ZdyuKMoKZzGLILBRO4a51P51koJbdAqfLrHIlt/BwHpYm8fkrX
 ACF7WZNKDWW0VdAGJ5ytOpOuXjh1FQlnGmhym6+2DazXrZfQkUIpMvrdrSR/R4caHKCxGoIPwuz
 OFitJ5VwubDNj0J7fN/YlymvSLdypzlLGZlzhx5JQTl7BC8CqzbjM55p1uReFVZvLtYKk4eDCMb
 k0fDA6iqs6WAXYEvtml9y4M8CVR3q1RsMYMpiohF3dIxhojcCOX5HLtZNCfWFOlk8XD+orOyHjH
 xidx3+wumPxe/ZzN7Ls7CsBnMATLhPnbZHVX0DE2F+O+4RqKyaTH1hng11eLZyMVjhykbjzlUml
 3g730GtnmkIawtzCnfuSt3MLrmmHakdRojlIw
X-Google-Smtp-Source: AGHT+IGnuP5BsIL6t8f1XgxP6tQ6pTsRRSiXj2y3bN9ZlJyC/DgmPkH1te3ywstvmQeNrB6aALgo1g==
X-Received: by 2002:a05:6a00:2ea6:b0:77f:37a5:97b6 with SMTP id
 d2e1a72fcca58-77f5486f60dmr875260b3a.6.1758593445333; 
 Mon, 22 Sep 2025 19:10:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77ea933bfeasm10715652b3a.53.2025.09.22.19.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 19:10:44 -0700 (PDT)
Message-ID: <455f0e94-4539-494d-ab8f-23c7832a991f@linaro.org>
Date: Mon, 22 Sep 2025 19:10:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: fix self-modify-code problem when modify code
 in a single tb loop
To: =?UTF-8?B?5p2O5aiB5aiB?= <liweiwei@kubuds.cn>,
 pbonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: kasperl <kasperl@rivosinc.com>, =?UTF-8?B?546L5L+K5by6?=
 <wangjunqiang@kubuds.cn>, Wei Wu <lazyparser@gmail.com>,
 liwei1518 <liwei1518@gmail.com>
References: <tencent_55B681D209516B8364F39BD9@qq.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <tencent_55B681D209516B8364F39BD9@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 9/22/25 19:04, 李威威 wrote:
>  > If there's a problem with 1 tb, there's also a problem with 2 tb like
>  >
>  >         jal     zero, #4
>  >         jal     zero, #-4
>  >
> 
> I tried this case. And it didn't have this problem.
> This problem seems only existed in single tb loop.
> 
>  >
>  > But unlinking the tb should be part of invalidation, so I don't quite see where the
>  > problem is.  You need to expand on the description of the problem.
>  >
> 
> I think the problem is the single tb is always in use  when the single tb is linked with 
> itself，
> and it cannot be updated when we update the code。

There's no use count for tb's, so that explanation doesn't make sense.
Can you please share a testcase for this?

For extra kudos, a small assembly test for tests/tcg/loongarch64/system/, so that we have 
a regression test for the issue.  :-)


r~

