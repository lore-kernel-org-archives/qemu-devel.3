Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65513C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 23:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6cta-0003bd-G0; Tue, 15 Sep 2026 19:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6ctY-0003bS-UT
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 19:49:00 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6ctX-0004Pz-90
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 19:49:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2db710396ffso12969025ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789516138; cv=none;
 d=google.com; s=arc-20260327;
 b=dcjO6sw4FQg0PFxwZqJ9hDzplPDDJ5ypC8YekGUmzjDWtYGsCqiH2q2ZvFh5UDkCCr
 Rto4nBoQk5wJP5xFeSwwY/yDjsvCngDrXZUtlddBt8ND7bAvj/5gkA4/xIUvIzHkgUgT
 GrsB+dHsjlxf142wQ037Cmq2Gs1BN33o02rb1kgfHhgLycISpWueipaFj25FMVHw8mU/
 CWw0VojZ1HhlYbGf5NKF8lmqqECibUwAqBDOfODGr53a4FugfrTMIh6tCu8EJCWeJGNA
 p7K9fuKhDnGUwXh7aDaqMQ5W8wEAl1B8Z6wTzUx6eCrU67mCvdbGL+BKZXRl4JyFQkJ6
 102Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6sU1+GmewT+E827XgAZjoHwEdPvSXGEEcY3O5jvmbYo=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=sRj+OmfxKuABNfSf7S6f9jYqI4ILPYCD2QzBT9CGHnBNgh2Wo/poENT0EyCI+9u87j
 geJLGSSgw75kleVa6sRCec50AFEHuXkFikDU0hKVt+Gv4H4BWMiRrJcx81BCEp33dNjz
 SWPB+cwC+IHPBMcnSq08n7aTb0JyeSUcv2sw+/ANLQXyvEw+kKfmruAhNQe7rvOldShi
 +sFJvyZ87jGu14v36JuRHMitecLjnk0fjni5tL5cvFT4xHa+HzAVmBlu0j/08tk/hKmE
 ICDKPq3jljbDXgd371rrdl+Kbg6y0Igv3U6ufmGrB265Bb4husbezv4B3bpw6ZQB1LoE
 Vkpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789516138; x=1790120938; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6sU1+GmewT+E827XgAZjoHwEdPvSXGEEcY3O5jvmbYo=;
 b=SIQ2KbQDn8WOVOyF1ReZHsf1+vAwRyAepxj+BRX5rGMZq9qG3qm4eqQqNbI1UGSZvZ
 xJ9lURvg44qjIIp7sQ8A4ntNYYNc6xvpBCCejBaObjmFcONzIpCdQfH/tEV5jlDwa6J1
 xDK0r5LbPLs2UG+QOhrnnB1xvolwN7nDKQ1uJ9jwx3L4UXPJLYsNRtWyEBCF3/oOzKln
 YJhex6xJ1X6kgkZl4phKgVndHblWZp4DLje/E54Cg5+r/AzKE2yuona7nr5Yw0aNC4BP
 lQQoOYs/WgYmu4Yck/rb8HZxH6B8+nLADd5ea9W+8UcUoqZxdsDu0iUm4m6tJAolP8zc
 Ve2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789516138; x=1790120938;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6sU1+GmewT+E827XgAZjoHwEdPvSXGEEcY3O5jvmbYo=;
 b=ROMeKDlVmqxFXDMKT+ImFb5JXchH9GJxfp3wCrkoCQK8AjBbr0gawhOF14QaGzGih2
 UOhOua83+/rimZZrjbzwwFS59DzXduarwbsG2EETTZAYjPLNUpsh7cerv6V9iD3LMjjV
 dAdjkUSwP6Z1LlxTH4gV6p1eOQac33O5gK57BobNf0e8w5LPnDagLX5YSbYbG8sy6i+a
 48jcehvtVRvOhnlf+iV9xqzZXOvCEW2Uayu4AVczQTmVDh9ISsNrRPyaGD3y96HZSYnV
 xVgZNQ/pLxIUlgb9hAAGqoJPkNCSvmGgkmUqEqyqt6sN49kfilHWrWYuxnkGIktmcuZE
 NA0w==
X-Gm-Message-State: AFuF++mvNjCodZF0u6RZDq5gZMCAYOwPJzVw4KQMuCXN3VFUCfvsI9Gs
 eWu9fBMchLG4/tcrBIUguhGQoz278SjPRMIrglGF94ULn/DADcz//LKWcU+kZ7NtIP9A9bTrWb0
 blVSyN9SF0XFwqHggGzEsmFH7sOAYMXM=
X-Gm-Gg: AYBFou128zsk1ANun/p/De2uN+HVJEU6cvjn70HTgpdaOWZVSLe2Zd/ExCFns1tzqdC
 Ctar8aWj73RWaMAOq4U6U8+rKAqnal+RLv3OHgH2V8+a+haaQZwH/CyRBVWcpWTGSoEE7xYAMpQ
 Y5hHddHpnbxUC1QaVR12IZh1gWAXtThLx8YDrLpZn91hHTHrcRVusnQVpY7BoTzQNkVNum8ev5f
 lGlD+5ObqEOU/92Xb9YSobkkoufju/Br3AFueDLl4hd5vnO0VynJERu/kF4fy5sMPGJ+Tpaz1K8
 OvFu55G/1J350//PRowxBlLYQOaVrq+1avjDC3dDb/EA7X3nwtliEEtdt+veTFChRdDJT66ElyO
 1fmz+ZF3xuHTM6T8GCf1Apg==
X-Received: by 2002:a17:903:b4e:b0:2d8:d4d2:d136 with SMTP id
 d9443c01a7336-2dd76542f60mr66620835ad.18.1789516137571; Tue, 15 Sep 2026
 16:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260915154502.4106597-1-brian.cain@oss.qualcomm.com>
 <20260915154502.4106597-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260915154502.4106597-3-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 15 Sep 2026 17:48:46 -0600
X-Gm-Features: AcwNN1Ul74uHyq34WLVpFYCaYTQ0W-w4DRD2Jhx2q5BG8KmcpHzE_xkcxxP_2wo
Message-ID: <CAATN3No0uA4Q-oB8P7FbgK9Md=2daJewmqk2ibB-QX8EQbpQrg@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/hexagon: stage the PC in the PC register,
 drop next_PC
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="000000000000b32a0b065b8e316f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x632.google.com
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

--000000000000b32a0b065b8e316f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:45=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> Preload hex_gpr[HEX_REG_PC] with the next packet's address instead of
> staging it in a separate next_PC global; nothing reads the
> architectural PC mid-packet. Removes hex_next_PC, next_PC, and
> need_next_pc.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h       |  1 -
>  target/hexagon/translate.h |  2 --
>  target/hexagon/cpu.c       |  1 -
>  target/hexagon/genptr.c    | 14 +++-----------
>  target/hexagon/hex_mmu.c   |  4 ++--
>  target/hexagon/machine.c   |  1 -
>  target/hexagon/op_helper.c |  6 +++---
>  target/hexagon/translate.c | 29 +++++++++++++++--------------
>  8 files changed, 23 insertions(+), 35 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000b32a0b065b8e316f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15,=
 2026 at 9:45=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Preload hex_gpr[HEX_REG_PC] with the=
 next packet&#39;s address instead of<br>
staging it in a separate next_PC global; nothing reads the<br>
architectural PC mid-packet. Removes hex_next_PC, next_PC, and<br>
need_next_pc.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br>
=C2=A0target/hexagon/translate.h |=C2=A0 2 --<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br>
=C2=A0target/hexagon/genptr.c=C2=A0 =C2=A0 | 14 +++-----------<br>
=C2=A0target/hexagon/hex_mmu.c=C2=A0 =C2=A0|=C2=A0 4 ++--<br>
=C2=A0target/hexagon/machine.c=C2=A0 =C2=A0|=C2=A0 1 -<br>
=C2=A0target/hexagon/op_helper.c |=C2=A0 6 +++---<br>
=C2=A0target/hexagon/translate.c | 29 +++++++++++++++--------------<br>
=C2=A08 files changed, 23 insertions(+), 35 deletions(-)<br></blockquote><d=
iv><br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylor=
simpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div><=
/div></div>

--000000000000b32a0b065b8e316f--

