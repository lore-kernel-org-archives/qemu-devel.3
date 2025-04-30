Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBF5C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 08:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA35K-0002d5-Mp; Wed, 30 Apr 2025 04:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA35I-0002cd-Md
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:46:28 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA35H-00065X-5z
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:46:28 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7c07cd527e4so750863485a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 01:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746002786; x=1746607586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WJUmRTwr/bsLQnKtetdpNi/VeDsYqMqqcPJurJ1QwrQ=;
 b=MZpkIbvVdj5Hwfz55c6wYHkh/xGEn5UanE9BbIK5vBoj1bkxmVYlwbGbEJRjQuWfIt
 DZi/bHf1M36p2xX7VhGN9OLgDsuRP6yJATBKDxct+ugbpb2X2QUer/spMIWrAdIcfjpT
 2LKVOwgxHYfBt1jfet3uYWKWnrjL6xXjkfS1CH4r1Ruol+abOjuIfbNLD1u1zaeFLBPm
 3DbTnzryhx0l2lXEY+WQzhhy7NTlxW78jqbC0UqR00+zHaUMFXUVY3WzHF75qIs+UFaJ
 UGW1NVy//dztPEg7pA/Ih9i0Yc10rGbFdtfGtsLF1DbvoQeht8n9ZXDMpQnDKQKcNuJ0
 kDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746002786; x=1746607586;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WJUmRTwr/bsLQnKtetdpNi/VeDsYqMqqcPJurJ1QwrQ=;
 b=KeoekWlDnWoPK1H9MAIQRzay3SkQUb134OX3bDzN/Itz5QY45psafwAggSlgkon0Jx
 XcpvY9a4bnPIrPXnH5Mc4Dt8bCdKjPD3BcA9g5wM6b7a1VDMQ182RPYCvpNSe8HBIW0y
 +Y7TVDXrIz934G/Kq5M0xl/J7WDKiEXWDRgCG8lYuYl1/4gWy0MwfCt6b7dRQDMfLkNt
 WG49rDCvacTA82QnLdPgFfieX/fJe9h3bwnxD34DEa9ZFhS1huKeEIlTPS/y84uQbsqs
 lbTcZhc4NOcXnwAJ5cBq0VIvPlDAKMwUvSqcAolae9Q0myjYbKUJzJgrA5fM2SD8ppek
 CSSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcZnFS2ko3NMVIp/8tpme/y4n/l86vkzDipJcR+6X4lhbhuYrzDz1QwDMIilXSZZMGyrkCLye8YZa8@nongnu.org
X-Gm-Message-State: AOJu0YyltesmRZZvz5+kVqCh5mPIZGOZhtAnCxQtFVaXBU6T5GS5hqIf
 /ytoII3dU51c6zo3Uui92eiJRh3jkUfDure3ttMa0NVDg2ZBAkTqeDvU87JQKD0=
X-Gm-Gg: ASbGncsi5Q5uUaDXmK3RjL38vL8gPPt5F/mmvDF3BF3Uc3a2d8/6BVfLIcjOFoBptl/
 SwA08x2y+A/H0x+c1h3zUXBGVssnjakkSBlTNpyc+XWdYo7rdpemYXvkvOh90ozReDf1KbYN4dY
 mkr2Idqqi0cjFtQZxlGgfko3+5iWyMK80Aw7qj4/x55cQ1X+60EY4dc7T8rN1WLYiAUVNHjDDjH
 295FSPDvD4jDSS29agsECUm5CCE3n48Z9Hy01nBWTj16srgJ5LAAz2bNIaetGNMJbuO0afBQluV
 XaqudiDDDbHsCaIaESn/ldw630JwPgyg9vm3/UtsjIHKQ2Cy//eQEM++OvPvmQ5QQ4uEz1HiJvV
 F3rCiJ0j1qN5l5w==
X-Google-Smtp-Source: AGHT+IF2LP1duXRBNN6ARHMofT1LJ9ELSc264yePK5udp6k3ME2swy6sFLjA3RWO4x69rj3uh3fJmA==
X-Received: by 2002:a05:620a:1793:b0:7c5:444e:3f5f with SMTP id
 af79cd13be357-7cac7608a63mr289144085a.15.1746002786020; 
 Wed, 30 Apr 2025 01:46:26 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958e9f4c6sm833146585a.92.2025.04.30.01.46.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 01:46:25 -0700 (PDT)
Message-ID: <1fbbf49b-befe-4477-87f7-c0a594673903@linaro.org>
Date: Wed, 30 Apr 2025 10:46:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/microblaze: Use uint64_t for CPUMBState.ear
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
 <20250212220155.1147144-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212220155.1147144-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x732.google.com
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

On 12/2/25 23:01, Richard Henderson wrote:
> Use an explicit 64-bit type for EAR.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/cpu.h       | 2 +-
>   target/microblaze/translate.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 45f7f49809..01571d4f86 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -248,7 +248,7 @@ struct CPUArchState {
>       uint32_t pc;
>       uint32_t msr;    /* All bits of MSR except MSR[C] and MSR[CC] */
>       uint32_t msr_c;  /* MSR[C], in low bit; other bits must be 0 */
> -    target_ulong ear;
> +    uint64_t ear;

Interestingly you already migrate it as 64-bit, see commit 77f63e1dadb
("target/microblaze: Fill in VMStateDescription for cpu").

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


