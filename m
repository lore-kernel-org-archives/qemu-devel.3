Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E68D31A2B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 09:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfwj5-0000Pu-NK; Wed, 14 Jan 2026 03:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vfwir-0000Jn-1H
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:59:25 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vfwip-0000WJ-MA
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:59:24 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-50145cede6eso8419621cf.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 00:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768381162; x=1768985962; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PIxEOaxTpJlKyp2vfZLiHD7IM8kMyFAzW9noQALN9YU=;
 b=RW4CQZ4IVWiUPumAlGjsy1lLmsjJNjyqV+V5fEV3Y2R+gtpgrt1tu6Mj+yiM6X8rvE
 xJzV50taB46DI1v0nQgzne1R+xeX1/x8mUu/P5qFjWwQt7jcFUUTv0gUl72Khu7tSlZr
 rRWxRFiWOQXr/5O1P+GoOo+zif5ixqMKvFUuMxuYbCe1S0LK2AoSBaTRfz9sTAN0wpsj
 JugYw7n404hcKYmORpIxWIJhNpQUxhxa56HaBNHEQ4A7ipr2Cu4BS3t7Ini2G3MLV+Cx
 8Wf56n7tWCK2QLxsxl+IXJzuPvOY2siC+FwAdUEzSrOu5X6LpshV37SOsJXeS2RS3Bev
 S5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768381162; x=1768985962;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PIxEOaxTpJlKyp2vfZLiHD7IM8kMyFAzW9noQALN9YU=;
 b=NLEtb4yHHEAe/UaJbTxoyEfJyiu/eh6UeZuqgN4DwtZ3An0p7w5xQaJEE5slQAt3QV
 uf8Iioo6iA/1MIlCULYQxXd5cCzPNakZAQyuJo06h2mc8iTkBkKviBqDP2NbEcA6ntGo
 K7gOlasfAxrpXb1nHU65aae/YimL+9sh0+Qq+DX8MTCNtatQsAQkt3TI4Xar9IqW2dkr
 MvrltU23Ut8GBjNkPgCYCWOJEOWY0wbLYBL0RV59RvAa6MGLK8tQQbsos4Zyj25JMB9U
 yZgcv8WX7smoIiyH5BhukPJSZtbLb0v0jPVS+cz0FdcSzwdnKqvSZDyII5mLTw9DIcRY
 vquQ==
X-Gm-Message-State: AOJu0Yy2OOqZHAcYDp+2ANFz4YaEmxoGNg+jQquYVQa2cyzJCRDHjcOo
 W0GmTb1MxYsDh8z9Mp3BdX8aEOSUEK67vDzskxOHS1QEgqtkqdw/w6q5dIL9aj81Y+goBt9BGMe
 f9qzziqAVRBJy9v7GyQYH4/Sk/GSq8Ht4LiM9
X-Gm-Gg: AY/fxX6gxd+R7ILzoCZGt5GX6DbgasuGfKJIsZSm9n0FTSTaenURKuFnoiRyjlDomUI
 TbFCH1MwpydYxbbyHXKY8j6Xq3KrzukT7dEUtpk5bokRRGQQWXC+xRl++6v+lAYu0/zeYG/WmJz
 CuvJdhFjHWMB7oWJW8nPplK3Ude4OXsOBN08R6tgLRP6R9bIb3MUCR4zXMI070/kU0jjpym0jHV
 Hvji/9j6jMqeFHIAafVidaj2WcddumU987Rf9MPdiFEppqwlM8zr+jt2rDBHPKgUD33+OoILAWC
 ZCCdrB7HAXXxiXxXfGiOrov/MM7MszfcG+JsVg==
X-Received: by 2002:ac8:590c:0:b0:4e8:b288:7b6a with SMTP id
 d75a77b69052e-501484b13c2mr20912621cf.82.1768381162025; Wed, 14 Jan 2026
 00:59:22 -0800 (PST)
MIME-Version: 1.0
References: <20260114083828.1305139-1-pbonzini@redhat.com>
In-Reply-To: <20260114083828.1305139-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 14 Jan 2026 12:59:10 +0400
X-Gm-Features: AZwV_QhRlRD66JWTrgZJQG6zeAEAXgxIu28Tzc0CSA4ZBzru4bRq8dXuSm9CNGQ
Message-ID: <CAJ+F1CL1=6=gZ3ouu=VAXyGFrOy2Ww1-VAG2RFarJee_E2_hGw@mail.gmail.com>
Subject: Re: [PATCH] rust: trace: libc does not have syslog on windows
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jan 14, 2026 at 12:51=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>         This is not enough for the msys2-64bit job to pass, but it
>         reaches linking.

same here :)

>
>  rust/trace/src/lib.rs | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/rust/trace/src/lib.rs b/rust/trace/src/lib.rs
> index c2abe430a52..143513891ac 100644
> --- a/rust/trace/src/lib.rs
> +++ b/rust/trace/src/lib.rs
> @@ -3,9 +3,11 @@
>  //! This crate provides macros that aid in using QEMU's tracepoint
>  //! functionality.
>
> +#[cfg(not(windows))]
>  #[doc(hidden)]
>  /// Re-exported item to avoid adding libc as a dependency everywhere.
>  pub use libc::{syslog, LOG_INFO};
> +
>  #[doc(hidden)]
>  /// Re-exported item to avoid adding probe as a dependency everywhere.
>  pub use probe::probe;
> --
> 2.52.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

