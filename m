Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB96CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 12:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSaHY-0008Gy-5Q; Thu, 28 May 2026 08:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSaHS-0008Fs-PA
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:56:10 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSaHO-00080a-VE
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:56:09 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-660390acd71so943545d50.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779972964; cv=none;
 d=google.com; s=arc-20240605;
 b=a7sgAARjYkl56NeTaxqi9UrK9QZHWq4KnbnBXM5hKGruXfNFjeCFLQ3iZnXGc2aoyB
 hHxoVmlGp0JWm/UQJnDgIXlriCzi89gP87byzHhznXK+9VjHMtnvqSB9NhoqaKKkQoJY
 ho7u7nuti8aikTHb4w7XQok7YZQ8buOejVmo5PWq+OM4NE3glq0FsWgOaHiYHka+PYLw
 PB4aihTiTcAxO8jc4W7oz9hHexudlgaVvd9Mbk9i+jYTVKxdy/tla36/nxKQpZFHWekj
 ae5b9uZYUEWzU75kisHSEGebOweDpr12kCViT+WF1W0H5kpZxZ8KXO3xWmIWTptpEEpA
 5S0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+5yjlEgM1kw2CqWiW/w+YsADSYuG4xsPIjdO5G70lcI=;
 fh=uCmUPCW8pkfAYUb2TNqBA1N8JsXLaq44DlF1L+QbvNc=;
 b=OUXWqObOVJ2mydptchDlpujrsLDDSfHI0IGls327FkulndyvEEOQH5/fvdeM7jYqKD
 zhmz5fCvSnE6Wc3QVtEmwp5anrXu1SgAbvh0hB19MZ5YIZXJ4QO95S/StRFKAK8ISmcL
 LbwA7wZ76FmGbC2EPwroP5zDO5t/Ws16qafvbjC1G2yD5KQe5UIqWobnlxJArrPbL9U8
 5uUFcvqX987xF2zEcaj9Hu1sFF1+S1dz6Onb98ZUy0P/KnriSHNXc9eHWZfoaKM1v4PL
 Qj78/z4wilXZn+l4F1A9+KFM2L6cHwFA+/WcXikN3m7JakCUHQWo7mkjiBhs/NYWrM0Z
 SzCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779972964; x=1780577764; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5yjlEgM1kw2CqWiW/w+YsADSYuG4xsPIjdO5G70lcI=;
 b=f7tWuw0vqhS6Y3x0JKll8xttwP0Fneox+nMUbvz/LYbPdbzI1MLVbWB2Cw1YaY0A14
 WzmyRZrqrtMpLYRHXgJ0JT5HepLeVBnOuJJ0NSTnl5A1QlocXEo7gc/yQWCLQKSY1ezM
 T9pW6G/so78RuhRQlIk5dwttb0ZbGwvyN/b50Qv200+s0Q9EoYKD+UyxAYCQTyd1uk11
 QOAV7h2NitqrH52BlJ2tVHbJrSb0TfNqwh8txmLyR2HZ+AtkdVlzzPmmieRFTqlKq/UQ
 ersGodsllx69PZuPqyTI1WYGh9yYoEXZwmZq9HZiGp6R66sM0/PhvhiXQZy9nsbu6K5X
 CCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779972964; x=1780577764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+5yjlEgM1kw2CqWiW/w+YsADSYuG4xsPIjdO5G70lcI=;
 b=MvNS3j0m3THp/3btkxF5f2iYjZxKZX+WrYDygXLFajkY4Y64HXU0lpQ9rrSWNcfJOt
 p6IE6A5QzWXZXTDUyhvGyDrFf+KbhJW4KlFC1kN0c1psnwZ43qgCdHOfZIn/jZG/lux5
 ldGBl9aBDzodJbAJWtzz8DUo9RAwjafM3mLjTnQg2YpDyz5ET9sZGpPe0Jfy6lqFddv5
 nJeZ1iLyNPl0fRabh4ntntnPGgesKQipFIEvw+5dWMa8L1fzsclkazTsZJDWTluqEqkW
 QyYxuAz23GNLx9bs1BwbUaeZ8KqtqkRE1fhspzPqyTmZnyQnGBFqrHC2sKCeFyaBRgdU
 rVNA==
X-Gm-Message-State: AOJu0Yz6e+36MexcoY0bJLMkrOrgugL+UpbwgmshLQQxP486mIIEWWJb
 +1dpw3oBvm/QZaOcXCA6rZHUWM9UP2wI1qm2Ur6m/kgIM0RYiqE+auWWBRCm+RVhHHWy+wu6Sbh
 rTtiSYSJB7Qnz15bR7+kYaKaCaBZDztlmkbD1FhZ2bw==
X-Gm-Gg: Acq92OEHkz/vF16M1aaV35pAY/lwGueL6cq/X1b0d+AX7U9hb8+n331VrhX26fUSPgr
 i5VXQKG8JpqtsRbmThzC7wvH+S28vHblKzdJoacDY8hub0egvFH41/O2VPp9UGNYNgXY7vSHwnb
 Op7ZtHzeucDNwTI7/QlgkUrB29BseOdEIgTCs11VI/k8F9aKxBz0mRBOWcFwzDkOB9DoDeX+6ng
 mt/WGl8T0RNL2S+003aWEIG9/cqnQDrOEwvpU1mpuXa0wrdlHODczIHU5vtmrrCt3NAz6+E74px
 65dm8bJvYHXmD9pVM9vNfGHLKgEIScnE8p13t9dcCz+t+5Tz63ENPMM4j9jlSwWtZDoQCdWVAQj
 R+f+QzoxFclT5
X-Received: by 2002:a05:690e:1905:b0:65e:1cab:c245 with SMTP id
 956f58d0204a3-66044a2bb05mr838417d50.4.1779972963907; Thu, 28 May 2026
 05:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
 <20260518073401.11279-7-corvin.koehne@gmail.com>
In-Reply-To: <20260518073401.11279-7-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 13:55:52 +0100
X-Gm-Features: AVHnY4Jkhz-x12OW3l2kTK4Rewu23FBHsdOw3HZOqpuj8D8Xdgj_OJIzavx74Jo
Message-ID: <CAFEAcA85HGU2zw95oyVL9m1iYnFXs9WwTH-k5hvXX=KLTd9a5g@mail.gmail.com>
Subject: Re: [PATCH v7 06/16] hw/misc: Add dummy ZYNQ DDR controller
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Mon, 18 May 2026 at 08:34, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> A dummy DDR controller for ZYNQ has been added. While all registers are p=
resent,
> not all are functional. Read and write access is validated, and the user =
mode
> can be set. This provides a basic DDR controller initialization, preventi=
ng
> system hangs due to endless polling or similar issues.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

