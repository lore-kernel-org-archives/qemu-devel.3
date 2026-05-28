Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B515CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 10:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSYCr-0000in-Da; Thu, 28 May 2026 06:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSYCo-0000hw-Mu
 for qemu-devel@nongnu.org; Thu, 28 May 2026 06:43:14 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSYCn-0002YZ-7z
 for qemu-devel@nongnu.org; Thu, 28 May 2026 06:43:14 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-660463977b1so217117d50.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 03:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779964992; cv=none;
 d=google.com; s=arc-20240605;
 b=F4MNCMltPTpjpPNDvLGipg5uiI2/m5AHcnrjKQOb7Az8LUif9pceM0g2yu4GCanN9j
 Hvh8uRup9sbXdh4WcQmulFEQD+U3qdBMZOWYODmd5XLPEDYTk3aqdsTuYf7iGIqqdx9+
 YMfI8V9hC7oTIIpseNyXWaG0M1jLAKDEsR/hm85gRFXMDazVYr0/T/uiPvBiTP9gNrOU
 3A3kH/mHN7RV11lyLO6bQ4K1SHL8lQpe8tKZK99hgkNSa7tj6JvOhUroPF6g5oh3wQ7I
 KzKw0qiBbvWjdC/hOWXhiUhtETWq60hDauZ1QJsIfui57obM53Al1hTUXAxZy8JtVzCQ
 SniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=R79pWmIrYPLNpX84U9KNTDN750bg7O0id2R334C+kes=;
 fh=FWtyXIX1K30Gh1JIPWWinn1E8IuOwxOeZI6Shz32Tr4=;
 b=WCFqklzcG8eICSQ5Jj5EdTdBdZttHYSb1wYAxrFXmyZ+s0CbNH8kScqnqH22ITOPHc
 x4TuEE7qXbF+sy4wp9mosxG5eLgDm/4eORDaXwpOFvuQ9UMOB/rmxc2wIBlT8w0Uz599
 n0YQiPDqZyGE+O0s0gfdNVumqcLyryZMXfQAUcLxYF8GJ/Wxu3LE6c5PKwak+JrtXZlh
 DG3mj4SvNiCWaTltsDq6GBpza18BFnHxyu8TsTcBTBaLKQcBlRISlV4r87rxeBrCtQpA
 h+QM44Ra/cffhMM2KiKqXGJbyFjxfouESanD/4btIbtzoME36MNIcp88UerUf4w0OqjY
 Dlig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779964992; x=1780569792; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R79pWmIrYPLNpX84U9KNTDN750bg7O0id2R334C+kes=;
 b=zBtg519Fp96aF+lW/IaZy/Ico6siz5yvu+FAMQ/mO3SjzUQdfmlzaNOtoZIUwX0w9c
 TMq8ywLwjUzJDbw4o8B0gEhS0fPQQ5kENZexoYThu8VDMRqc8aWzxwpm+ZJB8QoWE+Xl
 mEaZTMwtDdC8luEj0Z2U4cHQj1I2S07nICzBqQC4GEEYsfps3hm7j0dvTGWzMP3OnuV3
 dDxT45GYs+rOW8XDKnaoBbBEA4LAzaxstLHY6NefaPixVYiWNTbSJWdTH3RXgiEGp1rh
 C9H9VCAB7kDonoKc8oZwpmg63P9ipqXHCJdUb48thafBLMHrQQtAPEqBkNp7/qgOZh5Q
 UJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964992; x=1780569792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R79pWmIrYPLNpX84U9KNTDN750bg7O0id2R334C+kes=;
 b=APTvbMDwC4vfssKk+fPX4jxiuzEIiL+3VgkjMOpfHaYPlGTYOOvwJQuyjWwKQie8Qk
 vNvojqk8DEB4nLtfE88RzPNYS2WwekCm4V0Sn0Vm1JPJHq54S8SMmL9d12mYRqk77nxK
 nzGPEwcG9KxKiC65gLBxZwz44BuWzZYtHsZ5mCeNqjlNknAYIHVCTO05Wobo/QqE8O0A
 Z3us9DXyEQaX0x3CWaamIS/6uKEwA5Fzt5LJ03GhLE6NC/4ZDviflj8rst1LvXHpJhGY
 8tPYjBblIZyYhDBoYeCeBfcRRMOXOW3fUdsN7S+ND5tZtHorJYgxLIetMDMTHcSbKEvc
 4adQ==
X-Gm-Message-State: AOJu0YwWv4FHccE1E4GUYLaAeg8QSb5w+sirZnr2tIl5OZ9oUcQ13rNs
 r8P6jG/WiP3T+7Eo4uqd8Qt18F9Jxls0HnYBD8dOWfL+jQz1Hx9ppBwZ+HXqjeVuBrt0soV7TlB
 3tqyMsSaY/+Cp3ESRCu00CQC1AOTsttxGyhKKxYj4PpkUPxF595HX
X-Gm-Gg: Acq92OFLpLyMUDkqnM08R5wOg6+eGkG/q8O9iWiLf7jeY5zy6AJ8fV836WE3coJMM4R
 gtyXTSlAALdgMsfbiIYXq7lznI3Rma41puYHwfIYgR+48H6LuTg0wJC//smkB0c0VO0QYscZWcb
 2YJhTzBqRM5+4SpuUFgFfeMclNxS0SL7tD3J5RUd7j2C5GtXIeeUTNRtK/e7OijPLgfT3z2a8RL
 24LPDsaVYJLLsQcbO01+Rg2xo92uapzmzeFbWWgxjV39L7KAxQOB18+XxFblWYU/x0eAnv57K1R
 mh9mbYUDSZ02N5H22k8aT6lDKZc4VfFufkHb9VA+kuFq4OEUtjVJ8PFclBHt0+d4in4+HSWeldc
 v1Q==
X-Received: by 2002:a05:690e:4850:b0:651:cf77:f7cd with SMTP id
 956f58d0204a3-65ec963f9ffmr18022336d50.13.1779964991919; Thu, 28 May 2026
 03:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
 <20260518-pr-pacbti-v1-3-8932a885b03d@foss.st.com>
In-Reply-To: <20260518-pr-pacbti-v1-3-8932a885b03d@foss.st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 11:43:00 +0100
X-Gm-Features: AVHnY4JrApKQM4DjaDe_jXjzmka--d6osEi_jWFFlp8u8paJv5terBco9pn7m3M
Message-ID: <CAFEAcA-PByvCLEKJGOxi31YCiDqcTRYOG1X1hQWBj8AXNWeTAA@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/arm: implement v8.1-m PAC support
To: =?UTF-8?Q?Torbj=C3=B6rn_SVENSSON?= <torbjorn.svensson@foss.st.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Mon, 18 May 2026 at 17:16, Torbj=C3=B6rn SVENSSON
<torbjorn.svensson@foss.st.com> wrote:
>
> The algorithm used for hashing is a simple XOR between the pointer
> and the modifier using the "implementation defined" scheme.
>
> Signed-off-by: Torbj=C3=B6rn SVENSSON <torbjorn.svensson@foss.st.com>
> ---
>  target/arm/cpu-features.h  |  6 +++
>  target/arm/internals.h     |  2 +
>  target/arm/tcg/cpu-v7m.c   |  2 +-
>  target/arm/tcg/m_helper.c  | 17 ++++++++
>  target/arm/tcg/translate.c | 98 ++++++++++++++++++++++++++++++++++++++++=
------
>  5 files changed, 113 insertions(+), 12 deletions(-)
>

>  static bool trans_PAC(DisasContext *s, arg_empty *a)
>  {
> +    arg_rrr arg;
> +
>      if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
>          return false;
>      }
>
> -    /* Handle as if PACBTI is disabled. */
> -    return true;
> +    arg.rd =3D 0xc; /* R12 */
> +    arg.rn =3D 0xe; /* LR */
> +    arg.rm =3D 0xd; /* SP */

Generally it's better to do this kind of thing in the decode
file rather than the trans function, so that this function
get s passed an arg_rrr with the right values filled in
rather than having to synthesize them.

> +    return op_pacg(s, &arg);
>  }

thanks
-- PMM

