Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AF1C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwUE7-0004LC-QW; Tue, 18 Aug 2026 20:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwUE7-0004Kw-4U
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:32:19 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwUE5-0001Hq-Jr
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:32:18 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so460869a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 17:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787099536; x=1787704336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=APQP+HcYInUH/kMfrVPs2ije7nbvCMjEwR8LPnfZlWI=;
 b=ro7jD6J2MHDLhwqW/ejlmV+TgScMldUP/0c1ql19Z+iBOgjFI336qz414AAR6+xrg8
 1N2MNjGNMzuI3qX7oPVXvzoNj6CjL9D+W3TWFkyTBJ95vvx2JVnUUvIc1qNaaLGVb5cY
 I9UtLEuZxjxNe0xf8H0Vw+pnDIrj/YpFyQ25KLmB6p+m+Dh5exEhB8XpaYpm7ZYdMGVn
 L25i8qRFXEbEfs1yASZIKFcXXq1MORb9Y+33qe1bxUq1W5ncZ4dcgY3KOxVgWf8aqMaB
 aHKzOyAKtC4NWuwiUvusGivoNV0DGaH6amPNhkP2hUcSoH1l2pyCSj0o80Ff2I66eIfx
 ffoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787099536; x=1787704336;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=APQP+HcYInUH/kMfrVPs2ije7nbvCMjEwR8LPnfZlWI=;
 b=RCKU4FVTh9E7IfBh4LY8lNw2ERmD/HdBNODcCmORSQ1To14UHcw86cY5tX95gb1ykx
 R+5TDe3+akRN8I4fskKMWwkw+K9ZHXYxOX/0nsTRoP6o0TTOJslsBZDWWd7gT00iV6xM
 +6d+VFUr8Xw+ZITlrThhPTvCOTXasPWHfkw7XgG1ZAeC15L9WO1nlRfVSTdXRpyDFI7v
 H9yhhGsvcHolkQcXiiFYpn5W9tMKpiwFxClWicT9WRsHCV9Gq/4nS7V4bzrdGq3Tl0pJ
 HeRYEO9emO9oIvy+09sv2s9gKbNDBuMX/mJ3gu/9rEkttqkJBy4dpv8ovbFYSnne5XO9
 Uzig==
X-Gm-Message-State: AOJu0Yz5Nrco03G3LokThjuyeaLEzrubAA+ah6xtw8tnxp14yTO4u85v
 /XW/5qnR6jeyHo5To/DyLe7tm89zvv+RM4k27hTo5Ppe+kflucISwoiYRIEod8b+8eM=
X-Gm-Gg: AR+sD12iFfBkrzSfYRJzlyJTREaWUlX82MPnOMnmjqh5OvpL2uATaqGABb5P597xiXs
 ezlEIbYCv8Cm2eR1qI5vTUdW7m+wdaoimY2cJ8Y57vNreNwOgZxthsobxvHcwQEet2ibP9OT/Xt
 M6CFpRvtxCzVZSMj06QC/dNFk/Kl4PhpF51/kFaAO2+Oqe3y13Vh1tgFWSj/6eVmJ5DbuI63TeH
 bRPDQFkrfD04s/xRB5Fjpr2Pl9EDkiVLL9MBiGm8QxZ38AcNuP9ggYTuWJeoDAp6zVqsJuVkaW+
 PKTvXbYxVzc6osI7Fgxlu/bu5ck2LUb1WRiNj9vKaAP8brPqzt7euCPguPcoVWAihr3E3nFElu/
 a9rHkvGX4TfG3c1XfNCLDZ4bNCZKfL3Mv/70oeTjCYcrvSNMA6EmEG+VfKbOis+RTk7lwDk9f03
 eBrund4Ej3sU5eO6zZpHyE426vkeMJmMOB9za36DVaO1pOqxmF98Qu3kjywtbHPj+ZRfxAKLIcX
 F22nWmd
X-Received: by 2002:a17:90b:5102:b0:392:b509:b1a5 with SMTP id
 98e67ed59e1d1-395810caaf3mr1364763a91.14.1787099535840; 
 Tue, 18 Aug 2026 17:32:15 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb51271sm507370a91.7.2026.08.18.17.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 17:32:15 -0700 (PDT)
Message-ID: <98948f58-ffd4-41c8-b821-826f4ae2ad96@linaro.org>
Date: Tue, 18 Aug 2026 17:32:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] tcg: Defer tb_flush when initial thread region
 alloc fails
To: Yogesh Vyas <yvyas1991@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com
References: <20260813005031.518387-1-richard.henderson@linaro.org>
 <CAJOT6qOr+YL=Z_uVzPNtz5=8+gjLhg0dQ=99pwADZb5XEgKGag@mail.gmail.com>
 <CAJOT6qMuSpzUw_hxu2TQsscwSqxOnorbJvpoNYKVWXv52iCN1w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAJOT6qMuSpzUw_hxu2TQsscwSqxOnorbJvpoNYKVWXv52iCN1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 8/18/26 10:07, Yogesh Vyas wrote:
> 
> Hi Richard,
> 
> On Sun, Aug 16, 2026 at 10:38 PM Yogesh Vyas <yvyas1991@gmail.com 
> <mailto:yvyas1991@gmail.com>> wrote:
> 
>     Hi Richard,
>     Thank you for improvising on the initial patch shared.
> 
>     On Thu, Aug 13, 2026 at 6:20 AM Richard Henderson <richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>> wrote:
> 
>         Hi Yogesh,
> 
>         The main problem with your patch is where you've placed the change:
>         tcg_region_initial_alloc__locked is also used by tcg_region_reset_all,
>         used by tb_flush.  Along that path, we really can't have a failure.
>         The path on which we can defer allocation is via tcg_register_thread.
> 
>         The second change I made is to use code_buf_ptr == NULL to signal
>         reallocation is required.  In addition, tcg_tb_alloc doesn't need
>         to immediately fail: in the interim since thread creation, we may
>         well have performed a tb_flush already.
> 
>         Please have a try vs your hotplug test case.
> 
>     I tried testing these patches on my x86 host running qemu-system-ppc64 by initially
>     hotpluging 400 vCPUs.
>     While the response was relatively slower than the initial patch that I had shared, I
>     also observed the VM is as slow as stuck when I retried hotplugging upto 1024.
>     I will share more feedback if I have any.
> 
> 
> I have shared one minor comment on patch 2/3, with that:
> 
> Reviewed-by: Yogesh Vyas <yvyas1991@gmail.com <mailto:yvyas1991@gmail.com>>
> Tested-by: Yogesh Vyas <yvyas1991@gmail.com <mailto:yvyas1991@gmail.com>>
Thanks.

r`

