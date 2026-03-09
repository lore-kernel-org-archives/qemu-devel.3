Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C7FF3C24A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaVk-0000pd-Ei; Mon, 09 Mar 2026 09:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzaV3-0000h2-B8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:18:29 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzaV0-0001cd-Hc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:18:19 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ca9ec3ee7so11231155d50.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 06:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773062297; cv=none;
 d=google.com; s=arc-20240605;
 b=Q/pKl7CfupDF2ScAEeEN0hzjh0rShuJF53gcbLS77/PcvyJgcTHOfyALMZQeevY9+p
 +4ZRMk3AEDyxFGdBKsLAOvu+RHO0S59f+xo0tWYjhKEdMVtMqtOmIOIhMhf0chFmYoih
 gVVb/lFN3EaNhYg4j1rAacHK5xXXelrLSz+KMseFHeOpk55jUC7ODSIFwBOeHPmMC4AP
 vDHdXXOKY9+D7APirWvUnKqcqdk66cS8DCTUyaT2u+Pp3flwManA/7X3EMtxfLKOSo+n
 UM6Sw+JRX7iOBWpbu2L1rZ4zqmSBwwScM40SfCuu+vnNmlYfb2QNWiuGb34mk25RyG1o
 Qfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SbOWHHVRszG47ZlggvIgxsalaSxoDe3K2iT0UqzdKNk=;
 fh=kzk51/YeQmI4YTCijVk5rTapTide1tT1Df99nxdLXdY=;
 b=E6H6yrY1n1FJUGIvj4kQaud1T1pu/7RE1RsTBllKnIYekVJxEuigbAdqVMXjXVFkF7
 S1E3fPYCEMRd3c0V1NAzp+9NTWfN3l+TSJOUU83d/nyP19ssPrtY0oBU3iyIrX3ZrBAj
 FCX6nZw97VlmbJEp47HjozppUJaMammw38fNdk2sSoX41OMzzh2obsdjXxUKm7XYdpkD
 LuNQ1gfDq4/7XGTj+VVpP4wpyoC/9kGYVsecvAR9+9ZAV242jgMVbz8DL0crdilknFCW
 83rYZRsPnCpl8YrwyabF2kAv4mMTiW0YsWj+TQHOn0+ucuUE88YTwLabuiiCZga3kyRI
 vL2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773062297; x=1773667097; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SbOWHHVRszG47ZlggvIgxsalaSxoDe3K2iT0UqzdKNk=;
 b=k7HXvbMhNHYBRgtPHBgmlnjviZ3DqUtlqf5CpDMqw5nlSpbn16nBfxoNqz/XfF4FTt
 aERGuIPqfSxa7qiqhHUYWj8Y/cauRn8/eMGc/ti+fbDpauDSbkv2tFir1hZJhJ2kQ3Jf
 ELZisKJXO3j9CPaDOOq3lWVt1O9I1CXJ/N9x7iLOU2BBKQRw8TEKRMii/PsUITUh+b43
 3/Ykqy+9QeFGS94/LLl3WM2SOubM7Htq27Jw1S2M6yHWFV5PK5ATwYBUdG4x81IW2vvH
 9NKmYVSSAc52zalL0noJP1rIfk2+0gYJSyWDWQvkPB4fhmApPOJV3N2knvMZyXNAWMU4
 AQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773062297; x=1773667097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SbOWHHVRszG47ZlggvIgxsalaSxoDe3K2iT0UqzdKNk=;
 b=K/b7nw75yoTPa/KUG/xtdBZIwoX+sXt2MTN75uKhfiMqf07vSy961/o/jVxHPts294
 +F4g20GUWprJZchWX8i6z4iuiLGiWvAT2ymMYI37iJgR2thPk8dPnwUeY8egKwyF11gU
 nbCbo0ZtlPhuc3BH+Kn2TWBSzNYkZF/ESr2IWNUGh4yTFIWfZ+8Nf0iJNPlkTaYpRwhU
 UmdVFJTMtxCJLRNYkqwmd6x/4kQveWhNUcc1q1Rw3soT7JPsoIUBpgGCZf+fEgHdgIiI
 QIer1RKcL1fQUjPiMI5IaCR1Cudnrg0FkDAPWpPlyy/4DnibVU3Sks1HcHDqEHlozAKr
 /ACw==
X-Gm-Message-State: AOJu0YzcFhjfMHwgNaGJkfEy0CPrq17xNEJkM0MsDiDQ6LxIhqOTyNbk
 L0qPv8wijNTgjmus0RK8ecU0NtPvxmnov8enflgS0nB09NCjabV6Yo9dfRuYMowxpu5/N0u7hb0
 tdxYO6xQNrFbH+4VM1TKNar6OBKWiywDRI9eAaT4XYw==
X-Gm-Gg: ATEYQzyd2zVM2eYNrjGFAvaiiJAmxm1lhNIfzn1QsnSDp9ZuAegsv8V8NfEAzyTz8kV
 Q8r8WkAJwiPRW8OUYQMB7J9gyT85DISkvmSXLC73C1mJuTAaz/Na8eRoq8scDKbfHLBKv+pSZ+x
 G1QR5wt7RhKkXdnikxq0eJ29cbVeCy1At0iq8qFoR1wUnkzsGVFrY8gHN2Q90kn0MS/rJPuxqgT
 iTYn38wVhV5G866Yau5MdA9ZGTzUxDxZoEh5WUFgu5iq3UaygtJZhpnq2amFLVwO7zgOhwNvdNW
 TWm3NGRHlp9W9eLqEeJFjFIk2UCRNXqM84kdwtCVjUAjwlZG7htrm1gYzB+qqD2P0S8=
X-Received: by 2002:a05:690e:e0f:b0:649:d3e4:43c3 with SMTP id
 956f58d0204a3-64d14361080mr7842730d50.80.1773062296372; Mon, 09 Mar 2026
 06:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_D3A83F7C6433B6B2D6C4513970FD0446D708@qq.com>
In-Reply-To: <tencent_D3A83F7C6433B6B2D6C4513970FD0446D708@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 13:18:04 +0000
X-Gm-Features: AaiRm50q7Q3vxVtKecmTYiXAlOIptkbGH5Hqks3SyRoH_sLCNlbL8H-QbInN96o
Message-ID: <CAFEAcA-L0t9rGZuJ2CWPitkBP4qBA9wvFf+xo4KN10EiWHjf=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] i.MX6UL LCDIF: add model, build symbol,
 and SoC wiring
To: Yucai Liu <1486344514@qq.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, jcd@tribudubois.net, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Tue, 3 Mar 2026 at 14:32, Yucai Liu <1486344514@qq.com> wrote:
>
> Split the original LCDIF change into three patches and address review feedback:
>
> - place the LCDIF device under hw/display and include/hw/display
> - use registerfields.h FIELD() definitions for register bitfields
> - simplify drawing to 32bpp host surfaces
> - add vmstate migration support
> - use SoC child device init/realize flow (object_initialize_child + sysbus_realize)
> - add a dedicated CONFIG_IMX6UL_LCDIF symbol, selected by FSL_IMX6UL
>
> Thanks for the review.
>
> Yucai Liu (3):
>   hw/display: Add i.MX6UL LCDIF device model
>   hw/display: Build i.MX6UL LCDIF via its own config symbol
>   hw/arm/fsl-imx6ul: Wire in the LCDIF device mode

Hi; thanks for these patches. This is just a note to let
you know that I do have them on my to-review queue, but
since they've missed softfreeze for 11.0 it might take me
a little longer to get to them, as I'm going to be
prioritizing 11.0 work.

PS: something seems to have gone wrong with how these emails
got sent: the 3 patch emails have a header
"In-Reply-To: <20260303143157.80437-1-1486344514@qq.com>"
that ought to be pointing to the cover letter, but there's
no email on list with that ID, and instead the cover letter
got sent with
"Message-ID: <tencent_D3A83F7C6433B6B2D6C4513970FD0446D708@qq.com>"

The effect is that for instance patchew doesn't find the patches:
https://patchew.org/QEMU/tencent._5FD3A83F7C6433B6B2D6C4513970FD0446D708@qq.com/

It looks like something in the mail infrastructure you're
using is rewriting message-IDs (e.g. in the cover letter it
has added a note of the original ID as
"X-OQ-MSGID: <20260303143157.80437-1-1486344514@qq.com>")
which is breaking the patchset threading.

thanks
-- PMM

