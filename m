Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AFDCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGaby-0001ot-4c; Tue, 13 Oct 2026 07:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xGabw-0001oe-8R
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:24:00 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xGabu-0003i4-IN
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:24:00 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-354ba08cfd1so4848197eec.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 04:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791890636; cv=none;
 d=google.com; s=arc-20260327;
 b=NmB2+C3DynFCGgCuCAeAvgdydaLaJjLS3cGDOfEEW/0EHe4IAvTVNmArze9XZpoynu
 RS39GlJ7yFwGXWfNB+VmbdoYWdDQ2OpVRAubBtVj+OnxO+YFrMdgPOFNxZ/JwUq7mI6z
 3qydg/uJt9/StY638Jar8YuOH0+3r0HsmtDtIXNCHPTE2v+2+94LB5/UhbyU/+KxxSPU
 jjoomSoMNg+5a/Eih8+5S1b1O65yZJbNvuXac+p3UwYdJprjmax3CxOYB5/ybOd9ud5n
 rq0nSerW5ddvUsd0EScXJUVYkZ/JtOWc4XWOGX7PxjFbuhErY8+4euFaVv78X01iohwy
 CovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BufrqWRb4slvxGvLDbrhG49c8xwobDsW2brD3My6Cg0=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=bndeSWLhZWJ4ddlavApvfgpPtXPNeiA4chRgYvNv/nAZwvBRWOxF4H70dHe7TUAoPb
 3VIAeGZSxhlEjEA8s/GV+iurmcPQT6iYCxSyF1vXpIoD2wqghZwUhPJwSGcLotyWdVl6
 uAukNQIirf9/APtX8E8X1U8wxCL581ABOoBjhC4CKqSGNNlAPOlD6jvXAXPx8Mljcxiv
 4Mj5UoPt8JKyISLXiTRqSriLNQWc9gQpWERN2WzhlRcz9cStkfBBtCCOcqndVmdsXmj0
 nyYiEUQfxNGank2VjwlVklRcBM0PcKZBxafUzRd6i/XCdHdf2E6no0x0qxBjy/PrQivy
 gm+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791890636; x=1792495436; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BufrqWRb4slvxGvLDbrhG49c8xwobDsW2brD3My6Cg0=;
 b=epwGA3Em0mjnbsbQ9v/OG4B1vRm5xrnxVbPFEd/MpJWVxD7icjGm50b4dbme7EzXR1
 MTq5oe+nbUDeXcsrf6ORoLwEN/c5QL7jewB7AWepVc/5PUob1jCYY0RrCw5fXvk9JJCL
 /i7bdn5ImNJ36eorP/peXfgflPu4xCUUiIzvvwq9WSzZDLckRTnLBMz/1H0F9sv3hvag
 DkR59w8pyZxdW2hjv4mrKMD1WAiBvWhHCoioq1zkTv1g8K7ihuvXJJVpanv/xs8DX4mz
 IJkYwGjpMnlB5BgMajCiUiR+Rbj2wjBl8wPfOdODE8SUKJ4gLzesnj7NXxmNzexT7/wS
 i4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791890636; x=1792495436;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BufrqWRb4slvxGvLDbrhG49c8xwobDsW2brD3My6Cg0=;
 b=qcW3ltqJAc2pPyTAaJX8kVMoeUWasQmxixcrXZc01Z722bLkA6QlfJNq1sEOAjByF8
 va012YMxAGzqSEYG6o5YiPiFVSiYiggkvfgw4LO+tMFTZLU+9p1aTHsCvdPdZBLMa+s5
 qy50SZiEwkyNh8HII/pXRnZcj1/F9BJnpIWlr3eI8r6PkvPONkWsw7wngO9y3SJk78oh
 IpzN5+4zVV7noGLQd+HEFjCbCU9NOArum+UCONb260qal2QjMY7qRDOUa7iKtupyKMeI
 UGts/B1ztswSeDOhYxHmg1xrWJ5F4TlAKJht9wnpJk7t7QtT/Q62LufP7+/mSUf1CGwb
 a19g==
X-Gm-Message-State: AFq9FYLQd1Z6TKVZGcQYErgtxa629SCVmvYMpXAWtZCVyh9A86Nqrcwl
 pTbzaKyWRKLdX5EFwbL1OnynZFGEmP4tbbNOucsJPlduBygeXdR6c5Bowty6MZ9IWixHziBU28G
 il8bLCyqlxw3IJNiPWoyZI/4yHIxE0Pw=
X-Gm-Gg: AYBFou3QZwKLC25Az6PuZwsg5FYHHP2ItvIw8OA1UooTFZGpq1Id0lKDFDlvVOhoLT/
 ufRuQ6pDz2DHJQCMPASJ73hlgmZ6hJAo2hmrHDQ01OPi1/G+UbZ7N8nRnR4oZ/3QNSobYsAg00k
 la3EnNYYIRGpoFZaic1d6x5bmTf9R/pokl30OARrnz6sjGE1kNvOsR2bzFNftCz6fUHJWB8CC2p
 dhDxXZGQRSVjkoJ95GuvHjwLDw9gBUm5J4H3Q9w0D96xjXBXFK6dZ7r3V9MJdHYNChWpbcSrwP9
 84ZcvBAujv54I+adTF7FdYfCeq0/vE0kGrc86Sx5hH+9ybnt1znKHIdpWc1/lQMv505enyHB146
 I/xTUpm8l//w2
X-Received: by 2002:a05:7300:b106:b0:34e:f948:d7da with SMTP id
 5a478bee46e88-3537e0ce190mr28473600eec.21.1791890636191; Tue, 13 Oct 2026
 04:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20261012142447.446500-1-berrange@redhat.com>
In-Reply-To: <20261012142447.446500-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Oct 2026 15:23:41 +0400
X-Gm-Features: AclHuK94HJM7FXME8IxNmYl_tp8ZOO-tAF4eu0u0iHbO4fixSdoxfoCe3_8oTqI
Message-ID: <CAJ+F1CJdw-BSL_zYk7cb2fqWK2CCBnYYtttmSOx69mPv_DkRVA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: drop redundant match for clone() flags == 0
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1331.google.com
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

Hi

On Mon, Oct 12, 2026 at 6:25=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> We have seccomp matches for clone() which mandate the presence of
> several flags, in order to permit pthreads_create:
>
>   REQUIRE_CLONE_FLAG(CLONE_VM);
>   REQUIRE_CLONE_FLAG(CLONE_FS);
>   ...
>
> Given those mandatory matches, it is impossible for flags =3D=3D 0 to
> pass the filter. This is fortunate, since the explicit match on
> flags =3D=3D 0 is in fact broken, as it has a silent size extension
> from 32-bits to 64-bits.
>
> This results in seccomp generating psuedo code of:

pseudo

other than that:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
>     if ($arch =3D=3D 3221225534)
>       # filter for syscall "clone" (56) [priority: 65531]
>       if ($syscall =3D=3D 56)
>         if ($a0.hi32 & 0xffffffff =3D=3D 0)
>           if ($a0.lo32 & 0xffffff00 =3D=3D 0)
>             action ERRNO(1);
>       # default action
>       action ALLOW;
>     # invalid architecture action
>     action KILL;
>
> Since the clone() flag is passed as a 32-bit value in the syscall,
> the high 32-bits are liable to be undefined/uninitialized garbage
>
> The desired match for flags =3D=3D 0 was
>
>     if ($arch =3D=3D 3221225534)
>       # filter for syscall "clone" (56) [priority: 65532]
>       if ($syscall =3D=3D 56)
>         if ($a0.hi32 & 0x00000000 =3D=3D 0)
>           if ($a0.lo32 & 0xffffff00 =3D=3D 0)
>             action ERRNO(1);
>       # default action
>       action ALLOW;
>     # invalid architecture action
>     action KILL;
>
> That is redundant, however, as can be seen if we look at the
> (fixed) program with the CLONE_THREAD rule also present:
>
>     if ($arch =3D=3D 3221225534)
>       # filter for syscall "clone" (56) [priority: 65532]
>       if ($syscall =3D=3D 56)
>         if ($a0.hi32 & 0x00000000 =3D=3D 0)
>           if ($a0.lo32 & 0xffffff00 =3D=3D 0)
>             action ERRNO(1);
>           if ($a0.lo32 & 0x00010000 =3D=3D 0)
>             action ERRNO(1);
>       # default action
>       action ALLOW;
>     # invalid architecture action
>     action KILL;
>
> That "($a0.lo32 & 0x00010000 =3D=3D 0)" match will catch the case
> of flags =3D=3D 0 and do the right thing.
>
> Reported-by: Ricardo Branco (https://gitlab.com/ricardobranco777)
> Related: https://gitlab.com/qemu-project/qemu/-/work_items/4671
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  system/qemu-seccomp.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
> index 3889d48b4f2..8f8f8d3cf00 100644
> --- a/system/qemu-seccomp.c
> +++ b/system/qemu-seccomp.c
> @@ -76,13 +76,6 @@ const struct scmp_arg_cmp sched_setscheduler_arg[] =3D=
 {
>      { SCMP_SYS(clone),                  QEMU_SECCOMP_SET_SPAWN, \
>        ARRAY_SIZE(clone_arg ## flag), clone_arg ## flag, SCMP_ACT_ERRNO(E=
PERM) }
>
> -/* If no CLONE_* flags are set, except CSIGNAL, deny */
> -const struct scmp_arg_cmp clone_arg_none[] =3D {
> -    { .arg =3D CLONE_FLAGS_ARG,
> -      .op =3D SCMP_CMP_MASKED_EQ,
> -      .datum_a =3D ~(CSIGNAL), .datum_b =3D 0 }
> -};
> -
>  /*
>   * pthread_create should always set all of these.
>   */
> @@ -219,8 +212,6 @@ static const struct QemuSeccompSyscall denylist[] =3D=
 {
>        0, NULL, SCMP_ACT_ERRNO(EPERM) },
>      { SCMP_SYS(execve),                 QEMU_SECCOMP_SET_SPAWN,
>        0, NULL, SCMP_ACT_ERRNO(EPERM) },
> -    { SCMP_SYS(clone),                  QEMU_SECCOMP_SET_SPAWN,
> -      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) =
},
>      RULE_CLONE_FLAG(CLONE_VM),
>      RULE_CLONE_FLAG(CLONE_FS),
>      RULE_CLONE_FLAG(CLONE_FILES),
> --
> 2.56.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

