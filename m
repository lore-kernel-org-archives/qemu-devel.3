Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5588BCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbmwM-0001Ja-RC; Mon, 22 Jun 2026 18:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imaginos32@gmail.com>)
 id 1wbmw4-0001Id-DL
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:16:12 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imaginos32@gmail.com>)
 id 1wbmw1-0000Ac-Nl
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:16:07 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c07ea058c1aso790729066b.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782166563; cv=none;
 d=google.com; s=arc-20240605;
 b=Pg1SahAOTM5Jr2HPwNGKZPSxnyFlZHVeFsGJTWQ4OucadvQY7LgJaD7gD+XmocgF+5
 +zY2u9nG7nHoEGbk7SfAgoiAiyyiu43uunmGCGSg2Q6fa/18PGmSjqnt5FdnU1MqIpym
 0LDlRN2BKDE6XiIkl+GtT557YF+9gwcOvCBeYiGaWg2OVUfC3jbFk4z0SiHBAecqYr/W
 KyB9owi9TqMgrKJAwHV++qanrpedORrz2ccUksqq1ClfaBqL/89ZMaFPYWLsA5wotS8L
 bVvnnFMz4/wl8g5ijyRSQ+uCse61PO/Q/Tfx6iv2SqvOXtGJBo8xF1cDmP1TWmfIrKfW
 xqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OQXbCbpfsYPqXGbCWEVREiTQC3eFwyHDe4DLtDdCi4s=;
 fh=D7oqQ1Y02PB4IPSnN7GLalIcJM5LqLEjr++nqsfoD/M=;
 b=SWKVw9HJCG6BQkiXgZlNPX0FfLwvLv8VhbDlabcjP5OLySIDX54oy/y6faa9mojhUL
 sMzozn6Q8tDM/zdDaNReljTbXRLwhmoq5BADynK4hu3+NF1RxNGlrsqleUPBvtCKz9VW
 bNbY7hU/oqmIgXUapCXOChxLwoY/9Gr55n07McL1T/seSB08Rn40+udeqVViU9AKYdl8
 s25QCnmRn7+LGx4u0LvJpuvQ+TeBH0ohtsfc/5wEAYusi1xHx5/pckG1lXIQPOcE/fIy
 ATqbQo3oR4nVc5YplVqcJgIzFDgxH6Hzg9exPG35Vp6rw3plL9QyjYc11OJrYUuAfaFd
 6nCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782166563; x=1782771363; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OQXbCbpfsYPqXGbCWEVREiTQC3eFwyHDe4DLtDdCi4s=;
 b=Uj86YpBAPwW2jxo6XPLeTWDXe+pAr5xwWYQesUi8Ha409xhQ2/6Hz/xphHK0bcMFRV
 OSrfhVGJcr3gtjQSFtysgjGocKTdHC9EG+iqk+YqHenjU1+nI+diy2k7zQ6dSoMoSetF
 caToXCqnQPOY0J834/kI/zqKNKAyT6+GZCxfADX3HrXoPwDecxyRa0tFWbO90qSypph+
 7wk1Ab4eqF3uoe77BSddyCiRJuW2GvcSbeGXeZOrrMtIYnvJ2ublmZzRdLipLZpjpw9A
 Jzb4N3ShfXqVcU3tcrDi8J8YMMisiFxpJdfJKbKJjMm/rzNUU7VyfJHTex/d4QzLDhWQ
 /fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782166563; x=1782771363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQXbCbpfsYPqXGbCWEVREiTQC3eFwyHDe4DLtDdCi4s=;
 b=sqszLd/5KQIYoQCcWlxWh3NVLfeiC0Cr0QZQfxHF95cKUFTxNQQPzDIpm+rN2gxjFC
 y8joDUf+4NTCNpp33o9++SITgaENjviG9Ifd/wZwKCusCuATw6n1Mvmdnyb7rRF8Tb2j
 tCpKL0Nzh/U8temSvkaXVA+2n/ECTrklCNcqBNH712r3viApKYeJKPpA7n8IKXcK0gVA
 0WfPaGlefIH2SfepjUWHLsVunWf6mqZhC/Oe2HaACOej0FnyaCZOPSlpqPmZ9vmaRxY2
 Glk+/hPtGsqOHX1yJiZol286fzFhgqO5cR2s2qFp/mYVN531FWbAo2XS7fRBOTRQFlAM
 3pXg==
X-Gm-Message-State: AOJu0Ywp9ek3fQSNU9vsTkv/+NWV39SxFUFspZ2Zx/UUrb1K/lLQ4j9v
 WRvkA7hEVHPi3QFdmBYU8saJMWb2vjViD5g4745/Bepnzu3qr+W7IOTBTZQFOaUW+YTY4vuZasW
 sCsKXOTDQgJMFmUsSGpAprap5b981rgw=
X-Gm-Gg: AfdE7clwIGuJ9l56ou7uoiuWkultms2oTiekwUcyXsCMq4vxUkKB29W8Y3gIiqOQ7oP
 9Mw6YRXzCc3YIByLnh+7pQqbViRr5WhvR+iuORRAWxLSMSrrY7kBVnTbzsIE6sRkl3EojM3dA4G
 BiPXx+cKQP6LkRcDWTs3zgMkKiFIESQ+dLhVnhVu7IQ6nwo1k67bnbo0tPiGraKySVLN5JGaLnO
 9uIHsUY0GomnYHooqlhCwl/WT5j2gS2Up0DOK8+5y3FVyG0+nz5ZyCj7McH2j7pMes5KCuKxQ==
X-Received: by 2002:a17:907:c445:b0:c07:6950:4490 with SMTP id
 a640c23a62f3a-c097caca21amr761497366b.42.1782166563117; Mon, 22 Jun 2026
 15:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260614222131.5795-1-imaginos32@gmail.com>
 <CAFEAcA-GGP6aALn4Az5By31q1R3d75Mm+p_YXN0y=tO3GxDYrg@mail.gmail.com>
In-Reply-To: <CAFEAcA-GGP6aALn4Az5By31q1R3d75Mm+p_YXN0y=tO3GxDYrg@mail.gmail.com>
From: Imaginos <imaginos32@gmail.com>
Date: Tue, 23 Jun 2026 00:15:51 +0200
X-Gm-Features: AVVi8CeSouwMjmSuFc9S2hvR2Vz7Z8NRL9AV9-5KAy1BtimiO21yR_S64c1T5xs
Message-ID: <CAFxqGk98dEmAhebozRPMhZGwv9RRC7Yt4=rOeKPq2R95bXtDXg@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c: pmbus: NUL-terminate strings received via block
 write
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Titus Rwantare <titusr@google.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ecdd9c0654defcdf"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=imaginos32@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--000000000000ecdd9c0654defcdf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for catching that. I went through the repro myself and arrived at
the same root cause,
but I missed that the original report's description of it was inaccurate
and should have flagged that.
Thanks for the review, I appreciate you taking the time to look into it.

=D0=BF=D0=BE=D0=BD, 22. =D1=98=D1=83=D0=BD 2026. =D1=83 12:18 Peter Maydell=
 <peter.maydell@linaro.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> On Sun, 14 Jun 2026 at 23:22, imaginos <imaginos32@gmail.com> wrote:
> >
> > The PMBus string registers (e.g. MFR_MODEL on the ADM1266) are writable
> > by the guest. pmbus_receive_block() can fill the destination field
> > completely, leaving no NUL terminator. When the value is later read bac=
k,
> > pmbus_send_string() calls strlen() on it, which reads past the end of t=
he
> > array and returns a length that trips
> >
> >     g_assert(len + pmdev->out_buf_len < SMBUS_DATA_MAX_LEN);
> >
> > aborting QEMU. This is guest-triggerable.
> >
> > Add pmbus_receive_string(), the write-side mirror of pmbus_send_string(=
),
> > which reserves the last byte of the destination so the stored value is
> > always NUL-terminated, and use it for the ADM1266 MFR string registers.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3388
> > Signed-off-by: imaginos <imaginos32@gmail.com>
>
> Thanks for looking at this. Notably, the bug report in #3388 makes
> a completely incorrect claim about what its repro case is actually
> doing. The repro case does the "write 32 bytes to trash the NUL
> terminator, then try to read back", which is what this patch addresses.
>
> I'll let the pmbus maintainers review the patch from a technical
> point of view.
>
> -- PMM
>

--000000000000ecdd9c0654defcdf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for catching that.=C2=A0<span style=3D"background-c=
olor:transparent">I went through the repro myself and arrived at the same r=
oot cause</span><span style=3D"background-color:transparent">,=C2=A0</span>=
<div><span style=3D"background-color:transparent">but I missed that the ori=
ginal report&#39;s description of it was inaccurate and should have flagged=
 that.=C2=A0</span></div><div><span style=3D"background-color:transparent">=
Thanks for the review, I appreciate you taking the time to look into it.</s=
pan></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BE=D0=BD, 22. =D1=98=D1=83=D0=BD =
2026. =D1=83 12:18 Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro=
.org">peter.maydell@linaro.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On Sun, 14 Jun 2026 at 23:22, imaginos &lt;<a href=3D"m=
ailto:imaginos32@gmail.com" target=3D"_blank">imaginos32@gmail.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt; The PMBus string registers (e.g. MFR_MODEL on the ADM1266) are writabl=
e<br>
&gt; by the guest. pmbus_receive_block() can fill the destination field<br>
&gt; completely, leaving no NUL terminator. When the value is later read ba=
ck,<br>
&gt; pmbus_send_string() calls strlen() on it, which reads past the end of =
the<br>
&gt; array and returns a length that trips<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0g_assert(len + pmdev-&gt;out_buf_len &lt; SMBUS_DAT=
A_MAX_LEN);<br>
&gt;<br>
&gt; aborting QEMU. This is guest-triggerable.<br>
&gt;<br>
&gt; Add pmbus_receive_string(), the write-side mirror of pmbus_send_string=
(),<br>
&gt; which reserves the last byte of the destination so the stored value is=
<br>
&gt; always NUL-terminated, and use it for the ADM1266 MFR string registers=
.<br>
&gt;<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/338=
8" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/3388</a><br>
&gt; Signed-off-by: imaginos &lt;<a href=3D"mailto:imaginos32@gmail.com" ta=
rget=3D"_blank">imaginos32@gmail.com</a>&gt;<br>
<br>
Thanks for looking at this. Notably, the bug report in #3388 makes<br>
a completely incorrect claim about what its repro case is actually<br>
doing. The repro case does the &quot;write 32 bytes to trash the NUL<br>
terminator, then try to read back&quot;, which is what this patch addresses=
.<br>
<br>
I&#39;ll let the pmbus maintainers review the patch from a technical<br>
point of view.<br>
<br>
-- PMM<br>
</blockquote></div>

--000000000000ecdd9c0654defcdf--

