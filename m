Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB47F53D70
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Aov-0000Ta-0e; Mon, 16 Mar 2026 12:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2Aos-0000T7-2g
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:29:30 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2Aop-0006FH-VD
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:29:29 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35b88a4f123so1051281a91.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 09:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773678566; cv=none;
 d=google.com; s=arc-20240605;
 b=LYs6vPKaVsoOL8PbFBpKEnNSa/ZQ7K7K4eJohjjFgoZgWo1HvPteB1sIopb8c599s2
 zHMA0oQ1mVue3LKonASv5Bl1WwJx3vfXHEZ9hddmHLRWXjm7ofaylUu8jjkShefR5DMx
 O4Lgz+YSsYJ/3So9tWAsqJ9hjIQEe4hpF7PgA+kPzhMBlcKNaX29ql/X+e9TREabUErr
 7u1TU9M9xYOngt8AFE0U11qZF/P6tzFw8ejt9l67M9KDo8qT0a4aNHLFjmT0gAZrP3zb
 EV39m1VEScfwSLVXYuPoIO7OkfRmpaeG6B1C1xEaeJVUzHXypDgtRN1mz4TRG54vTEt6
 xmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IDd+J2IfctHf1D0vjK9rOtWkCRLIGCaarugb29FsCfw=;
 fh=yiUwoBOEypY2fM3mHrz5u4mbHkIidyv/b4UPGcEpz+k=;
 b=OHGsAsoztgwr7UKVY5jqHymzqmIpE1tjpS6MTGc+aMqYKgWatPTM5KkD2ujDULSQkI
 5GIDdW79wKgePYSTCHeXZ+d2ytJBZT2DWi61Bw2nLNtO0pEoWoCfIEN4oqQGQv7U+TP2
 qDslXMAPwvwYfPrHEZuo6jfaFfdb0ReaUeWslM4qlm4N2zjfFF6DsDK9pHrHfc4/Xai7
 7RXuKMDLV/DC6J3gPSt+9qlzUzeYiTa9Sf3FRsSx400/WBRRCfWuSEdq6kfc3bPsaD1Y
 ABtK60+VlhQByzNpWns64E44srHVHegtn/p/wF40cg2drBxBbh2G1hg8zRS6m81PKT32
 IWog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773678566; x=1774283366; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IDd+J2IfctHf1D0vjK9rOtWkCRLIGCaarugb29FsCfw=;
 b=aGSoE6/8KFqRrbcJBZc0mo+h7Go4afA51wBNlGxYDlSgCuEtkB/5BplTY0KuZtRXZA
 caRiAXEdC1kEydrOJDqT6y6Z9pWlHnAxl4CcWBF6utMshgdCNb+R9t9bz/8Yw6TzOCGT
 BO7bTO6qEqnOQHLrbA8hkEscUkp2EjIPJ7T/1iKT9HML6iPwyAT7y1QHKEpOy9mfcmeH
 Vxo8qkhtg3qTW9+KuQZ6xnHJiulFMKXd4SyhZhtmUgyvrZkQl3PcnciTZsPHI7sBGbUE
 7lyQD8jA4hFvG8BMHuXGFTc6i6KbSUS7Uw9wuB9X/y0fdB/jWUA09SgYTpjkjKH/4Hz7
 g3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773678566; x=1774283366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDd+J2IfctHf1D0vjK9rOtWkCRLIGCaarugb29FsCfw=;
 b=mXTOTcP72C7xk+z/wjlNftLcvEdoIFxGXotkLcocT8crvV1+nXuswV2MdfitkKEcuq
 OhKxE5VpRAlyE/SYMmu5YLzQvaSWt0fF0eGGVyL8dibSiCcY/l9EQmHtShqDEXl5uPsr
 SqyfqSeaBoRaEMJmdQp9APbDF1FVJZT4KOl6ooQCW1qGjx/bDtdaoSDlWCfyWXdxE6ik
 8bAYrrhOENAoiBPHpD4V59t6tmXm6NSmmpNAjdwPESKCFlko6z1iE0mLeub8n9bMhbRh
 ksErlbHc/UNueRu6bqdub8IkXL7hJNwFyAjutirM3U3mrLWyy2jOT2nj6ea0V1tjf26Z
 jcTg==
X-Gm-Message-State: AOJu0YxXfBT0UtowQ//1vNShZUnDyu9uJTouZ9JfIwO2a6TDOaHVY5g6
 D+5auInF1oCTBRz/7XRgeTWeb80ypv3OAzr5TYLqk0jLsKXlZ09Dty4KliRTs5AQlmAnxHq7snP
 0YHreyEFRHl1Dbo+wYfxtjV/hJpDPEvM=
X-Gm-Gg: ATEYQzwC5c6KEGDENoGcu8waIZk4TKU//Fm9VOw4SumaACyQeH/lkuSN9tbaCK/qSdr
 U3F9tUiwbqdTuW6YYA0JOjfSFEH6e0mJ3uPt5p96rPIzA+oO5pi0RxiPF0xM14SCJ+4nikLakuQ
 TQ1qghnYQa2NGDm3jVx0Z/9xSmMmST5wXj+rVyO1jJXXlcPUErqafIl8kTaFPv0anWcXfTY8Kzf
 8wOOSXcbjmuPycvyjbpIYgi68L0ei4QSW3vLJMFba1kYR5jE+h+1w/za4r2dMFv9XoBY9KjfMKn
 0PgwHBFB7nQfWuEVem4mcXbTB/LwChxEuDmHjA==
X-Received: by 2002:a17:90b:35c6:b0:356:7025:56c7 with SMTP id
 98e67ed59e1d1-35badaa49a2mr189584a91.5.1773678565809; Mon, 16 Mar 2026
 09:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-15-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-15-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Mar 2026 10:29:14 -0600
X-Gm-Features: AaiRm50KGyOekHz1lYsYWzoFfQvdlsKTeSdIYBVfoV1S6zn2UeKvkOsuwrUB-C8
Message-ID: <CAATN3Nr0c1LS6UrE5zJTzdZwzY-XJp88HtU+-M92umadcrrSnA@mail.gmail.com>
Subject: Re: [PATCH v3 14/32] target/hexagon: add simple cpu_exec_reset and
 pointer_wrap
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000dc5f7d064d26b810"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1035.google.com
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

--000000000000dc5f7d064d26b810
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000dc5f7d064d26b810
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">From: Matheus Tavares Bernardino &l=
t;<a href=3D"mailto:matheus.bernardino@oss.qualcomm.com" target=3D"_blank">=
matheus.bernardino@oss.qualcomm.com</a>&gt;<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.c | 8 ++++++++<br>
=C2=A01 file changed, 8 insertions(+)<br></blockquote><div><br></div><div>R=
eviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">=
ltaylorsimpson@gmail.com</a>&gt;=C2=A0</div></div></div>

--000000000000dc5f7d064d26b810--

