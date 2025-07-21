Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C4AC83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 21:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udyJ2-0007U0-7L; Mon, 21 Jul 2025 17:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1udyHR-00061K-19; Mon, 21 Jul 2025 17:42:41 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1udyHN-00008E-Tj; Mon, 21 Jul 2025 17:42:40 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-32b7123edb9so50576351fa.2; 
 Mon, 21 Jul 2025 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753134156; x=1753738956; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Pi5a7yefMwcMVC85NgeCH42h8Mc4dcn+m0lnzMYwaE=;
 b=OWHuljrkR9Xk+5AnOr/vwEvm1ATX60cJsD6CZDIT8/KCW80/RjvEhuw+HlJe6py43W
 HHPh1zLB8XCQp5DCrMpCqtpEW7cHs/6usaMaIIaBuKn9rcz1ElOdtUodZy+BWxtFQjvF
 GDav2vk3TPb2soDaRM/sJs26x6tGxYtWI7dWMARYh3oCypaE23ZCBp0rj0t4eMZ+pZpZ
 dETeNDFStDZPSIeVfEZXmfUfXqT5ARUuqhk3LTwTMrTGFt8M84xMU2cmGXEJsafP34ZT
 Lm5XJLatFaiAq6zG09piLp07vjM7OOO7H5ug8S9cC+Htk8oe6Fqufl7hf/3yjXY9osrZ
 j/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753134156; x=1753738956;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Pi5a7yefMwcMVC85NgeCH42h8Mc4dcn+m0lnzMYwaE=;
 b=fabWpCA9Whxqe3/tD/XC25hlZ/BSOJdrQciAzGAjmX1KNkS1KI74CxOwPcrnebB7rR
 vH1dvxIKuS+W/hrQyVfFSucGiU0fOQmK2O9Z9Y74X5r2FodKov7BNjx1A/9vOGXiIO2W
 SUKq9aD+EffOSf/ZMgX15gk+Q+XHXbTp2j8vNuCj1NJccZOUroMco1zM38nVMTvHlBUy
 UWPC1SiSYBKhi4yb+VyvA0uMhS8HEnn7q+DrlNC7P/fDWNxKJKLvoo3+/lyly/VAuiZl
 E15R7iOPSsXqAe3nwlaEBrSW+mylYO+x0gzOfrHeCPLzwtYkxx80FMXOK8GQYB2GZqr8
 WSGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmoWNsiIZnGP8biaAOPTj9g40U4Bnizjp4QExci6UPLUvIXOk4TG6lzYuQTu3crLVbj/12REXHZg==@nongnu.org
X-Gm-Message-State: AOJu0Ywab9lsVUeBH8/b1O0e+/98lld6+RlPLkEwsLkjwsVwUQsgDZ9p
 U+mtfuBG8u3I/9NpVDakB7FPcmjKML7oNYONcnEjOYE2Mx6VKK5kfK5u
X-Gm-Gg: ASbGnctj4aDXnOmlA271FeKvIsWqrL5sWLOV2eB9klIruscoTDhLKJaHGMvEUcm7kEH
 mWTtUzmY58Z53zwGTSTwBFj/BoqskY6hwAlfyS9X8a75Ghz/4oZOYSNzYYW99RaOaKJPgi//Dzz
 RwwwqzXAmyPUcehbiNAL53TldRSEl6RUnwQU21yF7p8m5KEOppAiD52Ur72sKGwwkb3gUg+5ErX
 Nc+gffhIIKXB0DTYsE6ISkWLRayx1xXtrXTj0gW405jmjUETGcxgdsq8uaq4eHw23ARpRLAe98D
 LzVZX3E4h1pdYgzBVJOsLHE0HdOT50c+uvCLkpdQiXtCivJrj2LQ2m7fUz7Sz2loF5Zka9cla5m
 m7sA2sdp1klfhZeS561c6V6WHg1dadlOvYfv4wAjmJw==
X-Google-Smtp-Source: AGHT+IF5RcNO4blGcmzEtB6kWZ+FNNyfz7EkL+jdGtN1Z7MVV42kX+fJBIxAkFu0UNMQO+SYRsRhgg==
X-Received: by 2002:a05:651c:1a0c:b0:32b:59d1:7ef3 with SMTP id
 38308e7fff4ca-3308f64e218mr62852991fa.35.1753134155281; 
 Mon, 21 Jul 2025 14:42:35 -0700 (PDT)
Received: from smtpclient.apple ([62.183.185.10])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-330a90d56b0sm15796631fa.4.2025.07.21.14.42.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jul 2025 14:42:34 -0700 (PDT)
From: Vadim Chichikalyuk <chichikalyuk@gmail.com>
Message-Id: <11C21A37-0225-46DE-84D9-19E12BCEC59B@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_5DE68C0F-2FE8-4B8C-8D7A-4B81F95CE82F"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.71\))
Subject: Re: [PATCH 3/4] hw: arm: acpi: add UART clock frequency to SPCR table
Date: Tue, 22 Jul 2025 00:06:20 +0300
In-Reply-To: <20250721104119.00001882@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Vadim Chichikalyuk <chichikalyuk@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250718162045.49012-1-chichikalyuk@gmail.com>
 <20250718162045.49012-4-chichikalyuk@gmail.com>
 <20250721104119.00001882@huawei.com>
X-Mailer: Apple Mail (2.3826.700.71)
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=chichikalyuk@gmail.com; helo=mail-lj1-x229.google.com
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


--Apple-Mail=_5DE68C0F-2FE8-4B8C-8D7A-4B81F95CE82F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 21 Jul 2025, at 12:41, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Fri, 18 Jul 2025 19:20:44 +0300
> Vadim Chichikalyuk <chichikalyuk@gmail.com> wrote:
>=20
>> On the ARM virt machine, there is currently no way to =
programmatically
>> discover the frequency of the UART reference clock solely through the =
use of
>> UEFI/ACPI (without the DTB). The SPCR table can include this =
information
>> as of revision 3.
>>=20
>> Bump the revision to 3 and add the clock frequency of 24 MHz to the =
table.
>=20
> Maybe add something on why you aren't just skipping forwards to 4 and =
filling
> in the rest of the stuff?

Haven=E2=80=99t really considered that =E2=80=93 you=E2=80=99re right, =
might as well upgrade it to revision 4.

Based on build_dsdt() and acpi_dsdt_add_uart(), the NamespaceString =
would be=20
=E2=80=9C\_SB.COM0=E2=80=9D, right? Although, for some reason, it=E2=80=99=
s just =E2=80=9C.=E2=80=9D for RISC-V virt (indicating
that there isn=E2=80=99t a corresponding device in the ACPI namespace), =
despite there being=20
entries for the UART in the DSDT, just as for ARM?

The relevant lines, for reference (hw/arm/virt-acpi-build.c):

scope =3D aml_scope("\\_SB");
acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], (irqmap[VIRT_UART0] + =
ARM_SPI_BASE), 0);

static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry =
*uart_memmap, uint32_t uart_irq) {
    Aml *dev =3D aml_device("COM%d", uartidx);
    ...
}


Thanks for the review,
Vadim=

--Apple-Mail=_5DE68C0F-2FE8-4B8C-8D7A-4B81F95CE82F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><br><div><blockquote type=3D"cite"><div>On 21 Jul =
2025, at 12:41, Jonathan Cameron &lt;Jonathan.Cameron@huawei.com&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div><div>On Fri, 18 =
Jul 2025 19:20:44 +0300<br>Vadim Chichikalyuk =
&lt;chichikalyuk@gmail.com&gt; wrote:<br><br><blockquote type=3D"cite">On =
the ARM virt machine, there is currently no way to =
programmatically<br>discover the frequency of the UART reference clock =
solely through the use of<br>UEFI/ACPI (without the DTB). The SPCR table =
can include this information<br>as of revision 3.<br><br>Bump the =
revision to 3 and add the clock frequency of 24 MHz to the =
table.<br></blockquote><br>Maybe add something on why you aren't just =
skipping forwards to 4 and filling<br>in the rest of the =
stuff?<br></div></div></blockquote><br></div><div>Haven=E2=80=99t really =
considered that =E2=80=93 you=E2=80=99re right, might as well upgrade it =
to revision 4.</div><div><br></div><div>Based on&nbsp;build_dsdt() =
and&nbsp;acpi_dsdt_add_uart(), the&nbsp;<span style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);">NamespaceString&nbsp;</span><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">would =
be&nbsp;</span></div><div><font color=3D"#000000">=E2=80=9C\_SB.COM0=E2=80=
=9D, right? Although, for some reason,&nbsp;</font><span style=3D"color: =
rgb(0, 0, 0);">it=E2=80=99s just =E2=80=9C.=E2=80=9D for RISC-V virt =
(indicating</span></div><div><span style=3D"color: rgb(0, 0, 0);">that =
there isn=E2=80=99t&nbsp;</span><span style=3D"color: rgb(0, 0, 0);">a =
corresponding device in the ACPI namespace), despite there =
being&nbsp;</span></div><div><span style=3D"color: rgb(0, 0, =
0);">entries for&nbsp;</span><span style=3D"color: rgb(0, 0, 0);">the =
UART in the DSDT, just as for ARM?</span></div><div><br></div><div>The =
relevant lines, for reference =
(hw/arm/virt-acpi-build.c):</div><div><br></div><div><div>scope =3D =
aml_scope("\\_SB");</div><div>acpi_dsdt_add_uart(scope, =
&amp;memmap[VIRT_UART0], (irqmap[VIRT_UART0] + ARM_SPI_BASE), =
0);</div><div><br></div><div><div>static void acpi_dsdt_add_uart(Aml =
*scope, const MemMapEntry *uart_memmap, uint32_t uart_irq) =
{</div><div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);"><div>&nbsp; &nbsp; Aml *dev =3D aml_device("COM%d", =
uartidx);</div><div>&nbsp; &nbsp; =
...</div></div></div><div>}</div></div><div><br></div><div><br></div></div=
><div>Thanks for the review,</div><div>Vadim</div></body></html>=

--Apple-Mail=_5DE68C0F-2FE8-4B8C-8D7A-4B81F95CE82F--

