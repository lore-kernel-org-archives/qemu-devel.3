Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFCAE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1OC-0001eV-Fh; Thu, 19 Feb 2026 05:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1OA-0001S2-6N
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:36:06 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1O8-0006Te-3R
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:36:05 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ae222d978so747204d50.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:36:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771497363; cv=none;
 d=google.com; s=arc-20240605;
 b=cVGJX6BR3aX2PI2WgI9x7Kdkjpt0Ee50l77zC6/cDCkWzVXVZGUWQv56HgSSgstUP9
 ahPXxLAP5Tf9NpKcXUWzWXcvXCu0ZG69jjn0K71YdeOTWYFPU01UTX2bJQAivn0EbfqM
 4EJcJ3I9BU0Pf7OFO5NQjZnpmeBHIe8BkIhhA73wnFGMem72xshnG9qO6f7W1Jt2sPgs
 Ilt6ichlOHivij8pFCfAj0wYNqYf5i3szJrTqLVaVOjIAxyb3nzZVoyr3fdsK/rnFxbf
 EgaVTN8fAz/SieIznm3SX6XwwVLTY/t9cZh+3/zKsLLYR9XOFibRwOXrZtKJgvl5a7B0
 dvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dmp4uNRpCZz8PgHDTBq39Snqks/z+vXwoOxFYt9Oq40=;
 fh=e2eC8NuQ4/dcP/8/zm8PE7I9Ag9c/nkRlugmCPGBcpk=;
 b=QA2HujkMjGIfEFV5RoImEc68MA0CTVyVDlt062dEq7mFXvCjpTqhRykLc2ZyAfOJlm
 /d/fqcA40VFDNgYVfndzzxb4rChNGUDkFKVPBJ6TfA1C+kbP3fO8YbRRNUA2M1r9DZW4
 dvSanddILbYu2j0cJNMTE1nG40NOek0DPZe7SR48syOKHTU2yTKhne+7ZpMVwf2P3lRB
 /2/7kGVZ9PIT8f4oIvnbjTDDFWMP+4wOHSzLS3ybwVd1ZgEvp0fHLsHrLWnz4fP/4Slt
 9Ej7U3MEl6r79cfR7iX6JycwPY+3wgx5Pt36Uo7Um+tiC7cK1o0N0kak+rc3dg9zpWEB
 /g5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497363; x=1772102163; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmp4uNRpCZz8PgHDTBq39Snqks/z+vXwoOxFYt9Oq40=;
 b=SwvGkQbU8qwrPObqhA2aZ+1B5384m0kD0/Q+WhvjdKdFV/xEr8Ezy1TJePyA4wwecU
 pzqWvkHrtW23hYA+29mV4GYF/k9MjZwxzaVigFlB9m0Fg3S2y4Qpx7CnP6sJmEd8gq8l
 JIIr8OtseXWScE/7FN/UMg5xr48osyD/05xw7eWPD7ma14YmY9s3e2fyXeEbHM0tNxOJ
 H1CwueyVfuUR8nkcDbYMXECAEubViMrACoXw5AGadsE6R/TDhJRx29GmACq9jlGWv0RX
 TjYdaZbt9gWnkzLKF8Anx6eQaXDIyc5yRJ4tbDKwDfy1f1stQYe0nyh3ArwGel2VniaX
 mKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497363; x=1772102163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dmp4uNRpCZz8PgHDTBq39Snqks/z+vXwoOxFYt9Oq40=;
 b=N9BYYU9wH5Y6U9+MCAREDG4v4Rpm4wXJD5Xnqd327CWql8ermwa5FIkSkvcw8UjyCO
 NQ7JrL5Xpt+4jKcwHQ16Ii8Pg2woHFrRKxzEZG1hcsUP3UOS1Ok0KaS8Z8OGHmFqWwCj
 hcQzPiRnCiTgNHhEKufmpmY2mJI2UegZ9YVvJIHGBJeBzEC9HhR1GYhH/yId6iBBs49M
 6bNHX7YFNjZhWX2GCeYAIAvz8K8e+5wKWXlo82X5VWJCKYP32Hr3rsByBqGlnF19Neup
 w/3C2r8sLtspyREqumsdOZDNTIQL76/R0cXiDgDSS6hGqVrTrhc0ISVW0rZpKY/rNqUD
 3Ziw==
X-Gm-Message-State: AOJu0YyZmK4qVJIar6QVl8A3Boxcez/s9HLhRilaUxPJkSkm+oocMlFg
 PjLtk4GAO5COZgyg4NeMQY5HHVxXbM9JzILfSNFrj2J0nHFrPi8F23PIJ+67jMhZ/k450N2Tzyp
 kixe0405yu2Q3L7s1k2WnHRv/EjVU+dq5Yw9aJ33y6e4j1Ypv/Tao
X-Gm-Gg: AZuq6aIVq8+0MFoP8u3TSzeauYq36oeZX41x4fm+cSpVBC65tNThqRz2YNP1IBlBwNJ
 oXi0TP7lIkx0pW+zTB5eTVZYIp4TJIXBKJhRZW1XXTbEDBhtrlCdWeTnXn5xWa31PENl7K2Fk1D
 tfkmBt1iptELaZlK0x807Oubb6G5XsBjSGwu7Oh37mFdrRx4RdbxKrXdhkEAqL+KtnhYeGYayA5
 0iw8CpTNzxI+RyTJdx0C61Bt1xhbOEVjg7GDZiSU+xSKYLLdGGpyZeABzJbCRk6tKSybli/QE66
 2ugx4sZA0iG1YGHIpC+cUfkSXuNP833i8SF97/fmuiryF0OttzM+LltpAQ8pEqQPKpU=
X-Received: by 2002:a53:ecd7:0:b0:63c:f5a6:f2ef with SMTP id
 956f58d0204a3-64c614c352amr1397320d50.65.1771497362777; Thu, 19 Feb 2026
 02:36:02 -0800 (PST)
MIME-Version: 1.0
References: <20260218140003.1554502-1-clg@redhat.com>
In-Reply-To: <20260218140003.1554502-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 10:35:51 +0000
X-Gm-Features: AZwV_Qh5erBfM_YG9m4r-WWrV9RqFLLBLauEVyusoUrh1fcOXAxJ7Es0LHa6byM
Message-ID: <CAFEAcA8yBwdzj30sh54stRxZCsG-+dV4y8gti=BskvUbv2mqNA@mail.gmail.com>
Subject: Re: [PULL 0/5] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 18 Feb 2026 at 14:01, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit ece408818d27f745ef1b05fb3cc99a1e7a5bf5=
80:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into stagin=
g (2026-02-13 10:30:08 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-vfio-20260218
>
> for you to fetch changes up to 9757da895103709f94d7ffb6a2aef8cf4e25ddc9:
>
>   vfio: Document vfio_device_get_region_info() (2026-02-18 10:55:30 +0100=
)
>
> ----------------------------------------------------------------
> vfio queue:
>
> * Improves VFIO region mmap alignment for hugepfnmap support on
>   Grace-based systems (GB200)
> * Documents vfio_device_get_region_info() API
> * Adds a new VFIO_MIGRATION event notifying PRE_COPY_P2P transition



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

