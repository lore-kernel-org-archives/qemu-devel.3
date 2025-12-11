Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9975D43341
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 20:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTn3j-0007e6-3H; Thu, 11 Dec 2025 15:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTn3h-0007dr-Pa
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 15:14:41 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTn3f-0003HT-Hn
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 15:14:41 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45392215f74so214686b6e.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 12:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765484078; x=1766088878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=djnnN+lo9jVZTsCiq/WT5+NslmQPdM28M2M2xxwwe34=;
 b=LbFno7mzFaadAfS7ZHyzqBqz+yQpJNjE7j41eEasWIGx7RmKZBzemzs5mBt8m/U0m9
 qsA1cqevFOYmQb/4CE80ufjVT0zy3mj3JdFuiK31QaKfDmqfNEIIj24dSn4//qfPYuYH
 7B9BTfaKFCH7sprw61pCh24RBuGfg/BwDqjJYiue/xJs5gz4PT7woLgUFqYjSfIg6ImN
 ILEg1ZuNKxFXoM+tEQlH+Zo6lh0TvTIfq8TyQAIx69JEyZzmCDCQCSgOR8aQOqCfVWyb
 CtyC/m3jXYLJQUTm4VOo0lRYkMR2rIcIYRz4/rR6T6WEJRmr0YT77Rudql0hPkbG/Dhg
 XIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765484078; x=1766088878;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=djnnN+lo9jVZTsCiq/WT5+NslmQPdM28M2M2xxwwe34=;
 b=tr6z1FDyBFPdruQY2rUgqlm9Vo4IpWaZ9o9VTsYeexzBFkmS55TaTzhdc5HkHRTg9q
 S3M/3OhmnW1TJ/Gfk3KEBifVQmXKDrplrnIrNMdcqD9teDALc4Bv8wFiQGTNSa417i+Y
 5nDof0JHcl/J5cVTLoVlyahFYuge/65eXhIH836XdQyAjTJ+lq8xurAyIRnX2VrIqngL
 zE+Nx75oMTnvsWJcGzL6/Xfzu1IVMLoo7psYzfxTlAJ65RHjWpK3kgGEZ6JQa7ws9rym
 7vM8OQOH2GJRkLGYQovfhhFLLcAiRFbqwQ6y416IsVql9zn/5Sw4Hiwh/z9iD3/3wmNm
 u6eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/FCWQqF9bijiTdSrlsV2egAUs/daabR3lKiZGgOFAmDDzlBDnTcnXgIBNyJOOterMcyYnWycOJ9Wl@nongnu.org
X-Gm-Message-State: AOJu0YykZYaIk8W9q0byHqYF8WanryovpsxomoG6Q6hRL9YG/JPiEq8Q
 UoHIL3KFAD0UnG/rZXjxVqG5NIoYBXbZD4cNUdz5UDznsLLhMjwwUo/H/aY8Us+yZ5M=
X-Gm-Gg: AY/fxX4E4mGxmqXtC8PCvtZYMPlg1jNe2SyvIKHGY5GuhrYeCe66NPw0snOSeJkLjFt
 IN00EaSLxkQWJ1xTTGbwpIYb7qiBCaroRdUNf8LIq58shpuBeFH/xHIBWZuXhQhaIIe7rxsVXKC
 y09hL5nWQhf2+1uKkBl67mLdjhx3NNFCMEkCvX+L6TZRJ+x0o8b4H/m/kLtOQnNKqM7nTZTqMRx
 TeYu06wwlcyjeWGQWxPXMrOBa8BItfDXmWlnvhj+JgcBAgqyZ5CQoiJVHmMO22jR8E/WQ7V+0yd
 wuO0RcbkMUw98rEqBj8Sp8O3KSZHcfMroQa/NQW8u7NQuCCq7S86rZfQXdQJ57XVtALGvgl8HOb
 SxewPOjgfwHMglMjlnKTkeBPXuMvB0ktef8hcSTwqb26ufeMXIevHPDirpiSbgtKdc8018fa5A9
 QOjRs06SXei3GqddNo1Sc6w0AE4J0UEQq1i14juBtPeuAMTEk3nfyo2bGfckW5jt8f
X-Google-Smtp-Source: AGHT+IEp1VKJRIJInbHKktIiZelOl8YNjJMsm0/nLha6VEaF+Ge1Rqqw464IeKIoyPCPGjdQrjAHzA==
X-Received: by 2002:a05:6808:5285:b0:450:bef1:f4d7 with SMTP id
 5614622812f47-455864d9623mr2897558b6e.43.1765484077873; 
 Thu, 11 Dec 2025 12:14:37 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d4a09900sm2404733fac.0.2025.12.11.12.14.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 12:14:37 -0800 (PST)
Message-ID: <de93ce41-6797-4b0e-95cd-ffeaf16b5c89@linaro.org>
Date: Thu, 11 Dec 2025 14:14:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Record AS in full tlb
To: Mark Burton <mburton@qti.qualcomm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Matheus Bernardino <mathbern@qti.qualcomm.com>,
 Sid Manning <sidneym@quicinc.com>, Brian Cain <bcain@quicinc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <A5D46F85-9B92-477C-B964-1DCE2A1CCF19@qti.qualcomm.com>
 <0d3b4338-2c31-4e42-8a8e-319f3ad4029f@linaro.org>
 <2A86D9C4-7EA7-4275-943F-D75801B5539C@qti.qualcomm.com>
 <081b44f3-48aa-4af3-a0d1-c8e5915d95e3@linaro.org>
 <1400AC45-E6F1-4031-A95E-3F51B79D71DA@qti.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <1400AC45-E6F1-4031-A95E-3F51B79D71DA@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 12/11/25 13:49, Mark Burton wrote:
> I am absolutely prepared to believe I’m handling the IOMMU incorrectly
> 
> The setup I’m using is CPU->SMMU(TBU)->AddressSpace (totally unconnected from the CPU).
> 
> What I see in the code is that the IOMMU is permitted to return an address space - that address space, in the cases I have, is totally unrelated to the CPU concerned. The CPU knows (till now), nothing about that address space. The address space being returned from the IOMMU translate doesn’t seem to be used - so I’m not overly surprised that we end up in the wrong place. Perhaps what you’re saying is that somehow we should be ‘registering’ this address space with (any?) CPU that could potentially get to it...
> 
> What I see is that io_prepare calls down and gets the target_as from the IOMMU translate cb, but it only returns MemroyRegionSection, not the target_as, and then e.g. int_st_mmio_leN seems to use cpu->as and index’s from that …..  I don’t see what I can be missing?

You're right that there's a disconnect.

There's an initial translation in address_space_translate_for_iotlb() which records a 
MemoryRegionSection.  Later, during execution, iotlb_to_section starts over from the cpu 
address space and tries to find the same MemoryRegionSection, but translation is not involved.

I suspect we need to revisit CPUTLBEntryFull.xlat_section, "indexing" of 
MemoryRegionSection, etc.

I've had in the back of my mind a reorg of the entire physical memory subsystem, with an 
eye toward eliminating TARGET_PAGE_SIZE entirely.  The indexing nonsense would must needs 
change in that scenario.  All very hand wavey at this point...


r~

