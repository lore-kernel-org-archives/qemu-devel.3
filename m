Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3221093177
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 06:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3T6q-0002uE-Nj; Fri, 20 Mar 2026 02:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1w3T6j-0002sd-Uk
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 02:13:18 -0400
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1w3T6e-0002QK-1i
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 02:13:17 -0400
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-128e4d0cc48so276433c88.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 23:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773987187; cv=none;
 d=google.com; s=arc-20240605;
 b=j+mSMwiFwfjdAlSxh7A3z+LCH5nl1WU+y+Sz9Ab47eNUfnOz4aWy6Lbu1IL/hGSvKJ
 yjMBNRTIccFoQrSHuB+7OffM1VZPHaif2MMbOM0hAkgWe1PQhqMV6NalGUgo7mxNzoKZ
 GUq3PV0+CBbH68P3FFxd26LXZAbiKmhIKgYnFAw7QolBiYaPO1e1mmzD3p7phVQ+9Ztn
 u7+ka/VnzI7a4UjKgaI+3USwAn/9niEYyTcRa6PU3Cda41Aa5gAtC3uKlXRcXCYiUPXx
 CbOzjIQdZMBcAfU1jFsitXa1KBpjmBBePgEUQosAU6AVZ7H8B/CKN1xMeAT8zJrjpcBo
 pDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=973wo5nJPV3g6aUdDP2HUV9fN15NR/SEcjW8CI09/wA=;
 fh=PJ2YM0MCLDpxc+Rr1VwlqTOUmMMZEVsV9MPE+Th47YI=;
 b=WsC2CHl18xNPpm4qQjbHZAhUGqcjT/hRhizGC2Ic38alQctc38uyCzuNRz0xu6jXsF
 bwBkkaTk1NLXwPa2Eb720LBbjh7Lgob9HpqUOXyvGDA8YBwnkiX7TNGKJCDx/EQ6jA4D
 G0kSx9d6aD3Qqtv4QashZ0M+NihlFeeoIK3TifQjXXX9+yWKbu40daZWAy0OvUPhdGiR
 3zDHU53SPSvUpqsQgTP835HJfR1DI3Q7bWk5upi2w2HVyelb0R4/V2yg+ZCp1C429MAX
 A6OLCY4S6Ek3vaodkfJschnlbz8vBm6Ky8t0c4+0Om5hXPgm+UBL5QUQeBJumHmWrJPa
 Zj1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1773987187; x=1774591987;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=973wo5nJPV3g6aUdDP2HUV9fN15NR/SEcjW8CI09/wA=;
 b=ChxcvCi4CF+q/6ltNCjuAFvtxUBdK2ZV+bqsoWm7dR72Svoyc//Bf5I+LjfK1MnVY9
 COhufAWBFMzAnPl7FQF867pIz8ktJRTXqRW9JzQ+Mny73ZWM8RhzVJNIwBlTHTVc8djv
 0ETL/QR3EAJ6mFMQW1D3RCiE+AAu9kKLO7ab3NC/fyRaykJDsRqNwnYGp/71xNCjEfoY
 cGeIL/7oeiwUx+mtHeG7YbrDqWAVjqqEdip2sPvqvXO7bY5aTl+DbWkeLyXQiRAWen5j
 Qh1SKO/rtXxB/wZjArEEfNsL+iyM5Ds7RcE/L4LMRkFpVRoIj7qC4XhkN0mIqHSBrH9z
 MmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773987187; x=1774591987;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=973wo5nJPV3g6aUdDP2HUV9fN15NR/SEcjW8CI09/wA=;
 b=Kjr7MY0+sADpFTHqdv5A1vzRyj1QpDkLCY/wE4wxBPgG+XOMrYKcmHHWJHZbShvtCp
 NMZ7RsSvnHO20XKiRBrDfVqf2BcDZ4AUq0+5a0zJMu4bi/tomAclJfBZxcen86dLLzia
 YocYTzFEncjEy3oNcVwUpxoBsoBS3EUcGM7WxCKSc8j08B4yufCC5tn7cpk6uSeeOiFl
 ZqMm55fikZxTThCUC4NUAnfXnfxpvpI/VlvqcSEkQ2TNKifY1YIQMLuXBbrwT09F6aSV
 ktIeTzEPkTzOx/sA3u0uOO3Gvbbv2116qt4vihtNwNn80mzO+0a7cLXadYDkm6SDfupi
 dktg==
X-Gm-Message-State: AOJu0YznS41eoM/K1HCwZ4DgzqeH3imxjBvtrOE5Rmf040wysxi1sVy1
 OAJ+R6Z1PxXoh3wP42Z7ahFDylK5fUR/lwiKAC0t5+nN+XDEHXzRKTjn4MSfD/pjM6xi89XWS0q
 XlrHE+6q7uJaU60GAqSRYdQznKeHBKdleLzEiU9fp1+65DCa1yx60E3Kj+ZBWrLahsmaj6PI7GF
 aNQVMzxFkPkPeha3SBsKdZPBBU
X-Gm-Gg: ATEYQzzbPIKWF5GofXquRcFSOyfH8GSUsAVebylCbabyu9leakfB/0qRZGfe+5xEOrV
 JRBLYhXnlWQN4/L3IGk0WlF6mxjMDg8j1r9VheL0W9VaEdj3pelk0rANAzRpgDhnPSIFWqUTCI5
 7+94/+BxNZBje85KKYn8ePe/TG7kqz4CLjVn6XW/G2G0Fkj51zGaPZGah1byHA6sVl7jPuPp3Cl
 pWsTlkSTwso4ssQFD73xnAbnnjLZ1bjPO54FqAZ7yptj42Md3V/XCDWQ1RYgdkd+B5icM94PEKe
 B1GyEc0=
X-Received: by 2002:a05:7022:43a4:b0:128:d5bd:3572 with SMTP id
 a92af1059eb24-12a726f5b50mr923318c88.31.1773987187133; Thu, 19 Mar 2026
 23:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-10-peterx@redhat.com>
In-Reply-To: <20260319231302.123135-10-peterx@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 20 Mar 2026 14:12:51 +0800
X-Gm-Features: AaiRm50w0UwHkQVRKfQNPHgqFsAfZ_oxl4PNS1rYAQTcxbmmiZkfNNGvhXw7voc
Message-ID: <CAK9dgmZb1RGvU5r-+Gudf2iZF4keG+0rJxfg6Rthws6v35XBFg@mail.gmail.com>
Subject: Re: [PATCH RFC 09/12] migration: Make iteration counter out of RAM
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
Content-Type: multipart/alternative; boundary="000000000000201a05064d6e9460"
Received-SPF: pass client-ip=2607:f8b0:4864:20::122a;
 envelope-from=yong.huang@smartx.com; helo=mail-dl1-x122a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000201a05064d6e9460
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks,

Reviewed-by: Hyman Huang <yong.huang@smartx.com>

On Fri, Mar 20, 2026 at 7:13=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> It used to hide in RAM dirty sync path.  Now with more modules being able
> to slow sync on dirty information, keeping it there may not be good anymo=
re
> because it's not RAM's own concept for iterations: all modules should
> follow.
>
> More importantly, mgmt may try to query dirty info (to make policy
> decisions like adjusting downtime) by listening to iteration count change=
s
> via QMP events.  So we must make sure the boost of iterations only happen=
s
> _after_ the dirty sync operations with whatever form (RAM's dirty bitmap
> sync, or VFIO's different ioctls to fetch latest dirty info from kernel).
>
> Move this to core migration path to manage, together with the event
> generation, so that it can be well ordered with the sync operations for a=
ll
> modules.
>
> This brings a good side effect that we should have an old issue regarding
> to cpu_throttle_dirty_sync_timer_tick() which can randomly boost iteratio=
n
> counts (because it invokes sync ops).  Now it won't, which is actually th=
e
> right behavior.
>
> Said that, we have code (not only QEMU, but likely mgmt too) assuming the
> 1st iteration will always shows dirty count to 1.  Make it initialized wi=
th
> 1 this time, because we'll miss the dirty sync for setup() on boosting th=
is
> counter now.
>
> Cc: Yong Huang <yong.huang@smartx.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration-stats.h |  3 ++-
>  migration/migration.c       | 29 ++++++++++++++++++++++++++---
>  migration/ram.c             |  6 ------
>  3 files changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index 1153520f7a..326ddb0088 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -43,7 +43,8 @@ typedef struct {
>       */
>      uint64_t dirty_pages_rate;
>      /*
> -     * Number of times we have synchronized guest bitmaps.
> +     * Number of times we have synchronized guest bitmaps.  This always
> +     * starts from 1 for the 1st iteration.
>       */
>      uint64_t dirty_sync_count;
>      /*
> diff --git a/migration/migration.c b/migration/migration.c
> index 42facb16d1..ad8a824585 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1654,10 +1654,15 @@ int migrate_init(MigrationState *s, Error **errp)
>      s->threshold_size =3D 0;
>      s->switchover_acked =3D false;
>      s->rdma_migration =3D false;
> +
>      /*
> -     * set mig_stats memory to zero for a new migration
> +     * set mig_stats memory to zero for a new migration.. except the
> +     * iteration counter, which we want to make sure it returns 1 for th=
e
> +     * first iteration.
>       */
>      memset(&mig_stats, 0, sizeof(mig_stats));
> +    mig_stats.dirty_sync_count =3D 1;
> +
>      migration_reset_vfio_bytes_transferred();
>
>      s->postcopy_package_loaded =3D false;
> @@ -3230,10 +3235,28 @@ static bool
> migration_iteration_next_ready(MigrationState *s,
>  static void migration_iteration_go_next(MigPendingData *pending)
>  {
>      /*
> -     * Do a slow sync will achieve this.  TODO: move RAM iteration code
> -     * into the core layer.
> +     * Do a slow sync first before boosting the iteration count.
>       */
>      qemu_savevm_query_pending(pending, false);
> +
> +    /*
> +     * Boost dirty sync count to reflect we finished one iteration.
> +     *
> +     * NOTE: we need to make sure when this happens (together with the
> +     * event sent below) all modules have slow-synced the pending data
> +     * above.  That means a write mem barrier, but qatomic_add() should =
be
> +     * enough.
> +     *
> +     * It's because a mgmt could wait on the iteration event to query
> again
> +     * on pending data for policy changes (e.g. downtime adjustments).
> The
> +     * ordering will make sure the query will fetch the latest results
> from
> +     * all the modules.
> +     */
> +    qatomic_add(&mig_stats.dirty_sync_count, 1);
> +
> +    if (migrate_events()) {
> +        qapi_event_send_migration_pass(mig_stats.dirty_sync_count);
> +    }
>  }
>
>  /*
> diff --git a/migration/ram.c b/migration/ram.c
> index 89f761a471..29e9608715 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1136,8 +1136,6 @@ static void migration_bitmap_sync(RAMState *rs, boo=
l
> last_stage)
>      RAMBlock *block;
>      int64_t end_time;
>
> -    qatomic_add(&mig_stats.dirty_sync_count, 1);
> -
>      if (!rs->time_last_bitmap_sync) {
>          rs->time_last_bitmap_sync =3D
> qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      }
> @@ -1172,10 +1170,6 @@ static void migration_bitmap_sync(RAMState *rs,
> bool last_stage)
>          rs->num_dirty_pages_period =3D 0;
>          rs->bytes_xfer_prev =3D migration_transferred_bytes();
>      }
> -    if (migrate_events()) {
> -        uint64_t generation =3D qatomic_read(&mig_stats.dirty_sync_count=
);
> -        qapi_event_send_migration_pass(generation);
> -    }
>  }
>
>  void migration_bitmap_sync_precopy(bool last_stage)
> --
> 2.50.1
>
>

--=20
Best regards

--000000000000201a05064d6e9460
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:comic sa=
ns ms,sans-serif">Thanks,</div><div class=3D"gmail_default" style=3D"font-f=
amily:comic sans ms,sans-serif"><br></div><div class=3D"gmail_default" styl=
e=3D"font-family:comic sans ms,sans-serif">Reviewed-by: Hyman Huang &lt;<a =
href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.c=
om</a>&gt;</div></div><br><div class=3D"gmail_quote gmail_quote_container">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 20, 2026 at 7:13=E2=80=AF=
AM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">peterx@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-colo=
r:rgb(204,204,204);padding-left:1ex">It used to hide in RAM dirty sync path=
.=C2=A0 Now with more modules being able<br>
to slow sync on dirty information, keeping it there may not be good anymore=
<br>
because it&#39;s not RAM&#39;s own concept for iterations: all modules shou=
ld<br>
follow.<br>
<br>
More importantly, mgmt may try to query dirty info (to make policy<br>
decisions like adjusting downtime) by listening to iteration count changes<=
br>
via QMP events.=C2=A0 So we must make sure the boost of iterations only hap=
pens<br>
_after_ the dirty sync operations with whatever form (RAM&#39;s dirty bitma=
p<br>
sync, or VFIO&#39;s different ioctls to fetch latest dirty info from kernel=
).<br>
<br>
Move this to core migration path to manage, together with the event<br>
generation, so that it can be well ordered with the sync operations for all=
<br>
modules.<br>
<br>
This brings a good side effect that we should have an old issue regarding<b=
r>
to cpu_throttle_dirty_sync_timer_tick() which can randomly boost iteration<=
br>
counts (because it invokes sync ops).=C2=A0 Now it won&#39;t, which is actu=
ally the<br>
right behavior.<br>
<br>
Said that, we have code (not only QEMU, but likely mgmt too) assuming the<b=
r>
1st iteration will always shows dirty count to 1.=C2=A0 Make it initialized=
 with<br>
1 this time, because we&#39;ll miss the dirty sync for setup() on boosting =
this<br>
counter now.<br>
<br>
Cc: Yong Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blan=
k">yong.huang@smartx.com</a>&gt;<br>
Signed-off-by: Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" target=3D"=
_blank">peterx@redhat.com</a>&gt;<br>
---<br>
=C2=A0migration/migration-stats.h |=C2=A0 3 ++-<br>
=C2=A0migration/migration.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 29 ++++++++++++++++=
++++++++++---<br>
=C2=A0migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 6 ------<br>
=C2=A03 files changed, 28 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/migration/migration-stats.h b/migration/migration-stats.h<br>
index 1153520f7a..326ddb0088 100644<br>
--- a/migration/migration-stats.h<br>
+++ b/migration/migration-stats.h<br>
@@ -43,7 +43,8 @@ typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0uint64_t dirty_pages_rate;<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0* Number of times we have synchronized guest bitmaps.<=
br>
+=C2=A0 =C2=A0 =C2=A0* Number of times we have synchronized guest bitmaps.=
=C2=A0 This always<br>
+=C2=A0 =C2=A0 =C2=A0* starts from 1 for the 1st iteration.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0uint64_t dirty_sync_count;<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
diff --git a/migration/migration.c b/migration/migration.c<br>
index 42facb16d1..ad8a824585 100644<br>
--- a/migration/migration.c<br>
+++ b/migration/migration.c<br>
@@ -1654,10 +1654,15 @@ int migrate_init(MigrationState *s, Error **errp)<b=
r>
=C2=A0 =C2=A0 =C2=A0s-&gt;threshold_size =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;switchover_acked =3D false;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;rdma_migration =3D false;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0* set mig_stats memory to zero for a new migration<br>
+=C2=A0 =C2=A0 =C2=A0* set mig_stats memory to zero for a new migration.. e=
xcept the<br>
+=C2=A0 =C2=A0 =C2=A0* iteration counter, which we want to make sure it ret=
urns 1 for the<br>
+=C2=A0 =C2=A0 =C2=A0* first iteration.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0memset(&amp;mig_stats, 0, sizeof(mig_stats));<br>
+=C2=A0 =C2=A0 mig_stats.dirty_sync_count =3D 1;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0migration_reset_vfio_bytes_transferred();<br>
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;postcopy_package_loaded =3D false;<br>
@@ -3230,10 +3235,28 @@ static bool migration_iteration_next_ready(Migratio=
nState *s,<br>
=C2=A0static void migration_iteration_go_next(MigPendingData *pending)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0* Do a slow sync will achieve this.=C2=A0 TODO: move R=
AM iteration code<br>
-=C2=A0 =C2=A0 =C2=A0* into the core layer.<br>
+=C2=A0 =C2=A0 =C2=A0* Do a slow sync first before boosting the iteration c=
ount.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0qemu_savevm_query_pending(pending, false);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Boost dirty sync count to reflect we finished one it=
eration.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* NOTE: we need to make sure when this happens (togeth=
er with the<br>
+=C2=A0 =C2=A0 =C2=A0* event sent below) all modules have slow-synced the p=
ending data<br>
+=C2=A0 =C2=A0 =C2=A0* above.=C2=A0 That means a write mem barrier, but qat=
omic_add() should be<br>
+=C2=A0 =C2=A0 =C2=A0* enough.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* It&#39;s because a mgmt could wait on the iteration =
event to query again<br>
+=C2=A0 =C2=A0 =C2=A0* on pending data for policy changes (e.g. downtime ad=
justments).=C2=A0 The<br>
+=C2=A0 =C2=A0 =C2=A0* ordering will make sure the query will fetch the lat=
est results from<br>
+=C2=A0 =C2=A0 =C2=A0* all the modules.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 qatomic_add(&amp;mig_stats.dirty_sync_count, 1);<br>
+<br>
+=C2=A0 =C2=A0 if (migrate_events()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_event_send_migration_pass(mig_stats.dirty=
_sync_count);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
diff --git a/migration/ram.c b/migration/ram.c<br>
index 89f761a471..29e9608715 100644<br>
--- a/migration/ram.c<br>
+++ b/migration/ram.c<br>
@@ -1136,8 +1136,6 @@ static void migration_bitmap_sync(RAMState *rs, bool =
last_stage)<br>
=C2=A0 =C2=A0 =C2=A0RAMBlock *block;<br>
=C2=A0 =C2=A0 =C2=A0int64_t end_time;<br>
<br>
-=C2=A0 =C2=A0 qatomic_add(&amp;mig_stats.dirty_sync_count, 1);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (!rs-&gt;time_last_bitmap_sync) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rs-&gt;time_last_bitmap_sync =3D qemu_clo=
ck_get_ms(QEMU_CLOCK_REALTIME);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1172,10 +1170,6 @@ static void migration_bitmap_sync(RAMState *rs, bool=
 last_stage)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rs-&gt;num_dirty_pages_period =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rs-&gt;bytes_xfer_prev =3D migration_tran=
sferred_bytes();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (migrate_events()) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t generation =3D qatomic_read(&amp;mig_=
stats.dirty_sync_count);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_event_send_migration_pass(generation);<br=
>
-=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0void migration_bitmap_sync_precopy(bool last_stage)<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best re=
gards</font></div></div>

--000000000000201a05064d6e9460--

