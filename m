Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62177C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7H0b-0005eW-SB; Tue, 22 Apr 2025 13:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7H0W-0005dB-So
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:02:07 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7H0R-0003J7-9n
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:02:01 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso112355b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745341317; x=1745946117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6tmBALkynzhhKbW0G2v1RBac1LIEpizgjgHZ0VeVJkc=;
 b=fckwkKxfXu7S1laq3bI3x7arWuS14dd2UYiiygSDJ8SrVdZrjFCUPP1PyTKS/LEBPF
 YtRgxt6SPFCC2b5jBeGfb6+1AfbkdgylkEyT5zahnqr9PQzA6xvxDQziinFqLoUWVlX6
 i2l7dkuFo9qJb8DZpImrQ1X40mJ80OXIUZpQJc6Sca6cxUXAr0xPjWpBeL2vxUyg8rXi
 N1W5aJ0vv7hWKeurwisXa5Gjr5jvF9RuC27kd1MzAEcgv1rMdOnlCsb+JuFVcyjYljRg
 l4J+ROWCANGDP1DPkmGQUEb8u4nhBSTwyTcr5QpiJ8raHi6XNGSaoXpg9TmL3+oPaAff
 ZDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745341317; x=1745946117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6tmBALkynzhhKbW0G2v1RBac1LIEpizgjgHZ0VeVJkc=;
 b=UpLoXQsJ7cJPG80NfwofJmbmEylBq0D0nQNDQA+sxS8YFNUL9C1WyQqgWgc1gns1Vf
 abZIj5Vffhe8SkMQ1wvsCa0LfFsECqDMxWzwVCTfnU45hpNOxJyIL5pAu9HMT9vZ2Ccb
 pPhFBSNbaNrPqOxX8l5u67pce2cdnU5uHzAKzaxeWBJmJekB9gmWa7DOfvDnxb4Cca4u
 E9wr1WyPcvdW2SzeKQX7pBkUD1ujrVT7Kn+m35z0xZ97WuiFaYGhosuyoS+AparDfuBu
 mQcftRbzWgX+vt2tXAdHSbeyQJXgxjkkAQmvHRekUUNbGu3QMMl+cS2koIe8jma3UPdL
 bNtg==
X-Gm-Message-State: AOJu0Yz3SeXKNUTVGjy/AyXun2+BETHbqGrgAgkPo/KBxBep46bDHBoE
 JFSR9g4asq/bIjnQNNajIYLkOA7S7k9HhKYax8Xv3jlEi0hkPgwt1q7XpeaA13Qv85P3yGmdMzT
 4
X-Gm-Gg: ASbGncvqLy8deZMQk6sFrewoSUS//446R09W6WjnRzLXIjKPjjLB/IHBkzw+hdCVa3G
 jhbD0XiYLb9zxAt69BMZ4JjOFXa9fLRiKU7OAzPloGKqZbghGbRSDWmheFde8F10+REkxHbX31u
 7ktPSxwDPWmcCUpyX8mAWgp/1pRt1/HBbohQ+1HcqCu2E5FPZMaFsoba7W/ybVGtm0TKYd9SSH6
 wshyo7VSIAyK8tX39hKg/R90UuKb4nfdndSQvEwUimRhb2Xbx5chUAAS3uFshqnt4PoWhVWmgeo
 WxqtuKvCUJyltA5ZJXC4bNC14ybKRalxjQeVBUoZbZ/dg/8rRSmnaouxZijzJKAYA5E5DDr5I8k
 v/Cfcahs=
X-Google-Smtp-Source: AGHT+IGiCD6YDMors182NAydhOwIeJKbsvf6AwvWN6JaWsCs8PHir3XDUJjAzM4iguYhCEA49TK7XQ==
X-Received: by 2002:a05:6a00:4b03:b0:725:4a1b:38ec with SMTP id
 d2e1a72fcca58-73dbe4e6458mr25374354b3a.3.1745341317419; 
 Tue, 22 Apr 2025 10:01:57 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfae9885sm8882224b3a.158.2025.04.22.10.01.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:01:57 -0700 (PDT)
Message-ID: <4b43396c-2404-412b-ac73-719565222297@linaro.org>
Date: Tue, 22 Apr 2025 10:01:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/i386: tcg: remove some more uses of temporaries
To: qemu-devel@nongnu.org
References: <20250403092251.54441-1-pbonzini@redhat.com>
 <20250403092251.54441-6-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403092251.54441-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/3/25 02:22, Paolo Bonzini wrote:
> Remove all uses of 32-bit temporaries in emit.c.inc.  Remove uses
> in translate.c outside the large multiplexed generator functions.
> tmp3_i32 is not used anymore and can go away.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 43 +++++++++++--------
>   target/i386/tcg/emit.c.inc  | 83 +++++++++++++++++++++++--------------
>   2 files changed, 77 insertions(+), 49 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

