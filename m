Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978DCCD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWvov-0005V7-7a; Tue, 09 Jun 2026 08:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWvot-0005Ul-As
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:44:39 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWvor-0005Eg-Ng
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:44:39 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65eb226b1ceso4829389d50.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 05:44:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781009076; cv=none;
 d=google.com; s=arc-20240605;
 b=HgfRhpKz0k2DL2WPZvxeKZL9x+WJ7Cy3iD6uhmUfn+tEsG0yfBwkDIDdJ1FKuEc99d
 13F7ZBpFbx1KVeYz4m1LRhNCwlqvV54Xjhc1svNP10fDPi+Pd4nM148Q9xBQ+sr84zsA
 EDQoiLy1naQ5rZrWwxhAs887bpNuh6ZRlN9pIZIMYj4RUOzB6XMYWkGwU43gXU4sckJc
 s+8+CDWUEmrmZxdBwSbA6skj3vRAwrMSOxR78huJMDQpT3tQCB6Dm8/oo0PqyLkzV9B5
 G1JW8fTeLTYo1FnO7gtqGZzMOvmGJBLB8ojGoQ4tNw73f1jAMBtm2zTNHQ5X58JJka0G
 pXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aeDrLcifxthJi2ua/z5xsr82IiW7eAqLRgoq0+uAzS0=;
 fh=VdU0ZIHHM7Xuu0AoHAY9TnsLw+Rmx6THNQ8Qxyqt4ys=;
 b=PXl8vIIaiID685bebqZRTQ0H8cRgPDOWIhq2qHOsMb9DBQTr8coDr9Ys5R8dn08TQU
 vpO9athLQ9jxZ4tCV53G+g3QzXQOrYNsyBkR1hfnlHQlyQEYKku0M8UVWqRKwr6qxjpX
 XfrKPYRqwxfkz61VwN7WR3/lalkTV9aP0TuEXvZsWnNDf58bdAX4KeJUb7fu793CYQFq
 qv6Pju0lPxa1u/qSQ18UPA4BX9shjUk5K0el1vFK8JQVjGLXA7I63uqMh1JoNtbnafeB
 BIQWfrVzAXVtXh2Aq+OkdxzEnw6h/TOGZMaRDErCcXyf06gRW8RQxqrj3EuzbtB+/D7C
 iczw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781009076; x=1781613876; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aeDrLcifxthJi2ua/z5xsr82IiW7eAqLRgoq0+uAzS0=;
 b=OrXZiasNAQeTtHZZo/W/LRK5DEkD51uySWkQE2Dk/FGNTTRieaq6bHkKVhWlWrg83l
 rJm10zpfvp9qy63bDt4TQdHm3ywJtl50eGU+8vy4S9SREoh/B1wEs/PXmAXCd0XZ9IIe
 8SqNitiMfUicW3MhQlSNbJE/f7JwoKqkI8ZR1zNpUS/afkXXhTlY0LvpO51mWrEpwIdA
 HIEAZ3gE6gwAgVDuhyJyAPqkcSq1v8JLpk6J5q6Bb5nsb2pozb1Ah1KwjmU6/i0qDWM+
 qTshFLjo8Yn4zGvyhARpBKus9ZHaODQ8SuP0PndYXgbcEmy/npTcJGhQujteIsmbu4je
 Vx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781009076; x=1781613876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aeDrLcifxthJi2ua/z5xsr82IiW7eAqLRgoq0+uAzS0=;
 b=tUy+WtQy4SvMkQgHW1AWzDec5ZrBHaWCmwo2gcUnQBr9DsjXPDzhqxZd+qyucZ2q3I
 xcDZ8gVBYf1IRnepVyz9vtMcwE6278MDZ3ssh38NUSeNRJoP7c/EhArLfrOBrfi4wKPX
 /zZ+RUzMstsagTCNRmLo3V3wXdHCVeDn2svigFfZMcWMaQgsOrEgitd6PwMGy5E6Rm6f
 9CC0mbhq53jihRnMDVQUKI9Cc9F9pq+C3IDwX4px9nM0vVlfGX1b/4/IXPbtsNq8aR2L
 4hMnCjmJrehlBqJOZgLnRcWrss2C/D9YMtysIZ7cN0IcvWINVtnjuMqbG0KntBuQFkxD
 c4dQ==
X-Gm-Message-State: AOJu0YwtOGp9tnCWTTc/aED8rJP6FHm5ZHQ8/QNC6+nLVtS7IRLxmH5V
 G7/uMqI7W1WggSZ+s6d/fYzxC8mHMjmDlnE3u1xx+Z3iAnYnTdIXDWMas0nJSH/zhlAmZ6oy6Ds
 yBZ/J20DCkYfcFA3cmL60z018t/JwXZCu8oVq4G75Bw==
X-Gm-Gg: Acq92OFzRaZJCZGo+fhIoIzZawtxc/hZpXcngzJ7CPsOl944hNUC+8Ci7nVeozR62LK
 oqFKgt8eDnRFA/+kCh1d7UUKIXVJ17X1Kb79gczg0jCtBLFGt2+3QYpd3ruU23OTYzfRKvuVWYf
 iF1pFwyq8yyxl4w1VMjEzcEGng7INVBst9H3HJHaEJGQC1R8Gx5TwaByXRVPWBC53xZmyNJ0bqA
 JkTG7/jf2jc4/KlHDmP9dlw96LP883A/20v+GOlPBjMSKckZS5DhHY20nrpBcABTJw2kGg+0+Sn
 w+k636yWJVuC9CjJwsiCqCiQd+LkveHy40mNTmbZ/6qEo4VBwslQDlJxTzIWrSxziJi6gti5n6t
 PK+bhWLIVNED0
X-Received: by 2002:a53:dc8f:0:b0:651:bcc4:c1 with SMTP id
 956f58d0204a3-66106f885edmr14532541d50.48.1781009076387; 
 Tue, 09 Jun 2026 05:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260521112806.504961-1-kraxel@redhat.com>
 <CAFEAcA8hbObntY8Tp+kOV7btb-io92O9GW99-6SPxigPJUjPrw@mail.gmail.com>
 <aiE5LrpfnJRbkx-A@sirius.home.kraxel.org>
 <CAFEAcA_ow2ro3h0nfhY3jA_XToAnjdVFNPrF25aWLd=X2cnmaw@mail.gmail.com>
 <aia8iXGozAclWQCb@sirius.home.kraxel.org>
 <CAFEAcA9oB_-ao5C8fGYonE7njUMWLHo5-iETeN_XtnFL4PzyvA@mail.gmail.com>
 <aibALjyPTXVUDpDv@sirius.home.kraxel.org>
 <CAFEAcA-VQWKzJ-aNnzYHZ7a+sVP1y6tkUnE3YCPydsqP0uVXvg@mail.gmail.com>
 <aiflCrf0iDwcpj27@sirius.home.kraxel.org>
 <CAFEAcA_+fZnFG_2xH2gXF7ZtGo-WVwAhwkz9ucuS5kXZOYShnw@mail.gmail.com>
 <aif6QGPxr4oMhb94@sirius.home.kraxel.org>
In-Reply-To: <aif6QGPxr4oMhb94@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 13:44:25 +0100
X-Gm-Features: AVVi8Ce52Ywx0xBDUfEoMqE6ml-_oTYRAK7uK7eN_l0NQD7mF73n9wfLZSkktdc
Message-ID: <CAFEAcA_qjzLjdqi3NWfY3cTDfkE0HmuvxSV3yVuBb+O95zvV9w@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm: add support for shim loading
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 9 Jun 2026 at 13:00, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > > #  - specify a firmware and pass a hint to the kernel to boot
> > > > #  - direct kernel image boot
> > >
> > > That is a technical detail which doesn't make much of a difference
> > > from the end user perspective.  And often people talk about "direct
> > > kernel boot" without drawing a line between these two cases, because the
> > > user-visible behavior is pretty much identical:  You pass a kernel to
> > > qemu via '-kernel', and it gets booted ...
> >
> > As an end user I find them majorly different -- I usually
> > don't want the firmware, because it takes forever to boot
> > if you do that.
>
> Not sure what exactly you are doing, but for me edk2 is done in less
> than a second (unless I turn on firmware debug logging), and that on
> a rpi4 host which isn't exactly fast hardware.  I wouldn't call that
> "forever".

If you're running TCG emulation then booting EDK2 is definitely not
that fast, and I think a lot of use of QEMU for aarch64 targets is TCG,
not KVM.

thanks
-- PMM

