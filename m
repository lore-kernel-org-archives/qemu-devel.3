Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0D5C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Opi-0006Jh-Qc; Mon, 28 Apr 2025 09:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9Opd-0006Hg-Jv
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 09:47:37 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9Opa-0002pq-Lb
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 09:47:37 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b07d607dc83so4149749a12.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745848052; x=1746452852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wq1rFmNEHgX2FeK42gIa+Nv74jFHymhRXwt6/Ht0GNg=;
 b=qAeqOnAyI0k3kHkQLyhiUmg6Ut5WRNm8ju//3peQQnI5M7M8s7bWnSgcDShH/EKMl8
 61eU7/UmpdarwZmbbsMX7xeHJdzN+4sGtPFu2rAaFaZxXi0mwF9xfxz41ECrmOhQ2kzS
 XdOGrUeAfwHUWvvxkYvXQRXuPgYyOC53TSFHjnVWCKgFN6AvmDU41gaoJPgvbhPJtrG4
 +aqQoc8DrvOnEYRxL9Qo55qbdQooCa11EUIwO8p7mMA9CpMIM9bT5vKeQyZ6NoYNWqwR
 dRNaVQ1tVUEzCOoR/Tqbd5TzBbAZfffVTYKgI2e8SGMoFgf6wYyaDxoI4PkxoWN7aQE/
 ULmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745848052; x=1746452852;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wq1rFmNEHgX2FeK42gIa+Nv74jFHymhRXwt6/Ht0GNg=;
 b=ntCWiBM3Eas7Z7p7/cK1vPkxJbdcvzM1dm5tKQQtI5DDDNk8b6WNxS628IV1OKeIU4
 MdCDzhKiGSy9wM0Hq6WfaRnWR2miUG1uFybanzirqISOi3KBx6KtutSUBL7E68y8LFNL
 SW8EhiPDESlYYHD/V+SWGI/rKOA7Ny78ZHhfLvcT8Qg7FGXeR/Heodzhs9dplN2761Bz
 cG96X0Jt1/st+NZyaARYqcL5GCz5bXIqK/dCmy35YUW/XzmtKqgbIdVF1xTmNAKljmpr
 /AFrbwIdgnv1yx0nSDgaafvxeW4Oy7UbK6OlkzlEpjzwOKng6wf7Hr6ZJesFiE0RPQK/
 yEfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOKag4RGJgI2nGWFH8u/N3jgsv2Ivuv1ZcGLxxrOG6ZRY3O3RfVhvOzfofXpcFlE4KIX8vYrNthdzq@nongnu.org
X-Gm-Message-State: AOJu0Ywl/ehqwI1OR+ESWKkRWZGCWSEx2Vw5agiVStMTqVr/w9PGSZhV
 hDfeAxLE+PMNtmlN3OWaizSI8sPfLKmFwyxGeMMZ193gYwiEG1oqT6pmdNIoBO8=
X-Gm-Gg: ASbGncuwZbJWTaBi9fUPTuCm4M3849B5LovOf1RIb6ZWj9TGYG17unY13dHwbiLEvt+
 YqdC7ElvKu5KOScnuJ8lRnXq4S5TfzG4eWmSyOORhTonw0H5/PKkD7NPdBo0YVqELpz23Zgeskj
 219LFpdOf1BgMf3jiz+5lHjhiWoYcY9UxPVQYHQNei5T07jtX3ktzXtUj0Z9iMnA8GIkOXsQudR
 KIa2tuiD9aQHhlotgoENlLc/HN03VJqAYEhtUu9XI/rf1hm40j4yM/o3ujDfmuAGKTbyoK9sBkM
 VsbLUo12eLDIJn1PYyTeeIcdisqryE3B50nKy2nSiUCXSdVOxWn0oV4JmKTbpO/bXcWfn6E6sc/
 c5ERPbBQ=
X-Google-Smtp-Source: AGHT+IGy2UhDGwgMs3xVh4FMzIQmk5kPFpFshvIqTcuvkXjcem9uiOSTdvuF3UPpQANnzjCdLZxybA==
X-Received: by 2002:a17:90b:2b86:b0:2ee:cded:9ac7 with SMTP id
 98e67ed59e1d1-309f7dde854mr15667906a91.20.1745848052250; 
 Mon, 28 Apr 2025 06:47:32 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f784a56asm7165759a91.41.2025.04.28.06.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 06:47:31 -0700 (PDT)
Message-ID: <ded56ee3-25bb-4ffd-98e4-2f47c500c88d@linaro.org>
Date: Mon, 28 Apr 2025 06:47:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/ppc: Inline most of dcbz helper
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
 <d3c6c417-20d9-a215-2a5c-86fa084b00fa@eik.bme.hu>
 <173c9111-e065-0dd5-c276-6bbc0351f9cc@eik.bme.hu>
 <2b969dcd-4a82-9086-803d-c52ea274fefb@eik.bme.hu>
 <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/28/25 06:26, BALATON Zoltan wrote:
> I have tried profiling the dst in real card vfio vram with dcbz case (with 100 iterations 
> instead of 10000 in above tests) but I'm not sure I understand the results. vperm and dcbz 
> show up but not too high. Can somebody explain what is happening here and where the 
> overhead likely comes from? Here is the profile result I got:
> 
> Samples: 104K of event 'cycles:Pu', Event count (approx.): 122371086557
>    Children      Self  Command          Shared Object            Symbol
> -   99.44%     0.95%  qemu-system-ppc  qemu-system-ppc          [.] cpu_exec_loop
>     - 98.49% cpu_exec_loop
>        - 98.48% cpu_tb_exec
>           - 90.95% 0x7f4e705d8f15
>                helper_ldub_mmu
>                do_ld_mmio_beN
>              - cpu_io_recompile
>                 - 45.79% cpu_loop_exit_noexc

I think the real problem is the number of loop exits due to i/o.  If I'm reading this 
rightly, 45% of execution is in cpu_io_recompile.

I/O can only happen as the last insn of a translation block.  When we detect that it has 
happened in the middle of a translation block, we abort the block, compile a new one, and 
restart execution.

Where this becomes a bottleneck is when this same translation block is in a loop.  Exactly 
this case of memset/memcpy of VRAM.  This could be addressed by invalidating the previous 
translation block and creating a new one which always ends with the i/o.


r~

