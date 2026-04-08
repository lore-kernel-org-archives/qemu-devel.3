Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6107510F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXsz-0002Pc-2g; Wed, 08 Apr 2026 14:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAXsw-00022f-1H
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAWuE-0000Ll-TG
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 13:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775670092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4BP+lMZaOrzehJh50THLk3PJdfBSmqrdJwD4Qv48sOY=;
 b=OreloGizAaoKYkQnHpTUpQY3WfNT7XP4s+oSvor4wBK2V/2Te3V+1ukBlcHTclaCfPNQvg
 MBXPmBtyJkn0FETf1egNybB7qs6xzM03OXZSq0FLnZlhpnzos/6szNOCQ21swFflM3CT8W
 Y8GWz2VJHx8cA4mbmdKny5E91u0P0jE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-545u4FXWMnWCn0F_eg3kHA-1; Wed, 08 Apr 2026 13:41:24 -0400
X-MC-Unique: 545u4FXWMnWCn0F_eg3kHA-1
X-Mimecast-MFC-AGG-ID: 545u4FXWMnWCn0F_eg3kHA_1775670083
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b91b5dd24so43641f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775670083; x=1776274883; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4BP+lMZaOrzehJh50THLk3PJdfBSmqrdJwD4Qv48sOY=;
 b=q2z3LUFkQaR5qMSUd3s/t7Rv9q94kQ7zVdX2mnqxNOXokGWBhsmFCSsO3nkRIgy6jm
 8mKkFTmsA5dv7tlaSHvaCpzRQ7AkDUkpmW6D4BEV0kXzPEcMlF6YpfzvnQLaoW2D/YGp
 pxQOoaMuFh14aV93AnlZj52x568jRS60z2voM+XWvIfenxCSBA6NghXwGji2hJL3RoYA
 I02W5eSEp+MNCa6uqydh+od/2cro/l38OYEXLPcea1vEekkkvV1z6M0zGoIzzDrwiHUF
 ZJQ8jN8sJOEQatcdtLdAajMk9LmtCOhT37bPsnnUcu/ol/Gv8jbN7/PhGQG55hP/dHE6
 1dsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775670083; x=1776274883;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BP+lMZaOrzehJh50THLk3PJdfBSmqrdJwD4Qv48sOY=;
 b=ZsrXw3jmHIH3Zk0SAxTd1FE946FbnOQ4MOJUvP1vCm6gGjl06+iHuDT8nwmr7UeaOi
 YtxwuxnuCf2idOcx5PnDB3L/wrepsUO48gNJs5UvD6x6UPM6fSjhXbNdh9ptDySc1n14
 mOk/SNWXmSakuiD37nE3WpShQk+eXrNBbxruyk6m6cvycYlHk8555/8TyCMGmoOjcgBN
 0Y2zcMLwe3czvl3LkPqmoZ3cS0ui4ksy+mDvwXEjHrOh9nl+em6iJczWDdCvcfJ6e6UH
 iF2vOhH2/u6iaWKbCnEh8MxS8vJj7EoHXp4g8kZgcq7e25keQX7fOLgdYVOTpvaNprLe
 evTg==
X-Gm-Message-State: AOJu0YzsmDPjidGvRiJZg1zULiKOM2HTCrlGLb0eCPplXh/XIAAK/Xk2
 +A9E5R6j2vMiYK+wi1Vwi/1dt2H+2Ccr6VXRNNHuGLLTNqVPyaluTZiWag7qGh5uy7seqfSD9A7
 6pRtkpP/f5JrocdYkFd7X2Of/4q8QbZZisFaaB5tHcWEijzAcRauXFOL4
X-Gm-Gg: AeBDietImOUA5zKAn9i3pJ0IOPZXXpVOXVBQ2sqcRemh3/8AMySsbFOvykh8vDwrXmE
 fkrxAls0ZdpGMw4T0bppnGwz4LAbqnyc/AEa/JJ81CbivzPKVOKKnDGMrURNhAZGJm9bmDroRc3
 NMMM7YbJ8ZAtXgHXbDs7gbiEcUBj2j8wWrbU6azkHAspboJWihXQam3hFGDoCaGLavt7juwmdmK
 Unpxft5kuaDAF1zMRc4aRSC8ZW88j21FIaaa9vn1Yv1zbfvdUmkG49lZ1c1xFpfOKj+ctZzp/Bb
 L4uoDmMgdChbIwf5mn7N5Ha4sPTWZo69dvZWmIs59hv3VVdZGGUNlfoWK2Nqy2EO3nYH75Sqd86
 CTbPS5PerYxtZJcyLBUclmmSLYqGW35yiV+uREgU=
X-Received: by 2002:a05:6000:2881:b0:43b:9227:bc6e with SMTP id
 ffacd0b85a97d-43d5a18e99fmr219578f8f.24.1775670082623; 
 Wed, 08 Apr 2026 10:41:22 -0700 (PDT)
X-Received: by 2002:a05:6000:2881:b0:43b:9227:bc6e with SMTP id
 ffacd0b85a97d-43d5a18e99fmr219548f8f.24.1775670082136; 
 Wed, 08 Apr 2026 10:41:22 -0700 (PDT)
Received: from fedora (nat-88-212-17-233.antik.sk. [88.212.17.233])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f5016sm64532489f8f.33.2026.04.08.10.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 10:41:21 -0700 (PDT)
Date: Wed, 8 Apr 2026 19:41:18 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 00/11] vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Message-ID: <adaS95U5bgZ_XVZC@fedora>
References: <20260401202844.673494-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401202844.673494-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Peter,

On 2026-04-01 16:28, Peter Xu wrote:
> CI: https://gitlab.com/peterx/qemu/-/pipelines/2424266591
>     (one checkpatch warning, not relevant to this series)
> 
> rfcv1: https://lore.kernel.org/r/20260317232332.15209-1-peterx@redhat.com
> rfcv2: https://lore.kernel.org/r/20260326210532.379027-1-peterx@redhat.com
> 
> Changelog rfcv2->v1:
> 
> - Rebased to latest fabiano's migration-staging branch (bd698d7730)
> - Collected new tags
> - Patch 1
>   - Add space between "_type*" [Phil]
> - Patch 9
>   - Slight refactoring on vmstate_load_next() [Fabiano]
>   - I collected Alexander's tested-by even if strictly I shouldn't when the
>     patch changed; if test fails, it's me to blame.
> 
> This is v1, I removed RFC as I we should have reached some form of
> consensus in general.  It is based on Fabiano's migration-staging branch.
> I've pushed this tree here for easier reference:
> 
> https://gitlab.com/peterx/qemu/-/tree/vmstate-array-null
> 
> This series implements a new vmstate flag that allows real dynamic array of
> pointers to be migrated, so that QEMU vmstate core will be able to identify
> NULL and non-NULL pointers pointing to any kind of VMSD (or base types),
> then properly allocate memory for them on dest QEMU.
> 
> The first planned user of such is Alexander's NVMe migration series here:
> 
> https://lore.kernel.org/r/20260317102708.126725-1-alexander@mihalicyn.com
> 
> This is another alternative to solve this problem.
> 
> I tested analyze-migration.py with this version and it works with an idle
> dump from the nvme series (after I rebase).
> 
> Thanks,
> 
> Alexander Mikhalitsyn (1):
>   tests/unit/test-vmstate: add tests for VMS_ARRAY_OF_POINTER_AUTO_ALLOC
> 
> Fabiano Rosas (1):
>   vmstate: Stop checking size for nullptr compression
> 
> Peter Xu (9):
>   vmstate: Pass in struct itself for VMSTATE_ARRAY_OF_POINTER
>   vmstate: Pass in struct itself for VMSTATE_VARRAY_OF_POINTER_UINT32
>   vmstate: Do not set size for VMS_ARRAY_OF_POINTER
>   vmstate: Update max_elems early and check field compressable once
>   vmstate: Rename VMS_NULLPTR_MARKER to VMS_MARKER_PTR_NULL
>   vmstate: Introduce vmstate_save_field_with_vmdesc()
>   vmstate: Allow vmstate_info_nullptr to emit non-NULL markers
>   vmstate: Implement load of ptr marker in vmstate core
>   vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC
> 
>  include/hw/intc/riscv_aclint.h |   6 +-
>  include/migration/vmstate.h    |  88 ++++++++++--
>  migration/savevm.c             |  28 ++++
>  migration/vmstate-types.c      |  36 ++---
>  migration/vmstate.c            | 247 ++++++++++++++++++++++++++-------
>  tests/unit/test-vmstate.c      |  90 +++++++++++-
>  roms/seabios-hppa              |   2 +-
>  scripts/analyze-migration.py   |  22 +--
>  8 files changed, 418 insertions(+), 101 deletions(-)
> 
> -- 
> 2.50.1
> 

For the whole series:

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


