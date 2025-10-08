Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19544CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 20:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6act-0000ro-PU; Wed, 08 Oct 2025 16:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1v6aco-0000rR-Lt
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 16:19:02 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1v6acj-0000oQ-5G
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 16:19:02 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso258327f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 13:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20230601.gappssmtp.com; s=20230601; t=1759954724; x=1760559524;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZk1+322SwNUMF0eNdoy3o70uhPuRH3h3mGTDzg9+3M=;
 b=tbbTiSy4dEFA5YO8RrnZ/CFGgCO1hxq2b1un2N+3wwOPYSDbOQCtZXNsxptApnJ4na
 jBzFMLJDQtwAAPwOUzDVN5H7nSu5ETz7HO6ftYpB9yaMaHRHiJy/SSHbS00nDJ0sAeZO
 e2PmyEqsbX64FevZRYQqDDcMUpsfq+zAIIvSDM53SRUSIdsX+JBnzB1nH0W21OOqsAnh
 Mxm2wG1YpBzO6Hor0KLIl9RjL4nMffsqIOVN+IuHH8JcWIbuDFbcU8FxVzrbOxzqv/t+
 U1ALkBT/ZZ+fuQuwwr2QM0PsDlJOvAovCwmJTv1e7a0n57mUIrfmM2fEuEmbbL8SgnC0
 9/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759954724; x=1760559524;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZk1+322SwNUMF0eNdoy3o70uhPuRH3h3mGTDzg9+3M=;
 b=ioFcIYn+7n/8gIDqiq2kIknQ5rBq1SWuBol8gWTSY/tutMeRd8X6fb6pjNUvpm9eVy
 x9qOKzr8bYJI84h5gDyRWlhUpad2TrilD5/tVuMWDlhd4YlBHBeetb7czpX6XTZbLqnE
 7MZZDKUPoMiIDSnWISrm2hx4B2U/QdvOI3DljL3XxwOeYBeCE/YAuE3IIwTRY+qeHRYq
 GtQymtdQNEDnTXSPV8AQf7jjN9x6G4Y81BFdZzMJqk48al0Mb6sJPe1EQ01c2Wt5y6yJ
 6JoBByf0dA3unHbsO59GVI9uuu/4Kh9TzJxN5vm3Nrisin4KnSmAJdZHDGx9vYyAjKBA
 CobA==
X-Gm-Message-State: AOJu0YxfesKYvGzpA2YAoVX+wQeMrSDlwVRqKZqeN/X83phMgAaLQTfA
 Ctqmh45YGyQWh336iQYMKSGJwKZGZiXb5rx8EMdTsNpuPuUjC40L8SbEf8Jt6ABLS60u3ripF9q
 qRxkMNzc=
X-Gm-Gg: ASbGncufnRS5cyfeq0dxxV+N2MzcuPk0Wvv58p49EGmLJWZ0v2Yc/iFdbYHwl0CsHXu
 QQGeeYikXouJCD/X3Rx7anyRIFPjjyjH0ZHcQDguNlrxfHZJVre2bYTPNuABjiJlS/oCeLuofkh
 eg1BIWiDN9ij9hLFmKwpeud8kQcJCEpQ7nYkLkBBGfYs6nOULKPsoHTnjUqEjgBmNpYXB2HN/sg
 k11eiQOEx3Dg0Tf5bPN+rcRt2uvyjMn7bfxloD2utpv5PwmJOYI3X6yQkWLtlXgSIi60wwNNvgt
 +AamWMgGaKjbSr6rZaGcW7IlX+ILss8f6dz6ubWqOcw2/BIwl6TL/mmYDpkbbajXagp+qGUFclG
 B53MrJPqjA4nzDc5+8gGThLi/Ctot09hcBHI2fc0JzwY9reJ3tXZw+44E
X-Google-Smtp-Source: AGHT+IFXGRFCRw7KlMFwZVVYZod+a5sjJfet4Ouva+7SLprHnTmydBGF+y1nl0RvGg7YQY5gtBjdOA==
X-Received: by 2002:a5d:5d0c:0:b0:425:856f:70ff with SMTP id
 ffacd0b85a97d-4266e8e080fmr3652845f8f.45.1759954724012; 
 Wed, 08 Oct 2025 13:18:44 -0700 (PDT)
Received: from smtpclient.apple ([188.25.252.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42585989607sm8598151f8f.53.2025.10.08.13.18.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Oct 2025 13:18:43 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: qemu-system-aarch64 hangs in a cortex-a72 test
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAFEAcA8DvpFmCPQJNNKkA-K8piRZ_m=FWDmHGF5bGb0uAM4JrA@mail.gmail.com>
Date: Wed, 8 Oct 2025 23:18:32 +0300
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E36ADAF-BC43-4E7D-8EBA-E7F91A87AD54@livius.net>
References: <9EF1806D-4C25-4980-B1CA-16616FA8E32F@livius.net>
 <CAFEAcA_h3-iWubDg++jcO6_S_o_Z1-Xm4RMHqLYq8T=1naADug@mail.gmail.com>
 <84A761E5-6FF2-45AC-883B-AB441E3894A0@livius.net>
 <CAFEAcA8DvpFmCPQJNNKkA-K8piRZ_m=FWDmHGF5bGb0uAM4JrA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
Received-SPF: none client-ip=2a00:1450:4864:20::431;
 envelope-from=ilg@livius.net; helo=mail-wr1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

I fixed the test to run on QEMU 9.2.4.

In case others encounter the same issue, here are some details.

The problem stemmed from incomplete initialization in the test =E2=80=94 =
specifically, the MMU was disabled.

My experience with ARMv8-A is limited, but it appears that unaligned =
accesses are handled by the MMU. If the MMU is not enabled, the core can =
only perform aligned accesses; otherwise, it throws exceptions.

On the other hand, the default aarch64-none-elf-gcc compiler optimises =
memory copy operations using ldp/stp (load/store pair) instructions, =
such as:

```
 ldp  x0,x1,[x3]
 stp  x0,x1,[x4]
```

With the MMU enabled, these instructions work correctly regardless of =
the alignment of x3 and x4. However, if the MMU is disabled, both =
registers must be 16-byte aligned.

It is the user's responsibility to ensure proper alignment. =
Unfortunately, some structures in newlib do not meet this requirement.

In my case, the program crashed inside a printf() implementation used =
for trace functions:

```
namespace micro_os_plus::trace
{
 int
 printf (const char* format, ...)
 {
   std::va_list arguments;
   va_start (arguments, format);

   int ret =3D vprintf (format, arguments);

   va_end (arguments);
   return ret;
 }
}
```

The crash occurred when the `arguments` structure was copied to the =
stack for the `vprintf()` call, as its members were not 16-byte aligned.=20=


Since `std::va_list` is defined by the standard library, there's no way =
to adjust its layout.

The compiler provides an option to enforce alignment: `-fstrict-align`.

For AArch64, this option prevents the use of ldp/stp (16-byte) =
instructions and instead generates ldr/str (8-byte) instructions =E2=80=94=
 twice as many, but alignment-safe.

I tested this and it worked: my code no longer crashed. However, it =
still failed later in the newlib implementation of `snprintf()`, called =
by `vprintf()`. The reason was the same =E2=80=94 newlib uses ldp/stp =
and is not compiled with `-fstrict-align`.

I couldn't find a way to run the existing newlib with the MMU disabled. =
(The `-mno-unaligned-access` option is not available for =
aarch64-none-elf-gcc.)

The solution was to enable the MMU (bit 0 in sctlr_el1) and ensure that =
alignment fault checking is disabled (bit 1 in sctlr_el1).

In summary, for embedded AArch64 applications, I identified two viable =
approaches:

   =E2=80=A2 Compile all code with -fstrict-align, which effectively =
precludes the use of newlib.
   =E2=80=A2 Enable the MMU in transparent mode to allow unaligned =
accesses.

As always =E2=80=94 and now more than ever =E2=80=94 the rule stands: =
tests should only be run in emulated mode once they've been confirmed to =
work correctly on physical hardware.

Regards,

Liviu


> On 6 Oct 2025, at 13:45, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> ... Note that depending on your compiler's config it might assume
> unaligned accesses are OK by default (because they are when
> the MMU is on for v7 and later CPUs). If that's the case, it's
> possible the fix might be as simple as "recompile with the
> -mno-unaligned-access option in CFLAGS".
>=20
> -- PMM



