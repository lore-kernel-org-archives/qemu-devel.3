Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248AF106ACCD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ktK-0004ei-4z; Thu, 12 Mar 2026 14:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0ktI-0004ca-07
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:36:12 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0ktE-0004FT-2g
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:36:10 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64acd19e1dfso1417040d50.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 11:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773340566; cv=none;
 d=google.com; s=arc-20240605;
 b=NappmVwAp+B5iws8H6J2w86wuKpyY5LzRzG+TheeTvAT15M9rN9orPJ1du/5IkX1SU
 22ZKOKv6tkcVNXKyCC6QcbI3vMZBTi3gmYGLHTYLQz7k3GjJ41IK1p6hBJffvkHK3enW
 pe396qTVNmiFNCnEVt9meqmzzqGoRFkK/QEnInZvfNzfYO5/NvbK2xDftfDDXrsEZ+nP
 PJV5HmcLovzJb1VE9LpnCW/CkBVzTBH+h92gq2yxrOeSsiOBydazyjjR22te3+uh8iyc
 CkVu8HHcaAAOER/KRalUieA/+OeHhaiYT0knZagpkDuPXg/wPD1IzbhjO2SCF2QF8AOd
 jaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yKFsz1n/SIi+yx9Jv+Ri/OlhRCdDhTR+xHfsPFWu16g=;
 fh=EzCqtT5E+bTTLv4rNAwVJ+2ChJBsIX5zYHpMVTT1IcQ=;
 b=k6Z+GtE0bMteEQnQzsf605cxtdgBw2bEWEXRVyGhesY5eu9dl/8HDIztr0nVwOaiYd
 tzLZXcVBg4vy9kpQrgDyKrUpj+3rILBLWvq7d4nmlKGHB0OiTcmIJuaqtIEW4Cvoe8xc
 uFzazmkMF0iS/fAtb9cj8DX+ai1TUBFIvMyTEefEt0BW4nvvV5bjZ9bOragI0Ummpq39
 oxAxLmew0QjAUoQIOj+9lta/5NW83jAf9rWbKhpQAzW6WnQCD911+jCjdQryuvvaK7Mm
 B9Rv2QS+WAA+Xoms56Id7Bak1KWvAcjhhTAMxjuA2IfjO+5oUVNU8SHUnF/ZzIKFqsjf
 czJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773340566; x=1773945366; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKFsz1n/SIi+yx9Jv+Ri/OlhRCdDhTR+xHfsPFWu16g=;
 b=yBpCkhCPc74PgnwpwROzUJj5DSZxjEkYW67Hrpa/SUr2dlDyYGZXaBlgV8zguUzftm
 EGsK0hgsUKgzVJeC8bG/k1NKiK/18bqjV0JLeiQEx5ciloXSovmp0ngZo70EFHOcIZU0
 ExPFO6KF6WKEYJeJF2gjWUQaCd4+o57SHdrzO0kVIKWODofcoBS/b5jS6n0i2B5IhkV0
 yOovF253lKn0cf7/nCeRnAc+mpg4+/NrMTebhZM16ASrtRb0eE4JeTMkRgi3BJIsUKw1
 FdZgjiEMTYAcC7uxBvORHeo6/4BW2HKadYoE83vwavrX4Bxs+htOHCR/y4wChA0fw3HD
 /9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773340566; x=1773945366;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yKFsz1n/SIi+yx9Jv+Ri/OlhRCdDhTR+xHfsPFWu16g=;
 b=ho9sd8ayOLdgp8s0YbmojTt5sLeF/6jwkdnWJ4x2i92J4kaigggTKRA3fH5jQEN5Ci
 hdlDcaVcv+a2yhpFHobNUMtyo5YL0cnN6iGpcD3dIU/e1Q9sU1F3jSgZiuS8cMpfmI8H
 FgMAZTbrkWg9dFuH83q8wE5jd5Kzgj7Ob/tbjsHQkz1oE92uJMFRl3MAhRnR+HIfivIV
 Fl5E1vlrm/qtcZCiAe4q8/xkAw1nSV8AJVMNwHxekl1Gf/XKSz/Mizw1WPz1waZU8Glc
 k9iWBUFy31PMLYsnTzzJ4JahLnpypVkha3zlYONk7CJAO88CpSOEOEaCGK3DpUD0fN+K
 rWnw==
X-Gm-Message-State: AOJu0Yw3QNiumJk4EytdsuyLZsfXeQVJcGsEyqnyuXqiiraInPVw4HiN
 SFaJVIaHP9N46Kt1s0KenFEzdlPm6jJu3No5GiTIlAs7xH8tVmMk9qHxWXaF/lmdEow/4L5/i63
 ahveBwIawb2hwXyXTZnh+uw/jPcbd11B7SugJjJEhkA==
X-Gm-Gg: ATEYQzw+XLW03qttgTVlYBs+MT43GQqabfqvwqpoLFk+zCKhVmob+tvRd/KCk5j/QMG
 dIFZEJvULwwEU8yclr+xqGqU3wnuvAjNNZS9c72WNh13DquRKQbWS4vLUC/++fHpgYFqNpZP3ik
 gwhpVN+8B6Hf5ZhDG1kYJo72GwT9CKW8deH7KWrJdSMcbGS+AB1lwf6XazP6QyFU/7fhGpdMhwA
 FF/GeLAf4l7moBMgvKkMb3z1X6F/fb3hFdK3dxIo9ELmKnxmB3Tj9Axw9Re0RjGrhAVMb/sUj3W
 2E/TccyskpyHBYA/cxgPhLAztpZQeEb8N7hx/OwpOhxwh+eRRKXoNRvkjyEUVtuOvM4=
X-Received: by 2002:a53:accd:0:20b0:64c:aa3d:f3c3 with SMTP id
 956f58d0204a3-64e62f689d0mr558331d50.33.1773340565634; Thu, 12 Mar 2026
 11:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
In-Reply-To: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 18:35:52 +0000
X-Gm-Features: AaiRm51Jy3WTTuDkUM9bYo0WAMy9KRRgHUd2PaxTctTSHrP2-M_7rRYE-zhpMTA
Message-ID: <CAFEAcA8DJW07LLpBM_sfeKcCDgJUQcTN3n+6b75eTJXSpcF_Ow@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] semihosting/uaccess: Swap bytes based on
 runtime-configurable endianness
To: =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
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

On Wed, 11 Mar 2026 at 16:28, Martin Kr=C3=B6ning
<martin.kroening@eonerc.rwth-aachen.de> wrote:
>
> The semihosting ABI [1] states:
> > Multi-byte values in memory must be formatted as pure little-endian or =
pure
> > big-endian to match the endianness mapping configuration of the process=
or.
>
> This series ensures that semihosting data is properly byte-swapped if
> the guest's CPU is currently in a different runtime-configurable
> endianness than the host's CPU. This is done by adding cpu_internal_tswap=
()
> functions and then using them in semihosting/uaccess.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3258
> Buglink: https://github.com/taiki-e/semihosting/issues/18
>
> [1]: https://github.com/ARM-software/abi-aa/blob/2025Q1/semihosting/semih=
osting.rst#the-semihosting-interface
>
> Signed-off-by: Martin Kr=C3=B6ning <martin.kroening@eonerc.rwth-aachen.de=
>

Applied to target-arm.next, thanks.

-- PMM

