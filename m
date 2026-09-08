Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7225BC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3rq6-0006Fo-I1; Tue, 08 Sep 2026 05:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1x3rq5-0006FS-3Z
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:10:01 -0400
Received: from mail-oo2-x02.google.com ([2607:f8b0:4864:31::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1x3rq3-0002uJ-52
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:10:00 -0400
Received: by mail-oo2-x02.google.com with SMTP id
 006d021491bc7-6bd3ee01a0dso50612eaf.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788858597; x=1789463397; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=71Mpuv729WYbiaUyjl4E7MxfENwavn5KXYJix8I7SxQ=;
 b=e9ZaeZGjpH16KX97oLvSyhtIiZGgzcYS8+FaBDcLCMb/6CEnPzoDHO3ZA1vEMeqS0I
 eQULrY7ufq6iRC96MLdeYJsHmC11uzFSEjgjJ/1Lg+yDkx3ir2E6ZYnldhUG3/btJoOg
 IHYjlPKsscaCadeUI3tGx+oEScTNQKnpnlBWrBazWCjTm3n2g4E0PDQplw948B+k8qer
 xRJ/vUUHHa8aT1a768/JczLcNrIxqDl0Gh0m1IntorsMbAzJyF5dUIGgAhU8dIceAr5P
 SNgHmkougS2OJiLeh+PhRKCxghje49anz04Bytbzh94M8uPUuyQktFD9cGY9fGEQ6WI6
 UR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858597; x=1789463397;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=71Mpuv729WYbiaUyjl4E7MxfENwavn5KXYJix8I7SxQ=;
 b=k6D8v9GY02RsEhnTzTm5sxwOcud41VfAGTV7n4JmKRVe5H9ndgN0XhgxK0upd50rI5
 fMv4RmOKVU9ScmVQnv//Swg2v+/rfim9kLUUmxtqABNkvl6hsB8S8dMSENyvt57cpaCN
 yA59YiPtmfil2NiqamB43zYL7mmFuWUlt4BqMVfqgSArWlbWHor3tKuMUL/3LKbXyZMg
 0A1Fb/xrTc7Jypk4ycS5bKAnjtLD/F3uRfyTxAxVeyZ/DtrVMmYao14eQyVm1A62jJVm
 l/j0U1ADmOf9F+CcZeoiygmNL7K1c6jUH83yxF+AQcVdBm9XeQmSOqB3b1FDBf71KCu8
 wYhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpjxRQBVjLDQdRAkD+Vwn+swN3vnZNmvOlB8F3v+l6gmtDTU4BkYJrXbBfYZ2mE9e2nFVlrf9Q2hsq@nongnu.org
X-Gm-Message-State: AFuF++l/noAOL+jDpyDW2WRZjIySBD0QgMEn9nHEP/BzFlIqhDp3B6Wj
 3HAFKpaLZnh6E1eR5uZ9D4x/2cLiWjTT1rVApXH7kmVu/yrcS5TvZg4=
X-Gm-Gg: AYBFou3tnsfPScuo65dszxxXYi0w3KqcnsNJ5keTiw++HJndTscHJUH/CarBTjp4wHT
 AWOoF3MQpkZhxz4hExgkp/o08d/e8YyNUEehmBx4OmvMXSrb+5KM6XV/q2IrfACyAL+9Er4olT6
 Sd0kuqpx9r+KUB9R2GQXRa3oRtNvDqDYKVgMfzl2XLafFMNgrdRId4TqU15ZoI0clXM0PDsEq+L
 g/Lqp4fkOLQX3lpzCumhtEY0Vra8piPUxlIkEE9JVTqfmSE1d0sNZryLZ2Spk6wLf0anLWvqGLq
 iTdF1baFKpMCWYYIRI/8K0VTSJqY6be2XQtYmMYPY3p50k2tRFiAc4a0B9EP0RRRK02aIqCliVg
 j0Uq/aI8Q2wcGsf2GemkhnzQ5bdBLzlYRjZZzJSiZWrhI1mnQwMBcCIsE3g3dGN34Pdh/g3DCYt
 8Jpjm6Svc9BH0Q/GFZ1gr83QBI/JzZG5/9L7uoj3kbE+BgkkBusAkGMZ2xAimugH0vqhheLYahP
 XcAKJUUZVcnCF/Al1P6RkCdd36IarObDGBKMjv+nA==
X-Received: by 2002:a05:6820:809:b0:6b3:519e:dfdf with SMTP id
 006d021491bc7-6b6fc7d3f12mr15654689eaf.28.1788858597459; 
 Tue, 08 Sep 2026 02:09:57 -0700 (PDT)
Received: from ?IPV6:2408:820c:8ffa:c0f0:25c7:53f7:86b3:955?
 ([2408:820c:8ffa:c0f0:25c7:53f7:86b3:955])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-334fbd5e6f6sm27287446eec.23.2026.09.08.02.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 02:09:57 -0700 (PDT)
Message-ID: <2dde7fa2-de05-4a8b-91d0-22e0fb1df107@gmail.com>
Date: Tue, 8 Sep 2026 17:09:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/igd: Add device ID support for Meteor Lake and
 Arrow Lake
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Yuan Wang <yuan1.wang@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com
References: <20260825090435.1492485-1-yuan1.wang@intel.com>
 <c425dffd-ccc6-42b0-b083-51f06562237d@gmail.com>
In-Reply-To: <c425dffd-ccc6-42b0-b083-51f06562237d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::2;
 envelope-from=tomitamoeko@gmail.com; helo=mail-oo2-x02.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 2026-09-08 13:09, Tomita Moeko wrote:
> Reviewed-by: Tomita Moeko <tomitamoeko@gmail.com>

Sorry I'd like to withdraw this Reviewed-by... 
> Thank you for your contribution!
> 
> On 2026-08-25 17:04, Yuan Wang wrote:
>> Currently, igd_gen() does not include the PCI device IDs for Meteor
>> Lake and Arrow Lake platforms, causing it to return -1 for these GPUs.
>>
>> As a result, QEMU calculates the stolen memory size as 0 and exposes a
>> zero-sized 'etc/igd-bdsm-size' entry via fw_cfg. When OVMF boots,
>> IgdAssignmentDxe fails validation on the zero BDSM size and aborts
>> without programming the ASLS register. Consequently, the guest Intel
>> GOP driver fails to locate and read the OpRegion (ASLS remains 0x0).
>>
>> Add the device ID prefixes (0x7D00 and 0xB600) to igd_gen() as Gen 12
>> so that stolen memory is correctly determined, allowing OVMF to properly
>> initialize the OpRegion and BDSM for the Intel GOP driver.
>>
>> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
I took a deeper look about the change, this change actually changes
vfio_probe_igd_bar0_quirk() to go with the 64-bit emulated BDSM register
path, right? But the problem is, does the BDSM register really exists on
Meteor/Arrow Lake and later iGPUs?

In drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c:xe_ttm_stolen_mgr_init()

	if (IS_SRIOV_VF(xe))
		stolen_size = 0;
	else if (IS_DGFX(xe))
		stolen_size = detect_bar2_dgfx(xe, mgr);
	else if (GRAPHICS_VERx100(xe) >= 1270)  // MTL+
		stolen_size = detect_bar2_integrated(xe, mgr);
	else
		stolen_size = detect_stolen(xe, mgr);

For Meteor Lake and later, detect_bar2_integrated() is called. The DSM
region used is at (BAR2 + 8M).

	/*
	 * Graphics >= 1270 uses the offset to the GSMBASE as address in the
	 * PTEs, together with the DM flag being set. Previously there was no
	 * such flag so the address was the io_base.
	 *
	 * DSMBASE = GSMBASE + 8MB
	 */
	mgr->stolen_base = SZ_8M;
	mgr->io_base = pci_resource_start(pdev, 2) + mgr->stolen_base;

drivers/gpu/drm/i915/gem/i915_gem_stolen.c:i915_gem_stolen_lmem_setup()
also suggests it is (BAR2 + 8M) on MTL (i915 only supports up to MTL)

	if (HAS_LMEMBAR_SMEM_STOLEN(i915)) {  // Only True for MTL
		/*
		 * MTL dsm size is in GGC register.
		 * Also MTL uses offset to GSMBASE in ptes, so i915
		 * uses dsm_base = 8MBs to setup stolen region, since
		 * DSMBASE = GSMBASE + 8MB.
		 */
		ret = mtl_get_gms_size(uncore);
		if (ret < 0) {
			drm_err(&i915->drm, "invalid MTL GGC register setting\n");
			return ERR_PTR(ret);
		}

		dsm_base = SZ_8M;
		dsm_size = (resource_size_t)(ret * SZ_1M);

		GEM_BUG_ON(pci_resource_len(pdev, GEN12_LMEM_BAR) != SZ_256M);
		GEM_BUG_ON((dsm_base + dsm_size) > lmem_size);
	} else {
		...
	}

	if (i915_direct_stolen_access(i915)) {
		...
	} else if (pci_resource_len(pdev, GEN12_LMEM_BAR) < lmem_size) {
		...
	} else {  // MTL
		io_start = pci_resource_start(pdev, GEN12_LMEM_BAR) + dsm_base;
		io_size = dsm_size;
	}

In addition, nothing about the BDSM register can be found in MTL datasheet vol2,
neither 32-bit 0x5C nor 64-bit 0xC0. I believed it is removed since Meteor Lake.
https://edc.intel.com/content/www/us/en/design/publications/14th-generation-core-processors-cfg-and-mem-registers/d2-f0-processor-graphics-registers/

Since you are probably an intel employee (from your mail address), you may check
the GOP driver code to see if the BDSM register (0x5C/0xC0 in config space and
0x1080C0 in BAR0) is really used or not. Please kindly correct me if I am wrong.

For the "IgdAssignmentDxe fails validation on the zero BDSM size and aborts
without programming the ASLS register", having a fix skipping BDSM size check
on Meteor Lake and later ones could make it work? OpRegion is automatically
detected and exposed to guest on IGD as I remember.

Thanks,
Moeko
>> ---
>> v2:
>> - Resending because the v1 patch was sent with an incorrect future 
>>   system timestamp due to an unsynchronized local clock. No code
>>   changes.
>> ---
>>  hw/vfio/igd.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index 413a49aae9..a0b6b34d81 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -96,6 +96,8 @@ static int igd_gen(VFIOPCIDevice *vdev)
>>      case 0x4C00:    /* Rocket Lake */
>>      case 0x4600:    /* Alder Lake */
>>      case 0xA700:    /* Raptor Lake */
>> +    case 0x7D00:    /* Meteor Lake / Arrow Lake */
>> +    case 0xB600:    /* Arrow Lake */
>>          return 12;
>>      }
>>  
> 


