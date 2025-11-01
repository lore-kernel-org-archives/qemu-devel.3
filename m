Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C1ACCFA02
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 16:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFEJr-0007Gf-H8; Sat, 01 Nov 2025 12:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFEJj-0007GL-0x
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 12:19:03 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFEJh-0000DD-0H
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 12:19:02 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-63e330a1360so3503791d50.3
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 09:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762013938; x=1762618738; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fyc/i2nWAzeFjWjBfbX9SaiynckeEaGBLgEtJU6TWmQ=;
 b=J5mfuMBE8508/WJFDlRjdPlYEsy6ujamt/7fR6bJEMl2P/+kFuMtiXz22BmKmIolgg
 4BTDSE0imj9+cmGF7JD4znckDSY2l1lC+H+2Gdn7LsRh4AjMY9NjIrUfCTjN5Tzht0fO
 G9GEgTI/j6URd1QldOkt3Dl6EFe8+H0r/OfTjmiR5KIcnWr3OUXa8dgYt33GFKA7Gjq3
 Z4GZlM193EpHbv34X5GrBUXRQ78ehnb8eMWFgUy9KUkGsHgEnsnPb/Och0L4nLDcnPf4
 hyHp4ehYk24I9OW9LWI9x4nvWCgLuwG1FqHVjyW2AyaJqRfUXlMDsuZ23cAUL4ZoiWjf
 1ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762013938; x=1762618738;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fyc/i2nWAzeFjWjBfbX9SaiynckeEaGBLgEtJU6TWmQ=;
 b=vfZ4ToVUgJTGN3ryzQ5K3nL40DQ2BtZvu7tdudt87q6DhnhiIhAZgUzC1E4n3jCxlL
 rEiw6t+PjywkEyER56Rh6mIs+fsAbiIWCic8c6x3KLQRJDpsN04bgUC7xdlDI+W0AMl5
 Zcg0F/Dzfrnpbe/anw4QMYauUE8a62vrR3WvndSbV2bEe7L8YDkMwl5DB9qn8dvMAqkj
 6MTV8GrB9DduMVpElVaQY/q+L7ufjHL6mEGmjr9zgesTDPZEEYsRD/Rsoc8leod1s8eq
 WpTWKW3JzFcUyOGgVXXmCNWDTawh4LtsUOsJnXIyM8pyWfflpTk2sZYugNcFRlhdTtrP
 C2xw==
X-Gm-Message-State: AOJu0YwR0fvlcn/QIdEXv5O+irFtRJ/xe1Fz6Tt43bQDI+eRIlM51CWC
 JpqAdNdybMBIdROUdrd6/3sGB4Oyb1a60R75J/UGEf/aEENXhSfVSXakOxO1T+wlfMzeu3VruQO
 pjFAldN8bhk5SHqSomTQ1vOcIIVxVOJ9ldocVCI3W1g==
X-Gm-Gg: ASbGncvuhahHbEe7F4Dwp4QRhP52GB5ARuIPkoWWsJeMxF7wCqjrcSb8w65dXkkPSqC
 af/tBYI4XbbD8rXnFXPgGXtmHvS+eh5F4UbXuXFwevl1AlkkLAeopYbK7ZwgqR2WBzkytdLPRdp
 EjHUjQZJdSuAM/RB9pbVichozI3Jq0tcUPgP5umqMcSO2dpE/W+EMT73+MdePelFDGbU2ulHPMD
 wwwqesVEcmjTyY3VMVlUTJF1wnymOv3VDhiOabHm194tk8QVB/cb/yM56nWmR29k/8N51ic
X-Google-Smtp-Source: AGHT+IGijqrp2V8dzTGEX3tkxiaH2MXb5dflW0HvZ6/YJVoYDRUI7c7AGwgSGwiNaVHVgaf/87mxcKjMHSQeUDRkM00=
X-Received: by 2002:a05:690e:15c6:b0:636:5ea:a88a with SMTP id
 956f58d0204a3-63f922ef7e1mr4427226d50.32.1762013938281; Sat, 01 Nov 2025
 09:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20251101130330.1927-1-shentey@gmail.com>
 <CAFEAcA-ycNEcZGF0kqLYBzq4xLSJikYZL_Q0JyKbuMuDtAJ7JA@mail.gmail.com>
 <6BAB4EAC-80E2-4DA3-B344-D233C014E7EB@gmail.com>
In-Reply-To: <6BAB4EAC-80E2-4DA3-B344-D233C014E7EB@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 1 Nov 2025 16:18:46 +0000
X-Gm-Features: AWmQ_bkXlqbNB7uXhJt_w2YcDKdopSMVDcrD8zq_nv1Y94hKqfhWwqyxeDTkgEw
Message-ID: <CAFEAcA-DP8TRX8cOrMBhr4+knC+68S90F6Zd2jd2SfqifSqUFA@mail.gmail.com>
Subject: Re: [PATCH] qga/vss-win32/install: Remove
 _com_util::ConvertStringToBSTR()
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Sat, 1 Nov 2025 at 13:48, Bernhard Beschow <shentey@gmail.com> wrote:
>
>
>
> Am 1. November 2025 13:13:26 UTC schrieb Peter Maydell <peter.maydell@linaro.org>:
> >On Sat, 1 Nov 2025 at 13:04, Bernhard Beschow <shentey@gmail.com> wrote:
> >>
> >> Now that MSYS2 provides an implementation of the function it clashes with
> >> QEMU's, resulting in a compilation error. Remove it since it doesn't seem
> >> to be used anyway.
> >
> >The comment says it's used by _bstr_t, which presumably
> >is in some Windows header or library that we're linking against.
> >Our code seems to use _bstr_t a lot. Is this function definitely
> >not required, or should we have something so we provide it only
> >when MSYS2 does not?
>
> I just grepped the code and it doesn't return any users. And searching
> the git history it never did.

The comment suggests that the user would be in the MS headers
we're including or the library we're linking against, not in our
own code, though, so grep wouldn't find it.

-- PMM

