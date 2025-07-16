Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E17C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubypS-0005t0-Nk; Wed, 16 Jul 2025 05:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubypR-0005px-5h
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 05:53:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubypO-00066C-DF
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 05:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752659608;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GMS3ufeDUPRFe7188wuF9WixjIPlmEY6ICo1fTQf858=;
 b=ICedo2J2k8g91SmsgPBaJqMIntAs7auRUF+Rd3m7EUA6kORCv6mguyLAr3f/GBp6N11GBc
 jmGN9JZZwxv7z42ck4FSwlKY1vD97SWq5GMx0vjCsdvrIyHmjZnJGMlPuJo+uH9gI4jrjF
 +pj7ErI86rRFSlRl+9SPJCXwxuqaAAQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-EYOC2EH4PcqZSn2zGGJqGA-1; Wed, 16 Jul 2025 05:53:26 -0400
X-MC-Unique: EYOC2EH4PcqZSn2zGGJqGA-1
X-Mimecast-MFC-AGG-ID: EYOC2EH4PcqZSn2zGGJqGA_1752659605
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4562985ac6aso14993485e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 02:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752659605; x=1753264405;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GMS3ufeDUPRFe7188wuF9WixjIPlmEY6ICo1fTQf858=;
 b=cJMfTL1mdqODDl13n9RL+6/pXOeOe16oByAtNKYhOqNHvWy0qejuiOAm4QzQ7XsYta
 33Oo7p28k5T0uba2yFGZbzUiTCcryeG8mNm3uO2vgmdua1hSaI1ELXGzL674rmhZJQZu
 8cw8IA1rsxDOwu3+2WLTwfOq4j3PtGivzSxYrIJ85eXjU+6zu099+timsmUiAc/jh7V/
 oidaVkx/UOHec8W4xhGH0QwMvbRNVNUDYO0ThDEpBHSHfYTb2yjmIfo7am+U5NkMm4b1
 GLIF0tsM7NWMc3c5eiQhLpExekQ6JqzBWHYNmt/VOJeklTyB7LjrPXOLv/ENX3Kbbf0N
 +4vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPp/GqhberZWV9XAFCyvxy2Sl0uHH/7AHFVivgIuUZCI3gfWMZojNAQ5SU7uaOPT9SGkRg9sYV7LDs@nongnu.org
X-Gm-Message-State: AOJu0YzP6uJcbDL1dRVwuyh3ktfOsd5bbDlh6QSUClKw5y6pbnnkiIfx
 Jb74p2boFUz/l3c/uIQHGHVNAKfcfGaHIs6+cDpUUmP3eW5JlwOFLmv6rtqS+ruNvt0TMeRLH5g
 vPIpOTRSTdIGnWkurQgLGqkjt+v+9g5pwnry9ln0ytlbQfmyVUxOOfqu2
X-Gm-Gg: ASbGnctN3JhKUbOLoYmNdU1Ir89mVG9Se4NEuCwexAmB731zKclWrnIN3ew60UwXwrp
 XTpMDhUMNR+pWx9pVjCN4w51uK5ehdt9JX4rqbz1GdGaQHNQQUdwFBbW/tMViYH01qARIzc83SD
 pbIiSbAvIFMclswdegrHXw+hUNgL9ovts7e4GEB2jYQQFKXemXs07AgRFYFzegj+am3CnAvQoYL
 uYT5h2dRcz6pwyMPOcWEwW5NbTAS7lgMfByOxCbd6wOH8gzUpsMfiGL5iof46V9d7uSaam/45Me
 FmqLM8qJhM3kEQekxWyy7yx38Hwh3gSHt6vnloH/oRaFNdpq3e7wevVdZ4uG0MZ3f9OmUwFX03H
 YpKAHOMX4euQ=
X-Received: by 2002:a05:600c:3481:b0:456:f9f:657 with SMTP id
 5b1f17b1804b1-4562e3c503amr20313805e9.27.1752659604893; 
 Wed, 16 Jul 2025 02:53:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk7G9zrdSqVcbqPgRSABg6TPgGtf89iY4ylUq12UcLypPVqdwdFYneZ8Iv/M7mXCOhRwnpaQ==
X-Received: by 2002:a05:600c:3481:b0:456:f9f:657 with SMTP id
 5b1f17b1804b1-4562e3c503amr20313525e9.27.1752659604445; 
 Wed, 16 Jul 2025 02:53:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d289sm17672326f8f.55.2025.07.16.02.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 02:53:23 -0700 (PDT)
Message-ID: <471cb345-2d67-4a3a-b555-e1da3e57b0e9@redhat.com>
Date: Wed, 16 Jul 2025 11:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/20] intel_iommu: Fail passthrough device under PCI
 bridge if x-flts=on
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-9-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250708110601.633308-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Zhenzhong,

On 7/8/25 1:05 PM, Zhenzhong Duan wrote:
> Currently we don't support nested translation for passthrough device with
> emulated device under same PCI bridge, because they require different address
> space when x-flts=on.
>
> In theory, we do support if devices under same PCI bridge are all passthrough
> devices. But emulated device can be hotplugged under same bridge. For simplify,
to simplify
> just forbid passthrough device under PCI bridge no matter if there is, or will
> be emulated devices under same bridge. This is acceptable because PCIE bridge
> is more popular than PCI bridge now.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c57ca02cdd..15f4393d6f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4330,9 +4330,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>      return vtd_dev_as;
>  }
>  
> -static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
> +static bool vtd_check_hiod(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                             Error **errp)
>  {
> +    HostIOMMUDevice *hiod = vtd_hiod->hiod;
>      HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>      int ret;
>  
> @@ -4359,6 +4360,8 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>  #ifdef CONFIG_IOMMUFD
>      struct HostIOMMUDeviceCaps *caps = &hiod->caps;
>      struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
> +    PCIBus *bus = vtd_hiod->bus;
> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), vtd_hiod->devfn);
>  
>      /* Remaining checks are all stage-1 translation specific */
>      if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> @@ -4381,6 +4384,12 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>          error_setg(errp, "Stage-1 1GB huge page is unsupported by host IOMMU");
>          return false;
>      }
> +
> +    if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
> +        error_setg(errp, "Host device under PCI bridge is unsupported "
> +                   "when x-flts=on");
> +        return false;
> +    }
>  #endif
>  
>      error_setg(errp, "host IOMMU is incompatible with stage-1 translation");
> @@ -4414,7 +4423,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>      vtd_hiod->iommu_state = s;
>      vtd_hiod->hiod = hiod;
>  
> -    if (!vtd_check_hiod(s, hiod, errp)) {
> +    if (!vtd_check_hiod(s, vtd_hiod, errp)) {
>          g_free(vtd_hiod);
>          vtd_iommu_unlock(s);
>          return false;
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


