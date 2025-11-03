Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10E0CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvFU-0003N6-Ik; Mon, 03 Nov 2025 09:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFvFT-0003Mr-9E
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:09:31 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFvFK-0003xe-Ot
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:09:30 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7864cef1976so43018217b3.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 06:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762178953; x=1762783753; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBeM6HT10Rbb3AR7a4LzprnBZEe2ZoomWAnT9BJ2QGQ=;
 b=PFP59pDaLPQwsPGhsfW6eoae2afBfls3wkFY3XwKMy0Sy4AAAYXa1rEpK7RzVPJZDq
 unC6IdwkZSmHXiJpGB4TVoYnuHePrpru6h3Cp2eHIIzc42SBTxr82kf3kZRVB2YrJZhr
 ITdAbt84dFCgAAy4FBky4X+1JwvhyVIZrh8N/1RGwVWWb7BwaaSjPGQbfMn7jwSy+ECv
 fny4X6K/E88wX0M6WXKnw7cBWKD9Dp+kWcg+aiFrQe5CxxcQRH4XLY91+4mfZ9QbcEsr
 /lTb+mMbrHjgwJ8D1E44L5Gc/hw/d4l2u32q6xGpDEQC/BD8mWF8u/1sNCzCS58grOqS
 KkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762178953; x=1762783753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBeM6HT10Rbb3AR7a4LzprnBZEe2ZoomWAnT9BJ2QGQ=;
 b=FqmwqWz2OBPSX0/a6SWvAi9D8ZevKtBYZW1pp2IW2rUXmYbeEJ0e+TXTmCWAl031w9
 07P8+YfcrK/qhJa5u4zl8GIFEZxVN7P4SSP0dIz/Pwdu/bmg/AfnFrDd9/Y/XM0ziXM+
 gnoD7+CjW1Qohk+KuWqtWd3QEL9gt6ZIjeiaNXjpJ6Ycx583plfV6FMZhmARyowUHBsL
 uYsfH/y5P2jnOr6lQMiL2E+H1IJcNHLuS6spuXX02PGooKRZFL7zu2rhDLHXiNuvnEla
 C4K8Q/pYv8rVNewrXVSNEIcp3OyfSDymSxHwnY1CwWXxcznJ5P08qCXHowtbGOWBfbpI
 qBtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkWqYr6V+/SGkHko0kVLOBWNLC38AV2nHXOTkCyr95Uxins4any3v3npreV7W18necypzwsOJ3gWS8@nongnu.org
X-Gm-Message-State: AOJu0YxMeDsN18BxgaAG8e98reaVe+1pG6kJDpxukdTsvjVkRixfPYLw
 MxwuuRNrpZ7SLUHe1bxrYl5MCu4gGMDJVSI8ep6llrFe8QJJGVLEw/ujj29JyhZXPx0nShZex0D
 d2uqj9gMhnbRDNXc9eah0vHqPRWYgUYm7prQU2CafXL7Q0waOwMDVptc=
X-Gm-Gg: ASbGncvqX2gljzMHbYHorvbljiuRsaHLa8Nvh+nUQuXrv9uNLkueR/yWFGxl+MvgRLK
 yZb7jVpYrSROD3X6BGzd8eYsk7tzg8GuPU67xo6sp0HUt/bwTFVteeTemv4hdQEMTmoYFPFjkfo
 l9Mhhy3Qd69uHMebZf/IO2KteK8BsZ7ALLgcmVN/or+1t8eTWoWySsngvIDiSFb/yOqe0yEMUNY
 drC3yw7z8BjvayIZvLndVcJ2Fwibo++zpK7iIzfjLGNqLWdXwBIfY7E/Lvv8lhuTVrnRTLA
X-Google-Smtp-Source: AGHT+IGoQOlyrGa7pFfTUowRk5KIcE0mrhz1j3GaZd+72FvLj72Xp1NtNiKROZI8DOLM9mcwm1rzh57/EK2D0VRTV5o=
X-Received: by 2002:a05:690e:428e:10b0:63f:ae23:b5e6 with SMTP id
 956f58d0204a3-63fae23bb50mr3691266d50.26.1762178953295; Mon, 03 Nov 2025
 06:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20250626074529.1384114-1-clg@redhat.com>
 <20250626074529.1384114-10-clg@redhat.com>
 <CAFEAcA9+EyeWE0QSUhgd7+i3din8J76jnhTuDB7i9hu3x-urOg@mail.gmail.com>
 <CAFEAcA88jVL4Qwb4MEzdcqeXDjob1NZ3-k_ZtwPCgG+9U6fkNA@mail.gmail.com>
 <aQDKmM2FFKAusenB@movementarian.org>
 <CAFEAcA-cLQTTeuwcCfYRXwv-434_mttDO0oXr_UuaOmkHX370w@mail.gmail.com>
 <aQiaoBcgnwJEYG5j@movementarian.org>
In-Reply-To: <aQiaoBcgnwJEYG5j@movementarian.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Nov 2025 14:09:00 +0000
X-Gm-Features: AWmQ_bn4NIdF1mwxO0P3B7wjyGTUVpEDkiP8j1TfV0PKBsEbfeX81PqoNRs36ko
Message-ID: <CAFEAcA-FSuURfXJETNYTegjLSAUzbSJiE6+s6LGJpdhM-RxjSA@mail.gmail.com>
Subject: Re: [PULL 09/25] vfio-user: implement message receive infrastructure
To: John Levon <levon@movementarian.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Mon, 3 Nov 2025 at 12:05, John Levon <levon@movementarian.org> wrote:
>
> On Mon, Nov 03, 2025 at 11:34:36AM +0000, Peter Maydell wrote:
>
> > > > > Hi; Coverity suggests there are some issues with this code
> > > > > (CID 1611807, 1611808, 1611809):
> > > >
> > > > Hi; it looks like 1611807 and 1611808 (the resource leaks)
> > > > are still present in this code in current git; would somebody
> > > > like to have a look at this?
> > >
> > > Please see https://lore.kernel.org/qemu-devel/aG-4hkfLDEpDsqo6@moveme=
ntarian.org/
> > >
> > > I believe them to be false positives.
> >
> > That email only seems to talk about the locking issue (1611806,
> > 1611809) which we've marked as false-positives in Coverity.
> > But 1611807 and 1611808 are "failed to free resources" issues:
> > we allocate memory into reqfds and msg, but in the error
> > exit path (e.g. if we "goto fatal" because qio_channel_read()
> > failed) it doesn't look like we ever free that memory.
>
> Sorry, I should have pasted: Here was my reply to C=C3=A9dric below.
>
> Looking at it with fresh eyes, though, I'm not so sure, at least in the c=
ase we
> alloc instead of freelist, we need some form of recycle on the error path=
. The
> whole function needs a big refactor for clarity...
>
> > *** CID 1611808:         Resource leaks  (RESOURCE_LEAK)
> > /builds/qemu-project/qemu/hw/vfio-user/proxy.c: 411             in vfio=
_user_recv_one()
> > 405         if (isreply && msg !=3D NULL) {
> > 406             /* force an error to keep sending thread from hanging *=
/
> > 407             vfio_user_set_error(msg->hdr, EINVAL);
> > 408             msg->complete =3D true;
> > 409             qemu_cond_signal(&msg->cv);
> > 410         }
> > > > >     CID 1611808:         Resource leaks  (RESOURCE_LEAK)
> > > > >     Variable "reqfds" going out of scope leaks the storage it poi=
nts to.
> > 411         return -1;
>
> vfio_user_getmsg() I think takes ownership of reqfds so this looks OK.

The error reported in CID 1611808 is that if we take the "goto err"
code path for "vfio_user_recv request larger than max" then we
never call vfio_user_getmsg() to take ownership of reqfds, but the
'err' codepath does not free reqfds.

> It's hard to say without the full analysis.

If you like you can ask for an account at
https://scan.coverity.com/projects/qemu which will let you look
at the issues in the web GUI, which is a bit more detailed than
the email summaries.

> > /builds/qemu-project/qemu/hw/vfio-user/proxy.c: 411             in vfio=
_user_recv_one()
> > 405         if (isreply && msg !=3D NULL) {
> > 406             /* force an error to keep sending thread from hanging *=
/
> > 407             vfio_user_set_error(msg->hdr, EINVAL);
> > 408             msg->complete =3D true;
> > 409             qemu_cond_signal(&msg->cv);
> > 410         }
> > > > >     CID 1611807:         Resource leaks  (RESOURCE_LEAK)
> > > > >     Variable "msg" going out of scope leaks the storage it points=
 to.
> > 411         return -1;
> > 412     }
>
> Same as above.

In 1611807 the error path is slightly different: here we
do call vfio_user_getmsg(), which allocates 'msg' and returns
it to us. Then we get a failure return from qio_channel_read()
which causes us to take a "goto fatal", so we never call
vfio_user_process() to take ownership of 'msg'; but we don't free
it or otherwise dispose of it in the 'fatal' codepath.

I think it might also make the code more readable if
it was refactored to keep the is_reply and !is_reply
codepaths separate. At the moment the error handling
is complicated because the second half of the function
has two consecutive "if (is_reply) { ... } else { ... }"
long code blocks, and the error handling depends on
whether we're is_reply or not.

thanks
-- PMM

