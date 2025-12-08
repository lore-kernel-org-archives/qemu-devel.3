Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36576D3B7DE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 10:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSYDA-0001fv-77; Mon, 08 Dec 2025 05:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vSYD7-0001ex-BP
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 05:11:17 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vSYD5-00036X-NP
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 05:11:16 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-78c2e5745bdso21991837b3.0
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 02:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765188674; x=1765793474; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=10Z1nvhCx8Jttq9gPc+1C4MSnhrBzSeQZNi5Q8b+j6Y=;
 b=Ld0QGIusdoVR05DL7MqCLNuPcAezbXjOoZzCI33xsjDgJWOn71VrRKBRIA8NSegOPO
 9J/XvWB0B3dSsHm71t3om7REaLFAuReLdDGJ06mL3XNxoIxvj+gwGKYaiHyrZoqcTtqT
 980efNViWfNvjxOoR08p+cVogKXcxbXRDOtGyRRk9UZ3oUEBOrR12bU6I8NcKEkabLmY
 AHeJLO1N0qMQFswGWHJHvTAgCqonqvsV5+Hb6JY3vUaIDtPFzlLec4eTW3sB2s5WU8t6
 /oKmZOz3R6Pq1vg3dbNelK7yaqHdpz/yom/YBCjxv3A1J9V7PPY2qp2JQhTmv2HR90mc
 MQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765188674; x=1765793474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10Z1nvhCx8Jttq9gPc+1C4MSnhrBzSeQZNi5Q8b+j6Y=;
 b=SC913qOveFLFE+0dgJ0J7W1IaBLVzDhU7CuonbfuJ+aN62pZLSKDAnJ4tAIx85xI0K
 +TILRDGCKqa7kr1JE5ffg973IMX66kSGLbOiaiYvyioo0u+XGz5UqlZOAjzt3ktdE3bE
 Fbxz4oNQrz84MnJQn0tKUGlbMO2WTMyhIc3odAnonqomfWhdEXky3Xa3iXgkGljlIkts
 m8JK8EKqoiwFRP7rzEUdnXsMS3ZiG6BKi4OS/dvtbDEi9tse5lUISN7BapSuGMrb89Ff
 0E7GTiefxR7nNYY0PO9RSXHxMZQwZkuBi/uzVlhIBJZfrTSmejqUOIk8jTJIP027iLeo
 OZCg==
X-Gm-Message-State: AOJu0YyEkjGnW/duJeU7Qn5DDRT6oBEeTEHvzaW6Cfh2Sob9n3f6hdpj
 kJAA5dkxxQhA6zs1sItWec+3ZfCjgU+7J5F8dSB8P6m0s1XCQP4bwhdb/C8TiafrYGq8Qx+m4Vb
 ZvUjuT915/55Cs2cKwhNCG52tDiZ/JvDmiCaldptAcM7SYetV4fjvNJI=
X-Gm-Gg: ASbGncsaYnbeaTIVgI4uQsrJ1etudZisepkmNE45JqH3pF0EnuUb/NL6zDZmdMRbq9R
 27xmf5COThQQQV4/OUKFdbDhybvJ8FxEmdVSiYpDCMls9nCMApVNgPCvpuQwW2j54J/pJ0syim8
 GQAJUnjQDTsL/CYzstJoaJbkDtRSZAaXo6k6iGydt+t7TxZwBhiXjbk/yKtRBPjuH+MjoRvAQOY
 iMcPZb5WFr4UuKN8KIE7ZFGzqjEDIxSYKRB0rxLfHh4yXEMOhCppRYfwXp7Wy2TrrcIwFpT
X-Google-Smtp-Source: AGHT+IFgB0pxSlY53XRuYNgnhCAGj1TOwvMz/FBJQZF1xIJH6KwT0V0x8dYCsZyQ2WSL/vLVasEd49+4DcNjIkUjW5I=
X-Received: by 2002:a05:690c:46c7:b0:786:4459:cb84 with SMTP id
 00721157ae682-78c33b7641emr131444447b3.29.1765188673732; Mon, 08 Dec 2025
 02:11:13 -0800 (PST)
MIME-Version: 1.0
References: <3d73bcbc-d3f0-4271-9f99-d53fb5a85db6@ksl.ci.kyutech.ac.jp>
 <CAFEAcA_XNdUDFLojnqYdsBqh2jZyg45ds9wJjiS9ujhPnX2z9Q@mail.gmail.com>
 <ca445bdd-297e-4e8d-9b44-06c1b44378e4@ksl.ci.kyutech.ac.jp>
In-Reply-To: <ca445bdd-297e-4e8d-9b44-06c1b44378e4@ksl.ci.kyutech.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Dec 2025 10:11:01 +0000
X-Gm-Features: AQt7F2qUR5D4Kqu3OmUWLsP7sySy5ShdQrihR0UPF9HkoTcf1yfWp72BYQ6NIuw
Message-ID: <CAFEAcA8EE_HrLKCvwTYGxVUtNqiF9nRycPPihMoRyMSPzyZt4Q@mail.gmail.com>
Subject: Re: tcg: Requesting clarification on return value of prepare_host_addr
To: Shusaku KURAMITSU <kuramitsu@ksl.ci.kyutech.ac.jp>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Mon, 8 Dec 2025 at 09:37, Shusaku KURAMITSU
<kuramitsu@ksl.ci.kyutech.ac.jp> wrote:
>
>
> On 2025/12/05 23:44, Peter Maydell wrote:
> > No; if tcg_use_softmmu is false and a_mask is zero then
> > we will not take either the if() or the else if() block,
> > and ldst will still be NULL when we return it.
> >
> > This is because:
> >   * softmmu always requires a slowpath (because we might
> >     look the guest address up in the TLB but not find it)
> >   * linux-user mode needs a slowpath only if we need to
> >     enforce alignment and atomicity checks for this
> >     memory access (because linux-user always has "guest
> >     address == host address + some constant", so most
> >     simple loads and stores cannot fail or be complicated)
> >
> > If we don't have to do either, then we don't need the slowpath.

> Thanks for the reply! Perhaps the confusion is from what "requiring
> slowpath" means. Does that mean requiring emitting slowpath (which
> I suspect is what's happening here), or requiring jumping to
> slowpath (i.e. never using fastpath), on softmmu?

Here I meant that we must emit code for the slow path,
because we cannot guarantee that we do not need it at
runtime. (If we are in this function at all then we
know it's at least possible that we might be able to
take the fast path and handle the load/store entirely
with the inline generated code.)

The only case where we can guarantee that we do not
need a slow path and can always complete the load/store
inline is for linux-user mode when there are no alignment
or atomicity constraints.

thanks
-- PMM

