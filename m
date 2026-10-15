Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673EDCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJwV-0001LX-4C; Thu, 15 Oct 2026 07:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xHJwT-0001Kz-R6
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xHJwS-0008Jl-0G
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792064890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQYWaJ3ltKnsv5ketcAMGqoDmq18SlYBgMfhH4DDlCM=;
 b=Cbms2P2N3C02HyAMtVVn/SY9EE8NJD4qy9AqGvsyyP0YWyzqrzVtGADsFrKI/DV1vkmUjF
 +th3OD8ZTCASH7zEn8RBy9Pl50C3RRvdEmAlgyfQDm8VLwhUUhNKfL7ab7FkiaelAAbSv3
 cTt6dvgmh5YJZYMhkxFShmwNQduK2ZA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-qggnvROMNm2rc5s01Mublg-1; Thu, 15 Oct 2026 11:48:03 +0000
X-MC-Unique: qggnvROMNm2rc5s01Mublg-1
X-Mimecast-MFC-AGG-ID: qggnvROMNm2rc5s01Mublg_1792064882
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a8ae5154e7so6879311a91.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 04:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792064882; cv=none;
 d=google.com; s=arc-20260327;
 b=MxDdI5R5QJmu2jr0YqfkMPaqrpVRGkzdzKHIzPvL6VnI193TuJ9dKpQDwRf/YA5SGI
 370VVaXKqzpoLXkb/fJTJlQx5PvMgvZRafjmzQlFtAnFr4OyC883fFQ7Flcpo79fCBsP
 jcBjJnI6QvIeFS08kKiMnuMmXRLgEJvXjRQ5Z3dF7Diq4GGhFSf+Eh4BDBenJeNr/RGI
 V/tCkAhWFTtWPRPJCPGf1OmRHPgJRwZb1aFBq7IKPYorIU+A18fq4bjARudA7fdQdQgH
 n5/Zbm85LXD4CgybBptntaxgwOVyuYFcxcStbjOnr8/yXE07NwqTP6TGVDcHOVsOB3dt
 MLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rQYWaJ3ltKnsv5ketcAMGqoDmq18SlYBgMfhH4DDlCM=;
 fh=xA1wct/nOgeBHWCzYRJBLu4P8v7ZQAHhSAY551Q5jBo=;
 b=Cjt+BnwDSd6OPrm8/HtWVmeg06+Dea1Vv8KcbHE9ZYjgFC82jYSXgFNvLZJzGKV66+
 SWQ4cGeekLtMHOmk+G9nAr8MDrQxceDK/kr8GX32+qZZl87jr+bJ7K1oyqICDAS3eAp1
 kodxEVM2iiSweLQiuWTQALc3EZ/rZbmDka79Cnx4vtfzgQEHAbMA7aFka6h5kAz0rIEd
 oBPeZhiQ8Yob5Bt/ssxtrsbppx0VnEnWpxq0TKbXeux47JSXZj37GgfzLIhb7O3tz2Jt
 vOcOz5+A/Dt/Je5Yec0YMnXKbVroak248OazHf9WGEC0V9rd1b76Yi/auJ0Nu3e4gdEd
 c8Rw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792064882; x=1792669682; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rQYWaJ3ltKnsv5ketcAMGqoDmq18SlYBgMfhH4DDlCM=;
 b=oy++0clXwypkQO86XTSpp0zOpBmMqIpYIGvglwO64LNzhsWQfQ6CEnss5rE/6RqKst
 n/5ymeV1Qxp2lb+b72n8NNgiGyAVf3CX96QQjxLR684eWVRq/0nFlHIRqe9+ce2rG8E5
 4ciYYIugxgh2onaXbtol7V8IduBxx91C1rwusIY8+wSa1Z0VFQ7Y9e9oLDEyzX3luPQD
 SIH3SugciMI0QNeWrhw4o1ZLkLsQkVlLSa2X6M6dLRuR242MxYodLBY9txHAZ2JYrAsA
 2+zDdAFrbOZ+FdDlZUKVPJD99UcFzLx1hcZxppbJZJw6fkHSeVqTlId3IHSZwXmaiK3U
 0hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792064882; x=1792669682;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rQYWaJ3ltKnsv5ketcAMGqoDmq18SlYBgMfhH4DDlCM=;
 b=v3ZrM19ZaTpEPfBc2rGvU4BT+xCOaWfyWQQgrXAZF2NTk/0ytgkErJJomJjhPsi9/t
 bc2bMjlFoA1wYNWQ0BL0fSgoU4imANTyaNy6ZMTHVwaC8oK0hW1EdyebkBCdSlyOPmsU
 PHyAdNcathKwQhAHbDplPFPEIoseysSlLe8jJZR/l316jGMIV/nh6oKOCemmgaA+55RB
 WGWPqxoGkscLxk9+e9sZkh7bt9gcXeJlCZ7ZLcF0yqLpDRHOeHBBVE+Wdh2OV9EaUnPP
 Of4YGJvwr1RR4BbOQgbJiuVdCtWLTzzVez+BuwrIv7vnS2yeEkf4FHQ0bs55cWLHpeYz
 65uQ==
X-Gm-Message-State: AFq9FYIBVVVaxDoWFR0xQ05+GqJyDLN2Kf8o9G6wDtbCe0BNSajQ4eLo
 /RGb9atYF/ymMa80Jr0a7weWJzL+RJGg/QrbCzruUeYhC/t72ZozDt6Wa4CktgsaWhnWJ1/R6NC
 za/60uKLEmn6ksobVZGi+QB8XAvnAHWQB7CfNr0NdwVO/dk+kluxnhj4OzjXbHT0iTMi6xWaua8
 Dy62YbcC9ITKyUO9PwP35EnuYQ9400VcY=
X-Gm-Gg: AYBFou1s/GlEQ/D1zbOMyEyWm0g7qsrwC+gF+fdAeWKvrJ+gL4i93pp5J+QOsQxgVvt
 tfxDAwca3SVBX1/GvJXOrsXPn42uSWsBfB9Qz9pEgRdelqqS2Bux2+RKRY0WhThXiMfX205tmju
 vILG/+paTJZLxLeFYOzXjvSWVjRmODQF4kYAwiQq3dhgsiaouop2E8uMM+zU6Jj4vEFk0evidyQ
 pUEr27kd26/f4hNNYZjGahqt1Y6vsohpsCDbpGzpaQb8mYWgbmM8A1CsMs7qhTbQ/nPiYMgoRgB
 7g==
X-Received: by 2002:a17:90b:224e:b0:3a0:ace4:d2b4 with SMTP id
 98e67ed59e1d1-3ab3a9f42aamr13870563a91.23.1792064881735; 
 Thu, 15 Oct 2026 04:48:01 -0700 (PDT)
X-Received: by 2002:a17:90b:224e:b0:3a0:ace4:d2b4 with SMTP id
 98e67ed59e1d1-3ab3a9f42aamr13870535a91.23.1792064881220; Thu, 15 Oct 2026
 04:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-fix-stdio-close-v2-0-0f01e6580e24@gmail.com>
 <20261015-fix-stdio-close-v2-1-0f01e6580e24@gmail.com>
In-Reply-To: <20261015-fix-stdio-close-v2-1-0f01e6580e24@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 15 Oct 2026 15:47:49 +0400
X-Gm-Features: AclHuK-Wg0yqph92F_tCXRydnxJoJ9Nz3ZqPQLN4PnDybo6CKhhKw6ACs0Z0dHM
Message-ID: <CAMxuvazvSsh9OXafHgh0jK0u+ky8LMnbc+-yVTUk1xfT9hiNjA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] char-stdio: avoid closing stdio fds
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Thu, Oct 15, 2026 at 5:59=E2=80=AFAM Filip Hejsek <filip.hejsek@gmail.co=
m> wrote:
>
> Use a duplicate of stdin and stdout fds to avoid closing the standard
> descriptors when the stdio chardev is destroyed.
>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-stdio.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
> index fe1cbb2d88..19860e960d 100644
> --- a/chardev/char-stdio.c
> +++ b/chardev/char-stdio.c
> @@ -89,6 +89,7 @@ static bool stdio_chr_open(Chardev *chr, ChardevBackend=
 *backend, Error **errp)
>  {
>      ChardevStdio *opts =3D backend->u.stdio.data;
>      struct sigaction act;
> +    int fd_in, fd_out;
>
>      if (is_daemonized()) {
>          error_setg(errp, "cannot use stdio with -daemonize");
> @@ -108,7 +109,20 @@ static bool stdio_chr_open(Chardev *chr, ChardevBack=
end *backend, Error **errp)
>          return false;
>      }
>
> -    if (!qemu_chr_open_fd(chr, 0, 1, errp)) {
> +    fd_in =3D qemu_dup(0);
> +    if (fd_in < 0) {
> +        error_setg_errno(errp, errno, "Failed to dup stdin fd");
> +        return false;
> +    }
> +    fd_out =3D qemu_dup(1);
> +    if (fd_out < 0) {
> +        error_setg_errno(errp, errno, "Failed to dup stdout fd");
> +        qemu_close(fd_in);
> +        return false;
> +    }
> +    if (!qemu_chr_open_fd(chr, fd_in, fd_out, errp)) {
> +        qemu_close(fd_in);
> +        qemu_close(fd_out);
>          return false;
>      }
>
>
> --
> 2.56.0
>


