Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B320FED3DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGITs-0007wU-Cc; Fri, 24 Apr 2026 11:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGITr-0007vv-C8
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:30:11 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGITp-0002uA-L3
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:30:11 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-65427236e94so5212185d50.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 08:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777044608; cv=none;
 d=google.com; s=arc-20240605;
 b=SbnONZ07fELCMZlU79Uc1z038TIUt7j85hnlFqnARBBWsN/99rAkyS/CdYuN8p7C6+
 9+VI1d96BY+wWqKg98S2X1OSA0nAJ7pswuRGCwhw87wiMqoM8iT1bg4+e3MJ4A3ulB2K
 2Eh5jWbq1u2K8abKIaoLGJOsPxCyuaVEje/MxmzBp/X1Y80bkkfG5wC+KkLVpVby94Tj
 cer8Kw1ObETvpFj4Pe+cXKvYnTVBiffW+TVoVWCxyVtUX1Klcz4wy9Fmz4Rh/VdeQ0KD
 WWzO+qUmL/uBhN1sH8/lXUJmky20sed8XAqSBly3OwmzGYPlPxAcfSyRDFBVbL0ZUlTO
 gqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TS12wVZYzp7HrcUTyTyrGrgHOVIk08nI6RI5LTdmOWg=;
 fh=kikRRec1FxgkP4Au11be9+/KjLkVKk5Zwa4aYXcHQUI=;
 b=EgqxWbmk5WGPyfHj1/CNYkj7w290ABzSXkRncGkvIVPge1Q9WLjYa4PNoHQ6Gmbm9K
 hmFeCyXNMizQiecK+/ZWj4hN/dEAMriGgkDDB74dHxxdWKKfFOEWATM2QKHkNIC8pwQw
 0Moh8Nq8trVi4oi6ejRxW1MzzAFlHclCqBdGpRhs7h967ZS873wbyKWVH60qmtqolzvi
 O2GW8w2u+CB5QVu75IcqajjFjmbCSO0ywT+34aFJ8LyRiBgDFE2piyuFIQVrfU7eR+yT
 P+9yprujhcdj5vVsWmTUZXPF4NTusegnvdbFY3xIrKBjGOEO/XwFHIEHXh8Xt1CjXTrp
 zQpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777044608; x=1777649408; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TS12wVZYzp7HrcUTyTyrGrgHOVIk08nI6RI5LTdmOWg=;
 b=maVhBhZNnhDQYSY2Umszqh6ohbhTk+qNHAxdC1IVUVaAEMy2GoC3bfVYTwajL45nBn
 Qh9cMI7i1E6U36W8PQ48aNWUyhSdz96vncakoZiSyq2lw7USMCzWbb6V6uXm5uAq+aOs
 y4ndJOUUrXOWeLiBvd5FTURhCDq4Vdr9xlUJ6c9P6x8s84QAHjnMpPllfQcrYcGaKl/4
 y0Zp5rGAZGmkNmSXC79SEEXOVv2mCHS5Nz8x/Se8ePtIFpmyAMTTF6ecI45SaBK1gfR1
 n9w8KPglopHeBzSfaamsEi8d8WqYnOf5CxhKNFQSLQHCis9QjFAnXvDMhrXlLNxYJQWj
 p2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777044608; x=1777649408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TS12wVZYzp7HrcUTyTyrGrgHOVIk08nI6RI5LTdmOWg=;
 b=oNFNKJPleTHgXD6GuUM43aTjmf0KuUaOyRy1ANCUTz7pA+fBO0xPWsGud61xKXIWbC
 GdvB4avthqH9CBO9YuvFfE+F8hhhsCfJhojJVAJFLTjB7eS6VUsv2XBiFPHDufbHaUdP
 10NW4bHU8248E0K/HTy2MjgfcKsgk8r25GZ3sFcNV61Iw11mIy9MOZxW7omYt7eUeInY
 ulAz4OYozAqXeWBZXm3/uidWCyui7cxGgoU68SQlOIOw5+/xdk6ZjTLglwUHnnEuq/pv
 9iwKe2o++o9/VlRBOoavNUhDr/ns1WhN36JR7Yf83E/avfOAFk4EI/Wk8RWCppyRrpFe
 HwhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zqPblygQU1a2RerbLQcW1KXwAzzCskoSsaDFIb0ONRXgWov310EbM3n98OickFTkyynKwVJR28U/g@nongnu.org
X-Gm-Message-State: AOJu0Yx01Ui6FtCjbTGga1WttWg3a9ZESXFHTsw8Qrl5eJJDwErIkJPY
 nFgHa+I19mbiYDtlu5GzQL/6Tqv6XSrOz1+UY6XPXMwj1jBaehA8+nobl1Fu0F40+hkOo0sPZKv
 bh2Ef9QpEyJCdsGQbQx/hPRIOLubAUGyDrVFSl4nv2g==
X-Gm-Gg: AeBDieuY2FuZbUej8EEXBDV1I+wt5TrpdPL73WHNGkABBXZJnud4PzMk+Hcd7+Kp4UM
 Z0NQkVpOewyUq59mWt631RMzPApMlz8ppl7u/goyoAQk627MY7DFOss91z0XKvUkMMM8UnSETEf
 PXBm070tn64/9fOe8NoNpShyF3q7y7zkUQsBwt1jP4Hwwsemx/dopCCyWi10670D4gxrW0jJ8EM
 afOJbhqchEqOoiQQHPLGrg6n+0n9G9WalnPfr9DQCSomAoKG9JQT+DMCH5suqZITDqO5rlgoM0d
 UtUkB/X1Xd2lYANYwjDNy0ftxXW9rhIbbZX5PDnvVtUD1xHwifn2xCD/eUo/ik6NaFbZVcKrwwh
 GRw==
X-Received: by 2002:a05:690e:c4b:b0:654:45be:85ad with SMTP id
 956f58d0204a3-65445be9706mr14160045d50.52.1777044607948; Fri, 24 Apr 2026
 08:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260424132824.27733-1-deller@kernel.org>
 <CAFEAcA-CwZZrSVHE5qPSGw0gCM_0Nh6e5X5-W_EDSSkv62LAyQ@mail.gmail.com>
 <2e676b2c-073d-405f-9354-5b1a456fba83@gmx.de>
In-Reply-To: <2e676b2c-073d-405f-9354-5b1a456fba83@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Apr 2026 16:29:54 +0100
X-Gm-Features: AQROBzC4SBAuqg4Ge2S1BiEIY1Nsqjh1b8xM5LhnXs5BnqbmhA0sk_Qeb_wHHlc
Message-ID: <CAFEAcA_BzBp0x9a6JAJuEjv7h1nwRMS9W-m80aqDWNQtaJ42yQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Fix CLONE_PARENT_SETTID when using fork-like
 clone
To: Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
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

On Fri, 24 Apr 2026 at 15:36, Helge Deller <deller@gmx.de> wrote:
>
> Hi Peter,
>
> On 4/24/26 15:39, Peter Maydell wrote:
> >> @@ -7059,6 +7057,8 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
> >>                   ts->child_tidptr = child_tidptr;
> >>           } else {
> >>               cpu_clone_regs_parent(env, flags);
> >> +            if (flags & CLONE_PARENT_SETTID)
> >> +                put_user_u32(ret, parent_tidptr);
> >>               if (flags & CLONE_PIDFD) {
> >>                   int pid_fd = 0;
> >
> > The clone(2) manpage says that CLONE_PARENT_SETTID stores the
> > *child* thread ID -- shouldn't we be storing child_tidptr here ?
> Sorry, but I don't get your point.
> Even before we stored the TID of the child (sys_gettid())
> at the location "parent_tidptr". Now we still store the TID of the child (which
> is the one returned from the fork()) at "paret_tidptr".
> Why are you mentioning child_tidptr?

I got confused about whether parent_tidptr was the value
or the address in this put_user function, sorry. (I think
maybe my intuition is that it ought to be a (dest, src) order
like memcpy, but it isn't.)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

