Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C15C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJvog-0005Mt-I5; Tue, 27 May 2025 11:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJvoe-0005Mk-QS
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJvoX-0006AU-0i
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748358120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+8mwCdL3hOJ7OEayJ1t/Dy9QXniV1Y+r8+4rSFbNcs=;
 b=Gu3f/MeSfjC5eSMna2v/psvZkjzR8Qau1NLYMBYsCL11QdgZMHgl6KHaGrOdD4UIR4w3gs
 TX1tGP4gXaqKW6TyVQcIB69x4NNyhGOqCn82AW3EXvcZsabTNf5UHVUol5BFDmkUVmp1qu
 YL8Cd5vdGRjR7vg3jQ16tCk9yxhtQvQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-0JivRReNPrKf8f_wxS6yLA-1; Tue, 27 May 2025 11:01:58 -0400
X-MC-Unique: 0JivRReNPrKf8f_wxS6yLA-1
X-Mimecast-MFC-AGG-ID: 0JivRReNPrKf8f_wxS6yLA_1748358116
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4d00e44fdso1421752f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 08:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748358116; x=1748962916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+8mwCdL3hOJ7OEayJ1t/Dy9QXniV1Y+r8+4rSFbNcs=;
 b=YiVLlHyxvlv+D+PWYtZO1GpI0LzkUW+vKx3/4ebaEAmuK6XzOYrnX3K0bOFSwi54F0
 OvYepAOLEXxbwfQf6Tb7nxho5/wQF6/eDtlUlbm6TVFnSv1+HJi59yiZY1ZuJTWnSHJS
 KWfvqYkDYxPQYBiRRbDoTFD7PSPRbEx7XMTWGsZWY22H4m4f/mMaDgjpktwdDpYbQZ8V
 kndA+fK4K8P6zd569BjPaP8ntU/S8JqhnRBsgvK+NfSbuProf9v+kZ1aN1TiRCBhrRga
 dhOvU1RlIHJcHr8VLAWE7fkLubU9CldJjiRT5FmoksJDqgUfsJR0L6gZIojVzdVIAewx
 cdcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3nj08kHrOAlKiTtEPROGhZbSXMKOJRosX0gvIPTE7ChUdJtjlPMwz+jkz8m8Ne3M7ISqFKivb8mq3@nongnu.org
X-Gm-Message-State: AOJu0Yw43v9frPS2Wd3vSFy8KhjT2nL8d10AH5Dc7U27u5jrX8RB61bD
 lCGqw9lC9dvfcttIPDOcOlr/TZceQuqmE9Lme5D4xlOTRLUfHqDuDuKfy6M8UsO71i2L4Ye9+gn
 blJqwNGUZ6g/HKkTi5OnOx0Rn01TytiTfYF9+gAb+O1ue7gJ4pkfrc8G6ccdIdvOtavSbh/scyq
 GUNmsCQmodZNBHpPoLFAI4TZZ+LphMGzc=
X-Gm-Gg: ASbGncuFp92aCUP86V2hPkMh4Csl/kkCAW88X7gT16EocpE7kS1U1lC3Dv9qI8vSPgD
 6jpHaTJMp2wXC/mX/PoLFge1BKssO2F0Olg8KRhlB9voh9uMoUo9fYMMjzXEBHTwsvxE=
X-Received: by 2002:a5d:588a:0:b0:3a4:dbac:2db6 with SMTP id
 ffacd0b85a97d-3a4dbac2f5cmr4949471f8f.49.1748358116000; 
 Tue, 27 May 2025 08:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3c7P6mMQlzsCWzr9zsQ9H8pcEsfm6l8wGv51zN9lNjPLRD5Uyjmx60lIOm5fkeuYug5m22h5t7uimoWPglfU=
X-Received: by 2002:a5d:588a:0:b0:3a4:dbac:2db6 with SMTP id
 ffacd0b85a97d-3a4dbac2f5cmr4949429f8f.49.1748358115474; Tue, 27 May 2025
 08:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
 <9461fc05-3c1d-4236-a0b7-99f39781f278@redhat.com>
 <a8d508a2-7369-4ccd-a6a7-7c74b38c962a@daynix.com>
In-Reply-To: <a8d508a2-7369-4ccd-a6a7-7c74b38c962a@daynix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 May 2025 17:01:40 +0200
X-Gm-Features: AX0GCFvHzNZdcbfcrgnweE5lQu0rTsv3ZDglahSFuk3Jh62fmOCyB_S9g3TTK_8
Message-ID: <CABgObfbh+VOvjWBM-NdTWnuSzgkmjLN=nfskLrxL8-NBtJwUTQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Improve futex usage
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 27, 2025 at 5:01=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
> I'd like to submit it with "[PATCH v4 05/11] qemu-thread: Avoid futex
> abstraction for non-Linux" because it aligns the implementations of
> Linux and non-Linux versions to rely on a store-release of EV_SET in
> qemu_event_set().

Ok, I see what you mean - you would like the xchg to be an
xchg_release essentially.

There is actually one case in which skipping the xchg has an effect.
If you have the following:

- one side does

  s.foo =3D 1;
  qemu_event_set(&s.ev);

- the other side never reaches the qemu_event_reset(&s.ev)

then skipping the xchg might allow the cacheline for ev to remain
shared. This is unlikely to *make* a difference, though it does
*exist* as a difference, so I will review the patch, but I really
prefer to place it last.  It's safer to take a known-working
algorithm, apply it to all OSes (or at least Linux and Windows), and
only then you refine it. It also makes my queue shorter.

> > Do you think it's incorrect?  I'll wait for your answer before sending
> > out the actual pull request.
>
> It's correct, but I don't think it's worthwhile.
>
> This code path is only used by platforms without a futex wrapper.
> Currently we only have one for Linux and this series adds one for
> Windows, but FreeBSD[1] and OpenBSD[2] have their own futex. macOS also
> gained one with version 14.4.[3] We can add wrappers for them too if
> their performance really matters.
> So the only platforms listed in docs/about/build-platforms.rst that
> require the non-futex version are macOS older than 14.4 and NetBSD.
> macOS older than 14.4 will not be supported after June 5 since macOS 14
> was released June 5, 2023 and docs/about/build-platforms.rst says:
>
> There are too few relevant platforms to justify the effort potentially
> needed for quality assurance.

Ok, nice.  So it's really just NetBSD in the end.

> Moreover, qemu_event_reset() is often followed by qemu_event_wait() or
> other barriers so probably relaxing ordering here does not affect the
> overall ordering constraint (and performance) much.

Understood.  For me it wasn't really about performance, but more about
understanding exactly which reorderings can happen and what
synchronizes with what. Load-acquire/store-release are simpler to
understand in that respect, especially since this use of condvar,
without the mutex in reset, is different from everything else that
I've ever seen.

Paolo


