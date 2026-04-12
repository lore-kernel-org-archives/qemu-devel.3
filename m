Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C473BE937E3
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 14:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBvXE-0003Mm-S8; Sun, 12 Apr 2026 10:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wBvWy-0003Lg-1i
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 10:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wBvWv-0004mM-P0
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 10:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776003072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7nr2A/dxJETpwBr73AVTmxj6GqBvVn0+bRRJPpY9sSQ=;
 b=cgzLg9uTo0wjSpSu5L+Xqjr0xMfx1gGSMKidoc1mhA/JbuTqWiFP5bArEWbRxFmiNji+NX
 qF9WCU9IMxS3GAAeYr8g6Z8hUgzWqPs27a9ajK6HoRLOR478LlqFcSg6F1EtXWEu2j1N3h
 XEqZ3Gia8n84BELXENfrb1XtqhkgnkQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-hjB29MjOPZSdBAEaHj9Vgg-1; Sun, 12 Apr 2026 10:11:07 -0400
X-MC-Unique: hjB29MjOPZSdBAEaHj9Vgg-1
X-Mimecast-MFC-AGG-ID: hjB29MjOPZSdBAEaHj9Vgg_1776003063
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35d9278587bso3438857a91.2
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 07:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776003063; cv=none;
 d=google.com; s=arc-20240605;
 b=fQwMXVM1+CF2yO7ArnBzmVJ8Lu9suk8xgZLHtoB5XSZIP9x92cd7u8hB7eU3ZUfKOw
 PaVOnpGTlnBbWCtwD3uNmaCc9wjECoLQPnxbwoLv08lrrq7p0uMOJxKTKl02EmcnD4Rt
 mo3cFina4VvHPVxVwycQZ40aGKIT+6CVM8nzjgC16vSuDFj3QYQKye8ubbvGvD0wYncd
 CXbjcN6BSOosPgct++rQsM5Lp4q5lOu+b0ZDxr/d8xg1OzbnUCWbqD8x+J/kylPAFwuI
 j6MIEAWazaonEumoumnrvrjL5Gj/OWgPPN+b8Funyup+0YaSiYn9SDCehIYcjFFO41SU
 lZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7nr2A/dxJETpwBr73AVTmxj6GqBvVn0+bRRJPpY9sSQ=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=cCL5m8Vy75ZI3Zq9ouIHIHoTTj4UHNTR+Fl25o7Kr5CRYqap8T3cNbGquuytegQ72y
 72FBmTTBzWZ2HVdKxFrpDZ8KK6OuZNo+VG/mWTFkmf0uBy5GJA6HLvj60Dlyn+wyEEnS
 0L7qdPAGnOFxH+cncWHyzuMHmsnWJd7iJwDYtKzL5tJyVvkjCzFyQ9tarkY4XXJ0iMbd
 WCftQcpPWbL/cHW/LcMhfDzOplWw6Zlo+WJljKFS/cpDtAnDVzZAlX0rbkJRCIv/tQzO
 28AKZPWakhVcFVRVIydRy6gG/xdhASHREJEnKWPff2gbxqmIPkP/LY9sYS0/UejWRCBx
 6S/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776003063; x=1776607863; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nr2A/dxJETpwBr73AVTmxj6GqBvVn0+bRRJPpY9sSQ=;
 b=JssyZBMuewP/KoZ0CbZ9lOD5zUmFbat4zWOfQorh7xlKFUJ9SoEn9roY9KFhkeF9NU
 AAOXXDekQMxmbNBLopL4OgE71IYJ3uveIFhlN5xvIA1Pk/jg75xNfWYnmU4sIxh/oss9
 B9fjqMkzthTyNByd2vypWhazsPSkXYm5Gwebpgz9kT0SI6IOWnaJhM1YVnQ+P3hniFNX
 hzoot5IiJhEGQBWUGM1y+lI12YkNCh0IzD3lQ5nJrfS28hqpjz8ehdHpT9UimdKaKPQt
 hdWIus7tc0l7Vu6VWIgjwa2hDLSrLWUQUhKoiRVPB5mIeoFec+it6/Rz6u/rClpEAro0
 DPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776003063; x=1776607863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7nr2A/dxJETpwBr73AVTmxj6GqBvVn0+bRRJPpY9sSQ=;
 b=dUlKET7VQYMp1NdO4WIM7Yp8J3l797LiTiA3sqDXg/YfHlpEvOzdBTQ7QF8eD5zsVY
 atE9VYYa+YbKl4GBxoFlb0DjoEs7ytFn3oOanVWbyzykMSCaKHlEovGrRM8hEK+yqkHm
 Ln15qxrZ1ecQaMr4QFy3qOeOAvKr6nN0j3nvCqBI0w3SMN/EiCdWy+y6jWtgojt5P+aK
 nqQ6JJXiWgunLwa69vbIMzQhn8jtcRvX3bsYpXyyYqmeqfn8Ea+Z4gXyXkTSTi7pN8JC
 vo1IeOlTMpgCm4JxkT+gQmEWqMilIU1P6BG2g5Vr0Dg5BCN1aGJW9dvxuUSGD2CAk7RA
 Y1EQ==
X-Gm-Message-State: AOJu0YwskWuNMvlAeOT6H2YOyV8fJl0U0YjmYVRFvK7h1e2d5TA/m1/a
 qFGy4R8kYWQDgdboi09H4uSw0gUdVomvkvN/S+VuNi9bnW2hNTx6C411u3Of/mmmuB5L907eU+b
 okiGzACWr/ZxNbCiJpJNknQaHRqrrSKwzcjO49HqdknCD9flsqi4lB0/gzzVCqOQ+bh6qAvxiWh
 Pwd2TV0XGjEc6pZRqTFzQ7antj18RkMVk=
X-Gm-Gg: AeBDietaybTF47gDSNQBmGn9dT6SLG66zLQ6i+/4NFT7at49H/uLCWfVlbyMK+c7oKB
 qtgSz6CJdjPps8BsxodXNye8IGiEfAH634uU3YAYnEuchGxBdJw7GnIyDeyKC+9LU/m2HMAzSsy
 mDmyezpKEcVjuUELX5bLI/hZGpuUHtsm31NXMvhFoZltzflGuNOGsGx9V0PZq0lw37CY0MrKqdP
 QDP77bIovRa1b0xZsj/erz8mZXWwl+DtHZZP3h64HSyZJyyJ4HJobsyIWGbLIY7otelw6F6/V4q
 vZpii61WMKbZI3XXX6EKWA6i
X-Received: by 2002:a17:90a:ad7:b0:35f:b1ad:fded with SMTP id
 98e67ed59e1d1-35fb1ae0146mr1121042a91.18.1776003063242; 
 Sun, 12 Apr 2026 07:11:03 -0700 (PDT)
X-Received: by 2002:a17:90a:ad7:b0:35f:b1ad:fded with SMTP id
 98e67ed59e1d1-35fb1ae0146mr1121028a91.18.1776003062783; Sun, 12 Apr 2026
 07:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-43-231416f76dc3@redhat.com>
 <8fded74a-b72e-47f8-a298-07f78218ed27@linaro.org>
In-Reply-To: <8fded74a-b72e-47f8-a298-07f78218ed27@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 12 Apr 2026 18:10:51 +0400
X-Gm-Features: AQROBzAOrUlKt197RKOOPd5Hv5nMCPKaLmLJ2Phixq5D_PL3nHfLuKLB_nGbw6I
Message-ID: <CAMxuvayY=wZeNpVqEPrGu7fU4SheZu-gSjmqk_bxmpw=g=X4YA@mail.gmail.com>
Subject: Re: [PATCH v2 43/67] ui/keymaps: introduce kbd_layout_free()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
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

hi

On Sun, Apr 12, 2026 at 2:27=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 10/4/26 21:19, Marc-Andr=C3=A9 Lureau wrote:
> > Enable callers to properly tear down keyboard layouts.
> >
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   ui/keymaps.h |  1 +
> >   ui/keymaps.c | 13 ++++++++++---
> >   2 files changed, 11 insertions(+), 3 deletions(-)
>
>
> > diff --git a/ui/keymaps.c b/ui/keymaps.c
> > index 2359dbfe7e6..d1b3f43dc8a 100644
> > --- a/ui/keymaps.c
> > +++ b/ui/keymaps.c
> > @@ -178,6 +178,14 @@ out:
> >       return ret;
> >   }
> >
> > +void kbd_layout_free(kbd_layout_t *k)
> > +{
> > +    if (!k) {
> > +        return;
> > +    }
> > +    g_hash_table_unref(k->hash);
> > +    g_free(k);
> > +}
> >
> >   kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
> >                                      const char *language, Error **errp=
)
>
> Worth renaming kbd_layout_new/init?

sure

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

thanks


