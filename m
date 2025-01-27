Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF572C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 16:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcRkF-0007JV-HI; Mon, 27 Jan 2025 11:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcRk8-0007IZ-P9
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 11:13:46 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcRk6-0001KN-RH
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 11:13:44 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-219f8263ae0so85537155ad.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 08:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737994420; x=1738599220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qvBQUlFuceOnRV4gwyW6jEWHBYnxnL5ZP+Yw/kJ48x4=;
 b=hwf7+MifUHuzz+GIvtof/zYo8eEPB1e6qLukeLhTMWLJGri/0NofLDqxyCggnfyp7f
 YV82ffgbV8tN1dBPESHJ4PRJ04eGWEixTgUF0Jt3avVb+rwrKuukoDiWgi3UYen6RTrL
 DsVUdDURW10VBDu+XJm/9YLFaetGZrWECuqoWUOnveVExmNFmFhJ7+UZ6kzVFRRWK3if
 uoFF+ny/lqaf0J20AhQ6mWLWlc7eQziyqJMPajvqW6LgaxfofC+VHf2wSTkyw7yAsv0J
 NIOOFqVWHKa+d+mgGic1WOfrFQQ1QmRAdjt1+1spw5u2mrgWynvOtx3YRfVV2yXpzZoh
 09rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737994420; x=1738599220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qvBQUlFuceOnRV4gwyW6jEWHBYnxnL5ZP+Yw/kJ48x4=;
 b=O3Ntmk8bF3iG4Gp/9qW50bF5QmRAOu8/FQMo+xW6nA4OeBDRN/WfBvrpOLKEaZXDtt
 5FAVYI3xCCJyVF/okAon+SH78fS2jCD3SBlHDqYaKQMHoSPtEzStsFCaoSDBe4uigGX1
 9vznNpbrJ4ZXU56QvTMn+Syj2xah+hdik6Wc0CXinsMcIqUxq5nmK5p5lWFSsOR4Ymq0
 0+Vkb2Rw03UZkpqVsp6/ZqByqgmgmKFO/K1DHxUBoYt19ahxWsHJbOF5kVDu0765FRkU
 9OoBpGR15NKFOkDM3M2bJTa+ePDVkr4Llp03atwKMJ8KVNVQCbcdT7vPmiDMTnjatb9i
 v3nQ==
X-Gm-Message-State: AOJu0YySp4JJmeFdi4SFMixKnEs/i74ogmENP0Cm8nmuNrQRjg7CM8E+
 3kFclUqdV7WdRsdeOmY6Mxta1Sp1HN05Icro2/7GHps/DgV+/ZkrxtPJtH12j5sJ86yQN8UA5m6
 O
X-Gm-Gg: ASbGnctBwr1ctF5Uj2vvFFcplmFzxYXEJUFEJxu/LRYWrWlyBhhJ36pFCb1nNXn7o05
 aosT5FQAfkzO5sfFXmuopVKH0hLowZ1yhiMkO84MCgLAT9/tJQtAnMIFm2CBfx3A68/TLiVW4TQ
 3g26Ue67Kb/FxirscjQxSO4+HqCSlbBx8SIrcCCPEIQJEc8nNDXsk/V/DNfxPAhXVbbwZkxoAhI
 MblARUNfb1S3fNA1ThH4p+VZjVUdj63vH74ny5glWvO1d8LJ5/SCEnnIF29iX7+yREBBhjXnJ8I
 riOdZ2Vo1q0RAfrjIg3juTZaz1tMYyXWonVUbH74BJarHCg=
X-Google-Smtp-Source: AGHT+IGLyF4dF6fQ+7dnDzVrV8rHJBrILeMFxXk3M8srEvcHPMMYAIXCLBye6vPS5nE5VIkAvnpNcg==
X-Received: by 2002:a17:903:41c4:b0:216:2259:a4bd with SMTP id
 d9443c01a7336-21c3562a640mr574924945ad.52.1737994419839; 
 Mon, 27 Jan 2025 08:13:39 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9e216sm66155755ad.21.2025.01.27.08.13.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 08:13:39 -0800 (PST)
Message-ID: <09e353a6-026d-4966-88ab-c4b300e3524f@linaro.org>
Date: Mon, 27 Jan 2025 08:13:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm: Deprecate iwMMXt emulation and associated
 CPUs
To: qemu-devel@nongnu.org
References: <20250127112715.2936555-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250127112715.2936555-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/27/25 03:27, Peter Maydell wrote:
> This patchset marks all the CPUs that support iwMMXt as deprecated,
> because I don't believe anybody is using them, and we have no way to
> test the thousands of lines of code we have that's only there for
> iwMMXt emulation.  (See for instance the recent thread where a patch
> was submitted to fix an issue detected by a static analyzer: we
> didn't take it, largely because we had no way to know if the
> behaviour change the patch would produce was correct or not.)
> 
> The pxa2xx CPUs are now only useful with user-mode emulation, because
> we dropped all the machine types that used them in 9.2.  (Technically
> you could alse use "-cpu pxa270" with a board model like versatilepb
> which doesn't sanity-check the CPU type, but that has never been a
> supported config.)
> 
> To use them (or iwMMXt emulation) with QEMU user-mode you would need
> to explicitly select them with the -cpu option or the QEMU_CPU
> environment variable, because the '-cpu max' default CPU does not
> include iwMMXt emulation.  A google search finds no examples of
> anybody doing this in the last decade.
> 
> I asked some of the Linaro GCC folks if they were using QEMU to test
> their iwMMXt codegen, or knew anybody doing that upstream, and the
> answer was "no". In fact, GCC is in the process of dropping support
> for iwMMXt entirely.
>                      
> We have one test case in check-tcg which purports to be checking
> iwMMXt. In fact it is doing no such thing: it runs the test without
> selecting an iwMMXt CPU, which means the iwMMXt insns are interpreted
> as FPA11 insns by the linux-user emulate_arm_fpa11() code. So the test
> prints garbage and then succeeds anyway. Modern distro toolchains
> can't generate a binary that will run with -cpu pxa270 (because their
> crt startup code uses Thumb insns); rather than putting in a lot of
> effort trying to salvage the test case to really test a feature we've
> deprecated, I opted to just remove the test.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

