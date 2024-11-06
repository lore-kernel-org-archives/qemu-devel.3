Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30ABD59F7F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 23:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8pmS-0005ea-92; Wed, 06 Nov 2024 18:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t8pmR-0005eR-5m
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 18:49:43 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t8pmP-0005sL-JX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 18:49:42 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5ec1ee25504so205936eaf.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 15:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730936979; x=1731541779; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIqlVMB3ERhBoUOIG531Q0z1PNBOBJU6cndRrwXGyr4=;
 b=NExqdFsc4CBpI2hyH/HVke1+YEo4VZqfyraxjDw0wnxdBPcNl+1c1UYvjO/LJNuEve
 KGDYGkAvlF4Zhwe7jHUW+HLEVhoJsXNFRRvGF9bES+JJVHy82hrqHAepKxDvbfRhj09i
 m/pKO6YgPY/Gf6n9vODTS9Nlu+B/+3KA19cJwuqk0RiT0HEtL2AXUybZLm9qliH/LxZ7
 mZ6yX7anMToIW2INl3/Ktn8Orjvaaa+sbxwnTPyTqZrmS3oHrOpyk6r77i8H7TMwkTqr
 7PJ+dMXc4/G+ELEENIMWSiuzQf2YHIVi8pHe91waJNLMdTMg4ybfzme5OMR76McF+Gt+
 +Dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730936979; x=1731541779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIqlVMB3ERhBoUOIG531Q0z1PNBOBJU6cndRrwXGyr4=;
 b=ogcsjUJjWfzsM4r3XPtRUS8Prs/lLUPxO3vDrsRx65Qu7yAaiu3dRCI727mH4OtLSz
 ftylubeM+0sMQP3a8oFmJ8KRr8Lhoy8u3fOTnEGZ08kzAf9FkKFX1ZNBxwEgQTEFZTM5
 /o3EdWgJ6r/TMABNyzf8fRu/7SrSxz0iADYfIwSvaU47WRX9LEHnXv3juxdZRBcydnso
 CyjxZkBLDpaTOeBl+ICqvVYNkUFYTWdorFxLcKd5Ti3XRs945xJXcGfTllpAcDwG6GXN
 fwZLt3ztiv+KPRYPoNs8IXG1so+alpAIrYH+GLsD8oFdViB+/r7XL3sfI1Dds+BDqxPz
 KdfQ==
X-Gm-Message-State: AOJu0Yyk7QtYo7oPk7d6HdXXGCpzTofglIcU4ZIitIcT46F+ZDs60t55
 z9kdvKeFSJ1ROhhQbhnLHQraSPlvf2oS5jCGYDnVXXvnSfrAEvwKojf8Sddx5ohLqKSMb2aG/tW
 cSFCQWZiBx+q2PALqx3fHnM0iD+c=
X-Google-Smtp-Source: AGHT+IEA72859Y7nH/SnI9VTPWg5GxZ7UyVej+RLiZtX7nAc0L4kBdOEl7kIFd3rj4nt0WrpyHPD23CY9z8jfZwEJGk=
X-Received: by 2002:a05:6820:1352:b0:5e7:cb2e:e01c with SMTP id
 006d021491bc7-5ee4a1b5b76mr124484eaf.7.1730936979602; Wed, 06 Nov 2024
 15:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <20241030141037.375897-1-goldstein.w.n@gmail.com>
 <000c9ef8-c610-4f2a-b191-04b84455d89c@linaro.org>
 <CAFUsyfKkmSid=LVTbG+WHZA_=MAGdf+TU5vGtNE1GGx8WDheOQ@mail.gmail.com>
 <CAFUsyfKfM-X_qGN4Dy8DhES7zRi66s6yVZ3+_KmNM4f2GhBG+Q@mail.gmail.com>
 <f21fe153-6239-4c93-bf60-994976a9dbea@linaro.org>
 <CAFUsyfLhPkSMrm50RAAvir2-WoRS4_jbtZf1WWR_WZvm=BOr6g@mail.gmail.com>
 <e63cd5f6-8387-4c39-98e4-5e1c180934bc@linaro.org>
 <CAFUsyf+8sJLX+qqzPEj1E1QPQpoP4n56uU5U9aksq8JEx_52gA@mail.gmail.com>
 <CAFUsyf+xVXamR+5gtu62vFXjYScrJu0Arvhk62QXYa359UCHsg@mail.gmail.com>
 <d23ea679-9c21-44da-86cf-ae97d0214b86@linaro.org>
 <CAFUsyfL=QfvtMb6TiWVa2cEyeYQobh_3zfYpnPEb7bq6FH1k1A@mail.gmail.com>
In-Reply-To: <CAFUsyfL=QfvtMb6TiWVa2cEyeYQobh_3zfYpnPEb7bq6FH1k1A@mail.gmail.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Wed, 6 Nov 2024 17:49:28 -0600
Message-ID: <CAFUsyf+OjfFVJ80ZwL8SovH80nTA4qpNyr2Nh7uUW90jZifSGQ@mail.gmail.com>
Subject: Re: linux-user: Add option to run `execve`d programs through QEMU
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oo1-xc33.google.com
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

On Wed, Nov 6, 2024 at 3:30=E2=80=AFPM Noah Goldstein <goldstein.w.n@gmail.=
com> wrote:
>
> On Wed, Nov 6, 2024 at 3:10=E2=80=AFPM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 11/6/24 18:13, Noah Goldstein wrote:
> > > Question about impl regarding handling of `-execfd` with/without a pr=
ogram name.
> > >
> > > 1) `-execfd` + program name ie: `qemu -execfd <some_fd> ls -a`.
> > > 2) `-execfd` without program name i.e: `qemu -execfd <some_fd> -a`.
> > >
> > > Do you want to allow both of these? If you want to allow (1), what sh=
ould
> > > we use for `argv[0]`/`exec_path`. The program pass ("ls") or
> > > `readlink(<some_fd>)`?
> >
> > The canonical response is, examine the kernel source.
> > We're not implementing this in a vacuum, you're replicating execveat(2)=
.
> >
> > I suspect the answer is (1), to be compared with
> >
> >      syscall(__NR_execveat, some_fd, "", &["ls", "-a"], env, AT_EMPTY_P=
ATH);
>
> Err, I think the reference for '-execfd' is `fexecve`:
> https://man7.org/linux/man-pages/man3/fexecve.3.html
>
> Which doesn't take a path. So I guess we just interpret the "ls" as
> argv[0] but not
> as "exec_path".

One more point, what should the behavior be if we have
AT_EXECFD from binfmt-misc?
> >
> >
> > r~

