Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E38C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwg3D-0002yB-Mg; Wed, 19 Aug 2026 09:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwg3B-0002y3-EO
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:09:49 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwg39-00031s-Nl
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:09:49 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a18b91fb1fso176791a12.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 06:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787144986; cv=none;
 d=google.com; s=arc-20260327;
 b=f7Xg7tE9uVVwOx9Ob5G95O/nPkagLQ9SOjFQxdg3vcemH31htXoNuCtKiCR3pWiFGe
 2mgK78CF21zZBspo6ABaQAXV17r/IXpcJ7Nc/cHOHcGrmBD7ScN9e7j9V3JiZUrClVFd
 +PLrlQWtXm4u+Kr19pE5BeRrNMjoSJ1WSjY44aL6Sv7DQaZHq9/wfx2bw+mEnjO9z3ij
 RkOxw5JaVEqdxnQHJPh049GLES2jofk3Ut1G32XjDPiwQ/fd+5hKzFa6i6PSnwjfQqXs
 vfqIAiaHTR8jb7T75WCWAnrgZ2qG31wHtDDwK17R7RNL500/HKNjuGiLppIVuyRWr5MU
 d5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vbAO8aXyzqnjyKlY/gqPooPIkbs4rldS2kRToFkBanY=;
 fh=QWNbaIaVQQou6IzIMV0ib5reMaT/Wr3DV7egi1JIcps=;
 b=pQHHm3h4s+GdGxT7fqbnB8ErMuDb4GQtngwnYOkOjSAd22seFYVELpbLOt7dg47Ckp
 frgt8ZyClwFhVm475wtUumAAvCw0HNvTawqhS/CbEPmHxtH++wVQLFBHClsKOFR8eKHy
 LUGFHDR7RDd3WH2XyEyvKidrisUSU3qaEiooWlYnpk4FlLozuzqX1e/Jd2M7WG8yMbXw
 DXbx4/HuVsCykJ0iv4sB+Ln4iyKWhk6Zy5GTqnH8EqyYEkw5Gn4scRNcRRB/hmg2bVN4
 LWUlOGTHsscE18r3ts59ZPy6WZH5zyPPaYz7GwwREzQI8HEnN9sM/u+akd8HMiLke0k6
 Fd+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787144986; x=1787749786; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vbAO8aXyzqnjyKlY/gqPooPIkbs4rldS2kRToFkBanY=;
 b=KLCtg7c7Jnl71Si31W/RC2HthzeLB6tKDup8257XLiZzwY3EWjE5caGtQbYoNGGrH3
 Xt907JNflC3h8fdWsMSL65ULYjJWKIXa92JLndH5CSBMLH+bgsgIEaKThJfsFNlriS7s
 LZmILRcvLB8e2Kh65zInvIxmeY0htfv1si5RABqEGsLc+Yo8ScKuvzJoVPsip/eOZKMj
 VUOnJReTm/Jb1OASRTnwMdtX0BtPYK4RXSIKVtXpCQ9rlIPmI66PI7Oh7Fzmrw5ueDi4
 1TfppLwVqIh/xAC9KX9p35jaonZE6RZos06E80gsVC2cifAAZKSRmXWCBrL65WSaFs4i
 8uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787144986; x=1787749786;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vbAO8aXyzqnjyKlY/gqPooPIkbs4rldS2kRToFkBanY=;
 b=JhDrKg3qcT2SK72yBzPvM9XN7RCSuhS2/XiNfu1uiHPLP5TN/kY7/UHQKivpwAvfBe
 5Sl7JNExiSy40k7H/pon3XreERBE3OlCrS16YrXehva7L3lUPDJFFmNWfPlNkpWQPLRS
 YTDL/klCBvH49vIrjFKm4cfSy8yihRoriJTYs7Q4wwHo+B5G7oI9UNtsbL6mdUJDr1/n
 JAa9ugr9VKtH9pwZL2tj8yB2Zw25OuFTZeJb2IPouUeZFXvGhvWoowTqtHjOfE4levqd
 NE5k9RroOqJY35BANoVPtk5xYGsXbZq3tVv1fvJd4zwhYeZbWg9CbF2IAFdFSJi3Y5TA
 2CNw==
X-Gm-Message-State: AOJu0Yzo7vtVweRIL1z5AXV0pZeWQqv3pKXaxFo3OMO7L4UGcbom4vdK
 MXp9VEPKJveM+qBqGzIWdLuKlp6kjUGwjh0Wae0EETsVenCtGTyMszd7tNrWB1V4MNhmtWd7rHv
 baXAmZufrPlXtkhIZ9OhqJpuSCbHFkaVhYqfO4PkMkA==
X-Gm-Gg: AR+sD11JpQqYSXvZKHveY1BKL7gHL6IEDe28I2WSx842AmZen+0zp3ecExce5+SASID
 0fXrXme+QjCdj409sdnVZM5R+rOr+Dejb3qqrHMxa2P6sJSyYnRUgLdsahnBhmiQ+nK/t+NSS+0
 oPQ1Tt/oKw50wx1jX6dqP5HU6U+J97o7qDSDUx+mixM2I3Se5T/kor2XzsLSGt01/0V61HzD6R+
 /+uZhDNl1EFzjw+RJcy5fjPedQ48L/vM59UhY0YGNKyG6ePiHbs2B8eN4ZTRSabCH7KkDpBCMoD
 koUXoG1u5PMEGSAX4RifYTfghHS02SP8WdLxb6dYdBSx
X-Received: by 2002:a17:907:960b:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c242e36cb2dmr157779266b.4.1787144985622; Wed, 19 Aug 2026
 06:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-10-peterx@redhat.com>
In-Reply-To: <20260817202424.2901438-10-peterx@redhat.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 19 Aug 2026 15:09:34 +0200
X-Gm-Features: AcwNN1VqE_ueYWrb3IuLPBAcUf0hqH4vS0VYLrCV6B0aOL_XYulsAKB4I-pGSr0
Message-ID: <CAMGffEm0xuvZXfws6sLFxg4C+mg9LbgxFEPHn0nCjT8KEyLD0A@mail.gmail.com>
Subject: Re: [PATCH 09/10] migration/rdma: Sanity check upper bound of
 register MR address
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, 
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
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

On Mon, Aug 17, 2026 at 10:24=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> Before registration of RDMA ranges, QEMU destination checks for validity =
of
> current_addr no less than the target ramblock's start address.  But it
> didn't check for the upper bound to make sure the address is within the
> size of the ramblock.  Add it.
>
> Reported-by: Tristan (@TristanInSec)
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4007
> Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  migration/rdma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index bbbc40ea3b..13dd60c11b 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3389,7 +3389,8 @@ int rdma_registration_handle(QEMUFile *f)
>                      goto err;
>                  }
>                  block =3D &(rdma->local_ram_blocks.block[reg->current_in=
dex]);
> -                if (block->offset > reg->current_addr) {
> +                if (block->offset > reg->current_addr ||
> +                    block->offset + block->length <=3D reg->current_addr=
) {
>                      error_report("rdma: bad register address for block %=
s"
>                          " offset: %" PRIx64 " current_addr: %" PRIx64,
>                          block->block_name, block->offset,
> --
> 2.54.0
>

