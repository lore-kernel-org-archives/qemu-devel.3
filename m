Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0840C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5zo-0000oa-3X; Tue, 21 Jul 2026 04:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wm5zm-0000nE-Lh
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:38:34 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wm5zk-0004Ft-Sy
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:38:34 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-81dfdbd86d1so71512607b3.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784623112; cv=none;
 d=google.com; s=arc-20260327;
 b=fogQPfO0+qB873x+ymfTzZNcP8a9Hz33GK6t9vCjVnz8n/jPMJ3MUNKPqtRGlegc7f
 zrlb3tTFXYch5g2Vglv8X+YsDToe4pV4SpKwzNOQNJPjKh0KwHUYDQCKWnMH/ADKYLIG
 BcNX7aJzG6XgHjrNAEHlksQf5Ka09U1NFR0c2GshoHfVOMKnHLuuhzZaGP3+4Sxnk9MH
 4fo4cng5ZkZL061OmbU9phxSEu6ElwCtd6qET3bxzxO55XZzP2aQ/mgzMHcWz2qtwb6m
 uV7cmc+yx3XV6OI6f+z7qVMEBFdMGgkrN1J1utsEOMj9SRVzLTXS3UUIXGImWJrM2M5E
 euxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=//AqVLoTIzw5dq3OJkoBpFoqrZfnZ00hc9yWX6A7T94=;
 fh=MObVK6jyoheTNC93lvrqcrncRVan99RdZ2q9B0zA5tk=;
 b=W/k3nXRqonTrSYm0V6EpquRbN8giFnLMTNlo/dmwp+YsbzcLPnx/ItGvTf5SVlpCZq
 tjIfNXfVKx1UI38GmyXOAGdwBjWGCSqsuTyEUtcrFYdmr0joiDHCe5Mqc4RqEnQ8iJF/
 sdbEAPH7US+cljE39cHEjwmhYlXqd0dY9eg9NpAbuVRttEtZez+0B+qMiLtCRfUBNA7n
 7dBV95NqjGHar3jw/eHI4Ra58ORPy5u7rI3OURJ4Es8dJHy6Rq7ZawFuQqQtnPHoMmSE
 DQABNiHwyFWyen2B9iE6wgCvGIMqhoiFZNe9GZogYsWjHlpojJsNaDwHm3R7ZK2B11Hb
 ojDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784623112; x=1785227912; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=//AqVLoTIzw5dq3OJkoBpFoqrZfnZ00hc9yWX6A7T94=;
 b=nPs5D0J/UI4YLR0myar4ob1DXHCLPI68dsG7CkiigBtUxYRbgT7D9BsfJ+R6CE9zYb
 fur0giE5GHsKteu69aVRpJvvvB6XZNMyQaI5Wk5DrmHNSEEX0X8zPl6MiV4rI4msq16x
 xTK4rbCTw9tNyi0cmqHWyjDaNIzGkNIbPxX2uA7sa9m3/u1hq3N80ZHaoTXK3NMknRu1
 qPk6ZQ3PzXneoJ0oTQETimoqfQR5mCMA5B5Deuurweskllvd47EjeOF1umLbm291tFew
 G8YM8p0pSVdH4CR0dpZOC8B1Ngrcge55Zzd+s+HKH4cc3ToZtu5P+WaJBThr5R9Y6UOw
 0nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623112; x=1785227912;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=//AqVLoTIzw5dq3OJkoBpFoqrZfnZ00hc9yWX6A7T94=;
 b=bxTQcGfe0zVR9HWF/TqBK16XTMbnl1qLBVRBg2fMSdQMs3MSvqXU+bCRdUzIp/hLhC
 JAneJJOjdKTdIjfd9ao2VOYN/CuPZxO/0Qk3pIj3d8qmfhHdsDhRX1F2wuu4ZACSiTY/
 W1LMLv1xsWMV2Jb55wjHuHypu6PQSPBePBHnFCIujcKHXkicpchoKB8l2XJSkara1d+r
 BEC9/Sd+aCRC43yTVrZL9NR281zjbSZXMptjUQ9YtNrKBA5UZ2K9l2U/PB/JJTguM6HO
 aQR12QJtBj2SDwAGkO2bp5DFPl2NBam5OO68eCWUxT2B7DEbICqUC/Tlf+gZHA4mYBis
 +T1w==
X-Gm-Message-State: AOJu0YzTeexXjvHsrofZo9vsBFJBt8QdmKCE13WiMQRII4ZTm3FTqYfV
 2Cds5iTpMtqGXyiS/ROuH8TjPLuiq6gdZYyMwPCdA7JH/zLUuELp3HKe6Sq8O+hNL7bpfO9IxR2
 Cw0JPUsfgkcpxLhmEAKNvSXNuQ27Elhc=
X-Gm-Gg: AR+sD10tTHjW1OzXd/fqGrAWI1yyyZjdcc1ohqUN04/zEWRZqUlRIVJmUKhY6NR5Hxi
 DeYo+y/eP02Oa0nwOOYpu06dZNNo0HtflIi2/NKybgx1OBDuhIEPyL20Y9MGNF74BVd2L4qLPSL
 Q57va28OQQIkAyDKxAzBjXP8uO5Jxng2r4av/xRDyebLZcPHkCjnkZpl+a7wX5oTA6K4E7kbjMX
 MDV7p1M7LRJsHHUpo0dRjhKAf8GoIGmC3grg68UIL6Qxr55Yr2ke9hDwSCKGCFP1e9SKrDBrA==
X-Received: by 2002:a05:690c:9c09:b0:810:c988:1d36 with SMTP id
 00721157ae682-81ef2603ab1mr56187517b3.54.1784623111704; Tue, 21 Jul 2026
 01:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260719211923.1079282-1-shentey@gmail.com>
 <20260719211923.1079282-3-shentey@gmail.com>
 <CAEUhbmWhqc+_7MQA3Y9ZG9vwBjsbE4-w3tsx7Ep1CbBHze3Mcw@mail.gmail.com>
 <897E12B2-A6E5-4524-9983-FA861A7FDDD3@gmail.com>
In-Reply-To: <897E12B2-A6E5-4524-9983-FA861A7FDDD3@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 21 Jul 2026 16:38:19 +0800
X-Gm-Features: AUfX_mzWMHT67oMTuyZHWSAuIp4LGFTWVkWwpagv9zpsCzFiib25A6vyLvwSmYY
Message-ID: <CAEUhbmXT9ajeFMz8_1GsCWZJU-FmkYXTPZd-pfYQ2A45Qm7hFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sdhci: Extract uSDHC-specific quirk
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1129.google.com
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

Hi Bernhard,

On Tue, Jul 21, 2026 at 5:11=E2=80=AFAM Bernhard Beschow <shentey@gmail.com=
> wrote:
>
>
>
> Am 20. Juli 2026 14:50:24 UTC schrieb Bin Meng <bmeng.cn@gmail.com>:
>
> Hi Bin,
>
> Thanks for yor reviews and R-b tags!
>
> >On Mon, Jul 20, 2026 at 5:19=E2=80=AFAM Bernhard Beschow <shentey@gmail.=
com> wrote:
> >>
> >> In Linux, the ESDHC_MIX_CTRL qirk is guarded by esdhc_is_usdhc() while
> >> the eSDHC code path uses the standard SDHC interface. Extract the quir=
k
> >> into a new `usdhc_write()` function.
> >>
> >> Fixes file system corruption on emulated i.MX53 where Linux'
> >> esdhc_is_usdhc() returns false. The same likely happens on e500 and
> >> imx25-pdk machines.
> >>
> >> Fixes: 75e98bc4f859 ("hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE")
> >> cc: qemu-stable
> >> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> >> ---
> >>  hw/sd/sdhci.c | 73 +++++++++++++++++++++++++++++++-------------------=
-
> >>  1 file changed, 44 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> >> index c86dfa281f..e58a610397 100644
> >> --- a/hw/sd/sdhci.c
> >> +++ b/hw/sd/sdhci.c
> >> @@ -1795,34 +1795,6 @@ esdhc_write(void *opaque, hwaddr offset, uint64=
_t val, unsigned size)
> >>          sdhci_write(opaque, offset, value, size);
> >>          break;
> >>
> >> -    case ESDHC_MIX_CTRL:
> >> -        /*
> >> -         * So, when SD/MMC stack in Linux tries to write to "Transfer
> >> -         * Mode Register", ESDHC i.MX quirk code will translate it
> >> -         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
> >> -         * order to get where we started
> >> -         *
> >> -         * Note that Auto CMD23 Enable bit is located in a wrong plac=
e
> >> -         * on i.MX, but since it is not used by QEMU we do not care.
> >> -         *
> >> -         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
> >> -         * here because it will result in a call to
> >> -         * sdhci_send_command(s) which we don't want.
> >> -         *
> >> -         */
> >> -        s->trnmod =3D value & UINT16_MAX;
> >> -        break;
> >> -    case SDHC_TRNMOD:
> >
> >Looks like this register is not eSDHC specific?
>
> Not quite sure what you mean exactly. The SDHC_TRNMOD isn't eSDHC specifi=
c but as per the comment above trnmod partial handling is deferred here, i.=
e. needs to be intercepted.

If I read the Linux driver correctly, I think we should do something
like below when writing to SDHC_TRNMOD:

  case SDHC_TRNMOD:
      if (is_usdhc) {
          val |=3D s->trnmod;
      }
      sdhci_write(opaque, offset, val, size);
      break;

Because for eSDHC, the transfer mode is already passed in the value,
and oring previous s->trnmod may cause some bits being set to old
previous value unexpectedly. Please double check.

>
> >I looked at linux
> >driver source codes and suspect we may need some more turning here
> >other than uSDHC only.
>
> Yeah, there is certainly a lot of room for improvement. I have some clock=
-related and SDMA buffer boundary patches in the pipeline which are necessa=
ry for satisfying U-Boot. But that's a story for another day.
>
> Best regards,
> Bernhard
>
> >
> >
> >> -        /*
> >> -         * Similar to above, but this time a write to "Command
> >> -         * Register" will be translated into a 4-byte write to
> >> -         * "Transfer Mode register" where lower 16-bit of value would
> >> -         * be set to zero. So what we do is fill those bits with
> >> -         * cached value from s->trnmod and let the SDHCI
> >> -         * infrastructure handle the rest
> >> -         */
> >> -        sdhci_write(opaque, offset, val | s->trnmod, size);
> >> -        break;
> >>      case SDHC_BLKSIZE:
> >>          /*
> >>           * ESDHCI does not implement "Host SDMA Buffer Boundary", and
> >> @@ -1891,9 +1863,52 @@ static void fsl_esdhc_le_init(Object *obj)
> >>      qdev_prop_set_uint8(dev, "sd-spec-version", 2);
> >>  }
> >>
> >> +static void
> >> +usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> >> +{
> >> +    SDHCIState *s =3D SYSBUS_SDHCI(opaque);
> >> +    uint32_t value =3D (uint32_t)val;
> >> +
> >> +    switch (offset) {
> >> +    case ESDHC_MIX_CTRL:
> >> +        /*
> >> +         * So, when SD/MMC stack in Linux tries to write to "Transfer
> >> +         * Mode Register", uSDHC i.MX quirk code will translate it
> >> +         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
> >> +         * order to get where we started.
> >> +         *
> >> +         * Note that Auto CMD23 Enable bit is located in a wrong plac=
e
> >> +         * on i.MX, but since it is not used by QEMU we do not care.
> >> +         *
> >> +         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
> >> +         * here because it will result in a call to
> >> +         * sdhci_send_command(s) which we don't want.
> >> +         *
> >> +         */
> >> +        s->trnmod =3D value & UINT16_MAX;
> >> +        break;
> >> +
> >> +    case SDHC_TRNMOD:
> >> +        /*
> >> +         * Similar to above, but this time a write to "Command
> >> +         * Register" will be translated into a 4-byte write to
> >> +         * "Transfer Mode register" where lower 16-bit of value would
> >> +         * be set to zero. So what we do is fill those bits with
> >> +         * cached value from s->trnmod and let the SDHCI
> >> +         * infrastructure handle the rest
> >> +         */
> >> +        sdhci_write(opaque, offset, val | s->trnmod, size);
> >> +        break;
> >> +
> >> +    default:
> >> +        esdhc_write(opaque, offset, val, size);
> >> +        break;
> >> +    }
> >> +}
> >> +
> >>  static const MemoryRegionOps usdhc_mmio_ops =3D {
> >>      .read =3D esdhc_read,
> >> -    .write =3D esdhc_write,
> >> +    .write =3D usdhc_write,
> >>      .valid =3D {
> >>          .min_access_size =3D 1,
> >>          .max_access_size =3D 4,
> >> --

Regards,
Bin

