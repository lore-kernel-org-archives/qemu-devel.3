Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10901F9D0D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCfkZ-0007i0-6b; Tue, 14 Apr 2026 11:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCfkX-0007hp-Qd
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:32:25 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCfkW-0002Be-CX
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:32:25 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-651b0eb2564so3310791d50.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 08:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776180743; cv=none;
 d=google.com; s=arc-20240605;
 b=kpuvJWNVk08MyLLZWAF8hx7W9175rclopfhSR+OLfiNHgOaQuG1/mbd3QDHThTvVSX
 51CMIDg9VBjFKABg9oDhnqZADCRR0Wo4PdvKgN8wcfLagLYfKJJ3k1HF4pxPlzhjc16R
 p38c1yCdeme68zAw413G4rw7K0zj0RpClAt2LvYM4ptP+lKIsqrgIm8ZDUDlDl0HZQXk
 FELbFzrgLANChZoCE/fkw2MX1Q+KBvwRhRftlnGu/hTep/ptVDWkD3jLEQhTWgIFBsyb
 LliWPAj4RS7cCvj3qEkmL4AkG63/IWiSgOzpBOlNTTJuFYBC28g5BYAPWXk2wmVhp0PN
 //vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IqgDWXgeJE2iFPS9/2bXY2Maq6DTFDlkahCFEcR7FsE=;
 fh=3YVkyDmas2Quef1RbylgZR1jFc8CsHwUZEHt8rqW5nM=;
 b=bI+UxvIMUe5a6krKCpj5Ve9BKwsH3D+3J6QE9vSb2IWxivpAca/mG+pvTlg6JUHogv
 nCg8EO8rCsT2vSjOn+x1CgF1pmpp0jP/2uJWjFusBevXan7fUx7IQ/jVhSACcn9CjxHz
 Fnd6pr1cBE8mmM8npPit91bzX6GpPspH5kGKbjT6JWjY77+O8n8LCzLN1fyxyWcRb15L
 98x4PjI/BTZ8dUZ0n0XRfmwDFlSGVwiGsnjSicIMWB5x31OU2OEZ5SgaMSIYTpLiIVU8
 8d70APeNdKqQqEHsurrlPFxcsQ1xcc+zcCzJnKS6XR/v37ByqGqLgPKlFWcHJJe/3AbR
 9+UA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776180743; x=1776785543; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqgDWXgeJE2iFPS9/2bXY2Maq6DTFDlkahCFEcR7FsE=;
 b=GcsvnvPKZMxF88Ive1teDuFn6LDO7N1DVSZQIW57+TfzYaC3fp/vFgKULxJ9xB0A4F
 faKStkfD/KXAAup/0jPYEaMDiLAbBM0z0Fdk6X3sPN/e8HOiPJmlWgQcb1BnhCHya4wI
 hIxQFf6xjaZpq34b8EPnLsYDKViVqwcEG2zVXGGTXMiYLE7Db0rK9XUUMDeYi0aYRHmO
 lapQfojr7Py7UH6dVr3lQRolzMP3/qtZ+NZksZASFsJSwHAcALLlNE1Yr3t6Q7tIyxk4
 C7Ak91YZejH0FtGmZ4UuyybW8BQvZqvBRSAIfIud7Fw85aR938xZAgOJSslweFGi78i0
 TAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776180743; x=1776785543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IqgDWXgeJE2iFPS9/2bXY2Maq6DTFDlkahCFEcR7FsE=;
 b=e8NqfmZexuCRn6vAIKn11xncfLhi8D1BoBm0/w/LY4w8w8GejdJMlyHOU1tCz6+QIZ
 wz4w7jL6KJ9ZQgffMt9Dg8X4cd9cdJbnzr7+kkNf9v/sYl3DYr+Cj9EcUiiy8H6UzLEo
 5j07Ghtj8MnYK4hmSTQ1+90dKO1PVmXbs3XckYaVIQvGErnkK1j9PuMHod+wiDJU31pb
 ZwlJ1FoCXSx18UT7aH+OZgL3JnnW4lC/6rTQljFlvEjY37yzl4XUs8wfHvrZneqBQxw6
 lNKfQ27J1ShYKPlohizTXzNNwETUfelkgg1q2FDpZrhma/eZdAZ89YdiYYRQy5h+a2aA
 MvCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bBLDivavbpoG61X22VUB2oW8SKhoJWjkc3YC/6oGxZMG8/PVoFyf9C3N6U9kJPm/hm8ID/uDP3A/9@nongnu.org
X-Gm-Message-State: AOJu0YyTnZBt4faPhuRJjQlGggbM1xud65S1ckY/OA7XlLhtmice7/Z/
 pMVFISmpzLL6UrGhC9nern3Ol9nxMPcV0210FcgKyx9B8lXDmpLRp73d5daue9lvs5s3lDAlToU
 Uu1GZ8TpoJ54RUjWvXQYFmNTtPBIzT2VbUnK+mPV3jg==
X-Gm-Gg: AeBDieuuOEEBflYmIeU5vWDlTo5K5ApyRD5mm7264g1QeHdf3hNzEJYAss1wyY8QeGO
 FYprXLveQf4Venk9eBrHIKr0UG1VmC1niK4oVTsMq6/M/XJ8QRQlA2eI2vg+XJKYbQIx/IzKnh7
 UZTZrWeD2gKgaTZlPg9GDsBet6GFLFG9qPOq7ym8YZingwdij6a9GLYCFvk+Z0llDL0rIs8SU4G
 eSITJZIazXHOaUveqZTSbrRWfsRWogBVsQTuzlCRrbHdgNOkdcbw5wsr1MRIPk3qoq1SZsXpgzO
 5QOGGg+BcBr+sEnYgzRQCtdDXa8Ovwg3QtLkbKYBNwjJ+Ribios0Qp1BsTipDYOvmMc=
X-Received: by 2002:a05:690e:4087:b0:651:b774:5f65 with SMTP id
 956f58d0204a3-651b77469eamr11715710d50.57.1776180742730; Tue, 14 Apr 2026
 08:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20251219014512.387773-1-chad@jablonski.xyz>
 <231416b9-034b-450a-b4e4-603f4cc3cdaa@linaro.org>
 <87tstizzxr.fsf@suse.de>
In-Reply-To: <87tstizzxr.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2026 16:32:11 +0100
X-Gm-Features: AQROBzDKAUwGURGGvy3Sl73y6x7IAA3zpUoW-9P3Ebki9IrBD3foidS9F3O79zw
Message-ID: <CAFEAcA-NXN+vBFAk05QavJh=bgRXqeqBPHxdgnsdLFFcqWet+g@mail.gmail.com>
Subject: Re: [PATCH] migration: Remove unnecessary zlib include from
 qemu-file.h
To: Fabiano Rosas <farosas@suse.de>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chad Jablonski <chad@jablonski.xyz>, qemu-devel@nongnu.org, pbonzini@redhat.com,
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 10 Apr 2026 at 14:52, Fabiano Rosas <farosas@suse.de> wrote:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
> > Cc'ing maintainers:
> >
> > $ ./scripts/get_maintainer.pl -f migration/qemu-file.h
> > Peter Xu <peterx@redhat.com> (maintainer:Migration)
> > Fabiano Rosas <farosas@suse.de> (maintainer:Migration)
> >
>
> Thank you, Philippe!
>
> Queued.

Hi; I plan to apply this directly to git so we can get it into rc4.

thanks
-- PMM

