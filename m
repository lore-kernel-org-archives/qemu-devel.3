Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B135EEDEBF0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWo5-0007pC-Vy; Tue, 03 Mar 2026 15:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxWo5-0007p2-4S
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:57:29 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxWo3-0003Yn-Kf
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:57:28 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c648bc907ebso3866994a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 12:57:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772571443; cv=none;
 d=google.com; s=arc-20240605;
 b=NobDAaRPbhG0t2SUeWpj6VPLKhoWPFPaMOwSPd6UEOi07AIxqSWYd0CxuF55lJTvkk
 4yd5RD277NaAROH+kLHaOMzyzkv2H4TKp3U4jfHoyMyF3ifzq87SEoVkwI2Vs7dVndtB
 kR8IhllFBEKn6uOPP40IHvdA3C9+nDaYX0wa+wyC35FQzLMHKB+0H09vgcNtsER2U857
 Uda7xxWukCno915dkq0aeTJ1wTtXIhoRrjjhh7XS3uhul4fEyr4inw30lSzinPIafwrd
 +LkTHr+47eEELtxbOUZhCqkaqtf10wju5OY/t9CXjy5Oc+JERaQSYEOQqcX7VbdjMmK4
 QGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KQilJEyYz9jsqFo438nmXrKgjGdUYW185BjJ30MNOLE=;
 fh=3N4YTDWV9KQk1Zfz9qwlmnoEsAk4PdvYntvEBJFMlvI=;
 b=PCwpcXGK51PoZ6cid7hjnmNbshWLarZtRMNmgiH0VA9L9gurMXCQGikR0UrfQGIH8P
 uxVZeUszHm4mhoc3dndq7C6BXb42PV4nRAPu6CYZkM1lV/QHirUVUEO3dzMRhT9ciY7a
 1F/3GbLHYpkWlIHaBkQYPaLWAr6Fwbekf9i8VIhthWIx6NG3fftpLa6Tn21idkN2vuMU
 N/TYiwlqwPFdXoYKtDRZnuEvRBlShxEKHxFRVhLzB7/qSVkGjC57MtH5RnK9unaodnbX
 zSjHx44vGBX0ezWkKC8CbMlV4Upoi4EZLLRNVKoeNuYvFSkURH7u2B/xKCe/90Ta99MM
 tjFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772571443; x=1773176243; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KQilJEyYz9jsqFo438nmXrKgjGdUYW185BjJ30MNOLE=;
 b=dwCflXZGvSol5ddL3/de4wk8/TCqCztLs8OWGLt3Y3ZzQ/DGYaC9ZL+08vyR6HcdL2
 i5fhtQT4jSAd7WEJZC0iT+PXSAD9I0cUTiLAMFxyps1oghljnsVw8KvQ4vFzvA5GjgIA
 5KmFzZA/zfGC+Z3pvpAGxedxiKUpGgQLv53w5KRxn07i+6DCZJlJGmA2o6Mcg7ET6lOP
 lSue7xb/rbI+CwFIe0rzD1t943+lyq/U+3R52x7eDW0dkTo1TCitjQvGwZYYxab87yw+
 sjyxG3sSPkneJXhR2y1OKy30c9Q5SkR03puUyGI/UVt49AGRVwGxtuwRenMJdJX5lAkv
 cgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772571443; x=1773176243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQilJEyYz9jsqFo438nmXrKgjGdUYW185BjJ30MNOLE=;
 b=w3JqgbE7u5qb4XdLhvSvsuoAMw7DRVeMpFC2pTwvGCAMgHUEEWU3rKZcjRO3kxUK1r
 A4jSOnzjH/g12RWeNxGtYuQ+D8eQ7LlhHRw8xb8GbYnLRUW3HK71wM1P5b6Inx41MKzo
 2DdwcVLejlEGBoZK89wk3+jVPnQVxte/HZ/SUy8kY6/JM8Pv34Ey7Hx3c/4fB6IbrzLg
 Wqjuqb3HpXPgaT46LiYkDAC5/ROlK9b6ZCXEbIceJqbJo3FsscldPA4pvto2uCfh6Y5D
 R4Pii9bZO5kKGw9vi3kjDPdyWH/fLrpAXNWDJkFQqHInIw7JpS4/BgKvdN3ivwhBjPYa
 DrhQ==
X-Gm-Message-State: AOJu0YyRZKMyAZFDiXDFjNpqXxZNCSJba2zwn9UigiyoUYxLs/e9lLcI
 hQoQ80Eo1kQvEGp4Y8q7GeWDoqOfX6NquCGUycyPNFmKKxFVf8I0Zlwp2bPzR7fO5EcibFhgosF
 V1jjOwFSMRatFecQqIwJePUe5vQT8AQc=
X-Gm-Gg: ATEYQzxnMvyyGMZZE8giAN83x680HmyTDQ3D0cY84zp7fd4tIgNmmVmNqoZF6xvl4rl
 5zBJH0VzeRroxeXnS39b7X0aNlsH6KO07Tjn1CdYC5A/A4Q6ApAjpPyOsujxWw2z65fDUoLk6NZ
 AfBlz1AE9ZA4ZDALBXPJw4o1pBAM1o9hPHHTHQ6EeTVqq2sPcveXxZoaX+JoYrc/oGszZIXOqQ1
 kp56aEFS/uxnnuGzUSrDD5JcfeWSJGnTMMIbOLWeFjjtCR/I/B66AKXydHfQj2ROUUqqI9hN01+
 /tBsLsRESR0ap/L2RSygKGlvtEuAa/LMCSDK43o=
X-Received: by 2002:a17:90b:2407:b0:359:791f:5f7a with SMTP id
 98e67ed59e1d1-359791f61f4mr7924803a91.30.1772571443406; Tue, 03 Mar 2026
 12:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-26-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260227203627.932864-26-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 3 Mar 2026 13:57:12 -0700
X-Gm-Features: AaiRm51dmsmGgw_zliqQGJLKIyaabO9ru8DzpN6dBQJ7wgU1RoC1-TnLz6axfuM
Message-ID: <CAATN3NpzsG8Cf4sQXi2oLnV+_7y_aGmta51uctgXW8n0jPx28Q@mail.gmail.com>
Subject: Re: [PATCH v3 25/37] target/hexagon: Add sysemu TCG overrides
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com, 
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, 
 Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000392ef0064c24f3be"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000392ef0064c24f3be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 1:37=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Define TCG overrides for setprio(), crswap(,sgp{0,1,1:0}).
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.h  | 34 ++++++++++++++++++++++++++++++
>  target/hexagon/gen_tcg_sys.h | 40 ++++++++++++++++++++++++++++++++++++
>  target/hexagon/helper.h      |  1 +
>  target/hexagon/genptr.c      |  4 ++++
>  target/hexagon/op_helper.c   |  7 +++++++
>  target/hexagon/hex_common.py |  2 ++
>  target/hexagon/meson.build   | 13 ++++++------
>  7 files changed, 95 insertions(+), 6 deletions(-)
>  create mode 100644 target/hexagon/cpu_helper.h
>  create mode 100644 target/hexagon/gen_tcg_sys.h
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000392ef0064c24f3be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 27,=
 2026 at 1:37=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mail=
to:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Define TCG overrides for setprio(), crswap(,sgp{0,1,1:0}).<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu_helper.h=C2=A0 | 34 ++++++++++++++++++++++++++++++=
<br>
=C2=A0target/hexagon/gen_tcg_sys.h | 40 +++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0target/hexagon/helper.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0target/hexagon/genptr.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++++<br>
=C2=A0target/hexagon/op_helper.c=C2=A0 =C2=A0|=C2=A0 7 +++++++<br>
=C2=A0target/hexagon/hex_common.py |=C2=A0 2 ++<br>
=C2=A0target/hexagon/meson.build=C2=A0 =C2=A0| 13 ++++++------<br>
=C2=A07 files changed, 95 insertions(+), 6 deletions(-)<br>
=C2=A0create mode 100644 target/hexagon/cpu_helper.h<br>
=C2=A0create mode 100644 target/hexagon/gen_tcg_sys.h<br></blockquote><div>=
<br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsim=
pson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></di=
v></div>

--000000000000392ef0064c24f3be--

