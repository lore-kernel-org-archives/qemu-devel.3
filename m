Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F92C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 18:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwnH8-0000co-Ks; Tue, 16 Apr 2024 14:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rwnH6-0000ca-Ky
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:11:20 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rwnH4-0005LW-49
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:11:20 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-78efd0fcec4so10778285a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 11:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1713291075; x=1713895875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=auG5RWCHGk/FAaKPd7AYfXLqqOBvuXJINss/afGfkEs=;
 b=Zv/tJO0nxAv67S4B1CXR5nWzoxPUo/KkyBAlj/IxQ/FKQI5yiOiFoZMCDg4tGwXLsu
 gPAk8M142gF8AvR9CK+YCB+ki1LnIhGOkfWst1Xvh4BqnHh22+zx0EzAaO+0iFSrp/TA
 2TCDUx23mtb4YofYA5gb5yUcAGWQb2/PAZhDz9pbgXS0lwgkxfLUp/bPaQ8cn0WFCU3a
 HmGk3LRKboY4Rn3oAVQIbkAIo21sLGCrk6F0YN/M5n6cIRfAOlaW5hE+UI1Zz9xz55TG
 Vywa3On31JgtjYwTWumSqJst/wsXtV46VaRyT7k/DSM4/XEruaj2Vds0rK8n1hHxKIb0
 GeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713291075; x=1713895875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=auG5RWCHGk/FAaKPd7AYfXLqqOBvuXJINss/afGfkEs=;
 b=kUndACXMiLfS05BxBWNwIthhl6OeWl8KEiBM7dGtx/Z72Xy+4mZ4CuTvw2D1Byd0vP
 ehEpGnpQyVB2VHf3lDHgVx9sp2aF/fTghgdsw2ARfBPRlIlNUzf3o4Z3xOghPbi4UExh
 nNMA3v62Aj5U4FPWDZF4yAqNkhn2+fxCoqe1BGhq5HMOWijEzULUVVcsdNaLJ5TeKhkh
 ZTUE0tLSvNhKW6X2QXp+B7PzjP1E8mZToU0g/nFFVM5pp5qwW4qoRCjjfmHsSA8SgTN9
 YfuOsNj3BkNr8vhj0J6whhQoBnvQJBW/oFVdffHFd2dCQUx+c4yX71hVEmEY6BNOIGb2
 oE9A==
X-Gm-Message-State: AOJu0YwILiQftW9VmeyMpbyXKhpXbeAp1Ko40Z8HHb0sq6xlLIWBNK+w
 IPJ4WkJH1pP/e0pTRoO38VcyQGG69nJe707aAMGlvsNciB9NBZFeWOwSGO2hjQ==
X-Google-Smtp-Source: AGHT+IGQ1urUfRYW5aIY/1szbLgklG69Y/jQ9WbL6ChQod/5xd+lJx584XHimcPsrnDohJYLATUHiA==
X-Received: by 2002:a05:6214:70e:b0:699:1756:d78b with SMTP id
 c14-20020a056214070e00b006991756d78bmr13927442qvz.40.1713291075544; 
 Tue, 16 Apr 2024 11:11:15 -0700 (PDT)
Received: from [152.2.133.133] (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 de9-20020ad45849000000b0069698528727sm7635153qvb.90.2024.04.16.11.11.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 11:11:15 -0700 (PDT)
Message-ID: <bff71578-42ad-4af0-9ba6-e0962dd73710@cs.unc.edu>
Date: Tue, 16 Apr 2024 14:11:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Add 'info pg' command to monitor
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, dave@treblig.org
References: <20240415160818.2316599-1-porter@cs.unc.edu>
 <CAFEAcA88myOeQwZ212q9R4EHBPpJbQ1qZYjuz6SS=HZbqS+NCQ@mail.gmail.com>
 <fadb288a-4c44-42c9-b706-f5595d97f952@cs.unc.edu>
 <CAFEAcA9Fe8TerNSrg_AfmpFZNL_4B9WV0OccFdLakJhtCN+m4A@mail.gmail.com>
Content-Language: en-US
From: Don Porter <porter@cs.unc.edu>
In-Reply-To: <CAFEAcA9Fe8TerNSrg_AfmpFZNL_4B9WV0OccFdLakJhtCN+m4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x729.google.com
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

On 4/16/24 13:03, Peter Maydell wrote:
> On Tue, 16 Apr 2024 at 17:53, Don Porter <porter@cs.unc.edu> wrote:
>> There is still a lot I am learning about the code base, but it seems
>> that qemu_get_guest_memory_mapping() does most of what one would need.
>> It currently only returns the "leaves" of the page table tree in a list.
>>
>> What if I extend this function with an optional argument to either
>> 1) return the interior nodes of the page table in additional lists (and
>> then parse+print in the monitor code), or
>> 2) inline the monitor printing in the arch-specific hook, and pass a
>> flag to get_guest_memory_mapping() that turns on/off the statements that
>> pretty print the page tables?
>>
>> It looks like most CPUs implement this function as part of checkpointing.
> As far as I can see only x86 implements the get_memory_mapping
> function, so once again somebody has added some bit of
> functionality that does a walk of the page tables that is
> x86 only and that shares no code with any of the other
> page table walking code :-(

My mistake - get_memory_mappings() is only implemented in x86.

In doing some searching of the code, many architectures implement 
mmu_translate() and
get_physical_address() functions, but they are not standardized. I also 
see your larger point
about replicating page walking code in x86.

I imagine you have something in mind that abstracts things like the 
height of the radix tree,
entries per node, checking permissions, printing the contents, etc.

Perhaps I should start by trying to merge the x86 page walking code into 
one set of common
helper functions, get more feedback (perhaps on a new patch thread?), 
and then consider
how to abstract across architectures after getting feedback on this?

In looking at x86 code, I see the following places where there is page 
table walking code to
potentially merge:

* target/i386/monitor.c - existing info commands

* target/i386/helper.c - get_phys_page_attrs_debug

* target/i386/arch_memory_mapping.c - implements get_memory_mapping

* tcg/sysemu/excp_helper.c: implements mmu_translate() and 
get_physical_address()

Thanks,

Don


