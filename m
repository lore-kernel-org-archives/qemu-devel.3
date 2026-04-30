Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1632CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 19:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIWcn-0001zC-NI; Thu, 30 Apr 2026 15:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIWcY-0001q0-PE
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 15:00:25 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIWcW-0006CA-7M
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 15:00:22 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-651cfaa21e6so1193204d50.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 12:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777575619; cv=none;
 d=google.com; s=arc-20240605;
 b=UAFhbqA7CDUHrap0BYHIX9A9I2yE9SxzQk06RjdrLN5JbXPtkmUYI/PtkzMzwERpGm
 2qQ2wom2uSCgWQXW7oqVg8tBI8ZT97PnvCm/8PCZwZlpGrl84w7uq8G8oJeFtsBk/eKO
 bed1U/YC7otvkOnFfln3oMJ1Fm7eOcwVmhXYFaOs+4TybMPo9ibZQhlQKiLvC8eg0WsW
 mIZOKdClgTiivb6XLl27KcgYUtYFy74dG4DkCuqWTAXjG6ZbfEUn4GBEV4z62cYgqicI
 mdczNCDhNx0GEEexSEOlRhtWci2QdxgbsUjokBG/Kgy2olGm20lNGAv7o0yrhj4Bc9GK
 qKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=33PsOdfRzSkdPROcUPsbwRof+hEAHu2aY8Z1kMr6zvs=;
 fh=qsSgpkl+6XmdYWhRLMAbTUE72QWsJeCxh+IYdLSlTrk=;
 b=JLHA8zeuFdsF8BnKWOr9Nhc8YqOyFC14hUP6S+XViPyv2o7F5OByn+AAT/RYTKhvTx
 3lV6nZ+aS5Fvl3r8mugXVCbyd6309bj0Bf8mOYugTPMeyPMIyoT0a0RDDalDwN5OkqMj
 +OqJqIzWa7p9RhUPuhsYokrGb5HULOHF7u1A3sukpHIXNhCzbzlJ/vkwo9Piyb0I9d7K
 5cN7qh3u6ar5eKTiV4tzMRgHjQzJFQQ5bIzXGfUve+FI9eQkf+Ubx5ZCld5DDrty0hPk
 6IIQQKhsrOMOqazVdzu/87ZtZk42eeYMYC2QIx6rzRYrSskvaKGQYlRpDtbk4JFNKKr+
 EQBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777575619; x=1778180419; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=33PsOdfRzSkdPROcUPsbwRof+hEAHu2aY8Z1kMr6zvs=;
 b=wfZ5RmLyy1aeg9tydWBBrvlTovPmV85YU6oPfZSp6RgcK2vUr71thVxrq4YpgoTY5V
 herAt3fXnn+oSh8NyDsUdytOWzBEhrrgUAF7yElMwx6Y7DF0jRmk6zlkZqlGfwaCb/Tb
 MaB3XAJ3GICHzN5z0Hwt3buWg/8XNriGn2yIZTgJvZQsqwfAsq0sxp957QR8/5EQeboh
 SyNheuB1C9x2CHESs01B1e5kc1DKq+eCwicAW3LNvy+w5Ea/ldq/PYQqRkle0/HtDV/3
 jRDsDG8jh0H9EUta7S/OEbpEXL2e5XQTnx00T5ZGbbNClIhYPG5qiCauBJb0NYkYb/uK
 hCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777575619; x=1778180419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33PsOdfRzSkdPROcUPsbwRof+hEAHu2aY8Z1kMr6zvs=;
 b=bKB3zoNLZJtJhqG3nLd5qAav6TWH44+KRbx3tRpHHNfu1YUyVb2Azu/6mcN9XzMsL4
 VibDbRb58UyN9tmQNZ6oz1Dnf77tivq5V5gd6OR/Zs+h+t/Uj23Oa0PNLKXB8TyO9QBN
 M62LCA4CQ4l3pq5J/sAav34ZZpvybBsBvtMQ1YtfkRVa5pIgd5hSpbtNNaHD7tDaWJXz
 mITELk6lrIYVjQ7tkiLJPMZbwvW87tw+P6YzwNyK+8496n+zgwOdkfmJDA2LwHHK6g2J
 MzLAWCWQtqBKYRrsSwxG6xCiCaQdo/mDg14Jbwn4pFM7t3f9vLQoTUX5T/3eOSTAvRTa
 dIvg==
X-Gm-Message-State: AOJu0Yzf0Ky5IBeIGkBKtQhwz5tyHqZ/9M2nqsRoAGDLnyM9BdZr42P/
 1C9anEG+n8jzybjG8zygEQrmFQFyiqphs3EPrrTXrei3o/onjPbv9U6OCBPIvW9vhcK6+z2QjTa
 ek2qlJNBt28svMf1WdaOqXzM1pZg0E+8cvIK/2sTHsQ==
X-Gm-Gg: AeBDieviZF/OWghmuENEIOWbDcnn8IzuvOJDls3hf6f1CnnnUIK2IecJ0M6+nSNMePW
 o1pOH+vwKxqZuZTrsW5ZZYxnV0ScKZTp+8wkAqE2iMpWqnHbjumeNO/Uku6T5TXV9kjizfbJ0S/
 wc2s6X1ETL1JlkK1ddk6XAGIOqhwzb/W0bceYvS75LFkhJY9/ojXsEALkX5LKGaDLqVo+6/cIrP
 gtQ5/JOw2AFqV5OZu/s7mqZRqbFlyJMtE8RfUQORgB/SGDRAaZAqMs4Kocfrb6HZ4ssgIG9+O+X
 6fwEPLzJcvOyMKRjMZ6yvS6fs0uKWJDBjf6jW+qJ9IQK4npZYO5yS876vh2E6S+eAqtGjqkmAxe
 QoA==
X-Received: by 2002:a05:690e:1207:b0:65c:2dde:1f20 with SMTP id
 956f58d0204a3-65c2dde2dcemr379405d50.22.1777575618555; Thu, 30 Apr 2026
 12:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-features-v1-1-1841b39da7e6@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA9_Sc=+Cn7JiPOo9GjOZFU4KCc7nFVqU=9=QAsNBG6AsQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9_Sc=+Cn7JiPOo9GjOZFU4KCc7nFVqU=9=QAsNBG6AsQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 20:00:05 +0100
X-Gm-Features: AVHnY4IS446GOgig4mj2hWyzIYZXt735BiHhTy8NoMwOpE3wZw3c3RnA8q9fDSc
Message-ID: <CAFEAcA8kk=mUYaqzbqT_C55398SknRUdCmkWKk1ruLMnr=0vOw@mail.gmail.com>
Subject: Re: [PATCH] target/arm/kvm: Cache host CPU probe failure
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Thu, 30 Apr 2026 at 14:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 28 Apr 2026 at 09:07, Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >
> > kvm_arm_set_cpu_features_from_host() does not properly handle host CPU
> > probe failure with caching. The current algorithm can be summarized as
> > follows:
> >
> >     If dtb_compatible is not cached:
> >         If kvm_arm_create_scratch_host_vcpu() fails:
> >             Report failure
> >
> >         Cache dtb_compatible
> >
> >         If getting register values fails:
> >             Report failure
> >
> >     Report success
> >
> > This algorithm has the following problems:
> >
> > - If kvm_arm_create_scratch_host_vcpu() fails, probing may be repeated.
> > - If getting register values fails, later invocations incorrectly report
> >   success.
> >
> > Make two changes to fix them:
> >
> > - Cache dtb_compatible whenever a probe is attempted.
> > - Record probe failure by assigning QEMU_KVM_ARM_TARGET_NONE to
> >   arm_host_cpu_features.target.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > ---
> > Supersedes: <20260422-arm-v1-1-106a9a9e22dd@rsg.ci.i.u-tokyo.ac.jp>
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

