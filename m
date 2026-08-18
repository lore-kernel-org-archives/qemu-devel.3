Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5680C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 22:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwSal-0001ZU-5a; Tue, 18 Aug 2026 18:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwSaj-0001St-Lt
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:47:33 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwSai-0002z7-6Y
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:47:33 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso600299a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 15:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787093251; x=1787698051; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U5rT7QAuswJzgtw7lqi6SXVFyH34DhDvNZqQHBEWI4Y=;
 b=xklJGyKb1oSvob2NshipxYaCLqKGbrrxcOS06nCtMfX2k1u+mUq9T49/hh+GMZKxrb
 B7fhZU8YC6pema29SIhzaC/fM77X0+g/I3yDVu9FMfcoKvvau7vFmsZuX9XPN/eJ73Qs
 4mRUqj36V11xikr9m8pj/y17jhsrz6utM4/mNCfES6udvs73N0WMnVoNzxLjNV0DwPg+
 OCkExvzjdAr4zWnNKDAJTe4I+6ZK1/FMhev0wXR6z9bgJ6JZoYf371McrbB04heLdPAf
 9ZCZAA1kBIDeqXxsOrhETpWWDZG3s5InVtdj3hneknV4tpckxI0XPeG/H503CqdqF5Kv
 wgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787093251; x=1787698051;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U5rT7QAuswJzgtw7lqi6SXVFyH34DhDvNZqQHBEWI4Y=;
 b=Ry8uraFzAW/3qDjgOgPAV3ROwrCKE7lrU6wKvmFucmJWgirR8PVj9FJttw9hw9maKQ
 9FJUZrXtn5mPyoZ1kdrYqi5lhXzb/uEZmjJKggGu/nDjt5qVwNIxbOYAtvDvupXAd1Xc
 i0IZw7wYChLQyx6t0R+MlUnRaYTpepkUv4FBwBH/jxHO10Gwj4o5SNDId44/zxx3iYqz
 u36a/dDf8OpM18k8hnkFLoGjYgNU183FviBXmDHA+MZKttSp3Ux39h9Q6hQ0HUhSYR98
 we8WV+naS0qBnfO52Uvkb1WeUW/e1SmRRk1LdVzb1m8SxdDWYvVTsSutYJbdKVm3WmyI
 2N3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqiZBr642VBITC2tpRQoW4ob9XgTN0xCt/eTw5vb+7B6xtkbF4XHjC96qejy2U9EKe1ndo0G42SRSNd@nongnu.org
X-Gm-Message-State: AOJu0YxNO6+YQrQEMDOfaqhfQPa6UTkbRzJLW8whhG3yC55IWnh8dl+L
 rMGlDaM948TGV4h0wPrs6dqmHih0um+gTkEyHalKI0y+omk57mnH+TuoN/grxVNzXm8=
X-Gm-Gg: AR+sD13kTUKeHQqhfJehE64sVE/SSwOZ3cHFG0te9e9BoTfnUqFbrq/KghJZ37qWFaw
 UWenNC9ygg1NMtT1s379h09q/XE9qLiM0OXOtGG2bct/2Sj/QNwGb0YNcwZliXJUzPK5djtYRc2
 F7Ru2Tl7/wf4LM+32873JWHibPrCtr7eBqqoroNq3XaMh4YjQEzwYrcouuQQeHeo521YAtQolnb
 maTUIpcquOpkw/MDKSDKXbnvvXCmkJNuSkC1MXOJ9vVi8O7QOcYCpOxwRjvUAtDj70PIVcmWdP3
 4H1nCfXzn9gd12d+tH0lslsRr83XbuuBKqOytw9JFoh4+qMMI9S8SSwFheIJdjEPLjAbb9O6KcV
 pTy6+06HnKFX53Fzis/F2kf4zDwRHQZtEwrR5cJUmQBQsswz1SY4kMHsbPd5acm7D6q8W9nNmEO
 T0niQLNi8F6NKNBgRQ/Q9XoNJjjH9wSKl7B4j5cH2Xr1K4IHhrejjlaMIvHBNeQCyUaNeczLvBB
 nlxxtt3
X-Received: by 2002:a17:90b:4c12:b0:393:1cf4:d972 with SMTP id
 98e67ed59e1d1-39580a80649mr428226a91.3.1787093250631; 
 Tue, 18 Aug 2026 15:47:30 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957faf596fsm250850a91.11.2026.08.18.15.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 15:47:30 -0700 (PDT)
Message-ID: <20f8c273-19e9-402a-9187-375afea214d5@linaro.org>
Date: Tue, 18 Aug 2026 15:47:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] accel/tcg: skip the can_do_io stores in user-only
 builds
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@mailo.com, zhao1.liu@intel.com,
 laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com
References: <20260818174247.649526-1-mattst88@gmail.com>
 <20260818174247.649526-4-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260818174247.649526-4-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 8/18/26 10:42, Matt Turner wrote:
> Every translation block stores to cpu->neg.can_do_io twice: false before
> the first instruction, true before the last one. Nothing reads it in a
> user-only build. There is no memory-mapped I/O in linux-user, and every
> reader is in system_ss: cputlb.c, watchpoint.c, icount-common.c and
> tcg-accel-ops-icount.c.
> 
> Two stores per TB is not much on its own, but TBs are short. An emulated
> alpha gcc 16.2.0 compiling the SQLite 3.45.1 amalgamation (255k lines,
> -O2) executes 34.2 billion TBs at 6.04 guest instructions each, so this is
> 68 billion stores for nothing.
> 
> Measured on an x86-64 host, LTO build, on top of the preceding two
> patches:
> 
>      before: 1,469,729,281,442 instructions
>      after:  1,402,816,253,499 instructions   -4.55%
> 
>      before: 120.97s wall clock
>      after:  115.75s wall clock              -4.32%
> 
> The emulated compiler produces byte-identical output.
> 
> Signed-off-by: Matt Turner<mattst88@gmail.com>
> ---
>   accel/tcg/translator.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Good catch.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

