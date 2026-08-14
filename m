Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E453C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wutDD-0004RU-DA; Fri, 14 Aug 2026 10:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wutDC-0004RI-F9
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 10:48:46 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wutDA-0003NY-MY
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 10:48:46 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-81ff017d420so28950137b3.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 07:48:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786718923; cv=none;
 d=google.com; s=arc-20260327;
 b=aPkxKBaRNSzLAPBogNOOOi+Ih2RnHi7fsNJFwmjDHiC+9/j5QLD0vO0Wj+LiVUn3AG
 s3Qf8JDjUMSUNDn56fF1vknADjDD9zneXmudDVztY9BENH7H1IWsLZASeOjPIlW9TkPL
 sgcO3jzuOTYfu0WDVUAQy4+bMcrERcC1Z0qVkDhMqs7j5y8RjaUk+FAhXoN0DIJVD9p8
 om6niaQwncRWXXGBUQqMECflcIUwcsfXZvJsypT/3211Jze/A0JrlRUA6PdBg8h1zFPH
 g0Bq2rAOjS18L5X+LmtZDF/a0JbmPgHj/TcMF6GI/hUd5I0bnrxKgDZGuBFH0b5r8TfO
 L5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cBhHqJ2vAnXffNQhmTEt1g2UqzcnnUVr659bRNRCf6Y=;
 fh=1VAF2WYA45yZH84kJqzuPyA16o8NR5X1WtriYu0VRS8=;
 b=cfOSZVGomGv9Pry+1fRktNeI54/qH0CSkYBDx9TlVU7gEz38ME3NQiCxw7qSUqGhYi
 fwsmaS0wAsGCTRSThff+BWs9Z6tvO955E+FQq6kzD9/ol+2QPIt7rVK4O6hsgS4MaYxs
 9vclp8dmS+FsL+XQgEu4C+9pGikLNCngrszmeWR+WY9k3RNRwtwnedq0BSdx/ScbtMfQ
 zWAJiXrbzDduMDGbX2yp2vKAkEXb01BqUpr7PUvHTxOnUAyX21fA7z/dd+KGGW5ztmCp
 PQAbOVE0MTG5uYWDkrMpTH2mpJ7+/vJNEv5ylCmaed6ELfelNrB5+5dYbHkUWOUfxPrg
 8dww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786718923; x=1787323723; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cBhHqJ2vAnXffNQhmTEt1g2UqzcnnUVr659bRNRCf6Y=;
 b=Sc3Ei5YhBR4aQ8UR61tB+s2ZnM/HOHGGCQd+9Yj6eePatPQEc1/xkqOTINdIIxmu57
 +Q0CHXJPtRWnbGs4coPB8DewAmdQkmluJhKUr/C6ECfAccn06fG3gF7GlpjoiYWsEoyt
 Lo1LLnJArenfUrE8CKzCfsJqKLJCtnGLVNvugGf6yPpRx7KdGCWyJb4qZBsVESXoQkUD
 dU+NqQR8vuqiKMvBfW+vrhvGbIQq5T9miqKpgtm5J5b2fpQlDEGlPqfJVuzhjTTdxgAE
 bQw9z2E2TcGewlKPOxosrYmNf2rUCZUr/gp93T6UEN8J/3mTDwXFNwO6OrG8SIZ58tdP
 vrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786718923; x=1787323723;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cBhHqJ2vAnXffNQhmTEt1g2UqzcnnUVr659bRNRCf6Y=;
 b=a4bgSNJmkpeDVBM0bbV2ja4SYQw+e3r7T87sfFwbnvphQm7jmergCcHhQXgZ/Cd3ct
 eZzlz9QSUCBg2x24cdqFyyFSxSyKI834a8mGmOqr4s6sTtTBb03dir9ToqhEd+S1OWYp
 Rb49guGGisdOjl0nlPqCBLYYRg0TyK5IkHrVmjT+qiyBKu1BM2jDzsHpLSoRkad4V6GA
 JghCq9/5R4cejRM/si5fDqXwazB8SyYxyVBEo1UX6/UgIURnXhCo9+sz3TRQfWAT5kv1
 qbpzVHT73AvRyOnpQflt4a5RNfwWqbkeyLZxYuLL6mG9PO0whF4KZ72hUwe8lS4fKcO3
 gjow==
X-Gm-Message-State: AOJu0YyUJZFcIMPrcdQq063oKNL//F8tUXoyIme5hVn6443h0vylb92M
 1hlQTdElDCQJZfACqiWan8KgH0vkxq2gO/J0gv0g4ZiI8l3M+UYULBK/4zNVmgKBIosr8R6RKsB
 fZuCLfcdPurvdB6RkA+FtfLqOb+soITSj2ZFmg9xP2A==
X-Gm-Gg: AR+sD10xrQ+kYmlyxgRaBG2l7XKSyQPiFv7PHI6Ou2rqG/fbPDrz3OZx4W5p/VRWorn
 W+sajCOF7IT4IZovP+RiERN1vPifp1vSYWBrX3fe4DUNv8E8GP1ahO31xVt8+QgorktZD9rIxB4
 XYi4P9Q4p9/XD88t/Z2M/mL1/HIjQK/lRKI4LfHU1AYXgtm9W7DwarUCgrhO0S5jYbg9OXst6lK
 TVt9apdIiK56k12JXQ7KmwUZ+9MGQIPCQKjDkm3io7NXCkc1AtXqgUtlVSMXVQXFJGiaYODhraH
 1Vrfv8mLRmEVzivfNsd3JJnKSW67lK1Sd7WfWy9cN43+uoehCmpkBBEaLfVQAkzAHY7Nblk+KNI
 aIU+OYAPufBG71JmBrLQFbUtEvy9etRal+Eke26k=
X-Received: by 2002:a05:690c:dc5:b0:81e:bc7a:df50 with SMTP id
 00721157ae682-83482c654bamr61231437b3.3.1786718923315; Fri, 14 Aug 2026
 07:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260814134035.2733355-1-peterx@redhat.com>
In-Reply-To: <20260814134035.2733355-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Aug 2026 15:48:32 +0100
X-Gm-Features: AUfX_mwwk98kz8GbsTjVAwXofOaN_QTjsLKHHnqgZpsHDZL-41Qf6U6dwhxzZ1U
Message-ID: <CAFEAcA9xnJ1i541bLbKheVZkPvSFH1NTerUomWV4j4DyHhOPgg@mail.gmail.com>
Subject: Re: [PATCH] system: Define ram_addr_t to be always uint64_t
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Fri, 14 Aug 2026 at 14:41, Peter Xu <peterx@redhat.com> wrote:
>
> QEMU's 32bit host support was deprecated since 10.0 and removed in 11.0, at
> least the system emulation part.  Now it's safe to move ram_addr_t
> completely over to uint64_t.
>
> It should be almost the same as uintptr_t as before for !Xen, except that
> on some systems (like MacOS) uintptr_t and uint64_t can be typed slightly
> differently, causing unnecessary compiler warnings when use them in a
> mixture way.
>
> Hopefully, this change also makes it clear that ram_addr_t is never used as
> a host pointer in any form, but only an internal QEMU integer based address
> space for allocating ramblocks.

I've thought for a while that we ought to do this even if we
hadn't dropped 32-bit host support. Having ram_addr_t be
64-bit should work fine even on 32-bit hosts (as evidenced
by the fact that we forced it that way when Xen was compiled
in), it was just a performance thing to use 32-bit values here.

Having it be 32-bit sometimes was always an irritating source
of "whoops, doesn't compile on 32-bit hosts" bugs and other
oddities. There are likely various places we can clean up now
where we previously were working around this (e.g. in
hw/arm/vexpress.c:a15_daughterboard_init()).

There are also a few ifdefs on HOST_LONG_BITS == 32, which
(where they're not relevant to the tools or guest-agent)
I guess we could drop.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

