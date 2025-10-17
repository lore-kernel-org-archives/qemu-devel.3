Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF02ACCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 14:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9lE0-0005X5-Mt; Fri, 17 Oct 2025 10:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9lDy-0005WR-FR
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:14:31 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9lDq-0005zh-Ka
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:14:30 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6354a4b4871so1926243d50.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760710460; x=1761315260; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gr9dKSSr29/Ar3cRy+h9xUxtJ6t94e5ocT5KOvAMoU4=;
 b=LVK8Ghl/xLP3/kzwdJVmhPXLga2twJudd/PL8h9SgkMqQiQe0Tl7IlqQrYcBwajUco
 J7G2dFCVBiNV5ssbvKbJvNU74tOp+90fWxgiOoqRgf9ofpZlxkhqdfJSaZSEb6EDOq8v
 WU7hecWOplFBBgFBOR0n2TDygLbp1ubOXdvxfI7T+HCEtQuEUbbrpk8NXiRfBQzxAKIN
 3+L/a+yI3Qb2GR/3/N7DlO+a0oATIX9HoEz1sEUA0fsFBWa6IjOgtWAq+ziEiqHJb5tA
 inhXDV0z1x3cmEpBsfjcHdZV3dOkbUQgM4+RVcr0lRqZ2G8UO2FsoklySu1BGLAzLnwG
 Q7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760710460; x=1761315260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gr9dKSSr29/Ar3cRy+h9xUxtJ6t94e5ocT5KOvAMoU4=;
 b=wxwR4qX8alWiYtPLnyvyVB5/3cRLqv+NQr8GZGlz0J0UyXMWfE/cyjpqJhOczOwO1D
 Fm7VNdqldZx/Fcu7okrVtdsM05ooDwqE8S99qq7UrrzLFDBT6iUNDiD+fhHez4Hcd/JM
 VDPiS72ULBzq15kSpfKVf2kd79DpCzr6jCr4bjCbxWTi5vID7usIMy0KP5uoq0+RJ879
 QS2ZnlsxnMSmIE1/1VrwzX8BiBVCYuAf125HszVr4UQK9NEwO+eKTBQ+RmQ/aRyPND/q
 E2bOM1KPD+K+d4LVab+lzUlAKpMUoLr3QbKS20dIoekWHJKlyNmryCKpz2StwGaazOgv
 6Mhw==
X-Gm-Message-State: AOJu0YzIx8cxdOCoJda2aO1M+w4rPhurvgjWoCOyulaEwAgznsJMdSP3
 dUFEWbb4JQjliRtzALxQhtB3JzSCE1FMUP+y1MyMy4y7P8qAHaZg9vPwrHfzw9JZcHCYagP8NNd
 zp0knOKZVaWlHMfGWkDcBVPJb+v+At5kqgVlSX1aMaA==
X-Gm-Gg: ASbGncsNGPiCKin6wqgqFJDsg/MJF5t4y4ig7pLsozmC9ac8uDXitiJ14NtCiDrd0Ad
 MYbEQJ2OEqgkLmji8A93q7KdHhIXzkjL5UxeaZYEe9ruWajXQIUK3YHEqDtDjtQIsrX9NuRZyvv
 5lUnZZ5uWTOG9SMikH7TcodCY+D5xfa1OpH/m7jfpiq/TeenHd9DJungBwLRSMcYsg7IWDi5ksM
 Fh3Is4CH629X1algIZlI+AX+4q1wBMVJWbjLjpFnuQ6Llu5DeGA5WndTbn51A==
X-Google-Smtp-Source: AGHT+IFcU2pObgeeDBR0o/1k5lb0+WfvxAqOZeNFhv7LGUFmZfFF1P/UN3rVME90toyaQTdf/J11Tt2HgtUZB5MsVvc=
X-Received: by 2002:a53:acd8:0:10b0:63c:f04a:99a3 with SMTP id
 956f58d0204a3-63e160e9821mr3198266d50.14.1760710460171; Fri, 17 Oct 2025
 07:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20251016122132.737016-1-peter.maydell@linaro.org>
 <20251016122132.737016-2-peter.maydell@linaro.org>
 <c6bea598-23d8-4f38-b488-ae017df8a8f4@linaro.org>
In-Reply-To: <c6bea598-23d8-4f38-b488-ae017df8a8f4@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Oct 2025 15:14:07 +0100
X-Gm-Features: AS18NWAKI6zWWzPjw6Fec24XOusRx37d7LuWO907QhwHdBMV9dg35avv4sf5SWQ
Message-ID: <CAFEAcA_rdzN_eHiEa=G7w2-=-HrPDQF4RDp9+K0v6nboDWk6bg@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/arm: Implement SME2 support in gdbstub
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 16 Oct 2025 at 22:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/16/25 05:21, Peter Maydell wrote:
> > For SME2, we need to expose the new ZT0 register in the gdbstub XML.
> > gdb documents that the requirements are:
> >
> >> The =E2=80=98org.gnu.gdb.aarch64.sme2=E2=80=99 feature is optional.  I=
f present,
> >> then the =E2=80=98org.gnu.gdb.aarch64.sme=E2=80=99 feature must also b=
e present.
> >> The =E2=80=98org.gnu.gdb.aarch64.sme2=E2=80=99 feature should contain =
the
> >> following:
> >>
> >>     - ZT0 is a register of 512 bits (64 bytes).  It is defined as a
> >>       vector of bytes.
> >
> > Implement this.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> The size of ZT0 is fixed at 512 bits.
> There's no need for the xml to be dynamically generated.

I suppose not. GDB upstream dynamically generates the XML,
though, so there's no upstream XML file for us to use.

-- PMM

