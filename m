Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED9EC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyMqe-0004Ad-Sr; Mon, 24 Aug 2026 01:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wyMqY-0004A8-Ix
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:03:46 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wyMqW-0006Dr-JM
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:03:46 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-69a33fb0031so476739a12.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787547819; cv=none;
 d=google.com; s=arc-20260327;
 b=l3YmHodduvdf8AEN72Upyp7eEEMuonvWoqxjgeDolWOegjBUxhg/jokmB2GUtMNYRj
 anttVSP03n4S7aBSErNvPrB7utef+OnMKmu/9rJTwI1knGI+1KBqDfzrDYDeoJ+d/Ua2
 vESaAqM9TSnLjv75ZD9TtORMcHLCGOwqw7a8Xlfn4cp9U6MDdpfLQO6dbc6wa7JXcKFB
 +XjXFQksOVuDa+NYRJxR1ZTbtwN1rCf6YPGGrs4GPJ+S5ZAds590rMPvzuXuia7ceHT/
 uEmigaZwjeUvn3/hen9sdbC8zz37imPG8Vx2jDU4ezvUFcWfoqUCTNGV8BYoQQY6+vp7
 3oBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YlaPGq8FNn2ugzM8Qu7ff5zxWrPJKDT9aohHVaiOXgE=;
 fh=+xxEUy9FJ+CZAB7XtA50nI6rSHzay7r77rFZhazA3AA=;
 b=TpUJ166WpOWIpT/5WpOuIW2QzUm4LTW8Z77zBJm0FInxNMwKsW5OemU7M5ygB/Aulo
 ays9MeMIBywrm2XQpNinOkF52cI4MaWydkY7KQJpAH6f9J4LZD3dRP1bWj7U8/irqdyz
 X2xObG+Eks2BryTVFsWQaxWpjTQkMVtftZJHzK28rR4i4vwQaoRm4J8zhIymD0mSeAPi
 i1Vtt/9GuOHwme9H9BC5G70nf3aGeZoRZRb7EcggR1dRHvr2YCob0yFrJ6d9v1q04kky
 2QdISy/NQO0vLPIg2FspETb2MsKwvpuhDBc8iikei7mflNIsesIGgkiEvUX3RG4409Z6
 Thtw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787547819; x=1788152619; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YlaPGq8FNn2ugzM8Qu7ff5zxWrPJKDT9aohHVaiOXgE=;
 b=MrzZ0dcMfoeua8pntxozcrcvwYkbKFOdWtPpXckOlM9p5au0nBaaJo2Dtenbmb0nxl
 uN3FvIu2jw1hs0zhvtOvv8tglwT/GBeOM0gmuHyZR5PRN4u5N6wIk0fPDq7C4v4+IUlF
 IhuzsPkVcvLmEqn3zf1UIembpqgC3eqJn8ZvieQsTPVkB7Kcxphnry7+/OtsEnVh5EoC
 xP9AUolGE8LOAiRGY5wbrIwISkZvhvSQuDy2vFNwKf3R/naV8ADlVYafcVxC0+wXXEl5
 ZENOVAUuXKtp7yio84PHWQFvVDtJjlkgGeTTE0mZhCciI04O4VKe+MtQh/hYmzOAzIrE
 SPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787547819; x=1788152619;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YlaPGq8FNn2ugzM8Qu7ff5zxWrPJKDT9aohHVaiOXgE=;
 b=C/YlQFHaxr1wPPs6BtInawzM1h3BHI1+ADkGx1UzlgrlFqHZ9xOrdzqmsrjBS6bIdY
 vdKPysSlTeBY52kcRk8Vwz/P4w7SD53UFqmkROBbMLkjuBBrPqatlZLda+g/Tq3GSN4e
 7+wuCDHJg5xoeJ2yYVZRgOR53r9zHMJW+hcq8/KP3DITR38X/kLeb2JQmet0+TVgE6kS
 eaeX2YuT8qW1y3+kpEG7lzEOataOu5CaT36BH2Hg6os9gTqRovs8QXY6AWwCKDiUpVYu
 yZe9SEqEFGOimucyIT2d8e7qZ9K6SJyPbl02xvRbDxEss4lm5DcA2i65P0223k0Sl4DP
 /Qeg==
X-Gm-Message-State: AFuF++lQbesPPgJ9bXrCegbEfKmPFmvk+//CSwqu8U6uAj1vj95CKzq1
 kxDzg6BkWAodvdVNIgJ1XOhwSxi6yKOsrMSzVC1CstvXp92AW5s4uuviZ1QSY6pirAK/80zEjLC
 SEE0GIbYFlb46eB/UqCj2wwMGXisJfG9E1NuOI9TEKQ==
X-Gm-Gg: AR+sD11Ji4nop9ogAlQ6fZcPKs6ci4a8B9Hm1YAB7jCr6Wn2K04vs0OtAZ3LIZ3mSjK
 X1kdVoZ86qxwpGajwD34qTjrQYQ51X3Oo7MRBgsv6CKTWo0KkgLN+Lf6dijYXHkvz0aNZlxaN2p
 H7TPCHUVCIGvh1TY1HrFv2bScqCZQGM51Q3ujH76+JnvsmdhqHgJfhKVTxvaitLroVZrKfMIa3f
 Gf4eLTqh53SheK+csr3cxRSPzRlhztXvZvftqEzKPPOP3g3xBBZdFcHbvPgajIdH23hgJLlOOBS
 Pu74cinDDtH+6hV57Pt0mJwb5AGBvKXDbxBZZPLOi8WhzhQ7gVOqQdksz5MGqQpvCzeLib1MD0r
 MU20VU3KCWj7Z
X-Received: by 2002:a17:906:6a25:b0:c16:1290:11a7 with SMTP id
 a640c23a62f3a-c246a396b8amr1502036566b.1.1787547819034; Sun, 23 Aug 2026
 22:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260823021657.2824542-1-yanfei.xu@bytedance.com>
 <20260823021657.2824542-2-yanfei.xu@bytedance.com>
In-Reply-To: <20260823021657.2824542-2-yanfei.xu@bytedance.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Mon, 24 Aug 2026 07:03:27 +0200
X-Gm-Features: AcwNN1UgQXc_yAoeB3ozG0Gqyj3otxQaeMEcq11sB9RnOexOH4zvuaAez16dlOc
Message-ID: <CAMGffEma-GtSiSsRoJ3ifwFCmnkYjgQoVHOFkdY1P3inwbUPiQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] migration/rdma: Fix write-side shutdown
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 lizhijian@fujitsu.com, isyanfei.xu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::532;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Sun, Aug 23, 2026 at 4:17=E2=80=AFAM Yanfei Xu <yanfei.xu@bytedance.com>=
 wrote:
>
> qio_channel_rdma_shutdown() reads rdmain for both the input and
> output contexts.  As a result, a write-side shutdown marks the input
> context as errored while leaving the output context active.  A shutdown
> of both directions also fails to stop the output context.
>
> Read rdmaout from the output context so each shutdown direction marks
> the corresponding RDMA context as errored.
>
> Fixes: 54db882f073a ("migration: implement the shutdown for RDMA QIOChann=
el")
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  migration/rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index c076dc04e8..fc6cb75167 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2993,7 +2993,7 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
>      RCU_READ_LOCK_GUARD();
>
>      rdmain =3D qatomic_rcu_read(&rioc->rdmain);
> -    rdmaout =3D qatomic_rcu_read(&rioc->rdmain);
> +    rdmaout =3D qatomic_rcu_read(&rioc->rdmaout);
>
>      switch (how) {
>      case QIO_CHANNEL_SHUTDOWN_READ:
> --
> 2.20.1

