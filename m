Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D668C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 10:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuUZt-0001em-Cb; Tue, 18 Mar 2025 06:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuUZr-0001dq-7m
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 06:53:43 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuUZp-0002Ft-L1
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 06:53:42 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so4522267276.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 03:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742295218; x=1742900018; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oUTV5Lfc19z4f99JDLRMO333+wx3g7icFhF1q0/9b+k=;
 b=Ec7WP5KXKZNrXH0KcgNCCPQFTfx7GvxcrFV2lTHIaJLjD/zb3/iMJ5FHjgVRBwbExm
 GeKUdDoq9fZHRWxZk4DDZ1TKF+jHgsh8zsHBbj3sU8brzeI7AuRFkzhAf26GNwdguORb
 sdhMSCj/jgK6eQwS4CIrJKm0iipYa5zQIF6e/XwRkksW+RXk/mNT6nv8kenShBjDezRr
 +w95IhXzf3iAmricnVXXqwMX9GWA8GluXgTlQpOd78moYkB7IcY/kA/6O1MRG0q5a3IL
 rLKnsH7kQfBCnzfEzj81Bn14rpRuhLFuHrQhPX/U2BNV8u9CVuHTHZ5hiojLnreTj7x4
 gkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742295218; x=1742900018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oUTV5Lfc19z4f99JDLRMO333+wx3g7icFhF1q0/9b+k=;
 b=a3ud2/VOtfv7VxskLG2FHQbslEZDkHFiG4At+KAQMf8N2ZnG1xYpH2reiOBG8vb5dE
 Ay9kt+lmMdzDskR3euqE1Ov+Q6MmYchJnkENeHl/9uWGDvch31cfgTrdcEa3hhRNv6mv
 CHGBgDIRhUkyq/Ildtr36bt2/DIKw+mh9Qiz5NlE3RoVhYqq2SYwqUSiF+oovdcb1O3+
 /IlPuQh1tdFqTKP+5B5WnUB5yS6MLcv2+W+4hsY6CE1nMGTZVxTUyKOs4FQv4gLa3W8D
 EcaGIqiqg94S/Q9HDYVKgwayFQTfiYgo9bC1zgZAFeGUqe1ix4KVcdmk4yxgSNzvJJic
 bIzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZAvUbeODKu9hva1Jb50bTSwvnDhDtmdedldRlnF2ami07LkjBtfV6ilTQM2djAy+8UI+OLjP+XCUf@nongnu.org
X-Gm-Message-State: AOJu0YzGDTjZyGfQmtXXgN/+NJTPfXue18AFmaNebUizSwo1/N02W2WD
 z1MhIK6KURuN1lw8WROgrj5ATsDnTTdFkWy1e2bQuH8wpc2CmEpKo+bUcOQVJzF8dgC1rz0CO08
 tALG1jts+zoK/JhOwztMAnh8uZ5/yGKyZlqKdSQ==
X-Gm-Gg: ASbGncsfcfuEktJebIf8UMasPAix4ZbYqMqNcJFODlHDik19WcQeuWMviyNBBCdpwDu
 fywksaxi4aj7AoYLVXIVHXlEfGroWCZQSSZTYyAuOdYNO8G7p1wZC6FD9662nPKz0za24tSFYTY
 1goN+oHJmn4GPaQ1xWJ3MgOvHmHkW7DTts4GPnfQ==
X-Google-Smtp-Source: AGHT+IFJv05jLVcOg8vRdx0tXirUl5K1PQ2ybgcQeC5/ByoEj/TeHEL6lFI8jFczQE33LgtkoJpvtSiGxXKi6c1YELo=
X-Received: by 2002:a05:6902:2481:b0:e60:9cf8:7f36 with SMTP id
 3f1490d57ef6-e64af0e93d8mr4157769276.2.1742295218675; Tue, 18 Mar 2025
 03:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
In-Reply-To: <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 10:53:27 +0000
X-Gm-Features: AQ5f1JrrQ6nhqGE20OUiFTNnvQGpLUFP1HDUN41gJWY3234X9LY_K-0xj_dC10s
Message-ID: <CAFEAcA_-fODgkxLLCNf3XHBU=EvGgKx4qcE_PqNt8-4jwqnqVw@mail.gmail.com>
Subject: Re: Generic way to detect qemu linux-user emulation
To: Helge Deller <deller@gmx.de>
Cc: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Tue, 18 Mar 2025 at 10:36, Helge Deller <deller@gmx.de> wrote:
>
> On 3/18/25 11:18, Andreas Schwab wrote:
> > Is there a generic way for a program to detect that is it being run
> > inside the linux-user emulation?
>
> Yes, having a reliable way to detect it would be good.
>
> My current (unreliable) way to detect it is using uname.

Yes, I don't believe there's currently an "intended"
mechanism for detecting QEMU, only ways of noticing
long-standing deviations from how the real kernel behaves.

> > The purpose for that would be to work around limitations of the
> > emulation, like CLONE_VFORK being unsupported.
>
> yes, and robust futexes aren't supported either.

You don't need to detect QEMU for that one, though -- you can
just try the get_robust_list syscall and if it fails ENOSYS
then fall back to a codepath that doesn't use them (same as
you would on an ancient kernel that didn't implement the
syscall). Robust futexes are in the "technically extremely
hard to impossible to support" bucket, per the comment in
syscall.c.

> In qemu-user emulation we could change the return values of
> "uname --processor" and/or "uname --hardware-platform".
> Currently both always return "unknown", but in qemu we could
> return the arch of the host.

As a mechanism that feels a bit risky to me -- at some
point somebody may come along and say "my guest program
requires that these return the expected values for
the target CPU", and then you have a conflict between
whether you want them to behave correctly for the
target or to give you the "tell me it's QEMU" behaviour...

-- PMM

