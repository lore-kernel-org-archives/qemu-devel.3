Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C67E69191
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 20:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEa7T-0005FB-GE; Fri, 22 Nov 2024 15:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEa7S-0005Ex-0n
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 15:19:10 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEa7Q-0003iF-Dr
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 15:19:09 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-29687cd1924so1510546fac.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 12:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732306747; x=1732911547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6jLuvMtqvT5rkHdW2ytdeB/9T3UOz6A72McanXePIGg=;
 b=N10d+SMVmQr3Kl4FomFfj4heqaD9RSvbydNLeiOVsfiVQu1WDUJa2ziAUhSfOeFphG
 nd3PI5BEOMEho0Jkd4Brer8lWqBNvyTHA77UMa52wc95Sp4F11nzl4iRaGDb+kH7PDvj
 j/lRE7JA1+3OFnjiH5eBFTJ2gp6MWNX0FmAxhwQqibAn3rtcwtsyplKTNoewvTJqV2vn
 IqWF4bHgvORef62Jw8z0WrhsRXxGeLkaWUDewxuD6JkaY2fO3eEc2yNWYJJZZ9L2Bm9N
 Qnb7Ca87cJBd43ZpSpy/NMT/xGTr0zvDDEoUBJN517hB6cYbijaI5WuYGvJA1ZM8eCSH
 u3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732306747; x=1732911547;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6jLuvMtqvT5rkHdW2ytdeB/9T3UOz6A72McanXePIGg=;
 b=J3rxG2pAlMmxrEZ111O/yb3Rp/EOjBe+enoAa/+w4H2GTNp+iN2uY3wElw4bgGKPIv
 fvV5Mlxz3/g9Dr6pcfuTb+tMrKZQ1GwWRFw0oXQah1HmkpEbx2Xu/mi6ORwKzSvk0Oiw
 sPCRUNVR4wQIT+EiKhDmGf55+PRpG1XBhhGlNFhoGb8T/qUyfjkwuLfWKVX5qKt2bAV6
 8Go3meIjyVS+q6Gm8Ko7PVFYr4yKzRTyySG8gPQ5xwaVyTmt28HowVRe4Eu93gAeIxLz
 Q4W3eKTlDbcUEGIj0NTgTLfsCr2YoS1dJH1qhtHpmfaNx/2WU78sZxH/DiVfZPbQCSDP
 OF8w==
X-Gm-Message-State: AOJu0YzyjFnSni3ANY1NT5hH0RNynotx7OiFMchjIP22xkN3HOessxgr
 5wf34rQw4xvGfMS93SXx42nC8vFrsZI3xb72mYAFNJvQGTP/Z/i2khQLm+YZtwzDkaqJ6RJ6G0C
 AdsQ=
X-Gm-Gg: ASbGncusxNjLCFSBfheX7uBiIpMkIdYPwUGdStQTblYcaLTU9xYLxBguCK54P8qFKWv
 gjqxxerk9tFetkWY1xKa8SWpHyf+xBspudSLez4uhhHNJcAGkgeobE1Vme+1pb+DJlanDbq/7xH
 NDcRJKpngR37DuIcgX06FtOQpSRlD4IAFeDM6xdtPchONA14HNrzVNKg1ldB2t0La/4plLrfPmS
 X7gJLDroh0t5yNszfWGyKkuw4L7/5PvS+52VXQzf8QMPWK8wTJSEiKPKGX/SHsQPtbDdZ0=
X-Google-Smtp-Source: AGHT+IFoe7ZelfNplTOIg39aOsGYIC6ybkhOXKcOdXhzaZq37KwVBRVFkr/f/5E8ZEBrnx9pkvxDKw==
X-Received: by 2002:a05:6870:7007:b0:277:d8ee:6dda with SMTP id
 586e51a60fabf-29720d6d6b2mr4869984fac.23.1732306746718; 
 Fri, 22 Nov 2024 12:19:06 -0800 (PST)
Received: from [192.168.170.227] ([187.210.107.181])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d822cf3sm794649fac.39.2024.11.22.12.19.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 12:19:06 -0800 (PST)
Message-ID: <621ea58f-c5df-4548-83e0-ece0b73eeb71@linaro.org>
Date: Fri, 22 Nov 2024 14:19:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Fix strace output for s390x mmap()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20241120212717.246186-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241120212717.246186-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 11/20/24 15:26, Ilya Leoshkevich wrote:
> print_mmap() assumes that mmap() receives arguments via memory if
> mmap2() is present. s390x (as opposed to s390) does not fit this
> pattern: it does not have mmap2(), but mmap() still receives arguments
> via memory.
> 
> Fix by sharing the detection logic between syscall.c and strace.c.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d971040c2d16 ("linux-user: Fix strace output for old_mmap")
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> 
> v1: https://lore.kernel.org/qemu-devel/20241119211138.148806-1-iii@linux.ibm.com/
> v1 -> v2: Share the detection logic between syscall.c and strace.c
>            (Richard).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

and queued.


r~

