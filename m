Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE696108B918
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Ywv-0006U0-NK; Fri, 20 Mar 2026 08:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w3Ywl-0006SW-CS
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 08:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w3Ywf-0003HE-9u
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 08:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774009636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RQv5qIZIpgZbbjJSpqCUzkAcGPiIdNsrHd/Kjf9HtW4=;
 b=aQBrJM3NCOXYPrBWa+h/AiFpLSjzYEv/Aozva2IsudHDvhUbGPg3nKYOoicIdeAv0iwr1p
 3nIonkanzuO6Ym8HYyZf3YKUqMyYj5nwR+gMQfkTpl6plXZ4my+gANVKE3uHP8GjepVVVd
 5RJnlk5ft9849DTK2UQpv28tJB3qeds=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-knJpQ3eEPP2_3QMhCg3ibw-1; Fri, 20 Mar 2026 08:27:14 -0400
X-MC-Unique: knJpQ3eEPP2_3QMhCg3ibw-1
X-Mimecast-MFC-AGG-ID: knJpQ3eEPP2_3QMhCg3ibw_1774009633
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-486fe36cf73so6167475e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 05:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774009628; cv=none;
 d=google.com; s=arc-20240605;
 b=Geba4Fb7PL40YMNR7BI9b/GSM4geQnmTDkxuE/bcliGASrgscPMjZkrVesIsLIb0bc
 6G1hjBpp1PSU+b8r/J5HRTHyW+AQXiB0Wq2g4+CpJ75a6/YbozJ2Lc8JLupVPg5ZXCwH
 uxX9k6NCFhidARhK6OoPX4bbWOlXLpt9471IBft7ug7B316k36BlJ4xUCb+dPCzvA3zQ
 3AzuN9fj/NlPPumKIJkr4KXRaIvT0KMl3Pyh4ZQHh0zE0T04dw2B/TJBePP0BLqjlOfk
 v2GG6gozcD5lAJpcOEZCnHAnaqYlmF8cIAErjYyQ4cZT9siIH9WOBjQJ+O/ekolDObRs
 mp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RQv5qIZIpgZbbjJSpqCUzkAcGPiIdNsrHd/Kjf9HtW4=;
 fh=Lkeq1iB2Dypck+qZqvMjsxSGYexXBAyQEFLmuX5D4LA=;
 b=egcaj6Pb0/73HHhhcLWJ00/nN2UgBCAb4uqkpW/qaveUJ1iaBvakVHLZjwgcHST7UJ
 aNG6PBW7mNAx8d+OUo2aGY29H2xm5bFrZ31tQ7OgYgdEp3RMOieb+X7v1Xng4gi8uNFl
 XLaIgp/tNVhu68bqDhYsKc0Xy4gIonTyQWgFmf4wgpyt3zKO8GzjMVg0tM8MdYrTBidn
 dG2tAI5s7qFzjYdCTb38b9mfU54Egh0Sgu+2DOlp74jDS+BzPKKrRlxnJVuF/J7hsuSz
 oUgcIDblyDD7oubXJ2PJiZAnkjnSIkUs8tLd4zbNkVncc4ZkeR5rfBWX4clWm34xIr2v
 hgqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774009628; x=1774614428; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RQv5qIZIpgZbbjJSpqCUzkAcGPiIdNsrHd/Kjf9HtW4=;
 b=UtZd+Xo+BIbfJLxXxNw7VeOQGGGoch2uoQq/nTyqFfkS+buobkcbCO9EHZe4GEiRws
 wTVDs9lKb9+BmawjAL3i/OJEl+aS4gB7Iy86hdYnbZk1gme05Y/msAkB1CF+4xmH7KFB
 ApXzidZccWRlHo6UH/X97WJpbf4bgo8oJhjL/RUuqCZTAGyJ5X88ZjL30pcU/yrN2Ewm
 QM0XyI6UFOXdgCx+O+jp0zi+hdX3PKkJLqJ9pzViL2KSmWtwz1o2etetr5uTVOShwTql
 LI7G2cXaG5i8ARn5EqbWSMyHFUkG15UpAL9m9LLBfmvTRdHGS3Emxa0n18Ip7NCuhDWD
 eI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774009628; x=1774614428;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQv5qIZIpgZbbjJSpqCUzkAcGPiIdNsrHd/Kjf9HtW4=;
 b=QmVLgT/tHmHrUBgG1LUTyXxWHQe8mH5Mmosrnb0/ohlwxUDck+2cwVPHO2PYWzA3tN
 g7P1mO1rwQX3Kk3gm8sff9kIj1c7ExL3XlPVHXTrM1T5fcFfGCgtd/LBNUtWEfHqIEkN
 A16j1+Pf+UIOmPXnXUxO4xaa8kuISqk02BOSfrPbZ5/ocdFsJgOR/Dmw8R4GPeTAoR4C
 VP1c4/qTUdHr36tm0pm9LV6K2tqT1op9k0NJIIHC/0rPM6xhx2B9fyWtltB9EZ59acE0
 UVkoKRiruneZUsi7xxmhcvjta6u8BLS5sU8+v54l3BVoE0zDLHFe36GejwUYmkiipB7O
 6QSw==
X-Gm-Message-State: AOJu0YzicLy1mSNJ0lVjRUgSZ0ErOCC5Xt87rsB5Vw/uaJioi0FwFzk3
 qQcJT9w43jn2iE8ogt2jkEOLFcMhIrx8hZ1z2Cv5fP5ONnnwT5YtjQS7z+ExQ2gI8SjgFd1lwsM
 PwWSJYGI0UwRcDdQ0sgkX6yw1giUPc23D81gOKUZD0+lXMmwQtHz6RX55kHm0Q6zQkRxy7HUpLa
 CPErIB6Cjh6uyoLM471gMNNPepSy7Rs9s=
X-Gm-Gg: ATEYQzzkvOqzcd4GlAVKa/I06mNGmnUpykIURWRdPGqwzNauEbp0P5uGqHqnYHfP5o6
 0fXwjH7PaSRCNTygsjU6hK/KvNx/QZPdvy/Xoz5N/fpbyc35olZYv2frTCL6cAa4S0BFmvWIUG7
 LjIBcikeA6+U3nVy1oD7XHfkYsRvPrOKznFblZ6+ENUTHMRvAFAxXmSSffRQ4sgPrD+pTbWYhVO
 +3L6YkOpFPpJS7D+xVSzO5yLE+/wR9vHykhTMPMi/y1kwSaxz0KscJ1916KKgJ3GIq4
X-Received: by 2002:a05:600c:4ecd:b0:486:fd71:e609 with SMTP id
 5b1f17b1804b1-486fee30149mr40235255e9.25.1774009628380; 
 Fri, 20 Mar 2026 05:27:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecd:b0:486:fd71:e609 with SMTP id
 5b1f17b1804b1-486fee30149mr40234695e9.25.1774009627891; Fri, 20 Mar 2026
 05:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-2-peterx@redhat.com>
In-Reply-To: <20260319231302.123135-2-peterx@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 20 Mar 2026 17:56:51 +0530
X-Gm-Features: AaiRm53_anFER5fXnZJsNiHD3PFgVymUmIxw6Nf-ZRRZ7_zcHuV8Vtq-03f6Bk4
Message-ID: <CAE8KmOyTq4wib3niowjXNfqh4TjwhcEDqUt99=mvuLs5vsSx9A@mail.gmail.com>
Subject: Re: [PATCH RFC 01/12] migration: Fix low possibility downtime
 violation
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
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> When QEMU queried the estimated version of pending data and thinks it's
> ready to converge, it'll send another accurate query to make sure of it.
> It is needed to make sure we collect the latest reports and that equation
> still holds true.
>
> However we missed one tiny little difference here on "<" v.s. "<=" when
> comparing pending_size (A) to threshold_size (B)..
>
> QEMU src only re-query if A<B, but will kickoff switchover if A<=B.
>
> I think it means it is possible to happen if A (as an estimate only so far)
> accidentally equals to B, then re-query won't happen and switchover will
> proceed without considering new dirtied data.
>
> It turns out it was an accident in my commit 7aaa1fc072 when refactoring
> the code around.  Fix this by using the same equation in both places.
>
> Fixes: 7aaa1fc072 ("migration: Rewrite the migration complete detect logic")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 5c9aaa6e58..dfc60372cf 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3242,7 +3242,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>           * postcopy started, so ESTIMATE should always match with EXACT
>           * during postcopy phase.
>           */
> -        if (pending_size < s->threshold_size) {
> +        if (pending_size <= s->threshold_size) {
>              qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
>              pending_size = must_precopy + can_postcopy;
>              trace_migrate_pending_exact(pending_size, must_precopy,

* What is the 'size' difference between < s->threshold_size  Vs  <=
s->threshold_size?  Going through the source IIUC
1) 'pending_size' is measured in Bytes.
     static void ram_state_pending_exact/_estimate()
         remaining_size = rs->migration_dirty_pages *
TARGET_PAGE_SIZE(=4096 bytes);
         100 dirty pages * 4096bytes  => 409600 dirty bytes => 409600
* 8 => 3,276,800 dirty bits

2) 's->threshold_size' is derived from bandwidth (100M bits/s) and
downtime(=300 ms)
        100,000,000 bits/s => 100,000 bits/ms
        100,000 bits/ms * 300ms => 30,000,000 bits in 300 ms
        30,000,000 bits / 8  =>  3,750,000 Bytes / 300 ms
        s->threshold_size = 30,000,000 bits (= 3.75MBytes) can be
transferred in 300ms downtime.

* Are we comparing pending_size(=409600 bytes)  <=
s->threshold_size(=30,000,000 bits)?

*  static void migration_update_counters()
        transferred = current_bytes - s->iteration_initial_bytes;
        bandwidth = (double)transferred / time_spent
        if (switchover_bw) {
            expected_bw_per_ms = (double)switchover_bw / 1000;
        } else {
            expected_bw_per_ms = bandwidth;
        }
=> ^^^^^^^  Should we divide 'bandwidth' by 1000 here (for bw_per_ms) ?

      s->threshold_size = expected_bw_per_ms * migrate_downtime_limit();

migration_iteration_run():
   /* Should we switch to postcopy now? */
   if (must_precopy <= s->threshold_size &&
      can_switchover && qatomic_read(&s->start_postcopy)) {
      if (postcopy_start(s, &local_err)) {
          migrate_error_propagate(s, error_copy(local_err));
          error_report_err(local_err);
      }
      return MIG_ITERATE_SKIP;
   }
* Here we should check pending_size <= s->threshold_size,  because
must_precopy is zero(0) when postcopy is enabled. And we switch to
postcopy mode even when pending_size > s->threshold_size.
  I wonder if we really need both 'must_precopy' and 'can_postcopy'
variables, they seem to complicate things.
===
# virsh migrate --verbose --live --auto-converge --postcopy
--postcopy-after-precopy f42vm
qemu+ssh://destination-machine.com/system
# less /var/log/libvirt/qemu/f42vm.log
...
migration_iteration_run: estimated pending_size: 50577408 bytes,
s->threshold_size: 36282361
migration_iteration_run: estimated pending_size: 43757568 bytes,
s->threshold_size: 36282361
migration_iteration_run: estimated pending_size: 36413440 bytes,
s->threshold_size: 34334680
migration_iteration_run: estimated pending_size: 29069312 bytes,
s->threshold_size: 34334680

migration_iteration_run: exact pending_size: 4339167232 bytes, 0,
4339167232              <== exact size is calculated once.
migration_iteration_run: estimated pending_size: 4332871680 bytes,
s->threshold_size: 35651363
migration_iteration_run: switching to postcopy: 4332871680, 0,
4332871680                    <== switch to postcopy with
must_precopy(=0) <= s->threshold_size

migration_iteration_run: estimated pending_size: 4332892160 bytes,
s->threshold_size: 35651363
migration_iteration_run: estimated pending_size: 4323188736 bytes,
s->threshold_size: 27243109
migration_iteration_run: estimated pending_size: 4315320320 bytes,
s->threshold_size: 27243109
migration_iteration_run: estimated pending_size: 4308221952 bytes,
s->threshold_size: 37695433
===
* Here, the exact pending_size is calculated only once, because we
switch to Postcopy mode even when pending_size is > s->threshold_size.

Thank you.
---
  - Prasad


