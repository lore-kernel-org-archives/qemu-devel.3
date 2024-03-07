Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61222C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 22:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riMNP-0000NI-1f; Thu, 07 Mar 2024 17:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riMNL-0000Mx-15
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 17:38:08 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riMNI-0003Wo-Tc
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 17:38:06 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33e2268ed96so197092f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 14:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709851082; x=1710455882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0fRUzhx9TipIh2U5F16qB9UBZ+vO/FO6wIfMDbXLTlQ=;
 b=VKzRM29eeuyFdtkrVnGmxuq+Qx6yDekhat0xCAp21tQu2UMN4dQZvCD6SF6sDjMia1
 GWaooDJ8zb2jNiphgTH2vvn5SZfr18xOOu/CZHfZwNos/zc0dKcH3s/973zGnisVBCBW
 1qNCWkk+FiZ1ETrAtxRCSWAirNqHs8uPcOVdqp//oQ7hUZUit55lsOk638s0i628mpN2
 0r5umC9cllE6iMQRZHACJ/EmXLwdpPMGZXBXLAau/R+iIzSla7pEThtFBaRlmMaFKux4
 sJB2dJ+YMzjCE0gG2rp/EfdveZcFREC7RVZ+JbUC+Ijw0qCCS5xovev9Y8wNcGyMouyl
 jGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709851082; x=1710455882;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0fRUzhx9TipIh2U5F16qB9UBZ+vO/FO6wIfMDbXLTlQ=;
 b=Bc8Kap7MlVYF+02cM8b610LUvuRh2FQPMCULcyXb+jmnSIoaBxuuLewwkSI2UwyeF2
 q1okLQ3iggsBvah/EULqlAI+9vcL6F2U/e9+/SHGfQ/sHh18pJpLiIR4pNaHNCvULP5D
 EKoAzYyFFpfRBm59+qKZsWiQE7fWY1zdUcBJLVz+Ijx1Nbc3mJRG7Xqc7JOuoJBtwnOp
 KX1joBL6zajM/ZjZTHjmi4wENAzuCVy0kP4/K5kjZLaXdL95HCGY33RCh4Sm+DxBQUg/
 71p4yqg7ce/995QWqkuAc2K5Kru/eeyh22Eo90N60NeB4igNDHLFkh1kuX9iheKGrxtf
 pqwA==
X-Gm-Message-State: AOJu0YzXqaER+daPZyUKyQd5P7SC5zAXPBM0Qw69OU+n5cozqBp6azL4
 X2yc9ok21z1xP6Q52MMvcaN7NCSZ2wz1DZ96Cg6cBq+Bexnts5qK7NBCF238RK+qWBU6TqdhJqK
 5
X-Google-Smtp-Source: AGHT+IEsylRNJJYzoboGzoscHglDTKNL5VECMQV8HSkKNjKTQHJFceUTrXyr6dzH9IJ+9J6EqGIkTA==
X-Received: by 2002:adf:f911:0:b0:33e:2099:88da with SMTP id
 b17-20020adff911000000b0033e209988damr13905850wrr.44.1709851081734; 
 Thu, 07 Mar 2024 14:38:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bp16-20020a5d5a90000000b0033e0567e90bsm22080279wrb.5.2024.03.07.14.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 14:38:01 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EA3495F873;
 Thu,  7 Mar 2024 22:38:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 4/5] include/exec: annotate all the MemoryRegion fields
In-Reply-To: <ee463c40-8134-4eb7-91ef-23b5f428bb3d@linaro.org> (Richard
 Henderson's message of "Thu, 7 Mar 2024 10:41:27 -1000")
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
 <20240307181105.4081793-5-alex.bennee@linaro.org>
 <ee463c40-8134-4eb7-91ef-23b5f428bb3d@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Thu, 07 Mar 2024 22:38:00 +0000
Message-ID: <87sf11u0qf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 3/7/24 08:11, Alex Benn=C3=A9e wrote:
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   include/exec/memory.h | 47 +++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 43 insertions(+), 4 deletions(-)
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 17b741bc4f5..312ed564dbe 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -778,9 +778,48 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, voi=
d **vaddr,
>>   typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>>   typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
>>   -/** MemoryRegion:
>> - *
>> - * A struct representing a memory region.
>> +/**
>> + * struct MemoryRegion - represents a memory region
>> + * @parent_obj: parent QOM object for the region
>> + * @romd_mode: if true ROM devices accessed directly rather than with @=
ops
>> + * @ram: true if a RAM-type device with a @ram_block
>> + * @subpage: true if region covers a subpage
>> + * @readonly: true for RAM-type devices that are readonly
>> + * @nonvolatile: true for nonvolatile RAM-type devices (e.g. NVDIMM)
>> + * @rom_device: true for a ROM device, see also @romd_mode
>> + * @flush_coalesced_mmio: true to flush any queued coalesced MMIO
>> + * operations before access
>> + * @unmergeable: this section should not get merged with adjacent
>> + * sections
>> + * @dirty_log_mask: dirty events region cares about (see DIRTY_ flags)
>> + * @is_iommu: true if part of an IOMMU device
>> + * @ram_block: backing @RamBlock if @ram is true
>> + * @owner: base QOM object that owns this region
>> + * @dev: base Device that owns this region
>> + * @ops: access operations for MMIO or @romd_mode devices
>> + * @opaque: @dev specific data, passed with @ops
>> + * @container: parent `MemoryRegion`
>> + * @mapped_via_alias: number of times mapped via @alias, container
>> + * might be NULL
>> + * @size: size of @MemoryRegion
>> + * @addr: physical hwaddr of @MemoryRegion
>> + * @destructor: cleanup function when @MemoryRegion finalized
>> + * @align: alignment requirements for any physical backing store
>> + * @terminates: true if this @MemoryRegion is a leaf node
>> + * @ram_device: true if @ram device should use @ops to access
>> + * @enabled: true once initialised, false once finalized
>> + * @vga_logging_count: count of memory logging clients
>> + * @alias: link to aliased @MemoryRegion
>> + * @alias_offset: offset into aliased region
>> + * @priority: priority when resolving overlapping regions
>> + * @subregions: list of subregions in this region
>> + * @subregions_link: next subregion in the chain
>> + * @coalesced: list of coalesced memory ranges
>> + * @name: name of memory region
>> + * @ioeventfd_nb: count of @ioeventfds for region
>> + * @ioeventfds: ioevent notifiers for region
>> + * @rdm: if exists see #RamDiscardManager
>> + * @disable_reentrancy_guard: if true don't error if device accesses it=
self
>>    */
>
> Why as one big block rather than line by line?
> The block is less likely to be properly kept up-to-date and is much
> harder to read.

The inline syntax is a little more prone to parse failures and
annoyingly can't group multiple fields in one inline comment block. But
I can certainly move it inline if that preferable.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

