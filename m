Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C63EC01C2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cVM-00023U-Kh; Mon, 23 Mar 2026 06:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w4cVK-00022z-En
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w4cVG-0007sa-HB
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774261638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J+/JjKgzfDiOyQo0MzQ15BLPP9bzWMs4iQspLF0icck=;
 b=b/J8GYmByM5enJZSyCKi4TisyVO6RlzOZLDhfDUlxPfAMfUb2AmjswKeWd2dPhfimsRQP4
 hsSiWpJvkL1C9HvBkhrVMYMde2osQ8bhoh5bIpC37BCMmun9zC8AVz6v0KQhT8mvfB3LV2
 bg2j5rzhlpAicTYqKjVC6TNArZEdefY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-bEhBKj7BOhuJP6bpjtIzBw-1; Mon, 23 Mar 2026 06:27:17 -0400
X-MC-Unique: bEhBKj7BOhuJP6bpjtIzBw-1
X-Mimecast-MFC-AGG-ID: bEhBKj7BOhuJP6bpjtIzBw_1774261636
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4853b5b0fafso42623285e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774261636; cv=none;
 d=google.com; s=arc-20240605;
 b=NpiZRVKU7S8fvHTaKorLxR6OHbZF0IQ8avEwujNn/LEe3eTFetvnhytVv5fnBP5ff3
 ggzjYvl3wIwpGzEu8whdXEEJVpU/RDd+dRaB0n39HELfPZuCWM35JRGjQi1l2MjiqaWE
 g7C7UsZb+S8GIleslYGRRAyuupQ9pv3/7VS6fzpzIly3LO8ptVk6vKNxES+djvbrMfPE
 4U6cxWkamz5r3dJp/w/BWZHPvqByxY3KG5dt4bcw772kW5kZqhp25+Z4u1P2GRrsAzbz
 ODUHeu3n7XdJjlqwXrfAtjKXqBjptBcBbeZB8GyHGRSYqnJGu4jhCq3+th3uHyy+BF3Y
 5itw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J+/JjKgzfDiOyQo0MzQ15BLPP9bzWMs4iQspLF0icck=;
 fh=PJ2YM0MCLDpxc+Rr1VwlqTOUmMMZEVsV9MPE+Th47YI=;
 b=FU5If8MR5aHmYYeV1pGnjcGehZF1EqnFANMdDGd0rkt4Q3g0WRMPE5eu9PHtciYKnB
 77wccg8N/K+XAGd5SHTe4er5hE6XP/NnjGMXF3fAzAWvKA2tZw2VFdQGm6r7h5LV9wt+
 jo+uW/MNyloalYVew+XGa2kL/OL5KisLY4EIQvX0p10zrQBhhMCchR1c3nv5pA6DmasD
 APxb61+V+DGS89kqH1mHQfaCUR2r3JQhykyFlaOHcs/o+M6+IQvBcldIOv6DNgl67bOc
 fdN3L3v2h7b+nnPJuQm2zmji9ht0SWAILoxqd/KRJkDCSnYABXWc2SUi0hVZL7I++15H
 P2UQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774261636; x=1774866436; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J+/JjKgzfDiOyQo0MzQ15BLPP9bzWMs4iQspLF0icck=;
 b=LkhALLtWZwgm3XMMTya/rludyBlhPxxMxrGDEWgVfcoEnbfOaNejKoA7ICDDG+AtCj
 vQ8ZOOPZkqimW11I6/MSBpIHylq3HHYFxpH3mdFs2zy6asbRCuFXyfRH5+XvR1WYlbLN
 Gu0FEroZPbtZrzXzi7fqmOf0VdBHFW65XplJ7tpAQ0JBa2dkHtiwfHjUfTfpkFm46tFg
 NG01203fJuORv5LP/nUQTC2ZTZTggl8eq5xocZTn0/HTMVrgNeezne7yn8Vr769HzJLh
 pxvfwbS+tvXD8zIRIEZxjTe+bjRbjVlGEs+qfFQOJPoRzITlYGuJ3Margdmu5kvuuLFT
 nZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774261636; x=1774866436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+/JjKgzfDiOyQo0MzQ15BLPP9bzWMs4iQspLF0icck=;
 b=NCYX80G4kHpMh9ehaRx/3D/h2v6I7PxHKBvkpxYPs+4nH/jFew55Rg67/5dJZOVn1F
 U52vX+VePL/I0DVHedFO8nlGLXhrwt9eetUwq2MLtCM2HO4FQ6XjRG9nV8uKnXSoq827
 dP1nZiLgtAofu+FxTDasloL8t4Ms3PkTqpAhdenOZSc6utDcYU2uaa3YHMspR+pqlipc
 Kdi9Bbo43vv8gVCAzLVJYkoZ7HSyrZgEIptXQJsJLjaQ+FqA5G8+lF4clQmm/RlPkuwX
 zydIRtKPzLBmJY5xNmOuntpypNXeMdPCAP691y63ogkOphIUkhte5An0LaLxEMIdH3DT
 90eA==
X-Gm-Message-State: AOJu0YwBguSuuGnMn/sN4+K2bujg684U0TKqhTP4Ig/NevJJU4bd8HgU
 mtVFL01ZbeqU7nPgEDTdlBorJm3CtLw4+YY+uasiQdZVir/VC89W/2tWjJEANhFZONU+8ta9O6E
 uOnIQKCowGYrmx+mlBnI7izo4e7tHLJKxY2Y91kHQ2Cz75o2HIXHzelDwq0/mVx08tzL2M1zg+Z
 3093AgbX1izd7g6VgimEALVEpe+X5gPV8=
X-Gm-Gg: ATEYQzx/7mXhLji1/T1r6F3piWLov4oq+jpTIhioTiRlvjeujKfVzV2pisLEAkPjpRn
 Bm+OKfTclKQruJ3ANtAwEjauOd9qyT8m1j+Mv7MCKcl3zqyXUq9BFuhMUtj3WfPWLm2bj2i2gcq
 BsngVmS/hBJys6DisXtXrG+CE21BWPbtV4sqQC8P0WYrjsDemf3YShRQpLZJmkXFmP6jmzn8eEF
 U/Q2fYxzLZk/tcS98PR/bJdG3y4+hAukz8iMAitgfSV9bQE/Xt2hvw/4OWgsE6qav9q
X-Received: by 2002:a05:600c:1c0a:b0:485:40c6:f528 with SMTP id
 5b1f17b1804b1-486fee2bb38mr176450195e9.30.1774261636019; 
 Mon, 23 Mar 2026 03:27:16 -0700 (PDT)
X-Received: by 2002:a05:600c:1c0a:b0:485:40c6:f528 with SMTP id
 5b1f17b1804b1-486fee2bb38mr176449615e9.30.1774261635551; Mon, 23 Mar 2026
 03:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-11-peterx@redhat.com>
In-Reply-To: <20260319231302.123135-11-peterx@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 23 Mar 2026 15:56:59 +0530
X-Gm-Features: AQROBzDnaQ3YJ4ueDty592EeYBQ4liY0xsOPOsGfhJB2OOEeYyZYGk9tLOXDMP8
Message-ID: <CAE8KmOxrBVeg5h3UK5HzbK+di9OG7VRiS0r9aT5QBn9-3xC42A@mail.gmail.com>
Subject: Re: [PATCH RFC 10/12] migration: Introduce a helper to return
 switchover bw estimate
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
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, 20 Mar 2026 at 04:45, Peter Xu <peterx@redhat.com> wrote:
> Add a helper to be able to return an estimate of switchover bw, called

* Add a helper to return ...
* bw -> bandwidth

> migration_get_switchover_bw(). Use it to sligitly simplify the current
> code.

* sligitly -> slightly ;  (Better still: use it to simplify ...)

* This simplification is nice and required.

> This will be used in new codes later to remove expected_downtime.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.h |  1 +
>  migration/migration.c | 43 ++++++++++++++++++++++---------------------
>  2 files changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/migration/migration.h b/migration/migration.h
> index b6888daced..bf3ee6cc07 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -586,6 +586,7 @@ void migration_cancel(void);
>  void migration_populate_vfio_info(MigrationInfo *info);
>  void migration_reset_vfio_bytes_transferred(void);
>  void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
> +int64_t migration_downtime_calc_expected(MigrationState *s);

* Let's return unsigned int64 -> uint64_t  here? Downtime should be
positive OR does it return a negative error code?

* This function is not used in this patch, it is unrelated that way.
Let's add it in the patch where it is used?

> --- a/migration/migration.c
> +++ b/migration/migration.c
> +/*
> + * Returns the estimated switchover bandwidth (unit: bytes / seconds)
> + */
> +static double migration_get_switchover_bw(MigrationState *s)
> +{
> +    uint64_t switchover_bw = migrate_avail_switchover_bandwidth();
> +
> +    if (switchover_bw) {
> +        /* If user specified, prioritize this value and don't estimate */
> +        return (double)switchover_bw;
> +    }
> +
> +    return s->mbps / 8 * 1000 * 1000;
> +}
> +

* 100 mbps will return => 100 / 8 * 1000 * 1000 => 12,500,000 bytes/sec

* When user specifies bandwidth with
        virsh migrate --available-switchover-bandwidth <number>
bandwidth (in MiB/s) available for the final phase of migration

* Asking users to specify such large number for bytes/sec is not user
friendly. 100mbps OR 156mbps OR 400mbps would have been better, then
above function could do

     if (!switchover_bw) {
         switchover_bw = s->mbps;
     }
     return switchover_bw / 8 * 1000 * 1000

>  bool migration_is_running(void)
>  {
>      MigrationState *s = current_migration;
> @@ -3126,37 +3141,22 @@ static void migration_update_counters(MigrationState *s,
>  {
>      uint64_t transferred, transferred_pages, time_spent;
>      uint64_t current_bytes; /* bytes transferred since the beginning */
> -    uint64_t switchover_bw;
> -    /* Expected bandwidth when switching over to destination QEMU */
> -    double expected_bw_per_ms;
> -    double bandwidth;
> +    double switchover_bw;
>
>      if (current_time < s->iteration_start_time + BUFFER_DELAY) {
>          return;
>      }
>
> -    switchover_bw = migrate_avail_switchover_bandwidth();
>      current_bytes = migration_transferred_bytes();
>      transferred = current_bytes - s->iteration_initial_bytes;
>      time_spent = current_time - s->iteration_start_time;
> -    bandwidth = (double)transferred / time_spent;
> -
> -    if (switchover_bw) {
> -        /*
> -         * If the user specified a switchover bandwidth, let's trust the
> -         * user so that can be more accurate than what we estimated.
> -         */
> -        expected_bw_per_ms = (double)switchover_bw / 1000;
> -    } else {
> -        /* If the user doesn't specify bandwidth, we use the estimated */
> -        expected_bw_per_ms = bandwidth;
> -    }
> -
> -    s->threshold_size = expected_bw_per_ms * migrate_downtime_limit();
> -
>      s->mbps = (((double) transferred * 8.0) /
>                 ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
>
> +    /* NOTE: only update this after bandwidth (s->mbps) updated */
> +    switchover_bw = migration_get_switchover_bw(s) / 1000;

* We got 12.5 MB/sec return value, divide it by 1000 to get bytes/ms
     ie. 12500000 / 1000  ==> 12500 bytes/ms

* It'll help to describe an example calculation in comments around
this math. Instead of dividing by 1000 here, why not make
migration_get_switchover_bw() return a bytes/ms value? That way the
actual calculation and the sample calculation in comments can go in
that function.

> +    s->threshold_size = switchover_bw * migrate_downtime_limit();
> +
           s->threshold_size = 12500 bytes/ms * 300ms  =>  3750000 bytes / 300ms

* IIUC, when pending_size  <=  s->threshold_size(=3.75MB), we can
pause the source VM and switch to the Postcopy phase, right?

>      transferred_pages = ram_get_total_transferred_pages() -
>                              s->iteration_initial_pages;
>      s->pages_per_second = (double) transferred_pages /
> @@ -3178,7 +3178,8 @@ static void migration_update_counters(MigrationState *s,
>
>      trace_migrate_transferred(transferred, time_spent,
>                                /* Both in unit bytes/ms */
> -                              bandwidth, switchover_bw / 1000,
> +                              (uint64_t)s->mbps,
> +                              (uint64_t)switchover_bw,
>                                s->threshold_size);

* Here 's->mbps' is not in bytes/ms unit, is it?

Thank you.
---
  - Prasad


