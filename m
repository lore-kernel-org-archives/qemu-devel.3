Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4452C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwj9n-0003hN-C9; Wed, 19 Aug 2026 12:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wwj9j-0003gl-Ui
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 12:28:47 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wwj9f-0004WT-VF
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 12:28:47 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5b021916bd3so1870238e87.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 09:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787156922; cv=none;
 d=google.com; s=arc-20260327;
 b=Q64tnR6LtKnvpZLB8lGmjkEi2OEkOC8NRc0sfl8oojU/205YdvjgARdfe93hIHJteN
 +OXmuLDfjOZMpalEX5sMl0ZI5uynTgQt4pU1idAGnnm/NsusdanrEqEB46a2goEzU1u+
 UK4ZvEX/JY5Q0vQnp8+sMAaasiH2fBPbdpkMgA4nwEuO4tqT22eGxW4gk1SjUC5Tk3zX
 5BL2Phf+/MpcPwD64OzvZb2tooZJAosyzIC7L6cxqoWJnEDoxvQ8J1A36AZJSyjRF2tW
 4g4f4eMCzI+47xDY+wzGKOQ2kBC3KiCpc6Yre0loP7xaqej5WEHaa8Vb9XgmTcEhERJe
 RODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SXY5wlc+h/LLROm+eTZDVRjklDm92a/JmAV6Df+p47w=;
 fh=R5Aahv4qNefvBV4Drq2w2/WptobLag/G3uOV8Fwoqjo=;
 b=IDzZdLjaQKHiu36HtIpb+kbqJJlQHPpQF+BWydURoAN/61xOBSVuKvPwrdtJbJKNoD
 BAmCbg8I1EoGna11M1zWbqx8dn2Sw3Iah0IU8L+CTLIAdF/h45qEzg/UkuWmFVrXOP/z
 NwJ2uoLUv7HO06BYNs6Bvza+g/1f72GVSYYV76398K+Oi0WHdKH5OUWcsBXcZJNOiXhE
 DQXRUAfFhJbs0p9Nizgq5bYusl3Unn8TXAfAIyINbzQk/dtSa4Qz/8Jx4KfZv8K+G4eU
 vheMO30KGCd/ckNx8quHCBCH97lPtEI4T+Ysytjz6f514G+TaiIh7pG0lKl6HYGu8zgX
 HvOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787156922; x=1787761722; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SXY5wlc+h/LLROm+eTZDVRjklDm92a/JmAV6Df+p47w=;
 b=gicSRnkiC0QNfT2my41pDiQsW6v8V0Uj0i34NxZLg1RaNYBfXJTpZsC57rF3FwAsmr
 Uiw0ioRwMRBQ9R5aEQnTx1qbV3FEItemKLnVWme5D8gixZZvf1kAvQAtZ+nZGhlBzsku
 i62YfIH93Mb2q+dfAa4fB7jpSOsR/xTDo6SDpwjPKmWehb0QMvKyG6eJKJxylQzXTAPz
 r0B0kNrzJcJNvaVVC5U7+qcl3PkWp+x1V83wCzEEXPbDOoGIiTcsjM2P8UG6MgKH9Z+U
 hZ490QahQx9jLgIlxH9T7ZwbwA/6y6iBJ9lXhGNeyPUQ9kbcG+nw8MrGHaqZm+efAXnC
 kavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787156922; x=1787761722;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SXY5wlc+h/LLROm+eTZDVRjklDm92a/JmAV6Df+p47w=;
 b=gtJbzmFcwXPXF99IWHW6xiDD81AfZsy12tWd/GLTMJt51eVYOBktwAgTk8Gcr1vwOf
 YTF8LgMwXeoHRrd1QPzL9+w9NMAUDbC2omRqHywAFmqObceSq/lsHiIaDacQnrwnh/9x
 oYSaQfvT/yfP7nVY6R0SzjOQpQfeA1c347ReW/SDiPE8qR9whGPk0VoAa2W5InMogSi5
 HuJJDs20XzqCDBb3kd7fbWfNcSqvS85DkwiJ0PAJP73twfblc8WQSwQ5+wYgsVa2D2OG
 mAUejptfh1Gel1O7NtZ14ZumqpLSaYht1n6I9gO1VztiocSTI3QevH1/RaGBOib37ki1
 +mDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFwSodctqSUGDFUqcyw5sFx0DtNIfY87C0NGut4KiKFbiQxAtphx8MIEMiapozDRRAvFBPFfnUKQR4@nongnu.org
X-Gm-Message-State: AOJu0Yxin3JxEQ3gbpIP2bNceSY3NIH6H7bLuVerEMdPzs3WaYiG3h7p
 0WpLjSHywGPYsjE9k7jYKIK9bz+vFD4pWcfcGtix29P+870v1lhdTIMdewo76a8RXElzqrxWA9c
 0PI02YLC/MD+W0jo5TLWZQKKQSU2GXBY=
X-Gm-Gg: AR+sD11ApETsrux08rgO3r9p/826DCqKiS7psrNGqaZzt51NUSn0n9imY6hiwXQykta
 ENUO+Qkv6q/d5zBGw1BiargeISW3YfbrHVIRJ/zV0sJzpd301iOT8mPMrfccAfhDHZ1TqIAWRLA
 GJ1eq8DisrLuETG7BgQP+vwir7HFxdigNSHHMQWLlJ1KEjbgPA1sPPvLAvCO6oZzDPgKHdUbD/4
 +Q+o4TzKpypcitVqe88iYVQ0KhmgsaXMjBWzUUJ+lpBPb19vByF1FfbpmUuINfLNpS4YWplUfpA
 s768UddA4638JRjfVGKGOyvEayX6DZiN57bOt4RhRGZsoXkKsXxAEv9sDqsh3zpL19W8bK/XEje
 J
X-Received: by 2002:a05:6512:1044:b0:5b3:e52:a005 with SMTP id
 2adb3069b0e04-5b478b51390mr2169379e87.4.1787156921729; Wed, 19 Aug 2026
 09:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260816174631.1547811-1-aadeshveer07@gmail.com>
 <aoXPAFDYLKxbTbWZ@x1.local>
In-Reply-To: <aoXPAFDYLKxbTbWZ@x1.local>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Wed, 19 Aug 2026 21:58:29 +0530
X-Gm-Features: AcwNN1UYbxg0xCSUWv4i_0twz5ZWB-XszLsHHUal152frcOYjPlnxIaM8jevfys
Message-ID: <CA++cPvJ+xb9S0s2AOvrRhcfMviKWGnaTb9tUdcv-2kgXW0U3WQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] migration: fast snapshot load
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com, 
 pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Aug 19, 2026 at 9:13=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Sun, Aug 16, 2026 at 11:16:20PM +0530, Aadeshveer Singh wrote:
> > This series implements a "fast snapshot load" mechanism to
> > significantly reduce the perceived resume time of a VM from a snapshot
> > file.
>
> This series breaks Windows builds... we'll need three fixups into three
> patches to fix it.  Attached at the end.
>
> For Aadeshveer: in the future you can check Windows build of your own
> patches locally by running this:
>
>   $ make docker-test-build@fedora-win64-cross
>
> I do hit Rust build failures nowadays with Windows, though, so you may ne=
ed
> this if you have enabled rust builds instead (I also normally use J=3DN f=
or
> concurrency):
>
>   $ J=3D8 EXTRA_CONFIGURE_OPTS=3D--disable-rust make docker-test-build@fe=
dora-win64-cross
>

Thanks for catching the Windows build failure and writing the fixups!
I've noted down the test command and will make sure any future work
does not break the windows build.

> For Fabiano: if you want, you can also directly pick up the relevant
> patches I queued in my -next branch, or squash the fixups attached, or pi=
ck
> your own fix. I'll leave that to you to decide.
>
>   https://gitlab.com/peterx/qemu/-/tree/next
>
> Thanks,
>
> =3D=3D=3D8<=3D=3D=3D
>
>
>
> From 572b0f8b611e430e5ed8651d99851975878624c7 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Tue, 18 Aug 2026 16:38:08 -0400
> Subject: [PATCH 1/3] fixup! migration: Propagate error in postcopy setup
>  functions
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/postcopy-ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 81d06917fe..3c85fa1b19 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1906,7 +1906,7 @@ int postcopy_request_shared_page(struct PostCopyFD =
*pcfd, RAMBlock *rb,
>      g_assert_not_reached();
>  }
>
> -int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
> +int postcopy_ram_incoming_setup(MigrationIncomingState *mis, Error **err=
p)
>  {
>      g_assert_not_reached();
>  }
> --
> 2.54.0
>
>
>
>
> From 4273cc6ed223de1781513af9a62c1672c3f5591b Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Wed, 19 Aug 2026 10:30:35 -0400
> Subject: [PATCH 2/3] fixup! migration: Extract blocktime marking helper
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/postcopy-ram.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 3c85fa1b19..fdc65c3545 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1934,6 +1934,14 @@ void mark_postcopy_blocktime_begin(uintptr_t addr,=
 uint32_t ptid,
>                                     RAMBlock *rb)
>  {
>  }
> +
> +bool try_mark_postcopy_blocktime_begin(MigrationIncomingState *mis,
> +                                       RAMBlock *rb, ram_addr_t start,
> +                                       uint64_t haddr, uint32_t tid)
> +{
> +    g_assert_not_reached();
> +    return false;
> +}
>  #endif
>
>  /* ---------------------------------------------------------------------=
---- */
> --
> 2.54.0
>
>
>
> From d2d397de73fe39b424b2871fe4ba0df7937cc680 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Tue, 18 Aug 2026 16:43:29 -0400
> Subject: [PATCH 3/3] fixup! migration: add eager load thread and setup fo=
r
>  fast snapshot load
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/postcopy-ram.c | 135 ++++++++++++++++++++-------------------
>  1 file changed, 71 insertions(+), 64 deletions(-)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index fdc65c3545..885ab58fca 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -39,6 +39,8 @@
>  #include "qemu/mmap-alloc.h"
>  #include "options.h"
>
> +static void postcopy_incoming_complete_bh(void *opaque);
> +
>  /* Arbitrary limit on size of each discard command,
>   * keeps them around ~200 bytes
>   */
> @@ -1872,6 +1874,70 @@ int postcopy_place_page_zero(MigrationIncomingStat=
e *mis, void *host,
>      }
>  }
>
> +/*
> + * Called by postcopy_ram_eager_load_thread over all blocks to load in a=
ll the
> + * pending pages of given ram block
> + */
> +static int ram_block_load_eager(RAMBlock *rb, void *opaque)
> +{
> +    MigrationIncomingState *mis =3D migration_incoming_get_current();
> +    MigrationState *s =3D migrate_get_current();
> +    Error *errp =3D NULL;
> +    void *host =3D qemu_ram_get_host_addr(rb);
> +    void *target;
> +
> +    for (ram_addr_t page_loc =3D 0; page_loc < rb->used_length;
> +         page_loc +=3D qemu_ram_pagesize(rb)) {
> +        target =3D (uint8_t *)host + page_loc;
> +        if (!postcopy_mapped_ram_load_page(mis, rb, page_loc, (uint64_t)=
target,
> +                                           RAM_CHANNEL_PRECOPY, &errp)) =
{
> +            migrate_error_propagate(s, errp);
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
> +
> +/*
> + * Used by fast snapshot load to eagerly load in all pages of RAM and sc=
hedule
> + * cleanup after entire RAM is loaded
> + */
> +static void *postcopy_ram_eager_load_thread(void *opaque)
> +{
> +    MigrationIncomingState *mis =3D opaque;
> +    MigrationStatus next_state;
> +
> +    trace_postcopy_ram_eager_load_thread_entry();
> +    rcu_register_thread();
> +    qemu_event_set(&mis->thread_sync_event);
> +
> +    if (foreach_not_ignored_block(ram_block_load_eager, NULL)) {
> +        next_state =3D MIGRATION_STATUS_FAILED;
> +    } else {
> +        next_state =3D MIGRATION_STATUS_COMPLETED;
> +    }
> +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> +                      next_state);
> +
> +    postcopy_state_set(POSTCOPY_INCOMING_END);
> +    migration_bh_schedule(postcopy_incoming_complete_bh, mis);
> +
> +    rcu_unregister_thread();
> +    trace_postcopy_ram_eager_load_thread_exit();
> +    return NULL;
> +}
> +
> +/*
> + * Create thread for eager loading in fast snapshot load case
> + */
> +void postcopy_ram_eager_load_setup(MigrationIncomingState *mis)
> +{
> +    postcopy_thread_create(
> +        mis, &mis->eager_load_thread, MIGRATION_THREAD_DST_SNAPSHOT_LOAD=
,
> +        postcopy_ram_eager_load_thread, QEMU_THREAD_JOINABLE);
> +    mis->have_eager_load_thread =3D true;
> +}
> +
>  #else
>  /* No target OS support, stubs just fail */
>  void fill_destination_postcopy_migration_info(MigrationInfo *info)
> @@ -1942,6 +2008,11 @@ bool try_mark_postcopy_blocktime_begin(MigrationIn=
comingState *mis,
>      g_assert_not_reached();
>      return false;
>  }
> +
> +void postcopy_ram_eager_load_setup(MigrationIncomingState *mis)
> +{
> +    g_assert_not_reached();
> +}
>  #endif
>
>  /* ---------------------------------------------------------------------=
---- */
> @@ -2426,67 +2497,3 @@ int postcopy_incoming_cleanup(MigrationIncomingSta=
te *mis)
>
>      return rc;
>  }
> -
> -/*
> - * Called by postcopy_ram_eager_load_thread over all blocks to load in a=
ll the
> - * pending pages of given ram block
> - */
> -static int ram_block_load_eager(RAMBlock *rb, void *opaque)
> -{
> -    MigrationIncomingState *mis =3D migration_incoming_get_current();
> -    MigrationState *s =3D migrate_get_current();
> -    Error *errp =3D NULL;
> -    void *host =3D qemu_ram_get_host_addr(rb);
> -    void *target;
> -
> -    for (ram_addr_t page_loc =3D 0; page_loc < rb->used_length;
> -         page_loc +=3D qemu_ram_pagesize(rb)) {
> -        target =3D (uint8_t *)host + page_loc;
> -        if (!postcopy_mapped_ram_load_page(mis, rb, page_loc, (uint64_t)=
target,
> -                                           RAM_CHANNEL_PRECOPY, &errp)) =
{
> -            migrate_error_propagate(s, errp);
> -            return -1;
> -        }
> -    }
> -    return 0;
> -}
> -
> -/*
> - * Used by fast snapshot load to eagerly load in all pages of RAM and sc=
hedule
> - * cleanup after entire RAM is loaded
> - */
> -static void *postcopy_ram_eager_load_thread(void *opaque)
> -{
> -    MigrationIncomingState *mis =3D opaque;
> -    MigrationStatus next_state;
> -
> -    trace_postcopy_ram_eager_load_thread_entry();
> -    rcu_register_thread();
> -    qemu_event_set(&mis->thread_sync_event);
> -
> -    if (foreach_not_ignored_block(ram_block_load_eager, NULL)) {
> -        next_state =3D MIGRATION_STATUS_FAILED;
> -    } else {
> -        next_state =3D MIGRATION_STATUS_COMPLETED;
> -    }
> -    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> -                      next_state);
> -
> -    postcopy_state_set(POSTCOPY_INCOMING_END);
> -    migration_bh_schedule(postcopy_incoming_complete_bh, mis);
> -
> -    rcu_unregister_thread();
> -    trace_postcopy_ram_eager_load_thread_exit();
> -    return NULL;
> -}
> -
> -/*
> - * Create thread for eager loading in fast snapshot load case
> - */
> -void postcopy_ram_eager_load_setup(MigrationIncomingState *mis)
> -{
> -    postcopy_thread_create(
> -        mis, &mis->eager_load_thread, MIGRATION_THREAD_DST_SNAPSHOT_LOAD=
,
> -        postcopy_ram_eager_load_thread, QEMU_THREAD_JOINABLE);
> -    mis->have_eager_load_thread =3D true;
> -}
> --
> 2.54.0
>
>
> --
> Peter Xu
>

