Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B9ACFD2F6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 00:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNKbg-0000Ln-3h; Sun, 23 Nov 2025 19:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vNKbe-0000L6-Nr
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 19:39:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vNKbd-0005pX-3u
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 19:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763944740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o0HtlU2Iwr54CHUz15ndK+vrg+kM74qYx4P9dTPMiA4=;
 b=GImncDKESb9jFh3PjVKr1XwOZIzyPxbNVjTFev1KXWJ/koJqlFtYXB4EF2HoZEAioeZfHf
 2wHCW4VXjTxfCBj0RvKBcyAXAKtIyz1WSbYpPigQ/tOnvxOLuZlQawXHs7iCZoHcvKAhz4
 KfKE74WRmVVNS5i0Ri/Tpvf2GuGT9hA=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-8FzHQy31NrW81nxsXUJdEQ-1; Sun, 23 Nov 2025 19:38:58 -0500
X-MC-Unique: 8FzHQy31NrW81nxsXUJdEQ-1
X-Mimecast-MFC-AGG-ID: 8FzHQy31NrW81nxsXUJdEQ_1763944738
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-5dbcf848bc9so2091763137.1
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 16:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763944737; x=1764549537; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0HtlU2Iwr54CHUz15ndK+vrg+kM74qYx4P9dTPMiA4=;
 b=J/gCU1yUVaFjkYvtiSZAFaxtsUYxr118rzqllJXvmnjlUhh2gK8m3C1vf1aqHKAwxX
 9HBAT1ciewk+lfPT430suVmFoalLHtu2ruUuQuNlSaknsJBjRYVrMrSC7gWcNpvb+B97
 T7X7XQQmrhbGbF56IBphBjgWVAEgigZSTq/xIUMVk+ZnRoOj60PTOkzFw81+xOs9dOFq
 rypgNGGiha6NBIxnx7ognW1Pw8JjouTzbJrYQBhKXZ+f5tYfMyteTDlG7cg+WZfM4Lky
 2se0oZDFyyPCj1n1/Bd4xEsYl9KbY9xlKYRz10y13/jW0VFgjUeu19bO6jXMCSHbhvJv
 oFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763944737; x=1764549537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o0HtlU2Iwr54CHUz15ndK+vrg+kM74qYx4P9dTPMiA4=;
 b=PGcxuOsGcyb8IzOwpeO+voLde8qqi6b0ylr3By+ykBa2r5WAknB21lbfRqqTg/pWHO
 c3DweJ3T/XpyhKAm6vmXlCGzOzRcHifsk3pzoHcST1sdEWdtzcNtl8JveRQyhZUeVWpb
 hG0I9K65HuDRXltx2IT+XylTn9PfyAcDDGFO91R+VJJKGGECSVa/wcUgrhqGKFYE435b
 vCkHHZJ/G7YbmxC4NL32duXT2xdDhnmfiDqZLKpgTwBm+pNSb92OUSy2YLJh/HPneFgr
 CyrjBl1WTO09OA6JcFzAwQoFG/Z1WRNTZuVT2zD/VjW8ZhkBoCSGMhN1ItTlcozRYSvV
 iN5w==
X-Gm-Message-State: AOJu0YzJdzH0m3/g179j2mJsYSBVSNJpyjKvzwixcFLn5mABA//3H3cB
 y2Q/o0tcqIy7WMmUj3HcniE1OVLRL+GzX2sddoRnVGbgIOZxXzqdywTh/Tlzfib3WhihkXFF1T4
 j2e8tuPdDrCxjEUOMpbrYWz2HQ49oM2qX5ewtW7+6JVf9YaKGYX39uGYWMYZ02bpY34sCFDgKh3
 O4yudZ9eH2ksednknEthKBOD2l20c5GB0viNHU96Q=
X-Gm-Gg: ASbGncuZ4ATa6+D9o8NKVxJ3Zze4o/RaL+4/9LvwR6S/xtR2KWVHXfsAQQ+wcKbuhud
 5Pefxi2ilz8eJ6t7YG5Bd7aMIEEj3Aci2VedkPmOv1h6zN6zCq9bxUZyXD6VhEqH5Z4mXxvOR4b
 xZUmyPZXI5gWTw4KFozKVBy8iwcMoXfzUomPV68vadUXgT4YexV0M+EMmHH3Ps4swutL8=
X-Received: by 2002:a05:6102:3906:b0:5df:bb10:631e with SMTP id
 ada2fe7eead31-5e1de4bc6bcmr3035668137.41.1763944737112; 
 Sun, 23 Nov 2025 16:38:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkFDuiT3JsxS9Ig6XfEUG6jAFxmtoLJc1WRezRFHYzMtiHneTS08GKdA0rPMoURPNveho9PZ1qsLgilFe+PxA=
X-Received: by 2002:a05:6102:3906:b0:5df:bb10:631e with SMTP id
 ada2fe7eead31-5e1de4bc6bcmr3035664137.41.1763944736663; Sun, 23 Nov 2025
 16:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20251114034806.2440-1-jasowang@redhat.com>
 <CACGkMEvmuwGC_U3wW51v=qyuvU8qt5R-xx-jf5OR8gB8Fc3XOA@mail.gmail.com>
 <CAFEAcA_x==cvj39sds5R+QSUKi5fyc-fJ3AbEv3_zGJkeo4FvA@mail.gmail.com>
In-Reply-To: <CAFEAcA_x==cvj39sds5R+QSUKi5fyc-fJ3AbEv3_zGJkeo4FvA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Nov 2025 08:38:44 +0800
X-Gm-Features: AWmQ_bnCseWZAQoQ2cD_6P66uPvOazJHqB305gD9IH7-LfTJxWHqmQN_JL4j70s
Message-ID: <CACGkMEtUaWwCz4Hczst3+zxbEypUaeE0GXr-xbdV9LZJ1G8Reg@mail.gmail.com>
Subject: Re: [PULL 0/5] Net patches
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 21, 2025 at 8:28=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 21 Nov 2025 at 04:03, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Fri, Nov 14, 2025 at 11:48=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > The following changes since commit 9febfa94b69b7146582c48a868bd2330ac=
45037f:
> > >
> > >   Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into stag=
ing (2025-11-12 11:47:42 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://github.com/jasowang/qemu.git tags/net-pull-request
> > >
> > > for you to fetch changes up to a01344d9d78089e9e585faaeb19afccff2050a=
bf:
> > >
> > >   net: pad packets to minimum length in qemu_receive_packet() (2025-1=
1-14 09:59:55 +0800)
> >
> > Ping.
>
> This was merged as commit 409be85c2f5422 a week ago ?

Indeed.

>
> (Richard replied with the usual "applied, thanks" message but it looks
> like that went to the list and wasn't cc'd to you.)
>
> -- PMM
>

Exactly.

Thanks


