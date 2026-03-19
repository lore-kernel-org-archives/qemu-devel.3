Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF72E1091904
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3I94-0005mP-C9; Thu, 19 Mar 2026 14:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3I8z-0005lw-00
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:30:54 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3I8x-00006i-25
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:30:52 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso1909138d50.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 11:30:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773945049; cv=none;
 d=google.com; s=arc-20240605;
 b=UeOXtqk+g4gOwrV8W74GAcWsX7j0J4vL0T2PkXA46gWRDO3yHYT1dyi0J9GwhJIL1r
 mVH8Ugj74HVNR2Uf6/l3JB+Lvyf6GL2wCkZOrjQ3P/CdnV5SdnX+c1mrvq1Q+2WtYsD1
 UbAm2zVWN1JN2BiRPph0jsc91SUegMQHGL9QwcztmEglms+jmrL/gsTNHnOA6f2BqZ54
 iZjXD7uimznvIJCzuQbfmntvWi/tMoUxv6d36p6IWmg3d/lPELWdrDmhkmsYac7abSce
 7TbRA9WWAtduFE5k9YfjTPJA5XJsMJf+6bFT1tUJ3OOMcZV1/lABMjirWWmPLFxGDY8j
 mHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=I8lcAC6tJVUUZKrDENyeBYATNzHzh4cCAFz/MtM/JQ4=;
 fh=BNPn5plGW4iapFgomzvvXDa0mZylAFxlcZuJupMSfiQ=;
 b=ObWyCKlDgUSlwT7HxTsyfJ2eOSm9KVogHLrGZm4A2L4LAR7xXQ7S57mIGng2aIWmNB
 pJDKVBrBGCvCdBiaX3R1P508E1f4Umxh0k6PEX8N9GxkNqfq3hSFWiwFTH6hAewFEYi7
 /I1NUwkYoLrrviGNMhznUisF4zJsw8/dOQF0LzvgXtt/u6zuYEUAFG8UPt0ymygZ7djb
 Ftst94GpqAFg/du0iY8bXDUrlZLvKy96l92HG4GLC8dsK8LGfAphTQAIzzI0cnsfxjDK
 fAVzgBAkvpvQKSeGQdEQj0oJvVtH8HEDFOR+MWzX4OqpBHN98vwsaPPB3gxShulnPSMQ
 Ytfg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773945049; x=1774549849; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I8lcAC6tJVUUZKrDENyeBYATNzHzh4cCAFz/MtM/JQ4=;
 b=YIpf8bUQWtRvcN3InmnHq2VAFlVbFLU7C56iZw1YZiWcFaNK77Z3CUtihhnTuP+Z5g
 +HQpdrZQH8Bdx7zSRKQwv8FLK0Zs6gEtZKqy5j/yuGRoWPI1jycqKmpQz3uPThRCgECk
 lsevGHcKfviSqVhMh7rF7Z+V7AUBS6URErAOo1bsMUkwFJN1jkGl23EklLUa3wskavmU
 sfGObUDpr4UWBWobPNGjrWNY2r2oxPDOtw7esk40rpFXmZlR944Jqu+2TLgJNlp0qZ8k
 an0xpp4wNnKLGhBRpny9peaGKJdkbQgHVmRUD2H/l0PZoimyCw9lbhoThg1BLPmhRDcL
 tdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773945049; x=1774549849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I8lcAC6tJVUUZKrDENyeBYATNzHzh4cCAFz/MtM/JQ4=;
 b=aMb4ikkjmIciFZ2EB20+c4T9ewQB8DvksFNFFfYK4S+OOh27nwTDBrHlQ+OsQS/Zby
 b+Gk71NMIgEgiTRMwReA9wUFl6uSIVv0NKyQl+MxvOCAfBwO/C/kxmS5n7Vc4+Sb9x6G
 vXVWVYTRppg3MOa1QwqkhlS9fqDRoFs1fD8ZOjZDcX5cNFt6iqTP36xdebxQiTh1V5oq
 AfTz7RWkQSUjyJ7wUp5HL9Y2FMvdiOeht3QoKAC5SCD7XJctuENkinyalGVH5jgj38n5
 hM0L+Rp4EdsEE6pBpUcL07cuhdACVy6vCXuRuyXJr8Xln0ZV5KXSdaAw0GHssKWF/tMj
 fTAA==
X-Gm-Message-State: AOJu0YwSwUWk5Z97yBC5vLJpW6PrdtdTN5HzrHCHjuY6GGcpTkUSQrj8
 Z4dTYVKTF1x7S+A1ESQlwETkyaRoXqPGrIlsph22C1HRfQG3j9zQVtX/obFdVZsESC8KfAfGcnB
 +fBZaqEWtFGBu4DZ65AQrYpGlxS1uWYCan7NM+fHW1Q==
X-Gm-Gg: ATEYQzwgSou+zBizOwXyfengF0zKNJhGE83VPdymdqliGMp85HCeGkefdwC1Kr2DGAU
 F3NceImf3qhCtuB3u5RfAAnlSKhlR0rJW6ou5r3vXwzKiuun8d5s2F0Bc8jnj+hxIObq67tozjK
 7xZ/wMR9piUv7Af0R5viHJcm1zfC1Qm8Ff9XfqsffVSyPrWj3+yMGVnxVNFV/SGtj6tgHWoNKJc
 vPINtChcRgaTSHWJBBp1zknc6GDZTueHy9fOCfJNuJ1H7XFiQztlv5pqbB/OyW3LkEfgnENEPtR
 NT7RcmE8zGhUWhqp1g98alYG4FdUfgRWMdvhtpGc+c27uIalK0Dc2cD4YKm35h5yWB8rgoepB+U
 9Lg==
X-Received: by 2002:a53:bdd0:0:b0:64e:9dc7:90b3 with SMTP id
 956f58d0204a3-64eaa7ab875mr461610d50.39.1773945049247; Thu, 19 Mar 2026
 11:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260317095216.25877-1-shyliuli@aosc.io>
In-Reply-To: <20260317095216.25877-1-shyliuli@aosc.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2026 18:30:37 +0000
X-Gm-Features: AaiRm53TBYR14g0I76EYwSMWO4mE3X-9o_JYOBmZ3i4fW6322qEcrKxNMnI0Q3c
Message-ID: <CAFEAcA_aqQ2Bd7fqm3XaCGb0chHjmxLmh79NTtJmLCrgQriQrg@mail.gmail.com>
Subject: Re: [PATCH] linux-user: update ppoll/pselect6 timeout on EINTR
To: Sun Haoyu <shyliuli@aosc.io>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, pierrick.bouvier@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Tue, 17 Mar 2026 at 09:52, Sun Haoyu <shyliuli@aosc.io> wrote:
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3343
>
> Linux kernel writes back the remaining timeout when raw ppoll/pselect6
> syscalls are interrupted by signals (-EINTR).
>
> However, QEMU keeps the original timeout and loses the remaining time.
>
> Both do_ppoll() and do_pselect6() now write back the timeout on -EINTR
> to match the kernel.
>
> Tested with the issue reproducer.

Hi; thanks for sending in this patch. I have a couple of thoughts:

(1) if you look at the Linux kernel code for select/pselect/etc,
it doesn't actually make the "update the timespec" handling
specific to "operation succeeded or hit EINTR", it just does
it unconditionally:
https://elixir.bootlin.com/linux/v6.19.8/source/fs/select.c#L295
So I think we could do that too. (There are some early-exit
error cases where the host kernel doesn't get as far as
calling poll_select_finish(), but for those the timespec
struct won't have been changed by the host kernel. So it
will be harmless that we round-tripped it through the
target_to_host_foo and host_to_target_foo conversions.)

(2) this patch handles pselect6() and ppoll(), but do
we also need to do this in do_select() ?

thanks
-- PMM

