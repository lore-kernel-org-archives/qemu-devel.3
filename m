Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF99CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCaa0-0001Of-4r; Fri, 02 Oct 2026 06:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCaZy-0001OW-4N
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:33:26 -0400
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCaZw-0004pb-9R
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:33:25 -0400
Received: by mail-yx2-x0f.google.com with SMTP id
 00721157ae682-895353e9051so74412557b3.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 03:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790937202; cv=none;
 d=google.com; s=arc-20260327;
 b=NLLwHx7/6gUjW6BvKOUgtfHUHR1mZTNUml0G+6Mv+z+0mJ5gF3W73ZPko9N7+whm+Z
 T3ywjezw7gecF0wehuB3vOnlc0uC2UXn34xUkfT4jEN0ZVK/UVb2KoSeO+E1g6RzcowV
 Qd3P81FPCskaZzYAcakjYnwyEMMvCWIUibFDoba9gxnogYJeSAQAyN8pYrn6uxCGzqI+
 nMnAHPhP3QrcnN2TUeR0jOoGdGJz8WvttBlw4e0vwmImh81GuLT16Z4MORVXi5HTgRL0
 FYzrlHIE/iw6gi5YDot8JYlzpgOJHOp752QWcnHfDiB9WJeCZ4y+3vMVUlwZP4ornxni
 bKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5xBJFiWxzjNBYYsawGQdNWSGN1yiA0tg7yBUGcp+QmE=;
 fh=r3wCZZDbTOKO9lZVTIFhMQQt4+cjrhRhMpQ+tvz+wiY=;
 b=Pq38qduDQKWlqALMMzDB7V+lpmt57QLzr10gkjc3qjV4yoZcy5TY8Gbv8qgKQkSYmo
 2Qhq4YyhQzrj/6tLrMj4TVJEHNifijf8ag5XyMieeVHPsb3wNV+lc1nbdNIUh7G92j44
 UdXWmfKCde+/JsIJAN+zPhB3bMQ9mZyY95JXa6l10u5ignWHS5VRO1eerD+pVBN66ybk
 zoOd4g8a7E4CJmg17aG949nr9LHyemwwjjN108M1zGik0VRjb3Fv62pL+UkmMWcn9cFl
 EkFF/brBP4OFJHsqRKSSpflpStUS1Sy05SfIY2gOR11MwOYO3zgHR9WXL8Dmx800OHor
 I4qQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790937202; x=1791542002; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5xBJFiWxzjNBYYsawGQdNWSGN1yiA0tg7yBUGcp+QmE=;
 b=rtJJpX6JwQFnSIp/eirDlo5Gxi1Up/N/vZ+GMnrvrizoHfxBVmzCii7eNWwAhX+cd8
 /tlDtXa5Q2U0kFQmvy2mWSlq2KpqYj8CUAW+BB/SifNpAF3ZRsFnpjuF1swbt0zoPRpO
 NkikhEnunGe7KgWTHQWEjUAJMcdqGP8Oo/pL4gosC0Oq4r4zlo1dkEsjOG0kaXCfOD60
 aYf0lvl4zOXh8khOzSqYkEe+wMWM4TTPU+ssRiPr/OK6wzyi9X2+nqtTjbPLQdr/K43Q
 CGL3kbV5XvguHO8j3dtTGZFv6knUitHGBf3jvUdN+tRIj3Yuo5ZKloTbwfXn2etRJBWN
 2YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790937202; x=1791542002;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5xBJFiWxzjNBYYsawGQdNWSGN1yiA0tg7yBUGcp+QmE=;
 b=E6kQYZ/q38O7Lo+hNaQOpQrGYPMEgDdSb0QJ8lnfFi6g7drkl59dJ3cz2fvMP3Wnp6
 11hnUcPK/Q0rYALpawkXTIZeNg7bPREpxuljjc5lPu3xyJOSTfQtNrhG0GvH5ehxQavJ
 ayjlZlUf8tHo6jqcNN/QlRcdP8/chrrPsdJ8E0FN0PGWnVjZpVCalz1JjErdRLqG4Hq1
 1QV4NPiQ/OdvxFCpkWKtYSQzPb5WhyQtgKn7Y5y9S0d0uE85+py6U8qnDJpJoBdJODzP
 Vn3BITbHZnGs9l9A6V3ebx1LSNMkVHp86DNY9qbnnKoDjVSsaerOJKqTILSsOqRJEPtU
 5UYw==
X-Gm-Message-State: AFq9FYKFccGROriFaMdBqThGeZfcYhO8ipBLvD+pjyYF/oqibW191D3h
 usk/gjcrSMFL7XJTnkE+xy7lV1RzrBeqiG38xevlbXAxLGAYehjdjd9FLQVT1xRmH4CjFddsrB1
 /OYDVVDX9jAZjPj+MsfhbbFbqLJHWgC9/pIWMreHJ1g==
X-Gm-Gg: AYBFou1Ud2u9r5yO3jrf2YYv9ed72UmUa/aa5tFQTy2qBk/WZU6gnuiRfCpOKM0Z1kG
 iYzIpqyuW4W35NK3TAphZ8As7gaS6djLNCKDz8G4WX0vhs0uIn+MOsawpYH7zXE1x0wrQwavMpC
 0prryMk5fFe+iFE/iqAp+uL0TQmTjigx8Gifs3/ZAc3/Rjzf6fWkgJuM/Ygki4n6V14S6wFu1vp
 XsbPUlO3olX3Ceh7KurUDyN5ZP5ryw7CSEHYWRfmcRgh6bgMPAyg9bTrytr30glDyabC5WuDas5
 Ldt+xmEQodxI3eqUsHYXpoluX0ZXtcGHCzHgPIghkxqJa/Ewb4l0i0s7Rl+ztvU+djyO9YypA3b
 8uJI7RAzeCdoDp13Av3m5/6Xs+6W4jrR3Si++SL2r
X-Received: by 2002:a05:690c:e218:10b0:8ac:e393:16bd with SMTP id
 00721157ae682-8ae3aedd9d2mr5858157b3.63.1790937202176; Fri, 02 Oct 2026
 03:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20261001194756.3003085-1-peter.maydell@linaro.org>
 <a3dd935a-0e15-411f-837b-3cfdc1c5bf63@redhat.com>
In-Reply-To: <a3dd935a-0e15-411f-837b-3cfdc1c5bf63@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2026 11:33:10 +0100
X-Gm-Features: AclHuK-K2AVTvHvMqkzZrfQuz0gwhjcyCrwE4Mo18jjqW9S0HwPeS_Sa6b2FcB8
Message-ID: <CAFEAcA_Wjx8CpkWkgM=FjaFZ7buQ9AygnCzGTmV9mJAvLrmRJw@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fail iso packets sent to non-iso
 endpoints and vice-versa
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0f.google.com
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

On Fri, 2 Oct 2026 at 11:22, Thomas Huth <thuth@redhat.com> wrote:
>
> On 01/10/2026 21.47, Peter Maydell wrote:
> > The OHCI USB controller requires software to set up an Endpoint
> > Descriptor data structure.  This specifies (among other things) both
> > an EndpointNumber telling the controller which USB endpoint to talk
> > to, and a Format (F) bit which is 1 for Isochronous transfers and 0
> > for General transfers.
> >
> > The specification requires that software matches the F bit with the
> > endpoint it's setting up the descriptor for, so that Control, Bulk
> > and Interrupt endpoints use F=0, and Isochronous endpoints use F=1.
> > It doesn't require the controller to check whether software gets this
> > right.
> >
> > The spec isn't totally clear about what happens if software creates
> > an ED with a mismatch, but I believe that the controller just trusts
> > the F bit, and tries to talk to the endpoint with the wrong sequence
> > of USB tokens (notably, isochronous transactions have no handshaking
> > and the others do). This probably results in the transfer failing.
> >
> > In hcd-ehci.c we check for the "iso transfer to non-iso endpoint" and
> > make it fail, but we don't do this in hcd-ohci.c.  The result is that
> > a guest that deliberately sets up this situation can cause us to hit
> > the assertion added in commit 7b1eba96aeca, where the endpoint is not
> > isochronous and returns USB_RET_ASYNC to an iso TD handling function
> > that isn't prepared to deal with that.
> >
> > Add checks for both "iso transfer to non-iso endpoint" and "non-iso
> > transfer to iso endpoint" and make those TDs fail rather than blindly
> > sending them to the endpoint.
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3729
> Looks like this issue got assigned with a CVE number, so please add:
>
> CVE: CVE-2026-7180

I guess we might as well, but honestly I don't think this is CVE worthy,
and I can't find any record of what that CVE number is supposed to cover
from a websearch.

This is in OHCI, which I thought was agreed to be outside
the security envelope, and in any case it's only an assertion failure.

The use-after-free that was the original subject of the bug report
has already been fixed by 7b1eba96aeca (which downgraded it to
"fails assertion").

thanks
-- PMM

