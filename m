Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63708C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udojI-0000sU-CA; Mon, 21 Jul 2025 07:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1udoip-0008JB-C7
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1udoii-0000sc-ME
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hs7f7j7fI0OO/CAtxJbLTNRYzwsIwU9dsY3IKOgaKvs=;
 b=LAWUWZ/GCszonT1UvGiGe41bZcn7Gi2IFluGwh7eSRDHnpPqMQnGOrdnmLegi9wfrVlyYU
 2NZHoGUe/hGmuo+c2MclwFv6MDL0e1439d+tpb8kJveIJIfgRcSrv6hLmi4SlPRmfaH/7s
 rtmt6t0PqT/jhqk3eaTCR4Kejuq+dh0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-A3HDtf_eMI-KtugdeIfl4A-1; Mon, 21 Jul 2025 07:30:08 -0400
X-MC-Unique: A3HDtf_eMI-KtugdeIfl4A-1
X-Mimecast-MFC-AGG-ID: A3HDtf_eMI-KtugdeIfl4A_1753097408
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a5058f9ef4so1563844f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097407; x=1753702207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hs7f7j7fI0OO/CAtxJbLTNRYzwsIwU9dsY3IKOgaKvs=;
 b=ShzbN8PaVgbKF77eCQX4TbHfL6N4ccZXoBVWnCdcZ3bBKX+56noGy26chfA/v77EGd
 ck70YLu/59DpCNk0NHwEWufwspYs1V5545Yha2bME+3zL9b1WZJmTKUFcC+YWqcaJray
 Pg6wxgYDm9+uiWjnbIb4/ZS40uoxPaKW+HfUmgTVS4CCoeXatN3Ie+95TwS+uNLtCtC4
 APXDhX05GIizHAqjzZ0Gd/otoOfqz6/ZYWEmwhe9qGbYIiRU8Hdgk9OE+rWZiZ8s5Qzq
 orTfThPfjWRfMNiqKuOkxJMh3oMlHTteuyw8spQc3JPEf5KiJNfdQib6omDI/E9iBa2l
 CKVA==
X-Gm-Message-State: AOJu0Yyfu036jXDV9VBZX/ugDlzDhq7o8FyA0coYL5BSnDtGG146wGsz
 5CfqX/dko0q4+yweRg0Ch012h8WRk/aapK+8NTeETPOCHG6DCgY0ccl2LE8Pu+H7aFkOXcRVN5G
 yYS00SDFeFP7NQNMN0/5rdJZ7O7es4UuW6s2qCML29zTBZZJOpkHehuArSh7kgKe9mLo0dsgsnb
 1iHypDzoEQip1sl9Y6xcsanAA4Dj7Tlko=
X-Gm-Gg: ASbGnctyBhQa1cAi/NZFmUfc/FUTIWoRYil9nd3sdyY6zu4H7nqWIGZv8mY6JLGYhoc
 8UAYR1UHdkdFVjmHc2vkNRMOBXIERQhdtp7GCmXevSjoNnpziLn2oaeVq1KIHn8tNlZEGA0qGL5
 psG/Y6pN1pAeH51wF0L8DY
X-Received: by 2002:a05:6000:1882:b0:3a4:edf5:b942 with SMTP id
 ffacd0b85a97d-3b60ddc647bmr17902125f8f.57.1753097407594; 
 Mon, 21 Jul 2025 04:30:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1qmDDOWiFNtK+/rQq9m/cbQ8DJfJoivXRUReH721YKHVqe2+tJIJnqLZYBTZS5Aa+OpwjfKcMs+DvpurihdA=
X-Received: by 2002:a05:6000:1882:b0:3a4:edf5:b942 with SMTP id
 ffacd0b85a97d-3b60ddc647bmr17902091f8f.57.1753097407084; Mon, 21 Jul 2025
 04:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250721105238.461477-1-pbonzini@redhat.com>
 <CAAjaMXY7aO18R+0S8fyB0ageb1D_8gd_HkFRsDE80Qa8ECWiBg@mail.gmail.com>
In-Reply-To: <CAAjaMXY7aO18R+0S8fyB0ageb1D_8gd_HkFRsDE80Qa8ECWiBg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jul 2025 13:29:55 +0200
X-Gm-Features: Ac12FXzVoqxIsQHnWHWCHyNIDxF4VaOiST_soTkNZDUzX9fAKqTqakp2QaoAHTY
Message-ID: <CABgObfYHcBu-PgaLX60u8DqKaxCVcy-8gitWZ=DzbkryhPGzyw@mail.gmail.com>
Subject: Re: [PATCH] rust: devices are not staticlibs
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 21, 2025 at 1:01=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Hi Paolo,
>
> On Mon, Jul 21, 2025 at 1:53=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > This is only cosmetic for now, but hopefully later on Meson will parse =
more
> > of Cargo.toml.  Devices are linked into a staticlib but are not staticl=
ibs
> > themselves.
>
> Does meson compile them as rlibs instead of staticlibs?

Yes, see "rust_abi: 'rust'". I think you can't even do "extern crate"
with a staticlib - the only staticlib is the per-target one that is
put together via scripts/rust/rust_root_crate.sh.

In theory https://github.com/mesonbuild/meson/pull/14818 should allow
removing the staticlib as well, using rustc instead of gcc to create
the final executable even if it has system/main.c listed as one of its
sources. Executables should than be smaller or they can use dynamic
libstd. I haven't tested that yet though...

Paolo


