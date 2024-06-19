Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40460C2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 13:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJvLc-0005N5-16; Wed, 19 Jun 2024 09:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sJvLX-0005Mk-Vl
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 09:27:31 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sJvLW-0006w7-5x
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 09:27:31 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57ccd1111b0so2672486a12.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718803648; x=1719408448; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3qLgBq+o7JVQDMYNxWh0zktfLyi/mma69twBe9PGq8=;
 b=UdsZXda3B1XH8EN7t6t4kAo+OsqQNTJ1uEEhOTknzhcsWKmWJPOJJWt2voMWgGQzMa
 ZzQ7wagQTk6hnW3buGCQ6SG8pXuakjsTi6268zG0KWy+KGD9jrhhy6U7fk5kSguiRdXv
 LcvxYL5dX1J9XMd20A1H8Vk6ekdDPZFKAfHXDSTFC9+UYIxkJBSlj7oEDKU1Tx+jI32I
 W0F2D4C2jo6U/XR20dOqyMqFNpcDDR0hSsaTPUd1DcBMthKw8RcUqeUGFS1zUlJUQD8k
 o+b66ZkmyiAmpM9b5b6OTwc1Jssn2QZNbpZZq68BNvBwhWjFEyGFGapURvKD1bqIPh93
 6T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718803648; x=1719408448;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L3qLgBq+o7JVQDMYNxWh0zktfLyi/mma69twBe9PGq8=;
 b=rvyv2lL0t7IRUrVAtOZR/JJa1xSlZopBXKDy1vMZAtJMvAhmFMxUFwxCYLAchayffm
 iZ5hQ2/70STSoA/0kMAZuD0ZGqsUkiU3DpnNXxGsw7LnHG42bR01BvlXkUTYDX+snFIJ
 vs+1QNIxc4IN9hPYXdy8D2ljiL5bk32hKEdMGme/a9Cv42gpyaR0h9Hd6rLEGNhAcqBk
 cTVnPlO7N/WFtwtOsbQiZG/fasSWrH4vVSSS/0jLuJbXBjgcAdNFu2xeT2BR+Gc/LTPc
 pwrkll0F9xlWPtxpPpCOyCuvKLt2uaS8ve9j1++n+NRJ1mUfNsiWsVxg4QqmtS4d2p7K
 /Pfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhoM+IUpVwozHZTjbIbzZVh7sLJ49PSGMaP7qUXjNuBbLrchpvg0iJVam/PjMI3Wuk3v0GisqUNuZiOJcOpR0nh9JCyrA=
X-Gm-Message-State: AOJu0YwhozjtX9Mvy/CVe0pyyGhn1JdNdab/Z3gbLlifrNl0tA0PZOhf
 4hVny1Z6KmHhQTe+9DLe6Z5dk1NKzyKkaxYiPxx/3ErG86Bi0egtAuHiKtUjag8a8jv78jsmC16
 9evS8U6G6BrzUevCtSdjVH1FhJmFGVWK6KIG9/A==
X-Google-Smtp-Source: AGHT+IFO57V9L6Wk44dqtbQ/UFIP/JJ/Z0DoRvWY495ZijgDLwTwSwGAPlU3WLFy9iP8JHFZr6D0G9rr/BglJPJ32KU=
X-Received: by 2002:a50:d50a:0:b0:57d:4bd:731f with SMTP id
 4fb4d7f45d1cf-57d07ebabbbmr1819320a12.37.1718803647834; Wed, 19 Jun 2024
 06:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240618160039.36108-1-philmd@linaro.org>
 <5ae93d7c-0fd2-4ead-b903-6b5838e0c24b@linaro.org>
 <6dfa4bb0-e4c5-46c9-93e5-d30f3a26592a@linaro.org>
 <68014035-47e7-48b4-b11b-83b219f4ef63@linaro.org>
 <e3274b41-166f-4600-b631-2013efc4540d@linaro.org>
In-Reply-To: <e3274b41-166f-4600-b631-2013efc4540d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jun 2024 14:27:16 +0100
Message-ID: <CAFEAcA-Meog7qje_8G3k-49us6JrdipszAQEMRmbgqv1t-3Wmw@mail.gmail.com>
Subject: Re: [PULL 00/76] Misc patches for 2024-06-18
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 19 Jun 2024 at 11:44, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 18/6/24 22:32, Richard Henderson wrote:
> > On 6/18/24 13:15, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 18/6/24 22:06, Richard Henderson wrote:
> >>> On 6/18/24 08:59, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>> The following changes since commit
> >>>> 900536d3e97aed7fdd9cb4dadd3bf7023360e819:
> >>>>
> >>>>    Merge tag 'dirtylimit-dirtyrate-pull-request-20240617'
> >>>> ofhttps://github.com/newfriday/qemu  into staging (2024-06-17
> >>>> 11:40:24 -0700)
> >>>>
> >>>> are available in the Git repository at:
> >>>>
> >>>>    https://github.com/philmd/qemu.git  tags/misc-20240618
> >>>>
> >>>> for you to fetch changes up to
> >>>> 02ad1f5b04bf2941852f405c87535307365f7041:
> >>>>
> >>>>    ui+display: rename is_buffer_shared() -> surface_is_allocated()
> >>>> (2024-06-18 17:54:40 +0200)
> >>>>
> >>>> Spurious warning (3 times):
> >>>>
> >>>>   WARNING: added, moved or deleted file(s), does MAINTAINERS need
> >>>> updating?
> >>>>
> >>>> Deliberately ignored in ui/ (also 3 times):
> >>>>
> >>>>    WARNING: line over 80 characters
> >>>>
> >>>> ----------------------------------------------------------------
> >>>> Misc patches queue
> >>>>
> >>>> . Remove deprecated pc-i440fx-2.0 -> 2.3 machines (Phil)
> >>>> . Always use little endian audio format in virtio-snd (Phil)
> >>>> . Avoid using Monitor in INTERRUPT_STATS_PROVIDER::print_info (Phil)
> >>>> . Introduce x-query-interrupt-controllers QMP command (Phil)
> >>>> . Introduce pnv_chip_foreach_cpu() to remove one CPU_FOREACH use
> >>>> (C=C3=A9dric)
> >>>> . Set arm_v7m_tcg_ops::cpu_exec_halt & mandate
> >>>> TCGCPUOps::cpu_exec_halt (Peter)
> >>>> . Constify few uses of IOMMUTLBEvent (Phil)
> >>>> . Wire loongson_ipi device to loongson3_virt/TCG (Jiaxun)
> >>>> . Fix inclusion of tracing headers on s390x/TCG (Phil)
> >>>> . Add few shortcuts missing to readline (Manos)
> >>>> . Update ui/display entries in MAINTAINERS (Gerd)
> >>>> . Use qemu_add_mouse_change_notifier on Cocoa (Akihiko)
> >>>> . Fix Standard VGA screen blanking and cleanups (Gerd)
> >>>> . Fix USB/MTP reported "free space" value (Fabio)
> >>>
> >>> Fails testing:
> >>>
> >>> https://gitlab.com/qemu-project/qemu/-/jobs/7129004955
> >>>
> >>> qemu-system-tricore: ../accel/tcg/cpu-exec.c:1082:
> >>> tcg_exec_realizefn: Assertion `cpu->cc->tcg_ops->cpu_exec_halt' faile=
d.
> >>
> >> Doh sorry, I tested but hit a libusb issue on this target and mingw64,
> >> tested there and thought this was the only issue and missed that.
> >>
> >> Hmm cpu_has_work() is defined inlined. I'll just drop the 3 lines
> >> I added to Peter's patch and send his unmodified.
> >
> > No, the assert is exactly correct, and caught a bug in the previous
> > patch (55/76).
> > Without your assert, we will just SEGV in cpu_handle_halt instead with
> > patch (56/76).
>
> Yeah, it was too late here to realize that.
>
> Peter, I'll respin without your series. Do you mind taking your
> "target/arm: Set arm_v7m_tcg_ops cpu_exec_halt to arm_cpu_exec_halt"
> patch via your ARM tree, that way I don't delay you further.

Sure, I can do that. (I don't think this series particularly
is likely to conflict with anything else in flight.)

-- PMM

