Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AC8F47CA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyD0m-0006l6-9F; Thu, 05 Mar 2026 13:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vyCzd-0004Jj-Ki
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 13:00:17 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vyCzb-0004Lw-MS
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 13:00:13 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7986e0553b0so72889967b3.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 10:00:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772733610; cv=none;
 d=google.com; s=arc-20240605;
 b=KMdCWwIA7qrINzkmlOIsiQYpISNr3ZRLpZI5N9nSbIgnAoXM809xuPrDBuSYoHT6AQ
 kOlo9kV6ilg0uO9HReqNLrFsPpBJwhPaKe6uy+HIE+9Gn9LLrzClW3VLkvwwh10I99JV
 wJDJX/dNcsUE8m3babjMLg8tvVvjaM94YLMlEwgALmH9TbuiSmSjjjBa2vXXOs55u4lo
 Tl/NhyVOtISh3RO4XODjEH78LlwClmzAt/8Wwhsd/LoYeY0Mal79Yfh66XLIGQpo0pFM
 hMnM/ESGJHyc1pdQJfw1/RVxwTFPDpciG7cdHHcrDSfcRi44+csa7sFVoWI73oAlj0Hp
 6iqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jZ5u5q3ziMgdOXUWrazP/s5OxeHEKgwwLExMYXOMjwI=;
 fh=qzhFIIYAcISiKbPNwUsTzJ4u+ko17iB1cY0W5dd0Jz4=;
 b=RjGHM5Nk7MlW7Nr2833Y19Ws9i6uAH+XfKQBUqUX68rb2dmMTVeLkrfIoiC8Fp7GX2
 Et7DC0ey04v4B50s+ZVKU8+nLy8go371IyqpnVIkyavLiz7ytm+kOuu3UWXKhrHLWKN1
 yeLhhItHTZyZWzSNfbY2Hdyv2yMkBP5iuKZIU20KpI/i/qKnUBsncDuy7Hd6nZzL5Tjq
 5Nt03lf2CtAn2tMWK2JEJIaEVnAWgYHSOUnrBFyVkqunuvsNvBzUVqZcLqCleoAn3uw+
 z3U0WcKEEjRpwYre2m14gVTHGgEZLX6P1KUXIFtHwWjrUHzNuaS5XTTmzU65XNb/X82Q
 oJrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1772733610; x=1773338410; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jZ5u5q3ziMgdOXUWrazP/s5OxeHEKgwwLExMYXOMjwI=;
 b=Z8a/9W0TudRfWDUDuaUOswmLn5Fc+JRRmZWcT8YXGJO5D4iCF0GonDaf2mUIl8FuAn
 td7ehgVWyoqN6z1RgjDpeG1ZqPd28kgbJW9MqU7HYDkQbal6i0AxkTTpc3emm606hqyk
 Ix2kQ/NZ3JaODD+PDFlrQJJc10JUs5RS6c/i/s/ROL817gYH6pu8HJ94cQx1ryO3bfpz
 ar2MTg8KENI1TcXlyhwE8g0bG+fJ6I3G0wc6JGNldn1xqoFJQDCVIjvTFFB8ylAZpZQ1
 Encpo4lRNPEp86KxBitxLUX8tCCdY0CNo9q1E/rm/sE9xkftgQxP2c7qju1UjjCsN4Kb
 e+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733610; x=1773338410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZ5u5q3ziMgdOXUWrazP/s5OxeHEKgwwLExMYXOMjwI=;
 b=VdJWNV7900aGBZoRGDDUTR5cbi0v5Yg2ckV5v9/2tIL897OMKPkquICdtrRBqobT53
 66Y+uQpLt49XYmM2TL/ZMv38PGhSWyfPAyW0r8dYO8cGlwnl7Q9KvAjENMd8GmM2QgSX
 Db0VXgIZN72MQlHVK6X6AvY2nXWPOIH7Zr0FHJcgW+Nq2N2gOd3KwvzRBZv7Sew/4ZH8
 3TJO5d/vFBv7tGVkIM5V9VuxILPlloWXFHIH5IBby6fMBj+WfWYhPVU+lTxpgtTv3Bx0
 5r4DQf7gaHlTFDIWn/skYhjDUq3jxdCyZGBPTmZgScr3nFeTVOVqPD7WbnrDp43cuZqC
 A+EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhn6fzj9jv20Da3mSb1yFMODcGtKnjfNI26TO7WXkEFLw4C34l1BbUPVenwKuKQ36Cc6j5CcSQqcUL@nongnu.org
X-Gm-Message-State: AOJu0YwLl2NhJWWZRG2jPQcJjnulzud+qZRTgmo2Y8yOxAaIbhtvGba4
 2ehKUOXbn3r3R2Re9Bde3vJFQulafzmFoVPAP7+G/yEShW1UvqjgX5JR3OxEuwkYhcKTJvvK5oA
 X4cHpadCHGkg7MS+YjTsK8s1KxL/tyTpxLcvQ2rL173SU6n3FfxSdQ3iaWw==
X-Gm-Gg: ATEYQzzY3Vc4EpIBEgvTGL+hxlaAOa4Atysmczb/SwEaXGxxistrY6ahfq49H78pHOw
 B4nsy0EnYTE4ClzrtRZfN9npIOdiE+QFVrl2NKSVEteRGb+UuJSUvjmd5lycjP/3PnEHw4IZVRV
 bZsZj01MSRcpmZeYrBWx5hUTWdMzd2aPCRGcfPRcXLjcmXbab3SbXTksmgBrtctbORFWTkJwS0V
 /d48M+V+IYZ72rfURCub+IW0ZQysdS7MxjGPNyE7J3BDe0z/qOpiXZFl2x1oQIN8Vsg5FhAMVjk
 s1ZXWDW1/LpK3vpfliM=
X-Received: by 2002:a05:690c:dd3:b0:796:312a:b817 with SMTP id
 00721157ae682-798da405df2mr7805857b3.9.1772733609584; Thu, 05 Mar 2026
 10:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20260304121113.117299-1-james.wainwright@lowrisc.org>
 <20260304121113.117299-3-james.wainwright@lowrisc.org>
 <CAKmqyKN6szjMFhctNsV7EvLXnXanERRFoE8ri3woALrnCHL93Q@mail.gmail.com>
In-Reply-To: <CAKmqyKN6szjMFhctNsV7EvLXnXanERRFoE8ri3woALrnCHL93Q@mail.gmail.com>
From: James Wainwright <james.wainwright@lowrisc.org>
Date: Thu, 5 Mar 2026 17:59:57 +0000
X-Gm-Features: AaiRm53CTIryvtuh4Pvfba1dCa2JLuzGzzmsIWuhoxqa-Tc4BnTOg79x2lVdLPs
Message-ID: <CAFFhqSvjMegTx5uQK-wZaiCJ3=nVizmgDWzePtMBKQOfmZxojg@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/riscv: add unratified RISC-V Zbr0p93 ext
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com
Content-Type: multipart/alternative; boundary="00000000000014bc6d064c4ab505"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000014bc6d064c4ab505
Content-Type: text/plain; charset="UTF-8"

> We don't have a policy on what to do with deprecated draft extensions,
but I'm reluctant to add these. At some point in the future they will
conflict with a ratified extension, which will cause all sorts of
issues.

Agreed, it's not ideal. FWIW it looks like OpenTitan is moving to use the
ratified `clmul` instructions to implement CRC32 going forward (
https://github.com/lowRISC/opentitan/pull/28511 and
https://github.com/lowRISC/opentitan/pull/29200) but the Earl Grey chip has
already been taped out with Zbr instructions in the ROM, so it would be
nice if we could emulate that upstream.

Does the extension being implemented as experimental and opt-in help,
similar to how `X` extensions share an encoding space? It seems unlikely
for machines other than Earl Grey to use Zbr0p93.

> These should probably just be a vendor specific thing

It's a shame that it's in the ratified encoding space or it would already
be like a vendor extension.

--00000000000014bc6d064c4ab505
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;=C2=A0We don&#39;t have a policy on what to do with de=
precated draft extensions,<br>
but I&#39;m reluctant to add these. At some point in the future they will<b=
r>
conflict with a ratified extension, which will cause all sorts of<br><div>
issues.</div><div><br></div><div>Agreed, it&#39;s not ideal. FWIW it looks =
like OpenTitan is moving to use the ratified `clmul` instructions to implem=
ent CRC32 going forward (<a href=3D"https://github.com/lowRISC/opentitan/pu=
ll/28511">https://github.com/lowRISC/opentitan/pull/28511</a> and=C2=A0<a h=
ref=3D"https://github.com/lowRISC/opentitan/pull/29200">https://github.com/=
lowRISC/opentitan/pull/29200</a>) but the Earl Grey chip has already been t=
aped out with Zbr instructions in the ROM, so it would be nice if we could =
emulate that upstream.</div><div><br></div><div>Does the extension being im=
plemented as experimental and opt-in help, similar to how `X` extensions sh=
are an encoding space? It seems unlikely for machines other than Earl Grey =
to use Zbr0p93.</div><div><br></div><div>&gt;=C2=A0These should probably ju=
st be a vendor specific thing<font color=3D"#888888"><br></font></div><div>=
<font color=3D"#888888"><br></font></div><div> It&#39;s a shame that it&#39=
;s in the ratified encoding space or it would already be like a vendor exte=
nsion.</div></div>

--00000000000014bc6d064c4ab505--

