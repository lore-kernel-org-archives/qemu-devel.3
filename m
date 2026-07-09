Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DA4C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whma5-00055z-UD; Thu, 09 Jul 2026 07:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whma0-00055h-Fa
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:06:08 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmZy-0006SJ-W4
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:06:08 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-664cdeab266so2537297d50.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 04:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783595165; cv=none;
 d=google.com; s=arc-20260327;
 b=DP6Q0PFGuibHFYcDpgUSDXcg24hXaKtOCDW4Sfz5beEIMx694LOOp8HaX1cMU99ASk
 4d3KnExdOTr4gXt9BMeNW11r1us+OewND+I0L8nPRHVPILBySr8G64hizwGqEd2QT/vV
 uH/Uu2DWjFAwMlgz4Qwih34Cvi5jweuIoHaWqyM5Vn+Txi4ZKW+B5Bmb38TtlSVMMduJ
 J41mhZePN4gutvn7EWGRu8KsYQeBeVBCjgalfC7aNls4oJ7tsXi1lLtnivqOoNDRup2O
 oqEMR3N0z585YLp7u2D0ZDHMU1lxmlUnGXKoiQL5fDLlXOTwLnpaZOecJjphif9iCw3f
 OvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mOSDUjw16rV2I/2vBm9luEKa0YvI0G/Jv3ltRP4yr0E=;
 fh=6WCw4bW4BFvFaSaS4HIQrGjpMzxK7yBnMEzkdlhtHXc=;
 b=myAEx+LuzA9Amkkv3RFuEmBm06NpvNb/GZ36vwW1eoyxz8hGtzEatvsPGa8js06zhV
 hSUF9X/RxlB4SvT3z0M8/UUOb45Rn2lVEcwqnFR1HkqElXaIueyPxmn41KyD3CrE81jP
 g5c7Cb1T9Gj66XJZrBv4tm39AW45k5zbm6A7958LGGGE/vCkJhzPfCGKBYa0Ct2+3b3I
 pRGo3nsaYVCYotHoSrgH0OTpRn/T9n9LwHmrD9Be+QvAvjgsJbaGWvjAmLPNX//K14aV
 MzldXdWo3RjFIvumcVYVwvMFq3/eQ1hoR0p4si/ym8hNRU34Z9CPXQQ7YlrCsG/HUWzX
 wFrQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783595165; x=1784199965; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mOSDUjw16rV2I/2vBm9luEKa0YvI0G/Jv3ltRP4yr0E=;
 b=bGsmzhnKm16TF9Smm3BoAGPrkce58xtIXU9iiNIShMz/r6iYZb8ehZbIzSNw0N2DnY
 ZRRjVUA3LWpRnPZe1zvcZbJiDqMy1unjyBcNDo6Tvoj7Jz7Jk+2WhWvhbFxEk9F5sKM3
 ceVSMEioo3uD27ltkdcX0nrDx0Wlt/8QxFO6eReFlioB17j9bxov2WIVrlrWPQduWntw
 WpaQ7QAlOsBZG21d+TGR+ohM98wQIoCzgt4AV8BgyosMVx/ikY5Okwwu8oXzQJYEyhD0
 8R6nI2S6zVCdeXV17A7rGCnwu/W7J45kpK2iFbuPSRJUO2IVd86IR1tTj3sX0dBTRfhV
 ZTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783595165; x=1784199965;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mOSDUjw16rV2I/2vBm9luEKa0YvI0G/Jv3ltRP4yr0E=;
 b=oqcUmoDy/WM4XDRPuooop2LryoI3Be5ebTMDEr2AN1WzMA4DEFtAwBJagAKuyw2wbT
 0y8/6QNypjb2N4weCM/8naMEWnYJ3/y4OOBbqGBbovF/rmSshKoElxdja1AWLwJRBzmB
 lOHEO5l1iAplaqfL6HCb36yfIv5zvKnXBwMNL8VvIel+pjsNQF7O1zK68tLrrncj0n7G
 TGiV20AJ/UnClk3BCYrcko74vNVAVmYIZQbhZZHLSQ+OtyQENZW5xhHp6Oav8gaxNzOE
 SEAlFBibdeYAOImVtB0BYBZ6ljBNd6/Al1kmZ0xvZLj1cq9NICjCYNLL8gLolcR12aT8
 gFPA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCvWBoasGxMqW+oR8RHaHRWLoG+7AfHjtvv2aOGUwnUPztwVb9bWxNZORgDk2UDwtyDPF2yt/v9Pvb@nongnu.org
X-Gm-Message-State: AOJu0YxMMFa8AiWfVKqKhDRQX6+2epmM6sqzIxlWk4xNT/4e0zF4C6EU
 g92j9bJpKRJa8KVJYt4cd6tqO3gE64XJDLXE9Pmq3fC38cFZox79+1HzkTM/3zkyFJ2WpMaA1xD
 ZCyu2f7XS1oLCbgs/qp+DNlXxK5/X0/XuIFIRwrkTHQ==
X-Gm-Gg: AfdE7cnXGLZHf7mvEO0P5IoMxHoMvJx0G8B3JaP38hEyBz6hjOubVh+NSkgDZl0yz2p
 AfFcgSnRR7hKIrpjB2Em6xzF4i5oqevbhjVj7kt4bv2rxFldl/NeEwEr6QAWp6jykvK6PvuK1Fo
 9ygYmnY1TXIgkX2ZSZmFy7WgbNxBQ4Au4nesPF0Aa40EuuqqovRRgV/hsXm51eYW9MuJWgrYScf
 d2/DgUvCY8FEIMV7lAIF7xMfkfCXIgeFlJBavEnMfyG2MlGMXAolGJQQnzmphmyYrRGmN+F0IcB
 2lEmxS0qGtW6q/pSLjkvdQmQFfg7Hy5z/CM8jfyWFpHexWCuHcrqcYqZ
X-Received: by 2002:a05:690e:c49:b0:664:ae68:33a2 with SMTP id
 956f58d0204a3-6679f17d732mr4716060d50.67.1783595165490; Thu, 09 Jul 2026
 04:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260707085028.165557-1-eric.auger@redhat.com>
In-Reply-To: <20260707085028.165557-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2026 12:05:53 +0100
X-Gm-Features: AVVi8Ccb_jNGog6PhCMuqSu3Kw2eK3d0YM1oiUGP5asaYJe2olY7AhWifW1tg4s
Message-ID: <CAFEAcA-6DfJJ_6oJdbYwwEDp6s4sqLKLMEUp7Cj0+6ozGq7UUQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] SMMUV3: STE lookup fixes
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 berrange@redhat.com, skolothumtho@nvidia.com, nicolinc@nvidia.com, 
 nathanc@nvidia.com, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 7 Jul 2026 at 09:50, Eric Auger <eric.auger@redhat.com> wrote:
>
> The current code fails to sanitize SMMU_S_STRTAB_BASE_CFG
> LOG2SIZE and SPLIT which are used in the STE lookup. This
> could potentially lead to wrong shifts/masks in
> smmu_find_ste() and does not fully comply with the spec.
>
> Also the series fixes different issues related to strtab base
> address alignment computations: off-by-one mask, unchecked span,
> missing L2ptr base address alignment. Those issues
> were not visible because the guest kernel does what it should
> but better comply with the spec.
>
> Best Regards
>
> Eric
>
> This series is available at:
> https://github.com/eauger/qemu/tree/smmu_sanitize_v3
>
> v2 -> v3:
> - Introduced STE_SIZE and L1STD_SIZE
> - Just cap strtab_size to 64



Applied to target-arm.next, thanks.

-- PMM

