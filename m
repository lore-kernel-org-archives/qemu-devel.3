Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B11E63F38
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 08:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrttq-0001lU-OL; Mon, 16 Feb 2026 03:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vrtti-0001lA-Qd
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:24:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vrttg-0004D4-2u
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771230238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gIJ+Ki4105TTSmqKP8RwVFEak2/83YrsD5ecQqd2O/s=;
 b=FIlOdfINIUFjJZ8vIeZJcWIr0XTmQJ6vujCyszbAG7fen1uNjPDCe1ol6ZqrB9BwKV1R7B
 6bNz1rjuTnT32ya4ynzOaPpd4vQRsGEWEOw0PZCvK08JhayPVIu/BCLmfGfJuNINtVTSjZ
 IOz3KkdrJ8aFvbEsjW2d3U4CRp5xtNs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-aFegiYxYNKCoqafpr6hUng-1; Mon, 16 Feb 2026 03:23:56 -0500
X-MC-Unique: aFegiYxYNKCoqafpr6hUng-1
X-Mimecast-MFC-AGG-ID: aFegiYxYNKCoqafpr6hUng_1771230235
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8966c2b187bso281314816d6.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 00:23:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771230235; cv=none;
 d=google.com; s=arc-20240605;
 b=WcQgC40+kTyvEG5G99br3zW0+DTZfKK+Xg2qohGQZMHW+71B/ghQw9FTmZocQARbZk
 fNzuHIjHGiXAdJjI8ubrOPGh6FGilXmLSd/aPckSFBWB0/q1qDIESjgwLmIUgS8+Z8Fl
 hzEnGEpyf+Lnp8yT0RQQZoj7ZYOXjqlmmTk5yz+34QRHQSX0j/7hjvX3hlNXNL36iWMB
 oj+EarUasz0sTy/8vyxoATVTY5LQNRHi6hSb2PZdSz2bR9qESR7XnG62if58Y5+0fGfV
 dEXdu3hg6kc7f6wR4yvpAISwarMfnmZyPSPYjFfEPYWukT5w4/heIUJ1KdorHnLs9CIb
 dDkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gIJ+Ki4105TTSmqKP8RwVFEak2/83YrsD5ecQqd2O/s=;
 fh=sIsIOvEHAUniTyi3GhO91uUMlcdX4avqzqeMhQBuOOs=;
 b=iJvaBo3ipqJ2+pae8x6V9RJZATMlT8ZnvMuQmF9IGQHelZS/h6GvBdxypy2O/ExxXK
 Scev0xWXiXUulJQbvF85uB6b2XVwIWJ/a2eHz8uG/5wcShAclmaEj3f8X54act/9miHm
 aKfQ3IpQ5/IM0+Sva/Rci99DSCun48YNZksXWHdxqYJ59YX234cybxEbM/BbOgquytSr
 svk9N3UiPZzgwQyowN9mMJfTABRPVFjfltS89GOisOPeVD8wIMLis+3Ri7FmIAqbJe5N
 3PDGzU6HVU9Qa6tYdOvO9YAwt65Tc0tAjbjeU4Z+/UKbv9GYzyVh6qol7Hrvv0wHHHUy
 dqTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771230235; x=1771835035; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIJ+Ki4105TTSmqKP8RwVFEak2/83YrsD5ecQqd2O/s=;
 b=QKi+e73xrx+q1x7Ug/9MXhyQAhOQj++8YoZqJvgEwkj66L/XnMuaeA1yxCPV7Ev+7v
 FfsYW9xaUYKi7495IfMEoqQaATjvJlJ9OmIiwQwzMP8qJRYJrl9yMYg5lA16rFTyhIA2
 lltbQMB2AvMsIhP71vXRMCHET50eyVbWAjgxtTXbNA5DvjWUxcR1NIY/Hb0IE2GhD0O3
 h3DDjKYZXRMMRLUxG2UCSZ+AzvhPA8G+6VBgAw5UgPQleUAxSEg3V2Y+gwgs5V213K7v
 fUxVgAHbpHL53hH7OP00tM8Bn/HM2IQcghJh4rFsPxzRNHQr22ZHVlXw+66sMHn1HSVt
 weRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771230235; x=1771835035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gIJ+Ki4105TTSmqKP8RwVFEak2/83YrsD5ecQqd2O/s=;
 b=mcdCTUmur+KN6cVhOtWBEzmqCrGMmHqxHPmLkd4i+0hGHDl2MzaeHSPCZd7p0vHd+1
 yUYiQPhMQ/9VaNrTFWbFJwV9g8BcgOM8u4CWmGER0NWqgFEh1jRvNd/byuNbWCmVwxjh
 eRsxhEm3UeBX6m77x07r9tcAocF5HYA8ukuT6mTA7jZ3RFhsTsuKX0/ZKez/+PklHVAN
 5Qq5Q4GXbJsf83dTN4KpPOSIsOvSc2V3d8ssN7S60gpTK+c/Q/Ci/sPkbO0xxpGRZz3R
 h/Ok/iBurGleLRmyJa+tbYaHpcA6EcNFjE5e9818yUYTzwbJvw7wSQh+zGhsc/YJeSJs
 K0+g==
X-Gm-Message-State: AOJu0Ywtd2j+IZ+YMH7GAxGpzS0fTLyixS+sc9TWg6f2605wyUythUHJ
 8+X3dcxqpEWzoa9bPiVaxu3UwmfQWhlL/c0HG98Hp9Hn9gms+DHVdYTb2hqqR71kBnZtO1OuhPt
 0V2VUbTONZq63hqf4r5xQnPBzMHdLk+8Qg8ImCUwLWJt+0anMlMhpWei4uXLrs1u693dGTEpvd1
 hvj0dnu+GdEWZti3Vzz5te7NkVSIjUkGc=
X-Gm-Gg: AZuq6aKOw9QHcUN4G1+SV8tQGkPkMtByYcx4H61B/5MutLYOYuGLRMrbhSuEgcWhcfK
 VhENXxXXn1kA9+ZFCHYGlyacm3hWuPEtiUHWObbFh6EEdW2PI4w34C9BXCDAUWFQnJhY8IEysI0
 RctEkDZscLWAjWwJOphHE913BTUAVOia/92wLZMJOwR+9e8GlUtKucC/8q89MgHfOagwF50UiJS
 JaeH/Z8RR0O6D0qIZ5scKb7zTZTKV0e+r8x
X-Received: by 2002:ad4:5c4e:0:b0:896:17e6:b3d7 with SMTP id
 6a1803df08f44-89736296273mr131730946d6.68.1771230235470; 
 Mon, 16 Feb 2026 00:23:55 -0800 (PST)
X-Received: by 2002:ad4:5c4e:0:b0:896:17e6:b3d7 with SMTP id
 6a1803df08f44-89736296273mr131730776d6.68.1771230235116; Mon, 16 Feb 2026
 00:23:55 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-3-imammedo@redhat.com>
In-Reply-To: <20260206131438.1857182-3-imammedo@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 16 Feb 2026 13:53:44 +0530
X-Gm-Features: AaiRm53ggyZ99cDfDKtwMkxBexCbyNJFS_Nmu5BDeyKnKV-XyL2nm0BMxY3TTwU
Message-ID: <CAK3XEhM9u49PLF7v9EFtA__-OOoUjTfkKuPgnuP-Q0gaKWejsA@mail.gmail.com>
Subject: Re: [PATCH 02/11] machine: add "acpi-watchdog" property
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org, 
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Feb 6, 2026 at 6:44=E2=80=AFPM Igor Mammedov <imammedo@redhat.com> =
wrote:
>
> It will be used by following code to enable ACPI watchdog.
> Initial support will bring it to Q35 and arm/virt machines using
> respective iTCO and GWDT watchdogs as hardware backend.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  include/hw/core/boards.h |  1 +
>  hw/core/machine.c        | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index 07f8938752..25577c3aac 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -447,6 +447,7 @@ struct MachineState {
>      struct NVDIMMState *nvdimms_state;
>      struct NumaState *numa_state;
>      bool acpi_spcr_enabled;
> +    bool acpi_watchdog;
>  };
>
>  /*
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 6411e68856..4ca808fb73 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -499,6 +499,20 @@ static void machine_set_usb(Object *obj, bool value,=
 Error **errp)
>      ms->usb_disabled =3D !value;
>  }
>
> +static bool machine_get_acpi_watchdog(Object *obj, Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(obj);
> +
> +    return ms->acpi_watchdog;
> +}
> +
> +static void machine_set_acpi_watchdog(Object *obj, bool value, Error **e=
rrp)
> +{
> +    MachineState *ms =3D MACHINE(obj);
> +
> +    ms->acpi_watchdog =3D value;
> +}
> +
>  static bool machine_get_graphics(Object *obj, Error **errp)
>  {
>      MachineState *ms =3D MACHINE(obj);
> @@ -1257,6 +1271,12 @@ static void machine_class_init(ObjectClass *oc, co=
nst void *data)
>          NULL, NULL);
>      object_class_property_set_description(oc, "memory",
>          "Memory size configuration");
> +
> +    object_class_property_add_bool(oc, "acpi-watchdog",
> +        machine_get_acpi_watchdog, machine_set_acpi_watchdog);
> +     object_class_property_set_description(oc, "acpi-watchdog",
> +        "Set on/off to enable/disable ACPI watchdog."
> +        " Default: off (ACPI watchdog is disabled).");
>  }
>
>  static void machine_class_base_init(ObjectClass *oc, const void *data)
> --
> 2.47.3
>


