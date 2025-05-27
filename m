Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F643C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 14:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJurj-0003Xf-Bu; Tue, 27 May 2025 10:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJurO-0003Tt-8h
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJurK-0005xy-LS
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748354446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9fqEK7t3Ihy1U7LdrqIC4SYR34scUsQWrqu4TAo6V+Y=;
 b=K1HFiw1Td0KfqSJyrNs4P3l3lXgaPWYbZK7NjekEToAqxwdU7C71SblfYBJihLOYE591EP
 b/otLufG204Fpj5W2aDbWoYIrLMAayF/28eSxTyTqs1jhHcVEn/UrP+tLncGTmJGwH+AiH
 rIQwvYhPWgDJuM3rcDT+APrN2ZscV58=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-EyIBhAQUPQujUBoimyzDOw-1; Tue, 27 May 2025 10:00:44 -0400
X-MC-Unique: EyIBhAQUPQujUBoimyzDOw-1
X-Mimecast-MFC-AGG-ID: EyIBhAQUPQujUBoimyzDOw_1748354443
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4d8983eecso1037658f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 07:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748354443; x=1748959243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fqEK7t3Ihy1U7LdrqIC4SYR34scUsQWrqu4TAo6V+Y=;
 b=Tg7jzzHGHMhR7b9So1UcIbnoFmfOLruiTes48eIfGdaJXWc3WzIzzx15sNymeJ0uhY
 xFCe7oDXeKo35nxPATEF432Rs0W+ZTJNXXp6eLtBU7oaoiwgcXKlsz2XloOvlvzkzf84
 A5k1xC5sAehiZ8/Ntr5olIFWU5qh4yE8TwX3OhRz9iDm5J0QhZrjuyEJG32/onmGTNmp
 Uvu4+igHGWs9TB0kc2o2In0sVT9Q9nCBZoJIF8GGLMu0lr3S+cCz3PDUWm/GU8FKauv7
 zLJ2VFM8J3iAqbWCVPRZiM3bpF8UkMH3UdgoSrlkDYvJpcM8RKWbXp3S6+5oHDkQk87a
 zqhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvSCtYQYncE8yGbbNFMaSQahErCobbEsqeOD586rvZWyq9FrfflqUijjjRdt5CI8ICInou5SV4Dhyb@nongnu.org
X-Gm-Message-State: AOJu0Yw6JymeLCyYkTnA+2ioxMPQH0a0fY40bV2vAWV9/zK2O5xGlaMh
 k9pX8f4uQpvQ/m2lw2pEFAHCHSplAi+jTTtYqZEtl8mD7BEMefDUmtbF8Bchkn4PYqcC4N+kcm8
 EWo7PL4k4frYv/5hA9pmUs/lvwdBmSvxhbzv92xInMw8yJH3M0z+T/L6tJp4ftycUKf8=
X-Gm-Gg: ASbGnctAVekG+dokBYhQII/SB7uR1O+j9OSsrmr7XsenkRykSlNEE91CHcSs6tGws6m
 pwrhrQtFh4qFemeHgzdcQI4K7AUrGlpqJgYXvaWq1XOKBOSFoZWVtg2XbZpItdevongs+bgQYU9
 j+ewSNEtqGjaqh+w5OAqEkxz624Lj1GCfPlqsoO0J7wa9RldA6nFE7Q35AHqKwAplqUGC6fbN3m
 7nOnGZqcPO3uyI5GCG7Dpw5BvKyOLRX+hoGapuarmBNf52r6B2rFqLUC+o7zo+ZfXT/9ysFYRfS
 gmzeBOsX/WKyyrVZMRJRl3ClVv8v6nie
X-Received: by 2002:a05:6000:4024:b0:3a1:fed3:7108 with SMTP id
 ffacd0b85a97d-3a4cb4b8e74mr10644473f8f.40.1748354442613; 
 Tue, 27 May 2025 07:00:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQZHBsCXWKvd0ywX7wP3mMHQR8XMtukgb7Jve918YRkUmO3KeJVM9rs1yjIuvv6Oi+DtiwIQ==
X-Received: by 2002:a05:6000:4024:b0:3a1:fed3:7108 with SMTP id
 ffacd0b85a97d-3a4cb4b8e74mr10644415f8f.40.1748354442117; 
 Tue, 27 May 2025 07:00:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4c9cd023csm11512864f8f.10.2025.05.27.07.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 07:00:41 -0700 (PDT)
Date: Tue, 27 May 2025 16:00:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 16/25] hw/i386/acpi-build: Move aml_pci_edsm to a
 generic place
Message-ID: <20250527160040.5641920d@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-17-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-17-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 27 May 2025 09:40:18 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Move aml_pci_edsm to pcihp since we want to reuse that for
> ARM and acpi-index support.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/hw/acpi/pcihp.h |  2 ++
>  hw/acpi/pcihp.c         | 53 +++++++++++++++++++++++++++++++++++++++++

edsm is for un-pluggable ports,
a more suitable place for it would be hw/acpi/pci.c


>  hw/i386/acpi-build.c    | 53 -----------------------------------------
>  3 files changed, 55 insertions(+), 53 deletions(-)
> 
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index 5506a58862..f2c3558654 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -82,6 +82,8 @@ bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus);
>  
>  void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
>  
> +Aml *aml_pci_edsm(void);
> +
>  /* Called on reset */
>  void acpi_pcihp_reset(AcpiPciHpState *s);
>  
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index d800371ddc..57fe8938b1 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -937,6 +937,59 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
>      }
>  }
>  
> +Aml *aml_pci_edsm(void)
> +{
> +    Aml *method, *ifctx;
> +    Aml *zero = aml_int(0);
> +    Aml *func = aml_arg(2);
> +    Aml *ret = aml_local(0);
> +    Aml *aidx = aml_local(1);
> +    Aml *params = aml_arg(4);
> +
> +    method = aml_method("EDSM", 5, AML_SERIALIZED);
> +
> +    /* get supported functions */
> +    ifctx = aml_if(aml_equal(func, zero));
> +    {
> +        /* 1: have supported functions */
> +        /* 7: support for function 7 */
> +        const uint8_t caps = 1 | BIT(7);
> +        build_append_pci_dsm_func0_common(ifctx, ret);
> +        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret, zero)));
> +        aml_append(ifctx, aml_return(ret));
> +    }
> +    aml_append(method, ifctx);
> +
> +    /* handle specific functions requests */
> +    /*
> +     * PCI Firmware Specification 3.1
> +     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
> +     *        Operating Systems
> +     */
> +    ifctx = aml_if(aml_equal(func, aml_int(7)));
> +    {
> +       Aml *pkg = aml_package(2);
> +       aml_append(pkg, zero);
> +       /* optional, if not impl. should return null string */
> +       aml_append(pkg, aml_string("%s", ""));
> +       aml_append(ifctx, aml_store(pkg, ret));
> +
> +       /*
> +        * IASL is fine when initializing Package with computational data,
> +        * however it makes guest unhappy /it fails to process such AML/.
> +        * So use runtime assignment to set acpi-index after initializer
> +        * to make OSPM happy.
> +        */
> +       aml_append(ifctx,
> +           aml_store(aml_derefof(aml_index(params, aml_int(0))), aidx));
> +       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
> +       aml_append(ifctx, aml_return(ret));
> +    }
> +    aml_append(method, ifctx);
> +
> +    return method;
> +}
> +
>  const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>      .name = "acpi_pcihp_pci_status",
>      .version_id = 1,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 6feb99e9eb..e8ed335fdd 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -322,59 +322,6 @@ build_facs(GArray *table_data)
>      g_array_append_vals(table_data, reserved, 40); /* Reserved */
>  }
>  
> -static Aml *aml_pci_edsm(void)
> -{
> -    Aml *method, *ifctx;
> -    Aml *zero = aml_int(0);
> -    Aml *func = aml_arg(2);
> -    Aml *ret = aml_local(0);
> -    Aml *aidx = aml_local(1);
> -    Aml *params = aml_arg(4);
> -
> -    method = aml_method("EDSM", 5, AML_SERIALIZED);
> -
> -    /* get supported functions */
> -    ifctx = aml_if(aml_equal(func, zero));
> -    {
> -        /* 1: have supported functions */
> -        /* 7: support for function 7 */
> -        const uint8_t caps = 1 | BIT(7);
> -        build_append_pci_dsm_func0_common(ifctx, ret);
> -        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret, zero)));
> -        aml_append(ifctx, aml_return(ret));
> -    }
> -    aml_append(method, ifctx);
> -
> -    /* handle specific functions requests */
> -    /*
> -     * PCI Firmware Specification 3.1
> -     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
> -     *        Operating Systems
> -     */
> -    ifctx = aml_if(aml_equal(func, aml_int(7)));
> -    {
> -       Aml *pkg = aml_package(2);
> -       aml_append(pkg, zero);
> -       /* optional, if not impl. should return null string */
> -       aml_append(pkg, aml_string("%s", ""));
> -       aml_append(ifctx, aml_store(pkg, ret));
> -
> -       /*
> -        * IASL is fine when initializing Package with computational data,
> -        * however it makes guest unhappy /it fails to process such AML/.
> -        * So use runtime assignment to set acpi-index after initializer
> -        * to make OSPM happy.
> -        */
> -       aml_append(ifctx,
> -           aml_store(aml_derefof(aml_index(params, aml_int(0))), aidx));
> -       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
> -       aml_append(ifctx, aml_return(ret));
> -    }
> -    aml_append(method, ifctx);
> -
> -    return method;
> -}
> -
>  /*
>   * build_prt - Define interrupt routing rules
>   *


