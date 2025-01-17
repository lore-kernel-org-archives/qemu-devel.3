Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEA1C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjuj-0002qP-IA; Fri, 17 Jan 2025 05:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tYjuh-0002pt-Fm
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:49:19 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tYjuf-0007jh-KU
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:49:19 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-51878d9511bso597145e0c.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 02:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1737110955; x=1737715755;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n4NuWJxOx3mu33CTYwEBJSMLzUPzZfqG4RG4jYeLOTo=;
 b=UDczaKdXS013DIsmIlV106rKCAwa37izHBMAN6rUU7RS9M548z6Bcv5+ZtffxTld2Y
 SGf0gSN3U5rfMJXDcQVQxzoekxKaI/k1cCRl0L31EE+HSmyh+4Nsne/dhw1gni/0IjUt
 ac3gnkFmHRUw7tBbY2owWoRcUfrEpLBbLmcTVyOhacPYO36H5/hgvOrHkbfluV6+FxRD
 O/aK2Q/1NJxWb4RqrNtnM8o2lt3iqzf0WWmXGlw2jXJL3zpFB43BpUp/ZrUbshh7iiiq
 opH5NabGbgvGpyQgwcM7W8B1JV0AujhddwEg/3enkrOS9lnzP+UMF3cMd3zIq+B2/uCJ
 XiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737110955; x=1737715755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n4NuWJxOx3mu33CTYwEBJSMLzUPzZfqG4RG4jYeLOTo=;
 b=VaMCggHSE0/roKKBv3P6luaKUYzB5hIHEU8XlPYIuGkAoj8WT3dU5UfdJHFCCw5CDG
 k2QKsh3Pe5AjeMk4D+lSBTpW7XGOkmIFF4DHilcAVmZKw4TUAd4Fw4J/WeOpDi3pg6Jh
 o3GIEWosRMIjCeaWUyrkTAHn7wOrZ24ui/P/r98VwsPttOrYcpIkFt9IuZktcLnTjc//
 pLKW9+7l9bFMJe+0/9idLNJ9tM98lh7ZDDAv3VgEBcBuWdP8Br5lZup5KlXT3vizUwqA
 q54AI3yD4JLgcIxiyomw8mvnpfQ8b/+7s7lwLVyAqJm+g2p7hE5ZLpCt2aw93EtS/aCF
 ToJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEqAqT0i7UD38YBSiTp655GA2fXqPpwxiKhJ+L/5v90RkIVWWPVIpOu7DrTCQXaGm85cnVz7yT+noF@nongnu.org
X-Gm-Message-State: AOJu0YzlFM6lNdhhwoqsFM6hk2tpT9c2DONRLTT2Tei6efpr03J+EFxN
 y++JTPniNJ04Pvus5dcLzakXJEsRo23no+lGrK2aqQjhogG9vwbXJeb/0Xki8MKz9lL5UDSUs84
 /0j1Y9vdLhOFGhlCxUhTfQoiKoqDcywXBWttB
X-Gm-Gg: ASbGncselkA7Mj8y12qkNmHiNCw725g3CBjDcbMqbpU/o47Iil9g2239ArTrmsVn54G
 e1wGndUa8rWCYw/VMX1JSWpgNHoWEZqYPHsElIQ==
X-Google-Smtp-Source: AGHT+IH4ij7t2YqNAHp50WuDuwXtNOKzSmwYgrR/K+Rp/DQeORqBQke3IdObKvN6pIfnPmahRiFcdZDdsdqNy3cEnTU=
X-Received: by 2002:a05:6122:8c3:b0:51c:baa4:122a with SMTP id
 71dfb90a1353d-51d5b26cb5cmr1328428e0c.5.1737110955435; Fri, 17 Jan 2025
 02:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20250116084332.1864967-1-dwmw2@infradead.org>
 <20250116221027.GA378432@fedora>
In-Reply-To: <20250116221027.GA378432@fedora>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Fri, 17 Jan 2025 11:49:04 +0100
X-Gm-Features: AbW1kvb4AeccwBqIzFVHnPiFJhTWZ1TstlsQUXoSrYiE5sx0D-GJpwLMYQbE0uk
Message-ID: <CAAibmn0Tsn9ZQ1wgoLLhCY=DQAkSDDtKBYOKKoSGmYe2TDTZuQ@mail.gmail.com>
Subject: Re: [PULL 0/8] Xen regression fixes and cleanups
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006f3e29062be4a92b"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a30;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000006f3e29062be4a92b
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jan 2025 at 23:10, Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for
> any user-visible changes.
>

This note made me realise that my feature addition (macOS PV graphics
device) that caused the regression requiring my patch in this series hasn't
made it into the changelog. I'd be happy to add it myself, but I don't have
a wiki account. How do I get one?

Thanks,
Phil

--0000000000006f3e29062be4a92b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 16 Jan =
2025 at 23:10, Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">s=
tefanha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Applied, thanks.<br>
<br>
Please update the changelog at <a href=3D"https://wiki.qemu.org/ChangeLog/1=
0.0" rel=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/ChangeLog/1=
0.0</a> for any user-visible changes.<br></blockquote><div><br></div><div>T=
his note made me realise that my feature addition (macOS PV graphics device=
) that caused the regression requiring my patch in this series hasn&#39;t m=
ade it into the changelog. I&#39;d be happy to add it myself, but I don&#39=
;t have a wiki account. How do I get one?</div><div><br></div><div>Thanks,<=
/div><div>Phil</div><div><br></div><div>=C2=A0</div></div></div>

--0000000000006f3e29062be4a92b--

