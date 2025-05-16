Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B7DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFid7-0001J9-95; Thu, 15 May 2025 20:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFicv-0001IM-Ay; Thu, 15 May 2025 20:08:38 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFict-0002k1-Er; Thu, 15 May 2025 20:08:36 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22e033a3a07so16477915ad.0; 
 Thu, 15 May 2025 17:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747354113; x=1747958913; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1ffQyjb4sxGs3rfLUNoaNEhYFnUihuLVIyEEra1qpQ=;
 b=d5yhn3HsoXBEbxZ7lbtNx3V2yGp+8ylhagaxVYshBOHO4BEDHEDIjtZy52UK6Pr2H+
 8jd1vs6NaDDOCC1NMaT3iDWVzkdIN4TsKecm/XwPDHJY2McWMv7xXAwhCW71wmi77Oru
 00Bbiwemq4UwVva2IA8gl7LDlZnmqfZdHj1nyrGK+T563dh0noOAlsZI51d7m9KJAG1Z
 LP9UJ2Q7hbJjJ+daNd1WiNTjQg9r2jep8BoMw/vpSEKjMqHE6CWBtAEt+f7Oc/6L1Zj4
 vVkN9ZmuN+oYkBLKieS9X5m04PuIfyzlyBMiWWIyEkuQlhS2135NhIye38UqSvZ4rcnC
 w7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747354113; x=1747958913;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n1ffQyjb4sxGs3rfLUNoaNEhYFnUihuLVIyEEra1qpQ=;
 b=A0nM/eKN5FlidObsGDr3NlqAj2OrMgWrM3I9bfpHBcHohOJPU2/fHsZzpUowZIWuFR
 A7z6cGJFEKHCqVtivQxgcaFp+htXuracRLLUfm9C6HoCCydGIwHeXrMO71HO4O6rvUK8
 LwYXUYGSXmqSqB0BRHgHLeZK2r2riojGX/evydrcbOGaH966jzr4wR5SKybdHDE1r/E5
 +e+qLPDi5pLhk8yRuDZuELAcQPQhUBJ9kNv4Qet+o9oCSAQ3BvUWDejyzC8h89+YF2nH
 ht4inJC1InH+Zarc2uCxxWtHrZQ/ysrEbLofhXRVFuGRmVbLSmgkkd0HB5ophFfOddC9
 aMhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8mEcNUO2H9nrHBf+pGcjS5kGibFA4+yzBnACOvUudAt6oM0zGg+u4XGUHQnJZ/G0LQVhlXgHGIg==@nongnu.org
X-Gm-Message-State: AOJu0YxodvsAxFaHOvsWknSTcwBqHJzKRUvNxA8WRdveGOfG1BW+NCKO
 mKAjK2tGr4noUJLL8ksLcuTgW362IyNlZur62OwM5D1wY3IfHCo8rBfW
X-Gm-Gg: ASbGnctxVHz/4lJ2LPwJQnK4OYMVRKr8/4XB5buLGYglHT4/xG7VdYWBtzhnZBRqV+G
 UUfvOrndbsYPAc5Y36cmVw2t84o2w12sEeCNcveGRM/T+Dlnd59DdGf3mKHNzLSDOpMMVskWjs7
 KDutQOeufIhrHHXKAu3ic2aFflj51fa8ud9uaZjWDw3qHY9zEiNye3/SIZp2kKJSYS3ZQRr8TYW
 ovqaWDvEiia0KNPFYwylBQjMYsf3DpOh9quuBxxIY/wsEBGV0WfsDjW7jJO+4zMORiOOWBunGre
 oEUaCAUhD1YIYlC7Vecmv4IgK0hvoLC+8xaj3N9+SzL5k48=
X-Google-Smtp-Source: AGHT+IEpwaMPdqwbJbDzslTO/q2ZaUYKXLT0FBj93BeP91Bu3dLm11hvlCd9C+C9mLDTfL4x2STY/g==
X-Received: by 2002:a17:902:e80c:b0:231:ba23:c7e5 with SMTP id
 d9443c01a7336-231d43d9be2mr12543125ad.6.1747354113215; 
 Thu, 15 May 2025 17:08:33 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ac95e1sm3561905ad.20.2025.05.15.17.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:08:32 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:08:27 +1000
Message-Id: <D9X5C373LP1G.2BNWFRJYOY8UR@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 04/50] ppc/xive2: Remote VSDs need to match on
 forwarding address
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-5-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-5-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon May 12, 2025 at 1:10 PM AEST, Nicholas Piggin wrote:
> From: Michael Kowal <kowal@linux.ibm.com>
>
> In a multi chip environment there will be remote/forwarded VSDs.  The che=
ck
> to find a matching INT controller (XIVE) of the remote block number was
> checking the INTs chip number.  Block numbers are not tied to a chip numb=
er.
> The matching remote INT is the one that matches the forwarded VSD address
> with VSD types associated MMIO BAR.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  hw/intc/pnv_xive2.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index d1713b406c..30b4ab2efe 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -102,12 +102,10 @@ static uint32_t pnv_xive2_block_id(PnvXive2 *xive)
>  }
> =20
>  /*
> - * Remote access to controllers. HW uses MMIOs. For now, a simple scan
> - * of the chips is good enough.
> - *
> - * TODO: Block scope support
> + * Remote access to INT controllers. HW uses MMIOs(?). For now, a simple
> + * scan of all the chips INT controller is good enough.
>   */
> -static PnvXive2 *pnv_xive2_get_remote(uint8_t blk)
> +static PnvXive2 *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr=
)
>  {
>      PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
>      int i;
> @@ -116,10 +114,22 @@ static PnvXive2 *pnv_xive2_get_remote(uint8_t blk)
>          Pnv10Chip *chip10 =3D PNV10_CHIP(pnv->chips[i]);
>          PnvXive2 *xive =3D &chip10->xive;
> =20
> -        if (pnv_xive2_block_id(xive) =3D=3D blk) {
> +        /*
> +         * Is this the XIVE matching the forwarded VSD address is for th=
is
> +         * VSD type
> +         */
> +        if ((vsd_type =3D=3D VST_ESB   && fwd_addr =3D=3D xive->esb_base=
) ||
> +            (vsd_type =3D=3D VST_END   && fwd_addr =3D=3D xive->end_base=
)  ||
> +            ((vsd_type =3D=3D VST_NVP ||
> +              vsd_type =3D=3D VST_NVG) && fwd_addr =3D=3D xive->nvpg_bas=
e) ||
> +            (vsd_type =3D=3D VST_NVC   && fwd_addr =3D=3D xive->nvc_base=
)) {
>              return xive;
>          }
>      }
> +
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                 "XIVE: >>>>> pnv_xive2_get_remote() vsd_type %u  fwd_ad=
dr 0x%lX NOT FOUND\n",
> +                 vsd_type, fwd_addr);
>      return NULL;
>  }
> =20
> @@ -252,8 +262,7 @@ static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, ui=
nt32_t type, uint8_t blk,
> =20
>      /* Remote VST access */
>      if (GETFIELD(VSD_MODE, vsd) =3D=3D VSD_MODE_FORWARD) {
> -        xive =3D pnv_xive2_get_remote(blk);
> -
> +        xive =3D pnv_xive2_get_remote(type, (vsd & VSD_ADDRESS_MASK));
>          return xive ? pnv_xive2_vst_addr(xive, type, blk, idx) : 0;
>      }
> =20


