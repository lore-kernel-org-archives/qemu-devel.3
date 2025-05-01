Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C580CC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 17:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAXsr-0000Fg-C8; Thu, 01 May 2025 13:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uAXsd-000074-4r
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:39:27 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uAXsb-0005mS-7j
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:39:26 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f6222c6c4cso1783796a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746121161; x=1746725961; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xr+AZnpLiteRrzICWPUMnb0lETINLnif30mzne9EE1g=;
 b=SQjdtNF4OYuPR3+wtB7AK19DeAxCtuyvtN6upjP0pK8sLPWK82SaK46xO/PZHd1tSx
 L8szSXo3IUJ+nqFsDsbMfEFmKqtnH7b3AuepocJXmkBvVyFtLl21PIfO1jspWDWqRm8T
 7eoCOC2Dj2Zl7GY78OlkntPjVAW/H5JD4L3nUqqeB7v9gkapBN2ClJ1pmCyAIUw6ujxX
 yXTBxeKzIIXI+tdg+MCK+Kt2oZ1Rd8vjJfcTwkXoXUsZro85b/q6LXbuiwMjjPV41Je7
 SK5W4YLOlhZpMLg+hMlAGLowMYftSXvo4klBofcRMb/1EB4aYV6T1FqtjvnrKLyMgzGA
 wi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746121161; x=1746725961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xr+AZnpLiteRrzICWPUMnb0lETINLnif30mzne9EE1g=;
 b=VNQINwTPxmbMmh0zhXMO1Gtnst/naet9/ud4gWi0ZBvHFKp5D+FlMlLQL6VBPdWaNQ
 0vOC9qLqOOgFzufIXgdEQTlY6jDAARbrNV0WDdZX61tAYwPlxdtWyYbhh4Pgo2lOyFQQ
 Js6HrvwSL+Nq0a9jSHJTqyu24WlhjeqVFS0Gp/F7r69nXNczl3eHbAELTjtIuUwy9azt
 H3BZdPeeT6K6fmUs2ZiqME6wyDuW/felti4lyZZGG70/0sPL+DzzBw3tw5a1eti4uilY
 rJFZ5ImJc6Tq3NvS9P37CnYA164n3N6mz1Y4q5urYqJMrVrUjxKHN49Kb5Ueq5PVS58h
 fFUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB0TvzDWlxqBAxLx7Wwayg1fc2M3ZezP5Rsfp5fWwVBwtXt9UuDYFQtCgEzCaleI6w326RlYh8zUWp@nongnu.org
X-Gm-Message-State: AOJu0Yx6HNC2DLTDcDXwu6atdkVw3rjfDr6C+3PZAiDaKiVQzgJBv8sW
 61g/aEsFHVxHbBKuKXk/eQ8a1u41zb1u87Wths5+cCvv4uCTcRWe9cFUFXd0UbkCevT6jWgekcb
 RJOWfsCm7qaQ+K0IBFF+c3diF4Yo=
X-Gm-Gg: ASbGncs1Z2rEoVEIGIq73iqMBDfDSyz6/sbXhx5v9wnxxVx73zTtnE5ZfTUJDXVoUAP
 +aTZZuYKt6Qezdc5nmh1GqhfLToWy/wFSQeYF3ZGiRZFJWsRHg5UrhDBt99hJG2oB+HE4FnOWad
 HxeRcT9wbicX93/R7Zi+cu
X-Google-Smtp-Source: AGHT+IEXDtuo+QKRxqSjCV7b+53dYxP8QoQPZRgpLziCsZrK+qnKEBNJx5XHlPuuv20XmZp5aTQCMqSIvItgwbY97ew=
X-Received: by 2002:a05:6402:2b98:b0:5f6:23d2:e6f7 with SMTP id
 4fb4d7f45d1cf-5f91947a7e3mr2480874a12.32.1746121160783; Thu, 01 May 2025
 10:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <CABgObfa-ViHvve=oqV-Y88ghXGkevu1wTug=+24E4dKuG54c3Q@mail.gmail.com>
 <CAJSP0QVpxQDfuBOQiMyP41ufaJ=56Xh2sRhWSON=FvVuxDabaw@mail.gmail.com>
 <aBOYZsfT0retojQf@redhat.com>
 <CABgObfa9O6V00H9Z7iawvUZWvXqQkj2XsdXejPW0tjXb_a7Erg@mail.gmail.com>
 <aBOh0eMEaVsR5py_@redhat.com>
In-Reply-To: <aBOh0eMEaVsR5py_@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 1 May 2025 13:39:08 -0400
X-Gm-Features: ATxdqUGJzhtFl_9DhtHSQzvpgFrIxuUUtIdkbZ8hy8z1hoThfPW7OVRKfwP7JJs
Message-ID: <CAJSP0QUHHuVD7is_D4bgDdKLpagvuYAHx0ATHLJ3TOJiOZh3iQ@mail.gmail.com>
Subject: Re: OSUOSL in trouble
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Hajnoczi,
 Stefan" <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, May 1, 2025 at 12:31=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, May 01, 2025 at 06:20:50PM +0200, Paolo Bonzini wrote:
> > Il gio 1 mag 2025, 17:51 Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
ha
> > scritto:
> >
> > > > Paolo, please let me know how I can help with migrating VMs or sett=
ing
> > > up a
> > > > CI Kubernetes cluster on Amazon.
> > >
> >
> > Since in the past Camilla did it but I am not sure if she has bandwidth=
,
> > let's run it with Red Hat first. All I did was give her admin privilege=
s on
> > Azure.
> >
> > In the meanwhile I will start migrating the VMs.
> >
> > Please ensure the any new CI machines for gitlab have persistent cache
> > > enabled. Our functional test jobs are still downloading images on eve=
ry
> > > run due to lack of configured cache, which makes them unreliable when
> > > sites have transient outages, as well as making jobs slower.
> > >
> >
> > Thanks for the suggestion=E2=80=94just to be clear do the Azure runners=
 have that?
>
> I'm unclear - what I can say is that whatever runners are currently
> being used always appear to start with an empty cache, as in the log:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/9853814057
>
> We see countless messages
>
>   Downloading http://ftpmirror.your.org/pub/misc/ftp.software.ibm.com/rs6=
000/firmware/7020-40p/P12H0456.IMG to /builds/qemu-project/qemu/functional-=
cache/download/d957f79c73f760d1455d2286fcd901ed6d06167320eb73511b478a939be2=
5b3f...
>
> and in both the restore/save of cache gitlab reports:
>
>    "No URL provided, cache will not be uploaded to shared cache server.
>     Cache will be stored only locally. "
>
> which makes me think, if there is a cache, then it is local to the
> build env and getting thrown away at the end of the job

AFAIK gitlab-runner supports two types of caching: object storage (S3)
or a file system mount.

When the new cluster is created in AWS we will have the ability to try
S3 object storage. I think that is easier to manage than ReadWriteMany
file system volumes in Kubernetes, since that would require NFS or
another solution.

Stefan

