Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F403D1A610
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBel-0006Yl-9c; Fri, 09 Jan 2026 07:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veBej-0006XF-4N
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:31:53 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veBeg-0006Iv-MI
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:31:52 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6467b7c3853so3195239d50.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 04:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1767961909; x=1768566709; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4xG3LesVXntyTIcHF1ub0eoBhOHYLDxtQnsDng9R/9Q=;
 b=QIX5iR9IQl+r3w7Vocwicl46To7StKlb4e41ul1oGWkR1HoCOgh+FALki+AUHQ1Emk
 Uzx2WnwLBaFpFAyulciio4S+Z6ONpPfNKCLTYOTXCBP2DMpdo5hFc2QZnsEF7ATvKZhA
 2E0cygAduszQoYQe7SV93RgtgyXVNx+6Vi0W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767961909; x=1768566709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xG3LesVXntyTIcHF1ub0eoBhOHYLDxtQnsDng9R/9Q=;
 b=aB/Oq7a8su5odUv1Fc/wE99br07idV9bCa9LH0ZnCRNthena6zSoQVCI0fWWiArsAy
 nBFyEvfIetnZWfHi4zPEoW343G+A/wqStnMbnssKWmkqM4DFFdlQecvmxfPsd1Oryybc
 K8d9X6J1uYmfAHtK0K+0PjRFZiuHm5lydrzYzWESiSwHyL4BQcwHEAO4x+/bfcZPEeoL
 qOatPK9ZOEBbpfUHW0p+Zn2qH/gb2z5Qr/lZbCEc33tgrbs8xupLEzhXbBBjqUPBwWbu
 bq/P/u3ZTt1zcpuyV4KYhrn+N20Iuk8uTq79X4Hn3QbZ3iYch5PbHpd1nJz8IUob+akY
 9xoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7OkAynaF0+7e0/CSXHxaxW8fH0gRxc3vEPJm4nfUTYI9DXPb24MGGql/j6/DzINO79wgxUNsfrdsS@nongnu.org
X-Gm-Message-State: AOJu0YwF2crqujk3/msHRuEpRuKoju/cAwk/o3CV7RH483ci/BgozbaW
 cT8BYRpwUwYKYqGgCJ/UfL40rSGOi28MF/FtpHxltRPTEuYPYqtAPriMfC1FyoQU3XX0/dyWkj9
 vU2nz0/PbaOnOXBIbrGT5JLGbUzsY2uI=
X-Gm-Gg: AY/fxX5m0xmBHhX+Jqjse1qo/3Gi5L67dGP8TJDxLn3r8AS2uBrTxTEJHPgTlUtm3Fj
 pX4GAO6Jts7B7flVWno8z+ZZO1BeOQV8HLbjYilfmsv0Duy+IKOh5RwAQL6nSzcBCfmf5vYEIXD
 ko6em+ZGAhGBw/v+2Lplh+ZA/IKtmGaGtbC9k0+ori3e/FfSHpfrsgtECJ0vUs4XHCg6t5I/7oy
 92lCZQRgOgfzA9QxVFG3NS5oMn5AJY1+0AtkjY8CLAjML5n1T2/teGpXNZy3SRhquQLR64=
X-Google-Smtp-Source: AGHT+IFhl06HePbCCiazhWk+bWEPjGuBI0jut+n+sY8YRg6nCYerC/H02CTAo3pWCwVmuSxy7Izgk1dL6lIe9mRP8Qc=
X-Received: by 2002:a53:b7cd:0:b0:646:7c80:d20 with SMTP id
 956f58d0204a3-64716c63598mr5759882d50.75.1767961909029; Fri, 09 Jan 2026
 04:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20260106055658.209029-1-joel@jms.id.au>
 <af7be4a9-b1d4-4759-833a-390e1032c1f3@ventanamicro.com>
In-Reply-To: <af7be4a9-b1d4-4759-833a-390e1032c1f3@ventanamicro.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 9 Jan 2026 23:01:37 +1030
X-Gm-Features: AQt7F2qWpmLtFWAl3vD8RJxCBljpW0-_opj-riP-OPgJgl_tdDchu1CI8iVpVKA
Message-ID: <CACPK8XdU1vaiKtByVNOG4DYySzQ-XBAei5E1VZAj2dsv36Y6vg@mail.gmail.com>
Subject: Re: [PATCH 00/16] hw/riscv: Add the Tenstorrent Atlantis machine
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Chris Rauer <crauer@google.com>, Vijai Kumar K <vijai@behindbytes.com>, 
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>, 
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Nick Piggin <npiggin@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 7 Jan 2026 at 23:51, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 1/6/26 2:56 AM, Joel Stanley wrote:

> > I hope to get early feedback on the base machine now. We intend to
> > continue modelling the soc so it can be useful for firmware and
> > operating system development and testing, so expect more patches to do
> > that soon.
>
> Good choice on the machine name. Looking forward for what's coming next
> (Poseidon, Varuna, Anuket, Leviathan ...)
>
> As for the patches I see stuff that could be sent separately in a prep series,
> mostly the 4 patches on hw/boot and the 2 hw/aia patches. You can refer to this
> prep series as a prerequisite for the main series that would include just the
> machine specific stuff.
>
> This prep series would be easier to review and would probably be merged first,
> alleviating the review effort in the Atlantis series.

Good plan. I'll send a series of prep patches out, based on riscv-to-apply.next.

> Also, the designware i2c controller patch seems fully reviewed. I advise sending
> it standalone to be merged right away. I believe Alistair wouldn't mind pushing
> it via qemu-riscv.

Okay, I'll do that too. Thanks for the advice.

Cheers,

Joel

