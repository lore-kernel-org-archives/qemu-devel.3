Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B87C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 17:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raJ7c-0002Ij-5X; Wed, 14 Feb 2024 12:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1raJ7a-0002Ia-SJ
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 12:32:34 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1raJ7Y-0000KK-Oe
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 12:32:34 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55c2cf644f3so7694672a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 09:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707931950; x=1708536750; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8dwBou5PS3rKclLYlD68mzBVa1RXbOHDycQN1sQeK4c=;
 b=uOCqpl4dlv0FaYvJiqjpLL4rDarA022GXmz+/AcBnzf7qIZALR5PNYHUli+aj9n9Jt
 L5eKwYA7/gYBFrkUlz9cjZEm24SoDEUbgH5gMn351Iw7mTKaBuNzxcBBfQ8mDVjhPhEj
 ZM/R5/MeL4OB5CilcKyKJrL6XADR8Qih6HemssbtVo5f+Y1axaYWZX9/yaNnSUgMg4RZ
 KwAYqTBmSNRRHFSzvN8jvaWUxxnUo/Ja/yb8Hx6MchPOCYwZO16ZjdWI5pUwaZUWjqvz
 klOeWer7wUwlSFMCQw8AFw3y+ys1Dv4MsrwxZQHB8NeyMBkjAX05Z9gARl/cm0xya5LV
 reYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707931950; x=1708536750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8dwBou5PS3rKclLYlD68mzBVa1RXbOHDycQN1sQeK4c=;
 b=SDskh0AwlVogE9spf0KIXw/xz9EshiyYn4Gaou2No7nKjBpZoe02TAmjgFJu9YyftE
 x1mZmMWs7hmh8VGlz0PQaZ8077p9f4B/uJpohoMmXw/z1Dz5hT9G1hiXNMiY+IE2OPJc
 TXxw+JVPkNvhoHtJTeeTYRWcEL2l4KXFT7oZwTUl859BKBUfT3spXOLCG+BL2Js4TzzD
 iDvOPp06bQFxuqWU8axDuQUHStZHiD+5GtasDCufdoTL0TIU5gma92/d3wZUyur1Uepl
 tdpbUMH/0D0xX8uhBCkChbCvuBTksT7Z0YZJauPQGLJicIsw1e9g9i0zbuZiKGPXqsNC
 TAEw==
X-Gm-Message-State: AOJu0Yxe1n2v07eGx2y30BsZH4AyNrtFVbKTOdJiIO4e7cOahuNF8GHH
 p3TI660GkfIfjdhxrxZQSv31dtaJo8qVWJGv613LAzm3ET/yxSM15PyxUWcfVMD7VYTSnziWs6E
 MSjgFRUfMgas9Qy7CKahmsuKGNY46NlVGgkdxQw==
X-Google-Smtp-Source: AGHT+IEnNGhf1B94CCszcwX+H1oodWZxMCkNNc9v79hBxSd8SlHQ3Qx9X1m0Oz8MyOKkbTHKyM8WBKqtZWjPZ8I9HRk=
X-Received: by 2002:aa7:da0e:0:b0:560:64f4:cbd3 with SMTP id
 r14-20020aa7da0e000000b0056064f4cbd3mr2614421eds.20.1707931950586; Wed, 14
 Feb 2024 09:32:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1707909001.git.mst@redhat.com>
 <20240214061846-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240214061846-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Feb 2024 17:32:19 +0000
Message-ID: <CAFEAcA9qmQZGEL8_ergVr_dCOZvqwW4OhNs5wEbF1VO8b3G2PQ@mail.gmail.com>
Subject: Re: [PULL 00/60] virtio,pc,pci: features, cleanups, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, 14 Feb 2024 at 11:19, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Feb 14, 2024 at 06:13:16AM -0500, Michael S. Tsirkin wrote:
> > The following changes since commit df50424b4dcfde823047d3717abd6a61224ea205:
> >
> >   Merge tag 'pull-riscv-to-apply-20240209' of https://github.com/alistair23/qemu into staging (2024-02-09 16:15:01 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 3afdb6d18e9ccd6470be30f151a562cf4537d13f:
>
>
> 1dd6954c3f5c5c610cf94b6f740118e565957293 now - dropped a duplicate
> SOB from commit log.
>
> >   MAINTAINERS: Switch to my Enfabrica email (2024-02-14 06:09:33 -0500)
> >
> > ----------------------------------------------------------------
> > virtio,pc,pci: features, cleanups, fixes
> >
> > vhost-user-snd support
> > x2APIC mode with TCG support
> > CXL update to r3.1
> >
> > fixes, cleanups all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

