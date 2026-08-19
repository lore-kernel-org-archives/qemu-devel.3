Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDEAC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmlS-0001XE-T1; Wed, 19 Aug 2026 16:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmlQ-0001Wo-TM
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:19:56 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmlP-0006dn-Hb
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:19:56 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cbe827e3cb4so1448275a12.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787170794; x=1787775594; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sfdb1dzdnoBwIpbZ45e8jxs15t/r3s/rCiyhXY3QLm0=;
 b=W8zuDRcZXFDmtQn+IKg4vEk97b22zx8litnKs6WPStGgabGIJCZMkT55kK9q78R5Ae
 UBsRh2Y1/dB1ZxdFSnw4u4ke47VLZGEuMqoBAcHXZQ/rVoJFhDv8Xjo/RSEQE7/AIksa
 JnuDZ/8rMtsy3JXoZtKOhhswP1AOL4a4ggnkFMpWpD2TwvOHlcj2gdSUpvKDnaVtAhgK
 4XL5RKpaRp5U+CKO5bALgTVswCJNN1ZMBkmfiENILfXWEQxT8w6amZ+ilHFKKEUWjlMb
 sS0iEhZy6BOQCk/UIvtVbB3IH2Ap3+EXbrdfoauMDkMWhG/Hsz171PwP07UP62RoVP1G
 TZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787170794; x=1787775594;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sfdb1dzdnoBwIpbZ45e8jxs15t/r3s/rCiyhXY3QLm0=;
 b=n2MZnqhcibYFV8GOpb3LD1Zc/6jIJXqGzHg8gP7O8u3YoBMQ9lqgsb0Afgwrq88YGs
 VqoDohhau1ZojY/AhrcjsfEk7qoibtzqmT77jGcUMdMD5mNb8r8zSOc37R+/sMfYOe9Q
 AxAeQtxHNp4ybC+c5WFu6ArhwBCKQ5gnUaxWGWyYI1v6/6mHgTCrpYN+Jo2kGmIGIl8W
 FA3ZEIICwqAiXS4eeVCf44hN5f1SVd/OiX69AzVNskbBBbxDEBuR9DLliXE/Y9W71q80
 qFe6ZBL+KtsBakcJnrahWbyhYge3y80K3I4fOYoTYy/NTcYPoJ5zdb7En4QItaBaAAMY
 reyw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbhEvj1yJamEaJ0dVZKkJY//wn/kdCIkqZoc02JdjNu5y5fFrvcJHhOq6RgEpvyYSwX1EnzaMBN41/@nongnu.org
X-Gm-Message-State: AOJu0YzZE8a+BmPf9pimNuz29EK3lB1/nkB4LRQMwdNvWFVUi3Cjer2S
 tv3IahDkgico5lzgSZhSydhb+/0SnUrrzwMOmur7JLXIBV2VWIqqaCuaNSBN/zgdV80=
X-Gm-Gg: AR+sD12JuUCKVbHkBEeW9TVm9ZCx4sfn86pY1fREqGLRwBLdcDDp/Ww2mjgFyvzAqDF
 Uy5SGFBK+zNwJFlPay+k/1kFeLwCmso6F0l7jkNdwDWD9yFlRTwLjx90LLtUz4GWsjxEfoTmz0L
 8xb0I/2g385fYnknsWkGl2/dFIJvt2KAoFZux15b7ljVu7xjuTiiUxLRzYWLuI3ninBNQinAOvx
 c/jBVBMp4OkrzVQRunZbRu3Og+FDVTLgzUCZZR/rX/L9bqWJ8ON0MATvJO0Rvu/ACW7tSF7emYL
 CK5ilKQsW4pQZJJsJskthczRnS+wogbtIDqIBV778dD/zNJC2m5XiJYtDNsz6cQB7s6eBPxtjxf
 ubB9ZPbZ6NAH+094xgzfblrgxTRKVeDCWr5VOCKIBs05XoCg3dWJUseM5LTtT1aTdBQticOWloH
 79dSlhofK+1cAbvzihaprV5uehCZ5Vg3jRfkibIj2EoiReD8Iq0wu+CeMKD7ralaKTG08gTi4Km
 sLTfDHr
X-Received: by 2002:a05:6a00:9093:b0:84f:a82e:d32f with SMTP id
 d2e1a72fcca58-851d38399e8mr13099795b3a.3.1787170794046; 
 Wed, 19 Aug 2026 13:19:54 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3389fcfsm997527b3a.18.2026.08.19.13.19.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 13:19:53 -0700 (PDT)
Message-ID: <7f100121-e4d0-47e1-a1c3-ad6c5be6862f@linaro.org>
Date: Wed, 19 Aug 2026 13:19:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] target/i386: Convert cpu_exec_halt() to
 transition_halt_to_exec()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-11-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819145649.23439-11-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
> x86_cpu_exec_halt() now merely checks cpu_has_work() and
> conditionally call x86_cpu_transition_halt_to_exec(), which is now
> the generic flow in cpu_has_work_after_processing_async_events().
> 
> Register both process_async_events and transition_halt_to_exec
> handlers to use the generic target-agnostic flow, and remove the
> x86_cpu_exec_halt() wrapper.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/i386/tcg/helper-tcg.h        |  1 -
>   target/i386/tcg/system/seg_helper.c | 11 -----------
>   target/i386/tcg/tcg-cpu.c           |  3 ++-
>   3 files changed, 2 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

