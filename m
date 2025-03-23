Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FA3C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twRSV-00081F-Bx; Sun, 23 Mar 2025 15:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRST-00080t-FJ
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:58:09 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRSR-0002l3-L9
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:58:09 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22423adf751so66318825ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742759886; x=1743364686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rV6w+vA/HSvcsGTSqT6d/tmonvQTsJQlJQIhHzRBrjo=;
 b=LIDg05Yq6V60Cv85yHyruMcZOIMYa9d4hRVy+K5tqHymgHLdN4xNllRK7YqV0W8TOW
 pNhEeYGsF/2xLTBbA3In3FhtDQRwwPB3TwUbmkCMF3ni65JTxjx3f9fIuJ6lO7pugQ7S
 9Xw29FRvWkc/uyo+pQ3ffPebizshA1xG/uMmE9aFbUDsND5euZmVOG0YGpn/UiPCGKr2
 HTY7FBqg/DGRnZRHWEmhdWml+ME2cMlkTpg6bOHHi72o8ms58YT/aD3Wyzv8ysWMkvuk
 7Aep7JMVClafef6LvDD1B4Np9QaiOk9EIXdVzDgM6/GBGeQEwxNUqB96KkSpo8gQrBtP
 TKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742759886; x=1743364686;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rV6w+vA/HSvcsGTSqT6d/tmonvQTsJQlJQIhHzRBrjo=;
 b=iWteL9Q1TxFZmq7XwTxZMTmyuY37vd/h7qR1VM0dJJPiXcJZWCn5G0B4FVhkSfxQPd
 T5/pslunPwf7q8mi7FN4bAj4szMyTnaF5LF/d+pKiZUNPLKeVrmuPpy8EU9QQW/phFWa
 ZYgtgJeaIzkP51HEKn5e0B4+ASQXQ32lVbabR0tbRkn8mxrQ/fqDinBEOiR2NVH95WX4
 zKs+gPPjukNbuEhRkw97qtWj6f4BUyUSBAQxQdGqS7ltgDDyDLjiIY3vt2JrYt3eEG3D
 hSWkQLQYJBL5oB41y6tEB/X33Ib7utMxeYJO5MsnRnfNTNiCFW+It8vCwxC12DoIzf7T
 raUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKCixkbXda7A7eE9rfIS+lr+dn25hvc8+reTalLKPpKKUDxOqEUQzzaq8xag6tp8Rb5V6H2nchtPlC@nongnu.org
X-Gm-Message-State: AOJu0YyO062kJSoSVKMUmcdPxp+CrUOlRRQ9UhVuHDRbTql3IJEqX4BB
 83E0tyNrts78tOLc13hU/w9ne7LtG/tP8y+WprShgHDLCS7Rz8pV/+YA7vO2eX0=
X-Gm-Gg: ASbGncu9vWgA9olWFKMEfqk3pYV0V0uQYu9Lxgn4nj5GtCu9Ms9YGuAqgRfIfFwZfn8
 CCVs2wqLJXotKWLIWrucU3Go6CMee+hDlScqlqiS1ahwKpPUjE5DWNKQG2jL+lzjucKxDHOigh+
 ioaqmtA8IGWfBKo+oE9hdmN3/UgCsF9JgvO6gt5iruPSjtXfg3yI7lw6n9IPmdjD0ZMYp47JRKq
 Eto+WnjOXa1CXaAp8mBstGKOJJyJ3Yyy/i/5oKtA9rDlyUne2lGRhq1p1+XNqn7bY7upvGEmHfI
 pm6OcDBv/bgwgId2gLGOiPw89WbLRUm+Tr8gQQuK2ZO9x8+dbVpDk3/JBYPVRySLfZZuLsMKV7g
 +Q20BFOUo
X-Google-Smtp-Source: AGHT+IFfak5B0jGxPFefdrcBK4EUg3tVjnxOA8xxYMB9LcDAjqBf1PF95EWl+vpwBeyVmqQayJ7ZBw==
X-Received: by 2002:a17:902:f683:b0:21f:136a:a374 with SMTP id
 d9443c01a7336-22780e25b3dmr168091805ad.43.1742759886087; 
 Sun, 23 Mar 2025 12:58:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811eedcfsm55095025ad.205.2025.03.23.12.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:58:05 -0700 (PDT)
Message-ID: <2650a767-a829-4544-99f9-42e23b131da3@linaro.org>
Date: Sun, 23 Mar 2025 12:58:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/30] meson: add common hw files
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-25-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-25-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Those files will be compiled once per base architecture ("arm" in this
> case), instead of being compiled for every variant/bitness of
> architecture.
> 
> We make sure to not include target cpu definitions (exec/cpu-defs.h) by
> defining header guard directly. This way, a given compilation unit can
> access a specific cpu definition, but not access to compile time defines
> associated.
> 
> Previous commits took care to clean up some headers to not rely on
> cpu-defs.h content.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build | 37 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index c21974020dd..994d3e5d536 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3691,6 +3691,7 @@ hw_arch = {}
>   target_arch = {}
>   target_system_arch = {}
>   target_user_arch = {}
> +hw_common_arch = {}
>   
>   # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
>   # that is filled in by qapi/.
> @@ -4089,6 +4090,34 @@ common_all = static_library('common',
>                               implicit_include_directories: false,
>                               dependencies: common_ss.all_dependencies())
>   
> +# construct common libraries per base architecture
> +hw_common_arch_libs = {}
> +foreach target : target_dirs
> +  config_target = config_target_mak[target]
> +  target_base_arch = config_target['TARGET_BASE_ARCH']
> +
> +  # check if already generated
> +  if target_base_arch in hw_common_arch_libs
> +    continue
> +  endif
> +
> +  if target_base_arch in hw_common_arch
> +    target_inc = [include_directories('target' / target_base_arch)]
> +    src = hw_common_arch[target_base_arch]
> +    lib = static_library(
> +      'hw_' + target_base_arch,
> +      build_by_default: false,
> +      sources: src.all_sources() + genh,
> +      include_directories: common_user_inc + target_inc,
> +      implicit_include_directories: false,
> +      # prevent common code to access cpu compile time
> +      # definition, but still allow access to cpu.h
> +      c_args: ['-DCPU_DEFS_H', '-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU'],

Oof.  This really seems like a hack, but it does work,
and I'm not sure what else to suggest.

All the rest of the meson-foo looks ok, but a second eye couldn't hurt.

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

