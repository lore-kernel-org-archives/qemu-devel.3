Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88504C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 19:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2EEX-0004RT-1Y; Tue, 08 Apr 2025 15:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1u2EET-0004QF-Q8; Tue, 08 Apr 2025 15:03:37 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1u2EEP-00054P-5f; Tue, 08 Apr 2025 15:03:37 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso5817122a12.2; 
 Tue, 08 Apr 2025 12:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744138997; x=1744743797; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GMvT5OA9+nyz2dr2ZM0Hc+etz+J1GeGLh4IodutTSwg=;
 b=LXCLkTFjsI65OvUObmEk7QqrGSZmlu0CfrrKLpa2lE+RsF74/1A52SW2cJRT3/4zVd
 4EwxamcLgkROndQocBrSgNbG9BeSYWkW/sN3Vk6IJWzpqYGQ7z24Fco3ddbDWJoro6nP
 mr41LAJgO9DHkLie0RICBy+Kpox8gXAOEt4YwSQTy7FdbGaWRESXbY9810jOo9DwnBQu
 wv0vmPfpUAA1uK0dFIFkGOGnLt/26E6EDY0qe7P4TFNZkGYVGRQMvPQ+OZ/ihXCjmJFN
 WTqrXvOs78aU84MQmP6jPeo0fsXu4EvbDfjt5na6Ke6UNLAiP7CxFTE0l2vz5uhJ3lku
 TYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744138997; x=1744743797;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GMvT5OA9+nyz2dr2ZM0Hc+etz+J1GeGLh4IodutTSwg=;
 b=NNRWk9fDpbb+L1Pnd/JTdaxqPg33C4rTU6reI2PSWiGIu6n7mwypmDFvvVPD87wz74
 VJNBTOc5jrW12aCwoVunDGOxY/pHrhWIy+ENPuO5DPn1b2KQiiFE2S3lJkCGSY0bZJgn
 MgIXXpU5RJRdCal9cJOFiGSXjugfLTQfF3SHw/SD37Pnx+ROLmjN99DP1YEgRPL3nKd0
 wilug7qghPfVMUEGPzEFK7feamByHVf+j5+aMxKd4qNk3aN1dNyGWRW05pmyCfOYLWFO
 r75l10hd7d698wdh9AfvFwNsalcfCDGjOYGhQDpFXd9jeYulM8kYBxWgIO/TbvURuv9u
 0zlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+WDq8h3dq+9pb4eJ9sMyIbc1xHgZuchJ39H0VJ2THVjMfeBthiHbRKbE8Y54E7L6idCYDjspFWx0c@nongnu.org,
 AJvYcCXYMPrr6ob5+kjuXT+KFVqS5scW7oLyfLeRxVh2FxQkPagcwedlbZ81SDORr2dyqfI17IpOSHTRHLohFg==@nongnu.org
X-Gm-Message-State: AOJu0Yz9lpLMUgroojFvs9cX7n0Dc52hr/DH8fdltcFhoBo/SPdAdU4v
 SEs67/r1iCWg34bE9qmlq5wgfz51y1dE5AbeEbowCsCExjZoG2acezDVp4V8c405SbYpLd0r8RY
 WTZr8Mv4en9G/0AfgRr6ZDEa3LJBAZizEiV+ouA==
X-Gm-Gg: ASbGncsHa+9oFYhxHfREQoZStpvyZqqCpmeOqncz8cADgIVfy36sV8oWIzTAKHUtdKA
 wiRzqpayx287N98O11z/JcloGIELqCW655bG0ROktZkFGT74LLAwlIqGnvpaKVJ7ZK4ZNgSMdsA
 6JNdmX+4o8fQrUcXFBq4rh4MBfon2PIy25546R
X-Google-Smtp-Source: AGHT+IGFruX4VwL1/bpMZzXfR8KS/d/dhL2Ii8RJ8vY0wywbjMQzDeUXjXKnEaqC9ow4YDu34DqEk4xpqMD2q9RWwUc=
X-Received: by 2002:a17:90b:3a10:b0:301:1c11:aa83 with SMTP id
 98e67ed59e1d1-306dbc2359fmr447673a91.28.1744138996758; Tue, 08 Apr 2025
 12:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250407154730.23008-1-prantoran@gmail.com>
 <20250408154338.GD550845@fedora>
In-Reply-To: <20250408154338.GD550845@fedora>
From: Pinku Deb Nath <prantoran@gmail.com>
Date: Tue, 8 Apr 2025 12:03:02 -0700
X-Gm-Features: ATxdqUGCUDasQ8kmqP5JUiFSK4jou_I2mHU0MJpEl-6y1IxRsCLAzjsAg9jAnGE
Message-ID: <CABqzzD6JWKpnR6Prwvna_ScYSXg3UNTLooXLZ2+nYpPO6c6VnA@mail.gmail.com>
Subject: Re: [PATCH v6] block/file-posix.c: Use pwritev2() with RWF_DSYNC for
 FUA
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000573f8b0632490106"
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=prantoran@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000573f8b0632490106
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yay! =F0=9F=98=8A

On Tue, Apr 8, 2025, 8:43 a.m. Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Mon, Apr 07, 2025 at 08:47:30AM -0700, Pinku Deb Nath wrote:
> > Full Unit Access (FUA) is an optimization where a disk write with the
> > flag set will be persisted to disk immediately instead of potentially
> > remaining in the disk's write cache.
> >
> > This commit address the todo task
> > for using pwritev2() with RWF_DSYNC in the thread pool section of
> > raw_co_prw(), if pwritev2() with RWF_DSYNC is available in the host,
> > which is always the case for Linux kernel >=3D 4.7.
> >
> > The intent for FUA is indicated with the BDRV_REQ_FUA flag.
> > The old code paths are preserved in case BDRV_REQ_FUA is off
> > or pwritev2() with RWF_DSYNC is not available.
> >
> > Support for disk writes with FUA is handled in qemu_pwritev_fua(),
> > which uses pwritev2() with RWF_DSYNC if available, otherwise falls
> > back to pwritev2() with no flags followed by flush using
> > handle_aiocb_flush().
> >
> > If pwritev2() is not implemented, then disk write in the linear FUA
> > will fallback to pwrite() + handle_aiocb_flush().
> >
> > Signed-off-by: Pinku Deb Nath <prantoran@gmail.com>
> >
> > ---
> >
> > v5:
> > - Use pwritev for unsupported OSes
> >
> > v4:
> > - Add fallback when qemu_pwritev_fua() returns ENOSYS
> > - Similar fallback was not added for handle_aiocb_rw_vector()
> > since there is a preadv_present check in handle_aiocb_rw()
> >
> > v3:
> > - Changed signature to add fd, iov, nr_iov
> > - Return -ENOSYS for non-Linux hosts
> >
> > v2:
> > - Moved handle_aiocb_flush() into qemu_pwritev_fua()
> > - In handle_aiocb_rw_linear(), iovec with iovcnt=3D1 is created
> > based on the assumption that there will be only one buffer
> > ---
> >  block/file-posix.c | 68 ++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 56 insertions(+), 12 deletions(-)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>

--000000000000573f8b0632490106
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Yay! =F0=9F=98=8A</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Apr 8, 2025, 8:43 a.m. Stefan Hajnoczi &lt;<a href=
=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">On Mon, Apr 07, 2025 at 08:47:30AM -0700, P=
inku Deb Nath wrote:<br>
&gt; Full Unit Access (FUA) is an optimization where a disk write with the<=
br>
&gt; flag set will be persisted to disk immediately instead of potentially<=
br>
&gt; remaining in the disk&#39;s write cache.<br>
&gt; <br>
&gt; This commit address the todo task<br>
&gt; for using pwritev2() with RWF_DSYNC in the thread pool section of<br>
&gt; raw_co_prw(), if pwritev2() with RWF_DSYNC is available in the host,<b=
r>
&gt; which is always the case for Linux kernel &gt;=3D 4.7.<br>
&gt; <br>
&gt; The intent for FUA is indicated with the BDRV_REQ_FUA flag.<br>
&gt; The old code paths are preserved in case BDRV_REQ_FUA is off<br>
&gt; or pwritev2() with RWF_DSYNC is not available.<br>
&gt; <br>
&gt; Support for disk writes with FUA is handled in qemu_pwritev_fua(),<br>
&gt; which uses pwritev2() with RWF_DSYNC if available, otherwise falls<br>
&gt; back to pwritev2() with no flags followed by flush using<br>
&gt; handle_aiocb_flush().<br>
&gt; <br>
&gt; If pwritev2() is not implemented, then disk write in the linear FUA<br=
>
&gt; will fallback to pwrite() + handle_aiocb_flush().<br>
&gt; <br>
&gt; Signed-off-by: Pinku Deb Nath &lt;<a href=3D"mailto:prantoran@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">prantoran@gmail.com</a>&gt;<br>
&gt; <br>
&gt; ---<br>
&gt; <br>
&gt; v5:<br>
&gt; - Use pwritev for unsupported OSes<br>
&gt; <br>
&gt; v4:<br>
&gt; - Add fallback when qemu_pwritev_fua() returns ENOSYS<br>
&gt; - Similar fallback was not added for handle_aiocb_rw_vector()<br>
&gt; since there is a preadv_present check in handle_aiocb_rw()<br>
&gt; <br>
&gt; v3:<br>
&gt; - Changed signature to add fd, iov, nr_iov<br>
&gt; - Return -ENOSYS for non-Linux hosts<br>
&gt; <br>
&gt; v2:<br>
&gt; - Moved handle_aiocb_flush() into qemu_pwritev_fua()<br>
&gt; - In handle_aiocb_rw_linear(), iovec with iovcnt=3D1 is created<br>
&gt; based on the assumption that there will be only one buffer<br>
&gt; ---<br>
&gt;=C2=A0 block/file-posix.c | 68 ++++++++++++++++++++++++++++++++++++++--=
------<br>
&gt;=C2=A0 1 file changed, 56 insertions(+), 12 deletions(-)<br>
<br>
Reviewed-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;<br>
</blockquote></div>

--000000000000573f8b0632490106--

