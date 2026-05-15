Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB4CCD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 08:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNnWH-0006s1-G2; Fri, 15 May 2026 04:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnWC-0006qP-S3
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:03:37 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnWB-0001K3-Aj
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:03:36 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c7a459105so1524539d50.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 01:03:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778832214; cv=none;
 d=google.com; s=arc-20240605;
 b=ZHvvvkcXK+Avz5skbCga7vgwDlIC8NOxmS5G4hQyYxRi97ct1QuM+KK11GrUXi+3ZK
 Ywe3Jb5AsK5q2yw38cht1GGY+uIUa8PUo6tdJAm1zPpy+FVpOxNj8pSZ4oYzmnNFh0EZ
 NOz+yy0iBjt6dRBstVcPcj45IdeTxTTwCTi47PFE9gsrbYkB0iB7A4q9FqBYlkBpWZnO
 SmnQHKStz4b4dH7yQtPN2aIGrDdWAD4B9brFavWJSchBy5I5tgA29YlII5LAXWQU0BwG
 ryWatcJx1HcdOgYhH/5SNfy6T5tRXyJczMWI6+GDUxYLOrEbFWOupRY9ASOMtJPXB645
 uIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SCOyY7KDaMTThO3yLBJAEUbRwbm8BDSIF39YqyrR2Qo=;
 fh=kvOOaizNZldvZrGcUk8ta2JEDnV4vPRBdkt8TLZf/QY=;
 b=eQsrdLkCHrt4vcbHiPXebIx/KD8ocn0GRhbgrsX8Cs8UG/M6lubpZ1mY6vp6zFibFx
 3YM8HJSZv76zNAdKglLkyKp4ZaaWlLebIYtqxeDzs6p0BuqH3jNcQjHx1HDNNpfM9nBO
 RGLjfM0M5jidG8RJDLjDPX1JlErUpnkp/ztG5QjJtFDd2KfG5R7nf/YnVJR3MArlF8fn
 ZbxRRFnFBGBssSAcmKEd0mlFiFXbSiBF6hx8ixmjYQmK12lMSgUKc1W/Amz0pXoKJRrs
 vjvuOgIldOps/Wksn0osMFlEFAPK9ZnGT+ecvhbAOzdTM9ivT6e1GZipZJ1UVDfpTJ4j
 gL3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778832214; x=1779437014; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCOyY7KDaMTThO3yLBJAEUbRwbm8BDSIF39YqyrR2Qo=;
 b=OD7QfoFkqwYTZx4cumwTTgeZ4aswjC7+3arD4OYkNk3FnUG5HRH8HgRck0g5iY8Mud
 XJz5JAiDQ1tRLPpXTPmICofQWcYjU+1Nvs/st75Ph/SyLucSuy7TAz3bR++ox0A4iC7a
 UMlgfUNIPgNQg529PV2kaQJIJ9fxI+nEN6nTJkSLSmc1UEzJEEsu3eUpMQgnKjiKPzk5
 jLA6r8hQuuTrlNrUZEB1Z7G/KELWpk0uJP80I/KewdBIRPNadK6IISZRyFp9/LH0cOR2
 S0e7NRIUuXeydJnFHUyPAOunNcBmYjMHvgOxkAcr/KeL492oJ7VTXz5zFXFtAdAWkG5Z
 Ghxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778832214; x=1779437014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SCOyY7KDaMTThO3yLBJAEUbRwbm8BDSIF39YqyrR2Qo=;
 b=OqzP4RlwAXctl1txoWD0tkDlwY6D2K3SD2OLYC6PGhrYRDnFbmbtQ5eQRioThcLy/l
 mjpLujmpBVdJtAgXDs3dePRBsuZbRXT0H+q3JKcZuyqA8GD42g4dUj2/8XUZ9z8pqONM
 J4CTcFxlSaCfnTCdMKhlnRDy+7hkCnxNl+NOvKu2EP+ALns57LCWujOKrsOex3Vx+ySz
 yavPVLih1kHSZAnRgxcNwnhHTpFZBMavBIxIdnaB98aoF8PyBX1LHvH7tYW5bj8O1ebi
 7Rc+japQ1K6yNZfCdR5I+HT+Jd+6+24DsuVxRc055wxPqRvApo2Z6KorFMOKTvLa3AMd
 Zdtw==
X-Gm-Message-State: AOJu0YzRtJdJbpJtchdS4XmDzQEYwS5Y9siSJJwvhvLg42/libZsMmFk
 kcbu958Lc6M9zLXso4xKS2myY2c8pAA29pMMVeUNGSLHpBo3f6SJGgIwifWFfdOlhS7jtqklEwy
 5wZscFlKsHqPRNyzvowdelxcX5cWdMrVLbgtcW4XPSA==
X-Gm-Gg: Acq92OEfbM+t259/ZHHjnkCKyezHvRP1UZhWebm8ZMZimjcnYbg6wrXlHxyuAZ8tGnA
 OK2vIEM1WgVYSMXeSjdpBcXkJK/WrkC7pmeO3NKhGghUqhevpb1Xz5n63F49N7Z+3LCvibbe9A9
 t4UO0ELiIXKIJs2ty2U6ZklY5Uf/Lsuj+U/CeJQ0m9q51VAGtcxkaoQAGQb7WTZwzAcQmhDrvAi
 iBsS/+V0vbQmsGrlJlZZSkEgkizZCWMN4r/OXhU2vbTW00pEY20ezbGWJT/JMlQBREScX+X7AoZ
 O02VOwYyO2Vr/m2mXYxt66g7UjdstiGpBzDZfLP2a1bJjxRgCSxuOV00fRyZjpHzGtU=
X-Received: by 2002:a05:690e:150e:b0:65c:6220:5fd0 with SMTP id
 956f58d0204a3-65e214cf2f5mr2180435d50.8.1778832214063; Fri, 15 May 2026
 01:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
In-Reply-To: <20260513105517.146706-1-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 09:03:21 +0100
X-Gm-Features: AVHnY4IJGLtaKUKAAqETlMmv1N4v9lLsbYwbkqdBmbc9eYz-wD_Pxb5rfpoCaxg
Message-ID: <CAFEAcA8KnmAONjnrzYRjeC5sFO+QLhgjgUx0n1apVk7CirzSxw@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] hw/arm: add Beckhoff CX7200 board
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 13 May 2026 at 11:55, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
>
> Hi,
>
> Beckhoff has build a board, called CX7200, based on the Xilinx Zynq A9
> platform. This commit series adds the Beckhoff CX7200 as new board varian=
t to
> QEMU.
>
> The emulation is able to successfully boot an CX7200 image. The image inc=
ludes
> some self tests executed on every boot. Only the cache self test fails du=
e to
> QEMU emulating the cache as always being coherent. The self tests include=
 f.e.:

I reviewed some of these patches in v5, and they haven't changed
in v6, but you haven't carried across the Reviewed-by tags.
Could you make sure you do that for any further respins, please?
it makes it easier to see what still needs to be reviewed and what's new.

For this version, I'll reply with the tags for the relevant patches.

thanks
-- PMM

