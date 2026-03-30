Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BAC10F3DCD
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7DN4-000369-JG; Mon, 30 Mar 2026 10:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7DN0-00035n-Ka
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:13:34 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7DMy-00088V-Tp
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:13:34 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64eee7b83cfso4538199d50.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 07:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774880011; cv=none;
 d=google.com; s=arc-20240605;
 b=Otrc+/C0iPQYrq2gl4snYY08dkys0hjO/sgTVrLIe6rOE+DEL94BrfBugt8ZWPU1vB
 APnZfFJUsiblEBf2jGq5elg8QtSPzqBGNtjQhmG7dFnjbRmw7jkmiKP3q6N5Unz/LdJ8
 df2EAb4N6kh/viNPtfIwzv/jmtJhzIX8k+auGojy7Fg6zeQdf6i21aNLbqX87Acg7rYa
 cLk65IPMKBrlC/oEgxtSnkx9KjqIwfI8JIIKCNctzXwIw28K2Yhqdd3iKZVGSph6VvwQ
 QhKUnhiH12b5DUCwYwbRRCmZvdpKmVpPnmAZCKw6U+1VyzHbbuXsUtqclbxkMKGv9jGg
 KJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BvLqtlGVtGlPQMcsApYnXEWEnUZNZLfSvVHOdXb6KWE=;
 fh=qNOYlnUqFDykRQWM4aj8lmCUcFY6RlKAzClmjGUuhAY=;
 b=R4DHcHDsKv+Teo2mr/ev1sZi1WtFF+lxyQNQlx4P/3FGky2eRTH5hPFbiTIlR2oc0U
 59j0Ik8UvZemFGysbmx75r203cvt79S9vaqzk2TPJNPyFYiyDF7qELOp0kNbOm6fs51V
 l0Th2wh7a7o27XfButWOoV/GG6Pwb29hj0QO1M58CQh/u3yShYnHKo0x0X/ct2VLm0yD
 aQw6JWMZo6N5w+gc00IlZyndQ0Ic0ggG10Xbp7rqFR3/nwQQL2ZMnMYuydeIR1oukRzu
 ZHNQmDJg7qvv4luBoqllnnYjCucTPjTzzod3vcGHErt/9C+2/MYNvDwCLz2IlWLh2h2Y
 1pWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774880011; x=1775484811; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BvLqtlGVtGlPQMcsApYnXEWEnUZNZLfSvVHOdXb6KWE=;
 b=z3Awa7L9zO7cn2M7z9RfryPI2AB2fHcyioUmCgysrnXxYpAxbykDTnUxsHTjdiA2xV
 OylI0hoQqsrincZ5IZhxyqMNVbSxkiOCfPiaj0b9rUmurj6d9z0nwa4RvaPJ3F9IX3Ci
 GpAVbm51F2oRqrH5EnIUE1vsjwzDaRFvg7fUQhm5/eLYX66rKVQfxHhZoRKoxEtreL5r
 ZUWaBvVXtPaWrEMZOh96AXf4JczwkGUG6yRG/uAAD0tnfReC2zBF2IRiXmf0zmJsqkwy
 PFcQcn5wqhqnH2pxT/F68AinSqqhkc8E2grAEDhcyMAf849KTddy/Q8DdafVXzZYCsN5
 ryDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774880011; x=1775484811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvLqtlGVtGlPQMcsApYnXEWEnUZNZLfSvVHOdXb6KWE=;
 b=ak46IDxeIBpD6dq5hDrkNCQsjONUetO2HcUxj6nHybRykXIbWB7zXoGD1uZ417ns2n
 CWYNzBMnykrhNosE+CHBEb7aca4xNglj42DdSNAJpbFcS5yQ75+d53/RG9YvrxKFfxvP
 5UtDEpt1o8vEknrfMNzTDLKChg0QYAjd0kLo/j3cHCKBgLyFiHlVgr6+HCJI0nxb6rB3
 RumQR/AvW3eccInhvElFtCmv89/1JloJffygoOcPwvZvVjcMcO/SuCz0wMnPR/5qhQEW
 UuyX7qP+Nq8Zhf+2buQ88mwwSI5/1CeGUP7t5TdMVctYeYvB+faXzcRbHDawFhMJ3Cnd
 0eww==
X-Gm-Message-State: AOJu0Yw4zmlzSYHlux7gJh5XEEuLGw6FKI9QTgCXKLwWuurVswwEzv5q
 nbfBgnHYWwL2XuUN8tD55pqopL11ufg1SKjSwRINOal45afso/j7Cbn/aNNImtuS9lBb+oFLc+j
 yZbTaHKAr4VzpMRjt5VcRMS0Iv1z6E7IkRgyRg0kuow==
X-Gm-Gg: ATEYQzzkAZIDXyCoWNM86pv8KemJWi98qkom6UvIa59MjCz8PEsfUYamDR5ur5lr2/m
 +AigXzigvOObYJJnnjj/Vq0mvvBWHPw9wDEp4zo0aPRTCCAnNN5/7f0+5jjLo+v3mMF/eLH3ORF
 NNnura+iKE1lzldYn5H5qy3EYBzhnY3BVRq1L+FZbx08wdDKSomLxDs+7s75nZFurnAVLpkvEVv
 K65m2k/YAnkF6IXVnuok2CtPPOak3hA61Mw60PTLWOyXDqPzYHt9KfmYJoPvRWdzTQR0sNmnbS/
 P+6TajDBRK7P/b4Fb55R4mSjohigI8isfEJUdszjQ4Jb399Ok2f37ckMCROk5yQn0ms=
X-Received: by 2002:a05:690e:134d:b0:64e:e82e:8413 with SMTP id
 956f58d0204a3-64ff71c285emr12767552d50.1.1774880010601; Mon, 30 Mar 2026
 07:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
 <20250501212113.2961531-56-richard.henderson@linaro.org>
 <CAFEAcA8qDz9a21bmrLLrBWa7b5vcDQj82+iSgm-nEzbqD5MjsA@mail.gmail.com>
In-Reply-To: <CAFEAcA8qDz9a21bmrLLrBWa7b5vcDQj82+iSgm-nEzbqD5MjsA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2026 15:13:17 +0100
X-Gm-Features: AQROBzAMFdsMW_yHFpbcMsmAR0DZfbuoLVZBSynBLZZBsc9g6_wjqWD3F6Hz-4I
Message-ID: <CAFEAcA88R_-RFtQ_YdNicO3kLRd38b-=EFK-kSNHkCX2Vc8SDA@mail.gmail.com>
Subject: Re: [PULL 55/59] include/user: Use vaddr in guest-host.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Laurent Vivier <Laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Mon, 30 Mar 2026 at 12:40, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 1 May 2025 at 22:31, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Replace abi_ptr and abi_ulong with vaddr.
> >
> > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  include/user/guest-host.h | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
>
> Hi; it looks like this commit (7804c84a56f92) causes regressions
> for some target architectures (at least m68k), as reported here:
> https://gitlab.com/qemu-project/qemu/-/work_items/3333
>
> The problem is that for a syscall like mlock, we do:
>
>         return get_errno(mlock(g2h(cpu, arg1), arg2));
>
> where arg1 is an "abi_long" corresponding to the syscall argument.
>
> Before this commit, g2h() took the address as an "abi_ptr"
> type (which is an unsigned type of 32 bits for 32-bit targets
> and 64 bits for 64-bit targets). With this commit we now
> declare the address argument as 'vaddr', which is a uintptr_t,
> so its width is based on the host, and these days is always a
> 64 bit unsigned type.
>
> So before, for 32-bit targets, we took the signed 32-bit arg1,
> cast it to an unsigned 32-bit value, and then inside g2h_untagged()
> cast it to an unsigned 64-bit value to add to guest_base.
> Now, we cast the signed 32-bit arg1 directly to an unsigned
> 64-bit value, which sign extends it, so we get the wrong answer
> if the guest address is above 2GB.
>
> Why did we make this change? abi_ptr seems like it is the correct
> type here -- we want whatever the pointer type is for the guest
> architecture.

I had a play around with this and it feels rather awkward
either way. We could insist on every place where we start with
a guest address in an abi_long carefully casting it to abi_ptr
before calling g2h() and friends, but that seems bug-prone.
And we're really only interested in a vaddr version of the functions
for one source file, accel/tcg/user-exec.c.

The thing I have currently that seems least-worst is to have
the header provide two versions:
 * g2h_vaddr() uses the 'vaddr' type, and is provided always
 * g2h() uses the 'abi_ptr' type, and is provided when
   COMPILING_PER_TARGET

That way all the existing code that expects the logically
correct abi_ptr type will continue to work as it always
has, and only the one user-exec.c file that needs vaddr
types has to be tweaked.

-- PMM

