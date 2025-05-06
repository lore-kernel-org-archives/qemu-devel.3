Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777BEC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJIc-0004Hz-Ty; Tue, 06 May 2025 10:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCJIZ-0004GJ-B3
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:29:31 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCJIW-0008UD-Qe
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:29:30 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30a9718de94so434599a91.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746541767; x=1747146567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+xINvCp1yuSIZKDy1B49HDPT1i1nZ7m9pEHLuJnqbng=;
 b=Ntsiu5WnL3qVvAFFhwHrmKoL7M4kDpERz8sLiytQNZAR96UhOyaYrr/stcj8+8L7NL
 691E4F7wfgiaIhaH50q5wbDCZwcPz+rio6oYPEIClGxRRHI+RPXGgkvQ8W1F/ggGavDJ
 TnHxAbUi8j8vpYW3jjrc3H2wfwnJkxx6b6CL2aayg0ww6oJFKtLyX40zbSoxewsNFRZI
 zjZ9vv7SU7LiXFt0zfMq8205/JWB38rVp/N7KhHRVJ2SME1msL89tLLfjPFPDSLc2ODX
 89Od3mrL2tO1sH9ByOqw/6YFRmUToMWeRDjjNpogVP2TfiWjpSg4ZiLzeCLQbz+Qwb32
 DeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746541767; x=1747146567;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+xINvCp1yuSIZKDy1B49HDPT1i1nZ7m9pEHLuJnqbng=;
 b=r6ekMbShEHghF/ACsgGolF8oE5stDWYqCran5DIK9ZroPh8UJTUVwEjbV349sRCpYB
 mg60Lb5xaY86oXvj+28YZrhsFncJyYL73DefIkknhsgqhIcoxlCFQV647WApIPPMqP44
 DqKZSAW2R1ah+1w6qGgUiyZdFHsOJ3kJDSVufMvEnyPASab1RS8psrIus6N/SA15XBCy
 yG03LLYjHGGmpUJeifp2/dsN3s4V6toq1xKlKOFFVG2CTU5URj3iOmCF9c5EZNHofyN5
 uuFCDL2XsGFnTgzT/J9BobQLNGRrRQZNGFtsoHoI5ekEjQYw2uobHIYH2R9J58GrFl/o
 8Pig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuY9R4HNeySsc1zL45GtNe6wCFSyztd8qcZ4VErjUUl2J1QgNgyOitQ4zzmzPXmuqw8LyPG/RXD6nw@nongnu.org
X-Gm-Message-State: AOJu0YwwdQIG3pR9qXDagzBtshXtkQnVj4AQFbh62iVqeqxcMkSNhE9C
 nZby0Be6/J+/QBqB+p8CyKRsBhuPtVpCu2070rmzzWjiFcMC2JAlPEPtplk1PHc=
X-Gm-Gg: ASbGncsQjSAzCNiroK0leP34nR+udvelXerKmPlf/G1ilcq7lUaHZPN13vPQR8L4jVn
 Mp4gpeUXQ6IzeHOE+k7Bxb1EbB7ou6EF7jcAzwni2hDe1gohCzwbh0LTpcOmUX9LJ0BW9Ah6eZA
 Wf9vhG775mpU8/mXNjnQhiOWaWgwPOaJyTyXxsLXIMZxusYRY2WEBVg8E6m/yrANOipl7dB5gW9
 0NaFaPDLWahGnqF8TGXai3aK30Z8SoY4tP5E9wGio8rYh0IOChEFRVmHdYhaOxVzMGkjoVLZ73/
 Tg8uoIGwpzxMic49bKJ+5SYL/5tPuP//6oni9H577wGMqQyrc3uCQ6HZZsUMmHZGD9X4QXAmlgY
 AEJeviXzdrwsji11bJg==
X-Google-Smtp-Source: AGHT+IEDUi/EnB86qhU+JzPrafWvDcjWRRJ/9Iulngyz+jMQjHs0VsEnY8G6lGAoNiN5TVAYA9PJ9Q==
X-Received: by 2002:a17:90b:2f10:b0:2ff:4e90:3c55 with SMTP id
 98e67ed59e1d1-30a7f32ccc5mr4172774a91.27.1746541767000; 
 Tue, 06 May 2025 07:29:27 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a892edbe0sm940979a91.1.2025.05.06.07.29.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 07:29:26 -0700 (PDT)
Message-ID: <c374415e-8c32-4ad9-b003-aa9064bc239a@linaro.org>
Date: Tue, 6 May 2025 07:29:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 50/50] target/arm/tcg/vfp_helper: compile file twice
 (system, user)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
 <20250505232015.130990-51-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505232015.130990-51-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/5/25 16:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/vfp_helper.c | 4 +++-
>   target/arm/tcg/meson.build  | 3 ++-
>   2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

