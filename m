Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B25F8809B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDGtG-0004Oa-Ma; Thu, 16 Apr 2026 03:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wDGtE-0004O7-CC
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 03:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wDGtB-0000td-5y
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 03:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776323507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZ/T6GX2E5UZY8hVaSvcfGYVhoYfCP9I1IIWjM5tQYo=;
 b=BonkCZaJUnuPKFaF7/AUBCBJp8DeQUlIMDwMakJLuU6vUrS3zQNr6qR3bV2E7BvDLNbws0
 e4fNc466zF4jRPlG/iK4nwXDuHpg4wHl6xHiqlFgIQ3oXnl2zAvKKXTWfBndQN+f+txFht
 CeEaswLY+9iHdNXC/Xn102Yun1oU6aI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-dXF9Et4PM1CbBl3PdDnP6Q-1; Thu, 16 Apr 2026 03:11:45 -0400
X-MC-Unique: dXF9Et4PM1CbBl3PdDnP6Q-1
X-Mimecast-MFC-AGG-ID: dXF9Et4PM1CbBl3PdDnP6Q_1776323504
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f3eaf4b9aso2232821b3a.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 00:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776323504; cv=none;
 d=google.com; s=arc-20240605;
 b=LjpBoWRionBMTjZTKf37tV0xSoODr0iL1ovz8GbMGjQbnAyu7iGitAtUMm02daa07P
 AKLebBhuqU0vG9JP8r9wVr4BrdIaSShc7YswMbTIDQhl4+G4Qmx5GWyCOrFU2Ccsbj2s
 Wc7IwX2CGZrJIYMM/FnVTdsOyQY8miSBVna0LPFYbeG+UAWYqEHWVRRAPoGJHMPkObZW
 SOI/qD60U7Gt1iavtlt9MBbTOF0wQUKibOyURlhVUHaXnJ9MfapB764JjErcmb9db9Qa
 bDYEOeTERZNCrXoWk/T5U9JYxorpl0HUOHK1USzG+M5Ve5DGkj8c0toaXZj+OvS5D9yL
 Wm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fZ/T6GX2E5UZY8hVaSvcfGYVhoYfCP9I1IIWjM5tQYo=;
 fh=ckKiQtaduSoU7Do81eCOdreQ45xLs6uc450ueGmOpCM=;
 b=Wmwie3v97jIPPueQpe1oepPwxf1LXdv01yY9Bq+wO10PjX2femZEpi+0g4GfwIpYBE
 Du+bSMlXv6/ALhq08Aa0i/ndxEOFvMlEUFMbg1QyUE0fR7slGx8MwixTndJME1uLCnDv
 TqmYx5ZI13cVKirWO80yXVy3TqyhaABh7ShGHBNRILj5TvfLsN8ZYATkqL3P9PAL0e+1
 Y8hdzkSyr0W+vbKg2GorXx8/3g3aft9DC/vwTjResWm2D6T172lLSq4cC1jRWPrRCXNM
 XPN837Wtjuoj0toxGQSiFJFXHZiOf14qsc5FmBWXrKIFZnMkE5GuMdvI8u16XQi7xbuI
 5HsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776323504; x=1776928304; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZ/T6GX2E5UZY8hVaSvcfGYVhoYfCP9I1IIWjM5tQYo=;
 b=SrCKpFeRbgSc698uyqrMvfsBvEkq08weyzrUEjQaaZSRpZBVPxCi54f7AKob343/+n
 fcE1dnOiAC+nGWe184xVr9g9oVWs8lMD9tVI524z5wEXxPBwMC//e1tUxhSKY9vdub+s
 V9mNqfi9RR8y+DAhrEnd9Jwz6P39W8hkR7lLmrltFE0PklTWYkZFYul+2feKUTzNFbyV
 7c7fVSZVaP0gBPtRfCn7ZXK98ASlEulcf+/7UInUbJL/9a42a4Chx2ukA89keYS7IrRc
 uRblDPzd+4T6eEy402Jihc14XVxBRNd439JHznDVnM9i3eWhDzEaGmXnGpv6TrLu8hNe
 XmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776323504; x=1776928304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fZ/T6GX2E5UZY8hVaSvcfGYVhoYfCP9I1IIWjM5tQYo=;
 b=GqpIa3XzQ+nivybnTYWWcYnOE7wqX7SouLViWvOTfzbbuEcZKvbruBGTKn4JBgvIVZ
 UpfbV9WN2e1egkE8kOoVHQZ+k0T5v7SJEhERx/bstUSjVTSOfbChbLTZCONGX0neKpVL
 xJN6hBNTOpfq+Q+ZsDhOUGnDWpO4kVdxU9zTZrImfrYvxIlfA9GeYKpy254vUCeQhwph
 YXAq9lFdEuw79xaWKTSa7lwLB8NE7SYQw5AWB9S6E5kOpPrhxLzqbj8L4or0tP6SwbF5
 fM2m9TSFZ4MxCRHk369e7x6uzoX3fOgR9OxEHeAjpWquJBZ/gSF9eJ8VmeZxGRSEoaEM
 EWGA==
X-Gm-Message-State: AOJu0YxfZx26ckCsl9mcI1vV7fgUBnE3cR2ZGeSyVe8dUvSKYEdf0F1H
 XMPVT8W4CiXae/rcWTZ7dTO8ufMaj/nNYaGAHQ+PpNQe7qlP1912+FHLp64fQ+MxeQ7etIz8qt1
 jpgv2co7sgpHApwtLcTF5xhRma5yBdVmDp4IbKWaA7Qqwpw49wEnjmepztffNNt4pqbEKDqXCKt
 fCtPTJAcdB2dDUYKlzL8gTWBsEr/fNN4Ixf6PBKetJ1g==
X-Gm-Gg: AeBDiesiqh7t9/re1/CSeSWs2y/YEruUbuNEXKhk5pD3zfyQY3vDeNpfDlWQNVVYUeu
 o8u+G3ui/GokbOa6qsUSr9xWasRXKnfMZXrtvWpuY5pGIJnt7qX/DjDZNHWKQ0H/3hG3OCGcnv4
 CajhIw1REZhwRCf6Hsi/TWDNFQxQiHNYyVDUJBY9LRz1qzRhPgfD6c5g6+p3NScncoGd60hSQEY
 p9EjK4QMEglvgkRRIqWMXZVv9Y/hX7z6wS1F5rq3tI1SJ43Hbb17yLrAOQIw3iuzddweT8jZdDj
 docQjm8G4iZZPbwnO/AORiE/Mxsn0l2Mm20=
X-Received: by 2002:a05:6a00:2d81:b0:82f:6b94:99d6 with SMTP id
 d2e1a72fcca58-82f6b94e569mr4690632b3a.5.1776323503683; 
 Thu, 16 Apr 2026 00:11:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d81:b0:82f:6b94:99d6 with SMTP id
 d2e1a72fcca58-82f6b94e569mr4690599b3a.5.1776323503117; Thu, 16 Apr 2026
 00:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260416070403.1683648-1-zhaoguohan@kylinos.cn>
In-Reply-To: <20260416070403.1683648-1-zhaoguohan@kylinos.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Apr 2026 11:11:30 +0400
X-Gm-Features: AQROBzCDbU1y7rhr7hDvN7PzWpxziO8nXWKptecsYI6haiDSTQZDcipAeXAUgqA
Message-ID: <CAMxuvaw3unyhdOMPgSvRFjbOapjuNmBj4wgpczaLn8wyjD-UPA@mail.gmail.com>
Subject: Re: [PATCH] ui/clipboard: clear deferred serial reset flag on resume
To: GuoHan Zhao <zhaoguohan@kylinos.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Apr 16, 2026 at 11:04=E2=80=AFAM GuoHan Zhao <zhaoguohan@kylinos.cn=
> wrote:
>
> cb_reset_serial_on_resume defers a clipboard serial reset until the
> machine runs again. qemu_clipboard_change_state() performs that reset
> on resume, but leaves the flag set.
>
> As a result, every later transition back to RUNNING triggers another
> QEMU_CLIPBOARD_RESET_SERIAL notification even when no reset is pending.
> That causes unnecessary reset handling in clipboard backends such as
> vdagent and dbus.
>
> Clear the deferred flag before resetting so the reset is performed only
> once for each deferred request.
>
> Fixes: c967ff606b99 ("ui/clipboard: delay clipboard update when not runni=
ng")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/clipboard.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/ui/clipboard.c b/ui/clipboard.c
> index ec00a0b8ec75..e3d8a31ba9f7 100644
> --- a/ui/clipboard.c
> +++ b/ui/clipboard.c
> @@ -47,6 +47,7 @@ static void qemu_clipboard_change_state(void *opaque, b=
ool running, RunState sta
>      }
>
>      if (cb_reset_serial_on_resume) {
> +        cb_reset_serial_on_resume =3D false;
>          qemu_clipboard_reset_serial();
>      }
>
> --
> 2.43.0
>


