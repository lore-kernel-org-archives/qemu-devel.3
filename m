Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7837CAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy4sl-0006Lq-Ik; Mon, 15 Sep 2025 04:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uy4si-0006Kw-7Z
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:48:16 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uy4sY-0002xu-Ms
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:48:16 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b07dac96d1eso328270266b.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 01:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1757926076; x=1758530876; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hi2+vqVRE+fas/Ib6/fubveYjHYqVt/mgNpODWXzoYc=;
 b=NY8O/28dy4cdep4WSWzdoJmp7kL6FkIkwqFTOzxEKCImUl79p5Hqjoxbgc44JeM9aE
 1rP1ZQmm65NxI9NviCU76fqOInfgwdqQc0Qnq292LmgxANPwPK5jL2QrHkgTZoZMu8ys
 +nrpeUxMMVMDmnHHKaxigl/ECzEuPqZhCACQOzfBsk1Pf+D9x+6Z+0VQNtHPg+BQuwaC
 bj5Rn8uYxWtNlI18nyCSPFjkLBZ72A4sfuY/tClV4pApXlUP5PrGIFaqycqxxHxvo+Mn
 bSInm4E9AuDL67tgKtV3bjMjKDNQ6VbpR8YHe/ZhL+S59y6IkjIix/DxRIB2clAof0/Y
 xjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757926076; x=1758530876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hi2+vqVRE+fas/Ib6/fubveYjHYqVt/mgNpODWXzoYc=;
 b=ZJhlT2XGZTC+37Sal9RsTSfsnPa2q55nwY5ZXpC+0FM4+zW3Yy769QTxcHR8DkgEDo
 S3d277uxpMZTtiX8ltzadnt3r4avbdF8XboPLpS+rkil9M45yvVc7PeLpGc1ueuf/I1v
 mECEblfg9gv1obA6a0TE999uLjSWyxX6JvRSTDYcioBGZtHSoON7PjaNrB2jGqh74UmC
 Qg6vXauzfZ1iFH+dQ2E0VFYjWIaRjsu/6Vuy8U8lFLVYwRVzVd/iJXxKpIpYsqfti0rI
 IXJyGedeqi41l7DUxQkqQzNuXu4ckb0nvyEl717OrU4ArprToOJVzjRrIty8/1Yxs0Do
 ieWQ==
X-Gm-Message-State: AOJu0YxwYM97ZyTNLC7R2gUB4R4RkrfvrHmcTPdppNq8UzBqOzw41eX8
 TEJUr0wN1XYvE6yoAU3ENOix0HwxgRxdlvIFA4+/2vNXrK/1K3QDjVghxIGO1s6HrvcBLlvYhtl
 XcvH24Lf3iZ79yKcjStU7oT+bC78jnGkyOShNE5Br/NkmGFec+cc=
X-Gm-Gg: ASbGnct9Iv+6nmGPINsVnjffMW9F+4ogiAF1XRvlWIyc27CnaiUnkwzAC5rPvmWZXKC
 W+/6UpuRfx19J7Hf+D588y7SM682KRNzHJkpX490o2bbhAL5FchETVVVf71mcT2CGqjZhBy8JWn
 yLRNpn0iyliH2Sz1HZ2UO3FTUnsZmBFmMloNCJKOXQVwbVhoQFTfccRhkO5YlUJ8e/v1gW+Yk5Y
 OBEnPk=
X-Google-Smtp-Source: AGHT+IG8E6lrElemxsqiu/7KVZFiOcXhhbZC/BjE8XX4uyr85kY5Co4gfFS55aP6nlG67UDKPZNQVGKSwbTon46dsQ8=
X-Received: by 2002:a17:907:7ba5:b0:b04:3b97:f972 with SMTP id
 a640c23a62f3a-b07c22b1dd1mr1376574566b.3.1757926075688; Mon, 15 Sep 2025
 01:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250903075721.77623-1-chigot@adacore.com>
In-Reply-To: <20250903075721.77623-1-chigot@adacore.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 15 Sep 2025 10:47:43 +0200
X-Gm-Features: Ac12FXyK7KEAUHRtRSVw866YByJEzdBA9RKDc3-_vF4iGYlGU5R3IiHn9_36zjs
Message-ID: <CAJ307Eie3hmjzYkKQgtHtzmZnOTK3oyB4PAE91bJ0OFTet8QhA@mail.gmail.com>
Subject: Re: [PATCH 0/5] block/vvfat: introduce "size" option
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x62d.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 3, 2025 at 9:57=E2=80=AFAM Cl=C3=A9ment Chigot <chigot@adacore.=
com> wrote:
>
> The main goal of this series is to introduce a new option "size" within
> the vvfat backend (patch 5). It allows more control over SD cards' size.
> The value for "Number of Heads" and "Sectors per track" are based on SD
> specifications Part 2.
>
> This series also includes minor patches:
>  - patch 1 introduces another option to remove the Master Boot Record
>    (this is mandatory for QNX)
>  - patch 2-4 are minor improvements easing the introducing of "size"
>    option
>
> This was tested on with a aarch64-linux kernel taken from
> functional/aarch64/test-virt and on aarch64-qnx over raspi4b with a
> workaround, not included here (the SD bus must be associated to the EMMC2
> port instead of through GPIOs).

Gentle ping for this series.

TIA
Cl=C3=A9ment

> Cl=C3=A9ment Chigot (5):
>   vvfat: introduce no-mbr option
>   vvfat: move fat_type check prior to size setup
>   vvfat: add a define for SECTOR_SIZE
>   vvfat: move size parameters within driver structure
>   vvfat: add support for "size" options
>
>  block/vvfat.c | 279 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 213 insertions(+), 66 deletions(-)
>
> --
> 2.34.1
>

