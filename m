Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE4ACCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL85-0003ix-O6; Mon, 27 Oct 2025 07:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDL7y-0003bh-Bo
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDL7i-0007ER-Bl
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761563445;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NixdesNY1utcW3p2yxkWUY9N6N9R0zractCK2Y1EA18=;
 b=ZzmjSgKblp6sHS45gHNFh4RIarentO1h6IepPll+UBpzv+bmLS6a2qaIgeamPk6tUTON8E
 GnPcO8u9fPWCt2LGrQBtEm5Kr514KTfKLI3kBj4S7defkgXyRVzWctY/SIAOqNzjEv5MG1
 VdnV/P4GC6kOIRAi+Jo0Ibz6nFD/Sss=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-tMMeCo6bNOKFKMO_DjZIGA-1; Mon, 27 Oct 2025 07:10:44 -0400
X-MC-Unique: tMMeCo6bNOKFKMO_DjZIGA-1
X-Mimecast-MFC-AGG-ID: tMMeCo6bNOKFKMO_DjZIGA_1761563443
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477113a50fcso10073805e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563443; x=1762168243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NixdesNY1utcW3p2yxkWUY9N6N9R0zractCK2Y1EA18=;
 b=PnBZ4oYBAHL83qu4/Zbq75uBLehd9/1vXiMMIwuO1Ig0Aa2HFptAiHOZUiefl+1Zk+
 jbC4tITsPtopjDZG3X4yEQTSkJ9TKQS1ZAAnNE+t43yA1AO6fp2WT/ehuqtV1vsi2M34
 jtH4lBVCUOxMq17s6DSNT4igN/KEQsM/lwrFmuH/xv1L/mcluso5T2INy2Y6BRMHnDCd
 K2r28xRS6hl83RrPtnzhLQFhDFleRZKAnH7KXQWWIRJT25MqjIx3bLBe8JrXWjYWjJKO
 GYx0nCZuZtIRtUHPRgBoBy0IiImQZ/z2AdPwJSJcwKBKkgFwyzWCanH71+8fBn8WYUR9
 ptmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpu1iKaj+6PnE7TykC/SM4Z5iVqMgh8+HB95Atifw+zc2YNM3gfrOf3IlFRpyZziAW5qCVZQBMdDyC@nongnu.org
X-Gm-Message-State: AOJu0YxbMhq+CUR2njgfCJE8cpYcAl5ebIyS5Tk20dNIERfIXeBgMf/2
 A08KFsIf21BDLgm/+ovnKF/pnErutJqhGLUaMYWuhoMOmtep7vJWKB25ScA7gLsqvl6pG6wIaVN
 KKq/77LFCfe539YC0Nx/rGa+4O4V77urReBOOpsdDl8bWlmH0n777gIWW
X-Gm-Gg: ASbGncvfzbnfT0X3wz5anJiFP3WoeUHBUdhD97aQCM8kvgPz3LmdLxU2abPh0oUUXEW
 1xlRS5OuhHcJPVwSYzcI9iEAvfjn9tPEM0Q6xAL6753woshLAjx4pI4Ky0H/dE8XY5OqJepyaPO
 iYck0fZrFo6BYPPvir1y96RrUMGBLsDrP5g/ps0OWJ3iA5Uc0AkQ6caET1fVQBu5MYfdy7Bh+nS
 5zR4Zi2Ka2/zr1pmpp54LmMVSo+555EsuQC2Nzz7ZBMjvmG4oJ/uW830tqdGVvKuAzofjVMJL3V
 GyOjFcWnzIxbTz1OsNY9l0+7iQjEC9XL3ac3mo5SQy84SGzP1cGmlgylrQpa9OYkvU9kKMPiflD
 uilfL3c0MJwx0HWa+iE/or41tz7Zrhks+8ahcvN8Elw7d0A==
X-Received: by 2002:a05:600c:6299:b0:475:de55:9304 with SMTP id
 5b1f17b1804b1-475de559b0amr57728565e9.19.1761563442905; 
 Mon, 27 Oct 2025 04:10:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGng66RYWVXieE6xjlZ/YVYTTvKoCU49arFvseGNSohI5B1YpYU4WWc8gYSb+Gb4OvCz4qgYQ==
X-Received: by 2002:a05:600c:6299:b0:475:de55:9304 with SMTP id
 5b1f17b1804b1-475de559b0amr57728295e9.19.1761563442468; 
 Mon, 27 Oct 2025 04:10:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd02ce46sm152237065e9.3.2025.10.27.04.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 04:10:42 -0700 (PDT)
Message-ID: <a7b94719-d802-405f-a567-c919c096263d@redhat.com>
Date: Mon, 27 Oct 2025 12:10:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/27] hw/pci-host/gpex: Allow to generate preserve
 boot config DSM #5
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-17-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-17-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> From: Eric Auger <eric.auger@redhat.com>
>
> Add a 'preserve_config' field in struct GPEXConfig and if set, generate the
> DSM #5 for preserving PCI boot configurations. For SMMUV3 accel=on support,
> we are making use of IORT RMRs in a subsequent patch and that requires the
> DSM #5.
>
> At the moment the DSM generation is not yet enabled.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> [Shameer: Removed possible duplicate _DSM creations]
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
> Previously, QEMU reverted an attempt to enable DSM #5 because it caused a
> regression,
> https://lore.kernel.org/all/20210724185234.GA2265457@roeck-us.net/.
Looking at the above link again and especially the list of devices for
which it was failing, it looks reasonable to me to enable that config
along with accel smmu.

Eric
>
> However, in this series, we enable it selectively, only when SMMUv3 is in
> accelerator mode. The devices involved in the earlier regression are not
> expected in accelerated SMMUv3 use cases.
> ---
>  hw/pci-host/gpex-acpi.c    | 29 +++++++++++++++++++++++------
>  include/hw/pci-host/gpex.h |  1 +
>  2 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 4587baeb78..e3825ed0b1 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -51,10 +51,11 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>      }
>  }
>  
> -static Aml *build_pci_host_bridge_dsm_method(void)
> +static Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
>  {
>      Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
>      Aml *UUID, *ifctx, *ifctx1, *buf;
> +    uint8_t byte_list[1] = {0};
>  
>      /* PCI Firmware Specification 3.0
>       * 4.6.1. _DSM for PCI Express Slot Information
> @@ -64,10 +65,23 @@ static Aml *build_pci_host_bridge_dsm_method(void)
>      UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
>      ifctx = aml_if(aml_equal(aml_arg(0), UUID));
>      ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
> -    uint8_t byte_list[1] = {0};
> +    if (preserve_config) {
> +        /* support for function 0 and function 5 */
> +        byte_list[0] = 0x21;
> +    }
>      buf = aml_buffer(1, byte_list);
>      aml_append(ifctx1, aml_return(buf));
>      aml_append(ifctx, ifctx1);
> +    if (preserve_config) {
> +        Aml *ifctx2 = aml_if(aml_equal(aml_arg(2), aml_int(5)));
> +        /*
> +         * 0 - The operating system must not ignore the PCI configuration that
> +         *     firmware has done at boot time.
> +         */
> +        aml_append(ifctx2, aml_return(aml_int(0)));
> +        aml_append(ifctx, ifctx2);
> +    }
> +
>      aml_append(method, ifctx);
>  
>      byte_list[0] = 0;
> @@ -77,12 +91,13 @@ static Aml *build_pci_host_bridge_dsm_method(void)
>  }
>  
>  static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
> -                                              bool enable_native_pcie_hotplug)
> +                                              bool enable_native_pcie_hotplug,
> +                                              bool preserve_config)
>  {
>      /* Declare an _OSC (OS Control Handoff) method */
>      aml_append(dev,
>                 build_pci_host_bridge_osc_method(enable_native_pcie_hotplug));
> -    aml_append(dev, build_pci_host_bridge_dsm_method());
> +    aml_append(dev, build_pci_host_bridge_dsm_method(preserve_config));
>  }
>  
>  void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> @@ -152,7 +167,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>                  build_cxl_osc_method(dev);
>              } else {
>                  /* pxb bridges do not have ACPI PCI Hot-plug enabled */
> -                acpi_dsdt_add_host_bridge_methods(dev, true);
> +                acpi_dsdt_add_host_bridge_methods(dev, true,
> +                                                  cfg->preserve_config);
>              }
>  
>              aml_append(scope, dev);
> @@ -227,7 +243,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>      }
>      aml_append(dev, aml_name_decl("_CRS", rbuf));
>  
> -    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug);
> +    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug,
> +                                      cfg->preserve_config);
>  
>      Aml *dev_res0 = aml_device("%s", "RES0");
>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index feaf827474..7eea16e728 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -46,6 +46,7 @@ struct GPEXConfig {
>      int         irq;
>      PCIBus      *bus;
>      bool        pci_native_hotplug;
> +    bool        preserve_config;
>  };
>  
>  typedef struct GPEXIrq GPEXIrq;


