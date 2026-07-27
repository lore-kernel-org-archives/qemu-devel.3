Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D5DC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 10:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woIhq-0006wd-IZ; Mon, 27 Jul 2026 06:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woIhm-0006wE-V8
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 06:37:07 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woIhl-0001VB-7d
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 06:37:06 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-668c1b780e5so2848786d50.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 03:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785148624; cv=none;
 d=google.com; s=arc-20260327;
 b=GWfmKLxIo/rZoqZa4+Qj6p68SKYTKWQyfNCVq5UtcJVyUY4CPa/Ci+59ctcrtNVfuO
 b2tk1cZ8lfB0q9+NifF5/AETMqm4Ao87MC7euKd3jNfSoH89UL2gBxHLZ/j7UTDtG2bG
 opEnHPDbOleyBYuW0BbBJFD6FTJ5G20vF5VxwTMwVYmvHZIJ6sAB1/ifiC/+NHWK1HgF
 ZEFfR3Tga79V826OrQX3dXVcYZd+R0RDMCf7pCqnWYEFFaIDIsUiAn1A8F1Ro6aTtpK8
 LshMCbv7w6hSG5cjvoKoU4y5gnHf7q0ECa5BGo+C7fOnZmCFPlKikzDT5UgoqieMHXN/
 5ELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MVK/6Qs3WucjtWhC9T0E1uzvDLONH17WPfJ06O/h0KM=;
 fh=AxrTunfAAC7+Gk14Yr2x4BmNQWlSksoAx60lqQjc7uw=;
 b=RGi0b5S/aBWDVe4cE2JMxxbqCyOCSwj1jsipiF/KG0JRpbvF6OB0WCt9JLvOZMU0RH
 +ZPnmgp40yo6ekp5+aPfO2HxukPW+45bPdm7tkqvQaaiSTKmYeUyxVef9mrUYNOKcZPK
 Z2vS2Pa/hG6pyhJgCuck6uH1FKtKgauDJFVWgp4MuH/kEL5Cobd8o2jPxwkUF/E9YjEJ
 dSn7Q+iR54Ok7UZRH7asga+glpbCyGZK7wySHB2WAOYek2x5UCTyGshCYoo+RC2CaHH4
 APrMQmsntSa2xVB2XfGrxMxdfs2PH7MryYO2rFCbP+qAkwElGsjAApOmTbZY2FWBZr1d
 YgAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785148624; x=1785753424; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MVK/6Qs3WucjtWhC9T0E1uzvDLONH17WPfJ06O/h0KM=;
 b=a5R/q/CzT14OcycAuy5snqN3NDwWXLf560y8Eb8LQakBycK60LjviNkGbPL38DSuEN
 Akh2oOHtqTcqzD441/IZ53/VRSzTTMAMcXlgwoN1t2TRt/oYGH9haj1U0jeNolUOkXzX
 PqEb871L0nbvFKL0Cs2MXJxoDVgivdlP+6VpRTwgnY8bUECXZyWC8YShZkgPo6RNMQDE
 2M34mGAQUCwMof2msr1o7Xxij19P8bs8y5iqcB5+AN7hQGpfrdg3ReyykNrvKqhpMzZs
 O7VkTla72/R0hx05WfNgzBxnDcaUE8/kub7vcIKbJWHtYR/FkwWHC/ALR/YoHu+GPddk
 PH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785148624; x=1785753424;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MVK/6Qs3WucjtWhC9T0E1uzvDLONH17WPfJ06O/h0KM=;
 b=QdB9ZdXq41EcCRa/qlqVsIJC0bhy4oWwAEM9Wsict886EIKEqq8z2BuZr4IH2SUNZu
 M2MJobqwRxjUIqvdATRlF8KnxEFLiHiKY7a3viZZcGzJEc+9l4u4t94SNqvEC7NJ1Z8x
 q3S5VLvaLG9CmMJjfmgAULPkHSq2C1bOp57oy7pBxMqrBr415JGbe/x6q9EvQzCx4KMd
 gxFHfLDhhrjG4tt9R419VeVPnAR5212Nf84CtHiQZKPNrPlHXHkRpUeomZbQCKWmmK/b
 GYVpWpLKKUEHMVmId+Z41RdP0Bc0uRTmMnyQASmQ2dMYhBVPBQypemkzTyvMf3WjZCW6
 MPFg==
X-Gm-Message-State: AOJu0YxiGZZS+oHQveMA0yFNzETdvChtsCLwyi5KIUERgjKQbfZAUvdz
 TQuI6ZKn0d0QPeuZcDxywwQfLJZhatNyZiSB2r4lGVH23UvtW7/WuKWMgTVyHE6Ca71jK+fKJTa
 yBFWUhC+vVZpvzrhBiVbpkrpuC2OTeW6GjQXu/P2EiA==
X-Gm-Gg: AR+sD11YrqU9fAPXzTGLlL6FwnLlALejZ/JbsoOqG/6ppTE5gWZiXem3oW3rXmknjzv
 bqCLMNLzqrHT7NJ5HxPZSfM6SxrzYBVJnYRgbHkoomDdVWJTUsXY4ip9x4xD2Lyjuv/7Bkp60tY
 /nWjMwNNLSzfJQiyrjXZ+6zbRZnqxmmnrGG0t+r+J0FP/7qAjEu303CfIr0Qby+0XCYkm0EUKDU
 /8s9vgCLWM7FzWqz/DXEionRl6mX+m6+uN7mPhiIeyAUmt1k37MqNcaJnVrKRf3Q62z2vT9UtjD
 b9Tk3D3cL3jDWSBS5VsgaLRWkI70r1fr90Yj5u8ug6xTbQ==
X-Received: by 2002:a05:690e:405:b0:668:9230:e268 with SMTP id
 956f58d0204a3-668c7a2c2fdmr1514233d50.47.1785148623703; Mon, 27 Jul 2026
 03:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-fix-sign-extended-32-bit-addresses-v2-0-6d6a01efed8a@maquefel.me>
 <20260727-fix-sign-extended-32-bit-addresses-v2-1-6d6a01efed8a@maquefel.me>
In-Reply-To: <20260727-fix-sign-extended-32-bit-addresses-v2-1-6d6a01efed8a@maquefel.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 11:36:52 +0100
X-Gm-Features: AUfX_myW7wby0cgcv0HlqbaHhP7UiCTbPIlq3_FjXEgK9_33QZjXluxOT0WyIl4
Message-ID: <CAFEAcA-hKu_C9MULJ=8_jktDgujveQRBkGXvgnczPNrTWZfeQA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_1=2F2=5D_semihosting=2Farm=2Dcompat=2Dsemi=3A_Fix_?=
 =?UTF-8?Q?auto=E2=80=91strlen_detection_for_32=E2=80=91bit_targets?=
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Mon, 27 Jul 2026 at 08:46, Nikita Shubin <nikita.shubin@maquefel.me> wro=
te:
>
> The switch from target_ulong to uint64_t broke the mechanism of passing -=
1
> (0xffffffff) in arg2 to signal validate_strlen() to compute the string
> length automatically. For 32=E2=80=91bit semihosting, detect when arg2 is
> 0xffffffff and replace it with 0xffffffffffffffff. This causes an overflo=
w
> to zero, restoring the original behavior of automatic length calculation.

Why do you think this is a valid thing for the guest to do? The change
in this patch is to the SYS_OPEN semihosting call. The spec for that is her=
e:
https://github.com/ARM-software/abi-aa/blob/main/semihosting/semihosting.rs=
t#612sys_open-0x01

arg2 is the 3rd word in the argument block, which is documented as:

# An integer that gives the length of the string pointed to by field 1.
# The length does not include the terminating null character that must
be present.

There's nothing there about -1 being a valid value.

I think this is a bug introduced in commit 5b3f39cb04: it
added "allow length parameter to be 0" to a helper function
because presumably we need that in some cases where the semihosting
ABI passes a pointer to a string without a length. But because it
doesn't separate out "length is 0 because ABI doesn't provide one"
from "length is provided by guest", that incorrectly allowed the
guest to not specify a valid length and QEMU to accept it.

thanks
-- PMM

