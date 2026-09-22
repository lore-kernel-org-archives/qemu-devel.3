Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39914C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95Wr-0007QS-AT; Tue, 22 Sep 2026 14:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x95WA-0007IP-V7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:47:10 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x95W6-0006us-Ns
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:47:01 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so168332a91.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790102817; x=1790707617; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZPr2IhXOs52SApaCaIdBa32t3L64syR+CdMKnh1S4Wk=;
 b=ztu5amWLnzFpR8t+CyJD+hIppt9xqx2e5uI1viM2kxG54Xl5u+efNle+02HLcha9Z3
 9T6uQgoNO4biRz6dqciM5Avu20B2DUhYUmiiOP/mWCgJrp1GaBFvZoAj+0YwDE6Uvob6
 +2JtsrRoWoWhE796O3REhZMeirERb2gWwnSP+nQhpsEq6DgWNYh9ygqJInbR5pxi9S/4
 lauOl8S9Ien4hX+1ypv1SXS/iulgdyzCGucJC9t7o0HHIythCTpLH8RdpszDVHnURuhT
 cf6mVo4q/WHBBtreF2NKjLko215GNnSg9BqhhAz3dV6zGkTLx9nylrJr0u/FyUxNUMg4
 fP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790102817; x=1790707617;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZPr2IhXOs52SApaCaIdBa32t3L64syR+CdMKnh1S4Wk=;
 b=pzXKHtEHmoH90E5K3xwqT1tWXhXcR8ILRXoRlZfRkm5TW03UXGt3tR7n9HV4Bcq1sC
 NEMmJ3V/MpUSCGRRVZUQKsYPLWxvDiDxZ0Tyv25IXnP3q2UUzWKMac/qNE0hXKJxc/qg
 WFBN8i9/eO2SwESXOOk3PKDX5fXo8e2TnMegdbsfBv+z9xylCLKjcyW1JJ5ThrA9zMHG
 zxrj1/MKKKLb2qSrJ8u07vswarr7JIECCkmZtqoZgw+6BWYbcstXrS91Gbk0aZjr7sQV
 M6VOaHdaR8yv5Dw5i3U5zJ24oWTNzJcdwUXpCtDq944xkulld3lIyz7EBGYnsiqu7r4F
 kuiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpJZtygSGu2neKKz/OoHKqIZnBmc9tHQ+9OPrb1HPOKDtyiJrJc7cMXu6g2tJUc4G8Spn21nWWmQ0e@nongnu.org
X-Gm-Message-State: AFuF++mUtnNdjcH1G2FMibr2aq+rq9+LHaTgs6zYkazTiYVvbpwzeGmC
 Y12EA7+a5UpwdLsGH4S5JOyL6r+a4jRG5QGEG+EFAMt83MhZVbdiAkZiNaQtTkXnaXU=
X-Gm-Gg: AYBFou1thbwBxjsp5tq+lX8OQzSWollFMQovmUd+OjTo0OG1H/TKn7+/Jva4lKxsWaP
 2rAfZT6fJlE775e84E3VWg/CLhh2DiyC6TlOcFfcG+uE83XDhN1uMuAjtDfJhUdccxRfdhtHSy5
 vVuhmMSXmvN+KzBgc9sES3OsZMpqFSsNtW/NCv9aBWjPU25Zmj/RW2gZ9ckVsY7NzNUehaD9OqC
 jJSpdMy17qbHCzFsOeEpcF1rIAN3VW/0RUTWteFaEXp9J2JLAuhq3knTiJ90Uz1VT4+agMxe9np
 kpVy5+3Nr8j5pqbbGzNJn1o5RqwCrvxU4OCvGhTDRzVkybSq7NsULhXACBADQjE2Z0YHjI1dkTZ
 6fyB4vjLbS1pe4pSbxfsYUHU580/QFVfIYQW0e5tjwrPLSIRfPAqoSiV5B/SKUJC2f5E7tedXjc
 8PcZzgD3CFGIaFDyqK/wr066VxhsKTIDV8++DrOGQFmhGpBzKoJXWZffdXayDVAX+sXB5gleyKn
 kIm4dVVioY+uWPFk7SnpgbktQ5/Om/J4FYQMASmkQ==
X-Received: by 2002:a17:90b:2b43:b0:39e:4717:7cd9 with SMTP id
 98e67ed59e1d1-3a07e313fcdmr311361a91.0.1790102817074; 
 Tue, 22 Sep 2026 11:46:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07dc2b2fdsm691515a91.12.2026.09.22.11.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 11:46:56 -0700 (PDT)
Message-ID: <74d4fc9e-66ff-44ca-b4b3-7dcaa350cfd0@linaro.org>
Date: Tue, 22 Sep 2026 11:46:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] target/arm: Access PSCI state atomically
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
 <20260922164936.15189-9-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260922164936.15189-9-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/22/26 09:49, Philippe Mathieu-Daudé wrote:
> Use qatomic_set() when updating ARMCPU::power_state and
> CPUARMState::halt_reason. Read ARMCPU::power_state atomically in
> arm_cpu_has_work(), which can run without the BQL held.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/arm/arm-powerctl.c | 5 +++--
>   target/arm/cpu.c          | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

