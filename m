Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939F6EC1EA7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 11:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnxv5-0000Mp-Fc; Thu, 05 Feb 2026 06:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnxv3-0000L9-GE
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:53:09 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnxv0-000393-RT
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:53:09 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-793fdbb8d3aso7751337b3.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 03:53:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770292385; cv=none;
 d=google.com; s=arc-20240605;
 b=FFtII4HCUjdrJh8Y8V+1SqRwekRUxYwsIso5rI7afaCSkvJdVeS19t38RnoqCGCOmg
 j9pTzuk2QyN68vt6PrLEOTpakkn0bpYtZQwfDR3WNeyuA9sLcVDah7g3jUJCAg8GLOpz
 6hSbyD+LSST8fvz4I23J+oSIVVh4nQgtfcwXRi2HRKulsDQT5/msxFxqRJrraLJwuWAs
 tCfPhk3H4duV5b15BWyT21zsvCLPuJiQ4umwr5n//NGP31F4nSAu0dj6YO7XksbdHG2A
 RV4r6mBlga2zwA/MzMPu1O1iPz+b1IeleQMwRBbXY+n0WaRoeF4V3lnSrypBWvhFXTLv
 m4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oaL8q7aoEKpl6+aTJa8/maUr715vd8ePhDvN3aomsDY=;
 fh=yo0HvKAv7lbK7xJWl7e7//44KX0nETgtKineO8CFFiA=;
 b=VwmLVFi7waD+1AwgDDZ6tFv7KA9s9GjI5R0Y+uN9voimOCST+0tDuKiRQKTaQp/oR1
 Dbz1o3mEAFBZgx10x7mYci7m3zb7l28U5vmCMdlHjOHxxHLOo7NwZIUGIIfnhz9TDSih
 Fj5XyEHgmP8wMPXlu30Z35OXDUzoHn8I6qAP91T01xLw5Nw59sXf+GLzlZ80bTArXlkE
 sJypVv0fN8t/U6U0zpKkPDCDwE8XHjdwOAqMaQC/1vfeL95YoW8atlqPp8s3zh+vSbt6
 3C0SZGd/HZEb5O7aU2X7BEFtmch3D4n5tq3peJ1a77MiHwY2/P+nycwItpBpGRS/8UR/
 BlJQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770292385; x=1770897185; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oaL8q7aoEKpl6+aTJa8/maUr715vd8ePhDvN3aomsDY=;
 b=aO2hhF6BKlGx25XK/E/5ru0Pzyu9biZv0n02AREihvgF1sGyo7lVvxS7zfWu2Fofii
 4c++/PSD3MCn2jT2azHaj6QrPi2+uPbLRHMAFjVoriuYZ3vzDpehSxEfE+qQQWPw8b9Q
 aFCGMzlxNYj5R9tXoOTTYSjKvL1GLq8oos+Nw1fxTQW1+yNWvj3l4GisLtQkybfpBLyv
 /AoC83Zz84I3GvsJMB1rd5mE654o+UmHeljMyRnPRHs0icwkMpyQBVkx7XDhABnxdi8S
 0nRMXXqa7Fj4pKTR0H8qwmuQieVYLxV80QT3KQHJF8zfWSuFkrYLRi8eWQgeD7LqMvha
 ansQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770292385; x=1770897185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oaL8q7aoEKpl6+aTJa8/maUr715vd8ePhDvN3aomsDY=;
 b=fp6JX2Pf5D4f5Ih7ehw0UI5BIlCs78WdfJfvCXDKxSiga30o0PH9/BRDP+fqpLbgBC
 XF+BuYtPCAYklN2CUxnM//Ckrh72D5YLwMvgelytH682eKzsITWWwSI7AvbNZHYjaB2X
 8zoUKw2Z8/avfgIa2TRqkCCn7zTnK8qEv2lHmzl+JAVkVh+NI1fcuvI23JEgRjMpl6Cg
 XB2Zozg4LWizkKxzV1sDpyVtjeAtLq5+SZCDzlb0Y7dxibxyi9Z2KQ2c/rijM/4OWHYi
 te88gQS3C4kJmtLaPovJz54XJuJfYVLfFM9Lqjv6n4Kw+vgPqQW20D9hDjcAG1/xZvSQ
 76kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2CnPeXXrQy3q+w2UtioHn7jds8kIUwU/qE0j3YOTLRpeiT2qOoAsxQIMlNixnXVBEjcaTQrup9EqM@nongnu.org
X-Gm-Message-State: AOJu0Yy4mcT7YbO6ze/tfmoYiawvl9OXKvVqC1eXfjCyaFCc8/lfuxRU
 u6+eTw01fgkU4EVdigOMvLy2geCDd6fik0CwRh1LgHphxZqWqwrbNUe06gqULy31sq6t721bPTK
 GysA5OGGLrD9GUfmSVpYq3mHhMdcmOJKMkJogIa52hA==
X-Gm-Gg: AZuq6aKQLadFVXLUFZ/AuQtK9Dz7Zzq2WR6EUdWPlO5+xEPceZQeEChZCMV1PRBHxea
 eidFC62nDN67b03Cjthl2ImgJ5HVUZSqyohpBbldaTtE3suI9j38pLtzET+Vyxh0ihpBn+hAucc
 c73UCEpjPNCk5w0FL1eggefW7Sa41c3xYG8XB0wfajGnE//UXa+l6weqo2D65Nb46ubA5mciI54
 3yIlFMWcaNj/4lxOcOX+DP5wl5N106GykrUpPPX1UDLCWYRpme1OHBbnjPWR/0rA6mlwQ==
X-Received: by 2002:a05:690c:ed6:b0:794:959e:c534 with SMTP id
 00721157ae682-794fe63b579mr60175087b3.3.1770292385272; Thu, 05 Feb 2026
 03:53:05 -0800 (PST)
MIME-Version: 1.0
References: <20260204133229.297061-1-cohuck@redhat.com>
In-Reply-To: <20260204133229.297061-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Feb 2026 11:52:54 +0000
X-Gm-Features: AZwV_Qgr7SIV9ctsC01ny2dLouZ2q79_H8IARKugnsUfSeSrEDGmdpp2E5Mnv0A
Message-ID: <CAFEAcA9SvgjUvwLb8VjOzyDNy_g0E30wpUKSN=ENfm3HXx_-SA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] arm: demuxed ID registers (CCSIDR_EL1)
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 4 Feb 2026 at 13:32, Cornelia Huck <cohuck@redhat.com> wrote:
> RFC because there are still some open questions:

> - There's a slight disagreement between the current code (providing 16
>   entries for CCSIDR_EL1) and the KVM code (providing (7 cache levels) *
>   (data/unified, instruction) = 14 entries.) With FEAT_MTE2, we might be
>   needing 7 more entries.

This is because architecturally the CCSELR_EL1 register is:
 bit 4 : TnD (tag-not-data)
 bits [3:1] : level
 bit 0 : InD (instruction-not-data)

but the 'level' field has 0b111 as Reserved, and KVM doesn't
(currently) handle the FEAT_MTE2 TnD bit, so from KVM's point
of view only 0..13 are valid values here.

The architecture says that if you set CSSELR_EL1 to an invalid
setting then reading CCSIDR_EL1 can be:
 * a NOP
 * UNDEF
 * return an UNKNOWN value

For TCG we opted to permit any indexes 0..15, so that we treat
the architecturally invalid 0b1110 and 0b1111 the same way as
we treat "you picked a level this particular CPU doesn't implement"
(and return a 0 from our cpu->cssidr[] array). Otherwise we would
have had to add an extra check for "and level isn't invalid".

TCG also doesn't do anything with the FEAT_MTE2 TnD bit: looks
like we missed that functionality when we added MTE2 emulation.
Setting TnD and InD at once isn't a valid combination, so we
could either extend our cpu->ccsidr[] array to 32 words (and
live with 8 of the extras being unused), or else add a new
8-word array for the MTE tag-cache ID values.

-- PMM

