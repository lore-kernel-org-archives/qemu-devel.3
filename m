Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE27FC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjM5-00077M-HK; Mon, 11 Mar 2024 13:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjjLx-00075A-Ec
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:22:24 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjjLq-0002u5-O8
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:22:16 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so6155001a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710177733; x=1710782533; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ExZDLlcW/aPce/t871JYwvQeW26VYQ80tHmn7HDLWXk=;
 b=PPFCxA1ulRLl3VBWbEiUodPtMsbIehnkSCLfF3kzDwWQADlW12LwgHJpoyFWl0GqF6
 /jPEA5cmXPtyHbzXAhCLTHv6e/j6y+uHw41Z1E6Cx6uqET7O8xdjRp25H43CnPU6x4y6
 T9phT5cEzqMDPAzrkl7ayssuWM/NCVzgtSAvBQ9QaNRorPEPlyXYb+pg+Y6VGWVLRluq
 x/5V1XTbnRZaGV7giPL0wO6kZAg10/vswtME0+YOHyeA/O51EsjzgYl8Rw/F383Dd5+/
 UlvpGADeArpJGVXdpUJLyx8tPcS/nCHEyKOGE6/hFDQoiJNxYnbqp8Qp71aiIe2IadUr
 czLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710177733; x=1710782533;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ExZDLlcW/aPce/t871JYwvQeW26VYQ80tHmn7HDLWXk=;
 b=YycQPvQ3yqtNp5uloRH/fE41w8y0+SsbSjgBICSyBjxLUiVUvF4S4fzCs846Csl8oy
 RnXshwwQr01/n9/GYYmQR1PdhtBjMrwjfMreFrA4KvS92lzgFF+1VZBmxvwbpx2c9hv8
 8s8KmHSyaEifPX96eVphyvYvumMROZUDdbbAxEAwtCfTB7LZxG4XOuKu2oASOsxoruKA
 6F1rPTfvysa7IsYucQl7HVQ12+EUg53mXs1iJB0mjSzOYnNpr3z/EP0F1q03+sKvt73f
 /r9AgJCsP/RbZCg9uFafORNqKQ6puoEbVBnOagLytcj8jIqMyqQyI/DWFrx53s3NsXck
 c9uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGzO3hUikzRKBgiMNb6y775xnI4FSdU1B1625DiN/LCCROpujnUGX7Wo73M5HFAt5wRSsuB9mNQGze1SmpLdV72Xjlc7U=
X-Gm-Message-State: AOJu0Yx0lHhtRWF0zPG08r8gS2aIuHwmsDK24HDRCY/upjeIs9A+ji1Y
 JGhSy/+PLShiXtKn/6zn6r4bJW0hig2m4GcoWVxGTAnKa6LrqgAWT0s4iTiZwWXx/SGB5Zfme5R
 QAyqbIWB9v0KrxZR9JxpHcvcmmaHRXXmzJzeOg3icosF5SoyZ
X-Google-Smtp-Source: AGHT+IFF0OpGwSHdUV1J4PmqeK91GpjTlDrECYjZKgU3NfG2tj+QmRdHv6mkOkcFXNZzdjJuk/JTE0JUcCFXGPBam+M=
X-Received: by 2002:a50:934a:0:b0:568:1882:651f with SMTP id
 n10-20020a50934a000000b005681882651fmr4979227eda.25.1710177732969; Mon, 11
 Mar 2024 10:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240311120346.9596-1-anisinha@redhat.com>
 <CAFEAcA_kh4sXkxsk10hCB9vAaJg2oNAv3DS_QhkHmFsWtVdUBw@mail.gmail.com>
In-Reply-To: <CAFEAcA_kh4sXkxsk10hCB9vAaJg2oNAv3DS_QhkHmFsWtVdUBw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2024 17:22:02 +0000
Message-ID: <CAFEAcA9jEdC7_TbKAr2s26TgtadU1uB+90i4QTCta1tGf2YJLA@mail.gmail.com>
Subject: Re: [PATCH] docs: update copyright date to the year 2024
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 11 Mar 2024 at 12:06, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 11 Mar 2024 at 12:04, Ani Sinha <anisinha@redhat.com> wrote:
> >
> > We are already in the third month of 2024 but the copyright notices still refer
> > to 2023. Update the date to 2024 in documentation and help texts.
> >
> > Cc: peter.maydell@linaro.org
> > Cc: qemu-trivial@nongnu.org
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >  docs/conf.py              | 2 +-
> >  include/qemu/help-texts.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
>
> Oops, yes, we always forget this. Thanks for catching it.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I'll take this via target-arm.next since I want to do a pullreq
before softfreeze anyway.

thanks
-- PMM

