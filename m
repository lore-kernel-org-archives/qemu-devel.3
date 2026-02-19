Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693E3E9A04F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 09:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt067-0001bf-T6; Thu, 19 Feb 2026 04:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt066-0001bW-CB
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 04:13:22 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt064-0005By-Tq
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 04:13:22 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-649df3c22d4so611359d50.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 01:13:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771492400; cv=none;
 d=google.com; s=arc-20240605;
 b=iJsM1Mhf5qqAHGQhmIkLkHldBSk55FcPGZ0zgYZxuqZ18KrCZ94BbOxIS26nByPWku
 SpP9CfRpw+0X+9eV2ZH70r7KRiAprD8x6gOlGVXyoVA/SrqFCgfl1/TmgUIBETu/mEoU
 f40iuVT3VjQShOwSbBXlOH4rvZ2Gt1CStNPdFxGfCUTHFgHDEcZT24TVvTkSPBszirj/
 eoWcbvLws4xVkn1GsebNkLuutAAKSu8cRXLSGVgVxGwTob9/ym4vL7NeZCR+uZG+8pVg
 bQ/bUgqgC+BZYhjCiK6W0Dl0gBb/QT0WV49EmHE+9mZEIlQ7eKscKUQz++QER6NPWmJz
 FXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ob2l66wmQc6TEPMpUq7eod2DeEBYY7T7XzJMDCbpwuU=;
 fh=a48Yz94NrSN1VfxXFKxdHg5tRcnTkBUqJPewYKl8hN0=;
 b=QUKJT+d5mnjn0sniq1pIY8EmTNyUOg7njmnbyelLuINYQIlrWDa3YhMXIMmTXFqsxL
 baixjw+nmEzfw+QWCWN2n1RRhYakDvR1SKKSEwrJ/XwOJMkKsOM/6blEJYCpIufHwcbd
 q2uXYw7UM/2XU+21pLOEKk6tpF3eakFOuALNN7lfL5UYVX6zX6PhFKG2+2QuxknX+eQt
 mv3Kf6aBBU5vEuqleA7awL2rgYdXBWVdFun5bek1AkBEv4DNsdWAjHqF/wBmzUUqAcAP
 38l/bqpclPE6AOWBhJMUIsUyPLV3Uwxc66YeiGIAtY6O9MCwT0bn3J3a9H8Vd+OI/Qeu
 wM0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771492400; x=1772097200; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ob2l66wmQc6TEPMpUq7eod2DeEBYY7T7XzJMDCbpwuU=;
 b=Mt+H6bSTVcj3seKftypA/VRJ2GwfZtA/eN989iaVH4tib4cqQW0xsZgD9y0BXo6rWa
 6SbW2TW370coZtWZIXdafe9R/je6nsfC4XodjyHRkN69Jdv14dCp0seBIN2AkjT//dXi
 V64db8rOo+buW3LEuDsdQsZ5sUE9VtCwkuprhx/3526wy3NWMjVNJ+OaYGw+2JGARF/z
 RTm3dTYkJfMw2OQ7Jvq78LYNL3K2xEvrrQJWQ48rVZU+WIASssdUTFlKHnxmi83OlYXw
 iVhWt8F5VAD8iCRIwhDQxqaFdJnY8XqrhEQ72mK7isKn+sefiVh9M/ipxOYxm43uu5RH
 hCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771492400; x=1772097200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ob2l66wmQc6TEPMpUq7eod2DeEBYY7T7XzJMDCbpwuU=;
 b=w04pq1uU/I79Dz9Hwj043Cp4Sp1HfxnicDnazvzaqVleeEW/XCUYdZ8V5qSax0KrbW
 8vu4HEYWltcU2mLkGbezL5GgyXbcMOZWLVKdhIY09AnF66uI0EQISRpnaPYeUUHnOJ4U
 3le5Lrq2rzR4dxPJiM2/0ql41FYdl6LhqLzncKei0ZYDmcFwho9A2R48PKsfZo57pjKG
 9r+GQbOmjn2mhIW/ruw3H8qME+Oh0Cdm/ACH/+f/ZkkdtXnvm46KJReDWzcAvMGSDxGU
 TVy81Py7XNVROxG6tNWOqucpC18STrXdP8bW2du7BdK8PHvePaKKkj+79z1ICdlqqcuK
 jalw==
X-Gm-Message-State: AOJu0YwBbbL7rQMxT/ud9YmkomXfXONlLbqIbO3S2b+HWNRcW0kBXqrd
 rz8LsPWU6QXV3SZsT3MyutBVXMAPppL/abbTd1Jy1aX+TrSVE7Ve/Y0Cp79mmFwMNAvgcrEjcvf
 /jtnuytvAgXgyyEfdHUy6fcnZ9KTcoUICfO2YXjfoyg==
X-Gm-Gg: AZuq6aKFdFisBGIjgyIAhe06wP7LPLdfSTI6GxoQqjXUemkvgK0I59S+TaGyH9D/jKK
 x3q0YmYNHW4QvQLg3XxUGrhngsLL8bLCtVaAulQEATlvqaH287BftSGG6EaFhRE1BSkFD12+Wym
 YY4FiD/SxZY6Xs9jV7p+bekpVw+GlByb0Lc+2jXF5d8wSMSozhbdWJF4DIUlWQGe59vTATkeUIv
 3Zi8e6Zwepn4USbSeXdKNKbuWuru59E02dxdQIdib7sByu7q7DfqDpse4yAy5KlUGJ546glo5jR
 /OxfaiSs43BtXoEEoxORtRDToldDSdKMRFb3ZGwE8Y4aFQ5mlBZ+TmBZFhfqhK01arA=
X-Received: by 2002:a05:690e:13cf:b0:649:ba41:18f0 with SMTP id
 956f58d0204a3-64c21a4432amr10611157d50.9.1771492399719; Thu, 19 Feb 2026
 01:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 09:13:08 +0000
X-Gm-Features: AZwV_Qgor56D5MdzLTxqS-0fie87awZi2qflxF27bEl1V4V36x7z0mPer4AloY4
Message-ID: <CAFEAcA-Gg5pJW=SYV0xQX7tBz8XwVJT0pUbnJqwoBzhZ4Fwx+g@mail.gmail.com>
Subject: Re: [PULL 00/85] Audio patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 18 Feb 2026 at 09:03, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit ece408818d27f745ef1b05fb3cc99a1e7a5bf5=
80:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into stagin=
g (2026-02-13 10:30:08 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/audio-pull-request
>
> for you to fetch changes up to 671f6b05e8939f01621250446d6d9a71c7758254:
>
>   audio: fix leak of audio capture name (2026-02-18 09:56:43 +0100)
>
> ----------------------------------------------------------------
> audio cleanups
>

Hi; something in here seems to be causing the replay tests
in the functional-test suite to fail. I've tried retry on
the jobs several times so it doesn't seem to be an
intermittent or infrastructure thing. Examples:

https://gitlab.com/qemu-project/qemu/-/jobs/13179297572
https://gitlab.com/qemu-project/qemu/-/jobs/13179297533
https://gitlab.com/qemu-project/qemu/-/jobs/13179297557

thanks
-- PMM

