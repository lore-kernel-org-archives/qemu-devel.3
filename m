Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBF4106705E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 15:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0iKH-0007hp-2I; Thu, 12 Mar 2026 11:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0iKF-0007hD-VB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:51:52 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0iKE-0003Nd-GC
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:51:51 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64ca09f2170so1303691d50.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 08:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773330709; cv=none;
 d=google.com; s=arc-20240605;
 b=Afvc/Q/PsXJbV1rp3k0Y9ymPh11xCfC5zzZtibTsDuQFql/HkwIWY3+MHaQ1wNsR6/
 /ez+w9FWaCJ8KTuicGtq8WNLa7U2Nsjzvsy/eRcJr0HCraI8+IEwQ5bOwTOmfB4srwjj
 5myPf2U1KoqAxjZqSCArq2MpHbKvebvU2zDnNy/hfGqJbzKYpAKgU3ZEeFgdlxvXrJbF
 9evOTbodLykJM67of8hYv5qWpJ6DVARQJ+rl36LeHNNXyFDYS6KitAJomDBGeTBgL+3Q
 7/gdAgMUG74ir12GwSUsXI/n72+dAoO4V1lkg/jsNJd1KOyp6ISSIKvhG0sgOlNp75ZM
 +ECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EnZZpg5o2fNNayARv6B0GWnrOpvn9bEaVX6JRBD9aac=;
 fh=mSAWogS2lmVC2ggos6iN86HIztrGu13DCLQVfy2chR0=;
 b=YVoJAgEww/8bm+yskPUPkyxh84RHDs/A8mu5aIndcvbpdOjr9U4Wqvp4vKjP6FShn4
 BTE88rZGwh4JkasGF0P+tzoMF6hnC88w4s+rZr06lWi6OgaJ3/rUYPhdOUrRNq7FJZlY
 RmMvCm4VWf6D8eTKuFqfzKhpj0tUvBUr1CNjhx0N3ik2+1vw9xCTvl7m0U88e5l2Uzz3
 0Xhvp6zh4aNv+It0824q776NN6kXRuoPTEgjt5mAS9tgR2LYtdQyPxMNjasB/XqrYYMP
 RoeA18SBGJ2NQySc87v2q6VJtAkdXjITH5eiYYiWoj8AC2fVCMEoNYsebZx45YeE7E7U
 ETGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773330709; x=1773935509; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EnZZpg5o2fNNayARv6B0GWnrOpvn9bEaVX6JRBD9aac=;
 b=adkilddIoNGR258h003rfCsMtsYEg8z4ucXZ0W4NnQ0PcJ/lGSTmudu8LFIt+zLiba
 52baPMDPZbrxCOM3vH/tFgqsu6cBUwHSr8j80KGM8qlgIbAlPCrE+A4293ZdWMfE0Uwi
 NdTJln7b7vjeA5uXl73LP2SkZLZvrVR0FNp79s1L52M/gbtkVnNLrKWsWBLiEOdGZLoO
 j2ZpyzByH7R2Kc8IQodViHgxM2Ttj/qTpb2WmVMzcizIvNQrmQM5lnIn3yqH07xbTlsP
 RrsgoDAmUAbQz3hqwPePsDJmfcAWFe8lydkVjwr+onvA7/PmSa9RF1F/d29IRo5sxxuv
 e6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773330709; x=1773935509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnZZpg5o2fNNayARv6B0GWnrOpvn9bEaVX6JRBD9aac=;
 b=VdJXAn4BOmRrd88HkmNZpPRLKBmu3RwZ0taEBXhN8iI4lyf8+QnxgS6gY4ELO4IRxm
 SRApMYKn4qg2y2kQHeLm/yPhnUG3kj0Ubc3ez0uHNC3RlTAoZHYkKzS3vQv84mrNZlDN
 yqNcAfu5phCdNnn/9WYYIytKo3HPmJUjcpyiV27c/CpA4wyEjbIFi4aY/QS+7eTL+uD1
 cNH6JmF/NoDcbjeIFOrjJngBB3wvJky7HDWI04Zi72COtxOuxZCJ394Xta24d8I+xtxs
 QQWjIdTP1wddjCDZxQz1/1L1LkqsS0qd6w77PMyPhIljX4mcNu/JsnFaSwCCbeQdKxEi
 JFVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4JG0wPHpce5w6zew0s5rdvUg2ql8ERAhQ54qcF5JiZvVfm45qAcG8zPGlajECgUGm1ICsaJ6e+ZdZ@nongnu.org
X-Gm-Message-State: AOJu0YxIHIZWNG2pfJ2MqztCYBymuw3SaebN23RBio0hkLlySt++ST14
 PbYRRkFLxAyE2AcSX28/P9EHGCqN+jlq/NJ8FHDFU6fIx+nLrVdsxLRIO/740Zcm/GDE77ZDKHq
 oZP9+HH2iK5t5IDlnTDG99QRjGwUamE5MlTXF2fH6Cw==
X-Gm-Gg: ATEYQzwDosjrzJl+p8Kghyiwj5GQdjpRC2YknpMdVDTqSqP7UhRBZIkkG3An1o1Lgim
 8xgJaaIa/CXmMss8LjLDqSLTcw0unBgUZHIHPuMLPiE6StUKbzMEw4MTUx+WQjmUNMN3dCyvolE
 n1FfD2PqIxejgdHS5UG6k7nw0gmIjrEFT8uR+kAdrr3XaUaIybYi78ZhOYKCqEeeCUvsGZrJU/T
 5EpZ7eJrHZGOQZp8wMwFKcSMnL1FeZASUwGoKoik0fMHtCJKBe19ihSpXao9JoCb6bNt4bmCe7S
 0qzNTsXh4wZNaM8PuBVUcoN/IS8j6J7W3Ps7rFeExRthXpAYwOqVyMSUX3Hf+ATSkmGhXS1KTx0
 s7g==
X-Received: by 2002:a05:690e:4090:b0:64c:a401:4759 with SMTP id
 956f58d0204a3-64e62f8fcc0mr33776d50.19.1773330707722; Thu, 12 Mar 2026
 08:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <62d074fa-6d4a-4ec7-8c1a-63e7a05c31e4@gmail.com>
 <abLdfsJK4tLx6_8L@x1.local>
In-Reply-To: <abLdfsJK4tLx6_8L@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 15:51:33 +0000
X-Gm-Features: AaiRm53Q0gIUK1cL13T48JySIUuKkEb939SmdkFsWRY53a-jBwm_r0PxIiNUcXo
Message-ID: <CAFEAcA9FCvJdwvAS1hh0yAHmPmCV7y30x2yGUbSyjN_0uoA+TA@mail.gmail.com>
Subject: Re: [PATCH] migration: check is_active for old-style vmstate
To: Peter Xu <peterx@redhat.com>
Cc: Yanfei Xu <isyanfei.xu@gmail.com>, qemu-devel@nongnu.org, farosas@suse.de, 
 caixiangfeng@bytedance.com, liwenbo.liwenbo@bytedance.com, 
 yanfei.xu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Thu, 12 Mar 2026 at 15:37, Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Mar 12, 2026 at 01:25:04PM +0800, Yanfei Xu wrote:
> > Sorry for the lack of background information.
> >
> > We follow the vfio SaveVMHandlers and add an extra vfio SaveVMHandlers
> > variant with is_active. In our internal codebase, we set it inactive
> > during migration but active in a specific scenario.
> >
> > You are right that upstream tree works well. I sent this patch because I
> > assumed the semantics of is_active is similiar to the "needed" field in
> > vmsd.
> >
> > I'd like to get your opinion on this. Perhaps this case we used won't
> > occur in upstream?
>
> Thanks for explaining.  That makes sense on its own, but I think you're
> also correct since it won't occur in upstream then it means we're adding
> dead code into upstream code that has zero use.

Incidentally we're now down to very few users left of the legacy
SaveVMHandlers mechanism: less than half a dozen, I think.
(I imagine the main pain point for getting rid of the rest is
retaining migration compat.)

-- PMM

