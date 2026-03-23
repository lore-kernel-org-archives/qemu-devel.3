Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5B3F483D7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4kqt-0002Sx-ST; Mon, 23 Mar 2026 15:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4kqs-0002Sc-Pa
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:22:14 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4kqp-0002mM-RD
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:22:14 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8296d553142so258998b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 12:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774293727; cv=none;
 d=google.com; s=arc-20240605;
 b=GO2vdsB+WF25bUe3K5tzwuCYdfv4cwWN0zARzhsctSbBZWVLSJVtu1HYzft9HIZPk7
 Lp2yX8ZdkbGCE4iHyguPNdmutQCPGsbtrYJ14Jvcz8p5aj37TgwTXgQceH+FbWtQUlQ+
 CEoYB0+Y0tcViGOP+esYx4k0mw8w+ijKdRq7V/nTY68xUncY3HivHTnLHfLTTMZUMi8z
 q/l4QDQl4r3ivY3QonnaM2F3fPmFB71Kyv+HGxLgGI31S+sz4ZEl+d64+v94lB+lgxod
 LkSbR80G0cwbVbCTCjV/ruuCQKWnq/1YeZ0WC+d4TqS9Xug+RPaLc8zkemehPeknpjdl
 ggEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Nr+vjzv3rB2Aa0Q6KmzyyoNamR1MTJixVS8ztkSHrm0=;
 fh=uv1tA9xklsQ23QRRVuZ5ICrQzjqlbIWk8lB36BxPINw=;
 b=fcRORhSxfWpKNfgVO/TJUBSjezPXTZFB0ABdEwxljBFVScFHwfIbgS9sqJ9aZ8hBv3
 P0q75AfyNedWirq5bnGzf6Bkg+v/2ONzb2EDsZSOISCyXB9AEvSaMUIDxCOxflhE36g1
 VYDyC57ycesUzyuDUI46X3U8lxR8P0m+cvTkUgXUY3BJjphT9SHkHnprUuR241L5K38A
 k9l5noOx8VRp5fnGrJaZI/4wADQXF/EAvjRfkoiyeke7E0TlWA9LY4QrsM2iGDynzbuX
 ipxzfzHagcRUjGoZw19KyHOAHX7WBZ96hVJEUO3ecTGbjVlQ0jcWpdbL1XDUbmdBRkNe
 mAYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774293727; x=1774898527; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nr+vjzv3rB2Aa0Q6KmzyyoNamR1MTJixVS8ztkSHrm0=;
 b=sLYze1v+ou1rklYf1Iw7nr19gS1VUv57qIe/nO3iDlADNg2HDrnCJHreTJg91v9h5p
 ENkNamlPL3lJAuKVb9WQmU8b4gExpx0eL6uxpq4R3x0Ku4e1b6U2/oE0gkym1k31Bc4B
 W+upQ6GrEv+skwFk/apC+OnE5PXxTN4E2FC9pRBeT4EXln86y7hNjIZCDZF7PxIFl95f
 MSNx+fa7p/+xjTfMOYPp0jeOquQn2ugt0+7zNnUHD7L2AF1pCiJCoOl8o+LUWRh7Haa1
 agrMwA91s2HRNKxgPpyPPfj2eRtLa01oxTTOU6MSrdWJd1T3zCKBwYYUYqIL7H9f3E9c
 KZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774293727; x=1774898527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nr+vjzv3rB2Aa0Q6KmzyyoNamR1MTJixVS8ztkSHrm0=;
 b=rIEHo/BG6+O/zLPDgCmRoVTUdLfWBal9w3PJ1RAJSZ/Gn6SNCjoC0EuTeRHEHCZF1h
 vj+Xm0AJsleNsvuO/mnCM0ogcLNAW3P3Cu6joIv7kFVz3eYXOuHbutENRS1/+kCM/vOQ
 RYCOMNJR+puRdQ2P/uu2uewlzQYhtPebdtTUsPqoZZwwH72DnK8Wi5pTsL1St6pr+NKj
 RpXqz27P+wlQBmA/99SyRnyl4HcCuvvf9h0q16kQXC10UcwOR9UBKGB/Clys27cNlJZ+
 Zk32ayBcV2BzXrE8nSLcDOd3/CXLQ2G+wZ+mAFm5CbBsdEfVhUG0K0F1lwnobzHIllWQ
 1HHg==
X-Gm-Message-State: AOJu0Yz+m/Htl41d7PJftzs0os6ieIcaGzhaF/Gy68RWR+MqZSb8Kxmj
 eJ3zrnDvogjMTf3SNy56EndWk0Dkrw3ibhcNd+3MkzTaUedBbOrbviFke6yAopvcss7ZJ6zHK7f
 3chpKsPVwnJWMVZdJYmRMmxV5u0xnP5A=
X-Gm-Gg: ATEYQzyZwD+7goF8YJWg0wluaU4x2z2bqgwn2BvjnUhgRQAcVKcBSDS3gujBAVysRS5
 l+8zJ2kpV2vxi0+P7lUen+/lUrjIXuGZngEnrY1D3OyTXA8k1FHh/e0U0hecLAVwJ4L+O0C+W6j
 KjBCHGOSntW2Bl/S/bi9OifbSeAjnmDWs/qsgelWyKHv8sylHKRizyXKnxPIY/OS8hlC2U5Ma3u
 l/N6JLzLsu5vDOlMWKoMNvcFVG042MuNOe1l/hWZ1sBIQrCSaTwo0d4qDKbYtnG5qjs3tfaZodc
 lPuL6agcAcN8758ZbwNwJtcf4hZE5ydHcOVVv90=
X-Received: by 2002:a05:6a00:3986:b0:829:7e6d:cf1f with SMTP id
 d2e1a72fcca58-82a8c3a0277mr10476359b3a.51.1774293727215; Mon, 23 Mar 2026
 12:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <dee3cd0407272dacb1ac617e6179943168fb0691.1774271525.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <dee3cd0407272dacb1ac617e6179943168fb0691.1774271525.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 23 Mar 2026 13:21:55 -0600
X-Gm-Features: AaiRm51-lP7SsdXbTPo2ZojHZBHMHKGzP14guUgu8NAzGb76G-RrdOutMVA0ZbE
Message-ID: <CAATN3NpYyA6+++vptA_CXE_0Yxffm+chn8p7NHRGGYM8N4e4vQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] target/hexagon: fix incorrect/too-permissive HVX
 encodings
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="00000000000056840d064db5f32c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x430.google.com
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

--00000000000056840d064db5f32c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> The following encodings have become stricter since v68:
>
>     - V6_vunpackob, V6_vunpackoh: ---00 -> --000
>     - V6_vaddbq/hq/wq, V6_vaddbnq/hnq/wnq: ---01 -> --001
>     - V6_vsubbq/hq, V6_vsubwq/bnq/hnq/wnq: ---01/---10 -> --001/--010
>     - V6_vhist, V6_vwhist128/256, V6_vwhist128/256_sat: ---00 -> --000
>     - V6_vhistq, V6_vwhist128/256q, V6_vwhist128/256q_sat: ---10 -> --010
>
> Pre v68 compilers, by default, already use "0" for the non-specified bit
> that changed in v68, so unless someone is manually writing the binary
> encoding, this should not cause any backwards incompatibility with
> pre-v68 binaries.
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/imported/mmvec/encode_ext.def | 48 ++++++++++----------
>  1 file changed, 24 insertions(+), 24 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--00000000000056840d064db5f32c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23,=
 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The =
following encodings have become stricter since v68:<br>
<br>
=C2=A0 =C2=A0 - V6_vunpackob, V6_vunpackoh: ---00 -&gt; --000<br>
=C2=A0 =C2=A0 - V6_vaddbq/hq/wq, V6_vaddbnq/hnq/wnq: ---01 -&gt; --001<br>
=C2=A0 =C2=A0 - V6_vsubbq/hq, V6_vsubwq/bnq/hnq/wnq: ---01/---10 -&gt; --00=
1/--010<br>
=C2=A0 =C2=A0 - V6_vhist, V6_vwhist128/256, V6_vwhist128/256_sat: ---00 -&g=
t; --000<br>
=C2=A0 =C2=A0 - V6_vhistq, V6_vwhist128/256q, V6_vwhist128/256q_sat: ---10 =
-&gt; --010<br>
<br>
Pre v68 compilers, by default, already use &quot;0&quot; for the non-specif=
ied bit<br>
that changed in v68, so unless someone is manually writing the binary<br>
encoding, this should not cause any backwards incompatibility with<br>
pre-v68 binaries.<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/imported/mmvec/encode_ext.def | 48 ++++++++++---------=
-<br>
=C2=A01 file changed, 24 insertions(+), 24 deletions(-)<br></blockquote><di=
v><br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylors=
impson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></=
div></div>

--00000000000056840d064db5f32c--

