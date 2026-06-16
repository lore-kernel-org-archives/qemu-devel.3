Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF404CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZP38-00025B-OB; Tue, 16 Jun 2026 04:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZP35-00024v-So
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 04:21:32 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZP34-0002pq-ET
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 04:21:31 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-662bcc30fafso238361d50.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 01:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781598088; cv=none;
 d=google.com; s=arc-20240605;
 b=BbdL3YrZTppqID/Aj+OLDUPliogelf5R++wDPJjtTa+LRKkykRhueEmriF3/2AV6Hp
 3PBLioQCXGTnf9a4q7e/X8GOuXg5QeXGgZADxsHQQBcKW2bnfQEGgF2T3MvTtoLcgk10
 j0MkvMrCDFtdGdIT9QVjSM+hkwLNN1myP/WkdraU1CLguQZVp43/hfvYZ7PbPDGgdubX
 C80QHXWuyyi6aUTP/ztAwvstzPCnAfE+2LGDt1rhDow6TiIW2l+b9r9jc+OxWUuHbFC7
 PD2ZHPioWrF55RxPHSaFuoF26KJcG8HYc1qRtDClN8OnvxG7K70HCezDVGEP8a3tDFwx
 ystA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CcgsoNfl3eNSRofGMtWhFenNVsEUOs5f5X8TDgrYT1A=;
 fh=EozbU2Dip7ihBuM+OpDpcROKl5e201y/O7KnKTMuldA=;
 b=lEU31a+yoaSepoX/G+u26pS6ozs7hwOnhdFquKTiaOCJxrmQ9FfQBo1NRsWonbL2xO
 mFtyD8rWiyecDTEFssHXOMvgje83k6tEzcQbSyK9qoNomF40O8FyJBkk1W09fs3Bt+1q
 nETbWIGPu0gvLLUXVcpIA2JLgUAS2fJQ+l/qt41SyhODEh8WYWH2y+7EF65k156Z7m3c
 VGZNUcHNQQuvMldDgmRoFKCwZ0RBY/TBuU2SvENBRnQ09SETn+zaI+uiUHI7S+luSO+P
 UQaraxFFntkrMbmyjceBajpVjq8bdtL/c0VXfEQlWws2kZ97GjIBMBwfBHiocWBhnjd1
 c8sQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781598088; x=1782202888; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CcgsoNfl3eNSRofGMtWhFenNVsEUOs5f5X8TDgrYT1A=;
 b=DShUvYT/TiQh4c0rCwq2ke7Lj1WFj/IiC6eOFqWZx3KOmAjArjDUCVxtahX5O1WxMJ
 45B/Ct7s1MEg5nw+wD6u1j/NhmNDiwNh8LzX8+Lg8yYNoqk2SXAzxFNcPbY/5bmP+YbP
 7AEblr94TY50Cx91RjG6sHAf+7KIgL9k1DuQ3jB8TY+6zbLKTdetT6ICWABDyuGC6CC9
 6mtHg3B3/VGdXypvpIltDf1GyERiKH90MUhtwiS09OGjyxg9FKorJbpPJ2c3lCQSqs6/
 u3G6LBVG6ou47d9cofTMHqTCBTn8OujjReBtO+Gryl4pCSXJ6yYmNG2AZeeczO74ae7w
 JTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781598088; x=1782202888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcgsoNfl3eNSRofGMtWhFenNVsEUOs5f5X8TDgrYT1A=;
 b=ZxtPhcc+lu6V6i5p3UNER3Syfm080DwCy7vmZbBze5FgYeFh0Iohu8bnwDUAd1lka5
 j8HQQ2Q+U6Qg4oPXVJ62KWYYdvtWHUVhSZsglVWiGg0vZDuTwOP++Guzmq3lSpJbS5G5
 ZEDv199jUOoriwmmHysh65O44pjQ0Vev2admNgIvjS95fDoqiYaPDm0WvVhcAE/Im2NV
 LIZQmXw5gZqDM5GV9s3tw87m12YUiBrprdpwx9IqBU+niQAkinajtagyFoUoJccnWlI0
 KLs51gRtz0VTFnUTtoODlkf1+KhJheiPR9s07DnnML1lF5WxIGzUqQGb7sVFbDSK9mMi
 K9fA==
X-Gm-Message-State: AOJu0Yxlaf5EhlfF9Ie5Q18ic3H9C38CvPskoK1sDGeJIaIuPFL+46Vw
 yPrTpiiMw65GaW8NZtU4E5uzHBbEl/VNBawnWB5SfY2sIFcMKjiAevRJ3+7DOx12HWLSzgN7LP0
 Yt7SGxI87ENggPBugI69zoAiiFvPY9m6x3mxsR0FwWA==
X-Gm-Gg: Acq92OHviwy/lUjNOeCMSt3wMPyusqfDN3DZJEhxGz/yPZ+d2JKkEu5dk40NND9v3+f
 k4BOdakyK5EvHp2CkXJ/1avc3ToZvFiK15PgWbE83ztUjmxT+Nx2fcGT6EQxIdnGj20Oe8L7NL4
 Btm6JHyppvQKySdX66tQ168DVFXpL4NXCHtVavr6D/zjgGenkrIGmUQR05GhWM495+cKFrWZJcD
 HGWLOyMzr3zOOz3OQRlLd/Ot2qRRptot9AiRneMwG8NsaPEtQam0EhJkmpq1gGy5qzDTepDP99K
 3ABmPj9JMNX6hG/fWV3PXGG10v6mN03nVfWMTpRp3kHqANVsRO2I0+4MH1b+KDDEM2g=
X-Received: by 2002:a05:690e:150c:b0:660:55e1:5bb0 with SMTP id
 956f58d0204a3-662b60cf9abmr1681228d50.22.1781598088596; Tue, 16 Jun 2026
 01:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260612161707.158029-1-kraxel@redhat.com>
In-Reply-To: <20260612161707.158029-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 09:21:16 +0100
X-Gm-Features: AVVi8CfNlUBUx3CXU9ZL6mEHVxhcXgea9TBYkYswcw-nvJdfhdogHSZLidcnZkM
Message-ID: <CAFEAcA81cWOuu7QkC-8A2ze6MKgz0h21T442oNuDvw9uWv7UgQ@mail.gmail.com>
Subject: Re: [PATCH v2] add a note on -shim to direct kernel boot docs
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 12 Jun 2026 at 17:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  docs/system/linuxboot.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
> index f7573ab80a..c787481ccc 100644
> --- a/docs/system/linuxboot.rst
> +++ b/docs/system/linuxboot.rst
> @@ -17,6 +17,23 @@ Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
>  give the kernel command line arguments. The ``-initrd`` option can be
>  used to provide an INITRD image.
>
> +The ``-shim`` option specifies the ``shim.efi`` binary.  This is needed
> +when you are booting UEFI firmware and using the ``-kernel`` option to
> +tell UEFI to boot a specific kernel image, and the UEFI firmware you
> +are booting has UEFI secure boot enabled.
> +
> +When this option is specified, the guest UEFI firmware will first
> +load, verify and run the shim binary, which is typically signed by
> +Microsoft so the firmware accepts it.  The shim binary in turn will
> +load and verify the Linux kernel.  The kernel is typically signed by
> +the distro and the certificates needed to verify them are compiled
> +into the shim binary, so shim + kernel must come from the same Linux

extremely minor nit, I think I would say "and" rather than "+" here.

Anyway

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

