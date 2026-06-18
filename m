Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B61CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCVD-0005fF-0L; Thu, 18 Jun 2026 09:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waCV5-0005eU-9W
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:09:45 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waCV3-00047c-OV
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:09:43 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-660512d80b4so1115607d50.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 06:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781788179; cv=none;
 d=google.com; s=arc-20240605;
 b=WMJHchtPEhCqS+Bo5LQohSsDuoPhEquaU3U2gI4E1MaRWTeUf6HDXoocqIotxfDCt+
 tyU+zbVrPuBYzerAbEz4jYQbkY8QskYkPKjESoCitrrVXCpCLdGtuWSR2RHjFLK35iDW
 D9vSC06dmUgzKHv5D80ZMUX9NhXsDLf0TrAQuE1BgY5nCo9cB4STjLI9eHofonHmlWb2
 EMtWjktfi+NF6oQ3+dmsH6kgO3ZU4Han75De4HAKHIfUS2fpH00OcyXtruGyIUZpv66E
 86b17HTs16Q6wrxqlh3SVJisKNXYozQSa8Q8l/2ieTO1fyqAfS02QGT620xLD8Atv9ua
 SKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OgvH7ms40ZffCRKg+AJZBmQ+KkZlsqgPOVeuZ35u6n4=;
 fh=x/e7xkPJit5dBLr3qPNkwl8VyhAnaZMziv6Bemhvs1M=;
 b=J2jWxUDHkLj/RVftLWp1FpPX1FXdq0j7Pidk8AbJ44LblOG6FtrirpOJ/F1D4B3bCd
 BOonajPoY5i/G8f89H2LWkZEf7XveikjiVkD897VDXoZNgK2dk+LEVXNX6FzFqgtpNNc
 Z3MeD9OyOgYONFrD0xNY+ZAe3bFwE4ZTTl9k/MKsfzxaJnyenscaUfev3SBPYaocRUIe
 btThrOSK9SmwYjNxDyRFJ4XyGGMG7kA81Rf0FYjn/qOn8r3ABtj3Z6Wz4vMtAeS0iVaL
 A/x6cbFFoUwn5jB0srEZ1U93LwEokEsKeVzVU1a5gHMJdN6CfMNAV2UZbo4EFXFG8F9x
 FHlQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781788179; x=1782392979; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OgvH7ms40ZffCRKg+AJZBmQ+KkZlsqgPOVeuZ35u6n4=;
 b=Evva6dXvWHAPQElH56Eu/5EicQRbA9LVVoCroxR+a/LZnbex+E9oijjErDo1jyRrMa
 ic09cwJNar8UiXJ6sBjDJEpIbFdJZNnrQ05qmBiRnYv72zAUYvXM62j2D+dkOnVgJb4B
 1pqGW+yVVxy+yemBYQbi7i/i3/JIM5HhlQaNmTjV6F/5LM6WBbV9O85PIOy40jUcRREF
 tHHDmSlmYTX0BHh1deUNl8vPRTqUKnicL/m0cubYzieovTdp7HlsK/z6dG0vEQHd0had
 S8Ggh5VaqGKrPPx+b35njKhQo0/ta+QCsKZHaxH1di6iHO/0PjZWubAMd08qZWA4V8+I
 3JZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781788179; x=1782392979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OgvH7ms40ZffCRKg+AJZBmQ+KkZlsqgPOVeuZ35u6n4=;
 b=dNOy9ad9cLMiQych+htPZUJizaqIP8n+e318Il1GrpMFXuS5gDOl8k5uKBFBbc3ef9
 8Ags3x05jPL95nd4LZROCDiHDFe+4aAc5qIlGi1uHBulZq2kYKnxnwsHZXjaTaAJjZ1w
 dgd0peRe/fYCpDpTq2gGpBLQwXU+uvTooOMODH3WdafkBwH8sHsbNNDozXJD6Py7VEr1
 KoE9/OD8+rqmL8yWOaAOVvK9xt0lWnRiUTo1fha3b7KCXHnj2YAfnzbvvNz7Q5eWL1zJ
 80oUOdjxWHwq2lpM2Zt0+SUJt6cCHMiJoqJy5BzE+LTME9W9nBiAsetvxP1pHHaB8jie
 +53Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PQz1qiQXW2hjAgLkJvU5886VfRvRTnSwRiNMnW+ju+bzFNXTrsCftidAdr+R3KQ2vw2yDxIoqA91I@nongnu.org
X-Gm-Message-State: AOJu0YztYg2DjZLprsn3Yz82JpT0cCnroBz1aIXURNzsvUFwI5skl38j
 0uklI0/0xgCU1uTsq+49Cl8CCxxC/A0pV06C3QfqugsVyX8rV8FwQal45mHVBD03f/3s38mzZu7
 9SU7klznEdDglQVfKNAZlyLOem5mMB+9ZV8n/+JJlKw==
X-Gm-Gg: AfdE7cmCyVdfFwS/YWLWmcecgBu6v0e2jcmF6snP5wiqJYRP1BAQgJUaz3I8z6JS2lB
 ibgrRvJzs8JfEQp+HYX+mwt2JNTFOGtDurSra7PvcJnJxByqCD7RngnVQJ0T0Wl+XQ5xGpEVlRV
 PqleY9bj30licz8ne4RfmOUkl5ZqJKj/HyjD+fF2qTWOEoyLSj0NBEw2fonPurKHCoq1OGRofDc
 4WOPk+I5duTqeh4ZlViNlcEXdZQhH0c8d+lIiUC0tgjx7szKsWHkl94JZEe5etZ4aVInaNzZkOp
 7Wl/LBdXNLdSUu7pV7qOTsnYQLALd9hUZFrTjb6OyROG4mWWK2x4ggaG
X-Received: by 2002:a05:690e:1686:b0:662:c78e:3943 with SMTP id
 956f58d0204a3-662e3e2b50bmr3498890d50.38.1781788178639; Thu, 18 Jun 2026
 06:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260618125442.641532-1-mbawa@redhat.com>
 <20260618125442.641532-2-mbawa@redhat.com>
In-Reply-To: <20260618125442.641532-2-mbawa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2026 14:09:27 +0100
X-Gm-Features: AVVi8Ceo7KCnhYAMdnLlDmBeqv-ehjOLrLcuik1h6l-Wwqk_2apB273oz1dz0Vk
Message-ID: <CAFEAcA9BtQ3DyuoqYEKcNYK-dncxmxXiS1zm51-6OuY5A8m=zA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/tpm: gate PPI support on tpm-tis-device behind a
 device property
To: Mohammadfaiz Bawa <mbawa@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
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

On Thu, 18 Jun 2026 at 13:55, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
>
> Add a "ppi" boolean property (default: true) to tpm-tis-device.
> When ppi=off the RAMBlock is never registered and the migration
> stream omits "tpm-ppi", restoring backward compatibility.
>
> When disabled, realizefn initializes the region with zero size so
> the platform bus skips it and ACPI PPI tables are omitted.
>
> Fixes: 46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for ARM64 virt")
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> ---
>  hw/tpm/tpm_tis.h        |  1 +
>  hw/tpm/tpm_tis_sysbus.c | 16 +++++++++++-----
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
> index 1531620bf9..6ac9804050 100644
> --- a/hw/tpm/tpm_tis.h
> +++ b/hw/tpm/tpm_tis.h
> @@ -76,6 +76,7 @@ typedef struct TPMState {
>      size_t be_buffer_size;
>
>      TPMPPI ppi;
> +    bool ppi_enabled;
>  } TPMState;
>
>  extern const VMStateDescription vmstate_locty;
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index 16bb17874b..54691ac272 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -94,6 +94,7 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
>  static const Property tpm_tis_sysbus_properties[] = {
>      DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
>      DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
> +    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, true),
>  };
>
>  static void tpm_tis_sysbus_initfn(Object *obj)
> @@ -122,14 +123,19 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>
> -    s->ppi.buf = qemu_memalign(host_page_size,
> -                               ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
>      memory_region_init_io(&s->mmio, OBJECT(dev), &tpm_tis_memory_ops,
>                            s, "tpm-tis-mmio",
>                            TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
> -    memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-ppi",
> -                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
> -    vmstate_register_ram(&s->ppi.ram, dev);
> +
> +    if (s->ppi_enabled) {
> +        s->ppi.buf = qemu_memalign(host_page_size,
> +                                   ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
> +        memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-ppi",
> +                                          TPM_PPI_ADDR_SIZE, s->ppi.buf);
> +        vmstate_register_ram(&s->ppi.ram, dev);
> +    } else {
> +        memory_region_init(&s->ppi.ram, OBJECT(dev), "tpm-ppi", 0);
> +    }

Is it valid to create a 0-size memory region? I think the more
usual approach here would be to not expose the 2nd MMIO region
if the device was configured with PPI disabled.

This device also very weirdly calls sysbus_init_mmio() in
its initfn, before it has actually set up the MR, which it
is doing here in realize. I think that also needs to be fixed
(especially since the property will only be available in
realize). It happens to work since all sysbus_init_mmio()
is doing is putting the pointer into its data structure, but
it doesn't make much logical sense to do it that way around.

thanks
-- PMM

