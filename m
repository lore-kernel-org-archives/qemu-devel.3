Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1B110FC454
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 22:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAavu-0005Lj-8w; Wed, 08 Apr 2026 17:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAavs-0005LV-Hm
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 17:59:32 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAavr-0001ru-60
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 17:59:32 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-82cebbdab08so220391b3a.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 14:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775685569; cv=none;
 d=google.com; s=arc-20240605;
 b=hiPZQPZwmXTqpO4obtGIlkPEzCSqPJX2SmUeqykdPKgJ4ofidfiTdGwq1yhVa4u7kI
 KoLESmaW0f2EdxDxMmO8xOeF1HJjxeqhUkRtzhOxLii65Bnl/D2/G7jPrpSWoZm3COqI
 aFIuMxGWVK+saRz/gjDHY5wdtQoqtGbiOJVBsRM8gOpIoxuAWMvWsxRyz1FnLxYhv0k1
 W3wtGKsNta2mjHeyT4vrXIy+KQA7aCK0OHe29YqcoWNEfJRuWhEHuVSvvJVSzN6XXvdP
 z58rXbrd/wM5y2cRiqXZ+YNIHcU5w/xXFJL7OjZjRhgPnFfX1PUrjMZXdoZETx8vszfN
 C4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QEt1yUhp0PXPLCsOk2XU3gSGTubo79oY2CdJf2p1MgE=;
 fh=seHpsuERei6GoCJPMtZiXpXOw/2EVnvuQ7nSTREwIqg=;
 b=GNdTrlM1jmP+EDx5x4NaF5AZuBxLqe2hRmzgB+jTBU4hesggInH2Pz/pjrFTHSaggC
 UfGMLjWaZjbOoSpaqwRyJGrbuzWEjV9+HaFBBEM0PVzUiJyuMFUelc2IPPMnGwG3WQGi
 6U4XP6yzw1dpaOM/vrSgMAELJ1u/9gOHAELMcCtxERIf3AjBXyV+qwVCYHy44VOohm2f
 F2NLArxHdzjzn6auF+L0Qey4fP3Jd5v5YYil+clpyKoHEJFij9Z3I6U6/N40YrZl73Wg
 alLvJzhTQn7GJwxSIGGzIQqg+xo4zYzuxqyCkKwP0wtAIPhi7wmpLFUynADkbm/Rg3bz
 ss5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775685569; x=1776290369; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QEt1yUhp0PXPLCsOk2XU3gSGTubo79oY2CdJf2p1MgE=;
 b=mf4w1CSNJACPryN2fWgHpA5JA4RizAkZqIzzpYTYvmdJSqZT6xiyc1qDz1b2rzfeXs
 KUagLQyUuoICOcg28kGmvdUGrlHiTMveTpiKQ134CQGrOBZ6QsLX4fCDmcMrYUjXf8T1
 B8UbRxCQPvBUqumvUE5EZbbwu7WKvzU5tnGOoQCURpI2GNO6NtvJIXcffSgAqySFiz93
 7kUSqFPUAEyPlFBFHI1nJmFlgloWkA110vTWwrwfD/1jVr9VgLHeufx918lossXuuA1p
 WakGqui60wDdvYmAGKhWr9wV+dJ0ROPvaGFM6lcP4rqvC5vWX1tvb9Yza6S6KNfa121U
 cL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775685569; x=1776290369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QEt1yUhp0PXPLCsOk2XU3gSGTubo79oY2CdJf2p1MgE=;
 b=VR7AWF4cNUQhdHVN5xIw2Y0jpDm4JXZ2VMvp4yX2Zq8N6+aWhB151mE4GUVZKOZj0L
 Mh5tC4UCeipsUMHHvIQxhKe81nGLflr8QN0f/SRys3aTsarOi+jeH2L+qTiYkm7NtHu+
 Wc45ZCQ3ci4fgWQJLeNd3Jhyanp8Ktv84FXYEzOfIKEXewYQytSZd01k10MIJk8iKjWO
 F6GS6gA5cnSWp63gMpPLbqPH0ZH5Trc59wUddUFxJddeppOah4aePPyof2RFZi42esh5
 EpoP/IJMtJoI5ZpgL7BlJ2HFIxo4IeTdCBVTvyin8IJkvjmA2uiB6tzuvRZVIzgEuVBB
 7YKQ==
X-Gm-Message-State: AOJu0Yxr78JCvV/qExs0rqgC5/qx4Jre7sf6fBDNMjEw9JzFutLz0fK+
 QbEF4M/zxCeEDaDB/TKgy+SMz7J6xUPU8RDEa+WDgfNfubq06UXl6SrpAZ2himTLrctm42fArcT
 BYXW60GVSuPJ7TB81o38u/OIM0nopIdE=
X-Gm-Gg: AeBDietLwDVECDocdRi2qoY+G6iORiI3X97T72N4yEynX3gTXq1o8Evu/3w+vGmef6u
 8uDhqpR2LXGX9tWtFJbMsH1lRbcvcUKofv8B7CrEf7xSVZ3hSu02adhc4yy8vnf1TS3h9ZIKZ6j
 K5xAioESNkIIrVofxT7G+A18kq4vAvBOaJ5T0sinh2dP0u4vSU4qjZ+pjUWVTwPbI+WKalqseY9
 s1KIOHFRtIvr0y2D5huMUYct4B99YXFYr7PCTQihlvyF9+3BntKdreBIEs2nJ0OmJtIzSfcQPG2
 LsSZPd4oqnW3iOuRbcV+3r4iUHX9uFURneKUsn4=
X-Received: by 2002:a05:6a00:4b01:b0:82c:dfeb:2ad9 with SMTP id
 d2e1a72fcca58-82dd8b3d698mr1142491b3a.53.1775685568776; Wed, 08 Apr 2026
 14:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <d7cc954b233ff2a1d7424eb48338473556bac78c.1775665981.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <d7cc954b233ff2a1d7424eb48338473556bac78c.1775665981.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Wed, 8 Apr 2026 15:59:17 -0600
X-Gm-Features: AQROBzBH7D-5Jm4pOcF3Y7bGakTJ-jlnhb3GsXpt5FKUytx3u5UF7iCxABSfDIs
Message-ID: <CAATN3Noy-4Qirxq6OfitkVq36234mBVj9E2waH33hfZ3gn5-Gw@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] hexagon: group cpu configurations in their own
 struct
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng, 
 anjo@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="0000000000008f4eac064efa0337"
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x435.google.com
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

--0000000000008f4eac064efa0337
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> This will be used in a follow up commit.
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h       | 10 +++-------
>  target/hexagon/cpu_bits.h  |  7 +++++++
>  target/hexagon/cpu.c       | 14 +++++++-------
>  target/hexagon/translate.c |  6 +++---
>  4 files changed, 20 insertions(+), 17 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--0000000000008f4eac064efa0337
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 8, =
2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This=
 will be used in a follow up commit.<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 +++-------<br>
=C2=A0target/hexagon/cpu_bits.h=C2=A0 |=C2=A0 7 +++++++<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 +++++++-------<br=
>
=C2=A0target/hexagon/translate.c |=C2=A0 6 +++---<br>
=C2=A04 files changed, 20 insertions(+), 17 deletions(-)<br></blockquote><d=
iv><br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylor=
simpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div><=
/div></div>

--0000000000008f4eac064efa0337--

