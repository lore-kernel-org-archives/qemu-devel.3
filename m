Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F2DD2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 19:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoSQ-0005x6-CG; Tue, 27 Jan 2026 14:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vkoRK-0005To-JU
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:09:28 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vkoRF-00042Y-OE
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:09:25 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a743050256so39768275ad.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 11:09:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769540955; cv=none;
 d=google.com; s=arc-20240605;
 b=MuhD4J7gDrPZXYuorYPN+YIestrLdria31IdyEBbbrnUICTitom3c3JAXpWlyawX4o
 3YWSAVTbmWgJDRAYFAbzQT1K9udjlaacHCltZwQJ5wZgA5I3QZbLqYykGUafZx6PZKhm
 7XwDPCQ+KgYYVFe1D/SbblgUTJyfZ94bkPlugtxo0Cx6QKDfFEMM4sFNAZs51BA2fwFM
 ctzoYa1oQk9Bgda0DiGD18XNeKP4VDpKa9grNDZt6xzW0hSPn7FyErta8njGR9GaJw2E
 SSIE4w7UBy1tDMZX8C1KEuRWeOWZ6GFXjGq/kVLrRFZxsAthq2hSLt+Qy+NNcosquB91
 JT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6A+iqOVYwdH2meRKyCa55Exp0xwVuIR3axV4gmipIjk=;
 fh=hdAlyzp8UpdPSI5O9FlJmNzUHmpgbsMZHSul8BBn2VY=;
 b=VWj9s1BDKe/BYK5Hx315Yh8two7EiCPJUyG/f9QuDvAVpUoZL4DcqJNt3ZlSkTHGSx
 pLVHSO/BRyCrDKEH8/WvIqRaqPYJj8cWVvVnSeLEohIX0xNv6jEV2sbMAoPEzqxVv6sy
 PaNvzLceh3IWGgFehkblZoEvH91RMeDO8/DtWophlDAIt/I0QxPlZc6cBkJI4aBZX1no
 pQrWkI9vEIytrA6fPymlY8AH9eHnKLRUph4Q4rNyOMuxytAedfT24J8p4Q7P1rS/V5Yo
 gNFBQF67oGPhDwp86vqPiAwyaJI/iV72CoP47ZiNbVHaMM1O2h7OcrNay8xhzKvQ6r3+
 JCKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769540955; x=1770145755; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6A+iqOVYwdH2meRKyCa55Exp0xwVuIR3axV4gmipIjk=;
 b=IT0Wv69xvuKK6AJWeyLx4skLB3UsHq2N/yki7C/UjQvgh67RNy6+R8MEuoq1GPnx1Q
 GUeho45/T7dQ0J+xSgLkca62SvyTs0a3/KcNd8KCJcnC9092Pcv4zngzZgO7lexqIbyc
 OoxqANzRMxmspbnE6pEwx5ufWK5Jvl5zNu1nHbpnEz3YdqBKzjVINPgaqwNyE64I96DC
 wZ7V4p2RzXIBCwkS5qMnqvg8vw8pEQiPPOlidUfmmjw8f6TEJGGET9CIcsfWEqsEapoU
 /2DMcdWJb7O5PjHgOrs42QQ6aVwUNgtK5MaMVCIIfj9i9TolfhGYLLr7MzvYcQq0huNn
 chRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769540955; x=1770145755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6A+iqOVYwdH2meRKyCa55Exp0xwVuIR3axV4gmipIjk=;
 b=ANXiQBxWvHNumqyYZQsXibPoxwUFs0HHC2Ovn0xu6O9RLlFmimMzJudC8UWCbbQC5i
 CrG3imUe5xgVC3oxcTU/T/7H1DjP7AFCYCTjNCO+EJJ6Kdf7SVg2KOXipJHh82tqNZTt
 EHG+0l/w91/W7aNyU8hTMz1zFbD0UQMGTSHjY/z+b3G2P+SsN40aU6sYJdfYXhbD0fD7
 NK5J5luPE7Q2vhgwwZrf8zj2ThsZ8i3pHsu2gl+D/wBCheUTfyaGegeeI9cjIRNCwYoM
 6j0USL8eTP33xaXlPhjgAnFoEr+MmJ2zYhnv5S5TR/FoGceccpMLC0mD+d8FcnVUOvHv
 RYew==
X-Gm-Message-State: AOJu0YykyqV9Ut7YHXsh8VN8k6JGsMOlPz9VaTiHdWGRM6upcV3+XmIH
 YPLadWa46bUWnvfl1z4qpAJWxbeh5Y9N8mwRnjw19ovF3S4TdkadFavPku77mlzVOgsg0mFCz6e
 1jXxPI8fomTun4fTwMz7hzgsMgo6Fhv8=
X-Gm-Gg: AZuq6aJtRcyg+Z+cyKC7p2ggyjF47/MXzS1wBPqW6tK5MYmIWx8c8l+us0OpDXtdEyj
 pQduAFGHThLH6WSgMkRgFD0OCj/oxR/gPscGKJHZ41E65Y6jgD093WDhqaMOa5eAeRXXA+T8kB9
 7BiDBzNkysamC/6/d/RZOGEOJSwbcpNVLIB/T4tbY2s96rTXepi56dZC1Gl3Y3QbJUwgwjmn/2M
 4maJ7XgX4aKrAw0zFnq4L1ZVEj3PWaha8tuDh2wU409mGU3eMxjP91RjmpTQDKpVwc3NENxuekx
 IjA6zpYdii/wLhMdWc7IioEFz4s=
X-Received: by 2002:a17:902:e811:b0:295:9b73:b15c with SMTP id
 d9443c01a7336-2a870e36522mr28964635ad.42.1769540955004; Tue, 27 Jan 2026
 11:09:15 -0800 (PST)
MIME-Version: 1.0
References: <20260126223439.46974-2-marco.liebel@oss.qualcomm.com>
In-Reply-To: <20260126223439.46974-2-marco.liebel@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 27 Jan 2026 12:09:03 -0700
X-Gm-Features: AZwV_QjMeAwWW4gGjkS16y6SHL4Piwl-fpLD4Gw0rR5PGL-rMXeoeLfzhLrDKok
Message-ID: <CAATN3Np1mWNkd3sF8uh7p+PyM4gfe02CfdfJROUwmYpL3Snnew@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: Remove unused is_finite()
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 sid.manning@oss.qualcomm.com, brian.cain@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="00000000000009e0060649635c65"
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x629.google.com
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

--00000000000009e0060649635c65
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 3:35=E2=80=AFPM Marco Liebel <marco.liebel@oss.qual=
comm.com>
wrote:

> is_finite() is defined but never called anywhere in the codebase.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>  target/hexagon/fma_emu.h | 5 -----
>  1 file changed, 5 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--00000000000009e0060649635c65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 26,=
 2026 at 3:35=E2=80=AFPM Marco Liebel &lt;<a href=3D"mailto:marco.liebel@os=
s.qualcomm.com">marco.liebel@oss.qualcomm.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">is_finite() is defined but nev=
er called anywhere in the codebase.<br>
<br>
Signed-off-by: Marco Liebel &lt;<a href=3D"mailto:marco.liebel@oss.qualcomm=
.com" target=3D"_blank">marco.liebel@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/fma_emu.h | 5 -----<br>
=C2=A01 file changed, 5 deletions(-)<br></blockquote><div><br></div><div>Re=
viewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">l=
taylorsimpson@gmail.com</a>&gt;=C2=A0</div></div></div>

--00000000000009e0060649635c65--

