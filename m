Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB17D1A63D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 14:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veDn7-0007Rv-Hp; Fri, 09 Jan 2026 09:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veDmu-0007HO-Io
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:48:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veDms-0001FS-2g
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767970103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FsAI5wCpDu0bodzzeSWErlN48XJI1pElJOgNqYaBuho=;
 b=aSHQWLqfzEJEdjoZS0rseHnRpnKvYqa8dive44LxsPkCKSkLOesZYdmKARpKkttcosCB8O
 J8royHKcp500EMWLXzX4/9r1lyWgt9tPy9O1w0G37W/ui+w7eu6GP2quvCNTRY33L6meKR
 PWwyew2r5NnUSiBMFUs9Ll4xJyfHJi0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-YQRyiLrAP8iigHAOPATdLA-1; Fri, 09 Jan 2026 09:48:22 -0500
X-MC-Unique: YQRyiLrAP8iigHAOPATdLA-1
X-Mimecast-MFC-AGG-ID: YQRyiLrAP8iigHAOPATdLA_1767970101
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-432c05971c6so2074299f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 06:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767970101; x=1768574901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FsAI5wCpDu0bodzzeSWErlN48XJI1pElJOgNqYaBuho=;
 b=Jt5wBKtmIUCOk56xbfuXt/+f2WBPBiZ9jq+TjxJfUHG9dlLKcEmRyAAMNfUp3Fp1fQ
 uq1DTA3/0qbOV1ROAu3CF80vmr1FEf9DtL9e6MaywgdzuYchDaE1DCDjg4Sehd/xypad
 UPr5PEizX/bAmaMHbfxKRlLasZ3uPYdh3z69zigR9KRsDjl0NLzGnFcrsICeh9hs2L4S
 THUZwnkH/7qpmHqe3/RfGksccKKm5ydr2sPaJ+SbICY8v4YCrEXO3H6CpYvagsTPQKa3
 po8dSFJcw7lsnAskkzuckGYgPDLGDBIaawG3t7QgO8tkvTGiDdOVgU9L5vDwZJlz5zza
 CwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767970101; x=1768574901;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FsAI5wCpDu0bodzzeSWErlN48XJI1pElJOgNqYaBuho=;
 b=TWC4D+enboquk/4NrFvfNaNML715Xj5FFpGllmrXtoJWYAm+1pePyUIzMCf4wEGcip
 +W9JwztABSy6IQ8lMvADxJM8p2tqEH5gGbmfwgfsREe7whjdAykGaKDUx5TLff1QhECC
 vry1xCTELJEl12MqvdLLjvRGNl8L2CWtK8ia0hJMmRW5C46lkROpFtd9fZ/ZhfZEI/HE
 rs5kDadsMXoKuL7/DJ79k2i+Jodyg4nw1ZiGNy9kQJZhR0EtLjBDWdZoToa1BE0xia9U
 ShE5NuAt9clJ88YJXbuHf7qXUCllkg1+vjpylC9PEeFkdqNSdlvW+BpQiuX+BReP+eoc
 XDjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcWlMPQcFNABNyf3X55apuo9vVrxKyxxNHfy3pFk7dC8Ltpzs7KC9QBl4v+GaxZGQTCfbjuRYjOLA7@nongnu.org
X-Gm-Message-State: AOJu0YzsLTNBOoYK1kbumwxhyuR5J4QuyWHUYo/m3tvdyeLtcH4Gd4nk
 KRZytlS236HdTmq3MDs2d3t1NsbwW4yQmwLcfjGlRjcKlDmGaHkDkQp/It0qTnAnSLi8CDCEqeX
 sHfWCbB5rbP3CJU33gfqT8fUgZum5s2BoDKo26ZBIIDAnrsCWJlYvMbXi
X-Gm-Gg: AY/fxX55ojfsIluTDK4/+QGX/2loeCu81IdC1OlSjz43zVs9AA6dMpjRCexDwKmWEgO
 GfGYKzGiGVe48UW3RjSvoBkTo6ncZwHlobWGB4jxewOInKM5fpO3rwXqzT6BtXI23cka7wYYTnY
 gMurtaQPznFWYDjbx22+r+Oh9eGVlbf3HPxLiTmPHvATHYcATe2Xh2DeNUcTQDDLbsw67Gk+553
 9T7uxTmD0Tk5lx4fvZKeqmA7jDE1ohz9CTcpr/CKzuzPcj8633cppBKhjLG18AvRYxQDnhkVpS7
 hZCKO8rA9sOzP+crrlxU9E8F2Rq0Bq4lpc8QGmy9Q6zqvxjIsK1m9drxftVp+w03A9QgRCaIsea
 3fF+EEwxiBLZWafo/DtGRgIfoIP9J8yT5hbeUcUe367ud58M3
X-Received: by 2002:a05:6000:a88:b0:432:c0b8:ee42 with SMTP id
 ffacd0b85a97d-432c0b8ef25mr12242143f8f.11.1767970101173; 
 Fri, 09 Jan 2026 06:48:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjInm2AX+yFjCn0CGoGmzlhr8s2iXQRpTdueGZO9iq88DczpIwLU+jBxjlgxtaiTI2NEC5gw==
X-Received: by 2002:a05:6000:a88:b0:432:c0b8:ee42 with SMTP id
 ffacd0b85a97d-432c0b8ef25mr12242110f8f.11.1767970100691; 
 Fri, 09 Jan 2026 06:48:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0daa84sm22653363f8f.2.2026.01.09.06.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 06:48:19 -0800 (PST)
Message-ID: <361f986e-c053-424d-b0f5-091f3872650c@redhat.com>
Date: Fri, 9 Jan 2026 15:48:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/4] Implement ERRATA_772415 quirk for VTD
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20260106062808.316574-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260106062808.316574-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/6/26 07:28, Zhenzhong Duan wrote:
> Hi,
> 
> Based on Cédric's suggestions[1], The nesting series v8 is split to
> "base nesting series" + "ERRATA_772415_SPR17 quirk series", this is the
> ERRATA_772415_SPR17 quirk series.
> 
> On a system influenced by ERRATA_772415, IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
> is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the readonly
> range mapped on second stage page table could still be written.
> 
> Reference from 4th Gen Intel Xeon Processor Scalable Family Specification
> Update, Errata Details, SPR17.
> Link https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/eagle-stream/sapphire-rapids-specification-update/
> Backup link https://cdrdv2.intel.com/v1/dl/getContent/772415
> 
> Also copied the SPR17 details from above link:
> "Problem: When remapping hardware is configured by system software in
> scalable mode as Nested (PGTT=011b) and with PWSNP field Set in the
> PASID-table-entry, it may Set Accessed bit and Dirty bit (and Extended
> Access bit if enabled) in first-stage page-table entries even when
> second-stage mappings indicate that corresponding first-stage page-table
> is Read-Only.
> 
> Implication: Due to this erratum, pages mapped as Read-only in second-stage
> page-tables may be modified by remapping hardware Access/Dirty bit updates.
> 
> Workaround: None identified. System software enabling nested translations
> for a VM should ensure that there are no read-only pages in the
> corresponding second-stage mappings."
> 
> QEMU code can be found at [2], it's based after below two series:
> 
> [PATCH v10 00/19] intel_iommu: Enable first stage translation for passthrough device
> [PATCH v6 0/9] vfio: relax the vIOMMU check
> 
> Thanks
> Zhenzhong
> 
> Changelog:
> v10:
> - All headers under include/hw/ have been moved to include/hw/core/, do
>    the same for iommu.h (Cédric)
> 
> v9:
> This is a new split from nesting series, see the link[3] for history changelog.
> 
> [1] https://lore.kernel.org/qemu-devel/bbc8412b-25c3-4c95-9fde-a1c9c29b54ce@redhat.com/
> [2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_ERRATA_772415.v10
> [3] https://lore.kernel.org/qemu-devel/20251117093729.1121324-1-zhenzhong.duan@intel.com/
> 
> 
> Zhenzhong Duan (4):
>    hw/pci: Introduce pci_device_get_host_iommu_quirks()
>    intel_iommu_accel: Implement get_host_iommu_quirks() callback
>    vfio/listener: Bypass readonly region for dirty tracking
>    Workaround for ERRATA_772415_SPR17
> 
>   docs/devel/vfio-iommufd.rst      |  9 ++++++
>   hw/i386/intel_iommu_accel.h      |  5 ++++
>   include/hw/core/iommu.h          |  5 ++++
>   include/hw/pci/pci.h             | 31 ++++++++++++++++++++
>   include/hw/vfio/vfio-container.h |  1 +
>   include/hw/vfio/vfio-device.h    |  3 ++
>   hw/i386/intel_iommu.c            |  2 ++
>   hw/i386/intel_iommu_accel.c      | 21 ++++++++++++++
>   hw/pci/pci.c                     | 12 ++++++++
>   hw/vfio/device.c                 | 14 +++++++++
>   hw/vfio/iommufd.c                |  9 +++++-
>   hw/vfio/listener.c               | 50 +++++++++++++++++++++++++-------
>   hw/vfio/trace-events             |  1 +
>   13 files changed, 151 insertions(+), 12 deletions(-)

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


