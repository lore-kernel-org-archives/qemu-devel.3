Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0695FC88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x67Yf-0005Hg-T1; Mon, 14 Sep 2026 10:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x67YP-0005Fy-9t
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:21:08 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x67YN-0000aV-La
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:21:04 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6714595153cso642751d50.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 07:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789395662; cv=none;
 d=google.com; s=arc-20260327;
 b=alSKWi2q/fsmuWYXgjvwpk8J4go8aYHBdT7DRlD8/yn/SoE/IfoR2Qif/TrpvEqZ/Z
 DzAK1pK23lVz9EgYvTyeBuVhlgh3ufqai/aplK8wxtWs4qOghTovSLpmYjXw5HfhoaYO
 LQgLdiXpsTkc06t4ZBmAY0oTRILNnICLIGx43OvIV1IO5kaPw7yv4aG0W/6h4PTJ2fLT
 L3QmuTJlLlc6jZQz4v4DDS0wrog5mN+oFGyJzMMAbf3DaLaL6wiR9MeIiaJITcce0gOG
 ElOKsfmcsn3jpxUQ5N1ip/qHC0wz0qbgvL76vYm+p6hNo5nnbZGtvIXQ2PgSk56gA/Zb
 Zn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r396Lzczg0syui8baH6Ko5amzTIaAAgFy4E2en2/tHw=;
 fh=jol11vazjHn162B7nW4goQwOGRozc5aH2gJiMA21Eso=;
 b=RaiE9Fixhwev7sIY/Qi56xp8iX2zGo4L4vK9GKsTrz+L3+jGqQvZApVWVBKNpbjfuk
 d82xS4mVDDqKRMxaShBim+TQPziiMhuyjVVuvDNmVEbvZEEKiZLWRVcgcJVQe+57JBXo
 2Nl8ZVBxKN0rVezO39m5hTU73IWiYFuV10wTjbtvki/W/AVJL2ICypbp08ae4zD4ujxE
 Dl0B5nEVASeUwXLZNbctXPTAo58NT2qhqgN9uoIV3c+mWIiKjWYiW68yndOTL0iLepb5
 64eP+nGRn1XKwTTkjQMSIBRuSG5zSEnksx0UkjJhBljtSWMDpSsSwumdd7IaGpz+4+B9
 eecQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789395662; x=1790000462; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r396Lzczg0syui8baH6Ko5amzTIaAAgFy4E2en2/tHw=;
 b=g699k6xz2SKkgR0U7dVinqgJCNm2zI5vnVxrfcvfKNpEbvsH8whAhvpcCSR4DYlCTN
 CK+kIlzGMTF0qX78qeSqYUKZPOAyWUHztXNN1f/Q+adDku95+htD7RGw08YScuaQurxV
 W8K0vajTUngeD2+KZjMSckuDAcSngmm6COlRdHegKpU+0zbY2TWCLAR74erWC3KjPT+4
 ft9yUllAC8BQ3vLJqxYqpyw//z7ECOMhA3ld8XUMWLnZ4j/8OAbpYZjXimjkMytSBXYA
 7wFzdL5BMn4OFTeleWzzCpJiMeyCztdBMRHBXFKgH3MCeXbsLG3zqbx1AStTQcJySCP9
 4Amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395662; x=1790000462;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r396Lzczg0syui8baH6Ko5amzTIaAAgFy4E2en2/tHw=;
 b=VPTWGnqEA92bvWGItBYQIPNhHBKoW4cgCtBg7d5o61CODeQx99xfhZ94c0dv/np57y
 FJv+YQMZWLedppIaajpUOxasA/3a0lsCSQT/YOHT2QU7IAEei/0fM2BiOPJP4X4hRGQa
 feZYp0B3MveyWQXJjDA5P23vMLqRSfAU3wsBV6KFiqk6QukKRIapKMYi12VvajYy75M4
 NmARA8VVN9CjMXCdcsfC5c3vPn/meurpJb+7TEa7hLdddgZEXFOwDVyhtRYg38Q/Jfvn
 DhfTT3QAnqCmehWQE4llVDAZr1beN4lqqj/0NJX8m5FZ6935R/7Spq5y0PpfRiPf3dvl
 GW6g==
X-Forwarded-Encrypted: i=1;
 AKwUvByTXNor5LnEQXp4bV+QsfiHYNEA81ElKac05H8VWL4nj+AytXS8kffWc2aSdJijjPQNMjn6afXev639@nongnu.org
X-Gm-Message-State: AFuF++lafLUlYWmVnR9eYruXnlhUOsHFgpIQNp5ahzIYdTokj/hoD4vK
 HgGAdK+eBKKwnbX5UzLlvtXv9Fm3xDOjwLKEX/AiG3+Q6nJSmBh8V813fyufTIWdLfLtG/bEySM
 9ELKOcgWusVwZ27DJKWUgb2NxT7HbdQ8t3zgO9N/4HA==
X-Gm-Gg: AYBFou1AUb5K8B9AOfq22BiJ3w8t1cYn7bOSHKGHPGeIZ/wNABAj7H9f4qOGUaMiWwe
 VofFnUrDBwxWIG1K9y8W/RzCieq1fU7hGiyvLuP0dISPThgNnwbOAv6eWPDPiVo/HpbZdfDCtNW
 qPbJqi7YYzb1BHtVLcOwiZaUUAN7I1uI2f5VwbxykdwVJBH95MV1+N8K0eWaXxyfkuDzZXRgQ0r
 CuDRB+bEVxKXjfCER29t7KLXX1ULzj1UPmGroXmK6c+g1ueX3DWNThdd5nZuro5EIbvpn91h9wT
 xzj5ZFf86MidLRcVnMlxUUtNSzwrqzxT5jPJaXsUE6bfEE4Zz5QQDY/BGGEm37L4Z2ZGL+8FNtk
 ZpuXCFKMv+6dDGWHftMqGaJa9kMHw0idioXJbd6Y=
X-Received: by 2002:a53:ac96:0:b0:664:bf1c:2922 with SMTP id
 956f58d0204a3-67142c97195mr1196017d50.27.1789395657320; Mon, 14 Sep 2026
 07:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260909144151.26803-1-sebott@redhat.com>
 <20260909144151.26803-2-sebott@redhat.com>
In-Reply-To: <20260909144151.26803-2-sebott@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 15:20:44 +0100
X-Gm-Features: AcwNN1Ub5nw9wtChzL2tYWe9mGDu0DkyVmpXYzrIP_mFtm9Uf1F0iYjcv7lA0uQ
Message-ID: <CAFEAcA9HBVnBcSchvBrt-z9UgYBeJ2EZAJrdbeoL_CoKgvU6rw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] arm: handle demuxed ID registers
To: Sebastian Ott <sebott@redhat.com>
Cc: Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, 
 khushit.shah@nutanix.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Wed, 9 Sept 2026 at 15:42, Sebastian Ott <sebott@redhat.com> wrote:
>
> From: Cornelia Huck <cohuck@redhat.com>
>
> For some registers, we do not have a single ID register, but actually
> an array of values (e.g. CCSIDR_EL1, where the actual value is
> determined by whatever CSSELR_EL1 points to.) If we want to avoid
> using a different way to handle registers like that for every
> instance, we should provide some kind of infrastructure. Therefore,
> add accessors {GET,SET}_IDREG_DEMUX that are similar to the accessors
> we already use for regular ID registers.
>
> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>

> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e3f931dba2..9652f8b0bf 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -919,6 +919,18 @@ typedef struct {
>          i_->idregs[REG ## _EL1_IDX];                                    \
>      })
>
> +#define SET_IDREG_DEMUX(ISAR, REG, INDEX, VALUE)                        \
> +    ({                                                                  \
> +        ARMISARegisters *i_ = (ISAR);                                   \
> +        i_->idregs[REG ## _IDX + INDEX] = VALUE;                        \
> +    })
> +
> +#define GET_IDREG_DEMUX(ISAR, REG, INDEX)                               \
> +    ({                                                                  \
> +        ARMISARegisters *i_ = (ISAR);                                   \
> +        i_->idregs[REG ## _IDX + INDEX];                                \
> +    })

Would it be reasonable to assert() in these that the INDEX is within
the range we expect it to be (i.e. >=0 and <= REG ##_IDX_LAST) ?
That would compensate for the loss of the compile-time checks
in patch 2 and the fact that static checkers won't be able to
see the intended bounds now this is just a slice of idregs[]
rather than a standalone array.

thanks
- PMM

