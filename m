Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F081C4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 14:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlSsP-0005Ro-5J; Sun, 19 Jul 2026 10:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlSsH-0005RS-Ck
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 10:52:14 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlSsD-0003si-SS
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 10:52:11 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-667923d86a7so3619298d50.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 07:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784472728; cv=none;
 d=google.com; s=arc-20260327;
 b=sBJPDbkyj6DrOTBNEwH9yCxrrD/tqJaRoOuBCMXiP+J6KhVx0hf1A/hrWiXGOmLo/p
 u3ZdutM/D1dsL11k4Y5OnI7kDycVfzqDt2V2vbRQ/fUnBq6vYsqjmR1czQq+gyq1Rss1
 NIHLm9kxbTO9iTpyQnPS2AfK/qlaAdUMXtKFM5mFjOQVNcbv3Qe8JYS+lDz++PplZ8jx
 njDOS/stV+TgyxNUtY/7zzH+1uKoy3FWEMgSrIH1ToCARRPsrLUTsYHlb7Aw+yODnLf8
 GCS+D4lmD8YjBTbPhZfX1/c9lg1TSD0JV/bx8hLTkbgHxaQDkX4mvOyuc4QwHGz3SwCF
 0VCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3XGeCYzTfyZfk7N+G2UzxTy4k0XS23v5CIwudahN9IE=;
 fh=al5FSA0QDJIfPMoyjfWiwC7oXFj+LfcBdbFSSZtoaSQ=;
 b=H3wLqMXkLOyTbMlhoOJzSvqDdis81vNjC0Tr0SWTXZ46gwI0z5Qh0TFf9S832qWOKx
 yCPzOrnopZ8czawj097ZmRbC9SM3lH1lDIspd6kmhv5GjSC+K1bIEhiLSFXJli/Vgu26
 wofEC+JIOPuC6sCaZOlM4xNSvNF+/xMAyYKO+/+hxhokgEr+MNIOYX1sOsxSfxwVnfSg
 fFXTqVlOYDYu/b84QtjmVCVuTUUnKJ4QEZhILL0XJL8x7sXt1XYlcjZsE7YGDQp1KD42
 ctuxdfdeQMkmwaSLyqgsGKE0ZSAK1F7AkwmTiY5EZI55ntZt7eOAPaDKh/rTbaETHLmV
 XI2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784472728; x=1785077528; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3XGeCYzTfyZfk7N+G2UzxTy4k0XS23v5CIwudahN9IE=;
 b=cZq8W/6xvbBIU8ZjZAi/Y8+aAKDkQLqdepPlj+iT3pz8Q9Xa90Vrt48koO8vVZj8/P
 6T2rJQJvBe404B3lMEVj0qhvj2ah+47GBfiwzb3fNSR2QzS7pZP+FuhE/uZIjNlIB86u
 3gifqGe8vYulUQoEaqJugW3ppeYrC9reOkqJtNwoIPgmLc03OW/IV2+QyFNesJd5vK//
 sb9DmtfhoQh5XmCv4EWQYbmxhcNfJxyt3vF7cM7E46AoNJhIKbzkCVGVfOxojGzUKv2L
 bXRzfRncl8kb0ZyZkHOadPhx2+GGPVPK3LuzNOxPWgQaNviOxIF4uAqqRFw/p7/wWeiG
 ICqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784472728; x=1785077528;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3XGeCYzTfyZfk7N+G2UzxTy4k0XS23v5CIwudahN9IE=;
 b=GoLv0dkTq+kVuiL0VPCezMvwqGne4MNYLwOTNt1G0bMgItxRj6naGlgJtsVIdton5s
 rKK3ZPN++XFdI5UCFUnWof6zBKQSlB48I6D8BzW8Ha/NPitVKymtajmLJkTmo3elfno1
 IrREpyX3sKkI4ZEgnmbt87cC2QTGvnUA2h40MhSZExqnaTSefxDWnAnOD7jDBsiuF2IA
 YwhiLll7InD+2wjhBceSbuyNSPyxwGqIwCxDei4fv7myjJqThwxNBXazquRtGbxVLmi8
 7/zpPNfzkhmicATUUFLLzWOYKAmUGRxqmhjKVHrXgKrpxGnQbNSfbPvOk7BkQZxm5qmz
 u4Og==
X-Gm-Message-State: AOJu0YynE6PGUd8z8jje8LRu0uDTpEIX35Jhqut++2vQqXvrWLcGJu5P
 hsR9d7zyk2mxp/I8AEyy0uSGHNlxPJVLpg5YAY+ussLSxW0o0uU5ZSC6SaQTA2SFIcY4HpmZ0Gq
 uI6qx3WbdwM80xcm5QyW1OTZOmlou/YjrKlSaotz75A==
X-Gm-Gg: AfdE7cklbh2moqktWzFNdrajDo12gjaeMsZya9Pmd/Zb/U+z6C/0c83THB27Z2PC6IX
 XzTacrwt/SH5TCIxYW6Nh7jaL6wZjP2/fgKaWkN9n+IMLcTGGKrRkbNIrXddt05WW5klTyX+NTk
 OuZWPipjmuslfwjbaMKClyGgGglfn+lzcYS5QphVuc0Tt8/HI04cAk9cEXuidpsx5sbRovjWbKQ
 lBU09SPljs1ZyTcIIxiO14nq8nITEk5lA395Xl3eh1prn16in5pBLHUBW1VsekOXZaqVNK8pfQn
 1uvnZcv+XUhxiZ4zk/haGTvaqan4P3SppqjmQO+vV2vwOQ==
X-Received: by 2002:a05:690e:4882:10b0:668:f6f:c40f with SMTP id
 956f58d0204a3-6683abbd3a6mr2252151d50.33.1784472728068; Sun, 19 Jul 2026
 07:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260719061528.15587-1-thuth@redhat.com>
In-Reply-To: <20260719061528.15587-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 19 Jul 2026 15:51:55 +0100
X-Gm-Features: AUfX_mxM0K9BQODRcvOurhyGvKiVsC4y8ql1YmYJu5bykyEFU7T1-ReMWw17ApA
Message-ID: <CAFEAcA8EJ8KDuA1uLweOPET-dp+_MZ8zZt4D3N_=1tLdZ-QKCw@mail.gmail.com>
Subject: Re: [PATCH v3] hw/usb/hcd-xhci-sysbus: Fix OOB heap access in
 xhci_sysbus_intr_raise()
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-stable@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Sun, 19 Jul 2026 at 07:15, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> Some machines like the microvm machine instantiate a "sysbus-xhci"
> device with just 1 interrupt (by setting the "intrs" property to 1).
> xhci_sysbus_realize() then only allocates the s->irq array with one
> entry.
>
> When the guest writes to the ERDP register of a corresponding XHCI
> "interrupter", the generic XHCI code calls the xhci_sysbus_intr_raise()
> function with n > 1, and this function then calls qemu_set_irq() with
> s->irq[n] pointing to a bad heap address. The qemu_set_irq() then tries
> to call an IRQ handler via a function pointer in that heap space. This
> either causes QEMU to die with a segmentation fault (if it's a bad
> address), or even worse runs some unexpected code if the destination
> of the pointer is executable code.
>
> Looking at the xHCI spec, it is up to the implementation of the host
> controller how many interrupters are available. So if we only support
> one or some few interrupters, the registers of the other interrupters
> should not do anything, i.e. reads should result in zeros and writes
> should be completely ignored. (big thanks to Peter Maydell for helping
> with the analyzation of the correct way to fix this here)
>
> This way, the xhci_sysbus_intr_raise() function cannot be called with
> an invalid interrupt number anymore. But for good measure, also add an
> assert() statement to the xhci_sysbus_intr_raise() function to prevent
> that similar problems with calling arbitrary function pointers on the
> heap could occur again.
>
> Fixes: CVE-2026-16043
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4001
> Reported-by: Tristan Madani <tristan@talencesecurity.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v3: Use correct word "nonexistent" and don't skip trace in read function

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

