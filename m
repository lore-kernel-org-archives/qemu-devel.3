Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18C2C61CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyS8v-0008ON-Cq; Mon, 24 Aug 2026 06:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyS8m-0008Ny-VK
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:42:57 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyS8l-0005bh-DT
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:42:56 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66c9995ca60so6968269d50.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 03:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787568174; cv=none;
 d=google.com; s=arc-20260327;
 b=q7O/KqfJ5vpY6t/MprGIR2fsj1VfHLY71Rs4lTrETt38HuATCUhg22yoYYqmvT8vYV
 WDRKdzHarUovI/NRlroZ8QPL3pt3yKLUjXZIbmMGhCZTZHkjaXmRKivtsCdOTKbUvJ3W
 yHYLkEkaKP0BAN55OBJdoEuzuYxtrrz0ReZT6BhDqZGnGBMNqskKMHbG2sroYdhoSKuZ
 474EvwQuUzz1m1EiIG7IMVd1Y5jGmFGcuNFseZYrr2wWVnpi5DEHk+OGZR4zm6T8eZs+
 7v2a8Sl5333MtZzpS2uJuHXPGAMVQ7ne+Fi72y7YTWXyWKo/cAZWmA7hRxbgneQJezGG
 69xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=+JUe8swsZ6YXdP1HwTUKC7caG2ohMj6fA/spvMzenDQ=;
 fh=nYTZllgjekHGtTzyKg/f9+iL5tjLFd5IiClpQ79Sotw=;
 b=GtLib91m/mnIZW4EFHdA5bXrzzIrkwGDBxE1O3ZbCR40ns758pkj8iNPMml1CGJBkq
 W4qUXk1pzur9l84CzHx5u7j9M6gVSKhdK20KrEE1FJIlIc9Kp+iapguqseYRlLiZbOX/
 cdxvk2ZAqJw7yKNYjqb4Hu5QYx+UuiIs9bJVGK81xAiWhPPCK5TNYeQDgnTJKEY4ZUlR
 mK5WkBIV3OaQpdV8ldby2fFfgK416wcFtM06i8HrLyCOEVDNinhVIPFufYQ62ULoRmo3
 d3bRqFsADY3zFTJ4PFNC1Tk61BCVpE3DnLxTFrrwMHhK6i7eUkwqUWVgEZOaOxekBRFr
 aoDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787568174; x=1788172974; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+JUe8swsZ6YXdP1HwTUKC7caG2ohMj6fA/spvMzenDQ=;
 b=IEpyBMcMn0I0W86UUJg9O55yAWYBYzv2OLYzlNuLl/rWCT+F19CHhPfyUk4A/GEAnI
 j7H23WapKIdwjVMrJgBmigdBSNpSxGLA0CNiK+qhpoFjFL1Xhz0RDnisSKkLoRgBukHl
 uJXoVCX25SfGehYKMGhJmh5qGp7Kif2Hp0T5RvJ3JuvUFi0TAHWduu7CDqCiFEmzlO5y
 9CuXOZ7uY9gzhPKsnMd3IrsN2LkGfy34WICWRKSNxHi9CQn5W6PhNcjyXaimw5nt1rbr
 t35KoNwWNAM+l6suVivGmpx2evSNwEIASxl6/uMzbxJotAKSSnSFOcyU83d4TxJcpB/y
 J2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787568174; x=1788172974;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+JUe8swsZ6YXdP1HwTUKC7caG2ohMj6fA/spvMzenDQ=;
 b=HGWq79cuyAVE5Ot5MOIqyAybRtZt0Bzq+y7iAqgh60G15WlozVOC5wzt3o7CodTsI5
 VilJm1V0CPKciaAm4sohppM2ogxnrfyMzfMPiLb9vbeDIbNaecYS+Ax8BjXIPz1FlNHZ
 APQl3NfEph0eJDiUFoYG+FnVWYF6VZlqQfQlmm1t6Jlc+O/bVd62istlXel2V8BYBn7/
 MP02OfWT2CL5sX5MKqHAEJyJzlJZflzj57MN5vwh5TBKpqme9oEkZ4RorEcBY5VRPrKI
 ReMmLZBLh3nEi9jdtZTqEI1rl/8C+l1zbQ5lzDKCeYvQ2XUQN2lf/xw31rR7o5egtgQq
 VRzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVkrW9F94FiO/kvIvkRL2p9QDlwPjqiQIZUGYLN7rEs9nKnGwLUmJHEOyHacNLsynnmIVy5wjBSz4X@nongnu.org
X-Gm-Message-State: AFuF++mQTJiYz8BGKWqeyiAlT4n72j2j9k4RRmddPYs4l8gUdcR3RbGU
 DRar1GUiD6Td55Q0eMlcCiTpMrQSpnYRXt5O9VXu9SqLjmtmxSMYE8nl6j3O/mB0sWOAA+8bYjS
 v04xF6fkraFil2nnAijAkwrWHmgnzsNFp4JHjADZzsg==
X-Gm-Gg: AR+sD11eZUjNZo3005/jZ/Wbhjb3O03YOzJHd/XW3inthlZRQpidLsDIgS+IsjUzugc
 l+ADsp3bPHeBzpFelZXV6gpOLjEdEClt1Zq0jMVpSwhyHB4Hxac2v/71YSVZSLAscaBrkAVqfvX
 9tTuPlwiHX4Qs9QJzntFnAB1lMC5kCID/Kyu8f8jVdA8nCL8uQvHx+9Ew2y21NVvyfJciaKvFTy
 An606mVcMzOllW+2VV+kdrJHxKKv6STQsLzSrKbqNw6pB0b5CnJYQZK5Quv6JfI/n6MWVjWyIYn
 x3yxDIh/82yovecKQdolL8nsJTC3gbAtqC27FrmZ9sGbMGkD//Y2jpE0Al+WSYUkxAPa6pir72s
 5IG0pk7hhPCVBAqD1cafS5N8XhDQz
X-Received: by 2002:a05:690e:4511:20b0:665:2045:fe47 with SMTP id
 956f58d0204a3-66cd68a5473mr8109748d50.7.1787568173748; Mon, 24 Aug 2026
 03:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260824102805.639072-1-peter.maydell@linaro.org>
 <20260824102805.639072-2-peter.maydell@linaro.org>
In-Reply-To: <20260824102805.639072-2-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2026 11:42:39 +0100
X-Gm-Features: AcwNN1XlPiJvl0vPwOAjhdIuC-qCvvroQHs_RtOORFFwcHHQWEyPugTU6m32uBI
Message-ID: <CAFEAcA-Y6GRf_a-Dfjgf0NLwzgMuVN+xr6RTu8aZZig1+Ci84w@mail.gmail.com>
Subject: Re: [PATCH 1/6] hw/intc/arm_gicv5: Ignore low bits in
 IRS_IST_BASER.ADDR
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Mon, 24 Aug 2026 at 11:28, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The IRS_IST_BASER.ADDR documentation says:
>
> For IRS_IST_CFGR.STRUCTURE = 0:
>  Bits[N:0] of the resulting address are 0 where N depends on the ISTSZ
>  and LPI_ID_BITS fields in IRS_IST_CFGR as follows:
>     N = Max(5, (ISTSZ + 1) + LPI_ID_BITS)
> For IRS_IST_CFGR.STRUCTURE = 1:
>
>  Bits[N:0] of the resulting address are 0 where N depends on L2SZ,
>  ISTSZ, and LPI_ID_BITS in IRS_IST_CFGR as follows:
>     N = Max(5, LPI_ID_BITS - ((10 - ISTSZ) + (2 * L2SZ)) + 2)

> +        cfg->base &= MAKE_64BIT_MASK(0, tableszbits);

No sooner had I sent this than I found a bug: this should be
  &= ~MAKE_64BIT_MASK(...)

-- PMM

