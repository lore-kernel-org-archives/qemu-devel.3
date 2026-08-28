Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D28C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzq4c-0007BQ-Ab; Fri, 28 Aug 2026 02:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wzq4a-0007BF-0o
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:28:20 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wzq4Y-0003sd-JE
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:28:19 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so73067366b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 23:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787898495; cv=none;
 d=google.com; s=arc-20260327;
 b=QXKx+06E4dHsKlTlRant+hTzxraEXLgs8PQ8bj95BhKGZTBNLTpQLJbhq77uEK0a07
 gClrnjOZY7DiS4enwHFjvhfbgU7cpEHtIN9rN+BOSEmNSJQCLDcOpXAKzxz2wAVR99G/
 yY8S8ZdbNMnQCB22uHy/PxhGvN7KHtHcLih0qKhekP1CWqqYdZDob0eZogzn/ddVlWMU
 9XObusxtLVfUECfKTeUUIRLXcFUH0g2xaPpOXyXux13OXM06tOGOA4+OdDqekRpiaACf
 Xsb1eS0lPWl0GbXj2TjgvfsYFCeJQy7HpQtkQWymwgHbQKa2SUdZgkdGHAzY9TP9BCB0
 ixpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uRQok1yz5stDDqyfic1hgU3qeB2gVzS3I1bNJHV2TAg=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=fYLOLugfUW/xU9bZwIU2q0j9jwiCDV8gtwyqg+Z7Ujzb+plYlUV+enIkdKxd7BSFUs
 lJIPIdr76RxK+bPDF5iH6Bmpz+8CuwEX8gKDtrtSP1BPIzKZeZ/KXJN87Fi3KDCb8gA3
 hQ5HEUaCA/rcVDEbfPQp9UNfZ/khXicEiuDhtzlK5O2B9kOxNmZ94aODQ2GggTHxq8SG
 JEBfKmzHG546IvYEoMl3usCoIWGyDJPvC22Zf5FDR0DgbfBPLhADgJ4rK8sisD31JxYb
 Ye5WZ/R//cUlgC0aUiOVZTC4mIYE6+4cnXAbw834gFQN2LZumnQvfsPeb2fGVbyCKyAK
 a+kA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787898495; x=1788503295; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uRQok1yz5stDDqyfic1hgU3qeB2gVzS3I1bNJHV2TAg=;
 b=c9HpsWNLZDUbi8MZPR0vJpq9c566Eo02S+ce7XdUgwctuMXyPAvF4H7jd69kqHJUHK
 TBWqlE04cTkUEc9CmMdg0OOpSSJNDxzHo0GQxMm3VKgVJNMmfiXnh5p6bfoW/ogSpYYF
 T48ZPL00ASIQNrSalfde7c72PsJte7ZS43AUfudvcvSjsWzfTf8PzFc0oNibCy56dJwS
 BJF1bb2TeuVY+6JCARHE7L7Z0cwSxvd4JTBMuVCO5pBMrRF7F78yRIvc35n39Sz3IK/r
 DqJ13s296YFG9wcqGFg+0Mnehtqfj8y2w4CXW13WamLs+yKy7fU03Y21IO8leLmCZysW
 BXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787898495; x=1788503295;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uRQok1yz5stDDqyfic1hgU3qeB2gVzS3I1bNJHV2TAg=;
 b=WIc/OFeTlVm8auaBfg8cUNhDmqlLJ2WMKD6NtCsoEQSfDNUJ4FKc6VChufNgTL/vOr
 wQdz+/J/54rVM/GCMSXT6kXNyVLbA5qwfOAjOzLjdnUeOb5vOXfkaffNWCYh7iCdW6EU
 ysZ6PiFbl6VhwcMCSDqlX9AdE/bc3zIdvIpurwrhdoswo93ywp0iY4XvDz9+/4mA9KpS
 7xKbek9qTb8kP7DdopUQ0UwqpL9hBzuoKgNDksJCUNGwU4VhYSe+/YX2fgYimMTXM0H8
 7knFwiA4VNdbrCbNLj/RJYGPBOs/Vt1TSenJDF6PP1q7PGVJOKtJAsy3uMVvmwDRsafY
 2rCg==
X-Gm-Message-State: AFuF++lmW9G6YIZDvbzidSbJOHqpMkAE1orVlt5YrqNo6jxI4SXIS2+/
 IhK0fG/u59uM17pW/V/HIBz8yzllNlqE0sBR0PEILMcUUHlOv66jQqmYFBgBGGNJj3GNIkIg8sr
 2g0FMzcjfI04LlXABGubfr/u9t+GX3jw=
X-Gm-Gg: AR+sD13x4Sfj3H3qRxNp3Bl4fhEUy2lDVDewKOjzcnu62uNIGBJSHb2Xiw8mx8euHka
 TyoG5Wyhvvi0gJ01jCYZ6x3AqM1x1kwMKpNkxf7oaIBMHAJzmEoNqRKn8nStfyoqRjbj86et0y5
 eTQuassEcq+D/3Zi25rIgkrymXDZ0CA/ANkUrcPcmJQDsl5V4nu9S6evVwrtBDupnM6J2bfeGUA
 3q43NctJPNQK0UKM4WfCxF7BSns0I77pj3mUofZx7GfdZYNZjUeRBq6moYS0mjHEnW3332yP/J6
 h0HYXEGjSCJ9yZVS2FhgiSPVnGfgQsMyNvKqPSEO5aG0vg==
X-Received: by 2002:a17:907:ea91:b0:c16:6a42:c7d6 with SMTP id
 a640c23a62f3a-c2556fe5799mr280410966b.9.1787898495089; Thu, 27 Aug 2026
 23:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260822213343.661939-1-zhangckid@gmail.com>
 <20260822213343.661939-7-zhangckid@gmail.com>
 <87zeyaobjj.fsf@pond.sub.org>
In-Reply-To: <87zeyaobjj.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 28 Aug 2026 14:27:34 +0800
X-Gm-Features: AcwNN1U1IXOtES4l-Z83AR6ifZzC1Y4NIt5m1-tI0AXXjB36wElYMQK4sbK2xyo
Message-ID: <CAK3tnv+G81CntgqX+6By2JYfGcM5+m18mdAaDO+hoHXu=JwO7A@mail.gmail.com>
Subject: Re: [PATCH V13 06/15] monitor: track IOThread users with QOM paths
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x634.google.com
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

On Tue, Aug 25, 2026 at 4:21=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Monitors that require an IOThread share the internal mon_iothread.
> > Account for each monitor explicitly in IOThread holder tracking, using
> > the monitor's canonical QOM path to distinguish holders.
> >
> > Acquire the shared monitor IOThread AioContext once, using the monitor
> > QOM path as the holder, and reuse the stored context for later
> > operations.
> >
> > Release the holder from the Monitor ObjectClass::unparent callback,
> > while the canonical QOM path is still available. This covers every
> > object_unparent() path and avoids duplicating the cleanup in
> > monitor_cleanup() and monitor_qmp_prepare_delete().
> >
> > The internal mon_iothread remains hidden from query-iothreads, as befor=
e.
>
> Let's add
>
>   Management applications therefore cannot use it to determine which
>   monitors are using the IOThread.
>
> You add tracking anyway for consistency, I guess.  Correct?

Correct. The monitor holders are not visible to management applications
because mon_iothread is under the internal object root.

I'll add the suggested limitation in the next version.

Thanks
Chen

>
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>

