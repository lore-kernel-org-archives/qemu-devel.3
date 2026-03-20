Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD4E108B8E2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3WMU-0000Dv-34; Fri, 20 Mar 2026 05:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3WMS-0000Dd-MQ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:41:44 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3WMQ-0001IL-Jj
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:41:44 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64e9d72d5f4so1580015d50.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773999701; cv=none;
 d=google.com; s=arc-20240605;
 b=N8Bzkn+3zV4HHPE+3ghZetFOvq5Lgu6H+C4Yq+Y5Pj01r0AqyJYqkgpU/HmgUOgX4t
 Au1tO4iuyiEmmohXZOTl00XqRW/Tm/YjpdbXBswbvrgJgEaUuLIjwIgEvjV1A0AamHen
 7adFp5/y9WbAq9qRNObCsiAOSZdw4nb9VEhK/psQOZM/w2J+lkOYtX3V+ffLHJm6dGHB
 KjVKLfujQLOVfckxyR9JcomONPSaEpQSG5yPRI3aTSm6bz/A8UDqgFO6zl00+qab7/SR
 09QmPFG9KkFMyskYi9QVz1pUL2sQbWDtjqceK5v1yrCb7a/W8Ih1O2BBWJirhpKPgdEf
 Fmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lhrwwyWiFHgwwE+JFWcXSCJHiIs5As/qN1aH/74+nd0=;
 fh=BNPn5plGW4iapFgomzvvXDa0mZylAFxlcZuJupMSfiQ=;
 b=klbdHBOGmsZ2Q9Je+wiVIIPQ/DnkFTufGNPlUnbazLZTEZRf0htsIXKxUatU4XitwY
 I1i7Bc1ZJ82sVimazdj3PmYhRWy9wKIIQNhSPyQqOZva+tmtTkqxK88Dl+krNErJAAxg
 DB19EFcwi3ccouHpvWOZ45llVs6OMwAqgAVj6Qm8Zy0J1blxoVmTDPo58IEyohsqXdGQ
 7qe3qHEKK1JbruLqo9h6xgDBpI7P3yfCG2M7zhZUWFvLN8Q6CVP2DQD64RrXKhG4yyxp
 cdPU1w1zxkrkJrXkEGcNwoRTHrxKYq3YZ5CIC3y7K5zHCaDT8qlDWAdhPvL2KGoqLRzI
 9EJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773999701; x=1774604501; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lhrwwyWiFHgwwE+JFWcXSCJHiIs5As/qN1aH/74+nd0=;
 b=E1U3+cpM2RU2JyRY0zD7gKGM7fp/pMmi/dyDmibUj1bWYfmHq09aI49MQAx1sVTz+t
 eIg43V4XvTPbmTtq02B2p3yURVEiBM26DIOnLQ0qyN30PWe9+sH/05/JZmh89rQXnKeL
 nwXKnEaJeMaS6NPnnBggiu0HQts0h37++u1gKseJaeJrfPny8IPidWu1f4//to8FmVMg
 0McPgYiyYdg+qXI0vDWKNZEJdOTa0rbvbW4pDD3ji6AMprnHfJIIgluHLk5cSLaV9cxn
 3NLU8XWxIEBA0oIU8lJA95kij2SWFVCVgGKbOYzQj8LpNjrtNLoi/ufJyKwvmg5sZQ+2
 QkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773999701; x=1774604501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhrwwyWiFHgwwE+JFWcXSCJHiIs5As/qN1aH/74+nd0=;
 b=W5WGjWdCl35wAiG6Eu2dhYsmbdP/yYkoNtDflfVo1FzPje4C+VLQrZ1srPBEFwafnR
 l8fWdaTDfmHwYoAt5ySMgoOn1b08rZJyNpM158E5oBmyKs52PXZhlKJ8wAcbuPE1auhq
 +owYaqNFnVpNU7f01H/V4g7CotZL2EByIxYAqkv5ZAmMqMvgpVWMZaCRV6w5fKSywvn+
 rng0y7Fc66VmD5iW8gWREQFOo1iz6Z5cgnIyuUnKgDLzyAvT9Wj+ffz1iDUHgtPLoxPS
 GbLs6iYW65T2sA9aAA0D8CtGGWz1iXL3NTWYm+l7F5e1ufclC2UXsRtF20HMZFopVrKm
 fxwg==
X-Gm-Message-State: AOJu0YxlilcxCPnHehwEp/wBTxPOuxH0Ix/4Q0iz/C8omWBKXHsm0O07
 6ttOSOGdCVGCbEsEqyFgKdaRUl+CTntUoO3CP3p8c0q+mo/Cm3Oxk1Bk6NijR8sLOIDdBqv0muI
 mZgxejQhv+VWMf32X/mZ/NshF5Z7KoLT/UeqowRCQ9g==
X-Gm-Gg: ATEYQzzLW1fzYhE66RowjTjjUjmRJJQUKFEnhsYz9rg4Pm63b0WK26U/c+Zt/tu8NPz
 4jlClcPxSaLomayOnVhWpQsQfSJX7ZQsk0/Ha6kCkjS6gdwSoT8CF9ObW4IdnwI5NAzzmW6Js40
 eJeaHmNCbfDc02/F3p9U/UImkOuCl3rO33EDK6NXAJGihxYI/ejdDYvtv/2tWHHIj04pbzmOXL0
 AViKZHWXHU+K4ivdvHfyZbdIQvMKUnUHJHgMTiYNiZcFbPbBBdb83+ScD1bUpNHVzRmAVSnsI+m
 JXoc6q8OxtI555nPic4Pfwn5qs9ZMg+aiK2oFtjWJTsKatP4EtRw7VXfCZVmR2pOlgKc2QN/FRh
 4Hw==
X-Received: by 2002:a53:b889:0:b0:64e:73a7:7330 with SMTP id
 956f58d0204a3-64eaa8312ffmr1874795d50.67.1773999701305; Fri, 20 Mar 2026
 02:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260320055700.44715-1-shyliuli@aosc.io>
In-Reply-To: <20260320055700.44715-1-shyliuli@aosc.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 09:41:30 +0000
X-Gm-Features: AaiRm52lfDz_GwBdGgNcyXr9HnXAcyehYc1wBDvE7caLFl_sBznFvds2j0q1loA
Message-ID: <CAFEAcA8vWJUjUmweKS5+2YAQpfL3wOfd0pB29xgxqcuQrJrD2w@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user: update select timeout writeback
To: Sun Haoyu <shyliuli@aosc.io>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, pierrick.bouvier@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 20 Mar 2026 at 05:57, Sun Haoyu <shyliuli@aosc.io> wrote:
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3343

We generally put the Resolves: tag line at the bottom of the
commit message, above the Signed-off-by: line.

> The Linux kernel writes back the remaining timeout for select-family
> syscalls in poll_select_finish(). If that writeback fails, it keeps
> the original return value.
>
> However, QEMU only writes back the timeout on success. If the writeback
> fails, QEMU returns -TARGET_EFAULT. This can lose the remaining
> timeout and change the return value.
>
> Update do_select(), do_pselect6(), and do_ppoll() to always write back
> the timeout to match the Linux kernel's behavior. If the timeout
> writeback fails, keep the original return value.

This surprised me, but it really is what the kernel does:
if the select/poll proper succeeds, it returns the success
value even if the writeback fails:

        /*
         * If an application puts its timeval in read-only memory, we
         * don't want the Linux-specific update to the timeval to
         * cause a fault after the select has completed
         * successfully. However, because we're not updating the
         * timeval, we can't restart the system call.
         */


> Tested with the issue reproducer.
>
> Signed-off-by: Sun Haoyu <shyliuli@aosc.io>
> ---
> Changes since v1:
> - write back the timeout in all cases
> - handle do_select() too
> - keep the original return value if timeout writeback fails
>
>  linux-user/syscall.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 064bc604c9..877a3b8bb6 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1394,13 +1394,12 @@ static abi_long do_select(int n,
>              return -TARGET_EFAULT;
>          if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n))
>              return -TARGET_EFAULT;
> -
> -        if (target_tv_addr) {
> -            tv.tv_sec = ts.tv_sec;
> -            tv.tv_usec = ts.tv_nsec / 1000;
> -            if (copy_to_user_timeval(target_tv_addr, &tv)) {
> -                return -TARGET_EFAULT;
> -            }
> +    }
> +    if (target_tv_addr) {
> +        tv.tv_sec = ts.tv_sec;
> +        tv.tv_usec = ts.tv_nsec / 1000;
> +        if (copy_to_user_timeval(target_tv_addr, &tv)) {
> +            return ret;

We're about to "return ret" anyway, so we can simplify this
by dropping the if(), with a comment about why it's OK:

           /*
            * Like the kernel, we deliberately ignore possible
            * failures writing back to the timeval struct.
            */
           copy_to_user_timeval(target_tv_addr, &tv);

and similarly with the other functions.

>          }
>      }
>
> @@ -1529,16 +1528,18 @@ static abi_long do_pselect6(abi_long arg1, abi_long arg2, abi_long arg3,
>          if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n)) {
>              return -TARGET_EFAULT;
>          }
> +    }
> +    if (ts_addr) {
>          if (time64) {
> -            if (ts_addr && host_to_target_timespec64(ts_addr, &ts)) {
> -                return -TARGET_EFAULT;
> +            if (host_to_target_timespec64(ts_addr, &ts)) {
> +                return ret;
>              }
>          } else {
> -            if (ts_addr && host_to_target_timespec(ts_addr, &ts)) {
> -                return -TARGET_EFAULT;
> +            if (host_to_target_timespec(ts_addr, &ts)) {
> +                return ret;
>              }
>          }
> -    }
> +     }

The indent seems to have been accidentally changed here.

>      return ret;
>  }
>  #endif

Otherwise this looks good to me.

thanks
-- PMM

