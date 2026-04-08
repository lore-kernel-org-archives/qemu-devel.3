Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB0910F9976
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYIg-0006om-Uw; Wed, 08 Apr 2026 15:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wAYGd-00045s-AC
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wALjt-0001x7-7m
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 01:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775627167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFNkEP5BzDcOaqmyGBoa7zkOfHlSi/JUCPP1i64IMBM=;
 b=FJvjAIDeP7vWJGxA4RoiY2DnEGUBbk3Ca4rYGkUurLmkQvEqyHGccxT+Vx9EM88cwqfIox
 M0Q7B9ok+yNbarFqNM9xt5+xbGvmgpzuAJE0Je617AJtuAEa6OKqbVH1qU3bzL1C5Wf/6J
 MNq+lO0VT1O47MtH7sqYDSmPP5Hn90s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-4n4zb91CNTGIFG_WUejJ7A-1; Wed, 08 Apr 2026 01:46:06 -0400
X-MC-Unique: 4n4zb91CNTGIFG_WUejJ7A-1
X-Mimecast-MFC-AGG-ID: 4n4zb91CNTGIFG_WUejJ7A_1775627165
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35da8eb0553so694014a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 22:46:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775627165; cv=none;
 d=google.com; s=arc-20240605;
 b=ReLluKGnqHgiJU2nlVNcM07oPCkrsuG9Z9sGlJH6Y2pX7EYjByE5oldNKVaSE+IRmj
 fPO4DkCH2+8HUMC/QSVDnXqhh2OlCoelBnGmsw4GsSikaxIfKEON/45f1cEdy90K9abF
 K9lXz9p2/iZWXTqAxy/Fs4UCS/6srxWpgb9k62jYslCaK324kQ3UlWQa2KTz1VyVPd5D
 3Zd7LgHM2VoHdhf1ZLZnacy3CSrX+XoYD63ho04auwy1Pr4EhvCVf6v6grW2GPVpsj6S
 rAY1zsNmvgbzKdvst54ppSjs20EoEWNI6e9kmmF0rcbLXBCnnMbgs2bJ2o7llnA1UqT4
 Pobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IFNkEP5BzDcOaqmyGBoa7zkOfHlSi/JUCPP1i64IMBM=;
 fh=J0lI+6V1e8A1yyN2nd5Guz99SJqLbGXMn75K4Y7Xiz8=;
 b=B0xByHG+3OWTK5kVvpjTvCbrPVtDtxAgosrzYuuLScxal14J5SzwZ5kS5byADS2mo8
 Me9GliUMQbFAOgMxQ5Asavj4wrAtCRIZmTGBm3JiqzU8gmHUtj8xJEs6kXskYR1nA7Li
 rl4MGBDWHk4iM1nUHnE/azqVsr8reGDpjCC95erOGoJ86CqpiaOjCpOLoKYY2x/mj6HY
 bP21j/qsKnlx66mq1Nd+50pjyoDXnhv26RV3S7Umrgfd3OXrK4ZrP4UJdG/N7L5nsy4L
 z0yE4cTkRVg+gu1vchxVetVGsPTy7GAmjDl+ItMhaM2zr1Nj0B8Lky1lhDbLkLoGy1xp
 fM6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775627165; x=1776231965; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFNkEP5BzDcOaqmyGBoa7zkOfHlSi/JUCPP1i64IMBM=;
 b=YoDbHP83u3hMwCdwLptyCchtiOh977Ce/GDPB8OHr62gmbbp/3mqdYvybJaafoXZ5l
 M765yW7VN/9X6VPgVMprfs9BkgsQ2nYTGcDUK92bxD9hXvWWPj+AXaIIkXrDM/HAUewq
 a1KEji6Jhvb5SMcXcZ0IDBU3bSqfh55HMPdHHp1pmf16JmkCwgrQNF2rN5XxQ4+VMb16
 NAYwTt1qdOAFZQ7ncAL9UfDT8rGdISRfUhWR4sgw0ek3A6dulHINif0XUOU5094MGZTY
 NDx1VrjemvA7v/PBJyAAqr9+kkduFKKAD6iF5/e/hPnjFkWeJCOHyYFd7CIuHSmM5FDO
 emlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775627165; x=1776231965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IFNkEP5BzDcOaqmyGBoa7zkOfHlSi/JUCPP1i64IMBM=;
 b=EepEij7ymD/OxyBvGzYX88xmKJNEUmgeEcNOlk4v87nxklU4w23akceSQxruZ1WHy5
 j0C4FK6CGQsaHEv4ZsCa50Qj1VDNzJ2QIBXBSU7ZwLX2krdiJisHwgat4CkTM9D0nRuW
 FC5sHNYl360KpLkk4lf8NwweuXQ/3TERNkGVw2zw0GacH7O/g7eRVQXlYUYVoNpATQdd
 MYEW5ndIv1BeRoqE6NY6wMCVrbhs2wyANd5pefwc5eVjER3cZlS6G5ml9vybnxniqZZS
 Gma9z4oDRx8SXe5wMzhAAkCfYZcf/To0tXu+0oAtp6j//cVnJrilzcYNxigkkeUKByuw
 eYCQ==
X-Gm-Message-State: AOJu0YzDOXf8U3ZJI5Lf2w6v93XI6rY1i4r+saygvHi31Mmlhi3srRKu
 bmlHIfBijZiiQEDBJnu4IbtQc4y+r++jKr7Bt7b9+At1mkfYWZa6iEhHIRyDm8jZR2mi9liVD3o
 IHQ7XTUZpyXEJFl5wvrQtDiHNy5eFlmDsRvWysYmujhmyBHQyVppvsepk/K+R+D2Ce7DR1B9Gn9
 0m1k4U50U+i+kBZ12JYdYdcvgIZiIETnNGitHbwr2+ug==
X-Gm-Gg: AeBDietKnf5KrD+l9Iqfofz/Cx8flt570zpEPVA+ipG1gyZNbk//9Uv6X9y66vQRZj2
 CUfY4cMEI8W2bOTbrofmb6m53xLdpsxI4R8WrsX900oGq4twhvAgWKDi+2Ewkzp7GGG2fHNXUFC
 tctd2ytqJ1h8xC9mSD8+2TMDacgXZ31Lq+HSmxLvwLRNz23lQhynF6zvWTe5bUAygtbUyZq7bIv
 E6X9j2lE3O412RPL7daO+kR3ufADoTG3xKUCOvfdLMxt6u7FNTBzyrC+IDCC0vU13ok7rliOgaa
 agqjdS6esLWGsSK6wFOIWbw=
X-Received: by 2002:a17:90b:2e46:b0:359:8957:7285 with SMTP id
 98e67ed59e1d1-35de591e9bcmr15823205a91.3.1775627164698; 
 Tue, 07 Apr 2026 22:46:04 -0700 (PDT)
X-Received: by 2002:a17:90b:2e46:b0:359:8957:7285 with SMTP id
 98e67ed59e1d1-35de591e9bcmr15823192a91.3.1775627164176; Tue, 07 Apr 2026
 22:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260408024024.606222-1-zhaoguohan@kylinos.cn>
In-Reply-To: <20260408024024.606222-1-zhaoguohan@kylinos.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 8 Apr 2026 09:45:52 +0400
X-Gm-Features: AQROBzBAfaJnSjz0t7e_WGb3WIbvNkhtl9Me_XvBc2J1BUVdLVmCeqC1gxeyyfQ
Message-ID: <CAMxuvazNT5bawngQbd8KvWvk7renjB2Zg-cfkxNxR=CTVZpW5Q@mail.gmail.com>
Subject: Re: [PATCH] ui/input-linux: close evdev fd when qemu_set_blocking
 fails
To: zhaoguohan@kylinos.cn
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 8, 2026 at 6:41=E2=80=AFAM <zhaoguohan@kylinos.cn> wrote:
>
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>
> input_linux_complete() opens the evdev node before switching it to
> non-blocking mode. If qemu_set_blocking() fails, the function returns
> without closing the file descriptor.
>
> The finalize path only closes initialized devices, so this leaks the fd
> on an error path.
>
> Jump to err_close when qemu_set_blocking() fails so the descriptor is
> released before returning.
>
> Fixes: c7b1172026a0 ("ui: replace qemu_set_nonblock()")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/input-linux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/input-linux.c b/ui/input-linux.c
> index c16726a3b799..74bc8511428a 100644
> --- a/ui/input-linux.c
> +++ b/ui/input-linux.c
> @@ -316,7 +316,7 @@ static void input_linux_complete(UserCreatable *uc, E=
rror **errp)
>          return;
>      }
>      if (!qemu_set_blocking(il->fd, false, errp)) {
> -        return;
> +        goto err_close;
>      }
>
>      rc =3D ioctl(il->fd, EVIOCGVERSION, &ver);
> --
> 2.43.0
>


