Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA61FF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 19:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHngI-0004im-9g; Tue, 28 Apr 2026 15:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHngB-0004iT-S4
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 15:01:09 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHng2-0006XA-Dp
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 15:01:05 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-651cfaa21e6so193099d50.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 12:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777402855; cv=none;
 d=google.com; s=arc-20240605;
 b=AcnxAE09clUBPeiCvvbarXtOiqVAVaeLM2wddrmr5kAjVuPx/61DRc8NqA63h5Yvwd
 jfdFuvF5w7F5C5rLUv/6mRgDPD/qmWsi6PIMIvypV/Iie2n2H4+bUXtQdZ4Upb3zU+G5
 LBpdnggrdxwtejZA6XfBopkVfE+fdvIF+ESAZFTiBS1sTkRPUWU2dwPJbeQxNCr4Hh9F
 /t6aV+ZHbvW8YTc4tyemlA+DB8mjUdpCLd/+KTTDLhtVMbKGP60JCXvoFBqVH4PRqPyA
 oAUqTD3YH1Aham/ywTEiVTj5S+XoYdlSL3DTRWroviFWv/P6S6wrxPerbpFTJZbtoYd3
 5rxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E/f4+2wPB9K7NzxILsl4n9ZiimULVZSocryuyEJbKsw=;
 fh=qOMDdQD3PZ8f/VgylqOBa1xsbem5CHk24V1U3hkjJD4=;
 b=PkpDnfkKr8t8IYluAUn65vtgqx4pudMHvsCooywzAvBeGLeGyP7QanVLuvektUQVyk
 hY5WJC7RzEMWa794n922Katx04A/8ahdzRCd2QBhbq/LWKR9PYQYzpdXvMbQPwhZaf2H
 hZ2J5nESdsG+/Cqcg/DVdzX2DDIn972NODrgviTKLlJHMG+SnHcOpJxddrlMoDTpIorn
 KvpBboKNv+4JwU76eHe0RCK+/DSTCex2BS1pyVQNp3QwEr/x27DRnUjbXyqhGEbaLxfQ
 oq6vGRO0pi59s7OlyBjJaq3y+ykaaouf0oBT5E4Pf8KSZ/aKmcil1YmSM58CuYJHpzBr
 LIdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777402855; x=1778007655; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E/f4+2wPB9K7NzxILsl4n9ZiimULVZSocryuyEJbKsw=;
 b=zHgaSDQ5OvpERcgCryNS1O+HoMxVGgN723hOVwihKdOaKjLlsNiRKz0kDqYOq4KMpG
 1ifURxYmztbwAc7A7Yer1yucoI0fLANMyV5sZVIR4+Y+H/uebIgjz7x1xsuac0fyG39F
 ywU6EU7O9AdXo2EHASjDtzTAhYy0sfO26hZ2L8OGC1oqKPw6mpSEeQQJUK3nXDQXnVGV
 NYDRwpdceKUtxu3nx4W72aSatbhH0wx6KTl6fWK2r3t0VrYPaxrMzkngDlacYJIwsFbr
 ehXSHlH262r/CN+arQcl3m4IG1ujV7DghDvk6cfCYhr1yOFriE0q5kaGRyIx0Eswn5qC
 W6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777402855; x=1778007655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/f4+2wPB9K7NzxILsl4n9ZiimULVZSocryuyEJbKsw=;
 b=VA0fH+mHE1ID7VC9pcI7zu2JI/4Ov6H65SDLIBOon+fHJZwMvSq0VuJ2dxt+kE4UDp
 jtrt0aU7g8D5l6n6B0Ewiy/BV2LhnrwViK1/H1bbRwzUtq7xdTjSMU/juE9Imuiq6nYL
 pxErnCfSWn8PnIPSjFbZP6Mv4VntrwZlTFvV98WvsKGq9crRRCaKSi8cPnvs/KY0+hTp
 XqVQvHhso5ONLPW0/1I4kFDWIUa3DNdZAMsQlqS6+862DdgcP7o5IMmFrRSnwIIQLlPt
 Zr9nbRpVvgfaLbiQv5juMwwxm2kkGeRIZmC+sNsJHcdq+tzF2IPiXBbj96U9ADSl6Y0h
 ol7g==
X-Gm-Message-State: AOJu0Yz2UpzziRQ7+KyNQaaIJVKYMkmfYPIoO69+C5JTaqxM+GhQY2Ws
 iqJ3msZ2QrUswU4LTvQe5DH8VmzspqHeOR9oWsIO+8yQdIfM3E8xBYzsthGVYoyZtXOTaXqPdOe
 Cf49y0JpBDlpYIk68XtxVtF7k1h3xXJ4Vf9wK4rNQaw==
X-Gm-Gg: AeBDietRO5PGLJ8kfqvIo9eu5zY4FnseyPS0GIS7/2Bl7VLxNcP8vUpzIbxMBomQs7E
 9NEdW9NrPdRTTII8rRRByVCervegNH/cX45jITNfz6EVldypwl730vMWmSdU2uRwtOEwJap1O6X
 1I2UY4VRRrvryndeWrCbtCrquLHakefIG/o/UocU3xT8JhiRBbDUo6ZOAqeIGHujga2LWdsQQZ/
 O74fAu1aMT0D73q0IcG2Fkbyw+wjzYRFjMsFVqQgM5BTUTgF8357jAEnMLlRPBV26mfUyuqdAih
 wUjdX4iduuBgmnmrSJsY6nHHRF/lxJSvt7W7ED88Mr4jxkZOVQwJZEqIyhxwF2gwGwWFwtewupQ
 p2rkdC+R8jiS6
X-Received: by 2002:a05:690e:d57:b0:652:c12f:18cc with SMTP id
 956f58d0204a3-65bfe5ea1c8mr82657d50.29.1777402854634; Tue, 28 Apr 2026
 12:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260428172055.1525176-1-shorne@gmail.com>
In-Reply-To: <20260428172055.1525176-1-shorne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2026 20:00:42 +0100
X-Gm-Features: AVHnY4K7yosPI9oTK0FHqewJQ44HWMfciyKrWQml0bf1WAwTD1BP7bJeysXlUvA
Message-ID: <CAFEAcA83wOaVDdw99Vh1qq6WL52=Kn1Pce+U0t9Ku6UkUX1Q7Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: Add myself as OpenRISC board maintainer
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 28 Apr 2026 at 18:21, Stafford Horne <shorne@gmail.com> wrote:
>
> In the recent changes from Peter I realized the OpenRISC board maintainers were
> not properly documented.  Add myself and ensure virt is properly listed.
>
> Stafford Horne (2):
>   MAINTAINERS: Add myself as maintainer for or1k-sim
>   MAINTAINERS: Add myself as the OpenRISC virt maintainer
>
>  MAINTAINERS | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

