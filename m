Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A1DCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHmj-0002oK-IT; Tue, 19 May 2026 06:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPHmh-0002jp-K7
 for qemu-devel@nongnu.org; Tue, 19 May 2026 06:34:47 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPHmg-0005SK-1Y
 for qemu-devel@nongnu.org; Tue, 19 May 2026 06:34:47 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-6312af106e3so2651415137.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 03:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779186885; cv=none;
 d=google.com; s=arc-20240605;
 b=MfWrIPBsuXlouxCwn+iwWhte1ND6pTccSTweEQbrfO9ZZLyt/Eszi298F4zhUMsRmw
 C4wsHCTi7Vl3r8xojWm1X3zMQpFkSHeW5TQ7Iv7W6EWiewd1TERy0g9fFBEy3UTjhvGe
 P/ozkA3kUlIfbDBu9xKAfCuUDwDFqearmknZZQfG7G29HvEgJFct+rLwR4pxLsogLt3R
 MPc7cRkgJbX6xTWPy+mXqhIYzm0dCXmHai7Vog+XRIr9bEb13+m9tgXzw/YzSQFazoXI
 3Zy4SdWI2irdQZBqXmlighwvDAwt0vXUt3/aNIMLJ/7O1riezvHdLOONBV2ZraJd2hHe
 WxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DjFGDO+rJPTxAOU1tv6enj69fI1k+YxVjY85n3Po5FU=;
 fh=IDp0myVICjsESA2hUndJr6dhiM4iD0DVzqBF3oUg2jA=;
 b=Cai22vnCNehtGaTxrb5cB485HPeWX0yPsaTHksiogmMpbkHYKdB64BBcTOCGuNmAEf
 eaTg/g8ISyRJCjAYR3rO/SIMzG15VZYp2Nht988vjUnXKdFDHG5xenSQ57dpBCOa1aHJ
 AJTctM/zZ/cfuxzAgBMW3z68enVdzrC50G2SvxM0SqPL83ucdXIdhsmZYmHo4EKqB17a
 yrL82MYPpU1IZmjQe0958JB8yhb1SER2Yp01Mlnw0sdYbQtj9v0wYnkFHjDQ+8uOzXUZ
 v/JyjfdfI6DXFKvcfGwqJNIF+zgbHqAV4ixptk1w2bKcSvWO9FuN7lMqiV1n+S9kdgAS
 hpPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779186885; x=1779791685; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjFGDO+rJPTxAOU1tv6enj69fI1k+YxVjY85n3Po5FU=;
 b=DzhqcqXkytQFQ06GgtqwKs8nsi8nI9y7ioSkFK6TWcUJnKmqTL3X8NQkBurxki7gi3
 IGnzQHgLt+7EqXZ6JQukF5SbsdpCN3JOh1KVlz4xiPHap1abJHWGq+vqMT9t/43TVUth
 qmNlLxx9bN1AUXIAx36Wld76wCVvm+LcQ3TqT8NApc9UINs9jfTiltC7rqWa2ll3Jkc+
 zH6qpEPCzhp6Xr+1X/yqlBJPqpjGL+en/e+W6M8i6J+dQG48upU59kwbxJtNR8LUZgma
 2197EX7onUjJEEUpA6VCsrw8ahisja5vcA/Gopj9nFwT9GvyqHcvhi6DNQfG2YNjyJZf
 CzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186885; x=1779791685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DjFGDO+rJPTxAOU1tv6enj69fI1k+YxVjY85n3Po5FU=;
 b=Ya5HlQ2CBLHfJMt3ciafBnF1awMtcpYhguQyKz05vyUFNOqjgBE04MayclmKA1BK1x
 CjVtfoeVPxskI+heE5VnfAVCRDoUqdcOQABxIE9H9lIdPRIoUFe2ycnHh9XgpUfxOlol
 IpEbTLCLXzupLCPs5e72ihcPLod6itSPvBIoTVhVcUIPepG2X8vzInqTHgK5xwjOQ61Z
 tYzwaF7lNAWIdByODV/yyd3e00MjzInXGhYp6yf9Yv+am2lRwTzDrPUR8CqQnTOky9eL
 fza5+f82hecU8utIc0hYp+pXgov8RmxF7zUwudjsqRVcjFMGiwu1JE7ipwT/o+/58tXx
 Uy6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/IJ5fpjuIBBtDJNLNC6gEc78p4kIUosCFeUq2cw/BLXrAx69y3eEYuOMNHbE9TbcBVF1cnjsKjXbBD@nongnu.org
X-Gm-Message-State: AOJu0Yy5O6vIOUeg+w3hEYyJXXcmhroGH2AWn1wGg56qS21nG6yImTvv
 yvjdHZcEEfWhQN0ez7zz78OK/T3UTXYG4hqXiUweTlJScgaCt0HNwzX1QfAmcOh6/K6tMwN/rpe
 83DdMEVz6l2c1+39dS9e4JlMTUna223ULa89iF2aAfQ==
X-Gm-Gg: Acq92OHoeTmbs7WFTl40M6JbTGGfCKpR3WnlIFcEuulX7mAbZu1Pf0M80RHVZiipIO5
 g9T6w9TTFckjdkC1CoiE586y6/Y8I029NZCLlXtdm5wWhIjSHSLa769vHI6e+et6avnO7oQ+CJa
 MhzKzh7x8qD/DXspPLq27YG9g6rub+X0Pv10IBPd6afwq56d7mgwl5UBYiuiXT/0eGR2ZLEOtwx
 xhw2yHyH2cGD68xoOwv5q6AyxVQVps1Y4cTnr+2lv6syoXYqcdn2nUKvXsjCsW2goTmk2h9yIGs
 EXsL1XGO1W2waF+6QU84wvHR4DV/77ywxQoF+cjkHE4+piENjvntVruXAgI4nuD99ls=
X-Received: by 2002:a05:690e:1551:10b0:650:5316:1756 with SMTP id
 956f58d0204a3-65e228a4ba2mr14812476d50.57.1779186107206; Tue, 19 May 2026
 03:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260518160255.1844308-1-thuth@redhat.com>
 <ags5_IDkvxClCdHm@redhat.com> <ags7xIsUG2DqX5vu@redhat.com>
 <dbc6464c-2685-46c4-803c-6af53d345083@linaro.org>
 <c9fa27e3-0939-4490-b350-7a625ebcdcdb@redhat.com>
 <b70b35ef-1761-4624-9f98-7c1ae161ed9a@redhat.com>
In-Reply-To: <b70b35ef-1761-4624-9f98-7c1ae161ed9a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2026 11:21:35 +0100
X-Gm-Features: AVHnY4IDai8ohiPPmfUsi6sgbNhGbbfI7LCpWhYitX_rzPXlm_IUhss04yTv4bA
Message-ID: <CAFEAcA9JaXVTNbAXbaTDM-bN=HEZHEX6+cDLiTx8n2=Di04LFQ@mail.gmail.com>
Subject: Re: [PATCH] system/rtc: Fix a possible year-2038 integer overflow
 problem
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=peter.maydell@linaro.org; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 19 May 2026 at 10:27, Thomas Huth <thuth@redhat.com> wrote:
>
> On 19/05/2026 11.18, Thomas Huth wrote:
> > On 19/05/2026 10.24, Philippe Mathieu-Daud=C3=A9 wrote:
> >> "32-bit *host* OS".
> >>
> >> Per ./configure script, we still allow:
> >> - x86_64 x32 ABI      (CPU_CFLAGS=3D"-mx32")
> >
> > We should maybe deprecate that x32 ABI ...
> >
> >> - sparc32             (CPU_CFLAGS=3D"-m32 -mv8plus -mcpu=3Dultrasparc"=
)
> >
> > ... and that one as well?
> >
> >> - s390                (CPU_CFLAGS=3D"-m31")

> > Uh, we really still allow 31-bit s390 hosts here? I think this could be
> > removed nowadays, also upstream kernel recently ditched the 31-bit user=
space:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> > commit/?id=3D8e0b986c59c67e08ada646249f834655a9e6da16
> >
> > Question is whether we can remove it immediately, or whether it needs t=
o be
> > deprecated first?
>
> Ah, wait, we completely disallow disallow 32-bit hosts nowadays:
>
>   https://gitlab.com/qemu-project/qemu/-/commit/372ec46b9f1215f48a4717f2b=
7ed969f65bfadc6

We relaxed that check before the 11.0 release in commit cf634dfcd8fc.
We require a 64-bit host for the emulator binaries but still permit
32-bit host builds for the tools.

thanks
-- PMM

