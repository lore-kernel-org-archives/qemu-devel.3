Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD70F3D332
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyByJ-0003so-N3; Thu, 05 Mar 2026 11:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vyByH-0003nr-RL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:54:45 -0500
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vyByF-0002kr-S7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:54:45 -0500
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-2be3bdfda8eso1262581eec.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:54:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772729682; cv=none;
 d=google.com; s=arc-20240605;
 b=I30EeHLhbzwgg20wGWH2DLqGGhb5AMy1JsSuQI8QBYiJ5RQvdfE+KmDmQ9hwC7I8S9
 V42SX0oix5Xb9euhUgmZAfUgjNgMAyTmcT9wREB+cq1rXJESbYQiWNXdVFRARKIwY2Vs
 PsKFuS/rNq8rZ/lAePbm29I/XFl4LgQACYyXQFlxZahX0fuXquEygQVRDJw9Imr+RUEn
 jXCEg+rlpIxKoE8JogOf+wDeYYm5WzUHnNHNyLYmCLwQI3puqJXm6yELY2moof/K7yvu
 06DRKNjSdRJXYp5hAR12Im9yHeZAfuampUZjIXvbnCLfDsF8KhqX16PTlpcOy88tQH0q
 E0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JN3yz4yDvne1ASqd5+8mt8sQQ2HcG1i6fNccUip6zrA=;
 fh=Pl9qU+tku27Roii/thTg9NkME+EbUadYMX1EnsLfscU=;
 b=k+JtGqmwfTUiYgzt8ZHgh34pdSUxakB55GwPv28QdG4XASNLC6yxAeZ7LD/a7YAe7r
 Iy0DyD9wOPegRlaGe9BPUtWnkWbLc4DlboPCTeqPSqvRYfU/cVUEsdyVoBUZs6a2CBRh
 ld+GVqI4REJcDxTo89UQc7upjkjzJM/+AkU7y749L8pCls0nG6L/Og2ighnr6zuICIoK
 IuaP458RcCfYP/MC6ecQHtR8BaEG8UN2cDlwnnuGFWE9pmbR/T3I9MsdQQ1utqHQ/ZPJ
 m5b2tIlwSHYGhml/iIwqPcB/DK/9qBodiFDqJzamIQLQz/sW/P7stpcqHdFoWfcXBiV7
 50mQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772729682; x=1773334482; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JN3yz4yDvne1ASqd5+8mt8sQQ2HcG1i6fNccUip6zrA=;
 b=DrS/hv9O5yvZ+80prz4aedf40VXakgpsOK9sY0Z8YNhoSuUVX80dwtsOOB7yMh8nEE
 9yN4NBaLIk7F59VTKHqktTYvl9YgUg6zwdva5CL+P9S1K0S5NoLVdNM4RnownnPSXFDI
 Nf0U1YNTQ2cf0vmj/GtYjDzug5uGiDfaKPR+Uy6B8S8BlMmuBA/Fm5E5Gdi5WDLiE1px
 0laSVtpLvSfy30L/4tESTVNHWkM0E8DnyJTZaXX1yduEj1cZ9jHK0PCaKx9RzdIHaT8h
 Jrew2r3mz/+aOACBxpPvnCww/d4gTCCvHY40PEYynbmW2UZegN8U/K65eFIYnVmCkaSF
 AJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772729682; x=1773334482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JN3yz4yDvne1ASqd5+8mt8sQQ2HcG1i6fNccUip6zrA=;
 b=TvvPlhHwvuP1JbeLiUQc+KjFRGGPfgf8pwJYvwSeg5ExXoZBF5fuy28NcToUynZ13W
 rYV5JXEEWIiWtkxGqU8pdTLaXVpLWNTyEsGwfn+Mw2G5O4u2eJwMlEHKQ02MFni30Eaa
 O868K9KNEfNJDxrRGDJ6bKLfXoY0cuhS8BJahaWA4Y0sD17c/pP4ZEHmkJVMt0rFXQbB
 Y8K3X+5qS/TTbXI5XO/iClqt7CHFsAfl/GAGT2unvyoPU1ODNd4L8QLlIxZya65PVOge
 SChiaVxL+DCmwVrP2u3zqQ+c49bjXgsnc7U+K/rvY4DtQMdTVqgvXkwZwW0kBdjwxExs
 a4vA==
X-Gm-Message-State: AOJu0YzeBqjfozENGPnpduNTAJHvj+aMw1vODsiMZNNGC8IOAA5FJ3La
 NIpvOVZ95SSeO7kXMDm4IZ3cFyW/vV6eBZlU2ovINcijnRwQqx2nIWFtVVnM+tQCDjU97eYhdcW
 x0tu0ynMQ3EaO6MLz43XuoB4JlobqZvA=
X-Gm-Gg: ATEYQzxvKoyxWzdlLOJh1XJxlhfgiJJFuTQ9nVb4ZU3xE0/SyHnI0pYtGB+R5H/VH00
 WfB15rf4APWQcfrOtFT2zyVkCbQRJjOdFDpkoA/4ywUSTFPq7L8Td/m/OI+SjIgw5PCzB+f2MnK
 rRE2iHEliWHoSmIQCEG6T2aG1tXJ7jvviiBgf5owXg56bsWROMN2kAjWyXhCatHMROVzrxeWhNQ
 hcRBH3iT2zHzKQh79RRhQsXTb6wDXtHOnArc5LwZyMJwo1/HXTEWEBzXIowj52oHMoYNejXINnV
 VtZiqjajqIilJISqTw==
X-Received: by 2002:a05:7300:7251:b0:2be:1946:8587 with SMTP id
 5a478bee46e88-2be4aa03e8cmr187181eec.9.1772729680284; Thu, 05 Mar 2026
 08:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20260305-xilinx-phy-protection-v1-1-ffc9edd84e58@linaro.org>
In-Reply-To: <20260305-xilinx-phy-protection-v1-1-ffc9edd84e58@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 5 Mar 2026 10:54:27 -0600
X-Gm-Features: AaiRm50vAdVBWD0lXiym5vkC4o8PFO7MdEU108X6AsEyT-cFzG33NfqMJmeelaM
Message-ID: <CAJy5ezrJ94SEuK2Apd=Fs8azi8Z9YZYWdLpE4GziapQNi3brSA@mail.gmail.com>
Subject: Re: [PATCH] hw/net/xilinx_axienet.c: Prevent writes to PHY
 Identification registers
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e04f27064c49ca69"
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-dy1-x132a.google.com
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

--000000000000e04f27064c49ca69
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 6:13=E2=80=AFAM Jim MacArthur <jim.macarthur@linaro.=
org>
wrote:

> There are other registers in the PHY model which should be partially or
> entirely read-only, but this solves the immediate issue.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3297
>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>




> ---
> See:
>
> https://gitlab.com/qemu-project/qemu/-/issues/3297
>
>
> https://lore.kernel.org/qemu-devel/CAJy5ezqTAMr=3DA3uAfmuWLepK66AdLRu4Q8A=
mFMh4+4q2HtDrkA@mail.gmail.com/
>
> IEEE 802.3-2022 does not explicitly state that these registers
> should be read-only, but suggests it in 22.2.4.3.1 which says this
> information should be entirely manufacturer-supplied information.
>
> The standard does mention several other registers in the set which
> should be partially or entirely read-only, so further work may be
> required.
> ---
>  hw/net/xilinx_axienet.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index d85f8bb23f..970732b162 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -141,6 +141,10 @@ tdk_write(struct PHY *phy, unsigned int req, unsigne=
d
> int data)
>      regnum =3D req & 0x1f;
>      DPHY(qemu_log("%s reg[%d] =3D %x\n", __func__, regnum, data));
>      switch (regnum) {
> +        case 2:
> +        case 3:
> +            /* Writes to PHY Identification registers are disallowed */
> +            break;
>          default:
>              phy->regs[regnum] =3D data;
>              break;
>
> ---
> base-commit: 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9
> change-id: 20260305-xilinx-phy-protection-c396a658d072
>
> Best regards,
> --
> Jim MacArthur <jim.macarthur@linaro.org>
>
>

--000000000000e04f27064c49ca69
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Mar 5, 2026 at 6:13=E2=80=AFAM Ji=
m MacArthur &lt;<a href=3D"mailto:jim.macarthur@linaro.org">jim.macarthur@l=
inaro.org</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_contain=
er"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">There are other regis=
ters in the PHY model which should be partially or<br>
entirely read-only, but this solves the immediate issue.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/3297" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/3297</a><br>
<br>
Signed-off-by: Jim MacArthur &lt;<a href=3D"mailto:jim.macarthur@linaro.org=
" target=3D"_blank">jim.macarthur@linaro.org</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.ig=
lesias@amd.com">edgar.iglesias@amd.com</a>&gt;<br></div><div><br></div><div=
><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
---<br>
See:<br>
<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/3297" rel=3D"noref=
errer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues/3297=
</a><br>
<br>
<a href=3D"https://lore.kernel.org/qemu-devel/CAJy5ezqTAMr=3DA3uAfmuWLepK66=
AdLRu4Q8AmFMh4+4q2HtDrkA@mail.gmail.com/" rel=3D"noreferrer" target=3D"_bla=
nk">https://lore.kernel.org/qemu-devel/CAJy5ezqTAMr=3DA3uAfmuWLepK66AdLRu4Q=
8AmFMh4+4q2HtDrkA@mail.gmail.com/</a><br>
<br>
IEEE 802.3-2022 does not explicitly state that these registers<br>
should be read-only, but suggests it in 22.2.4.3.1 which says this<br>
information should be entirely manufacturer-supplied information.<br>
<br>
The standard does mention several other registers in the set which<br>
should be partially or entirely read-only, so further work may be<br>
required.<br>
---<br>
=C2=A0hw/net/xilinx_axienet.c | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c<br>
index d85f8bb23f..970732b162 100644<br>
--- a/hw/net/xilinx_axienet.c<br>
+++ b/hw/net/xilinx_axienet.c<br>
@@ -141,6 +141,10 @@ tdk_write(struct PHY *phy, unsigned int req, unsigned =
int data)<br>
=C2=A0 =C2=A0 =C2=A0regnum =3D req &amp; 0x1f;<br>
=C2=A0 =C2=A0 =C2=A0DPHY(qemu_log(&quot;%s reg[%d] =3D %x\n&quot;, __func__=
, regnum, data));<br>
=C2=A0 =C2=A0 =C2=A0switch (regnum) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Writes to PHY Identification =
registers are disallowed */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phy-&gt;regs[regnum] =3D da=
ta;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
---<br>
base-commit: 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9<br>
change-id: 20260305-xilinx-phy-protection-c396a658d072<br>
<br>
Best regards,<br>
-- <br>
Jim MacArthur &lt;<a href=3D"mailto:jim.macarthur@linaro.org" target=3D"_bl=
ank">jim.macarthur@linaro.org</a>&gt;<br>
<br></blockquote><div><br></div></div></div>

--000000000000e04f27064c49ca69--

