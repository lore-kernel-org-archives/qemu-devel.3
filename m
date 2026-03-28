Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B1C10F3DCE
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2026 13:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Teg-0001II-CM; Sat, 28 Mar 2026 09:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w6Tee-0001HR-S8
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 09:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w6Ted-0005wc-DI
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 09:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774704281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fflB0LoqGT5rH5FdMcYQPoW4h2hRiuEbN2Gfb5ipuvA=;
 b=FV1SqLGqtvU8Gag5+JvDHO9Dhl6pVyuafWVCBx4YBkGjS6qYjPOfNZwj7Q8u55etg5MnAV
 8H6wyC5on5lpkaeZ8dHgrwgrAt35QqcRDPaQcVmjerQYWzUZK21OPRQ4RxJBqoh7T3kVN2
 b4XuLSnpA4OyHkTMI5lxTxc3IJJZl84=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-HrbQuQqPN6uZT5-eDcSoyA-1; Sat, 28 Mar 2026 09:24:39 -0400
X-MC-Unique: HrbQuQqPN6uZT5-eDcSoyA-1
X-Mimecast-MFC-AGG-ID: HrbQuQqPN6uZT5-eDcSoyA_1774704272
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-67e20b838beso4844599eaf.1
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2026 06:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774704272; cv=none;
 d=google.com; s=arc-20240605;
 b=X/Drdgc/MbKa1vJtMsxx9dBdoPYrNBGrDREqchQP5Kuo66G4YOFYALs3XhTHJQfAs2
 wNwLOpN5fKpYDgadN8bHYaspCWsZ/5Y5obp1BtQeIhoOZ5v4z4QBYXhD4mriMybxfSQ9
 U5E9XAX8E29ei7Q0LwT2xVk43x4lrgi38EZtWB5PT3YJB+ubdCCUV4hJzEsAhy26k9vj
 nVAUq61YZ5iN9WVekX1B7/m/1zlQBXYwakc63lLpF3Kau8Z6XnxVlP9hFOHq2p2VgTAq
 uyia6FaWqdMFt46iSyBUgjLPWaEwJVWBJi6oh1ERUlUIyz5WrPubv0cAk4WaZnUBJVcn
 J6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fflB0LoqGT5rH5FdMcYQPoW4h2hRiuEbN2Gfb5ipuvA=;
 fh=b0JRYb2XSHjkOyAB1okxmgPcdRee2FaFVgLFFAO1nPQ=;
 b=XuvqMT8at0N88m2tLQ0NohDeoe1EMPR1DCn6OA1c64C2BgZnfvgUu1VY+3QGVcIo4O
 YNlRwH66bmXSEPNXzjBCvTvEMxNtheaTOqL/2hkMhc+E+2CqBvkEQaehSeSZm9EZzw47
 rbWfndBYdAufilV5YDCpC5ryTBo3sJc0w/3e8PQAEcfMCaKgvXzRYHu1Q6o7qxwYqHFh
 v4q87N2PpUR43xwHjIvMfuFY6siOBfmudCmFJZaQVLJQyGtfGAZzfq7PW1gxzFtHbxjw
 flsV8PH3HuYSq3cnSONxHsfMKMetlEwul7Vw8w9xmcSEFFjAYAcB6muVlGpJ8vloxUeu
 0BfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774704272; x=1775309072; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fflB0LoqGT5rH5FdMcYQPoW4h2hRiuEbN2Gfb5ipuvA=;
 b=aG9AtMivuDx+AGOu72aE1VHhGcbRuWle6NEyhCqCTH87xmRq8DaPuJQtWiZpdyvlJ0
 9g5YbOcDpOWq24wXzk/tw3zTUYb/iEJ+nrW/+Cf6h5AiGDOa2w4Qnsl+wsaR0Mod/YVt
 nRCOBzk59LDl3ORR1imLqrVsgNHgc3QwqYddaSrQ8x/+k6YeemUuoZuGwfPjusPSB+6c
 1Pltsid2O8vgeiICtu1XeJZEzm/jTw0GOgst236M5okuF9XoOeU0RjNhwxheAT7+O+O6
 mk+FUUV+zEfakvmtXvJEr2rTLksnZilnXbgkTxq4PJ384GyCzN327i7aA4ytBG88ReBM
 E+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774704272; x=1775309072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fflB0LoqGT5rH5FdMcYQPoW4h2hRiuEbN2Gfb5ipuvA=;
 b=oZuKM6I3Lsh0WNGkfS0thxzOH3iyZtAxv11DRdTlqDxuUoyCYC0lFqV84Mg2DQTjwX
 KkPfF/CM8uY4WovHfYWfO+hF7MLvgpd1O0j6g+Bb5qoIq9oGo0syjz3TkKZODJp11oy+
 XrdCOcZf8HJGpHzTBm9Eeuq/fvsCHu/1AkQsR+FuetUN2FicBSX+uP1hlu6i2DDd5t/A
 rGvu2b10QeV03G2EhyLaA5Kk0Q/wMOUp9tCfAOlWT6vt9VV7/gyv2W9QmCpdY1QL4W8N
 FabYI+Zs/p0M2DX5IyCzcHke9L4tPpF0ew5M7sHg24uBhmJHIr7Cot237Wi2ExYOTjh9
 mbxw==
X-Gm-Message-State: AOJu0YzewcOHufgl5DyZixbAo2+BmJyYS02ZLuu3hha7nB+oDSaRXXZE
 LkQnKFhnopXIxSmcyk84HkvvuukPXWnHNBB8t8DO7GMhUgOqtVhbH1aD3KynW9bym8Gnwj1e92W
 vs5yQWTOWHtDUlg6G1+Pw0L9fkKD+XZAHcwxNuh3+IHskz0CBtoqqd30Tgdl8wcHZw9wXHjzK+D
 RfXLDvYkd/zyVW6LxBxl73hJtc2I3KdO4=
X-Gm-Gg: ATEYQzyGE4dLPBO7t/GeQPrQRvsLjhx1dfSSe7NB53sP2y7DLKDqyfWavSBAE3eH7jZ
 zGoscws4wOEFnbfCcwQkAwf4YnV/9ALKrcRCIOIEP5GJ/4RCv+i/lpaKtPGkGpKiJTlQSqJdbR8
 lFnM/mHuXeBOSQCFa/zs+TD1KNXCqJFN349HPCxM4foBWPzcTdcfhjX0xN9W0yOW9Pvk1lE21FN
 AUycg15uRmrqo1IdKAtN2EPc9UtU62BO+9eV+g=
X-Received: by 2002:a05:6820:99c:b0:67b:c9fa:c310 with SMTP id
 006d021491bc7-67e187726b3mr3236775eaf.68.1774704272622; 
 Sat, 28 Mar 2026 06:24:32 -0700 (PDT)
X-Received: by 2002:a05:6820:99c:b0:67b:c9fa:c310 with SMTP id
 006d021491bc7-67e187726b3mr3236762eaf.68.1774704272205; Sat, 28 Mar 2026
 06:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260327173209.148180-1-mbawa@redhat.com>
 <20260327173209.148180-4-mbawa@redhat.com>
 <6cb600f2-5f0a-4b77-a972-967deee93698@linaro.org>
In-Reply-To: <6cb600f2-5f0a-4b77-a972-967deee93698@linaro.org>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Sat, 28 Mar 2026 18:54:16 +0530
X-Gm-Features: AQROBzBmSFlATYcnLAcRiQFiM4WP6_UUedUQsRD0g6DmrsirwT9xV1se8F0Ej2c
Message-ID: <CAJg9KkybpR9X3xELr6mM5j1VMAC_61wPfq=dUS7Ug_xSqvd7uQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] hw/tpm: add PPI support to tpm-tis-device for
 ARM64 virt
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com, 
 pierrick.bouvier@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>,
 imammedo@redhat.com, 
 anisinha@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com, 
 qemu-arm@nongnu.org, mohamed@unpredictable.fr, 
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Mar 28, 2026 at 5:17=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi,
>
> On 27/3/26 18:32, Mohammadfaiz Bawa wrote:
> > Add PPI memory region and ACPI _STA, _DSM to tpm-tis-sysbus so
> > Windows 11 ARM64 guests no longer log Event ID 15 errors from
> > tpm.sys on every boot.
> >
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> > ---
> >   hw/arm/virt-acpi-build.c |  9 ++++++++-
> >   hw/tpm/tpm_tis_sysbus.c  | 11 +++++++++++
> >   2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 591cfc993c..5b5ac551f8 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -240,7 +240,8 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachi=
neState *vms)
> >       Aml *dev =3D aml_device("TPM0");
> >       aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> >       aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device"=
)));
> > -    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> > +    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> > +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> >
> >       Aml *crs =3D aml_resource_template();
> >       aml_append(crs,
> > @@ -248,6 +249,12 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMach=
ineState *vms)
> >                                     (uint32_t)memory_region_size(sbdev_=
mr),
> >                                     AML_READ_WRITE));
> >       aml_append(dev, aml_name_decl("_CRS", crs));
> > +
> > +    hwaddr ppi_base =3D platform_bus_get_mmio_addr(pbus, sbdev, 1);
> > +    if (ppi_base !=3D -1) {
> > +        ppi_base +=3D pbus_base;
> > +        tpm_build_ppi_acpi(TPM_IF(sbdev), dev, ppi_base);
>
> Matter of style, I'd rather:
>
>             tpm_build_ppi_acpi(TPM_IF(sbdev), dev, pbus_base + ppi_base);
>
> > +    }
> >       aml_append(scope, dev);
> >   }
> >   #endif
>
> Hmm I see in tests/qtest/bios-tables-test.c that test_acpi_tcg_tpm()
> only tests X86 (Q35). Could you see how to add coverage for Aarch64
> virt machine? (It could be a patch on top, no need to repost a v4).
>
> Otherwise,
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Noted, and I'll look into adding tests aarch64 virt coverage as a follow-up=
.

Thanks,
Faiz


