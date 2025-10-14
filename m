Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08A5CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kyr-0007qo-N8; Tue, 14 Oct 2025 15:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8kyq-0007oH-3i
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:46:44 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8kyi-0002lR-WF
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:46:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-789fb76b466so5281967b3a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760471194; x=1761075994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VdOTWm1O3YsuxVNj9jDxe6Ud7QOrWki8pRAwLabjhm8=;
 b=sS23wLXzkzaIh9ZWKPE6Us9RWiS7GTYTJ+tRj8aNxzL0U+G3NGdfsSb04KqAF6rm5+
 bgaCUKVRINQnPpGb1Ktt/292d7nIgBYRcab0bWYk+VHgUqc96qKupHoM4ohSRL+xnmns
 XC3XF56isgVNP0OnHjneCOCKjzbiLPn/oELgfP6Wwu4SR/oBOVU0A/bHCC7O/KMEV7h/
 mM5bqsTlCLDtSdGVODSaEIbDBjcqidOzkHW9b9eMoinyhnbEvlXaH6kh9CHIKtHj7epU
 YZz/TCkTXmV0hzQ/r12Vs4B3IO3FpDWNPV/UUUrYP73O0l05zI2fp90maH2La5nk0FNM
 AheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760471194; x=1761075994;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VdOTWm1O3YsuxVNj9jDxe6Ud7QOrWki8pRAwLabjhm8=;
 b=pJyw6HVYffTtBUeAHONRzpUh3zj2+oq1ImdAB7ZC2Thxj4BdfCKZ5M9DaFTOBh9sna
 fc93LMC6VfM4ZTj0uShgNqcVRSl23wCNp0FXOLA/4q0qn0WWsqbioeZaiVxaC/3gf2oE
 Prx3vpzgk1YWqw+j1+nhY6GSqevlBeC6mWRJttIUBFl9W/0KgajFB9V5VyoEVpacbC3C
 eTrOidwsr8+Iy37IBEADsNvGcik2U/p1P1+ZBBs/X8d06cK4c6a2HFKcVgkYXCh24g2p
 sBythyDxOVQ2NKPwroCkWOYqdEsGfj/l7vS5dH4iS8yehnA4k9+syP2d53K1r8gxHwYA
 YWOA==
X-Gm-Message-State: AOJu0Yy78Z5aSBSuTs0cWD5kMcR8/aMz30hLt4y4/V36swJpSPbV156J
 ufP4CZt0oek/Q7Ko+EPZjFQLYgPk7HPwe1KaVBXhl2lL1urqfL/NAII+KQzWGANuHvvYHFjwvR4
 BeHHA8h0=
X-Gm-Gg: ASbGncs+b84DoYTPOgtWIWXnR++8/FYzRRRTGRu5oKdNtWuFKnmi9zs/GGzWXI71eJO
 8Yg5UiZxbt3D1G6Xdl4UZCvR8Vp110B5+SqogobH6cm3bItds+hG8sLYnT8t9w8h4S/v4KiU64v
 iJzPy+xjJcrm1WQUEi2f/jv4X6x5eCsH/Vpu+PWYSS7NasZVoXGzuZ8E13BiHKAaa8CeB30FzRz
 mQPy/idWd2KBMb0KEBKfv0tOMRe8wIPs9Mho+OqZebWMUgAFUpLo7ySEiCuvrcSyRP4yaIBYmQ3
 n7Gg/glWXtIUu1jV++xxV492XnBGS9UecK/U0yLMGnwDGQvi0ebQ8x1V1MZ2YUye0kzfkHLCwME
 dx7aV5jzsQPO0ctGn0rqQhfKWLOqgZk1gtEJchDG3AASicmGf38s7IewlV2M=
X-Google-Smtp-Source: AGHT+IFQU9SAmaexUUjPNU+MUetKIFGGeMHqRLG8hK++ud4WOBQkoVtQOuf6WgqCDcbqhoaWmdrkYA==
X-Received: by 2002:a17:903:1106:b0:24e:3cf2:2450 with SMTP id
 d9443c01a7336-2902729039dmr342208555ad.2.1760471194304; 
 Tue, 14 Oct 2025 12:46:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034de54c7sm174479625ad.10.2025.10.14.12.46.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 12:46:33 -0700 (PDT)
Message-ID: <c06841e5-a250-4745-93d4-9bd515459444@linaro.org>
Date: Tue, 14 Oct 2025 12:46:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/28] Rust, i386, accelerator changes for 2025-10-14
To: qemu-devel@nongnu.org
References: <20251014133540.1103268-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 10/14/25 06:35, Paolo Bonzini wrote:
> The following changes since commit 94474a7733a57365d5a27efc28c05462e90e8944:
> 
>    Merge tag 'pull-loongarch-20251009' ofhttps://github.com/gaosong715/qemu into staging (2025-10-09 07:59:29 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 7ee5875d423598ac55a0b55881d9a1ee5c3c7daf:
> 
>    rust: migration: implement ToMigrationState as part of impl_vmstate_bitsized (2025-10-14 14:43:54 +0200)
> 
> ----------------------------------------------------------------
> * rust: fix nightly warnings
> * target/i386: a smattering of fixes
> * monitor: add "info accelerators"
> * kvm: cleanups to kvm_cpu_synchronize_put()
> * target/i386: Add TSA attack variants and verw-clear feature flag
> * async: tsan bottom half fixes
> * rust: migration state wrappers with support for BQL-free devices


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

