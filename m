Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DEFF34C63
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJrK-0000wB-Gu; Mon, 13 Apr 2026 12:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wCJqz-0000uV-JP
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wCJqp-0003da-Cm
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776096562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XsHRlgIainPvA0VAWBxDYR7CbZ9e2tbHl18JznsYMZM=;
 b=SZOMLVJJUkOD1k0Q0K3hsa+aSUa6N+6fIDuZuzER7VpuGeFloazLyBKOnigZiiwL857az5
 FlI+M5XxPIb6nyjPBce/gXHPbzSheAe+jdy2YLTX9et4//Rb6AmulOWgle8BmsXSwmjoPm
 0M+6xb45jSExUASUUxmDlTPjI/fx7dg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-BdGCubX1P8aq5ot0r0H0Dw-1; Mon, 13 Apr 2026 12:09:19 -0400
X-MC-Unique: BdGCubX1P8aq5ot0r0H0Dw-1
X-Mimecast-MFC-AGG-ID: BdGCubX1P8aq5ot0r0H0Dw_1776096558
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488c82b4701so27755775e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 09:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776096558; x=1776701358; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XsHRlgIainPvA0VAWBxDYR7CbZ9e2tbHl18JznsYMZM=;
 b=DvApUajeJf3Il51oKQp/OCjiayRVFcJ1+yNzkXSfH1UeXWlUDsiCOS36fr8GliihKy
 hVTuuoJ68rxzqfGW0PyrWmDg2YD4g96ghnjSbR93Fyi/nlun3ieMa/PUfNgMmPljanLq
 3GbpDUIDdP16LnzMHhKCusdKoQRhUABd0JVTEZOiMKcbjUSLd8FlZs6HWjFRxv3T2k3d
 TKarEJLXz9/o2R8CSVa4J9nojoIBfYT2zFoD3Fww5bF+FBNDkSTXvN0CHgG6jsNDiWY9
 QMGA8M7zjDzUDuMES6cynhCycRyyIGb22mgKkj/B61lpdYTsvGcwV8GC7qjI0TFkoQGd
 5fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776096558; x=1776701358;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsHRlgIainPvA0VAWBxDYR7CbZ9e2tbHl18JznsYMZM=;
 b=SDfCUWp8m1Hx5zr5CLKR5uwRstCO4LkUTywIYoHHTfB1pJ0Mv9bgWb69Dn3RPeUUp5
 Gh8TPzNCLGNKOJuQi78dqIkhHRRn91ClFIfCcjox1AhMu9c/wi2SGnp4qSzUPoLnuqCQ
 RmKTzo0VoHZlPucns6AFLUKgoltZmS6eq1FYYPsqg35UPhePkM4OZ5+fx6OYcJuXVfVF
 N+706rmyNM+qOgVgfn8mnp4V4f1I//LseLstib+adwe6bZqqq0JRKn7rKXmaDsxEXlqM
 319/VnT/GLdnL5TtCM8aWikm3Ng9x1Qsnm9AEDguZsrdi2s2lZAtXm2XPIFBnJdXHvCF
 DMJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wAc99EVm0S0YLJb8//514FfaeSaHTXoD4RqJ/vqKhaAaEQbcAVSR1YsM88QGD8qZg20dC7bc8pCkg@nongnu.org
X-Gm-Message-State: AOJu0Yy11LuYHCzi1V84w2es3NtUkdX2ejw8LsB4VVb7f9oOUcWZy6EQ
 mm25LkXh51cU/bhoboGJQiAiAaoVNPF2gYfEmVI/LWcwMzuXncQhlNm+zV5VG6wFUQyzND5WlI2
 cWhHDRED/PfzkTV9aiWC6CPsj0x0DMstoUmB/9mKQ6Rts0sQTYEw+t/+N
X-Gm-Gg: AeBDieuVCCCViKrUVtWsPm3Mz6pgYblsn9+WahYBoMaywez0hNa9wJ/8uzYHoBAe8qo
 qprcGr5g+XMAmgOEDeqF5vWSTPr6kJDy825EP24QKehB9NOxvW15LiTngXN+iHdopehwm/ddH52
 gf+oDk+MiJwZdlmxivtsmGIjmFeQ6NMhIrXVbTwfz2pMexoKlKK0ls2xhsdKq9veWsiWxyPDFpn
 cRT2oxbpnZ5V0vEAUYvYFQpek6hfAKAte3xcx+adJFVAPN8bf5vsI8D+wtBj0IcS9x1VcQ+3rNg
 N6ND7firC2pmx10vyDSNH5/YuLpN/S0iu4NLIAbYCLjcrJQ9iQG2SBURkwAlp/VUkJSiwhg+0eo
 yCSLpO11tFQF5V5g9vUsALLRiOzE0ZgZ4SJxf5E5PUpWQLqinan3TxHh6Uv4q
X-Received: by 2002:a05:600c:8717:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-488d6816f5amr192575395e9.3.1776096558236; 
 Mon, 13 Apr 2026 09:09:18 -0700 (PDT)
X-Received: by 2002:a05:600c:8717:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-488d6816f5amr192574685e9.3.1776096557681; 
 Mon, 13 Apr 2026 09:09:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d532ef00sm345910925e9.5.2026.04.13.09.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 09:09:17 -0700 (PDT)
Message-ID: <8c51c77e-b496-4e99-a35c-364d224d1b3c@redhat.com>
Date: Mon, 13 Apr 2026 18:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] migration/vfio: Fix a few issues on API misuse or
 statistic reports
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
References: <20260408165559.157108-1-peterx@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260408165559.157108-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 4/8/26 18:55, Peter Xu wrote:
> CI: https://gitlab.com/peterx/qemu/-/pipelines/2437886506
> rfc: https://lore.kernel.org/r/20260319231302.123135-1-peterx@redhat.com
> 
> This is v1 of this series.  I dropped RFC because I feel like I collected
> enough feedback on previous version on what is uncertain, meanwhile I also
> managed to borrow a system with nVidia RTX6000 2GB vGPU and tested it.
> 
> There're too many trivial things changed since RFC->v1 here, let me only
> mention what majorly has changed:
> 
> - This version will assume both VFIO ioctls (reporting either precopy or
>    stopcopy size) may report anything (say, garbage), and it shouldn't crash
>    QEMU.  It will affect what got reported with downtime or remaining data,
>    but that's best effort so it's expected.  With that in mind, I dropped
>    patch 3 as Avihai suggested.  IOW, I expect no concern on either overflow
>    / underflow or atomicity on reading these values from the VFIO drivers.
> 
> - The cached stopcopy_bytes for VFIO reflects always the total size
>    (includes precopy sizes).
> 
> - Introduced one new patch to report "system-wide" remaining data, which
>    will start to include VFIO remaining device data.  We can't squash that
>    directly into "ram" section of query-migrate QMP results, so I introduced
>    a new "remaining" field in query-migrate result for it.
> 
> - One more patch "migration: Make qemu_savevm_query_pending() available
>    anytime" trying to fix a very hard to hit race condition I found when
>    testing against virtio-net-failover tests.  I can only hit it if I run
>    tens of concurrent tests, but it will be needed to fix a crash.
> 
> Otherwise the major things should be kept almost as-is.  I should also
> addressed all comments I received from rfc version.  Please shoot if I
> missed something.
> 
> Overview
> ========
> 
> VFIO migration was merged quite a while, but we do still see things off
> here and there.  This series tries to address some of them, but only based
> on my limited understandings.
> 
> Two major issues I wanted to resolve:
> 
> (1) VFIO reports state_pending_{exact|estimate}() differently
> 
> It reports stop-only sizes in exact() only (which includes both precopy and
> stopcopy data), while in estimate() it only reports precopy data.  This is
> violating the API.  It was done like it to trigger proper sync on the VFIO
> ioctls only but it was only a workaround.  This series should fix it by
> introducing stopcopy size reporting facility for vmstate handlers.
> 
> (2) expected_downtime / remaining doesn't take VFIO devices into account
> 
> When query migration, QEMU reports one field called "expected-downtime".
> The document was phrasing this almost from RAM perspective, but ideally it
> should be about an estimated blackout window (in milliseconds) if we
> switchover anytime, based on known information.
> 
> This didn't yet took VFIO into account, especially in the case of VFIO
> devices that may contain a large amount of device states (like GPUs).
> 
> For problem (2), the use case should be that an mgmt app when migrating a
> VFIO GPU device needs to always adjust downtime for migration to converge,
> because when it's involved normal downtime like 300ms will normally not
> suffice.
> 
> Now the issue with that is the mgmt doesn't have a good way to know exactly
> how well the precopy goes with the whole system and the GPU device.
> 
> The hope is fixed expected_downtime will provide one way for the mgmt app
> to have a reasonable hint for downtime to setup to converge a migration.
> 
> Meanwhile, with a system-wise "remaining" field introduced, mgmt can query
> this results at beginning of each iteration to know if a stall is
> happening, IOW, if it's likely that this migration will not converge at
> all.  When detected, mgmt can start to consider the expected_downtime value
> reported above for converging this migration.  See more on testing below.
> 
> Tests
> =====
> 
> Tested this series with an assigned VFIO device GRID RTX6000-2B, FB memory
> 2GB.
> 
> The test covers both correct reporting of system-wise remaining data (which
> used to only cover RAM), and the expected downtime.  I verified that using
> the expected downtime I can converge a VFIO migration immediately according
> to the value reported. Test process as below:
> 
> Start the VM and kick off migration until it spins at the end, not
> converging with default 300ms downtime.  It's common for a 2GB vGPU device
> due to both huge stopsize reported and dramally small mbps reported.
> 
> As a start, update avail-switchover (I chose 1GB over a real 10Gbps port):
> 
> This will stablize bandwidth.
> 
> Libvirt's domjobinfo won't be able to see the real remaining data because
> libvirt still doesn't support the new "remaining" field, however we can
> still see expected_downtime will be reported correctly now (instead of
> reporting zero, before this patch applied):
> 
> Data remaining:   0.000 B
> Memory remaining: 0.000 B
> Expected downtime: 1910         ms
> 
> If we peek through QEMU monitor, we'll see with the change the system-wise
> remaining data to be 1.9GB (even if RAM keeps reporting 0), and expected
> downtime keeps the same as what domjobinfo reports as 1.9 seconds:
> 
> Status:                 active
> Time (ms):              total=336919, setup=10, exp_down=1910
> Remaining (bytes):      1.91 GiB
> RAM info:
>    Throughput (Mbps):    460.09
>    Sizes:                pagesize=4 KiB, total=32 GiB
>    Transfers:            transferred=12.7 GiB, remain=0 B
>      Channels:           precopy=12.7 GiB, multifd=0 B, postcopy=0 B, vfio=0 B
>      Page Types:         normal=3306906, zero=7745576
>    Page Rates (pps):     transfer=14010, dirty=8039
>    Others:               dirty_syncs=247045
> 
> It means 1.91 seconds are required as lowest downtime per math.
> 
> We can try to set something lower than that, migration will not converge:
> 
> ...
> ...
> 
> Then if we update downtime_limit to be slightly larger than expected downtime:
> 
> Migration will complete almost immediately.


I tested the series by performing a migration of a RHEL9 VM with a vGPU
(NVIDIA L4-2B) and an MLX5 VF, from a RHEL9 host (vGPU mdev) to a RHEL10
host (vGPU VF), with the vGPU under load.

The expected downtime was fluctuating around 2600 ms. Bandwidth was
around 950 Mbps. Setting downtime to 3000ms made the migration
converge quickly.

Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
> Peter Xu (14):
>    migration: Fix low possibility downtime violation
>    migration/qapi: Rename MigrationStats to MigrationRAMStats
>    vfio/migration: Cache stop size in VFIOMigration
>    migration/treewide: Merge @state_pending_{exact|estimate} APIs
>    migration: Use the new save_query_pending() API directly
>    migration: Introduce stopcopy_bytes in save_query_pending()
>    vfio/migration: Fix incorrect reporting for VFIO pending data
>    migration: Make qemu_savevm_query_pending() available anytime
>    migration: Move iteration counter out of RAM
>    migration: Introduce a helper to return switchover bw estimate
>    migration: Calculate expected downtime on demand
>    migration: Fix calculation of expected_downtime to take VFIO info
>    migration/qapi: Introduce system-wise "remaining" reports
>    migration/qapi: Update unit for avail-switchover-bandwidth
> 
>   docs/about/removed-features.rst   |   2 +-
>   docs/devel/migration/main.rst     |   9 +-
>   docs/devel/migration/vfio.rst     |   9 +-
>   qapi/migration.json               |  32 +++---
>   hw/vfio/vfio-migration-internal.h |   8 ++
>   include/migration/register.h      |  59 ++++------
>   migration/migration-stats.h       |  13 ++-
>   migration/migration.h             |  10 +-
>   migration/savevm.h                |   9 +-
>   hw/s390x/s390-stattrib.c          |   9 +-
>   hw/vfio/migration.c               |  92 +++++++++-------
>   migration/block-dirty-bitmap.c    |  10 +-
>   migration/migration-hmp-cmds.c    |   5 +
>   migration/migration.c             | 172 +++++++++++++++++++++---------
>   migration/ram.c                   |  40 ++-----
>   migration/savevm.c                |  73 +++++++------
>   hw/vfio/trace-events              |   3 +-
>   migration/trace-events            |   3 +-
>   18 files changed, 313 insertions(+), 245 deletions(-)
> 


