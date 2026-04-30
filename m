Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A97FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIT4m-0004sm-Ju; Thu, 30 Apr 2026 11:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIT4j-0004qy-Rh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:13:14 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIT4g-0003lE-DR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:13:13 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6501547d7edso997604d50.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777561989; cv=none;
 d=google.com; s=arc-20240605;
 b=DvOITAYbi4Xc5ypzfDX03EKw20iU51bsK+DWL3mpOCNvtLcn6jArGVG7ZZo4EAD9kJ
 OxRS0meDjspuQscgujoM7ABTfm4OQSoqcUpUZFPgrcjDJvXN8IhDJYut9PkXwwDMfJzV
 JeKwvKmjrYYqGNl7lZrnvu2M2k14vG3PmxT5AIetkA2Nf7dodZQaRBp64OO5mAnPTA8c
 yrpY/kPba+9klOvdtDm+ddEEPtteu1i2cQQKjt7kQSDLsjUtm6j7zyBpAp4STpyckvTo
 NTOZlvLhB3p/ATYb+fOsiPDdvPfZ1dHOBLI6UWel8g8SGDh9s7nShjJopvMC3EjED1ms
 G0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kRfmg2/lhe8tE7lO46l2bILxIDcNmnU0tR5MUeOwWAg=;
 fh=N1YcepiC2/ZNEdJeGCZFuEiACpW3uxChQGpyM5xjiIc=;
 b=KgphFD4O/ZcXSfgwUmGfEbhEdmDIOtT/h981OnxvHTjD94C8RCb3viUSWePtSrWzb7
 fJFfFI4ekVrrdHZjLA2jAm0GulWsfLMmw/3WO80nb0a6D4xRSJ52Ys9svGQZFLEvtkXI
 O0NW4zV6LBC3L+5nWwxMEABa+93BkCSRlfnqMBsE9ujAfv0DQMOVuAo3yK5Ao8Eg78AF
 70YP+ebv/bMW+TBPbYxf26YosUYohI8JzUnBYKe8wh4va7t0g8e3J7aBOWDX36A+E+N3
 ipnrHtxzAgRsIB+ZfD38grMRiEcYHsAsjKni6Ed/alMxBfUjbP0OIpSGzCAFwHlkigId
 6saw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777561989; x=1778166789; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRfmg2/lhe8tE7lO46l2bILxIDcNmnU0tR5MUeOwWAg=;
 b=T6EU5rNJEExEnhicpO6hdl0dQD72ByleSG9tgVFc7hIYO3GFWM/5vHGY6oX3luBgVK
 xKd5iK+pIF39/6bDgbXIkDmQ0VCUEwiPyeWduOnLCPsjL6k7k5pGMo11uxjVeOBEB4cV
 v51L9wqgosCWG0h5oWZdn3S1BGrC91jgkSr11u4XLio89M5ILVa4bi+9ct7N6ScD58b1
 Snstd/Vj+/3lZkAhqNPmcif/atOXxyYdLbm5cC8iSFK+uGvmxwchnoNRyzRRpawbWb7p
 cAh8LLg0M1YkSng8SRODYNCMyiRHhfpirm5FFZR/2SweGyK932FhY/PbthqcV7MMwsD7
 tFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777561989; x=1778166789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kRfmg2/lhe8tE7lO46l2bILxIDcNmnU0tR5MUeOwWAg=;
 b=d3KMHM7aUp096wXkuzlR8fiR/USS15Pxe3/oXW0TonnrdpOk1O3gMR66xH8Y2G/MI9
 nxaOE6dMIL9KdQ2NItKNF0uCs4+3Db7hQIiWpsem/c1ktudRK/T9rQeuFw38n4annxRY
 cCAAZEHOGqFBzjeZNuYSJKoameiXuMehz3OZETw6kAPio5c8mEHF60efORkHKy2fX3Ki
 HtgvCgxDAWx4TupDBXkS1FZ4hDE4egQMgS1UWIcvI/ne485wPQmLPHmrnQou+N2U3czv
 AmbvZ1+ATFj7oMgul0JuR2/AqKLiOgx9KwoCNESKWU5P5ILHrbl66sCmRirFspxzGQY3
 r8pQ==
X-Gm-Message-State: AOJu0YxBDePj8VSWxihRdpqmNzZ7S24ZTsWiN9A9QHZ/s+f6Yb0y/3em
 2vOCMlkVJKfyD3lm6wUw5pANnocC2nALcjWL1qcazaYm+AqKZktEHdcjQ60D75xpfwvQv7FK3De
 MotCclPugUXsdM70vGgqzabzTgzMW5LZyRRSKxvIhcQ==
X-Gm-Gg: AeBDievgILVC8J2Z6oqsahHgggLKkcMgj9wxeURBsVQXcl68rQEfR/j41vdJl/IfmWV
 UBkZJjusDGcm1QgcDp3ifizJeKhRR8uJ9a/jvhwuPAF5Kq1f+RCeFbRAbtXlYtIBaT5PlbvGTqY
 u1vRFqiFw7aA5j3IqqZBfA154Us2OJMpP6zzyQ1QHes9UTuNMW34lgBjPAc0UEN7pD0FypZKrgU
 4ge5Y5BTwki8GikCduii0Ja0Of0i07SyBQfMjlQfERWJY5aCJ3NcoFqBxzYBo5Yx1WoYUH5R85E
 2M8bJ0LKHVosRmGqflMIm+Zj6HupiGG4Sqhlr+wuPhT3MgOzMBueoUNbpzWd8hqdonYRekWVmdG
 w7Q==
X-Received: by 2002:a53:d00a:0:b0:650:1aa5:8594 with SMTP id
 956f58d0204a3-65c18fda650mr2289939d50.49.1777561988902; Thu, 30 Apr 2026
 08:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-34-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-34-c413f3605311@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 16:12:56 +0100
X-Gm-Features: AVHnY4JeMnIGjW_otRFblPTUn3jQCgGaBWfqVHBDMQj5iHWMWPdDCK7cPH3MyWA
Message-ID: <CAFEAcA-tSqa7SQUE-f5yTq_P9eW6p_XrnNSnHZjw4g=Z2WncAQ@mail.gmail.com>
Subject: Re: [PATCH 34/41] hw/arm/virt: free flash devices and OEM strings on
 finalization
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 27 Apr 2026 at 20:45, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Flash devices created in instance_init via qdev_new() hold an extra
> reference that is only dropped on sysbus_realize_and_unref(). When the
> machine is destroyed before realization, the flash objects leak. Also,
> the oem_id and oem_table_id strings from g_strndup() are never freed.
>
> Fixes: 602b458201ff ("acpi: Permit OEM ID and OEM table ID fields to be c=
hanged")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/arm/virt.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f62253e1aba..fac825ccd47 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -4032,6 +4032,19 @@ static void virt_instance_init(Object *obj)
>      cxl_machine_init(obj, &vms->cxl_devices_state);
>  }
>
> +static void virt_instance_finalize(Object *obj)
> +{
> +    VirtMachineState *vms =3D VIRT_MACHINE(obj);
> +
> +    for (int i =3D 0; i < ARRAY_SIZE(vms->flash); i++) {
> +        if (vms->flash[i] && !qdev_is_realized(DEVICE(vms->flash[i]))) {
> +            object_unref(OBJECT(vms->flash[i]));
> +        }

We currently use qdev_is_realized() almost nowhere in
the codebase. Isn't there some way to do this such that we
don't have to care about this because the object is
parented and gets auto-dereffed ? Having each object
have to care about the possibility of "inited but
not realized" devices in finalize seems like it's going
to result in a lot of bugs...

> +    }
> +    g_free(vms->oem_id);
> +    g_free(vms->oem_table_id);
> +}

thanks
-- PMM

