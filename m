Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CB6C5321D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 02:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shgu1-00058F-Gu; Fri, 23 Aug 2024 22:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1shgu0-00057l-B0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 22:53:20 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1shgty-0003qW-G4
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 22:53:20 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2d439583573so1903704a91.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 19:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1724467996; x=1725072796;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x8wiF9/m0Wx4dwiAPVIyAvbM7sfZYX3AslMzV/OlkTs=;
 b=iP8KJ021GqxAn7nHAuErRpcYpV+z5+pEn9Fgb4GFLRxZSXOLMH9aMzd7oZbF/2ihR6
 jSf+xcvfS1FDD/oANYlyA+v/aoDkxOZ70ByFYYZL84xZGeaMyuN04BDVc2b1AQPZY+Q4
 DbmMY5SOIqTfj7aK6mhq4kTRAa9EQ9F8uae2l1ea240y/iiSFWmdxJbHhsnhCPAO1fzG
 sOGiKbDDT3+iDViA1CqDEOA45gVO+w9adrYJAVv2DfCYGPLOH+qb7G6UhntLw1nl9TcX
 bwxkC4TcU3nRxkyqhh1xgFmtSjS9bPVFRkL7VLnJ2hzUI9wAo3FzyYj0rcKvbv7jbjCU
 lfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724467996; x=1725072796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x8wiF9/m0Wx4dwiAPVIyAvbM7sfZYX3AslMzV/OlkTs=;
 b=RDjRtVu9NQdPVvgT2dBl8GYJkl64Pz+fTA5XoqJqpfwx9+C7f1Wxb10e9TyrfidbVX
 xAJXysMg6FviN/Ff+k6B/6LQX2gAb+Bw556n/Cfd/fFfQSt3vgYf98LUxjHcNBVWxGAF
 X+LUpAaNXjYX0s676KqPI+rYvySjE7YOBFRF3fGIv3avavs4BzhF7uZpGPkG2+jz6r/9
 X3P+w+ployrLIdK0Z+Rp+u4pnCMA0q3FHOwGgAW5Fd91+s+r5qixC4ZxIGQQWM3METzF
 MZDZ8V4oViM1P02e29dyDsH+G2ZtD063vA9thgK7PUS4yVoZD1m3bwvTDC7LYkzBMEjk
 VsqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxI/Gx4jXIAQnL0GsbOgn1832jLsEG4xrR3s2bdcQhFT1hmr//bi7IM8pP++BG/XtMgirCcslHsXQ6@nongnu.org
X-Gm-Message-State: AOJu0YzW+EB6qMFA1ZCsC+6+howxJdeFugi6C9ytsmNfFsliP9K8Q27K
 7xv//FP4DrHNcZNwNYl3rGE6XzcScLRZG/NGme9qMh0CGk6QmFsgvkaORrEeEhtSzNfrKj7M7Nc
 1pTAuwbqA1UwozI63lE6fFIlxobIMOzZBT9S62w==
X-Google-Smtp-Source: AGHT+IHwBXzzlWXxZo2/DoZyRr3c8uCjoYR1OqQ/wKD+GufdCcAHe0aQI1bTKK8bgwtOHh3KZQuHreQpeS2u1QZkeHo=
X-Received: by 2002:a17:90a:70c3:b0:2cd:b938:770b with SMTP id
 98e67ed59e1d1-2d646b8bf2cmr4178515a91.5.1724467996195; Fri, 23 Aug 2024
 19:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240820050848.165253-1-richard.henderson@linaro.org>
 <55f5a246-b16f-4cd3-b503-b9b37e7f835d@linaro.org>
In-Reply-To: <55f5a246-b16f-4cd3-b503-b9b37e7f835d@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 23 Aug 2024 20:53:05 -0600
Message-ID: <CANCZdfpf_-RrpsENp8xZ3xGEXzUvtf480264esEWkH76NSD6Kw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] *-user: Handle short reads in mmap_h_gt_g
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 gaosong@loongson.cn
Content-Type: multipart/alternative; boundary="000000000000571acc062064feab"
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--000000000000571acc062064feab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 4:34=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 20/8/24 07:08, Richard Henderson wrote:
>
> > Richard Henderson (2):
> >    linux-user: Handle short reads in mmap_h_gt_g
> >    bsd-user: Handle short reads in mmap_h_gt_g
>
> Series:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Series:

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000571acc062064feab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 20, 2024 at 4:34=E2=80=AF=
AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 20/8/24 07:08, Richard Henderson wrote:<br>
<br>
&gt; Richard Henderson (2):<br>
&gt;=C2=A0 =C2=A0 linux-user: Handle short reads in mmap_h_gt_g<br>
&gt;=C2=A0 =C2=A0 bsd-user: Handle short reads in mmap_h_gt_g<br>
<br>
Series:<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br></blockquote><div><br=
></div><div>Series:</div><div><br></div><div>Reviewed-by: Warner Losh &lt;<=
a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div>=C2=A0</d=
iv></div></div>

--000000000000571acc062064feab--

