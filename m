Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0A1C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nUN-0000gX-IE; Wed, 16 Sep 2026 07:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6nUJ-0000g1-6b
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 07:07:40 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6nUH-0006Fm-E0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 07:07:38 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 46e09a7af769-7ff1e4ffb3aso476989a34.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 04:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789556855; x=1790161655; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mBINFrGwuW4pXROi3Misnd6L/VrR/Yu/A2/Jd/DcgDE=;
 b=mpXODdV2mE57mfnXAJNNUnTkMBSZQ3Y+ev1tcqJCU7uRfsy4rDzSMODYn6zs5Y1HQ3
 OltPrT1ARKjsB/692Kp+cwMg8NXX/IBtdc9kMKsU8B3Vb/Yt+bT95BDUmfSV9ASLYBiR
 die4iPT6lseb2/nibcLlUaEa68rzI9/RZ0o5a/RjVxc2+Y2arqOUrCrzeOIJITYyjqkG
 FDnmG+DZ32ELnK526j2arH0TKRXLPqxZBInTBD8kHqJxDQzJjQPkdBsvpAuqHnX9ushE
 hsHn6jXGK/rBpPdWL6QiFUPmV9cYFfzgCh2dV/qvjGfLF+EDPGENpCwJ6EcAbO7s2LQK
 8jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789556855; x=1790161655;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mBINFrGwuW4pXROi3Misnd6L/VrR/Yu/A2/Jd/DcgDE=;
 b=w30hhImUNHbwrBHBpXgxfwtlxq6ecbRW9nefhNeSH98Ik76apDgE+9JJ2coGzacLXN
 YeyQCJUFOpDNFWKZYkqF5nAx+vrK5BO4QUc1BBHOUVnIFWjVU4VMzoFP1VLMMsjsUspI
 OJWC1clST/Squ/YvStf5098+y88Z8vlLopF4QmZ++TTjapyUvI4VP/OxDe2TbCwv1EMZ
 rDCDKnLQrBNJds3FnlELDqLbd2CyLODx6s94l0hQiUX83QiNeQXSPRdm+xNySpJNihyb
 OppPxvJUh1frBmyf4EIoUdnj5XbKj/x4c4zr5v3s3oF/zhasw/Uo9sbkopD4tyIl+d+e
 OC7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKcZDcZqXTKGBdUHIBVJWmt0JGbefjHB8P9VV0tPrtcDArLzCLIyPzAWyoDam+r0LRFh1W/U05B58X@nongnu.org
X-Gm-Message-State: AFuF++mYGue/TzrR7PuZzBDUEqTn/dGjXYapsBo/fDlvkxQX1DPpCNZW
 nb2OSmb8W6/qdhq6ZzYhmaxJEdz4pL6WCsqk3nerAIhsqeFWgTktmIA58VZNVvWxd98=
X-Gm-Gg: AYBFou2hLfmKtMOTSTA6ZbLue4+hWRPA8IfiXhw1DkoFqTUe8v7EzyX1m8zY5nc1+1h
 mvrDaqzd0ZkjBvP0Od12cWptRq1U2c22D0dc1teAHm2j2BGBhRVo6M+v42hdZOHLkYm0Uol3z5A
 tBKnKFy7rYpm3Y9nzTEj/qHjGVSWdMaW4NzTE4Ha59IelYTwPQqMSEYc7imgFxtsXn4WXFR07/J
 zXlFgLg01i7bM86YW9oDqCU1pbtX4Zijo1PmGQLLAZjU1iLV6Gi9AmVTuzbsJhJIPfTLynhYSOe
 12znunvvSpvPAIG4jfqOOvpi06urxYJHQ2W5CqkIowSZ93IuIjLhEVAug0dcknjg5402OoMG4Vu
 8VKEFJ1w5jOiqtIp1m5Kcr/mYS5K4ZCWX8hxNYFJ4gb3de8XpEEf/BESx8uD2OFecHU+KSxrb7v
 2ycEbCseIo2qVvSGZSyo8eZnbwl5awLQ4URUPeeRtFd6uaLBfpEGeYhH8YQ+ItuYcKybO3iKlJV
 PjN5/1ZGfvZ28pKNJUPiPALlPg86DQ+PVAEXWVRvGfEyS1E0alAztN8/LAtQA==
X-Received: by 2002:a05:6820:214:b0:6b3:619f:25ce with SMTP id
 006d021491bc7-6c7d1cbe9bamr2191140eaf.30.1789556855384; 
 Wed, 16 Sep 2026 04:07:35 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:845c:f507:397b:9b72?
 ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b2753csm14879339eec.31.2026.09.16.04.07.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 04:07:34 -0700 (PDT)
Message-ID: <cd5e2ad6-96b2-46e8-b35c-93cbc3616cd5@linaro.org>
Date: Wed, 16 Sep 2026 01:07:30 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] RFC: accel/tcg: allow cross-page goto_tb chaining
 in user-only builds
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@oss.qualcomm.com, alex.bennee@linaro.org,
 zhao1.liu@intel.com
References: <20260827050241.3713332-1-mattst88@gmail.com>
 <20260901034808.3524945-1-mattst88@gmail.com>
 <20260901034808.3524945-8-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260901034808.3524945-8-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 8/31/26 17:48, Matt Turner wrote:
> translator_use_goto_tb() refuses to chain unless the destination is on the
> same page as the start of the TB. For guests whose text is much larger than
> a page this is expensive: an emulated alpha gcc compiling a 255k line
> translation unit takes the indirect dispatch path for 8.4 billion of its
> 34.2 billion TB exits, and a large share of those are ordinary direct
> branches that simply crossed an 8 KiB page boundary.
> 
> The restriction was made unconditional by d3a2a1d803 ("accel/tcg:
> Introduce translator_use_goto_tb"), whose rationale was:
> 
>      Various targets avoid the page crossing test for CONFIG_USER_ONLY,
>      but that is wrong: mmap and mprotect can change page permissions.
> 
> That is true, but in user-only builds the invalidation path already covers
> it. There are no page tables: every mmap, mprotect and munmap reaches
> page_set_flags(), which calls tb_invalidate_phys_range() whenever the flags
> actually change, and tb_phys_invalidate() calls tb_jmp_unlink() to reset
> incoming jumps. A chained cross-page jump is therefore broken whenever the
> destination page's permissions change. This is not true in system mode,
> where TBs are keyed by physical address and a page table change invalidates
> nothing, so the restriction is kept there.
> 
> The rule protects one more thing, which the original rationale does not
> mention: it guarantees that execution cannot enter a page without a TB
> lookup, and so without check_for_breakpoints(). That is what makes a
> breakpoint set after a block was translated take effect, since insertion
> deliberately invalidates nothing. A link established before the breakpoint
> was set would jump straight over it.
> 
> So the chaining is only enabled for a run that can never acquire a
> breakpoint. In user-only mode every breakpoint comes from gdb -- BP_CPU is
> g_assert_not_reached() there, and the guest cannot ask for one -- and gdb
> has to be requested with -g before the first block is translated, even
> though with suspend=n it may connect later. gdb_may_set_breakpoints()
> reports whether it was, and is fixed for the lifetime of the process.
> 
> Add tests/tcg/multiarch/test-xpage-chain.c to cover both hazards directly.
> It writes the last instruction of one page and the first of the next, so
> that the fall-through between them is a cross-page goto_tb, runs it 200000
> times so the chain is established, then checks that mprotect(PROT_NONE)
> makes the next call fault, and that different code written into the page
> once it is mapped back runs rather than a stale translation.
> 
> The two instructions -- set the return value register, and return -- are
> all the architecture specific code there is; thirteen architectures supply
> them and the rest skip.
> 
> The test detects the hazard it is meant to detect: with the
> tb_invalidate_phys_range() call in page_set_flags() commented out, it fails
> both phases, executing page B after PROT_NONE and returning the stale
> result.
> 
> Run with -b, the same binary stops once the chain is established and lets
> tests/tcg/multiarch/gdbstub/xpage-bp.py set a breakpoint on the far side of it,
> which the next call has to stop on. With gdb_may_set_breakpoints() forced to
> false so that the chaining stays on under gdb, that breakpoint is missed and
> the test fails, which is what makes it a test of the gate rather than of
> gdb.
> 
> Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling the
> SQLite 3.45.1 amalgamation on an x86-64 host, LTO build, on top of the
> preceding patches:
> 
>      before: 916,415,123,244 instructions
>      after:  891,254,240,071 instructions   -2.75%
> 
>      before: 85.59s wall clock
>      after:  81.45s wall clock              -4.84%
> 
> Note that this is worth more in time than in instructions, the reverse of
> the preceding patch: a chained jump replaces a cache probe whose loads can
> miss, so the instructions it removes are more expensive than average.
> 
> Measured before the inline jump cache probe, when a missed chain cost a
> helper call rather than an inline probe, the same change was worth -7.9%.

Cherry-picked this to tcg-next.


r~

