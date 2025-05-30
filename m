Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B051C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 06:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtPN-0007YO-N5; Fri, 30 May 2025 02:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uKtPL-0007Xg-U8
 for qemu-devel@nongnu.org; Fri, 30 May 2025 02:39:59 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uKtPJ-0002Lw-OL
 for qemu-devel@nongnu.org; Fri, 30 May 2025 02:39:59 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7406c6dd2b1so2300818b3a.0
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 23:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748587195; x=1749191995; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mLJgGsHYlC9EzJXe4GvyxSYR5mGvu8elhlUzRVWhsZ8=;
 b=H/A7eocoaE7qRR5lmssZAiyNcMjwyPoCk00U1Mo8GXvWmgraoXvHpB2c30qDM2QI44
 LdwvmcWpvcvxk5N9dAxg81Kv+3J8kqRCfsDnwSXPp92HmnNZrIvaoP9PtYOcmv7B32bu
 d9k0GKW/d9FJf1LL1VmGw/iYQZT144QNX0EBoPtAnmbzVVewVxKd3W5pYt72B20Cp4KO
 HwDyLLYAU7RkQEzqUdRD3NR9yMGxY/THaJe27U4ltdDyqFRhakDYK9lGpbwun4jlHfpx
 IUZNqMkf04WEBokqvY8wejhrJmXbwghucXjz66C1BhwmAmqnVzoPrVi0ARE9Z/XZrKCT
 BIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748587195; x=1749191995;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mLJgGsHYlC9EzJXe4GvyxSYR5mGvu8elhlUzRVWhsZ8=;
 b=Q+OBQgtoIrwiRc72Qqug/V6Ar91SJZe+8Mzfcmx5+vjx591z39Px/OEcqqw0KtRAX6
 GbsSTYojgXwiHG0DC3jtOXMAcOKkr+Q0C5guwQ5XLqbROg5buEgmkPqRSLmv5qXpRJbq
 hstjL1DP8AxcozXaMz19nI0FNvRAdELRPtrYNdQX54z4Yf9N8SfI46hysZ/t4HTmCI11
 klNfRvyZEzIVhEZV4UlAgrYLJb5AfOtDsu/6m9Pto2Nk7b1/Oa2zH8JyNtMq5gwNNvAN
 V6q2m2+d8VNGK3k5aF5wr9rK9IUdI5t8kwCqJgraTimrK6XBmgnvrhDpu816xs0u66nM
 FWNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+XHelbJ79CpwxgAeYgsY/413ALDoCji0KK/6UB9YhaSzo8XKHqVo7UE/nbcZusGyBhNoO3u+XSaLD@nongnu.org
X-Gm-Message-State: AOJu0YzSbCsFcMIrnAgbwPszDM9HxL1lvkrJrFglMYfnoBzXgQr+9uYl
 D9pmlX8ORRUtRxhi9v43ToAz4m/mhx1xYromVjIQv1AAjPD39VsiEaDG
X-Gm-Gg: ASbGncsuRnSJeOjKFxJuoupsaS0Fbt2nFRBRm7v1HU1y+pmcF+FRruhJeQfF7hdkv9U
 4SPrTd/dRwNIv33EhwlVFdp96+sfCIwrMGb6s6/rC0AOSOZRDD3sxpYJcYg08Rujyplu/kIUtdj
 vD3hUz1QN3aT3CExzN92BJiGIP02QEe0S0Ax8itP6b2vwgQ1xzxiOH8FbqLkIN7/QDxrjnJ19IV
 b6K18m3seCU2INnmBzYLhSZgImoVJqonN4B2klPnTirNebKIcfvpzvMph+xe1vGpDEKXtBE6L2o
 64stjxAhaGpDlwhCenHB3LZio0Y9PfRrp/rAit+LMpUeNSw9UWXR6CCteeWaQU4=
X-Google-Smtp-Source: AGHT+IGmOXFwoepu/pbzBqeJZUwpvBSCTKkIXPBHov+l2efKKxR+9WAwidKlHu/qBk49+gVdNdUVeA==
X-Received: by 2002:a05:6a21:7116:b0:1ee:5fae:8f6a with SMTP id
 adf61e73a8af0-21ac5ad4e92mr10704662637.1.1748587195414; 
 Thu, 29 May 2025 23:39:55 -0700 (PDT)
Received: from [10.239.152.184] ([134.134.139.75])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2eceb29b20sm801894a12.30.2025.05.29.23.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 23:39:54 -0700 (PDT)
Message-ID: <0790819eab97fbc5728f583b6ec90e338c2819e0.camel@gmail.com>
Subject: Re: [PATCH 0/9] ui: Improve scale handling
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=	
 <alex.bennee@linaro.org>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dongwon Kim <dongwon.kim@intel.com>
Date: Fri, 30 May 2025 14:39:50 +0800
In-Reply-To: <19542757-ecc0-4eb5-b26c-4a06f7f800c3@tls.msk.ru>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
 <19542757-ecc0-4eb5-b26c-4a06f7f800c3@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x432.google.com
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

Hi Michael,

On Thu, 2025-05-29 at 10:23 +0300, Michael Tokarev wrote:
> On 11.05.2025 10:33, Weifeng Liu wrote:
> > Hi all,
> >=20
> > Now we have quite a lot of display backends for different use
> > cases.
> > Even in the context of gtk, we have various implementations (e.g.,
> > gl=3Don
> > vs gl=3Doff, X11 vs Wayland). However, behaviors to users are not
> > aligned
> > across the backends, especially in the part of scale handling. This
> > patch set attempts to improve scale handling.
> >=20
> > We have to deal with various coordinates due to the existence of
> > scaling
> > in different level. Firstly, in desktop level, we could have a
> > global
> > window scale factor. Secondly, users might set a zooming factor to
> > adjust the size of guest content in scan-out level. Consequently,
> > 1) the
> > buffer from guest, 2) the host window and 3) OpenGl drawing area
> > inside
> > the host window are in distinct coordinates. It's important to
> > define
> > these coordinates and scales unambiguously and use a consistent
> > naming
> > convention for variables representing different concepts. The first
> > patch in this set tries to achieve this goal by adding a document
> > in
> > gtk.c, and the next patch (PATCH 2) attempts to align the code with
> > the
> > document.
> >=20
> > PATCH 3 - 5 fix bugs in mouse position calculation due to not
> > handling
> > scale properly, for both gtk and sdl.
> >=20
> > PATCH 6 align scale update logic in gtk-egl with other
> > implementations.
> >=20
> > PATCH 7 fix an issue that gtk window might keep enlarging/shrinking
> > because
> > ui info propagating to guest not considering scale.
> >=20
> > PATCH 8 and 9 align fixed-scale mode behavior in gtk-gl-area and
> > gtk-egl with
> > other implementations by adding appropriate padding to the window
> > to preserve
> > the scale.
> ...
> > Weifeng Liu (9):
> > =C2=A0=C2=A0 ui/gtk: Document scale and coordinate handling
> > =C2=A0=C2=A0 ui/gtk: Use consistent naming for variables in different
> > coordinates
> > =C2=A0=C2=A0 gtk/ui: Introduce helper gd_update_scale
> > =C2=A0=C2=A0 ui/gtk: Update scales in fixed-scale mode when rendering G=
L area
> > =C2=A0=C2=A0 ui/sdl: Consider scaling in mouse event handling
> > =C2=A0=C2=A0 ui/gtk: Don't update scale in fixed scale mode in gtk-egl.=
c
> > =C2=A0=C2=A0 ui/gtk: Consider scaling when propagating ui info
> > =C2=A0=C2=A0 ui/gtk-gl-area: Render guest content with padding in fixed=
-scale
> > mode
> > =C2=A0=C2=A0 ui/gtk-egl: Render guest content with padding in fixed-sca=
le
> > mode
>=20
> Is there anything here which should be picked up for qemu-stable
> (current active branches: 7.2 and 10.0)?
>=20

I think the first five patches are good candidates for backporting to
the stable branches, as they only address bugs without altering
existing behavior. I was able to apply them cleanly to stable-10.0, but
porting them to 7.2 will require some additional effort. I'll send out
a new patch set once the backporting work is complete.

Best regards,
Weifeng

> Thanks,
>=20
> /mjt

