Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA4DC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 15:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNCBM-0004c5-Kd; Thu, 05 Jun 2025 11:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNCBG-0004bP-JB
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 11:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNCBE-0004pB-G9
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 11:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749136014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCmbn3bXFc6eaxQpCWgIgPAm9Gh9CuCqYgzbBDu09yo=;
 b=ZUtXhLyDFrW/4XymmiM50b5ZYvUBQFFSxcfsr6D7/uY9fQJyon0Z1Im35kY2BhexvGRm78
 UTNDqOAGNRAQpTKhZJPzbsx7G3fGCanaQ6vC7JLLgcUpXiUfutvbaueGUnPzBKdezk6j6P
 z7UFHJEisXn3i8eoR516bWWrkaxXoy8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-3EPPQQdeN3iizYYdnt4B_Q-1; Thu, 05 Jun 2025 11:06:52 -0400
X-MC-Unique: 3EPPQQdeN3iizYYdnt4B_Q-1
X-Mimecast-MFC-AGG-ID: 3EPPQQdeN3iizYYdnt4B_Q_1749136011
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-551fe205635so446393e87.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 08:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749136011; x=1749740811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LCmbn3bXFc6eaxQpCWgIgPAm9Gh9CuCqYgzbBDu09yo=;
 b=N7kyfhlUuSvawKVmAwMgiSt1TrAD9HHVA/dVzSqLpY6g080pwvsFm8MoKRfLtccVRZ
 GJCRHjCPTDZRMIR09fKHMwiLukWDU/QzeIgSNNrXizeJNa92xzl3XxCE18R/4O98vvbH
 PNj1YCH7HvlbFI1x//bhHLUZMsJl3S4GzDoKTgFieQddl0ceMUJVufZ+4eWiwXvqmjf8
 KkjSSIHI0t+aEQa8wW7T/FwEgYr42bzKqzmE7VRyjEEjElpkrwPG0tsmA9w8wXpKnDXI
 3b0TEjEE2keoOcdKOl4slJLcWpvWEqpOAG9h7KThB5JwZgC3sYZf/07iYJyuXxQaL46G
 15ow==
X-Gm-Message-State: AOJu0Yymac7Rt1Tvn/OyOFvaUiJmgyAlg2cP5uwOHOM2W1/lJtaaFyc2
 TxGROb6FqEpmR3a738zk8RJXBdLYt3N3i5pB8R7onTunXJu6vX/S+uYdV7EnN9j3IvQ+TSU2W4O
 nK17b4u6K8CWchPzMzeej80Fp6EF1/iQJukP9Pcq2KejSnCJsul2upel3
X-Gm-Gg: ASbGncsqlfVv1A7pSb2nbO3RlBo3dsEJK+XpkD9/XccvJ7fAYq3BOpBUDSaAKwkUqGc
 2xQ5poqUD0i+K3pxWVVJxhLaMx66S1qJpP+EAlJr877B7gBYT4qeP98fbkfigHCiVV9B/xirie1
 L9fBtaJoeW7Cta7YQD/xkxJyPhnNK1AhrP1dPsYvwbIQXBng69eluL+4QcYe03sn/ZOR4kwNXct
 JlzHW5Hz2WxOzUTFQ9CDR5y8bcXTJr2JITjVSO3JABUC1z5RbiBqAYZ+NH2ippgW/spoqrvUcyM
 Z01Lc1wkHzUCVHZVDJAXow94fPGOw2qg
X-Received: by 2002:a05:6512:3b06:b0:550:e648:182a with SMTP id
 2adb3069b0e04-55356df2dadmr2157580e87.55.1749136010590; 
 Thu, 05 Jun 2025 08:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG+ePqDrviip98yey1vJxRxmMKtzPJ4ht0aGtb/La5aXLP/cGPGJSTAzDLsVEGpp4iaTv3sw==
X-Received: by 2002:a05:6512:3b06:b0:550:e648:182a with SMTP id
 2adb3069b0e04-55356df2dadmr2157504e87.55.1749136009681; 
 Thu, 05 Jun 2025 08:06:49 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451fb178895sm22062935e9.14.2025.06.05.08.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 08:06:48 -0700 (PDT)
Date: Thu, 5 Jun 2025 17:06:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 06/18] hw/block/pflash: Remove
 PFlashCFI01::old_multiple_chip_handling field
Message-ID: <20250605170647.7b9fe533@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-7-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-7-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  1 May 2025 23:04:44 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The PFlashCFI01::old_multiple_chip_handling boolean was only set
> in the hw_compat_2_8[] array, via the 'old-multiple-chip-handling=3Don'
> property. We removed all machines using that array, lets remove that
> property and all the code around it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/block/pflash_cfi01.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 168101d8dfe..bba099a0c9e 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -84,7 +84,6 @@ struct PFlashCFI01 {
>      char *name;
>      void *storage;
>      VMChangeStateEntry *vmstate;
> -    bool old_multiple_chip_handling;
> =20
>      /* block update buffer */
>      unsigned char *blk_bytes;
> @@ -703,13 +702,8 @@ static void pflash_cfi01_fill_cfi_table(PFlashCFI01 =
*pfl)
>       * in the cfi_table[].
>       */
>      num_devices =3D pfl->device_width ? (pfl->bank_width / pfl->device_w=
idth) : 1;
> -    if (pfl->old_multiple_chip_handling) {
> -        blocks_per_device =3D pfl->nb_blocs / num_devices;
> -        sector_len_per_device =3D pfl->sector_len;
> -    } else {
> -        blocks_per_device =3D pfl->nb_blocs;
> -        sector_len_per_device =3D pfl->sector_len / num_devices;
> -    }
> +    blocks_per_device =3D pfl->nb_blocs;
> +    sector_len_per_device =3D pfl->sector_len / num_devices;
>      device_len =3D sector_len_per_device * blocks_per_device;
> =20
>      /* Hardcoded CFI table */
> @@ -765,7 +759,7 @@ static void pflash_cfi01_fill_cfi_table(PFlashCFI01 *=
pfl)
>          pfl->cfi_table[0x2A] =3D 0x0B;
>      }
>      pfl->writeblock_size =3D 1 << pfl->cfi_table[0x2A];
> -    if (!pfl->old_multiple_chip_handling && num_devices > 1) {
> +    if (num_devices > 1) {
>          pfl->writeblock_size *=3D num_devices;
>      }
> =20
> @@ -930,8 +924,6 @@ static const Property pflash_cfi01_properties[] =3D {
>      DEFINE_PROP_UINT16("id2", PFlashCFI01, ident2, 0),
>      DEFINE_PROP_UINT16("id3", PFlashCFI01, ident3, 0),
>      DEFINE_PROP_STRING("name", PFlashCFI01, name),
> -    DEFINE_PROP_BOOL("old-multiple-chip-handling", PFlashCFI01,
> -                     old_multiple_chip_handling, false),
>  };
> =20
>  static void pflash_cfi01_class_init(ObjectClass *klass, const void *data)


