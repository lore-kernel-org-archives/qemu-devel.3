Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDFDEA4E07
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx3rh-0004Ht-O6; Mon, 02 Mar 2026 09:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vx3pz-0003TS-Ak
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:01:35 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vx3pw-0003cG-Be
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:01:30 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso4216401d50.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 06:01:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772460086; cv=none;
 d=google.com; s=arc-20240605;
 b=VbfssYNhbTaWQEMdqyqrYsg6LKRl1lkyiNN8QdUQoGvP5OnhnOfcDvr1yQhGY2SsHD
 LKBG3IXTr0HpD+MnEM8l4wj41eArI5O9xA8C6Q58TaYA5dF1atU3/jltCWIJ0o6KRhQ3
 4W7P2qB7zay5i0LniMqY7kR8mzfz0/DM399ZF69JYlaQdF83Kw5QZ9cJWIDBa91oc/2N
 WCvtXQjPuDuBKZ60gXlRDBtNIi1VC9/R4jcyNzU7VkgCqq+UywFTifNeojL1oQuckf8c
 xGDjry+ywjGma8D3NzvrsDn1VAD3hstB7B3yp2GAK9fLs0+j22fr/JyVQWmNYditY/Xw
 hglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lcIH87/HWqeE796Npg+61LXj4TfPjZfGb7zVgG4kM58=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=DNb+uT+9a7c1PVDPd/JYBRshBDqWP1qhraET9GjdclgmWpT7BH/Ef10KnwASjxr7mZ
 XLgP91qwdqz3uYbsAJ15+DKxuSeTVWpezTyvqU8FWMMjnje6+LNUdQzNlfkgShOnK0hM
 8klPBmt3rDTDKhsrE+TxaH083/qUBdZ5bOqpoA5QGE7bVXdrPxm0wfQYsK6TefTez5FA
 lx1uGxHuzDsBx1mpEO6tksXjESndT9J6lEfB5Vdl99Sh0hgvd6DgOHSB2K2Q9kIYhti0
 bpH2Ck9/XDDbUv/3M49MekLZePuVurTmvAQ+IEqsDpjB4QMmh231Yssg26maOWuX3lwt
 KrPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772460086; x=1773064886; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lcIH87/HWqeE796Npg+61LXj4TfPjZfGb7zVgG4kM58=;
 b=rsNZbowm6eQ8fd0fp7PyJWouvCttnIxQ/S7fpR0jE8sapxVlXS0izE6b4NdUGn/XLU
 vwDwEAFmfY8JzPw+LtrTU4kwjFO970CxpFESSWJnQrvdFGm9NYRe1quzugClrVCs9xyv
 ieFvoLpzPaHXpG28k4pOK8MFX/dGGQrfIPRx6QqXEXSnnq3kCQ4xWDF8hZGDy2OsKy93
 poGeFpSW4rjyepxM+LAyVPtfK7Rer4k+W6aIIbm4k1hg0pc/CzN9vTRucLvLGTF6CqS4
 bGYy7f60hrZQOmnpeD49by3ds8RhXpeV4pk/Ser4cN3T1s/EsrkGzY9iZrwnyPOXoDyr
 RG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772460086; x=1773064886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcIH87/HWqeE796Npg+61LXj4TfPjZfGb7zVgG4kM58=;
 b=ozx6Bx5A28AsNNMCG4Nr/5uuI3dFBYM+rOoBHUtMNNKfqfncyTSlMMeKBvaVPjiYEu
 yydRngQbdh5hJ0jiv2tZBbnVO4Gh8G9zqvXcBp6XdQONLhAInYaJl0bLxaK3nB5J3DXL
 Iy/tDVaMQfi4ipfYXtJlKMdxloZzITpEVH3tGTNeBEUo3sCUW63Y0X0XRHoEjnOf6C8J
 +WJzo+opHL/Y57Nh1RDAouMfZNB2SFiVbsS5D5L9qDSPvB7h1kNEWGQbZ3fAOA8njDUl
 IAM9gAXuUKRogN7b5w10FcidIs+JE2Lu+a/d3hdgHcJr8iXPMu7PyucEjlHkk0b1JqKR
 fPpw==
X-Gm-Message-State: AOJu0Yw2YCiZo5ktDYk/VfjkyMOiG7gtWTatpZ+xtTmXYPKpsLoApc1V
 8GL+2ZA4TcJEebIbtQMWKliciGMlJMVevdRFtKfDax+OesHO4ksdlmFd9t/54QTcwjQyL5YyXcy
 yRyUTx3n30oHjjfH8ZGi1jHw0MvtWXnnMVbx0VA7TI4h12DZGjDCV
X-Gm-Gg: ATEYQzxEtA4PggV/7UuJ5iwXMMxuVCD8bKgMzTaCejBOYk5uDW3fVbWRG2iCSw0t0w/
 iQhWEEiPpBbSsWXCaTmyQ3Rg9+l6jcz5QJ0E6kxdlXAVLGT93svwCO8xVghBoZbpIefOIb8mi3L
 Twxi4vg4eyAzMTMGSSbJYBe2duFIyYGehqUFmDQz1mrHdRJcw0KlX4RKc5YLNJuuPCefBbMrbIt
 U1ExGIrEgE9MAAe5Vw4eKPT5jTGWhgP853eDsBE69if0iD4sBWLgCXmkuiRxVe5jVfLKTrhM2cH
 +nHGflrF0oBcZWJktIX8m8Ehx05+AdbjdTU9QzDW0i3qpmcQih0dXWX70EgnTbbW/UhL359erFd
 dHA==
X-Received: by 2002:a53:db02:0:b0:64c:a9a7:4655 with SMTP id
 956f58d0204a3-64cc202dc35mr7891650d50.15.1772460085917; Mon, 02 Mar 2026
 06:01:25 -0800 (PST)
MIME-Version: 1.0
References: <20260302084338.473368-1-pbonzini@redhat.com>
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2026 14:01:14 +0000
X-Gm-Features: AaiRm52KFOOdr0NlxE8LtEdQHz3z7baxrIisBelZvRvx0xVY9cyQJ9jmu-qAAG0
Message-ID: <CAFEAcA-yGsL-i7jpnRtQKQMUqD_tnet_7epRtSGKXTJt=xufDg@mail.gmail.com>
Subject: Re: [PULL 000/102] Mostly i386 patches for QEMU 11.0 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 2 Mar 2026 at 08:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit d8a9d97317d03190b34498741f98f22e2a9afe3e:
>
>   Merge tag 'pull-target-arm-20260226' of https://gitlab.com/pm215/qemu into staging (2026-02-26 16:00:07 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 5a0f9481b0cf344c4437515b596e4ecf57ccc30f:
>
>   target/i386: emulate: fix scas (2026-03-01 16:02:54 +0100)
>
> ----------------------------------------------------------------
> * target/alpha: Fix for record/replay issue
> * accel/nitro: New Nitro Enclaves accelerator
> * generic + kvm: add support for rebuilding VMs on reset
> * audio requirements cleanup
> * vmmouse: Fix hypercall clobbers
> * rust: use checked_div to make clippy happy
> * kvm: Don't clear pending #SMI in kvm_get_vcpu_events
> * target/i386/emulate: rework MMU code, many fixes
> * target/i386/whpx: replace winhvemulation with target/i386/emulate
> * target/i386/whpx: x2apic support
> * target/i386/whpx: vapic support
> * kvm: support for the "ignore guest PAT" quirk
> * target/i386: add ITS_NO bit for the arch-capabilities MSR
> * target/i386: add MBEC bit for nested VMX
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

