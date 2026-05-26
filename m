Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33FCCD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn53-00058f-33; Tue, 26 May 2026 04:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRn4u-00053p-L0
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:24:01 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRn4s-0001LW-2h
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:23:56 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-65eb226b1ceso4419650d50.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 01:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779783827; cv=none;
 d=google.com; s=arc-20240605;
 b=bfsHCFZN5zrDtG47J8qsATNskkoYxNehuWc5CJIk0/FpRK6cqyaViVfcuCed9M8iqp
 z7j53JKpVSMs0V3hebhj23Qp2UI94wGR6xosdxUaveVLjN02UKHPUSWzq1Ge/7e7bezB
 IMjX0yphV6Fz/CHNbhIDTSuBdZJqx3YPzo6u1fL4hP3VWdxuSIO4gO29LWLSozLC6WI+
 VRzQS2el9uC7i+3UMO2XkNgVx2IbwwR6NsowescARWpCI9EWysrDgetyR3athDfwCgOw
 7+q3umb+RliHCefQ1p5JMdfM2yHY48eXjkmU8LyLxCfjCcUzhnolpGTecJCMl+gG628u
 Mrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E72UwPxP8oerXbBoGcvWBZGo+CtYdrJ7yeTUR6858HU=;
 fh=dsrWGuYq2Hq5S/UnYnYvifMs6U4PJVV/wcPl8jVq5+4=;
 b=E3WA6waGtzFC30dbeGUHwaSbGULPt0LOv8XAaHvoLVKt7O4bW2RGHLJtdLAc1R2Cs9
 Jx8qcsufV+xBVTPDXJ9Lc/CvGz3UZAXnCzdfrePqmrVR0Chy80GEI9phKLRJvDjIB3LU
 XTkMrsLxE2Ml+S5Xt1fJGaRiMzvoQPMQiXHoXnVJ9/V0agADLSVii2XebcCHLSje1yEm
 y0vbBQz+lETW8t3/gaDu4gW7uWa6/ie8sP1Ep/f/JhQFrlnY9hc7rdlwAk/baAv1YCv6
 VNqYSGjORPkM+o6CL5BNOgATa/ylDxdR0p2SFrJIgbV/QgiTshE8+sXorQHyFlnR38BM
 KmvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779783827; x=1780388627; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E72UwPxP8oerXbBoGcvWBZGo+CtYdrJ7yeTUR6858HU=;
 b=HafuiaLNKEcZ1Vniw09cY3J4X8SJEBbc1IUmJx7JS6SlKzz2aHWuteP0wkTi8qb6aw
 I3K87YQ5aASBB/EvB/Im88uADAFoE1eS9SJLR0eY3aP48ZDJMoRwfa/zENgrXt+APMdd
 NcJDPY0Nc+gZYE0XG9hhXTEat4TYe7PtEPKFsZb3rvUkhVyE59GfMBlrMygZnph7a9vD
 2Edds8mpaTgZPb4AgHzZqD4vWcWmw2BpFOfdzV5qwLyD8d0ZQT2M7MeU9P5CAdOD26q6
 hmeHsD6k2kBN08eJhoHluaCFkLAzsnRyRbeVZ3kdlNYwIPpf1q+jOMEseDFVQCpS8nDl
 BMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779783827; x=1780388627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E72UwPxP8oerXbBoGcvWBZGo+CtYdrJ7yeTUR6858HU=;
 b=qrmck8SU2kNAEhIyGlacvsHlmqxcX8mZnezasvVIG/X/SIXXatkgh5ryrnRhIOXtgQ
 8WrTef6b0Y/m/n8Nt8f0yBNqdkkMiDdWmSC1xmzkKubwZrOP2njzkwZZM+cyKlDmuZZE
 KOuRqfl+JoEH3Nj6HPrUUIq/ahkIxujmS6d/irfuWwDFCmyqPnmlOdS17JDJbZgRkuSY
 4PNLmwXr8mMLuq+UTx8ef+epdOx0C1GgB57QzZjXC9e0cPxDwz8LGlfaJaSiPYG5SbYc
 gQoj/mrz0mFeLHNCK/5rCzcLqjJ5Ri/ndkctuJCPLoC44WwbbJ55RMKhpM2BDo49Z87k
 yIwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/h2sd1gffQlC4wKw7rti6qLOvAPDrtJp+lbVcxvJQ/kdctabxmZZGcYTBCfZnnDuxtjAiNWX5QhX5k@nongnu.org
X-Gm-Message-State: AOJu0YzVeeJv9PL8ScwFG6nZ4UxOh+XfdbQtrdK6zCQQYa1wZ5KlonG9
 6M+QWQA6WxDbEZOGL9Am4/GQSSw+MriBO80A77KyW5p1Ah+p7f4s6aU54xOFKPsry/9Fun218VR
 30wOTlI7go1j/1HTotIST8EdNjxiLnUHtCY1KurNTZA==
X-Gm-Gg: Acq92OFTpBA3gekyWCX+vT8jDRrtukjI+Xi71P2Eg8HJRd7/zWWbrsSsURJWCsTOTyz
 643h6r+dVgtAYLJSAUuoYn1986V7N3X8SGrJTLcCLONfu74V9nuRWM/pDyBlZSD06TwBGBm2N/7
 gqtAoqdA5cftWSQ0hONVCsOIk5phDeoNWFaygAP/nyyQ7gOlr0r53XLsgQDV8+HXfZDC+mvBQim
 vZ3wSORnT0UA0WDJQl+5BXNNGeLCgL7Uc5kcUagCQB6jzHJzD3c0d15XjZ1+D4NNj30RuYuj/ND
 ja79ravZupp6OdcpIC6Hu3TH7DFfTPNVdnFNWw+f4BsB57MfKGQXRr4mzspFNqvJDiwk3gqpCq0
 aZg==
X-Received: by 2002:a05:690e:4186:b0:651:c20e:a43 with SMTP id
 956f58d0204a3-65ec95f1d06mr14827374d50.6.1779783827328; Tue, 26 May 2026
 01:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
In-Reply-To: <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 09:23:35 +0100
X-Gm-Features: AVHnY4I9Zg6zx1JS9tO2mhCsYecXfz4T3WT7Ij5grVcV40azvbULvI8uz8_r8AI
Message-ID: <CAFEAcA9wMRFJWrjGHcd2nfhgXovyuS=dDJvCXWZkgmD_eez27A@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Mon, 25 May 2026 at 17:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 5/24/26 14:42, Michael S. Tsirkin wrote:
> > I propose adopting linux's rules instead:
> > https://docs.kernel.org/process/coding-assistants.html
>
> Replacing QEMU's policy with Linux's would be orthogonal to the topic of
> the DCO.  Maintainers would still have the option of rejecting
> AI-assisted patches if they don't believe they can apply their own sign-off.
>
> Other projects have taken similar "no AI" policies for different
> reasons.  Zig has one because they believe AI code would make it harder
> to retain contributors[3][4]; Rust is working on one that is fairly
> restrictive[5] (discussion at [6]) and requires previous communications
> with reviewers about *any* generated PRs[7].  Personally I think QEMU's
> policy is fine but we should start introducing exceptions, possibly
> including large contributions with pre-authorization (but not
> pre-approval) from the maintainer.

If we revisit our AI policy (which we should, I think, in the sense
that it's been a while and the situation has changed), I want to
note that although our current policy essentially says "no, because
we don't want the legal risks", that doesn't imply that "if we
judge now that the legal risks are acceptable, that was the only
blocker and so we are now open to AI contributions of all sorts".
While we were essentially in the "blanket ban" state anyway, there was
no particular need to have the discussion about other reasons we might
also want to be restrictive or cautious about AI contributions, but
those other reasons and viewpoints don't go away automatically with
the legal one.

I have quite a lot of sympathy with the rationale behind the
Zig policy, for instance:
 https://kristoff.it/blog/contributor-poker-and-ai/
I spend quite a lot of time reviewing patches for things which
are features I don't necessarily personally care about. I'm
happy with doing that for other people who are hopefully
learning and gaining something from the process; I'm much
less interested in reviewing a mountain of LLM-generated patches.

thanks
-- PMM

