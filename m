Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E76CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOtJ-0001iq-Lu; Sun, 04 Oct 2026 12:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOtB-0001hK-Os
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:16:39 -0400
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOtA-0001G8-CM
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:16:37 -0400
Received: by mail-yx2-x0f.google.com with SMTP id
 956f58d0204a3-67109935888so734330d50.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791130594; cv=none;
 d=google.com; s=arc-20260327;
 b=gXMhNECM9aeUqJPPIAjvu54GhVCPPWJ6F9zeX9XDPsMOVJEIvdCl0gg05uItKFiFxQ
 OL2S5faQMh2HdxdpsnjQbQHgoneZRHPyzYIGUgdfwW6kh+899lIPusHJdbkTzDBx94z0
 iypOu1TdHCKeb//C5Ped50jfoyj06J+DR6o+lkdz6oYe1QYt1/3IfLWWi/G24Fu/75CG
 1fhMh6R/bFb4WPeZzPpXw23NSF1/6m1uX5UPwz06WQNqBN+F9dZYtxkVlI8R3GrFBtmu
 Bbg9fumEeCQSzYOy15Y82fNU52Kem9DnyeNhh8/tILBoQfjC1O31S/ONC7n49G2aK8rW
 F+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DmZaWdgSsjwsGhT+bcTwZ/ICj/jwgKoJL2XG9oXJ74s=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=FbsV4J2/t72Xpt8cmr2s1fX/Or3F/tjrNwWx0QhHpNUP7NFECaSBrHngE84zw1iy2Q
 RhjwpG7HK5L0bF3U7nDzK21ANp7cCbOv++OtuT0W2trhPPcznWRUTMr5k56Vz9eKPzfZ
 lHNfYEPwyxcdxOheMQNkHqAVTZq0MI481opgcI7Hf1pa2OxXkZSfmaVI9CF+nhpIi15/
 e7RE4vtZBnAdgg2jsri4SgUC6f/9IZavCJTkr3AVX1CPvtXiAwP36MYzpG14XGPtU7le
 sNlgh1Bn8log05ejy0gMfaen64CiLVrPXMOA4jpuAsjVwocXlVpLoDIFWmLCohJ3Ld7w
 65pw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791130594; x=1791735394; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DmZaWdgSsjwsGhT+bcTwZ/ICj/jwgKoJL2XG9oXJ74s=;
 b=O2SajuRr2++26e+HAGxskZqUtsVPY/wp0/i7zVaKNgZbJQdFIhhnmX2Y5i6DKG7Fa/
 wLmuPd30gd0f35aWuRdErD/dN9qNgwLtrFjo3kMOIPu+CfI4KTRPzlq6OqFOTz8ih7qI
 2Yc5Ksos3JKeFgPNFTtG1ai3rMhVULhSRU/Fkms60+KiulFLNvnxEMbErhljymNG5Y2y
 ZB9tR7hBiM60sQAR0rnolaYNMQFKlbH+1ST9MUeO/RnREaK+Ny7Gx5r71LL+KuHpIRws
 oEKfl2/GQomTMLd1S6vxczW41RCCsCf52QVXe6VYGvpqMtUHT21cjARGEdrAZrYLDrmm
 cazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130594; x=1791735394;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DmZaWdgSsjwsGhT+bcTwZ/ICj/jwgKoJL2XG9oXJ74s=;
 b=tVw4XlK7Bc6sJPvgzehJsu00mFcJjfC5zgA0P4LVehCgvL71693jzBsZ8YW4EBxaHS
 HQv+LmwjaTpKWupv/sKVwd2Gd2JGMTJ/6bthXd+46zuNcnOluIsk4N1B2Z7wpUxLvt9E
 jHB4p4J4V4+eS93+QZM6vTn2Jjc6WhYRyvR2WjH+D0a4eR1jvWYfpzfnoP23zIffF+Gs
 rWaSPa95gScbrlkMrFAfU2zGL83lAUUFrH+0DaIhL8OJV3vSwxyVyxNxc2CoPUoc5yRw
 rvb64v4dYiwcQqi2z+I08m77p1iXPfl41Wr0XruRg6wbfCbdS0eIpGtL/uJYsqhvhor/
 vtbw==
X-Gm-Message-State: AFq9FYIDk77J6fLP6OV7dSRrzmOcQqh5zdPCOXr+r37y/xOCU+jeiWUV
 DhjtBxS5EoWma8gKh0VLSiT/rTm0ZkuVRcABeHRCsGcUrWu3Vey85damZmSuNtHOAlFpIakGMhw
 18gsiRC2NySomcOGWbUz9mwyPYliYxrg=
X-Gm-Gg: AYBFou2b+hzzp3BeSjWIbm58JYxKbnBXqOo2XODvsF8Z8KX23jxovFiyTukK1bUcM8l
 0wq+OLXXPCDevkKzuU/5h9YpYHTnBa4a9imwIjUIHGO8K32Tab3RAQbjaE5CWmhIt/xVoqHt+8t
 6x6W8RjGeuBfhPUXLnRAZwsuO6tcJtQoJvYSr5tucjcTvUVDz5HVTjX/EBgEUWyHaivNMvfS7oV
 a7eZxgZEebFkoh47VW9XZFjECLbheLup8ylk0YWmJY6B+b84T7z/D3WHAXy0e4+2Bk844gm8fjz
 J9kkQYc1Ft5DSrSB6NrfpKYRSd6iXDSsXQsS4K3rMKIcoajQUOs805azFn/2qXKaZAJHoR99hxx
 IhrMNtNo21E1oaLS+d1yRCdh0Pw==
X-Received: by 2002:a05:690e:1913:b0:677:aedf:d296 with SMTP id
 956f58d0204a3-677aedfd46emr3335305d50.7.1791130594292; Sun, 04 Oct 2026
 09:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-15-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-15-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:16:20 +0800
X-Gm-Features: AclHuK8OgWZYdIbiLNjf4s9o5UfzXsMuJywvadl8wfHNSBp1CV0h_Q3l-w_ANLI
Message-ID: <CAEUhbmXc6vynEkCYweCdxsQ9_qhk_Rzy4Y2rb7KKOZSRQsYCLQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/30] hw/arm/fsl-imx6ul: Derive from
 TYPE_SYS_BUS_DEVICE
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
Received-SPF: pass client-ip=2607:f8b0:4864:41::f;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x0f.google.com
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

On Sun, Oct 4, 2026 at 8:28=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon
> machine reset.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/arm/fsl-imx6ul.h | 5 ++---
>  hw/arm/fsl-imx6ul.c         | 4 +---
>  hw/arm/mcimx6ul-evk.c       | 2 +-
>  3 files changed, 4 insertions(+), 7 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

