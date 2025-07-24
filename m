Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21911C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 16:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueyaK-0001pR-8B; Thu, 24 Jul 2025 12:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ueyaE-0001nf-Kf
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 12:14:14 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ueyaC-0006Ij-GR
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 12:14:14 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b391ca6146eso1099330a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753373650; x=1753978450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TZQ3WCV1wQWpewxVTW0Rr3ReeURQ/MoLhiKPbmuJpto=;
 b=v8TjjN6yw2CFptYNuhMknY9YND5HoiForpM4j10FEwmWR/a6Awghfooile6GcdHpde
 /+ZHMWGyvrG4KYPbkmQbYzBqQFIIobYoNH6uYxJBV4L5cctwWT53ZpNVwHlTaokbLLPY
 kfZP/0RLTuExOQMtiRwfOrH++YxfdQfNgmaUBF6Us7OzQQLvKVWW7BCdQjXA8Q+7kX1c
 cRKG7XrnQ4DB4OpqXyU5S05y/UH1hrvkfzPHCpIgo2E2XPvYy1AZfRquhakthi980qRn
 frUhLazz5EQjis6RQG1CZmeg+SFKLhAgNFxrQuCAE+/Dd7IIfpX0Iyk47oX5xzZMLcC+
 ODGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753373650; x=1753978450;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TZQ3WCV1wQWpewxVTW0Rr3ReeURQ/MoLhiKPbmuJpto=;
 b=kYjWqg8UYeem2RzRvZY5Dc2mrC3/6eNhAYUeewXQE9CmbTyg9GykQXvatUR7Z0Aej3
 i+zt1lHMv0LIsDqCnQ2izYHmATy00ewhlBUcblevczu2xchsK2MUcm7zvXD44xd+kIZk
 or6u5m77Qd6PG0Hrr3Gi0XxNOLXWR1g2JEFjmOUpigcNDO1ZrmGGXnYJnO4WQbapePyk
 LImB4rCFRAdD77DGT08U6hPg5Y8fHpcr9hw0nxZ9y/j0TH11cdsouVkAeKP+eXgG9vQ9
 pz/Usc20I0sQSiKZt841+u/0niVwENvrgwTxNOiDUffuylGtQwzVSWc0QPopW05VkZyF
 30pw==
X-Gm-Message-State: AOJu0Yw/aj1+QzXgIyRMJM/t0M6fvJSig/2MDbPyKdf8cMG0OKzLkLQi
 nX02yhbDrA2nOTXpori3p2EEYOHvmfoAtfod5jzzPLJG47PhTCcApDr5/HId52BhNct5uZHhHkm
 S3dJK
X-Gm-Gg: ASbGncu3ZxUwVQ7zbSglHk1w4rGFTMdF4GYNSnFNYeyvMT3Iz6GFcoM9SYG+3w2Kn7y
 pRIcN+LQbZMIRtEVPEySCe5A9V9nKBfqAOfrzrkHAt/NnyXUTF/EBzaf9W3ReNuPdCaW51iom5/
 LR2XpK2zPjCoF+f5TNlL4hiDUJpJvjz0zbozSLTFDHb0hhdpQChIDoKM9N6YQi/ZdtmDJ9uZHm5
 wp7+gc4Mk32lakyIyfFn+JD9HxdpT6V66TXM5CtxzDXJJckPAHWQxz4rNsY+leA6Xkpw/yrIrt2
 mCJtAj1Om6wOTLM+5g668wstxqAf7doSAKhuLQppsdVyIF6E+KfiuB/ADBQAGGEMaEuPagyR90d
 bFpCsShEKxrUZ4Xegzu661Yno6lEsSmzL/RNR+xSZ/dxqnQ==
X-Google-Smtp-Source: AGHT+IGaRUd/pKnI8oMozO4+xa6RM+YrAh6kU4yMr9ylIy6uHjQpw1u81mYGy3k2g67fVS6o9XZp4w==
X-Received: by 2002:a05:6a20:12d3:b0:230:8b26:9d47 with SMTP id
 adf61e73a8af0-23d49029880mr12297638637.10.1753373650535; 
 Thu, 24 Jul 2025 09:14:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761b061b14dsm2013158b3a.117.2025.07.24.09.14.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 09:14:10 -0700 (PDT)
Message-ID: <173c1c78-1432-48a4-8251-65c65568c112@linaro.org>
Date: Thu, 24 Jul 2025 09:14:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: fix use-after-free with dispatch
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Michael Tokarev
 <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250724161142.2803091-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250724161142.2803091-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

On 7/24/25 9:11 AM, Pierrick Bouvier wrote:
> A use-after-free bug was reported when booting a Linux kernel during the
> pci setup phase. It's quite hard to reproduce (needs smp, and favored by
> having several pci devices with BAR and specific Linux config, which
> is Debian default one in this case).
> 
> After investigation (see the associated bug ticket), it appears that,
> under specific conditions, we might access a cached AddressSpaceDispatch
> that was reclaimed by RCU thread meanwhile.
> In the Linux boot scenario, during the pci phase, memory region are
> destroyed/recreated, resulting in exposition of the bug.
> 
> The core of the issue is that we cache the dispatch associated to
> current cpu in cpu->cpu_ases[asidx].memory_dispatch. It is updated with
> tcg_commit, which runs asynchronously on a given cpu.
> At some point, we leave the rcu critial section, and the RCU thread
> starts reclaiming it, but tcg_commit is not yet invoked, resulting in
> the use-after-free.
> 
> It's not the first problem around this area, and this patch [1] already
> tried to address it. It did a good job, but it seems that we found a
> specific situation where it's not enough.
> 
> This patch takes a simple approach: remove the cached value creating the
> issue, and make sure we always get the current mapping for address
> space, using address_space_to_dispatch(cpu->cpu_ases[asidx].as).
> It's equivalent to qatomic_rcu_read(&as->current_map)->dispatch;
> This is not really costly, we just need two dereferences,
> including one atomic (rcu) read, which is negligible considering we are
> already on mmu slow path anyway.
> 
> Note that tcg_commit is still needed, as it's taking care of flushing
> TLB, removing previously mapped entries.
> 
> Another solution would be to cache directly values under the dispatch
> (dispatch themselves are not ref counted), keep an active reference on
> associated memory section, and release it when appropriate (tricky).
> Given the time already spent debugging this area now and previously, I
> strongly prefer eliminating the root of the issue, instead of adding
> more complexity for a hypothetical performance gain. RCU is precisely
> used to ensure good performance when reading data, so caching is not as
> beneficial as it might seem IMHO.
> 
> [1] https://gitlab.com/qemu-project/qemu/-/commit/0d58c660689f6da1e3feff8a997014003d928b3b
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3040
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   system/physmem.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
>

This was tested with reproduced in bug report, doing more than 5'000 
boot without any failure.
As well, all QEMU tests were ran on aarch64 and x64 linux hosts.

