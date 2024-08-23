Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480F6C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 10:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shR7t-0008RP-F4; Fri, 23 Aug 2024 06:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1shR7f-0008Mx-Fy; Fri, 23 Aug 2024 06:02:31 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1shR7c-00066h-GI; Fri, 23 Aug 2024 06:02:22 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa69dso2102341a12.3; 
 Fri, 23 Aug 2024 03:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724407337; x=1725012137; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3GUFE6xVQ6akuuJsZ5o1XGnd3Koqhk0/504xLo53AyM=;
 b=Ozm8MNW+4XJ7pgjmHaR08C0P7xcIZCg44E077djDf1gXhCKEmXnCE3pbNaJXgQnzqt
 cb55uzGyPGIt5bckkUCzXzuBWpOEmacXDZhjv/PuG7b0fGGUjP65+x7Bdzw0ZiYk70v6
 tFerSTsDLMMzu4R//6n9TvqPiYVLBQR/XrbeRmToHKrhFr2mjtg07ViKmjx7mG/z+2kn
 h/B0rviukdexNIVaKpWumPsBvM55oS/0Z7K/KWRW55nOGib9YmwfVJTvNEWBsho/38wv
 g/rHSXVVmuWtLzIyrHYsJOCe6YR24m99n3ZhaCrSBw/635EwmVVnVdqTzRmYAUlGYLPs
 18Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724407337; x=1725012137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3GUFE6xVQ6akuuJsZ5o1XGnd3Koqhk0/504xLo53AyM=;
 b=gRJ/yNWMd2XE+bPMIVxFGn5U6KtsyGutqtjpJy8gAcGNlYsyNJJW2vAlAFu8Sn1IQk
 sV1eOMNbMKMbdfit/Cdu/SJ5SCSldvRhuZ6Up64jQpK7ma5a1sQtM+q968BOby5Safo2
 ru2/Q8/Xnc7DrsJGuPquYLen2X/KG/8rhIL5Vl3HX6MnDjcvGuhegEhYuX4zdScTZJ2w
 +hxoDEayEU7PNgRTvVjLQDkgTx09n6eKyL+RXLvZWfC9sHM9lU01kd3YmzBCoRsJBK1H
 ybA+H7acAZMu5GRlA2uWBxJB3Ln0TT2mJ7RD0Qw6EZ4otN002lIc1PgJSk4MZWh95+p/
 0Kmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+J8Csqi97gwNOOSXXFihdFlQzk7escJ7UWOwxxDEXLp2h3v0id/VQhD0UJQrIRvPyH12XF7gC4lWb@nongnu.org
X-Gm-Message-State: AOJu0YxwnCnahuW33A+AK3WATcP2zBUPAiOs2cfdQpJ/8ayrk9PIZwxn
 q976NOvDO3UKtEpjT5s2XfWz+8YO4V0UejCgMZTNbvBEHRkux58w1j2UNYpTyGJM/51Z8yGuBxP
 8+miVgScAkwLmB7WXfsHyvNb5JF0=
X-Google-Smtp-Source: AGHT+IG5JB3WL6rJliHKpuBIB2P8CwnYpjayxu4KGnJKSh6EtSzGIRjkhp5QwPGbrHC67X+heSO8v2/H3KkesMzhrKw=
X-Received: by 2002:a05:6402:34ca:b0:5be:eb9b:b72a with SMTP id
 4fb4d7f45d1cf-5c08915b95dmr1048332a12.6.1724407336511; Fri, 23 Aug 2024
 03:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240822162127.705879-1-peter.maydell@linaro.org>
In-Reply-To: <20240822162127.705879-1-peter.maydell@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 23 Aug 2024 12:02:04 +0200
Message-ID: <CAJy5ezqsZ4-nxAOaHtPJzwrt_1Ccf5-pYG88=8RVWEa5xYtrFA@mail.gmail.com>
Subject: Re: [PATCH for-9.2 0/6] arm: xlnx: fix minor memory leaks
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Content-Type: multipart/alternative; boundary="000000000000bdb230062056de41"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000bdb230062056de41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 6:21=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> This patchset fixes a collection of minor memory leaks in
> various xlnx devices, all detected by clang LeakSanitizer
> when running 'make check'. Since these are longstanding
> and not very important leaks, this is 9.2 material.
>
>
All of it looks good to me:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> thanks
> -- PMM
>
> Peter Maydell (6):
>   hw/misc/xlnx-versal-cfu: destroy fifo in finalize
>   hw/misc/xlnx-versal-trng: Free s->prng in finalize, not unrealize
>   hw/nvram/xlnx-bbram: Call register_finalize_block
>   hw/nvram/xlnx-zynqmp-efuse: Call register_finalize_block
>   hw/misc/xlnx-versal-trng: Call register_finalize_block
>   hm/nvram/xlnx-versal-efuse-ctrl: Call register_finalize_block
>
>  include/hw/misc/xlnx-versal-trng.h   |  1 +
>  include/hw/nvram/xlnx-bbram.h        |  1 +
>  include/hw/nvram/xlnx-versal-efuse.h |  1 +
>  include/hw/nvram/xlnx-zynqmp-efuse.h |  1 +
>  hw/misc/xlnx-versal-cfu.c            |  8 ++++++++
>  hw/misc/xlnx-versal-trng.c           | 12 ++++++------
>  hw/nvram/xlnx-bbram.c                | 13 ++++++++++---
>  hw/nvram/xlnx-versal-efuse-ctrl.c    |  6 +++---
>  hw/nvram/xlnx-zynqmp-efuse.c         | 13 ++++++++++---
>  9 files changed, 41 insertions(+), 15 deletions(-)
>
> --
> 2.34.1
>
>

--000000000000bdb230062056de41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Aug 22, 2024 at 6:21=E2=80=AFPM P=
eter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@=
linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">This patchset fixes a collection of mi=
nor memory leaks in<br>
various xlnx devices, all detected by clang LeakSanitizer<br>
when running &#39;make check&#39;. Since these are longstanding<br>
and not very important leaks, this is 9.2 material.<br>
<br></blockquote><div><br></div><div>All of it looks good to me:</div><div>=
Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@amd.com=
">edgar.iglesias@amd.com</a>&gt;<br></div><div><br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
thanks<br>
-- PMM<br>
<br>
Peter Maydell (6):<br>
=C2=A0 hw/misc/xlnx-versal-cfu: destroy fifo in finalize<br>
=C2=A0 hw/misc/xlnx-versal-trng: Free s-&gt;prng in finalize, not unrealize=
<br>
=C2=A0 hw/nvram/xlnx-bbram: Call register_finalize_block<br>
=C2=A0 hw/nvram/xlnx-zynqmp-efuse: Call register_finalize_block<br>
=C2=A0 hw/misc/xlnx-versal-trng: Call register_finalize_block<br>
=C2=A0 hm/nvram/xlnx-versal-efuse-ctrl: Call register_finalize_block<br>
<br>
=C2=A0include/hw/misc/xlnx-versal-trng.h=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0include/hw/nvram/xlnx-bbram.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<=
br>
=C2=A0include/hw/nvram/xlnx-versal-efuse.h |=C2=A0 1 +<br>
=C2=A0include/hw/nvram/xlnx-zynqmp-efuse.h |=C2=A0 1 +<br>
=C2=A0hw/misc/xlnx-versal-cfu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 8 ++++++++<br>
=C2=A0hw/misc/xlnx-versal-trng.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
12 ++++++------<br>
=C2=A0hw/nvram/xlnx-bbram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 13 ++++++++++---<br>
=C2=A0hw/nvram/xlnx-versal-efuse-ctrl.c=C2=A0 =C2=A0 |=C2=A0 6 +++---<br>
=C2=A0hw/nvram/xlnx-zynqmp-efuse.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 13 ++=
++++++++---<br>
=C2=A09 files changed, 41 insertions(+), 15 deletions(-)<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000bdb230062056de41--

