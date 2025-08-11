Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E239C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 09:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulOT8-0000yv-NE; Mon, 11 Aug 2025 05:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ulOT6-0000yQ-8Z
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 05:05:24 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ulOT4-00054s-55
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 05:05:23 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e9028e13bb4so3319919276.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 02:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754903120; x=1755507920; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fl2vmmq+v9DGeZx45O5Nw0hoNQ8t026OH3kktP1HWdc=;
 b=IStGxRbK8ugICODG0tjFhJjWS+IgjfWxEv6XWyTKQA8TbKrisSgRYuXBSx5e5MpqZ8
 0DODSpTvPYKc2XZS56417XdYv21teN06ADwpO+FMELu+B+HvES8/JBtutGKhtEplXVnb
 oaSFYETGziObHkwRVGaV9Pdy8vo6yCkLPhDYAilNRxRkSYhBbZy2m6g4G5xotiBvMI7w
 U1BqQUboN8Vx/Vr3PFuqILkBMpPEKhKVBKAcGQuz2cwfsbUJoa9g7s5GEQG9l3M1UTQY
 VVwLUoNtBl0iyAQcyeYCGzMpa0pIAJbR9rW5mcojdNec68x4MVYfqXGj1EGkzVyb/KKq
 YYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754903120; x=1755507920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fl2vmmq+v9DGeZx45O5Nw0hoNQ8t026OH3kktP1HWdc=;
 b=hre0Uicg2+y5w4ewy7mnYQeS1W/9LMv6JFY5bWRQPJgFfL4rX047ii55deWSlPdr8f
 uNIOn0GXs6ZNcmjKUt0dtvXmjZA00r4EsTXYMelBQfj4cF1Kf1B9Osl/4VimlDS1uQ9A
 UTlxeiq5UCUCAKSBFrz5lD90HnmO0zTKv0kZSPwAMxo2Y0Wmh8jMIZJDJxlGwxRqlcZh
 i0mjaEhopiMiLrF6wBQGc3c/rkHWatPZ80JU9u1LfQgkXx56elr7ff8Kmqo+B8Uzx58F
 rhEYUWfWWUg4zATQctdbt4lIq2uWq/Md5eFi2r+5PuXQr/yiUPiJZSDrd6H/RxnFIP6q
 MTGg==
X-Gm-Message-State: AOJu0YxFzUNETSSRz9Xe2AcCiG5OqRz/ZLRVfx0tAwVtktHQ8v9RR3V8
 OBJXDZtyHbael9Kgw99jLULRjYUsybxKJ0yBh7vldQh+W9Oe976sN0q+sPYgMOSfjYNmO6yJ4Df
 GChhrb3CujUT8RphChgAfZKhcVQrfWzPdDkl23WvVvXORShrOScjg
X-Gm-Gg: ASbGncs+0ermfeeyFCCYaH3KSHUtisjRZyTH2/B1cfUyxVHL4LDSfYkwk1r3JvNa9wf
 /nemljr18iJAJNALbtKAbyco0eHGcmKWXAPb/m8OsyYTew0e071GOkhg/tRxNu7xigczEdRSrGY
 X2AuBY837jt/U3y9vSQvRmZuv0peiKhUMmUnZKAMuo8YCN+QNegzjCbNLLxn6I3mS7JerI70F1M
 enZtIEH
X-Google-Smtp-Source: AGHT+IHDBFZnMy7v0k33Ovf1KNbBXMto2W1HY1iMlHnBfhjSZUf3usobT3QGRoiLOB+TYqlpN6bMRQQRFq4pCmjUna4=
X-Received: by 2002:a05:690c:62c1:b0:71b:6d47:8c59 with SMTP id
 00721157ae682-71bf0cbaff4mr160469207b3.2.1754903119802; Mon, 11 Aug 2025
 02:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <bf6e627f-b2dc-4776-ba30-cc7670dde685@tls.msk.ru>
In-Reply-To: <bf6e627f-b2dc-4776-ba30-cc7670dde685@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Aug 2025 10:05:06 +0100
X-Gm-Features: Ac12FXwBpL2QHvHege0ppNFHnq6SjKGnlcDcqj7dwXi52p-5o4rUpD7YbNDxH1A
Message-ID: <CAFEAcA-DqPtnYVvvNyEN5OGxuaMBU+6E0RQaKObVetdUufZvkA@mail.gmail.com>
Subject: Re: using qemu linux-user with setuid applications (C binfmt flag)
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Development <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Mon, 11 Aug 2025 at 08:57, Michael Tokarev <mjt@tls.msk.ru> wrote:
> It's been quite some time since many distributions enabled the C
> (credentials) flag when using qemu-user binfmt_misc emulation.
> This means that qemu-user executable is used to run setuid binaries,
> usually with elevated privileges.  The binary itself might be suited
> well for security-sensitive and probably hostile environment, but
> qemu-user binary is definitely not, - it is a quite complex piece
> of software with a lot of possible attack vectors.
>
> To me it looks like a Very Bad Idea (tm) to enable the C flag in
> this case.  But maybe it's not *that* bad because the administrator
> is the one who controls *which* setuid binaries are present on the
> system.
>
> What's the qemu project view on this?

We treat all code-emulation use cases as "not security sensitive"
(i.e. there might be containment-escape bugs in parts of the
codebase not used in KVM VMs; we don't have the resources to
audit). For linux-user, we further assume that the executing
code already has the privilege of the QEMU process -- I'm
pretty sure there are things you can get it to do that
will make it fall over that we don't care about on that basis
(notably, all of QEMU's internals are shared with the guest
process, with no memory separation, so the guest can just
write x86 executable code and arrange for QEMU to jump/return
to it if it likes).

Whether any of those things in QEMU would be exploitable via
controlling the input to a trustworthy setuid binary I have
no idea (though obviously if you could get the binary to
do an "arbitrary write to memory" that would be a problem
in the non-emulation case too)...

-- PMM

