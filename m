Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6773CE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 14:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMpTH-0001gU-RX; Sun, 15 Dec 2024 09:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpTE-0001fq-Hn
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:19:44 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpTD-0004v2-4H
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:19:44 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71e17de2816so1709375a34.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 06:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734272382; x=1734877182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bbmH0GOIz8UQk3GDcpri0r0/LigTKN1A9rlpr7JCQiw=;
 b=VfUi21s6ctREwgOKSei5YTUL5yF7U3y1CiFxaKVNB0ERlq+BzHmqSLl95GGnKpXKnF
 pguMc6Xy5ZWAIOSEZD7OIws4HFnyrLD/NnJ0q6JVGwfd7k8oSQB4tqstYD8ilDgOgldZ
 551GqFcavgLSJgspvhLFHuMwxkM+5CmYpMFXcTqCY8JVU5gneDsINAOxFFPo131Miyle
 5UHw50iyJEBvamDk8gnvkf/KWe+v0R2HJzMAqBfq9oPBbb2Kr5eYPekXXX/m18yB1ihA
 Xxh1x3Ej+3/cvt1azjqJMqAuC383a68v/TdMvJpL3lbhQ1lkbx7CZftDPPenoW15lwqI
 FhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734272382; x=1734877182;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bbmH0GOIz8UQk3GDcpri0r0/LigTKN1A9rlpr7JCQiw=;
 b=SUf3DDR5wLwV5mFj3hyWkA56t/K1+2F2bU2R+6t5MNhjgya3ShehvYqMqhsHikSXsc
 qIwPqNUkz5Y2FlqIpPOsU2kLInAoc5UhP7wl+IpnBEfvxeI60jsXXqdA/etI8Mbinzp+
 99OlZZDLgNGArg6fBPgq64hDeZyC24jH7Tl2jHqdhddjApypj8JdO1cRm5YdzWCOx67s
 n8stiHQHNGwwlaWwDp5oGcv6EfLV/D2HTt7lSiPJ+PkMRiW8NtfzESM2yhMtQsb7FrrB
 EudhJZahMKTtP0nIF7DXvu9RmFuHa6gK4jT/LCkUrptR/o8A2JiaG1mLnMupy/MNz2Kh
 ccLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5zZSJSNiU/iQih+Imi9e4S8tnaAU6C06McSY+rbUq4o+AR4ojA6iERXI3jRTZ7eNSYuHSaY4rYJTV@nongnu.org
X-Gm-Message-State: AOJu0Yy6KtJTxc8oYzoAdQYHdvJ3uNCEKx1/CxtGUNhm1j6ob5HVHiXe
 t19UHt9lfdVYEXPhGfOn64IZSN7GPK0t2n3jAen/cOr54/JmiFNmccF5yEDPKVqgylpgVgsOXeO
 NNxR61kEl
X-Gm-Gg: ASbGnctUVD5m56I0ovGIz9GfGQsGiEXsCMj0fynBjtiuX8XC3SBJGKAsH9JJe/5tsIy
 H5ncBdtuDB4x8HeQdQEJ3Q9iEeWkPIbE5paF/ZdF8x7URLBBwsae0bG9wmauuN0FuocyiqKS1Ol
 ttvHajp24a7RnkdGPZ7BlFNOlBOWYs+p8QPa+aRvtp4gYC2+qqPkotlbZDv+Xz1LQ5egdOrNjNr
 YMkmaaJx89jWMj0tHBMDXyHF9AFRMGK62e9+DOMjRqf3820uGJF94NwU01V5wvLBBR1qEAu4+FI
 9ilaF7bNCr5+HN56KZKJ9HAz0EvSmsg2ISA=
X-Google-Smtp-Source: AGHT+IEkiGNdKujxdLTas+OrgCYauIN72ukwkL7j3oQ0iu9TmzKS9e8uP+kbLGJaf0M3hFq2fxTCow==
X-Received: by 2002:a05:6830:730f:b0:71d:fdf7:f8da with SMTP id
 46e09a7af769-71e3ba7127fmr5128698a34.27.1734272382005; 
 Sun, 15 Dec 2024 06:19:42 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4835607bsm868564a34.26.2024.12.15.06.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 06:19:41 -0800 (PST)
Message-ID: <5adb38ae-a9d4-44c2-90a6-367524093816@linaro.org>
Date: Sun, 15 Dec 2024 08:19:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] target/i386: tcg: move gen_set/reset_* earlier in
 the file
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-7-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241215090613.89588-7-pbonzini@redhat.com>
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

On 12/15/24 03:06, Paolo Bonzini wrote:
> Allow using them in the code that translates REP/REPZ, without
> forward declarations.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 80 ++++++++++++++++++-------------------
>   1 file changed, 40 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

