Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF10C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 15:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQbR-0002d2-Gw; Mon, 27 Jan 2025 10:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcQbG-0002a0-8K
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:00:30 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcQbE-00005g-LR
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:00:29 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so6577778276.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 07:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737990027; x=1738594827; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prIHRTcFxRjf8k9oXkyXV2TLH0whA2O0LDCYqNyw7ZE=;
 b=BR/bzXwHCao+6WB8DMl00Y4fE1q2ukAj8V/hN/p935coeZZ60sCJ/qo+WVRLmOBPRo
 2KXIJVokwY8L+rYu5fX9sIXrnDTK6w9xk/+mv5KN6sq/GpV+3R74+ok4+GQf+DNl7y1w
 WsP5oW8iWAnMSniETMOH0VzJbV5R2KUsj/DBHOBS66oOJaaztf2AO5Yyu4f3L09OXKDz
 0bgD/9BA6Ku7eQFI9ZRQAdyu3FRWcppIjuiUz8m0FS/3l+zpjDg78ledCZvoOZYifC04
 Q8ThqGLhNIObI9qqDBONCD8Vex427bh8ctv44H24QDKoEuYBnFO6U/s5ZdS/O2u4peYB
 XBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737990027; x=1738594827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prIHRTcFxRjf8k9oXkyXV2TLH0whA2O0LDCYqNyw7ZE=;
 b=fgAtmQ8ynNQcUDhkOhWWgCZQiYjx7XLQomyjIwg+PeiSm+Hw3ggCvDYuPmUNyTXsPE
 oC6WZKcJMAeYbCHmcp7fv88BTG1LWR0nsUlPQf6F29sO8xb/XKht1Gi/+woh8NyyCKrp
 9QZpt5P+RMSMueeGFwxdGC8xzUllUc9WDBYA8QTM0UmlzwdegIKYd5JJKsDbQOI2XzkF
 nyswFyilv2UcY6LIDIje2N3mmEMZjXGxncpEGK3jElblZS+1ra4L0SOQmgIKdxQwnNFC
 +FHDgx3hOeki0CC4XGNe8ElRqGR664BR47AUzeSuoyc61tQ7qCTL5e0xxfarDwulWc3S
 rZcQ==
X-Gm-Message-State: AOJu0YzVnoGdqNc1wVGcfOU4GugPhhDHSi939iTQ64aVNISgNkTG+5Cg
 GuVPL6jAGnRaSGHroikA3JfMqtb/esP0DoUysoxwxwx+yRz3JR5Dl2B0B4sP5sSGf3ciEH1UVi5
 +SLtDFZNF5Ltxxoj0/WEngbBxjE2fYQrAe14n7Q==
X-Gm-Gg: ASbGncspL1HC0KAflDtJX1hEd2ziZOBi+F1scIdiH3rDbBA2YUJfvC6cCtIUIL6pmPz
 SsqIOMefmN8vTSUFct1/7i71wPfVTWYKyFDZShcJMroyoH65wc+IsLj3R/2o7Mi0=
X-Google-Smtp-Source: AGHT+IGBRSAFk/sy5cx23XsislhaBJPX8boKg/yhiV8pPE1VKot5LNCOOJpPtnCcmHNtujNo/EbYbDKWnPwLYEnrTcs=
X-Received: by 2002:a25:7412:0:b0:e57:cb7c:29b2 with SMTP id
 3f1490d57ef6-e57cb7c2ceamr22412031276.7.1737990026756; Mon, 27 Jan 2025
 07:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20250110160204.74997-1-philmd@linaro.org>
 <CAFEAcA95_AcsszEwqybegfabb-bcZK0qfvF1BjmbsSReTbwvaQ@mail.gmail.com>
 <d2a59e25-51f8-494d-8bd5-a1d5c50e8696@linaro.org>
In-Reply-To: <d2a59e25-51f8-494d-8bd5-a1d5c50e8696@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 15:00:15 +0000
X-Gm-Features: AWEUYZnyhbk4Mb2AgBOmnZOXwCLon0PXHfIlv97Sjm6m0W-6twXlOlVxBB9yM_o
Message-ID: <CAFEAcA_+yQEiXwxu4ZEVkcWGV8s0cXTh9CHKh0zwn=sbGTfB_Q@mail.gmail.com>
Subject: Re: [PATCH 0/9] hw/arm/stellaris: Fix overwritten IRQs and cleanups
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Mon, 27 Jan 2025 at 14:49, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 27/1/25 15:31, Peter Maydell wrote:
> > On Fri, 10 Jan 2025 at 16:02, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
>
> > Applied 1-6 to target-arm.next; left review comments on the others.
>
> Thanks, could you s/http/https/ in patch #1 or should I post a patch
> on top?

Yeah, I made that fixup when I applied the patches.

-- PMM

