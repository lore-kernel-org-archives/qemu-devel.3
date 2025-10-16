Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591F8CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mq5-0004I8-Cj; Thu, 16 Oct 2025 08:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9Mq1-0004Fc-LK
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:12:09 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9Mpq-0007Vh-74
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:12:08 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-635380a4a67so596479d50.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616709; x=1761221509; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=74prRsWt9fN/jTucFMtsjHX21AKgfiRm6RmaEx0wV40=;
 b=GpJvN5N3qoQyrfmHL+VnO/sMPxV7mFdoodoCKRUUTnzCcFAyNocTfglFvSkYZ+I0x2
 Gh17bICOY/nuF5TSdDzAne+L3RpcnbJUvsYJpkrbc2Dcub43ULfI8aodfMb4heimbgLj
 YF4rxTZADShSj2rucajZly8aNvUZ24RapmjYW0mCKmZ4uwgvGBP0Dse9KDxXRPPhx6Tv
 /TkTu2+heZj8DgzzYQbSuVrj1VT7eKUkTbLhAc1icRLSqoA3mlo8NU7USy7+aLnmj8bU
 jYUuJEGXrI+dnvqxblpnJ0v5qwIYhpJrfdCC8MDCRsXTCI0HP7u5MFFCASnEvuNMvNM3
 e28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616709; x=1761221509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=74prRsWt9fN/jTucFMtsjHX21AKgfiRm6RmaEx0wV40=;
 b=jcIxCwlgV3OXZkW4ieKDyDWc7VkbwMWIXvCckJxLefQq91tDCeSgtTUX2o7mrycOYb
 scGaINw7DfPrioKIG0eTT0jQRnydKgnwHw+KzoM1NltyfMCMxVeDVaegM1ogGTrLnYLL
 RdPVrptuaOwdFNBzQOAD5KqkSrC3FBZtbRzjVm9zy+eptZgyovO1zwnHVXeU4I6fHjUG
 lJ0GMeWbaw1BHd1hlAMHL8lkLGvtA+ob0q7jZ/+faAjbYf/7p3ehzB0xqy002kCSsCiP
 ctl3GzDgZxpd6cIeFRwGvw5IJ29rYrl1mloNNv0hhnUoo08klTKFtB+ij4tPwR64bP7W
 0Cdw==
X-Gm-Message-State: AOJu0YzVS8f5X4PPiUDXbFSdbujthblWNWSphquKR806OvBoomHq0u30
 jvZAHraaWtqayl88KBZYBc69NKlI3HlM7yuIP+pIMAzs47ld71DH34ZbW9OUD9JYNOq2s+Ip+EJ
 2ggwdzNAxKb4i3qJ+dP4ppx0JBZjpj2P2echHM51qSQ==
X-Gm-Gg: ASbGncsrUY3RamAjfonI+/xzvZXgpOYVRrinNds3X9ObFHwDVPnF6rfHAIy6DJQ/zBD
 MfO117PlSTqcRDlkXCJ0ZeQhsRsmsjEASJnIs60YluIDi5DH4mQ3hL7KdcovDZe7I89u7dPi85O
 EW9NdMHBTpEsWCZqRxuK4rwZwQ6wEDiPFVZ1Js2sJ62Vhgr5dE+/tOXk2U9M1hqqBZ4B51fHnLb
 oX7VBlbXWhUSyJuXKBkkw2UQj9R7VaUIhT8dBzg9XUYc3xPu/27nWwQVYpU6lKRkf9PkA5nCLAQ
X-Google-Smtp-Source: AGHT+IH8iTmPmiSludiYkeeYjZ3LtQ7nmOsK6tVWQIwHNTcppT5F01A3Jp78Un4F+GZ9aRMv9PMVEGQ8sNN/zo+PDKQ=
X-Received: by 2002:a05:690e:1287:b0:63e:12d7:8f35 with SMTP id
 956f58d0204a3-63e12d79256mr512626d50.49.1760616709239; Thu, 16 Oct 2025
 05:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251010121435.3885228-1-peter.maydell@linaro.org>
 <03c1d056-7319-438b-a2dc-27687108b678@redhat.com>
In-Reply-To: <03c1d056-7319-438b-a2dc-27687108b678@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Oct 2025 13:11:37 +0100
X-Gm-Features: AS18NWDYEp2fMbXdLllyh9mHzJ7IbBOZyflYj3tp8eTC2yYVKa--RF9XLxMTTwQ
Message-ID: <CAFEAcA9sZ+ss7H8HrjLsHrsh_Rpj0ykt=y_y=vptwE2pLE09uQ@mail.gmail.com>
Subject: Re: [PATCH] tests/tcg/multiarch/linux/linux-test: Don't try to test
 atime update
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 16 Oct 2025 at 13:08, Thomas Huth <thuth@redhat.com> wrote:
>
> On 10/10/2025 14.14, Peter Maydell wrote:
> >   tests/tcg/multiarch/linux/linux-test.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/linux/linux-test.c
> > index 64f57cb287e..bf6e0fda262 100644
> > --- a/tests/tcg/multiarch/linux/linux-test.c
> > +++ b/tests/tcg/multiarch/linux/linux-test.c
> > @@ -155,9 +155,14 @@ static void test_file(void)
>
> Maybe drop the "tbuf.actime = 1001;" earlier in this file, too?

The utime("file2", &tbuf)  call will still set both atime and
mtime, so we want to keep the initialization of that field
so we're not accessing an uninitialized value with the syscall.

> >           error("stat mode");
> >       if ((st.st_mode & 0777) != 0600)
> >           error("stat mode2");
> > -    if (st.st_atime != 1001 ||
> > -        st.st_mtime != 1000)
> > +    /*
> > +     * Only check mtime, not atime: other processes such as
> > +     * virus scanners might race with this test program and get
> > +     * in and update the atime, causing random failures.
>
> I actually saw similar problems when looking at the atimes of the files in
> the functional test cache, so I agree, checking atime cannot work reliably.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

thanks
-- PMM

