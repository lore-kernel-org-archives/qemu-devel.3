Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAE3C982DA
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 21:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8P85-0001oG-Ef; Sun, 20 Sep 2026 17:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8P83-0001nx-Te
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 17:31:19 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8P82-0003uK-6G
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 17:31:19 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso2580108a12.1
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 14:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789939876; x=1790544676; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Alt2boJfFpnGWQK7GEzim6rNbUuekPvfR7ZNFEaaT9Q=;
 b=gHDj2I2vjGeARa2Xbm8Kj5KobH/I1d6aT6vBS3UAK270eIGUJq8n7exIM11dxOtHA3
 +6Kk5EofdJ1CxwTU0ZShybtSRQqUKLWflJUFYQjy8I3+G1iQcrM1pplFAU5/c12g1Kyn
 khqCARYSXTyQkTCW1hcjpvNNVt3et4VfN1v0k/rA/ta0RyDNa+OesLV1IG8pdYWbNTt5
 Bfm/05QMfPuhZUlhwJ67IW5Fi2Ym+axKk/TSxQkW4jv7bF0E2BY4GJAhPgHnXaH7Yn/W
 FXbcWHeZuqWr0GA8EHSXX4+NmRqKet3H87f1Dp9f9Ect8Jbu2pNY6FFNWeaw+aA0N4H5
 AVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789939876; x=1790544676;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Alt2boJfFpnGWQK7GEzim6rNbUuekPvfR7ZNFEaaT9Q=;
 b=Pe4nS3SZaVw1ljHFvqoWn+iptcl7ifSn943eGxCCQZvwte9IwB5WJipEdLL2fFICfk
 wU6/pFURmDR+Rmddc23PREMvfyouvGCoueVPCmd5FVkGJON5TnbpR9g2dd4kDa6tnaxv
 rd9rvUVdnnfWDQnnAiMz3Yg3QuRHCeMX0JH96apIQkZ3zn7PEXXISNSF5XpG1StCNPSG
 1KCf5UTi/OUxUj3Im5MKKRKNTBNcvL+ZFDzyzFscy78NFu+edy9V5RmQdCE0LfOHd8iT
 6wsMRY6+0qUePMN2I1Aw2TsKNYfXfghpsTNifNeCXSbGzaGxfpXGonCNenCt+uuqNXNF
 zNjQ==
X-Gm-Message-State: AFuF++lr4+m4haA3x4izQhpdikmdOQPMhSRa3nYEDJgyjfMRZrMt24ih
 cHHk8mi8qyOfnSQ5jpkmqH//yyiCIjOnx/73LkOnA+ngtUcGQJzNE8qPWdQzepmVDP8=
X-Gm-Gg: AYBFou1rLBirAG526sK6LgRIXhTJzrfo8v+Zh0rUj1vAp3nYPSohOkUI0QyetdqI2Qk
 L7sCil93A6aoiW2XQRAc8EJVmNhb5RkpiQ4YjbcSthG+eJ6SGYDckS3OJ0XCNJF8d6hM1r5FvKI
 GPZAEwSD7PEjlfiBXptkvaEPcGHHhP1PayH5bGLXy5yto76M84KLxWZ3dox0NPEocZnafkIqu0f
 AF6YjZI8wb23zvb82rB+SIxD29sIJOMA+0hIQf1yZ/E747RkaCioM/Ahx9mrmiodmPIDAQnjgPZ
 MnfieDy3wZlBl1hq4LAhTctRw1OhmZFG3k0LotJ2R4HiqzLMKHsEVrJqquLc5Gxk1IFKLFqc370
 oJaGCMNgqXZ8MD3ROc5yaPOTRzivNbaXQRNlDerPKVZ4rG4PX+G2C8L55o98+n8lMU+bsLgldwH
 J0tANNnMI4Rr34ZH/xeD507fEoGYFL/puHbJHqEq/UxByVtBC5of0YlkQJsSifCBj/ZeW/JknSW
 gb6RpY9BeavkroSlExU8oeKU3ksbTdJ7p/jLk2xIznN0ABIvJGvmggUUASpbw==
X-Received: by 2002:a05:6a21:778a:b0:3d3:aed2:6f20 with SMTP id
 adf61e73a8af0-3dd72684de5mr14643246637.20.1789939876184; 
 Sun, 20 Sep 2026 14:31:16 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:5f56:e854:5df2:d786?
 ([2603:800c:7900:ed00:5f56:e854:5df2:d786])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c32f17dbdsm14935237eec.1.2026.09.20.14.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 14:31:15 -0700 (PDT)
Message-ID: <dfa3b2ca-b87b-4581-9769-2f90aba86c56@linaro.org>
Date: Sun, 20 Sep 2026 11:31:12 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/sh4: fix race in atomic variables
To: Mikulas Patocka <mpatocka@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org
References: <ae75af55-eb9a-5ac2-9288-aa116a3c4000@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <ae75af55-eb9a-5ac2-9288-aa116a3c4000@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 9/20/26 01:46, Mikulas Patocka wrote:
> I'm experiencing random deadlocks when running heavily multithreaded
> workload in qemu-sh4 userspace emulation. This patch fixes them.
> 
> The sh4 architecture doesn't support multiprocessing, the processor
> doesn't have atomic instructions and it uses a technique known as gUSA to
> provide atomicity guarantees w.r.t. signals or thread scheduling (see the
> commit 3b894b699c9a for a brief description of gUSA).
> 
> The function decode_gusa attempts to recognize several well-known gUSA
> regions and turn them into atomic instructions. When it fails to
> recognize a known gUSA pattern, it generates a call to helper_exclusive.
> Qemu will attempt to stop all the other threads and execute a gUSA region
> exclusively, so that it can't race with anything.
> 
> The problem is in the function cpu_exec_step_atomic - this function stops
> all other threads with start_exclusive(), then it executes one
> instruction and then it releases all other threads with end_exclusive().
> This works for all the architectures except sh4. On sh4, executing one
> instruction atomically is not enough - we must execute the full gUSA
> region while the other threads are stopped.
> 
> This patch fixes cpu_exec_step_atomic - it adds two new per-architecture
> functions: is_uninterruptible and revert_uninterruptible.
> 
> is_uninterruptible returns true if we are in a gUSA region and we should
> continue executing code while the other threads are stopped.
> 
> If we got TB_EXIT_REQUESTED, we must stop executing code - in this case,
> we call the function revert_uninterruptible that rolls back PC to the
> beginning of the gUSA region.
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Mikulas Patocka<mpatocka@redhat.com>
> 
> ---
>   accel/tcg/cpu-exec.c        |   15 +++++++++++++++
>   include/accel/tcg/cpu-ops.h |   20 ++++++++++++++++++++
>   target/sh4/cpu.c            |   25 ++++++++++++++++++++++++-
>   3 files changed, 59 insertions(+), 1 deletion(-)

I think this should be integrated into the sh4 translator instead.  We 
should not be single-stepping through the atomic region, but generate 
one TB that implements the entire region.

This may require some coordination with the translator loop.


r~

