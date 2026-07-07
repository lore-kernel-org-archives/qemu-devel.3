Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EA8C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAFr-000140-4B; Tue, 07 Jul 2026 14:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whAFp-00013D-AN
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:10:45 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whAFn-0005bO-OT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:10:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so36763805ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783447841; x=1784052641; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EyLKOn5ofgT2nSZs/mBesRB92xBEFK/QdqMD82tvEDs=;
 b=c29YyshALTYcAWSLsQYvqNZ6MHdyzIKdtOajSSgVPgOv6BASSUmRLVeQio0GwJyaoq
 mbx7rPuvVsNlnbjTEIPvElPrS6F5SDETXX17UpfZ3GSGkqZAnpSc7ndkjdwS+rnOik/c
 lvzPqAZOgFumAprZyxThLEEsDKN82Gi3eP3k6b+twa9Kpp2CkmFVJlDQPtfDaGAhCff1
 IAiBIzkZ4WjIKfjCvaEoqcAYjaiOeebgVUVsrA1qVFcGtpJuJe3z72z7RaUuX249502R
 z3+9oOUm76mB9Zs65JIyDTOZciMXkcVf6KZcR1kWUHfUYA9Jg8scX725CdxgRovx5xTY
 CuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783447841; x=1784052641;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EyLKOn5ofgT2nSZs/mBesRB92xBEFK/QdqMD82tvEDs=;
 b=tDbo64en0kvBAK+MCBYpuIlW7ll7HZ5G8o7tGK+CrXglC7rguEO90McYjd9aVVtTLE
 7MIJkYFkTI7XyGmMofugij4VtyQaMTMU7sDOYps0dE733UenHKSKaaOjh3opF4zhyTH5
 /ru8KcFGxYcW3C6p/j7yD/BBifJTbYJ1Xi0qfW3HX0GCMl13pwF102QhafSLQjIdUQJ+
 JExM2XRFvFP1uHzISFwaPz1L5OQj2hpGsOEVRqfT6A8PT4VfPho+jIMvQp00fmi4akRA
 YOm3Siqodkg5czgzxKN0bdCWyMsiHeHEOfuzwV66vPebci8Dyp+B5SyePzznzjCbOTST
 Nruw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcY3T1bwb7LGHGU5E+S+dpA0uPXpvqcNB3bVSye2ULm70D+S3sUU1B9xXv1DDncDpqfpXLPcB6aLV+@nongnu.org
X-Gm-Message-State: AOJu0YxcPZIGBkOybRSdLHJLNFv6HfC3tHhlGMdD7ZcKcJuaFwza06oQ
 HBZa5WNhBsMnPaOxYxY0gxSt2Hgkrsfd8Tr24TPILzBAMTtD/5dHRHBDVchHTQLSiXM=
X-Gm-Gg: AfdE7cmKjsB7GS0LRPf7A+mtbKfaBTwI11qOu7j7fil0ERwPItlukT0HdrmEJpM4pjv
 w/3EMg2B8uXhIDLHLTyVVFd5OpPd+bLHhOxkZpXGTE84JchJxmYRCc/v7d01q/QUU2pR0BgF6tK
 jqFNY2y3+C7wFCwpkenI71eG0cI1k/DR1mpW7YEzjvdxood3Qu1Z5jKSObsieepWvDnqShOsx56
 5OcFo1F1dDzcLRum8AO1vqAD9BRv+Ga+pmAy3X8ujilKlrr213hw+xz/RvKhHDT/xi0VhccOoT5
 d1CwOyvsOsBIbo1LsyVryVgd0gkcqnKkDZwW9efBcyer/FX2hgGAViImoIttVONKWnNxQRzPFKs
 h7j5ObZqkInpDjWzy5bgQlz9erLdTybdmYvh/8k3hpV6iXILDJfaWNJ8DXAw5W7LkHedYeHFzrC
 Sa2rarHbqTtef+s/FtLbYKuRCeGh2bew4OYHHkxR2XlCWTF0jQgv1kMM8=
X-Received: by 2002:a17:902:e88d:b0:2cc:9179:325 with SMTP id
 d9443c01a7336-2ccbe720304mr58621175ad.13.1783447841533; 
 Tue, 07 Jul 2026 11:10:41 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1e284sm16188405ad.40.2026.07.07.11.10.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 11:10:41 -0700 (PDT)
Message-ID: <9768be60-fb4e-4e6c-ab29-219da64ec533@linaro.org>
Date: Tue, 7 Jul 2026 11:10:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/91] tests/tcg: introduce meson.build
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-5-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260706223343.988769-5-pierrick.bouvier@oss.qualcomm.com>
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

On 7/6/26 15:32, Pierrick Bouvier wrote:
> Every target declare its tests, and add them in global tcg_tests
> dictionary, indexed by target name. See comment for full description.
> 
> We make sure that if a user repeats a test several time it won't result
> in duplicated executables or tests. In next commits, we'll introduce
> what's needed to deal with that.
> 
> A test is compiled from a single source file (and later, a single set of
> compile flags). We make sure dependencies are correctly handled by
> generating a depfile.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/meson.build     |  2 +-
>   tests/tcg/meson.build | 95 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 96 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/meson.build

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

