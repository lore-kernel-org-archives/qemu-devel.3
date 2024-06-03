Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83342C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8S6-0007IO-7q; Mon, 03 Jun 2024 10:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sE8S0-0007Hk-EI
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:14:16 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sE8Ry-0001JG-2a
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:14:15 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-43feec1a475so21419881cf.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 07:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1717424052; x=1718028852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=htfnCi25EheVh9FsVUjvtPYrq2LKQ8fNesJnIGJPoiU=;
 b=alnVi4x8ysHzpgcCWrtUhvPITE/rwMyvM0Lux+4q4BxSjnMr7WNi2i3ehUvlhmJqus
 DFGi9edzNVJuHfysM0Q4lVAjCWtNavzLxkqcGA5yvOh0MumEWAkF0bM5XDRtgTm+/IAh
 8skvnyJEGaT1+eiMKyNM4fQp1Lf1yd4Y4d0VfRZHzkbKiANil7IP8VVbFuskLt9SUV4e
 v8iLgcHTAPoQLnMnH40fGwc8VbOf2fhSE3EwFcdOFvqvQKpGCZznyuRiyXzUgGlYTm9V
 K+UVd2l0x60ABtfdySdFTY9Obu7wfr9guD0FEpQ1Aty+7YuxzGmaqIDt569e8AnkpcQv
 cTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717424052; x=1718028852;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=htfnCi25EheVh9FsVUjvtPYrq2LKQ8fNesJnIGJPoiU=;
 b=CLPMtoam4ls0sLuLDHiLIAUGYrvssa9xwFpp7HCUSzslfWSZzYX+1rwn69O/SO8tlS
 9mTx2fHk5lW11nekMQ/3kvGG+eC/QyAVy++ocwLutVKYYINJ//Zm/DXZ9IeVnuE58g/R
 pw1pbvLX/i3ajU6UK8tIDNx3qyL1wcz4aH4aVQ3CmFELInchSSXXg2YBsk9X4q+FAwMM
 OcY+p5nKFsfmLeHfWYDH6mLmX1L7YrTlNSsR0OOkannWgy+tbrUGp4Rux9lRbjqlv6EL
 sMDIrtl4hTFUBxzTn4DqIgMYo18xBup3UqoKsPVPQasJ47aUOxnCd/ybrerUr/EbwptJ
 lpcw==
X-Gm-Message-State: AOJu0YwIQ4YOpagYewUYtF4MgQx/K+oiooLJOmSwpz7lYxIuqUmCOTTi
 OYDA/4WACVpU3A5G3jV3fE9UCTXnPouv7/2bLJLJYTioTVv1EekiBE6pNwFQ9Q==
X-Google-Smtp-Source: AGHT+IEQMqD83ml+OWW0bLztgyv4dOREIM/9AyDr9dD43r65Od0PUBoI8YismgTVDae+b1lOsbSMGA==
X-Received: by 2002:ac8:7c47:0:b0:43a:dede:73b8 with SMTP id
 d75a77b69052e-43ff54a5700mr98459461cf.57.1717424052465; 
 Mon, 03 Jun 2024 07:14:12 -0700 (PDT)
Received: from [192.168.86.22] ([136.56.85.135])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff23bfaf9sm39712901cf.27.2024.06.03.07.14.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 07:14:12 -0700 (PDT)
Message-ID: <f49772c0-77da-4ab0-bd06-05e6f964e813@cs.unc.edu>
Date: Mon, 3 Jun 2024 10:14:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] Add an "info pg" command that prints the current
 page tables
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org
References: <ZiKkWCjreGOMFX5p@gallifrey>
 <20240524170748.1842030-1-porter@cs.unc.edu>
 <20240524170748.1842030-2-porter@cs.unc.edu> <ZlnajZpUHyGDTgNx@gallifrey>
 <1bafa185-25bd-44d2-8f4b-51ca28125115@linaro.org>
Content-Language: en-US
From: Don Porter <porter@cs.unc.edu>
In-Reply-To: <1bafa185-25bd-44d2-8f4b-51ca28125115@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=porter@cs.unc.edu; helo=mail-qt1-x835.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/3/24 4:46 AM, Philippe Mathieu-Daudé wrote:
> On 31/5/24 16:11, Dr. David Alan Gilbert wrote:
>> * Don Porter (porter@cs.unc.edu) wrote:
>>> The new "info pg" monitor command prints the current page table,
>>> including virtual address ranges, flag bits, and snippets of physical
>>> page numbers.  Completely filled regions of the page table with
>>> compatible flags are "folded", with the result that the complete
>>> output for a freshly booted x86-64 Linux VM can fit in a single
>>> terminal window.  The output looks like this:
>>>
>>> VPN range             Entry         Flags            Physical page
>>> [7f0000000-7f0000000] PML4[0fe]     ---DA--UWP
>>>    [7f28c0000-7f28fffff]  PDP[0a3]     ---DA--UWP
>>>      [7f28c4600-7f28c47ff]  PDE[023]     ---DA--UWP
>>>        [7f28c4655-7f28c4656]  PTE[055-056] X--D---U-P 
>>> 0000007f14-0000007f15
>>>        [7f28c465b-7f28c465b]  PTE[05b]     ----A--U-P 0000001cfc
>>> ...
>>> [ff8000000-ff8000000] PML4[1ff]     ---DA--UWP
>>>    [ffff80000-ffffbffff]  PDP[1fe]     ---DA---WP
>>>      [ffff81000-ffff81dff]  PDE[008-00e] -GSDA---WP 
>>> 0000001000-0000001dff
>>>    [ffffc0000-fffffffff]  PDP[1ff]     ---DA--UWP
>>>      [ffffff400-ffffff5ff]  PDE[1fa]     ---DA--UWP
>>>        [ffffff5fb-ffffff5fc]  PTE[1fb-1fc] XG-DACT-WP 00000fec00 
>>> 00000fee00
>>>      [ffffff600-ffffff7ff]  PDE[1fb]     ---DA--UWP
>>>        [ffffff600-ffffff600]  PTE[000]     -G-DA--U-P 0000001467
>>>
>>> This draws heavy inspiration from Austin Clements' original patch.
>>>
>>> This also adds a generic page table walker, which other monitor
>>> and execution commands will be migrated to in subsequent patches.
>>>
>>> Signed-off-by: Don Porter <porter@cs.unc.edu>
>>> ---
>>>   hmp-commands-info.hx              |  26 ++
>>>   include/monitor/hmp-target.h      |   1 +
>>>   target/i386/arch_memory_mapping.c | 486 
>>> +++++++++++++++++++++++++++++-
>>>   target/i386/cpu.h                 |  16 +
>>>   target/i386/monitor.c             | 380 +++++++++++++++++++++++
>>>   5 files changed, 908 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
>>> index 20a9835ea8..918b82015c 100644
>>> --- a/hmp-commands-info.hx
>>> +++ b/hmp-commands-info.hx
>>> @@ -237,6 +237,32 @@ ERST
>>>           .cmd        = hmp_info_mtree,
>>>       },
>>>   +#if defined(TARGET_I386)
>
> FYI in order to unify all QEMU system binaries as a single
> one, we are trying to remove target-specific bits in monitor.
>
> How 'info pg' should work in a binary supporting heterogeneous
> emulation? 

In the discussion of v1 of this patch, it was suggested that we
rework this mmu related code into generic hooks that need to be
implemented on each ISA.  The hooks need to be migrated, but in
the monitor.c code there are several functions (pg_print,
pg_print_header, etc), and in arch_memory_mapping.c
(mmu_page_table_root, mmu_page_table_entries_per_node, etc)
that each ISA would need to implement to interpret its particular
page table structures.

I suppose one can also push the check for whether a given ISA supports
the command down one level in the code, and call a wrapper that
may do nothing on some ISAs.

Does that answer the question?

Thanks,

Don


