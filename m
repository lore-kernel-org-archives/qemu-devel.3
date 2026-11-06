Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA953606D825
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oFjJQGtx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPLkK-0002uQ-PM; Fri, 06 Nov 2026 10:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPLkH-0002ti-R8
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:20:49 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPLkF-00069U-MA
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 10:20:49 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b0dba37a7fso6235127b3.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 07:20:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793978446; cv=none;
 d=google.com; s=arc-20260327;
 b=aEjh5nAXpkZb9mGarBdQFMCjIp4Bh+FeDZia54BlKucMHlSmlYrAUQNPWe/Wt8h9WR
 ZjrZ21XEqbJCW6WM/RR/AzgTzyYMQ19FidKxAKQk2fK2QTbGM/59iN+kXYDzTAqcVNm4
 Vz7jnDl9IRQG6J6o+ldD28tPpEbg8/eRo1KWNF6L9mrpyihLTju4XSIvNwjG/Djtrl9J
 Z9Bernr6ueM+qTjtzpTK/Vm/gXHMZqnwtXkudbbS/5ySFkYY+nmrr6V1Fx7TS0KdgyrG
 n8Lri/5BXcuN/VR3g8AOD+QZd5vY1e/WNuv8bxUjbKbNGTOUyjmv6rI07eURqgDY/6sf
 r3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e2yrcesM43+alyjjO9G2ZtVdWb8XwcX6MmiCYk1DqX8=;
 fh=nGzDeVHUdnZKUdEN/A3t1mOx9QIS6zQ6u0Ifcf+j2PY=;
 b=VGxJh7AJK4tDlkaa3wuYa2YU0r2BOyxeXaXYU1VYM5KqC0WFGs83cYMk+i1bfQ5Mo0
 QDcIoLu1fQEjUu5hOgo+qGhVyWcYdY/OsQTpVUWE/7rv8mgQl+pYKqa3aWeUwrgMMZ/B
 PaDCuDW/iUU+O3yJ8jy0D+71VZNIou8a+1vsC0wcMUDxne34N99hsfg8wxYYyy0er3lG
 lk2RUZrBkJua6Pu5rY/uBj9VmgmW63toiOkQEf2rMdv/6ly8c5VJ6q2Ca52n8iApEc97
 4R7BhuOBMHqTiZSQFVqlgjRoUiTAHa5ifR0VMpziJaxavhruKnclGQpCdfvwgreH0heU
 rL2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793978446; x=1794583246; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e2yrcesM43+alyjjO9G2ZtVdWb8XwcX6MmiCYk1DqX8=;
 b=oFjJQGtx11Z4kg8CM6e/JQVnaZfoPzu0Pay9di/NTWuVUAB2KRpQzRnZ9F7kC4StaZ
 R9L7SFOzYIYYI2Jq7OzdtQjK6Uha/TvEanboYaMUespjI7Lu9cbJ5BELX7OXRdEMOju+
 riinOFH4euVnCYKQMqHiGugOhBMnymE9a3l7Rg9Sew2cn5ZlyYS0OelKPjRWduitrKzZ
 hKTr76P7wK+NPVUo84tUCUcpnaXuZlLkAEu6SKfLYnkM+B4r3/nkNk6umE5EYw9AsDuB
 lMnIxPZ02xJ5K8dMH/4+Lt6Z7djE7LaEBhSX3JJcyZQu/yV5PPe/kqe2yQF+jAlSrzEB
 1UZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793978446; x=1794583246;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=e2yrcesM43+alyjjO9G2ZtVdWb8XwcX6MmiCYk1DqX8=;
 b=niUcqpT3HdMhBBEqonNaEY7IDtLu2QL2J88UIR6m8KeVhNO86zQuhBZUGdsUDZMa99
 YuVj8NBS9KrT9qiZeyUODHlyyVc4MMiXejxQAq8D/tggMze40Ah8TG+X9nSNkD9GAQyC
 4zcJG9iNc6ypOWssD5P8kx9zekxdKqyuDL3vTtf/PggWRTJgQ4h9cpK7fCnbDBPxLoFX
 l0Sm1ZxroGtTasazv/P0zBClTFJ/YRujc5zxLll7WXsi+nJ8lbGrnYGttrmpSNhlBucK
 vCYD/qhkQhV2HQTF+S//TEsj4ognX6gc5dmSKkY15kY6Y71/aNLBVko+Xn0a0RvBsjLj
 hWzA==
X-Gm-Message-State: APuU4Z9LWP1hmPHDcCUbX/mTjzWlVJbcKt7l4EAxHJTfooeDkaOxeYaN
 GhDuvoD/qvYzLqGi0yr/wMGMu5hDNQFEikdApu2knOTbeXuA9oztrZl8H786aHsqS8w6Fa+XpDe
 cXdeX5hO9Vrmz3TM/jRTPBOPoOxOhAotAbXZYgOAFVA==
X-Gm-Gg: AYBFou3c3Kp9SYxqQ9Pq9E3QM5q4OpZBXXmpPCD/O9AvYS+EoLf0h8x5NApA6XAjYtA
 NyoWzdqAK4RdwaudStTG0NGaLciehHv+nwnIsnfC2iVGRDNPomt9QUEQkWcMIW1ZTDwrWv0c51p
 UmjhrMnV/YfQVHL+ENgz1TxNTn98VGuFwKoKUx6wgp/wSGbEPQJQcbRrVxQ7P/Hb+V3zoGX9FkQ
 Yu0P9hQ3fUXtMCq1wO/kxiDs70gq+w9E2kX0kOlTSxwjXaHSEClciDM/HzHe7yD37IJZ/qkn6U1
 PZWTu19ULx3rmAbOLb11MbW9YVH7tbd9gvLxuL3BJhfscQ76ZogK/T4sdVeiNsSwu26ePyJpdNL
 eAoYkRET90r/YeJvIJ6hqcXbJprhb1YEv+h93CJ0HMnv6jjzrWo4xIvT7hSXJDEyBCc0x9RSG+9
 oKNEcppbTUFem4mydNSvyD
X-Received: by 2002:a05:690c:3482:b0:8b0:aae7:5c75 with SMTP id
 00721157ae682-8b341771fa2mr12933967b3.4.1793978446016; Fri, 06 Nov 2026
 07:20:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793613972.genet-ring-fixes-v1.git.lorandmarton.dev@gmail.com>
In-Reply-To: <cover.1793613972.genet-ring-fixes-v1.git.lorandmarton.dev@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2026 15:20:34 +0000
X-Gm-Features: AclHuK_WgvXj62U3kNxYsvQbWuiCMBp6qf_mWqKGqcA3udhnTu0ED4rdo3DmQDI
Message-ID: <CAFEAcA8DW5=W5cCVFfTkSH-=RE+SEpvhb986KDOsEMK3keNHrQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/net/bcm2838_genet: TX index wrap and full RX ring
To: Lorand Marton <lorandmarton.dev@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 jasowangio@gmail.com, marcelomanzo@gmail.com, serg.oker@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 10:42, Lorand Marton <lorandmarton.dev@gmail.com> wrote:
>
> Based-on: <20261027143036.44973-1-marcelomanzo@gmail.com>
>
> Two fixes for the BCM2838 GENET model of "[PATCH v6 00/17]
> hw/arm/raspi4b: working PCIe and GENET (real networking)", which is in
> target-arm.next. They apply to target-arm.next; if that is simpler,
> they can also be folded into patch 12/17 (implement GENET TX path) and
> patch 13/17 (implement GENET RX path) of that series.
>
> - The TX consumer index counted past 16 bits, so the first transmit
>   across the wrap never ended: the device sent the ring's descriptors
>   forever with the BQL held, and the guest and the monitor hung. A
>   guest sending a sustained stream hung after about 65k descriptors.
> - The RX path wrote frames past the consumer index of a full ring and
>   overwrote frames the guest had not read. The fix keeps them queued
>   in the net layer until the guest frees descriptors, as e1000 does;
>   real GENET drops them and counts them in DISCARD_CNT.
>
> Patch 1 adds tests/qtest/bcm2838-genet-test.c. Each test fails with
> only its fix reverted (the TX test hangs).
>
> I found these bugs while running Raspberry Pi OS images on a model of
> the Compute Module 4: https://github.com/LorandMarton/boardtwin. Its
> QEMU changes are on the boardtwin-develop branch of
> https://github.com/LorandMarton/qemu. I intend to send the board model
> (raspicm4) after the 11.2 release.
>
> Checked: each patch builds and passes the test; the aarch64 qtests
> pass (33, 3 skipped: the slow cdrom test and the two swtpm tests).
>
> Lorand Marton (2):
>   hw/net/bcm2838_genet: wrap the TX consumer index at 16 bits
>   hw/net/bcm2838_genet: hold RX frames while the ring is full



Applied to target-arm.next, thanks.

-- PMM

