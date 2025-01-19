Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415FCC02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 10:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZShu-00046G-GV; Sun, 19 Jan 2025 05:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tZShp-00045l-Fr
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 05:39:03 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tZShl-0005zk-US
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 05:39:00 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f43da61ba9so4699840a91.2
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2025 02:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1737283136; x=1737887936;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hTYR/TZd3lfjEsk0qZI2beG1czTBduWfhBM/C4CL/0Y=;
 b=YWybSS5i/1vRMstQDXs5J0R9isIXGxeMAPWuJc3TFvPHbs4BjUoN0kIN4CHD11btMp
 LAvtsObVI6wut1bMIAwU+CUBSH8D3zUkJ9WnKpWqLsMuO7DwS3r/74/yis1SlUPXcDAW
 P2Rvd6mK2zLJXAZRgASqXrXwqRUAJYKZgWH667LQY9aFzHyd4zDkw0rCf7hm2b+0/2Yk
 JfpiPw0KBzaYEjgcCs6ne7Sf2TTjN69nXjQ62XwOivU+5X4d3p/xJrhG2vaYKxaonrIY
 ywYLndH7pJqsnvBeZn+LII6EVxr5GpGJZysJ7me5UiKeMEtignO8XG431m89WB/kn4ol
 TW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737283136; x=1737887936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hTYR/TZd3lfjEsk0qZI2beG1czTBduWfhBM/C4CL/0Y=;
 b=bIdqcB1Iq8hzTzsFDQbesFWIl2rbuw4yl20j/Z67mqt5wxq3JgS3C33gJZeqijaxtL
 TLIP6RswQQo/vLmKF8T+YWSKkIeIjsavAkXgjGmW5L5JC6j/AaSGpFfXdTDNd9jAX3I9
 wqynKs7zUu7YefbM9Wly+4rsljgmmJaFdqQfbDhKuiFlRalfDgS1C+0t+ukKAEAKETAW
 w4/SmwRz+mpUWUEOYeMN6LGxyd5jKXZg6pqa2Mhpf8Bhi4Yr5q1grVQT6qt4WaCbj0MW
 FlT0Lng3cI/p5ruyVpb7U9JjWX25+QQeJQTD2acLZlF4Ha0hRPydTB6bMSumvIxHUuYM
 91pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLJ5P/4bjOphQ8A9DGZw/MYAUEjOLtUG/wZNRKka8j70O7CMUIjNmsATgxzDAj2gXPBS/UDjKyAeYZ@nongnu.org
X-Gm-Message-State: AOJu0YzkvAvWwoc6J+p7VqjCpAxNWjanhr4arzN+aZxigUNVNxhejLa4
 BQr46q4k0ZgdpNGPn/I0JIZ0aIewAq28Lr1E73YkMTTVfBBPCD+NfcU62Utki4UfHIGSGB26DA8
 GDpsat97BTjVa7nPFKQJMJMCNTpQM9Y9WVCKW
X-Gm-Gg: ASbGncs3tr/ynweYbJLpk8NQ7NcXmJP2l6xG3/4IzBPga7rmjQEdJ+1HptLblTLmlPC
 SSoPj5+iaDZLFX+aoxcPIF2FD0vr7QYyWH2/d2zwbr2cFyoaF2Qg=
X-Google-Smtp-Source: AGHT+IGa5NK6cSfCccadkW2aZtxNNCRzIV7C0X3zlyvfbW3Var1jMqRiMqECz1+e9XziXOeukEe1EFF6XLes8q4bocs=
X-Received: by 2002:a17:90b:5483:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-2f782cbd9eemr14763143a91.17.1737283136080; Sun, 19 Jan 2025
 02:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20250117172842.406338-1-npiggin@gmail.com>
 <20250117172842.406338-3-npiggin@gmail.com>
In-Reply-To: <20250117172842.406338-3-npiggin@gmail.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Sun, 19 Jan 2025 11:38:44 +0100
X-Gm-Features: AbW1kvZiAN0tObTW3s1gkrpjFgjdOY9f78Us4yj9T42TIF_4_fpyQZ6KCZNXy7M
Message-ID: <CAGCz3vtDjaVnWbnZdKQSEReoWdtrMpyJGVkzXu4Q8XaVPYciFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/pci: Assert a bar is not registered multiple times
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003367d6062c0cc05e"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::102d;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x102d.google.com
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

--0000000000003367d6062c0cc05e
Content-Type: text/plain; charset="UTF-8"

Looks good to me. There is a risk here that the assertion will fail on
existing code. (Unless you've rigorously audited all callers, which would
be quite the task.) However, I agree that this would constitute a bug in
the calling code, not an issue with this change. Since we've still got a
few months left in the 10.0 release cycle, I say go for it - hopefully such
bugs, if there are any, will be shaken out over the next few weeks.

On Fri, 17 Jan 2025 at 18:29, Nicholas Piggin <npiggin@gmail.com> wrote:

> Nothing should be doing this, but it doesn't get caught by
> pci_register_bar(). Add an assertion to prevent misuse.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>


> ---
>  hw/pci/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 2afa423925c..b067a55c5bc 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1391,6 +1391,7 @@ void pci_register_bar(PCIDevice *pci_dev, int
> region_num,
>      assert(hdr_type != PCI_HEADER_TYPE_BRIDGE || region_num < 2);
>
>      r = &pci_dev->io_regions[region_num];
> +    assert(!r->size);
>      r->addr = PCI_BAR_UNMAPPED;
>      r->size = size;
>      r->type = type;
> --
> 2.45.2
>
>
>

--0000000000003367d6062c0cc05e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Looks good to me. There is a risk here that the asser=
tion will fail on existing code. (Unless you&#39;ve rigorously audited all =
callers, which would be quite the task.) However, I agree that this would c=
onstitute a bug in the calling code, not an issue with this change. Since w=
e&#39;ve still got a few months left in the 10.0 release cycle, I say go fo=
r it - hopefully such bugs, if there are any, will be shaken out over the n=
ext few weeks.<br></div><br><div class=3D"gmail_quote gmail_quote_container=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 17 Jan 2025 at 18:29, Nicho=
las Piggin &lt;<a href=3D"mailto:npiggin@gmail.com">npiggin@gmail.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Nothin=
g should be doing this, but it doesn&#39;t get caught by<br>
pci_register_bar(). Add an assertion to prevent misuse.<br>
<br>
Signed-off-by: Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com" tar=
get=3D"_blank">npiggin@gmail.com</a>&gt;<br></blockquote><div>Reviewed-by: =
Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu">phil@philjorda=
n.eu</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
---<br>
=C2=A0hw/pci/pci.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/hw/pci/pci.c b/hw/pci/pci.c<br>
index 2afa423925c..b067a55c5bc 100644<br>
--- a/hw/pci/pci.c<br>
+++ b/hw/pci/pci.c<br>
@@ -1391,6 +1391,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_=
num,<br>
=C2=A0 =C2=A0 =C2=A0assert(hdr_type !=3D PCI_HEADER_TYPE_BRIDGE || region_n=
um &lt; 2);<br>
<br>
=C2=A0 =C2=A0 =C2=A0r =3D &amp;pci_dev-&gt;io_regions[region_num];<br>
+=C2=A0 =C2=A0 assert(!r-&gt;size);<br>
=C2=A0 =C2=A0 =C2=A0r-&gt;addr =3D PCI_BAR_UNMAPPED;<br>
=C2=A0 =C2=A0 =C2=A0r-&gt;size =3D size;<br>
=C2=A0 =C2=A0 =C2=A0r-&gt;type =3D type;<br>
-- <br>
2.45.2<br>
<br>
<br>
</blockquote></div></div>

--0000000000003367d6062c0cc05e--

