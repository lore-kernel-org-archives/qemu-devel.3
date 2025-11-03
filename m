Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA419CCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrQe-0000QU-LV; Mon, 03 Nov 2025 05:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFrQb-0000PB-VR
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:04:46 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFrQZ-0000nO-Jw
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:04:45 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-78665368a5cso13152487b3.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762164281; x=1762769081; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TO/WTpBy+Pg8zGX32AYPEP66aTxiG6UJz3VzSqk152s=;
 b=u+tARBM2uV6DgmJrSzqhho0xA/a3fAum8zo19UX3axzSTOLEq+fp/UnP/DWOVHHion
 ukKUJ0bYPKMw1U2l3w8pyvp8FJ2l8Y+h1CTuRGw8r+2Gbalxlb1/jwMxauR+6vlF8ETr
 SeeMLU7e8t6+mtY6FKL4R0uVjoZUpAbGQUBmSzaDffQrlZP0YebTMdPLBOWYlDtDwsKV
 w2X1F9iTxSMuWVNLxpZH/caTHhxFArjV6qWh3K9O5oO7CZkzs2pqdczK4UXCpN3KvLOi
 +mKHkdbH8tmqiOnkHnqhcSEAtbK6E+gFdaC2ptplG4ycEHyzRAERSqVnnfW22In4LGp5
 fScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164281; x=1762769081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TO/WTpBy+Pg8zGX32AYPEP66aTxiG6UJz3VzSqk152s=;
 b=db+cjyJ9KGEa3VAqXhaaH0uZD6TUUbmwvyqMorCmmX7vkZnJwFRiCZR+p8PdiQFHSP
 EU4sAp6KZmJBNZ14vduSi4F7HR+FAgCkaz28G9llBugAb0nJAMGg0KcfiOBD+lN2D1Zl
 ZLC6rdLOXR8sYHXIF1ojbfRDiEMazjy/Ii1xndlY+QKFNgu7UrJObccDgBpTlpnpmz+u
 QnkN2Sg5VSd6gk+/fxMQxygDE4oEDsrOFM2Wfrfa8lQkbPj15KYd4pXgXUFrXspMu/wm
 DZHq3l/zxilrBJHaSa1kqdFLeyM23VfbMwv7HZJQ/2oQhtTqnchfDNLtulp6PNfy/acq
 DBtg==
X-Gm-Message-State: AOJu0YwkbTKrGXkf/C+YoaJ0ko+/p6fIrer2yMD6Lj9kgF+fMkdQOynv
 e5tHNmW6HQF6d9jCX4pnCcWL2OkYCQs/3UQAeQr14s2lU0cEayVtP5ze5veZbt0NwpBRjv0wrq2
 bf34XOyQKXRF6FYSAnlPuneyDU1LcoqJRNEmOIiVqy/MDU/0SDqKOTy0=
X-Gm-Gg: ASbGnctM3M6uDc8lHz7l2T5KTU3eeAQinugnVX2WwNH/FTWDVlqCQsTHuKRg98omlqk
 XS0R9xgWypAIvwFa9i8AleQbKGCJJrvViJ9MgieJmnoIr0QtkSNBTcbjRRtLdpzZnkvGSzu37rv
 OFnJ4wESjRNO2DiqxK1tPreZgyVXQ3Q3mDCS6143yGguHPAE0GcEG2SbCmHjTmvZMd93CSb+rNf
 j2yY5NuRidPVFOT7J6zy0iBw5aJCEUkP5q1GOb2nTgxeVbyuVjJapmzjfJmCA==
X-Google-Smtp-Source: AGHT+IGiXW7hC2vHNPiW4POuiie1I9JVva7jt2MEUzmgAFDeR+Yvj+Ls8bR0X7zgsUl3pcQzeD9xTrYbWLvy8Ly7LNE=
X-Received: by 2002:a05:690c:6604:b0:786:5620:faf5 with SMTP id
 00721157ae682-78656210f94mr99368247b3.47.1762164281238; Mon, 03 Nov 2025
 02:04:41 -0800 (PST)
MIME-Version: 1.0
References: <20251103100158.1148552-1-marcandre.lureau@redhat.com>
In-Reply-To: <20251103100158.1148552-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Nov 2025 10:04:29 +0000
X-Gm-Features: AWmQ_bnTITtK_OJ87C-ixgdFl9rvx8ns2oFs96aIy5A9oWNIKE6kuk9_JH-uemk
Message-ID: <CAFEAcA8U=dRuAvSf5n=tNbNNk039YLXo9UBRe_Vis689x7JaFg@mail.gmail.com>
Subject: Re: [PATCH] audio/dbus: make "dbus" the default backend when using
 -display dbus
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, berrange@redhat.com, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 3 Nov 2025 at 10:02, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Set "using_dbus_display" during early_dbus_init(), so that we can try to
> create the "dbus" audio backend by default from audio_prio_list.
>
> This makes dbus audio work by default when using an audio device,
> without having to setup and wire up the -audiodev manually.
>
> The added FIXME is addressed in the coming up cleanup series.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  audio/audio.c     |  3 +++
>  audio/dbusaudio.c |  8 +++++++-
>  ui/dbus.c         | 17 +++++++++++++---
>  3 files changed, 23 insertions(+), 5 deletions(-)

Shouldn't we be documenting this somewhere? Having -display
affect the audio is a bit non-obvious : generally we prefer
to have options be orthogonal and the user to specify what
they want rather than trying for "do what I mean" behaviour.

-- PMM

