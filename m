Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E82E7E0CA
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 11:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpOzo-0007S5-UP; Mon, 09 Feb 2026 06:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpOzn-0007Rt-Tj
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 05:59:59 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpOzm-00066s-F5
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 05:59:59 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7948e902fadso36884557b3.1
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 02:59:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770634797; cv=none;
 d=google.com; s=arc-20240605;
 b=kkKogfA1dVPdbVA1HOK/IXyn4i8lmcpmv1BfQ8QjYGEIq/gDds8zwN/S+E0nSTzfEb
 4/R4K4JyV+YlOZmqsuiHJwfr/T+eJHtFLQWCEUm+AQwxF/LWc3wPIYyc/gg7toRtTywP
 Vw9Q4y3jtHh277TGbn80XLsKUWBQjOV3nf4O7/wI/UhtROoPv5tI++W4KTI6jM6wR3TS
 3lHuUWIx+cV6yUV/def6RdPPZStrpkZv1UQVf/4lyeAwSIYoUPV5GNQ3V+7yFjqDMqru
 y7p8QSxBhwY4szDnm3jMKXi7T7zCUM2//0ARUsIaogYHZC3abK48VT5/s7bIS0FzR8tl
 jbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AW7iR7ezhxl1MeK+z7eQZkFK4/l3uvF1vjXEXQ50QD0=;
 fh=kKOOyNDP2cpoXHabZOBEVnMSGHm/aLW0Oq1cKs8jhnE=;
 b=POVQON8f9owAy6R2gDW9pgL9T6FjSsoF4pqBbZLxEeROyazmYcJu9YwtHJBtYEKTQv
 5SYMXvuK6lUOjxcGsp3zBl8TbiL8hjB1DYN91+ddiQSX+aqFbbDwvk+HsOoBp0e3jbTu
 xyY51r7X4OhdEXfKSu1kpCjjTbJlB3Jqyia7Op2SfsgM3n+wHlkY9FO1qlYnuSybd+u1
 eypdXOfir/tBRuB2+TWW92j8qHPrKEXPCTEcLNzV/XjIiEXQ1h/AZNVK313l11C40Y91
 B9mgPTVwAK2w64+NVn0zQhh3d/gSYK2Uob7rmZmg1qfLooNYFaAJYdferbeoCdHv0Xlf
 sxXw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770634797; x=1771239597; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AW7iR7ezhxl1MeK+z7eQZkFK4/l3uvF1vjXEXQ50QD0=;
 b=jNjVJKdmQPu1h8lLm9O5aT/JS2Tn6sX/cx0cjqFIjtjXH3CnVnvbwHKprr0IDzBa3h
 qdb2SSz/A8cIyECeiWy5F687s3GcZyJDGVdN/d9tYsp1FBN9U74rYNwOW/JvMRYTOjvH
 BrDg8lUGKr2lcCd2QNSQoG3epcL/NKbyiI5Lls6hUHywVyE8d4VNoRRmKNGoBVcUnpCo
 coxEKreBNP1BeUnQy9Ui71LUBmmPSpE/qMQ3KVTAm/UjkwQTGlIpYGQ2Q716otn3dbL1
 kGBfbcAip+7otMXRUMA4MTmOBD5pUDtM+C+C0Kztllrqt303TORyzUiULVFrOpIeF9hX
 C4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770634797; x=1771239597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AW7iR7ezhxl1MeK+z7eQZkFK4/l3uvF1vjXEXQ50QD0=;
 b=lYkL5/IM2a7nqbV0vNY3H/MqckGXXFwVIlhhXF7m+GQ8tP08A7ZkZCUKsoZTReQeMC
 w0vAcCMM7mz7hI72iS/mad9PlDHJKzWAkFD0W/jFmncmhRXZvfn77uaNW1Tu4XnX0q/q
 edXJ5yLiCd7taiwKIR+fsFCkhfoxf1MjG5RBb7R3pmCAJPtWPK0dy+E3jMSySEClqFfA
 LuWzI8TkwVWFL9uDE+k1BGkxjiKdqmGzDIdF1pQ2oR//w5CQKPc7/Yj6SN2AHsa/V1Z4
 o+toAb9Lr+p1Ez2vVYo3tnUq/+k/QoZBqPzFjacU/6hkUUIECW72aDcjJwiB7azfVrGq
 TAWw==
X-Gm-Message-State: AOJu0Yxelk+thi91fct5Mcf8qmModYFAP8N7WtNsYgUPr5YxBN7NL4V4
 Hi6apSglW3UYhnR2OZ66rqLHNPIkdrgnLOQADAR0Aa8QEhP17NzQ3HXzBmTqhVlmywCVRWdAyAo
 QRU7UKeFb3LyaJiaPebs689KG50h+fUD0OX5sLqhIzQ==
X-Gm-Gg: AZuq6aLv5hHahEpmiXoeAK1qYSoxQkpiHna3BfjKGhcGJMigteZdExRdo1LkKyARnEr
 paNcxsEwn7SYocSAOnxeNoy+XkFT2a8QRRl+rxqfcg8hjLidZnmR1k7XLz3R1JWTmk2aIkHPsFO
 nCL24bb+xJdAtdbtAEVBes/D2/lbNQmn+2udCYdUhdXqpFRGHR6LU9/5dJhvStuLk/SFOEg25jc
 xaOunoqTWzKTbyokkOTWScsngUSMvnYGJ574hhtL3G1xfWE4/RjQmvXoWDscAU2aVuMp2BMhslA
 DDDJ0uUgaNKLPB1XRgECz8Iyj+U+SiCObhoYDKM3PZnqIu9EHemuRJ4=
X-Received: by 2002:a05:690c:6501:b0:793:a3c9:795d with SMTP id
 00721157ae682-7952ab71be9mr92621747b3.59.1770634797095; Mon, 09 Feb 2026
 02:59:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770470220.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1770470220.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Feb 2026 10:59:45 +0000
X-Gm-Features: AZwV_Qh5dU2v0zxmuy-5KOzCZZha06hlo7A_jyXEQbsmjBqoIl-WtyY2-OM5olY
Message-ID: <CAFEAcA_6Q8sgHrjqHDZOiJ29wnai1vbvVO2iNgFMx31EzWvUtw@mail.gmail.com>
Subject: Re: [PULL 0/1] 9p queue 2026-02-07
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Andrey Erokhin <language.lawyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Sat, 7 Feb 2026 at 13:23, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit cd5a79dc98e3087e7658e643bdbbb0baec77ac8a:
>
>   Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-02-05 13:54:50 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20260207
>
> for you to fetch changes up to 22296f2db9f17f9954f85de9e99b09498936eb51:
>
>   9pfs: local: read native symlinks when security-model=mapped (2026-02-07 13:38:56 +0100)
>
> ----------------------------------------------------------------
> 9pfs changes:
>
> * security-model=mapped: add fallback for reading native symlink
>   (if no mapped symlink present).
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

