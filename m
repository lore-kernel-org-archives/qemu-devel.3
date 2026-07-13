Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE68C4450B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIFK-0008Fb-Rd; Mon, 13 Jul 2026 11:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjIFJ-0008F4-Eh
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:07:01 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjIFH-0005iQ-PE
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:07:01 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so29517055ad.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783955218; x=1784560018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Cbeza0JweGBXswVZVljcfaCOtYAgEqnMzf8MThDE64g=;
 b=LXfpuhmz6Zvfd16jtDCNucbGSd5YZQiW3R1P4wQMPn0wzhWi+4roKeKi9aV+vNttYt
 4ts8F7yVoJ7B2Ogccka7G2J9xEbQZNiVXnD4X9pRGxI/1BRe4GuhsCWZUUNYvbgWwq/3
 W518rzlG8ee0DnxiOi7tXErD9Eo7+XPUU67Ym7DwvpbxSOhKmeJ7qW6+WEWfWBbQcIUh
 7pnsv+0Lt+C2hf7vaHMGru+DoOC58QdtO5cUVz4fIoOuwCSqYjqEcEKu/FA8u2Hs2K5k
 7fxHmJW8jbXM011W+s8pYKK/RoIG8MZ+VybB1CNj1y9uolgmjZA0vE0l5sv0WgPpKQ6D
 +W/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783955218; x=1784560018;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Cbeza0JweGBXswVZVljcfaCOtYAgEqnMzf8MThDE64g=;
 b=HVGMpBxPUmyNwk+ytJOhKZRkDUORSUzk9Oq1fv2GPzeUsrIqV+wHN1fC9xZVvCc0Ye
 nKc84+vc+91ttYA4OqSJMIWDjp/Or+d+9MrVOb4CClEuZ3Uc9Ob8Y6B9kq0gGSUPeTt7
 t60E8nHkMv4+nV0xGG0eeIET6YCVxUr8Jy0CmUNwwxdNMI56CK/ctb2i0SymmmCCyg/w
 vXDTGU7gFKLV4o/To/qBP2DAnfu9jGzpfcjWnxUGKleRwjgphUl3aHEw/0AChTWV7ix8
 rOukv8XMj+qbnGx5wWe07utjKaFE9NMyFjKMbZKb1xYDVq7ENciU4e+QQm/sjnHixure
 80eg==
X-Gm-Message-State: AOJu0YxRK3AskqXZTeNDZfrU/OrA5QcmGphZ/VHR2tJyOE4TLHG8Fw7C
 xbbNML6efTMXxMw9xU1F3sRgo4q4z2tgrErQ37mzLzGDZmirYvVF5CBEK6tbNbjo9k9GZKUCeQn
 FU9P3
X-Gm-Gg: AfdE7cnvAQJ6EXbRGP1ucj+AdWfzu9ZgOF/WsHVCHV0nHOxtX7pERDIX2JLio6mFTHt
 4wF6fAl3ivi5Ag9jOPbFCPXbj52PMLHFtj2gB5d3bnQ9Ztd1+k4o0he9kJnctbKndOiM0XuJxVL
 pKtvNsjg5HLHOVbZ2KcdII7cXGWq2NlRyalM3kNfbgZTDHhVc5rZ3r9gt3rpOOLtLmMCs8/9/+c
 AhqS2McobqEFem9KbtqOmmF4zXuZkiwwtenokw8fU7W4iRYCu/H5CicdgBbeDibJNhXzjC3ahhe
 iYrhErxUGncQsLhhF2zb4uXjFo/NVAKhWwEcR0ExisynQnIqw3okF/TIr1UeYXfLUHGPGWLPAYV
 eIe5i9ejh2/QlCJUHitVfud1z09/N+SclaybIlTBTexbLBGrcIudYSGf/wCcsiKucRvJo7pxOwV
 db/zgg/MzU0qPAesk/tXohdMeyDg==
X-Received: by 2002:a17:903:1b08:b0:2c9:ed2e:b8c1 with SMTP id
 d9443c01a7336-2cea17f82a7mr90421545ad.12.1783955217641; 
 Mon, 13 Jul 2026 08:06:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.146.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cee5ccb56esm2395115ad.84.2026.07.13.08.06.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 08:06:57 -0700 (PDT)
Message-ID: <c20d55d9-6563-417a-9df9-25a93c6641cd@linaro.org>
Date: Mon, 13 Jul 2026 08:06:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/sparc: Take pending signals in
 sparc64_set_context()
To: qemu-devel@nongnu.org
References: <20260713141429.3387066-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260713141429.3387066-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 7/13/26 07:14, Peter Maydell wrote:
> Every callsite of block_signals() checks its return value, except
> the one in sparc64_set_context(). Generally you need to check,
> because the standard pattern is:
> 
>      if (block_signals()) {
>          return -QEMU_ERESTARTSYS;
>      }
>      /* do some blocking syscall */
> 
> and we need to take any pending signal before we do the blocking
> operation, not afterwards.
> 
> The use in sparc64_set_context() doesn't do this.  It doesn't have to
> because the operations it is doing aren't blocking, so it won't get
> into "we didn't take the signal that we should have" races that
> blocking syscalls do.  But it does make this way of updating the
> signal mask inconsistent with how we do it in do_sigprocmask().
> do_sigprocmask() does the usual "return -QEMU_ERESTARTSYS", so a
> pending signal that was not blocked by the old signal mask and which
> will be blocked by the new mask we're about to install will be taken
> before we change the mask.  sparc64_set_context() doesn't check the
> return value, so we won't take that pending signal.  That's not
> wrong, because it just means the signal lost the race with the
> executing code.  But it seems clearer to behave the same way as
> do_sigprocmask(), not differently.
> 
> Make sparc64_set_context() check the return value of block_signals()
> and return early if there's a pending signal to take.  We don't need
> to return a separate return code to indicate this because the main
> loop handles it the same either way.
> 
> Coverity CID: 1660058
> Fixes: e0f0ce88eb9 ("linux-user/sparc: call block_signals() before set_sigmask() in setcontext")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> I thought about just adding a comment about why we're OK to ignore
> the return value, but eventually decided that consistency with how
> other parts of the linux-user code handle setting the signal mask
> was better. This was originally flagged up by Coverity, not by any
> actual observed problem.
> 
> Disclaimer: checked the original repro test case that prompted
> e0f0ce88eb9, and ran 'make check-tcg', but no other testing.
> 
> ---
>   linux-user/sparc/cpu_loop.c | 10 ++++++++++
>   linux-user/sparc/signal.c   | 30 +++++++++++++++++++++---------
>   2 files changed, 31 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

