Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A040CDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcq8c-0007QU-Mi; Thu, 25 Jun 2026 15:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wcq8b-0007Ph-3M
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 15:53:25 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wcq8Z-0006aM-Bq
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 15:53:24 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-693c69b97e7so349118a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 12:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782417202; cv=none;
 d=google.com; s=arc-20260327;
 b=DTLE6VtszyJCMlG3BK+zVbHD0UowMVbZA5kpLj9HcVFeJxanh50biJipiBCOVtG9qA
 X0vO/dNUnto0Cc5PlG4aDkzbuEnZIWCkCi1SjG+7PgRNt4t+4iZ9zo5U7YshTu4qGXvR
 1fVVdR6JvQwCwNbG8bJKQAZUBNwFCTpZX80QP+arABZiHGsKxqYGSCSGbzvYI4dgfO/G
 SkgylcPLeJcrOo+x9YKt4cSfQeHskm/VQ1ifvq7VLtAFN9lEHAYKaxWX9dtwxlEVN4ly
 kvdGcNLMkgKjwtpvzOuCJFlWot6lHmWGHBZgJuG1nV7yD6Vxn3q4VYiVJgke4gz6qWcS
 t5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hQ1dbLbWR4hrX2njvx97uq4oDtup4JEVDPajJW5uXbM=;
 fh=0Jwhlc9AHdcGYRTVndGRK3EjGfvOa1nGV6BKtBQ7YfI=;
 b=W3+iaOgIGQIzR7rPnDdh/phyJms0J3j4JDOsSiRh3oW+Asjtdn0r2p1QX1/83HNVY9
 OG6Q3nISOuWwjh07qbllFSOMllf5so/bhUh/k5UCVLF5d4FYSdfD6/5msdJzKpOHLgJO
 15NqItkn4lWA20gOVQg7wLOSnLN9IYiPj+KBL3CWWpRNRAQ+rVZJyCdOp+RnU2bH+QzX
 QccJ1ss0512iP2VjNQ667aR8ZoA/AEZKHqhmKq8cca68rY9/c3xZvC0SbdGmxI9SLmoF
 nnpy/FGDh81uL5ru2wMABQ+vpJ5zCHIybTbhobH0jiC3mPadxwFeoorFLpTk0rqSryng
 fsNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782417202; x=1783022002; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQ1dbLbWR4hrX2njvx97uq4oDtup4JEVDPajJW5uXbM=;
 b=CjgRIjdIkftHgMy2vvu/JYVGkBZ+p25AxI3gaUHhVj/059n2uA/GTTDM7D3BNsQY5D
 eXfcQZBOcR0yXJ075eR8IOvb7Stb3tO6YBRhEvk51fiXBP2pmnlEQTBL1NkmoaUNb78m
 dqBN1BvZawJ0sOWdgMa4maG2U653UhJ+VarkLsOx7FfkfeOvuhhi/c496ecYLqQhYG5r
 XaVKPHg5OJEWHIfYn5sU2rdrdT39a83nKHZPIl/yXrebC+pXtFMCU0qVNw57+m0k159N
 67XzcM+3R0G7WyPq0XLXWtNz/wdMQV72FMkgelx0S5F5u1N3OuugAdsmrLJGzjLdkipM
 EWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782417202; x=1783022002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hQ1dbLbWR4hrX2njvx97uq4oDtup4JEVDPajJW5uXbM=;
 b=AuovUsF1P4fXaAzkF5Vk/r2eCIysdaHZ2aV3rHUJPIOkSIz8k0P1A2LLxt8ZHdruPJ
 thm1LuXBYqYhUkGPQqqiKmFclDCnT2n+VkyS8v7XVMqlnN3i5ArjgILGtgPUaNS2MKex
 JzCfcz2ETfZ1lIxwA4j4P/l4DGIa5SvxJU4qyKsyGYL2/r6OWnguSrpgrR17sRlaTHhg
 psKHyDCGfae/NmHoji1PsFOfA84XVLiluY18C8bo4gZQQrYUtuxZYo4l0orcpYGuvOYM
 ApiG6cvl6W88lyu336/SGKUztofwiZ1YGJk8iSN4ghVhxMfLG44WoWBMe+9Kk3TAAjbZ
 CnmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJ+PwFFADWuSkRM2I4RWREr6Suptf2lR9tHGDoHLGY93qg1b3MxmvyktYYWE1hhBazdrb78aed/iDr@nongnu.org
X-Gm-Message-State: AOJu0YxrtGxfCaH4rZ5fy63gGDkvihWjS662tU7E8V2O3VAavCDUXEmt
 92cIgE7wnSetsYvQMNIi81aj7MQFVYkfOLLL7mVQ8dHxusFgJ+nPWX7BOmr2oGj79TUIqWkPk+w
 FtVoslRVnGraaTiE496NxAptHBfCj9UQ=
X-Gm-Gg: AfdE7cko3dYX0C9MlnDwopvGqg+c3OlGZqMMNxMUJglGvDVoe2BsFtXFz9BpFkbYgst
 W21YpPquP0HXXXlm0YAL4rkG1V5KHaa30H/BjoBN+rJ+o60tFZXDwbr3A23abYCv3Z9osLNNpxY
 XHUX+dLbaP945DXyljf6ObIkv86PI3iuVKrcLvCGwDfou+Rtm8DrNPBL7f8WwtN7UsWCB2PUOEQ
 t6tMWB+oQ0kBWMnZbYRpbrmGgSzWzVu7kXNkBBZYUduliGA0IU6BUwjflyq+TpVWYPqrJ4gzwhZ
 vaE6/sNAyqyxGKChwWxhazuuivCS1fP+Vg7QxIRMPg==
X-Received: by 2002:a05:6402:13cb:b0:697:973f:cf01 with SMTP id
 4fb4d7f45d1cf-69810ae47b1mr390277a12.20.1782417201573; Thu, 25 Jun 2026
 12:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QXRy1Dc_MwqtU_gS1+jOdrW=Vk6YynP75q5HP3Rz_CpTA@mail.gmail.com>
 <904444A5-0120-4BE6-8E11-C7167F2A3BDB@unpredictable.fr>
 <D91DC576-2462-4652-9E8C-5A7C96791622@unpredictable.fr>
In-Reply-To: <D91DC576-2462-4652-9E8C-5A7C96791622@unpredictable.fr>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 25 Jun 2026 15:53:08 -0400
X-Gm-Features: AVVi8CerOeDtKLBSE0iRXCHuf-QAHRPNo3va0SkpYPmtvHVJ0oUObTv4O8R7hZc
Message-ID: <CAJSP0QWBpXN-=iu_13y3k_4z4uZJX7NPTgFH16CSBn30EYTrAg@mail.gmail.com>
Subject: Re: macOS builds broken in CI
To: Mohamed Mediouni <mohamed@unpredictable.fr>, Emmanuel Blot <eblot@meta.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
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

On Thu, Jun 25, 2026 at 3:15=E2=80=AFPM Mohamed Mediouni
<mohamed@unpredictable.fr> wrote:
>
>
>
> > On 25. Jun 2026, at 21:11, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
> >
> >
> >
> >> On 25. Jun 2026, at 20:38, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >>
> >> Hi Alex,
> >> tests/tcg/multiarch/system/Makefile.softmmu-target's
> >> run-gdbstub-interrupt seems to be broken on GitLab CI macOS runners. 5
> >> days ago it still passed, but now rerunning the pipeline on the same
> >> commit ID fails:
> >>
> >> - Good (5 days ago): https://gitlab.com/qemu-project/qemu/-/pipelines/=
2615134022
> >> - Bad (today): https://gitlab.com/qemu-project/qemu/-/pipelines/262970=
4018
> >>
> >> I've tried many CI runs with different pull requests applied on top of
> >> qemu.git/master and they fail in the same way. Maybe it's an
> >> environmental thing with the macOS runners?
> >>
> >> It's unclear where the SIGKILL (Error 137) comes from. Could it be an
> >> out-of-memory condition on macOS runners?
> >
> > Hi,
> >
> > SIGKILL is the known symptom for failure during signature verification
> > by AMFI.
> >
> > Now that we don=E2=80=99t have separate -unsigned binaries anymore but =
relying
> > on in-place ad-hoc (w/o certificate) signing with entitlements we might
> > have issues linked to that.
> >
> > In the past file modification had issues with verification tied to the
> > inode and the workaround being a reboot or a cat binary > new_binary;
> > chmod +x new_binary so that the old (now out of sync) signing state is =
lost
> >
> This is highlighted in the software update context in: https://developer.=
apple.com/documentation/security/updating-mac-software
>
> > This code is incorrect because it modifies the command-line tool=E2=80=
=99s executable file in place. macOS caches information about the code=E2=
=80=99s signature in the kernel. It doesn=E2=80=99t flush that cache when y=
ou modify the file=E2=80=99s contents. Modifying the file in place yields a=
 mismatch between the file=E2=80=99s contents and the in-kernel cache, whic=
h can cause a hard-to-reproduce code-signing crash the next time you run th=
e tool.
> > While this example uses a command-line tool to demonstrate the issue, u=
pdating any file that contains signed code might trigger this code-signing =
crash. That includes executables, frameworks, dynamic libraries, and bundle=
s.
> > To update a file that contains signed code without risking this crash, =
write the updated code to a temporary file and replace the existing file wi=
th that temporary one:
>

Nice, thanks for sharing this! Do you want to send a patch to fix this?

Stefan

