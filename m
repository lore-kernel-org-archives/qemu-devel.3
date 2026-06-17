Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0C5CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZoJR-0004MD-VS; Wed, 17 Jun 2026 07:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wZoJI-0004LA-KK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wZoJG-0002jn-K9
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781695192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZAoga0oC+iVKdLbNIEPMkEcyeRGCdZjKHBJ6qJIXT4=;
 b=gy1Nlcbh7hBBsegUKzT23sc7SgBt6xOwxg43vN36g7uCsu/30i14rft25slGHjEujS5CSS
 qmKRRtqn7PErb3WMCslThHxqN3N/cDb6WGFJlsN4ruM/cjOCbPUecyAPdWDonODcaYFyca
 sM3vJ7NLt9zEIUNwaNL/tkzJsBLzAGc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-hcOW016kOLuMYsNBb1_9PQ-1; Wed, 17 Jun 2026 07:19:48 -0400
X-MC-Unique: hcOW016kOLuMYsNBb1_9PQ-1
X-Mimecast-MFC-AGG-ID: hcOW016kOLuMYsNBb1_9PQ_1781695188
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-46250b59ed5so561201f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 04:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781695187; x=1782299987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZAoga0oC+iVKdLbNIEPMkEcyeRGCdZjKHBJ6qJIXT4=;
 b=ntSv2ZF1KWF5JFV6RBkplYOAPWw021Z3rQnvdxUWW+AOAZEnbOvKCGMHeeJ369nOpl
 ECVcnn0/i1a1Wrn+XSozI4jGjcysPTbsFYx5IHRSqWv1dCOaUv2lmKSODfeKhALJRCAz
 H9et2w04dufhOCQ2bdI1airTIGMPzOvU4zmiitrSH6cPDnwMx7Xb+FXTGRsJBpRgXgxL
 N5h/GNv2DYnztcDyG5ZBh2c62cAvxK8XnAhMbmLRg1LJGW1W8o+tP0HS6Jf6Nl5HGVqt
 0LLPgwpvoqa602YfWD2D8OC6suCa1UBrEmlr2fQ9+Rc9NGBzdYrQ0HlAgz9iRgyM7w2q
 63sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781695187; x=1782299987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BZAoga0oC+iVKdLbNIEPMkEcyeRGCdZjKHBJ6qJIXT4=;
 b=KkZ6VO0LhMLhJOB3HwBQPzzvsyFR+yRYRBMdz0EGw4ugT4snzWg/G1PMjlCCKO/cPZ
 gUvxTM1pYYSm/9jZfJ8kVHxrJuVf6KHpTMkz4JLsyQC0fyPcLvOBwlNnsnLITYVl6gXZ
 xCM6IUFHnDw1QqEifBiK+YE6Vz4CuqzFPVrdRBY5lWMSjjfFtun9mgpw+/nXxsFeVB8I
 hWfCJznTl+t0mWd5fLYjQIzA1S1qR1SIuSO4AcNGGj2ZtXpgMFtC0USPKyNBrjlyR6qa
 BgFjp4cSHhWCRF9gixotz7gYWy5a5h7sK/wXUu0RlJvSi+IkYPB+Y0Mcw2LCSIwvSIoS
 a+8w==
X-Gm-Message-State: AOJu0YwkiahGVgv6Ad/0XDqImSv0wOW1SYTdK+w8Qv9olYqY4cIM9krh
 uzGH91KU8Khh+N/Q8VaAyaM3PaYq0r7IgSgKnpUhek26q/XfxDO3Btk9HsO31iBehmIWDiuWzKl
 7zZJrzUrC1zCmt3xWl32Dq+HGvUPqpYmsUutb3Ol7sd9o0PcYHsxozdFp
X-Gm-Gg: AfdE7cmH4fLnVXJ+M6QML46IK+E0GQYeoDFyYkY2+h2ce54tZwTCwVKYfmmxcg/YCXl
 k2+4NIqJJpmiEsE9dl/tto1DpDZqCAu5wr0Bt0AEyh03LuKYFsX20IfpWnBOfeLnjrjIBb0F4ip
 OK7vUEBvuBx1P31/GA3mj598qy+PC8KWnSLb2hCmMf+UJOZgTFxPBzVw3zXRXr6YeDV4qK84kuK
 gCGlXqqmXetfimxpt5cOJ5E4ZTALwxNZt0l0cwbCDrhwHdNBLpYbpLClNz1TWVvdHDDwLCfO87E
 ff+4hW17Kt9P55WOtWXjzfrstOpAOaqqBKHdwC1+Kl3wwmoVceNBM4O2y1klM3gsO9MBSUo=
X-Received: by 2002:a05:6000:2683:b0:45e:de42:6e90 with SMTP id
 ffacd0b85a97d-462386f3fbemr6237055f8f.37.1781695187617; 
 Wed, 17 Jun 2026 04:19:47 -0700 (PDT)
X-Received: by 2002:a05:6000:2683:b0:45e:de42:6e90 with SMTP id
 ffacd0b85a97d-462386f3fbemr6237015f8f.37.1781695187208; 
 Wed, 17 Jun 2026 04:19:47 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-461eaa0d1c7sm9798088f8f.7.2026.06.17.04.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 04:19:46 -0700 (PDT)
Date: Wed, 17 Jun 2026 13:19:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <gourry@gourry.net>,
 <philmd@mailo.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v12 0/4] hw/mem: add sp-mem device for Specific Purpose
 Memory
Message-ID: <20260617131945.5d7cbc5f@imammedo>
In-Reply-To: <20260616090808.3047939-1-FangSheng.Huang@amd.com>
References: <20260616090808.3047939-1-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 16 Jun 2026 17:08:04 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> This series adds a TYPE_MEMORY_DEVICE subclass `sp-mem` for boot-time
> SOFT_RESERVED guest memory, following the direction from the v7
> thread [1] and the v8 / v9 / v10 / v11 reviews [2][3][4][5].

review is done, modulo cosmetic patch restructuring and missing tests
LGTM.

as for adding duplication, I'm expecting cleanup/consolidation
refactoring on top, that I've asked for in earlier reviews. 

> 
> Background
> ----------
> 
> This series targets coherent CPU + accelerator shared-address-space
> systems, where the accelerator's HBM is not a device-private
> framebuffer behind a PCIe BAR but a tier of host system memory:
> visible to the CPU in the platform physical address space, shared
> coherently with the accelerator over the platform fabric, and bound
> to a NUMA proximity domain set by platform firmware at boot fabric
> training.
> 
> For such a region to function correctly in the guest, two things
> must hold simultaneously: the CPU memory subsystem has to see it in
> the system memory map (so the CPU side can address it), and it has
> to be reserved exclusively for the accelerator's driver (so the
> kernel's general allocator does not hand SPM pages to unrelated
> workloads). The SOFT_RESERVED memory type in E820 plus a matching
> SRAT memory-affinity entry is the mechanism that delivers both: a
> firmware-produced topology that the CPU memory subsystem honors and
> the accelerator's driver consumes for its own range.
> 
> Approach
> --------
> 
> The series introduces a new TYPE_MEMORY_DEVICE subclass `sp-mem`.
> Each instance binds one host memory backend to a single NUMA
> proximity domain and is boot-time only; placement, mapped-state
> enforcement, and QMP introspection come from the existing
> memory-device framework.
> 
> Testing
> -------
> 
> Verified end-to-end on q35 + KVM, with both SeaBIOS and OVMF, for:
> 
> - single sp-mem instance
> - two sp-mem instances on different NUMA nodes
> 
> Guest observations: /proc/iomem shows one SOFT_RESERVED entry per
> sp-mem device, dmesg SRAT parsing reports the matching
> memory_affinity entries with correct PXM, and the umbrella
> HOTPLUGGABLE entry covers the remaining hotplug-memory window
> without overlapping the sp-mem ranges.
> 
> Changes since v11
> -----------------
> 
>   - Drop the unneeded memory-device.h and system/hostmem.h includes
>     from sp-mem.h (HostMemoryBackend is forward-declared).
>   - Use SP_MEM_MEMDEV_PROP in sp_mem_get_memory_region()'s error
>     message, matching realize().
>   - Move the .unmigratable comment next to the field it documents.
> 
> All v11 patch-1 review comments from Philippe; patches 2-4 unchanged.
> Patch 4 (MAINTAINERS) retains the Acked-by from Igor and David.
> 
> Previous versions
> -----------------
> 
>   v1: https://lore.kernel.org/qemu-devel/20250924103324.2074819-1-FangSheng.Huang@amd.com/
>   v2: https://lore.kernel.org/qemu-devel/20251020090701.4036748-1-FangSheng.Huang@amd.com/
>   v3: https://lore.kernel.org/qemu-devel/20251208105137.2058928-1-FangSheng.Huang@amd.com/
>   v4: https://lore.kernel.org/qemu-devel/20251209093841.2250527-1-FangSheng.Huang@amd.com/
>   v5: https://lore.kernel.org/qemu-devel/20260123024312.1601732-1-FangSheng.Huang@amd.com/
>   v6: https://lore.kernel.org/qemu-devel/20260226105023.256568-1-FangSheng.Huang@amd.com/
>   v7: https://lore.kernel.org/qemu-devel/20260306082735.1106690-1-FangSheng.Huang@amd.com/
>   v8: https://lore.kernel.org/qemu-devel/20260527074215.229119-1-FangSheng.Huang@amd.com/
>   v9: https://lore.kernel.org/qemu-devel/20260602084447.1100554-1-FangSheng.Huang@amd.com/
>   v10: https://lore.kernel.org/qemu-devel/20260605104609.1739911-1-FangSheng.Huang@amd.com/
>   v11: https://lore.kernel.org/qemu-devel/20260611100637.2460507-1-FangSheng.Huang@amd.com/
> 
>   [1] v7 thread closeout:
>       https://lore.kernel.org/qemu-devel/666a7ba1-5d3a-4732-b872-0d9fb2fe8461@amd.com/
>   [2] v8 review:
>       https://lore.kernel.org/qemu-devel/20260601105057.2d764e55@imammedo/
>   [3] v9 review:
>       https://lore.kernel.org/qemu-devel/20260602084447.1100554-1-FangSheng.Huang@amd.com/T/
>   [4] v10 review:
>       https://lore.kernel.org/qemu-devel/20260605104609.1739911-1-FangSheng.Huang@amd.com/T/
>   [5] v11 review:
>       https://lore.kernel.org/qemu-devel/20260611100637.2460507-1-FangSheng.Huang@amd.com/T/
> 
> fanhuang (4):
>   hw/mem: add sp-mem device for Specific Purpose Memory
>   i386/acpi-build: partition device_memory SRAT umbrella for sp-mem
>   hw/i386: hook sp-mem into the pc machine plug path
>   MAINTAINERS: cover sp-mem under Memory devices, add R: tag
> 
>  MAINTAINERS                  |   3 +
>  qapi/machine.json            |  43 ++++++++++-
>  hw/i386/e820_memory_layout.h |  11 +--
>  include/hw/mem/sp-mem.h      |  33 +++++++++
>  hw/core/machine-hmp-cmds.c   |  11 +++
>  hw/i386/acpi-build.c         |  96 +++++++++++++++++++++++--
>  hw/i386/pc.c                 |  36 ++++++++++
>  hw/mem/sp-mem.c              | 136 +++++++++++++++++++++++++++++++++++
>  hw/i386/Kconfig              |   2 +
>  hw/mem/Kconfig               |   4 ++
>  hw/mem/meson.build           |   1 +
>  11 files changed, 365 insertions(+), 11 deletions(-)
>  create mode 100644 include/hw/mem/sp-mem.h
>  create mode 100644 hw/mem/sp-mem.c
> 
> 
> base-commit: 2f28d34ea0aead9830478cd1d3d0dd9d9191d82e
> --
> 2.34.1
> 


