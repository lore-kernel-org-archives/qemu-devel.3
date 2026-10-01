Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C015DCA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCMpP-0008Pl-VC; Thu, 01 Oct 2026 15:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xCMpI-0008O1-H6
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xCMpG-0005aU-BO
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790884337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=waWMTGeo8thKUDMoGE+Jn7tt0Extekr910m9VE/kZTM=;
 b=QYJKEEHRu7kM+qi1hlM6fppZS1NmhJewgH+i/MRSgMYT07LfcUuWoU+j4gqCWLHgAy3LTh
 rIaTTBOoylK8QLvzffmBnP/47/Tu49G4fAOhmpedKgNRT31yPcrLJfqAn0VIWFwGDcadt/
 UjjDFZsarI02iBHcnNPxRT34xBIKB+s=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-GUrDX3GqMaWKHzxxz5soNg-1; Thu, 01 Oct 2026 15:52:16 -0400
X-MC-Unique: GUrDX3GqMaWKHzxxz5soNg-1
X-Mimecast-MFC-AGG-ID: GUrDX3GqMaWKHzxxz5soNg_1790884335
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53395d51187so10326971cf.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 12:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790884335; x=1791489135; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=waWMTGeo8thKUDMoGE+Jn7tt0Extekr910m9VE/kZTM=;
 b=facsvK5gIvYgZ2h3wMd4QD/0qNGmIQJLgq/ZXECOND5Bv1D56XfVtMB+xIuGZg8fvy
 WqmSf2j8dUO6AkTRFg5Wtu7vrsQSnw7liZjUEwLCFv4OjPfpuS2ZEXWgBJa4Q9/qro0z
 lAVuVHSDTHgi1/ae1HzQ4pUXZGvvIxNepVKY0RwA818OvpZAW3ymkziFhQYArn6GfwxO
 4+KNccrUycPr/F+DenC5I/srNICXQgce94SdzUWnllxPy/Y5w+rVXlfjxgV5bVMnSuQu
 XEtK61bsnJiXV08JFPiwo9l2+fNw3o7kS1okv2SLvYTPracj6mrxAvo/y3xu5hHHw4j3
 ygUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790884335; x=1791489135;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=waWMTGeo8thKUDMoGE+Jn7tt0Extekr910m9VE/kZTM=;
 b=tAyJ/uM32hPlNcDTc7wUjxiXndwGJsgiu+zrmIntFFxWJeiSeAFyWBY/wseUHMNybq
 Xb6H7NxKXUwGyjl/OwvxAkzzLh/oxdD14AOG/QOGcEFb7v1PajMFAAuix6vTy7WGdmbA
 YPW88MnNN2xwcRhUv0RHvovMBphcR3WpXsdOXLn94UN5je/V4oZZEnmFSnyVeKIC9x5i
 1VWWVRAWSoJgMh3a1vtyCOf2MdYXGPd0bWsuP/2RyBJ+gLvf1QWs1Wmx4TfscMo514xu
 qObWFLOj0qm+QcB78SX6Ek2SSLYK86TjPnQiKQWeEl1cAmd6JcQV9ZWqjploky7495F4
 5kxw==
X-Gm-Message-State: AFuF++kO8ylxAK/O51Y7o3pL99ziffWH4CA0Ec+wF2hxxsdcnSkrLr0U
 DX1nz7EylggIYU6OZKGZKLeteyz+78IQ0zZLH7n2kFLGCPZs1bHS96iojPl/0veBTDq/wt9I6r9
 PWP5T4B/pcRUzyu7qTcuzhxr2O0m9ah4Gsq4dxmgUyb5f5mQp+TAZ7Kop
X-Gm-Gg: AYBFou2ui9Sk7aD49GBZZSK3IdmRGAuvhga8nmkYplTGw4ZOvl9Qdsr6vM8Kk9xR8OF
 mdBw5iErG49yH0+IXk9ObTTNI34Rs8sFfSamGacBny/BMPetB+JZWJuXK2Vp/6OTE5lZQOB33cs
 nv6BZVSe6haVZ2PFpkU16anbDsGUFLQB55sBTYfT3quZobeLrhzejaF8+TJ7qfzqSJ7nMiFraVt
 9FJNQf7uigo2CoJ8671OCMVfaeUO5VmZIG9Y5GK7Bj7wtBHWszBCEhfIkEz5cK1qg5cykoDFA2X
 7kcbM4xd/hUchWmLpKCeQB3beeWyY1MAECZjHgVDW2NVL56Ea0eIgUcoM0X8E4U0Rq2GJzg=
X-Received: by 2002:ac8:5a01:0:b0:530:5152:75f0 with SMTP id
 d75a77b69052e-533cbc78724mr3997881cf.22.1790884335282; 
 Thu, 01 Oct 2026 12:52:15 -0700 (PDT)
X-Received: by 2002:ac8:5a01:0:b0:530:5152:75f0 with SMTP id
 d75a77b69052e-533cbc78724mr3997261cf.22.1790884334631; 
 Thu, 01 Oct 2026 12:52:14 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53398d122a4sm6360721cf.23.2026.10.01.12.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 12:52:13 -0700 (PDT)
Date: Thu, 1 Oct 2026 15:52:13 -0400
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Denis V. Lunev" <den@virtuozzo.com>
Subject: Re: [PATCH 1/2] migration: let a vmstate defer its post_load to end
 of stream
Message-ID: <ar657ehBVdQKSWXF@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260911142345.3999518-1-den@openvz.org>
 <20260911142345.3999518-2-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911142345.3999518-2-den@openvz.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 11, 2026 at 04:23:44PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> A post_load hook which only rearranges the memory topology forces a
> flatview rebuild as its section is read, and the cost of a rebuild grows
> with the number of regions in the machine. A device which does this once
> per vCPU therefore scales badly on the destination.
> 
> Add post_load_deferrable. A vmsd which sets it has its hook queued during
> the load and run once the stream has been consumed, in the order the
> hooks would have fired, with the whole drain sharing one memory
> transaction.
> 
> Opt-in, because deferral is not free in general. A hook which can fail
> must not be deferred: failing after the stream is consumed means the
> source has already been told the migration succeeded, and may release a
> guest the destination never started. A hook which reads guest memory must
> not be deferred either, since the drain runs with the topology in flux.
> Postcopy is excluded because its listen thread walks the same stream
> concurrently.
> 
> CC: Peter Xu <peterx@redhat.com>
> CC: Fabiano Rosas <farosas@suse.de>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
> ---
>  include/migration/vmstate.h |  40 +++++++++++++
>  migration/savevm.c          |  23 ++++++++
>  migration/vmstate.c         |  67 +++++++++++++++++++++-
>  tests/unit/test-vmstate.c   | 111 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 239 insertions(+), 2 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index e72c3fae9a..16045319d5 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -303,6 +303,29 @@ struct VMStateDescription {
>      bool (*pre_load_errp)(void *opaque, Error **errp);
>      int (*post_load)(void *opaque, int version_id);
>      bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
> +
> +    /*
> +     * Run .post_load() once the whole stream has been loaded rather than
> +     * as this section is read, so that it sees a machine whose devices
> +     * have all been restored, and so that several of them can share the
> +     * work they would each repeat.
> +     *
> +     * Three things must hold of a hook before it may be deferred.
> +     *
> +     * It must not fail. By the time the queue is drained the stream has
> +     * been consumed, so a source may already have been told the migration
> +     * succeeded and may have released the guest; there is nothing left to
> +     * report a failure to. A hook which fails here is a bug in its vmsd
> +     * and is fatal.
> +     *
> +     * Nothing else in the load may depend on what it does. The hooks run
> +     * after every section has been read, so anything a later section needs
> +     * to observe must not be produced here.
> +     *
> +     * It must not read guest memory or resolve an address space, because
> +     * the drain runs as one batch with the memory topology in flux.
> +     */
> +    bool post_load_deferrable;
>      int (*pre_save)(void *opaque);
>      bool (*pre_save_errp)(void *opaque, Error **errp);
>  
> @@ -1299,6 +1322,23 @@ bool vmstate_save_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
>  
>  bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque);
>  
> +/**
> + * vmstate_post_load_defer_begin: Queue deferrable post_load hooks
> + *
> + * Between this and vmstate_post_load_defer_finish(), a post_load hook whose
> + * vmsd sets post_load_deferrable is recorded rather than called. Hooks are
> + * queued in the order they would have run.
> + */
> +void vmstate_post_load_defer_begin(void);
> +
> +/**
> + * vmstate_post_load_defer_finish: Stop deferring and drain the queue
> + * @run: run the queued hooks, in order; when false, discard them
> + *
> + * Returns false if a hook failed, in which case the rest are discarded.
> + */
> +bool vmstate_post_load_defer_finish(bool run, Error **errp);
> +
>  #define  VMSTATE_INSTANCE_ID_ANY  -1
>  
>  /* Returns: 0 on success, -1 on failure */
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 4b590ea672..2352dcf684 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3128,6 +3128,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
>  {
>      MigrationState *s = migrate_get_current();
>      MigrationIncomingState *mis = migration_incoming_get_current();
> +    bool defer_post_load;
>      int ret;
>  
>      if (qemu_savevm_state_blocked(errp)) {
> @@ -3147,7 +3148,29 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
>  
>      cpu_synchronize_all_pre_loadvm();
>  
> +    /*
> +     * The postcopy listen thread walks the same stream concurrently, so the
> +     * queue would need locking and a defined owner for the drain.
> +     */
> +    defer_post_load = !migrate_postcopy_ram();

Just to mention we have two other paths that will enable this too:

qmp_xen_load_devices_state
load_snapshot

It looks all fine at least considering the hyper-v scope, but still raise
this in case it's not expected.

The other thing is, IMHO we should enable this feature for both precopy and
postcopy.  Postcopy loads that in the package, please kindly share more on
the above comment on disabling it; I didn't directly get that part.

> +    if (defer_post_load) {
> +        vmstate_post_load_defer_begin();
> +    }
> +
>      ret = qemu_loadvm_state_main(f, mis, errp);
> +
> +    if (defer_post_load) {
> +        /*
> +         * A deferrable hook only rearranges the memory topology, so the
> +         * whole drain can share one flatview rebuild.
> +         */
> +        memory_region_transaction_begin();

IMHO we should document this behavior in the "deferrable" interface above,
this is important knowledge to know that the whole deferred vmsd loads are
wrapped with boosted transaction depths and all memory access is illegal.

AFAIU, that partly supplement my other reply, that the whole thing is not
about "defer" or not, but about "batching MR update".  It can still be at
the end of course, but it's not the major goal, the major goal is about
memory updates.

Thanks,

> +        if (!vmstate_post_load_defer_finish(ret == 0, errp)) {
> +            ret = -EINVAL;
> +        }
> +        memory_region_transaction_commit();
> +    }

-- 
Peter Xu


