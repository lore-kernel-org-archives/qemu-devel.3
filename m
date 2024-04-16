Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CC4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 16:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwm3l-0000v3-9E; Tue, 16 Apr 2024 12:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rwm3f-0000sy-DE
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 12:53:24 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rwm3W-0000N2-It
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 12:53:17 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4376157292fso671771cf.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1713286392; x=1713891192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qt0BjfkBmFp0M7zEWmzHIc8miGdMURRW+LUkX0QYWhs=;
 b=jqYgg6kaO6lPmUP5HNavVLiUrnoct4NB8i2rArovLzVJR1DT7V8S9LITj97SpWTvV2
 NThiVi7cFXLTXkbpXnq0djAk4f5rDK2KTFAHOylXPkl7MKhxClEIh/HzJvv3xTkDcpRH
 IoJvQiXLwbl9TPFav0wDCMXcmNsxyMCUD/EML+wp8Assn6UidAV+yudRys0VukVm44mf
 KH5dqg7QXpMCyFmWsVGjR43Sfj2YtQBxd5qt8oJyQejJsgR0irHNYpuoZs5nhlzqQe3k
 ew6NIAjyboFVsuRVU3hOkOFt1GMTKoBQrtzKGKdHeyNG27ojEcMcp2NP2fI8tMpI50mS
 phoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713286392; x=1713891192;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qt0BjfkBmFp0M7zEWmzHIc8miGdMURRW+LUkX0QYWhs=;
 b=oQnCebrr8W1Twa949nqWNaNCbkvEXaa0PazUW/t6sWZBR1oqX5ulS2A2X5XzLknTN+
 RqZxF/mzfqYmIEqSEMCPacRnJ2VGnQp89XckNCy4yh+vXBcba1nP7tUTnPyNY8rJf2qh
 RmudiosYXOP0mYXF1wUNjwCPWimTTAguQlFMqtQd+7cWAb31w+NjFSuiqDD7oO/Dti1c
 eGrPOsd5Gr3AbNuHLniQvzEmt333sm31IWgxUhi9L6FhLt5ALLH+vw5kiiPlENbBRYmv
 H+gXcrNJVSLXCUmMew4U4sAof7u+2Lj01lOxPTg9wXR5z1inVEBPic/U+I6uAexlrxlR
 5bDw==
X-Gm-Message-State: AOJu0YzJgBaOGrqBI/KBqsS+BtzSrLnJvdVLyXkzgKqZ7XqzKagHpGXf
 FxWCKDe0fSA1oizkUGoHaIpgzvlupLS0Ylawq1NB9qTdpKJIjJgYXa6ErZMIKg==
X-Google-Smtp-Source: AGHT+IEln2UovgG1mZ+otCXGHrWoMVI1goJKVb4LOyx2j4X72Hw6UAf9ws2iqG0wRn58uhMMrlawlw==
X-Received: by 2002:a05:622a:58f:b0:434:84dc:4593 with SMTP id
 c15-20020a05622a058f00b0043484dc4593mr16023218qtb.60.1713286392237; 
 Tue, 16 Apr 2024 09:53:12 -0700 (PDT)
Received: from [152.2.133.133] (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 e15-20020ac8490f000000b00434d86fb403sm7347380qtq.86.2024.04.16.09.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 09:53:11 -0700 (PDT)
Message-ID: <fadb288a-4c44-42c9-b706-f5595d97f952@cs.unc.edu>
Date: Tue, 16 Apr 2024 12:53:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Add 'info pg' command to monitor
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, dave@treblig.org
References: <20240415160818.2316599-1-porter@cs.unc.edu>
 <CAFEAcA88myOeQwZ212q9R4EHBPpJbQ1qZYjuz6SS=HZbqS+NCQ@mail.gmail.com>
Content-Language: en-US
From: Don Porter <porter@cs.unc.edu>
In-Reply-To: <CAFEAcA88myOeQwZ212q9R4EHBPpJbQ1qZYjuz6SS=HZbqS+NCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=porter@cs.unc.edu; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/15/24 12:37, Peter Maydell wrote:
> On Mon, 15 Apr 2024 at 17:09, Don Porter <porter@cs.unc.edu> wrote:
>
> This patch set adds an 'info pg' command to the monitor, which prints
> a nicer view of the page tables.  A project in my graduate OS course
> involves implementing x86 page table support, and my students have
> found this helpful for debugging.
> So, my issue with this is that it's x86 specific, and it adds
> yet another monitor command that is doing "show some kind of debug
> info related to the guest page tables", along with "info mem"
> and "info tlb". Plus it is yet another lump of code that's
> walking the guest page tables and interpreting them.
>
> What I'd really like to see is some infrastructure that is
> at least somewhat guest-architecture-agnostic, so we can
> minimise what a guest architecture needs to implement (and
> then make providing that mandatory).
>
> The other thing I'd like to see is perhaps some investigation of
> whether there's any way to implement something useful by
> using/extending the existing get_phys_page_attrs_debug() and
> similar functions, so that you don't have to write one lot
> of page-table-walking code for QEMU to use when it's executing
> guest code and a separate lot (that's bound to get out of
> sync or not support new functionality/changes) that's only
> handling these monitor debug commands. There's a lot of
> complexity in figuring out things like permissions in a
> modern architecture...
>
> thanks
> -- PMM
>   

Thank you for the feedback!

There is still a lot I am learning about the code base, but it seems 
that qemu_get_guest_memory_mapping() does most of what one would need.  
It currently only returns the "leaves" of the page table tree in a list.

What if I extend this function with an optional argument to either
1) return the interior nodes of the page table in additional lists (and 
then parse+print in the monitor code), or
2) inline the monitor printing in the arch-specific hook, and pass a 
flag to get_guest_memory_mapping() that turns on/off the statements that 
pretty print the page tables?

It looks like most CPUs implement this function as part of checkpointing.

Thoughts?

Don


