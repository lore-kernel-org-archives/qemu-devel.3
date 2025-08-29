Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741D1CA1001
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNBt-0007YN-3u; Sat, 30 Aug 2025 11:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uruaa-0005RA-F3
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:36:04 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uruaY-0007iv-77
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:36:04 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-71d601859f5so14618837b3.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 01:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756456559; x=1757061359; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0zjbcE5G1LG37y+Wg67giIDmYYPj4UoKECNJHfTw8jE=;
 b=WMyCo3U6BT22H554eJiw1O4gGdw61e/CTTpYVw9EqjewU34EemMnKB8wPlwFsbb11P
 tItRjmwqIEQWoU/VuyfY+0oiwI0fcNjAZsdd7nGnWjIAz/jPaqxhikGcxSy5GLjSQMSQ
 5bJssMGlXca8YPHbooTFBnTof2kAubNMQ/EfTROtgfCiv9I3AFgzoMIl6kcexYNrbw5/
 yiCOIKTMlLPEGM/6cvL0crzHS6Olgdx5n4XErY7NjYwj3Ji5Rvld4xvC31Hgh+p9Wol3
 Xzc24GWBVQU48OoM/oTzxKU/ghzQktVrvFGE5qR//lMcHB57Gg6BOy/35AZz+yooiOAT
 D3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756456559; x=1757061359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0zjbcE5G1LG37y+Wg67giIDmYYPj4UoKECNJHfTw8jE=;
 b=hShZ7jT+AaL2Xdc0WLsKFqmeKv136iNxv5pSh8l5QczOix4XWugR98r3Eho++8+9Yj
 JsO9VEedB8OPKozwQZphqzljJL3EKLGNF9BEufFTDp7u13PZHkJOF4G4HEPeK9jFHGQZ
 Qsts1tCTe7NKcNrLP7EhFcQUZjGs8A1fuHSsu93ZIO/o33t3nRZlYDzgZz52yleNnOV4
 2TQZ7AOTCmbrha0uFuMnKzw9d78MwWz7FPDBIFZcUmWPC6zqge79b1vXmRqK4sJe2uH/
 FjFcFn1nAPp61FiNlMJfFh0C+enZqE7vtx7PpEzk/ECUivTeVx8hVPPjGtYWMsWeV5gF
 yQpQ==
X-Gm-Message-State: AOJu0Yxs2PWbJUVlAAG9vWCUHU0Yv73BGQalfVFSJkijzeqMoAr9tlZl
 p9AdaDdCs69fQpSE11Hy3dvKyaAzLjDfHtZAL7dlei7JNT9ZcVTq/tfm2FVQpjE5hjFYdTStL2J
 +fM8UdTVhmUmW9h4Wc8quj5OF1vFoWEIjfou37UQ2du0Cmz9Bazx2
X-Gm-Gg: ASbGnct475k36TY4ekIhd2znrGuw39T2aZN7IKWiP2rb+UrzBQInnkApN0F3cBBd/q6
 VrLNZMSRgX7ZoacqsyJS4gRYEa+acBiHyO8wA4AW8XzQhC3pICK/jpqBOEAy9SNdas384DjfYk6
 z9NB3NAGIAhjOD7A8qOYzt6zowTKM/js9ttBg/yZnToi6NTH3Ba96FTRH1NPiwYUMcrCLxnFn1F
 NmAkRgV
X-Google-Smtp-Source: AGHT+IER1fZcdoLrcWyjw9xrYFLIAm5xz1C9XggfOdwb3Ix9Kl4YiA+SHAowHtuB3YljJFkafTcdnR4E2FNDwNOzNJI=
X-Received: by 2002:a05:690c:ec8:b0:71e:7ee9:839a with SMTP id
 00721157ae682-71fdc2f17e3mr299279997b3.2.1756456558772; Fri, 29 Aug 2025
 01:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-39-richard.henderson@linaro.org>
 <CAFEAcA_a-G1hgeefCxdZQMxcGv4=-23fRMM8TifPTuBCJcbKVw@mail.gmail.com>
 <e5ff8c1a-4f6e-42f3-9ff5-38dcee98cefd@linaro.org>
In-Reply-To: <e5ff8c1a-4f6e-42f3-9ff5-38dcee98cefd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Aug 2025 09:35:47 +0100
X-Gm-Features: Ac12FXzIlG-oRKE4Pa2FJGStJka6cFJqqNir5gavCYfEMKRKmrg1g8gz397djqM
Message-ID: <CAFEAcA_8uPM5rkRfqp3AKM5J6vkswAAuZDVTyiEs1J56jvzHug@mail.gmail.com>
Subject: Re: [PATCH v3 38/87] linux-user/arm: Expand target_elf_gregset_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Thu, 28 Aug 2025 at 23:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/29/25 00:47, Peter Maydell wrote:
> > On Thu, 28 Aug 2025 at 13:10, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>   void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
> >>   {
> >>       for (int i = 0; i < 16; ++i) {
> >> -        r->regs[i] = tswapreg(env->regs[i]);
> >> +        r->pt.regs[i] = tswapal(env->regs[i]);
> >>       }
> >> -    r->regs[16] = tswapreg(cpsr_read((CPUARMState *)env));
> >> -    r->regs[17] = tswapreg(env->regs[0]); /* XXX */
> >> +    r->pt.cpsr = tswapal(cpsr_read((CPUARMState *)env));
> >> +    r->pt.orig_r0 = tswapal(env->regs[0]);
> >
> > Why is it OK to drop the "XXX" comment here ?
>
> I assumed XXX meant "what is this", and the answer is orig_r0.
> I'm not even sure the value is wrong as-is, due to the way we process syscalls.

I suspect the XXX is probably because the original author
was unsure why this was here -- after all we've already
put env->regs[0] into r->pt.regs[0], so why have the
extra field if it never has a different value?

Compare the "FIXME" comment in the m68k elf_core_copy_regs(),
and contrast the way our x86 code is explicitly
putting some other value in orig_ax. Are these different
kinds of orig_foo, or are we doing unnecessary work on
x86, or missing something for arm and m68k?

If it is OK to use env->regs[0] here we could probably
use a comment explaining why the struct field exists
and why our implementation differs from the kernel in
a way that makes the two fields always have the same value.

thanks
-- PMM

