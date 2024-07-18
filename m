Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38307C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 15:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUTWU-00023e-GP; Thu, 18 Jul 2024 11:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUTWT-00021e-3c
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:58:25 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUTWR-0001UY-7o
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:58:24 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-595856e2336so1643320a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721318301; x=1721923101; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BicxdVjzUdVqK2d1Ak7i2HMnuV4H14w3G5YWcCqGOA4=;
 b=vyYrLwc6PnlDHmQDDA3avp4mIvrtmUM15q/Yp4ZFm/muC2NtdvssUOe6MHl3kKaUsq
 3a5IEvML6QBUgVEPXW9GGOxODRmn8JD5zWdGHUAJaugG1kCYw2Y+nnyimFWy2DWdHoXO
 KWgi7KlboKDMT5BJIVb51FDXWDxKdo1d8yNolIL0nnplgYkM+7p9hoaHLQzOFocMfL9d
 KopfdhjqxgWY56W0Gcs/E8VwVlq/IxXyXXmM6yy7hzdbDDJSwdVQdJFwixmFfY1aNYRC
 g/ZPLmhtCHPFFS2ZnLZMQbleqGBGnrmosO4fhpoETw97huaO91GPLKsQAYLcHbZZh3nx
 nPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721318301; x=1721923101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BicxdVjzUdVqK2d1Ak7i2HMnuV4H14w3G5YWcCqGOA4=;
 b=J9m2vQPt56k2DWFvGrk7MOJJjpis7p+U5y8G5fzQHDSI/1At7RXu4Kz9Z1rkVBKKZY
 go3hGn4tr9WRMLZ3g7co5X86eZ3WEE0cYZmoRhF0q24z6WTisyxwz9CIQgnGBFHuhRua
 FsOPF7qoO5BtxwnFV3OEIegrve9Q5rpHAsAcTX81VdbUChWbLWCPjptmy3MNYKfDA3wi
 PU7DWePGFn1S+IxdWTD8nTkbbhBl4k1cT0HE7DUMpPS+7RERZBoM2azGhtnOPoiva9h/
 u1CoOst43TLkFqQ0W/e/FRFheFyDeByg7oBKQgYp+yixpP5GXvBa8MeJ5RmAn6TId1uz
 tBmw==
X-Gm-Message-State: AOJu0YyjDjBUqyujrMReo+fPfWLb4PHTsUU4PoW2hzYf3+3gk/TnqBzR
 GtpXLcLyAHcc3DGF3ow4V8+zrZ0Ut+n1xcifRrOTKW45iwsFZBWHkbLxT5CJsyOM/+pXVZY/+4z
 4e4YbPzKyhLsfICB3DB3kWyKv9JOR5aXwBF9lTw==
X-Google-Smtp-Source: AGHT+IHvhgK4ZfCSRQLbTxMlLHZunR7F7ydP/EJ0rWdmOaPyNGJ/RopDZOwbj23hEg8mWmF6CNbTKdLqUu/oH5UoFdQ=
X-Received: by 2002:a05:6402:27c7:b0:58c:36e:51bf with SMTP id
 4fb4d7f45d1cf-5a1557cd64bmr3503020a12.3.1721318301492; Thu, 18 Jul 2024
 08:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111029.1726329-1-kraxel@redhat.com>
In-Reply-To: <20240530111029.1726329-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2024 16:58:10 +0100
Message-ID: <CAFEAcA8ShMnj43QwhKZxPvqQ9ei3s6LBGgXHQwRvpKf98dvuBA@mail.gmail.com>
Subject: Re: [PATCH v2] vnc: increase max display size
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 30 May 2024 at 12:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> It's 2024.  4k display resolutions are a thing these days.
> Raise width and height limits of the qemu vnc server.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1596
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/vnc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ui/vnc.h b/ui/vnc.h
> index 4521dc88f792..e5fa2efa3e5d 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -81,8 +81,8 @@ typedef void VncSendHextileTile(VncState *vs,
>
>  /* VNC_MAX_WIDTH must be a multiple of VNC_DIRTY_PIXELS_PER_BIT. */
>
> -#define VNC_MAX_WIDTH ROUND_UP(2560, VNC_DIRTY_PIXELS_PER_BIT)
> -#define VNC_MAX_HEIGHT 2048
> +#define VNC_MAX_WIDTH ROUND_UP(5120, VNC_DIRTY_PIXELS_PER_BIT)
> +#define VNC_MAX_HEIGHT 2160
>
>  /* VNC_DIRTY_BITS is the number of bits in the dirty bitmap. */
>  #define VNC_DIRTY_BITS (VNC_MAX_WIDTH / VNC_DIRTY_PIXELS_PER_BIT)

Hi -- somebody on IRC pointed out that this simple patch
had been code-reviewed by Daniel but never made it into git.
Marc-Andr=C3=A9: you're listed maintainer for ui/ -- do you have
a pullreq planned?

Alternatively we could take it via qemu-trivial since it's
a pretty tiny patch (cc'd).

thanks
-- PMM

