Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915BBC4829E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 18:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZb3d-0002G7-H2; Mon, 12 Feb 2024 13:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZb3b-0002Fv-Rp
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 13:29:31 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZb3Y-0002O8-Vf
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 13:29:31 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so5351086a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 10:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707762567; x=1708367367; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9xLjl+NAhigim4DSxsx1oZoTyBV1WrlW4DUoRdXd5Rc=;
 b=mRFf6mjkzZCGlqcDWYRjFpgxw/LTjvkqh2CjSTcCtxa8nrIuvm0SLZOx96JnxWKeAI
 HBPW8NG1BfKIw1NVpyc99w5a5Rrf0UkJCozr8JcxL8GpCDM0XNpBDYvQFX82etkYlFLx
 QYo8pFTPy76s0f9MuWJ3jG5a70GUQwRN1F9apjpt5sL+ZfvQQbIhQ8DbSnjeT37GqSA2
 p+SBPLtZmDYSuQSeF8q4UHhkXlhnCdbT6SebSqTMUFJ6zODkWIHtwjPvXQ5r+RMCEePt
 E2O+bxn1lVNg51b65RWfRmzVAAVCmvQIHaObjO+CausHMcg/2fdKdIqjDyn85csmNVWj
 uE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707762567; x=1708367367;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9xLjl+NAhigim4DSxsx1oZoTyBV1WrlW4DUoRdXd5Rc=;
 b=B0EucKuY/GXt/w+Wo0bc+TA6e64W8dni0Kp7Qt8lPruNObMG5Yq5NHsfUdPC2DbxFZ
 KC3JI7F+LNoOetdvG+IkVIpfsJINf2r/KUGf1/42mksnbIYfoSDyI0ilJGOd1/0KD3ww
 KY2wRiwdNeKHCybZgQjK8Bk+sgNa+5FSvKGymBUyvIBkKIZCwEQ6nWNyvgf1d6oMqoDL
 6obfJbDiwKtozfaA2v5Tt8IGoK/a8m3FCjTKWatBIM5XfqM+G/2swVadnQcD9Xd5ikKP
 9ECJGcFRlooiw9V+WU1Fb0W0HHJm33WbU/vmfqJQTq5tosFmQzTUoisbxZN062EQyhbK
 N+0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUToGPdNkgttqXhPWx8GW69NkxAQA4V42hucaPL7jBljFX0Kq7zX/ESAW+OioqDaCMEjWuzRzeVVpQR0wKsIdwVAFDEOSQ=
X-Gm-Message-State: AOJu0YwFyaJkoNxoF3yP5wjbU1ewIhX/H09A20DEe7j7h7yDQvMkyC1X
 7QFRSAcN2eT1X9i6FqjUh8tU4SnysjCYwswxBFF3adM+JCml2lPNKonXLnTKh6luE7OnbrjKCyV
 XoDKL1Xfr9/hJiRvFZ+4GV4KsBFpKrAjK8Y+EYQ==
X-Google-Smtp-Source: AGHT+IFWFU6sN1MpMrK0TW7s54Jomcl/2yPYJ3xKY5HwQjAujlVosoVxOxyUjzCSokbVJags+NVHGn9tiZNR6rqNlj4=
X-Received: by 2002:aa7:cd67:0:b0:561:eb77:865a with SMTP id
 ca7-20020aa7cd67000000b00561eb77865amr22144edb.8.1707762567377; Mon, 12 Feb
 2024 10:29:27 -0800 (PST)
MIME-Version: 1.0
References: <87y1c7ogze.fsf@suse.de>
 <CAFEAcA_BPf4LSh-JF1NVVVdaLoKgUcsnGeP7sHt-f73r4zyh7g@mail.gmail.com>
 <ZbjT5OYpzNJjkMw9@x1n> <87wmrqbjnl.fsf@suse.de> <ZbnG3qkMBPdsQxan@x1n>
 <878r45lkeb.fsf@suse.de> <ZbsIYKJ5fYG6zsVi@x1n> <87y1c4ib03.fsf@suse.de>
 <ZbwuSM7LjWCsa_VB@x1n>
 <CAFEAcA-h6BDiY4G1uBymcmmnzagHTvhevb1wXPzwBOwZYM338Q@mail.gmail.com>
 <ZcBOZPhEq0gNHFzY@x1n>
In-Reply-To: <ZcBOZPhEq0gNHFzY@x1n>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Feb 2024 18:29:15 +0000
Message-ID: <CAFEAcA_gsgPGFp1DeyGWPZ=WVBsZVWNix+cJ1T11TZXE8XKd8w@mail.gmail.com>
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 5 Feb 2024 at 02:56, Peter Xu <peterx@redhat.com> wrote:
> Thanks, but then this is pretty sad.  I'm surprised aarch64 doesn't have
> such requirement to allow some VM config to run across all kinds of hosts.

It just hasn't been anything that anybody so far has wanted
enough to put the necessary kernel-side work into. (There are
also some tricky issues surrounding errata workarounds that
the guest needs to do: you need to have some way of telling the
guest "the vCPU looks like it's type X but you need to do
errata workarounds ABC for CPU type Y, not the ones for X".)

> > The difference is just that we provide different cross-version migration
> > compatibility support levels for the two cases. (Strictly speaking, I'm
> > not sure we strongly support migration compat for 'max' on KVM either --
> > for instance you probably need to be doing a migration on the same host
> > CPU type and the same host kernel version. It's just that the definition
> > of "max" on KVM is less QEMU-dependent and more host-kernel-dependent, so
> > in your particular situation running the test cases you're less likely to
> > see any possible breakage.)
>
> Yes we don't have issue for the current CI on KVM compatibilities, but QEMU
> does matter for sure.
>
> Then we can either (1) add code as Fabiano suggested to choose different
> cpu model by adding hack code in qtest, or (2) we simply not support
> aarch64 on cross binary test like most of the rest of the arch, but only
> support x86, until any arch can provide a stable CPU that support all
> config of hosts (we can document it in the CI file).

That seems a bit pessimistic. How about "always only test with TCG" ?
That will defend the migration compat on all the device models etc,
which is the bit we're most likely to break by accident.

thanks
-- PMM

