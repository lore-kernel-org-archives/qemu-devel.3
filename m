Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C17EC01DD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4e2l-0007Ns-FY; Mon, 23 Mar 2026 08:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w4e2h-0007M9-Sl
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w4e2d-0005Rp-Oa
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774267553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VbJn9zVPp8Hu0EOwgyYBsUEt8ye52w+kd7FH6JpIj4=;
 b=bo8NzU38JzLTuGaAALUPOApnVPdHMM5qV1K0ihAqr2G4vY7foVax12hf1/v7hL+wfP+6YF
 btPLXTa2s+lLzek+ylvGRP5J9Ukpk9ng4b4TGhA0P7LI89nMPCB+wfS6v/aLoIepQaYkz2
 nA9dmxEW640VZYt7KzceI8AVxAWJwnY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-5lnibufEP46W_jOy-n-7ng-1; Mon, 23 Mar 2026 08:05:52 -0400
X-MC-Unique: 5lnibufEP46W_jOy-n-7ng-1
X-Mimecast-MFC-AGG-ID: 5lnibufEP46W_jOy-n-7ng_1774267551
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-486fc42c83aso423635e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 05:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774267551; cv=none;
 d=google.com; s=arc-20240605;
 b=VrVDOxX9BIKBtUSVDpmEa9wZGBLP9EO0zeftsv2uuFkc9vOCx+4eiyT8tfV/DJZF0K
 CvcuFazEGT3vRPz4z5SnW2jzMcDa8NDTDl33WJsvWSCuqjK5cYbbCTvEtPA8hGwzoVBl
 pHzZLlxyob8HFK3wrL2+hk49mRJu91D7fK46UzQr29vnIAI0GN9XPwLOlwST2tZGk+XS
 z54o0E7kDN50aHoN9EV5xXtGYik/gt/Pz4G0Gi0Ebel7K8Nzon3kiBmauvyGymZB7dRF
 GSd9WndQW1fZLHIjiyU1zizHyYrnwbXaPk8DmpNgQzh0SlYGQWNt3EVvxkWFjVo//U/2
 JHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0VbJn9zVPp8Hu0EOwgyYBsUEt8ye52w+kd7FH6JpIj4=;
 fh=PJ2YM0MCLDpxc+Rr1VwlqTOUmMMZEVsV9MPE+Th47YI=;
 b=lmMSOJgShb809M2CPthhRx0xXeCXea5zHINsShKa1NMGbfbSAF47w9ZbGI5/bEbm1q
 4Gd+9PPuFAn2tWRNQvtgA0zpAuh8qflMfK6sqAlhlwi3fzPtoxcuSX+acupQlnHeya8s
 IJIsZ3KySVD0qpXYHhO3n4sWjoUnkKsrTh4NTUA4P7Abbbd5PSa55zw+yw27BQbQT5Qi
 u04xKYDSmsiO3mPEB+x5/JVkWkgxw6cxgrykP4G9y7U1lFaTDsNl5oWFOuhCLeJyOf8/
 kP4D+1aOvnPHCD4fOHoNbr6fJ1g4INXN6WMptycK8njqZv23yVklBD446i1RhiF3V0L/
 WTzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774267551; x=1774872351; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0VbJn9zVPp8Hu0EOwgyYBsUEt8ye52w+kd7FH6JpIj4=;
 b=OCM57iDQsmWAQwn1s9tl6wMYGcG8odkv+TjQwH8hEhR3QnYgDQr+Mxwaw50a2jasM5
 wVZZ7d7k2n1Ilzrl3Ljx+IUqr5gdIki0sBbZOgbXRdlDPQZpqKFXN+J8qsFb4nAyy6G/
 KLs9m8zx5Ie4zOR/bYLJIlYyVRuJMWr8phnxlH/n0S19Pd98++5KW4Z6NBSnsf7A9YvV
 3UaXLPFlZMAXi/uHrvXUygX4Y6s+fRqDtTERQuTR0bprSyrXc4RD9GcbeAP1L811gsC8
 CQMW5AD1KFXAmy1TJj9D7FcF0IQV2RYR8gjFfmKEmBbfcK9cBCdDWyeUvPXyU0SeKWIE
 1Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774267551; x=1774872351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VbJn9zVPp8Hu0EOwgyYBsUEt8ye52w+kd7FH6JpIj4=;
 b=rqEEC0/teN44sA9WKOE54sgNt9NW+yxPASco/6fry4XktkZpoSVIvWFu4AXncrOSXK
 LSaDDXKzFIv91l1O0lVuzvstTbJ2RlHzi87lW0/57cqHSKwPuCCVDfqkcxnvNuASlleP
 k2N4JpPJhrmn2oqRQf0Bh8lThcPM7B1dDIe3uLv+/TZIYJ5FYsX7PG3T4ZwgPMue0JeP
 dPWRZn0YeHah6bHtiy7SMY4Tvf6t38QbApC74K5c/sxx+ngUuRJVKGTCNFPSs6O3DI0Q
 4yqP+8cVZb99Efc6l4MAFUNOkZjOFaKKCx0EjPi8zNmDW5dIEyzV/bkHwJZ6mU/TKb/Y
 S6KQ==
X-Gm-Message-State: AOJu0Yy1tkDEQNnb/qofQrvNuEiNg5SiYoBPfpejwWFy1G1gbSTh7ATx
 +d86imdmhtOIUg9qqGvKLurCSvP5qXR3U2tAwF9KyyAKF2Fp6Ze0rt84xxOjpRJAzKAE9Avh+1p
 1X23JKwv0+J4gRAAmhQtbHuFk7t0oszTg5P5xze0KJlSTr+AyaNMnWL66g6wUDCHI0AqxKLfkzR
 bJPgvvI1yUVrWC4kMC1+zzxCtFj2TpR+c=
X-Gm-Gg: ATEYQzzBm0X1QTrF4qlwYHU011PiOFjYQ75wkDLMpIIbk3AQFOY1A6r3UndrKyWXh2W
 1j/Bh3UthTLN8GGljcsijH/045S8EUo6bKcihNih8UXZGqJ7HSa0iPXeZP6Qjy4/Bgh/XyRWqhd
 2Ga10gAe3RXs+CELqNDibNvzd6kTlff0Aj0sNXJTEpOgd2BR4HWeKF3uKmmPTSn7cxXSkyoq2vN
 Q9xPV/bcHsZjvJ6AsHJHOqGVzTq/X9QvHL49xWYkaK4OFtO8aWBr/AzQqgXpfNfnuts
X-Received: by 2002:a05:600c:8b0a:b0:47e:e57d:404 with SMTP id
 5b1f17b1804b1-486fee0f917mr168334285e9.16.1774267550849; 
 Mon, 23 Mar 2026 05:05:50 -0700 (PDT)
X-Received: by 2002:a05:600c:8b0a:b0:47e:e57d:404 with SMTP id
 5b1f17b1804b1-486fee0f917mr168333635e9.16.1774267550358; Mon, 23 Mar 2026
 05:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-13-peterx@redhat.com>
In-Reply-To: <20260319231302.123135-13-peterx@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 23 Mar 2026 17:35:32 +0530
X-Gm-Features: AQROBzCkhTi_1xdWif7u4hd4nuqxZbKeCeJBEFj7OrwLGnQGKW1eezbzCbBxKV0
Message-ID: <CAE8KmOxeDSWnK9k0fSEs236qkgdARjPP__GjUzZHg6xozyJL+A@mail.gmail.com>
Subject: Re: [PATCH RFC 12/12] migration: Fix calculation of expected_downtime
 to take VFIO info
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson <alex@shazbot.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

On Fri, 20 Mar 2026 at 04:46, Peter Xu <peterx@redhat.com> wrote:
> QEMU will provide an expected downtime for the whole system during
> migration, by remembering the total dirty RAM that we synced the last time,
> divides the estimated switchover bandwidth.

* ie. Total dirty RAM synced / estimated bandwidth? If so, divides -> divided by

> That was flawed when VFIO is taking into account: consider there is a VFIO
> GPU device that contains GBs of data to migrate during stop phase.  Those
> will not be accounted in this math.
>
> Fix it by updating dirty_bytes_last_sync properly only when we go to the
> next iteration, rather than hide this update in the RAM code.  Meanwhile,
> fetch the total (rather than RAM-only) portion of dirty bytes, so as to
> include GPU device states too.
>
> Update the comment of the field to reflect its new meaning.
>
> Now after this change, the expected-downtime to be read from query-migrate
> should be very accurate even with VFIO devices involved.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration-stats.h | 10 +++++-----
>  migration/migration.c       | 11 ++++++++---
>  migration/ram.c             |  1 -
>  3 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index 326ddb0088..14b2773beb 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -31,11 +31,11 @@
>   */
>  typedef struct {
>      /*
> -     * Number of bytes that were dirty last time that we synced with
> -     * the guest memory.  We use that to calculate the downtime.  As
> -     * the remaining dirty amounts to what we know that is still dirty
> -     * since last iteration, not counting what the guest has dirtied
> -     * since we synchronized bitmaps.
> +     * Number of bytes that are still dirty after the last whole-system
> +     * sync on dirty information.  We use that to calculate the expected
> +     * downtime.  As the remaining dirty amounts to what we know that is
> +     * still dirty since last iteration, not counting what the guest has
> +     * dirtied since then on either RAM or device states.
>       */

* Multiple uses of dirty is making it rather unclear. (any funny)

* May be:
     Number of bytes pending since the last full-system accounting
     of the dirty bytes' information. We use this number to calculate
     the expected downtime. The pending bytes do not account for
     the new bytes the guest may have written since the last update
     of the dirty bytes' information.

>      uint64_t dirty_bytes_last_sync;
>      /*
> diff --git a/migration/migration.c b/migration/migration.c
> index 23c78b3a2c..1c00572d14 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3240,18 +3240,23 @@ static void migration_iteration_go_next(MigPendingData *pending)
>       */
>      qemu_savevm_query_pending(pending, false);
>
> +    /*
> +     * Update the dirty information for the whole system for this

* dirty bytes' information

> +     * iteration.  This value is used to calculate expected downtime.
> +     */
> +    qatomic_set(&mig_stats.dirty_bytes_last_sync, pending->total_bytes);
> +
>      /*
>       * Boost dirty sync count to reflect we finished one iteration.
>       *
>       * NOTE: we need to make sure when this happens (together with the
>       * event sent below) all modules have slow-synced the pending data
> -     * above.  That means a write mem barrier, but qatomic_add() should be
> -     * enough.
> +     * above and updated corresponding fields (e.g. dirty_bytes_last_sync).
>       *
>       * It's because a mgmt could wait on the iteration event to query again
>       * on pending data for policy changes (e.g. downtime adjustments).  The
>       * ordering will make sure the query will fetch the latest results from
> -     * all the modules.
> +     * all the modules on everything.
>       */
>      qatomic_add(&mig_stats.dirty_sync_count, 1);
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 29e9608715..1bdf121d16 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1148,7 +1148,6 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
>              RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>                  ramblock_sync_dirty_bitmap(rs, block);
>              }
> -            qatomic_set(&mig_stats.dirty_bytes_last_sync, ram_bytes_remaining());

* Shouldn't the ram_bytes_remaining() go into pending->total_bytes
here? ie pending->total_bytes += ram_bytes_remaining()


Thank you.
---
  - Prasad


