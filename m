Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62CCC36001
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvHVf-0007O9-UJ; Thu, 20 Mar 2025 11:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvHVd-0007Nh-8U
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:08:37 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvHVZ-00040c-Am
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:08:35 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223fb0f619dso18944975ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742483311; x=1743088111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tmknNAMYy+da1PqK3f6KHNEQwy7pLw2fn0cbDTr/O9Y=;
 b=GKU+kuvIZs9y7JULbtiNa9PYmBmxR9J23fta3KBR5CA97mnwgHWl2kBHLVT9EIDRwu
 h5pS9ZgGztBFj32FUvj+slFF7hwXBqlzvBXZEMceSyDUcRoRJNG8fKDM0o39ux2Fq9hF
 MgJRJYpDOu28filYyJadrs9nY3ctZRuQvpIDLjJORxjvb8/C5ADxGzFASsSOL/05Reof
 cdLQPqSUu78UHTkad6Ai4KRgUGapINvefhqzvghD60tuR8h4RxR2ycQnRgCynRNDFham
 kOj93pCxkBTe5cR1TuYZTL4i6HGIbtM7wcMuzZxRulP9pVp3u6XgZAVDelSSFaK6nYde
 H4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742483311; x=1743088111;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tmknNAMYy+da1PqK3f6KHNEQwy7pLw2fn0cbDTr/O9Y=;
 b=HQ6FcN7+wjeT+6BJ/kQnwzrOKzx+p02us8AGAex2jmY2WQ4IqjaIs9ozxQFJMoB6ZY
 oIOHUac4atU1OHqmVVtvPQv2W0+kLP8Up8Z5uoRGPCNmqrOUyM4TODWu6/kuZmuhC1jv
 rU+Ece0gfTOOhqLOrVALGq7dytyU4fsgkTqBtePg+xIgKNjhlaH8eXPaSFro8qhwrDWN
 EZFAw5PwZrFyPH1OCSmyjRv9RsECuHYVV7wpTBRgtTTr69Cu4jmgg0uPGmmAlfzHgJkH
 zsOGJRZ0W2TIwxMvIAHxS8xBgvonlgmLZL4DJ5CZoEQNu7Rn8MVkBjYaLAwMhadO+jwL
 6BGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0t3YchJdjtqCD4WlrITGWJL3shlBLhPeeQvEVygtUhfReQxN7rhfB24EgGJ5ER8xy7+roPSOPl8oG@nongnu.org
X-Gm-Message-State: AOJu0Yxd0ZQh+IyvRLnoZrA4STq7EzqzEG02q/yDeTIafiE3tphXC8PQ
 824vik2588x8b64Gr+tODN1T249ChwYj3l/NQtUqAN0u8afSzJ+KoOtqK0q5TnQ=
X-Gm-Gg: ASbGncvrtFcIrWaMzzEbqT94yQZo7s22UcSY1nJqxvR7uu4wV5nfDiD0pJ3Zj8wUlrp
 mFPtV6RhURi2v2N5YkL2MOEjEO5ITvBUFsUQRVRubTwFZyqXFurS/EzoPpOOfOCMCb3mIST0y4N
 6jciuW1m2XAYcAgfmy/fhg9FwC7JBOMqBrp0Kl3xHwTmEQhb5xV1Fs+Dvvc73sZpygRsD2tu4kK
 eryfDZ2l0mlfl4x9vsvlZs/73gVPTy3Jqbasazcuw9uD5tlf21qnx+X6NvRPWb9CLtxA0zl3gMU
 /WCNlmUqTbfwbjTtVd0ZtAm4jdfgSUdIo/bqSGy1Pcam9EamtBQtWa0Op10s2k0d
X-Google-Smtp-Source: AGHT+IGrRwBgCn9BPpzook8ixhwT3hKD3rA+4UetI3BPH7RA63Yt76eudBhJKKpBg1ucuLXPxIVubQ==
X-Received: by 2002:a05:6a00:4648:b0:736:33fd:f57d with SMTP id
 d2e1a72fcca58-7376d6cb9c2mr8642907b3a.17.1742483310774; 
 Thu, 20 Mar 2025 08:08:30 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167d88fsm14392290b3a.96.2025.03.20.08.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 08:08:30 -0700 (PDT)
Message-ID: <53508fc0-7bb4-4380-8043-a3b0344a7ba9@linaro.org>
Date: Thu, 20 Mar 2025 08:08:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Fix facility interrupt checks for VSX
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>
References: <20250320115924.107996-1-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320115924.107996-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/20/25 04:59, Nicholas Piggin wrote:
> Facility interrupt checks in general should come after the ISA version
> check, because the facility interrupt and facility type themselves are
> ISA dependent and should not appear on CPUs where the instruction does
> not exist at all.
> 
> This resolves a QEMU crash booting NetBSD/macppc due to
> 
>    qemu: fatal: Raised an exception without defined vector 94
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2741
> Cc: Chinmay Rath<rathc@linux.ibm.com>
> Debugged-by: Richard Henderson<richard.henderson@linaro.org>
> Fixes: aa0f34ec3fc7 ("target/ppc: implement vrlq")
> Fixes: 7419dc5b2b5b ("target/ppc: Move VSX vector storage access insns to decodetree.")
> Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
> ---
>   target/ppc/translate/vmx-impl.c.inc |  2 +-
>   target/ppc/translate/vsx-impl.c.inc | 20 ++++++++++----------
>   2 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

