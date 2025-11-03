Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62542CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvVE-0003hl-94; Mon, 03 Nov 2025 09:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFvVB-0003hY-AV
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:25:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFvV4-0001N0-Gj
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762179933;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFsUwPUqdy8CnxzDFCH1DPu8CHXHZvk/F0AvAt+eUgc=;
 b=RyPxF9StcKGr9KyOe9bP2T2iSE9yJFhAn7EMERBCP5lAW8eKdlhg9WN+htzV+GZ4fkn1Pb
 WqMGOnHMOOflgugdp2ve1jbI+ud0S08ettRYSmiGFGUHWkwRM0QLD6CI5Z/iCQUIZTs/ON
 vdfq7NvlPZltcO2wxNB7gFbfNZHBMGY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-cRGW9EhFO0GR2gcoKhfVug-1; Mon, 03 Nov 2025 09:25:31 -0500
X-MC-Unique: cRGW9EhFO0GR2gcoKhfVug-1
X-Mimecast-MFC-AGG-ID: cRGW9EhFO0GR2gcoKhfVug_1762179931
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429bd66fe65so2123067f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 06:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762179931; x=1762784731;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rFsUwPUqdy8CnxzDFCH1DPu8CHXHZvk/F0AvAt+eUgc=;
 b=UcqoX7iWNfOLdCLpb0aIkKFrw37VTv9+dy8qJsnGvVdQQMrxQwF4spkYZqFQqX+qxq
 bwmU5/RFDWbG9Dlj1/lBl9GJ6TG6tcD1IB4a9V4RysMT4pzzhP+WJ+x0AlELfPiPQ+wt
 ZX0lnhZurVWnYtSB5dzBgp3oXivMFA1L6AbZuUrBKaIeHfgotX5fl/ZikFEDp0DhWPl4
 EMqhsad9uOdji9wkkmrmGeogsxubBMJcWxqcecz84Vd7VhIwPfo08XgDqbGNa5UgRVR8
 NStceBvRL4BdmCjQp/iCWQRRsMvDvUIOL9IbDcA0/8RRPgq12gv9XFBBE+iOCfDcLkWM
 01ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhuLFX5SKPi2XCIsYktQAC9KK3YPafQ4hnii8iH4PgNJE8xpEIP503ta+ndkVu5f0mbp0UxPLtwv9U@nongnu.org
X-Gm-Message-State: AOJu0Yxhabqx/uMhayD2ukPXgQvGqoI/dC7zHzDFbHaW1k9zEdC3YcdW
 Aqx5H4EZ0Onmj3YNQOQX6UZlknGx3Q1++317ViSKEwehEK9lgMkuNMM1B1eggEaxUgyIMv1remW
 Wm/tP4nt6HLJvUTE0BtVUdEcXE116hR2R0lWTzivuOcIDaY02NWYZL7Vg
X-Gm-Gg: ASbGncvG5sOdbAJs+9fRyvYP5V+eO3uxZ4puSshu6LmVL7aqd4MCCeMPspqKIYwhzoI
 OqWx2akPuhcefjNdY27/SvvsD5YiGB9vyLvS4+dM91sYncMQzl6T6qoP3bUocBoXXzBleXWVipD
 WuY7NiKOpRrdjO7APzHhbnDv4zUdhokjsTXeq1tPsdpGIFvftPujhxh5EWhF9DZTDRKGvPyBlFh
 ncUXMzwJuHMrJ33T/uW78e/H0FlfGNkT3TTzR+bNlquMlZ+UlqWnD7uMuLaJQXaWXi9KpAgo3PR
 vde7AMLk0msf4QgMJqj/vBnRSFmDYM7lvWg5tg6FLlhrC/1HUTeeW8I9ni0FE/AHBhGdPQMgXJw
 Nkenkr2Hu05eIvrSH84TM4HHORWRC5wDKuTDML8O6gLAh3w==
X-Received: by 2002:a05:6000:4024:b0:429:8d6b:16f7 with SMTP id
 ffacd0b85a97d-429bd68c553mr11133194f8f.25.1762179930758; 
 Mon, 03 Nov 2025 06:25:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuh5Kgajp0Kkx6M5ylzPvLWRZ6Nr/ZQ8+A+NpjNK1vlCKY3osI5GIaWZKt0MZG7ry9+x098w==
X-Received: by 2002:a05:6000:4024:b0:429:8d6b:16f7 with SMTP id
 ffacd0b85a97d-429bd68c553mr11133139f8f.25.1762179930261; 
 Mon, 03 Nov 2025 06:25:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429cfa27886sm9746719f8f.44.2025.11.03.06.25.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 06:25:29 -0800 (PST)
Message-ID: <e86bed4f-5550-40ec-bc38-093eae87e856@redhat.com>
Date: Mon, 3 Nov 2025 15:25:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/32] hw/pci-bridge/pci_expander_bridge: Move
 TYPE_PXB_PCIE_DEV to header
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-10-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-10-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 10/31/25 11:49 AM, Shameer Kolothum wrote:
> Move the TYPE_PXB_PCIE_DEV definition to header so that it can be
> referenced by other code in subsequent patch.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/pci-bridge/pci_expander_bridge.c | 1 -
>  include/hw/pci/pci_bridge.h         | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 1bcceddbc4..a8eb2d2426 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -48,7 +48,6 @@ struct PXBBus {
>      char bus_path[8];
>  };
>  
> -#define TYPE_PXB_PCIE_DEV "pxb-pcie"
>  OBJECT_DECLARE_SIMPLE_TYPE(PXBPCIEDev, PXB_PCIE_DEV)
>  
>  static GList *pxb_dev_list;
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index a055fd8d32..b61360b900 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -106,6 +106,7 @@ typedef struct PXBPCIEDev {
>  
>  #define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
>  #define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
> +#define TYPE_PXB_PCIE_DEV "pxb-pcie"
>  #define TYPE_PXB_DEV "pxb"
>  OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
>  


