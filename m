Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8221CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZPoZ-00041b-TK; Tue, 16 Jun 2026 05:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZPoY-00041L-Ry
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:10:34 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZPoX-0004z5-9V
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:10:34 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66058b880e9so4146185d50.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781601031; cv=none;
 d=google.com; s=arc-20240605;
 b=S6PhjqGA/lilJORfvwlqls3EbNTVCY1tYRbPuJatuQY92vk0/jkMqtVlxu+WlJQ1uE
 Sgr0Sypd5FXjj5rbrWslx6nU5qvW80W+nZm6vK4lyJtDqvPfF8qDerrixTwmBTCq7c8o
 cg5MIR1KZYyxKfFAjC7Onsjlp6DVl190qk64J2FftmMjH43sNDXVyR82dUmEyxVFPvfh
 hjV/NrxiT2ApNGVb4dYnfDEnWDjRrXsA8TwtPN0CPh5bvMC8mR4s0gjZTV0s4zIKXMQG
 83OVXN4EFTNcbgGgl401cEDsCoIjZSW3ccnqHTLMEKx0dDD1V0xSiopafaUEWkuL9D7j
 hDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9ErFtHlNefnfvOAXcetVfpHe+L3xBA08nmoOEuggZR0=;
 fh=cBQhc6x7ORNTsFEH4pjE9fJeGmkdQ0QZzNvfyXbNyuM=;
 b=PrCmNKY7kvnPpWsnoBUbP1XScbeconYO8fYaqNiEG/m/G7clm0fyEQk1FIJcqRxFmG
 2OG7tRoPVkCELAn9cAbjjrrPak6TMUPzT1icfnsBZzPvpH45S5LF0mJv0ankzUKjC97P
 7zlq1+FsnjnudrKTGiNHBl7OMeyw/B7QAeK9MeS2spJ29gDhbLTvDq/FB5tq8mCT9L+q
 PLKC1/55T46P5J32JciuS+UArgNT6WnuXpIB4Ysab3yuEi/Sd8D9cwCCs0AJsVgDuqUo
 vDFBF1qrnubcFGZjW+5DAiLv1WNQFEFMUlPj4Wqvl+G7b6/np5Vv6qMPJJISrAoUBMds
 /aEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781601031; x=1782205831; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9ErFtHlNefnfvOAXcetVfpHe+L3xBA08nmoOEuggZR0=;
 b=OnRkGJGFUjpZQryP5pR5ChWYpHl0V+b2PiL/3qCmI3iUcTlZL7V4dHt1cgYKOW8rXH
 +WxWNXsVVfZLAphanCn1TP6hpeYRmzjbhLsI70yaaEYGSWRUqb+5okRlxPqYGYWV5C9M
 KczZ5pjsJnWs+axN256t7YLsnbdHZQ52ZQk9yt8cubv3E0fUtSxN/lMBZPG5XNGDPvYR
 TXyRdHpcc0qo8CfR2okc7L0VEXxEFmYO9XR3iw23hkaBqFNoHrBWqHOpKgPbd954sKFA
 VVCrtuDjoAcuC52stGwevtDmQAOVYhfOBXNCQ1c9vxLDIrZ+gMRrfAibxRQlH/tpMauW
 RKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601031; x=1782205831;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ErFtHlNefnfvOAXcetVfpHe+L3xBA08nmoOEuggZR0=;
 b=EtvLyEGHR1Pg51dbFAZwAhZC/E3y4IdX/061lWyvqTx82LGkJYP61KSlxsgeqn6okk
 ElWBMhoWumf0yoyN4Ezj9D2uk/Fjv/rDqbNmiI+JXgxVd3B1i5S3PCZcDzyUdxvD3bcX
 OTNxb5hxnIFtpfdJ9BqsLngzpLw41/l7dAKlxmVcfhjey0VRZIL436Qd7B1BvaoWZZmj
 XKbDe2GpnimaD/kBe50FQleeh5/T7nqIynBp66uZ2E60er28/Ih+TWM3PQujT+dzyLQD
 uRdulzUALSToxzHvxoHpPtPYJejBj9dPzJcvI8lr1MY6sNZp/5sJX8VYw1RoBzdKjNBC
 8PBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rWmXBPKg/zt0SPGgGcI1rjElsHMMyh82Z1xAptX28HOGinLQmgmcCCR5Hab8I3SjkZsuG+YLr9XhT@nongnu.org
X-Gm-Message-State: AOJu0Yy987/YialYt7gBxDTqu6BoF1cp0fl3u22sntlxp7B7sn8TVVYx
 m0J3H+deQDgKTNtu1/vq/JBKdY0vjDalyFftqosmHW3Ea4m9zu9E0sMORgySBS6HMB4jwdSIzoF
 WvULpsch2M/d/RNjDnAdSmSITAZWflHTe1Rou9rIkvw==
X-Gm-Gg: Acq92OFzVcdjfbrE+bQ7VYmbAQnaJCeDl67yNyyMOLZikpLXpalF5XtKlhPIeNcJpcB
 W2mqHo6FBr41oFQAIywiJ0mc1lNjU7YnNVYfY75UlX0FK4DvAkRrKyHKGmssp5/1KbqZMcBP94R
 Pg16879esyxyScOd6pA7c8lk12OUIsmcYGRdgbwtWqwMpZKQVZABerBxyxaIdLKuKTOX+rv9+mR
 jRmle1ahmqAMXVprb2GbwDUdbdYa4kqrRopriPpA5fg8lu28vgiLxotnM4n/3h7cmYOgeAlKC2x
 vlU/BmW8WS41X1BMrRuAV2K8YlppjQrlU1RZKXkCzfrdtkUlqQR4a9AIrD9CpWAJUIhAV8Rwtil
 Hhw==
X-Received: by 2002:a05:690e:484d:b0:660:5ce2:58e6 with SMTP id
 956f58d0204a3-66284f8d069mr9684295d50.21.1781601031311; Tue, 16 Jun 2026
 02:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260605035012.2876664-1-kylefoxaustin.github@gmail.com>
 <20260615000835.996870-1-kylefoxaustin.github@gmail.com>
In-Reply-To: <20260615000835.996870-1-kylefoxaustin.github@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 10:10:19 +0100
X-Gm-Features: AVVi8Cf8F-RXRP7xg9EdKC9DiH4MXMJcFVeGYWSGfUZjyo6q3DBexVXnKoPxwsM
Message-ID: <CAFEAcA_TpWZ4CsaidQwsP183SZdOLQaNO4oJZ8Ai75X2CH7rgA@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: honour CCR.BFHFNMIGN for probed data
 BusFaults
To: Kyle Fox <kylefoxaustin.github@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 15 Jun 2026 at 01:08, Kyle Fox <kylefoxaustin.github@gmail.com> wrote:
>
> M-profile CCR.BFHFNMIGN lets software executing at a negative execution
> priority (in HardFault/NMI, or with FAULTMASK set) suppress precise data
> BusFaults caused by load/store instructions: the access completes
> returning UNKNOWN data, the fault status is recorded in BFSR/BFAR, but no
> BusFault exception is taken. Software uses this to probe for the presence
> of a device.

Thanks; I've applied this to target-arm.next.

I tweaked the v7m_read_sg_stack_word() slightly so that the return-early
case is the "take fault" one and we fall into the following "return a value"
codepath if we suppressed the fault because of BFHFNMIGN:

        /*
         * The SG instruction's stack-word load is an AccType_NORMAL data
         * access, so CCR.BFHFNMIGN applies: at negative execution priority
         * with BFHFNMIGN set, the BusFault is suppressed -- the access
         * completes returning UNKNOWN data (status recorded above), with no
         * BusFault exception pended.
         */
        if (!((env->v7m.ccr[M_REG_NS] & R_V7M_CCR_BFHFNMIGN_MASK) &&
            armv7m_nvic_neg_prio_requested(env->nvic, env->v7m.secure))) {
            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_BUS, false);
            return false;
        }
        /* BusFault suppressed; data value is UNKNOWN, we choose 0 */
        value = 0;
    }
    [etc]

-- PMM

