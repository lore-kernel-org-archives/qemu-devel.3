Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A00CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDP1v-0001Wm-Jb; Sun, 04 Oct 2026 12:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDP1u-0001Vx-33
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:25:38 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDP1s-00029G-M2
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:25:37 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-671563fb8beso830633d50.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791131135; cv=none;
 d=google.com; s=arc-20260327;
 b=rIZyAZEcdWeZB/mTBU0fu4XJtCDSA2rDNFK8GTEg/OBul4wJwz5+C62Z4y6DIQnNEg
 nVGZ3aECWS+y2ROnSADgdTb/dnqqT82LNYPakeJBvMqGKp307xL1Px4bL/Zn0X+NIxR5
 efhyO9vmTkPmFd+ugrFSFcbzngiO358ldJPK69utERchmGTy0gd3QlabWGUfuCMwqci1
 3/JClSBa3UhjfhNudi0HACvYNzQyFGLs2Ab0GOn3s8CfFNoifwTC5HKmgyTC9Wk+HnZt
 0KB8jUd/hS4A7phSHjyC8GfwSbYmddSzOQBkL3j5JgeQmMXjVAa0wY2B0Da6Qgl6MxCH
 1jZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RF3eI+l1bMF+Ouj9aZSTkdGOqq0MZmWEvOan5LPgOdc=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=UtSbQp3tdGnBVT0eKahS6ajM0ugrGZz/ltSr8NA2aRyMJX5UPECTdUuSYvQ8PKhNw/
 yE6S82ntUDhZgNRj3pFMirKgQeoMdBn7YhaQRu0Xa7upgjIL2oorZvgZ7C3d4KvnHTJR
 e6nyTAp2goVwaswtWrrGyRMmN0giXhQfqDrbEhoN65woFIprmW3ppJsjpGxqmmQ6rCic
 0Dl3yZcMJ2XQBW4Iu3BMV9YTusq6BAzXIRewQFHXQfAWLyojTlJLwoApBNcO9oBa8GAZ
 OKRYEpgyumFaiw3sT6gyPrSFO9fKM4tBYh0znJ9m5o2FNsBG0GCo4p06vxJdJQRhp4cy
 qwGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791131135; x=1791735935; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RF3eI+l1bMF+Ouj9aZSTkdGOqq0MZmWEvOan5LPgOdc=;
 b=QcKVfHuxtbUNB8dyazm3yTXOo6by4eNHtzgECvvLny8Pqaise54vEuA4PdwxZzEqmh
 59CYB3xIDm3iansot1k4WygYdkEOswwT+VhZbPWd2yoJx7xgpMabUZgCRv54C9vxnkry
 MJgTLJYkD4z+7nXQkwBGLOLX56XDmxjIxRKpXoF/yI/UfORK6YiRPvDmSxczST225vvD
 2JxCZguIuwXAYBeelQm+BCK0bIN7QzucgQhh4uTRf3U8965mZETKyQGfbSaqPLLJ9o4w
 AoPT8TY5/AF8bgVVEjViYgDybcVDOLrjpr+e6e183zoFdD0dU93KMXKJVgy1r3aE2doi
 V/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791131135; x=1791735935;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RF3eI+l1bMF+Ouj9aZSTkdGOqq0MZmWEvOan5LPgOdc=;
 b=LSvXFUspZ+UA+U6ZM21vVVyZCKRgSNGLbaytafRgDJTjwfo2p8lAtzRXz3MKSXEOEM
 /mDarvlKVmR11KfbDI6krXieWVmMd5ShRcmhp9tuFT6FEzokJg9vrDd8hErBKrbu8Wxe
 g/QvKtrUBF0zzur5wAUVQoLTlkZdHopLD7rhjwDFk6EsGGaD12rxUuTqYw1Yt+rVYsQX
 TLxS/bsqWUJJ7yAoaWCn9JzifEkFUWF5UVG6GXwUWReVxPpeJbbHysNFxzgqADMBUhpD
 lDItlHCjRKvIzfMXgBAJaPvCfWBYLrozn2nBr7j+IunpaMVy9mcSJuIxsdd5r3cUUc9y
 d8Pg==
X-Gm-Message-State: AFq9FYJ+eE+kX6L3TeXwtg9nQgUAbPT2jrmX6ePHrOppuH+yCmBX/iZ1
 4ma1Y6vaEoai6Kij49eSRbukWbo4qrsUMlfNK1813uL+eZ/cyj5tD1sxVSibjbWSV9j/jkZrEBc
 8ozojR3S4EBIHJM/Sa0XltmSkZAjVXk0=
X-Gm-Gg: AYBFou2S7q8mpBS3oqx4zyzb293JvqfNoIL6saS5Vo1DV4tjgtGvqfc/Jv0i1TeNzqq
 dhJI5Gkmcm4X9iGWYPG+68tsLCn+wvgD3KD+z0DLxN7WxC/Y34TKmmm04PjS+RJimVEoVi18WGR
 NvnZGiaD1wnNfHBXXYpr507Hn8KLEGZSJuuZBIwl3SyNgnE0Wx8KFldGttE1ZGu2fzqh4W8Y7jd
 wp9E8lhCTfbKK29X00z71/BJiInZuEfKEzq2c85Vcuur8e4xC5SJgi3z33vi2D3xF2gUZfpdtZm
 EgcRp502lrZEzLDGNYM6wnjJC/Oy+EoLLawzJENhQrridMoXMHy5tpw9or3C8QmaN0ttdDrckuv
 tyzETijVQp6dmulc=
X-Received: by 2002:a05:690e:118a:b0:677:d1d9:1276 with SMTP id
 956f58d0204a3-677d1d91839mr603193d50.89.1791131135466; Sun, 04 Oct 2026
 09:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-30-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-30-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:25:23 +0800
X-Gm-Features: AclHuK98IEkVfd8VQP0-LcnzO_f0FLJSMyh1k2_fcfBCUBJEg3f-lrU_nx1k9vQ
Message-ID: <CAEUhbmW_9MKRPW9CXMjAJPkkT-APsbL+Wj5tUegfP6vseSoe1g@mail.gmail.com>
Subject: Re: [PATCH v2 29/30] Kconfig: Remove config IMX
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Oct 4, 2026 at 8:33=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> The previous changes removed all uses of config IMX. Remove the now
> hollow config item.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/Kconfig  | 7 -------
>  hw/misc/Kconfig | 3 ---
>  2 files changed, 10 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

