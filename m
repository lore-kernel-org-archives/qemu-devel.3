Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08FDCCF2F2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 12:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhoMQ-0001mr-7R; Mon, 19 Jan 2026 07:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vhoMO-0001j1-8O
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:27:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vhoMM-0004ji-CL
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768825673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+wE8JDCo8PXcVnEcN5UBV1qoCWED8Yp0dlq80pT+8Xs=;
 b=i48Is98WQ5YohHmtC8sJ6CAiZ54d9e8QmFAuCSVyu0sNLaNC/JI9JhSHe5NfmFWi0Wm6ZO
 tTf2bALZiiYTPLvyqJlgVtpR0DpMWowW1q8L/UW+r4jiuZ1ngBCTdz7va7/Z5nA01zvrIZ
 dpFqBTj++7gwdwoI3I+q/aaAFHaS2V0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-AHyotGXVM3i1MQxLv03oGw-1; Mon, 19 Jan 2026 07:27:51 -0500
X-MC-Unique: AHyotGXVM3i1MQxLv03oGw-1
X-Mimecast-MFC-AGG-ID: AHyotGXVM3i1MQxLv03oGw_1768825670
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso39946375e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 04:27:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768825670; cv=none;
 d=google.com; s=arc-20240605;
 b=Zzm3PyVstwzjRAOJbO8QEYmfyEMNQE11KOETzM0EDCQxLeAbv3694yP5afy4vDrMWI
 pyt2s0GCSy/JEGb7d6I0b3Dj7whaCSuakXWlOciPatDzfGzAjiq3JYLT3OYtUWDlq3oW
 ORKBALFceA7dvxiTVdBR3Jx5+1hPeEmCt9Y+qnHFh5+2Y5Ewnx/Y4vLkHYqh27het27Q
 r6ij7sst03GAN6TWXLX9r+ZRMydh3L1CxQFXrGYYl8TEx46Oo+uih/niKGuGuIIOP1FB
 TCgr+HOfxq0vgkebDSPcenD3nwIZNh/CLfxVJ2J53+A7QxLsYrwW0ypPl4fj78GEKURP
 x9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+wE8JDCo8PXcVnEcN5UBV1qoCWED8Yp0dlq80pT+8Xs=;
 fh=0wQhbH5PyiW8mCGsVuFpUsFCyW2Tj+HDIxFJ/KoT2Iw=;
 b=jHc/3OfVecGFSCcj5fxooSqsIIt7w7IeuqCmBKtky4HWDFQp0yTmnjmrG4XIBasrZa
 H6CAGwJqZ0cVE9s0Jwe9mEV5rShsschzQKVCN7QHezOgPfhHHdK3qsmzBLcu9v+PAqlG
 kbkNKuIimk+IpD316VpqrwzMgecBGeDCLIaxOzorBQIiMQCsKvMEVBX6mL/AXeG75ziO
 2Fd4EwzxYU2c+TPTAYBzBis37PKFAVpCgMwrd/73EDbGcHqkns8Jy5ARrTqRT4D0ICfI
 AbrGB1fVSJir4T0Gu4YJcgtN+iH4pobrgnFbuMmNPnpHZgrOFP1Firp1wmDu7jCC6fz8
 Xy0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768825670; x=1769430470; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+wE8JDCo8PXcVnEcN5UBV1qoCWED8Yp0dlq80pT+8Xs=;
 b=DUxQiEdbeTM82vfZo8gSwLqY4XgWUFLDQ2Df39J8jTQ9hByT10jQU7fz8EvSFPZddF
 TqdhIG6CjNRFWXwYzlOOaJz4ChuEcogj1U98QTV5q91ygRLEoUVdundaGJe6Yxq+z4o1
 NPYZ2XhWhP0dgQqj+Bzea4RGFgurTAG9tVjt+3sr84xjPv9pUzQTchYOVGJQXPesO8I2
 YL+Ci8P5VDTAUnWUH+zoBQpWvUyaV8HNDkS2iX0bnDcNYKDqv6TfJ8qRsQwkPLXkwvYV
 VBG07TFfiapE6Q3MXXYgiUIJrCem1WIkAivNvm3fnQYyN9KLCrRaA5v0MNJIa6t3afEt
 bBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768825670; x=1769430470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wE8JDCo8PXcVnEcN5UBV1qoCWED8Yp0dlq80pT+8Xs=;
 b=FOODy0gmlyJHrTHTUovcqbNdThy95CQ6SWSzWkThDwCvPtWcdAxAqQDlCp3jPI+w6O
 1bn4Yq9AOo5oWOM4wHTaTqLj+FM/eyVUG+/Lgyz6hHxOR907Xk3ldJrHxpvwC326jqOv
 wgs6UKcS4D/v/7WfLY+sb2eLskxFerzAwo6BP5o3iHIopsrS1XA//6Yx9Z2aV9tJK1TH
 1+h5t1xSi5rpac/pKN3l+a30QyW6bP97FwuzQYEVakbxMbe7wmMVlTNy4MPMM0e52XI3
 YGy93DcxGO/iLKNncDUqHrCKaBVC9VyVrEwMx6u465XaCVhYjr2VzsLtPIk0li8fISn9
 W2wA==
X-Gm-Message-State: AOJu0YzAhB26Q5y58qgiVieyTx/2Z1n/ZwwZIhI7uHuRllVHGBgc/Gqi
 ZZkBZ2BxqM9okwYHqEeVJJhlAuWm0vQZEnG5SWt3VLKDooPNoCyKz72TJlWksda3xentdQo3rJF
 9SGjSDra7/f8ww6LkRL9Kkr+8szpFjHtj5r+cQfgE1VM2PEW5TO3DlgzhfnmQZvfLX2/jw9ZzdF
 7Bk96iUHK6lHTunukhaUyyeqi4Aw/Qy24=
X-Gm-Gg: AY/fxX72SwGLKwRFN2J5VrKqxQXm9CTFnM0OWRMujjWTxG1V3a/eTWKtW9m0o5F5SL3
 2IkTvCmNubwAIiDrG+kvwXCZxnw5ENuQkyl74r6W681G6gw9I99h1WiANh4c3IFbhr+LI55j5ER
 lL4q2S5Y8NiatYAlotky6ILGjV9tPO0UbombmS3eD/PeiPKJESmOqdhyukmx4XdHLV9cS9+90G6
 YxYY7ifHQyCwfFwgtRff2Rmg6WZgKSuAfdZoIVfh9j3srDSndyknR72
X-Received: by 2002:a05:600c:3ba8:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-4801e2fddcbmr162270615e9.8.1768825669988; 
 Mon, 19 Jan 2026 04:27:49 -0800 (PST)
X-Received: by 2002:a05:600c:3ba8:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-4801e2fddcbmr162270215e9.8.1768825669466; Mon, 19 Jan 2026
 04:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-15-farosas@suse.de>
In-Reply-To: <20260109124043.25019-15-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 19 Jan 2026 17:57:32 +0530
X-Gm-Features: AZwV_QhiNzfXFWqZsb9948PsPEItujlDuYWY4uz7q4O1zhl0JXTfmPTXk7Z4FK8
Message-ID: <CAE8KmOwahU3vybULJ55o3GxVNge40_kyyciBxwDfhyhDvGvmvA@mail.gmail.com>
Subject: Re: [PATCH v3 14/25] migration/rdma: Use common connection paths
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Li Zhijian <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 9 Jan 2026 at 18:13, Fabiano Rosas <farosas@suse.de> wrote:
> Use the common connection paths for the incoming and outgoing sides of
> rdma migration. This removes one usage of QEMUFile from rdma.c. It
> also allows further unification of the connection code in next
> patches.
>
> Move the channels enum to channel.h so rdma.c can access it. The RDMA
> channel is considered a CH_MAIN channel.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.h   |  7 +++++++
>  migration/migration.c | 13 -------------
>  migration/migration.h |  1 -
>  migration/rdma.c      | 23 +++++++++++------------
>  4 files changed, 18 insertions(+), 26 deletions(-)
>
> diff --git a/migration/channel.h b/migration/channel.h
> index ccfeaaef18..93dedbf52b 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -18,6 +18,13 @@
>
>  #include "io/channel.h"
>
> +/* Migration channel types */
> +enum {
> +    CH_MAIN,
> +    CH_MULTIFD,
> +    CH_POSTCOPY
> +};
> +
>  void migration_channel_process_incoming(QIOChannel *ioc);
>
>  void migration_channel_connect(MigrationState *s, QIOChannel *ioc);
> diff --git a/migration/migration.c b/migration/migration.c
> index b7367eb5cf..7d56d73769 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -91,9 +91,6 @@ enum mig_rp_message_type {
>      MIG_RP_MSG_MAX
>  };
>
> -/* Migration channel types */
> -enum { CH_MAIN, CH_MULTIFD, CH_POSTCOPY };
> -
>  /* When we add fault tolerance, we could have several
>     migrations at once.  For now we don't need to add
>     dynamic creation of migration */
> @@ -1025,16 +1022,6 @@ void migration_incoming_process(void)
>      qemu_coroutine_enter(co);
>  }
>
> -void migration_fd_process_incoming(QEMUFile *f)
> -{
> -    MigrationIncomingState *mis = migration_incoming_get_current();
> -
> -    assert(!mis->from_src_file);
> -    mis->from_src_file = f;
> -    qemu_file_set_blocking(f, false, &error_abort);
> -    migration_incoming_process();
> -}
> -
>  static bool migration_has_main_and_multifd_channels(void)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> diff --git a/migration/migration.h b/migration/migration.h
> index 4dcf299719..cd6cfd62ba 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -527,7 +527,6 @@ struct MigrationState {
>  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>                         MigrationStatus new_state);
>
> -void migration_fd_process_incoming(QEMUFile *f);
>  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>  void migration_incoming_process(void);
>  bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 596a1aba0b..d902c8669c 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -15,6 +15,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "channel.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "exec/target_page.h"
> @@ -384,7 +385,6 @@ struct QIOChannelRDMA {
>      QIOChannel parent;
>      RDMAContext *rdmain;
>      RDMAContext *rdmaout;
> -    QEMUFile *file;
>      bool blocking; /* XXX we don't actually honour this yet */
>  };
>
> @@ -3836,32 +3836,30 @@ static void qio_channel_rdma_register_types(void)
>
>  type_init(qio_channel_rdma_register_types);
>
> -static QEMUFile *rdma_new_input(RDMAContext *rdma)
> +static QIOChannel *rdma_new_input(RDMAContext *rdma)
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
>
> -    rioc->file = qemu_file_new_input(QIO_CHANNEL(rioc));
>      rioc->rdmain = rdma;
>      rioc->rdmaout = rdma->return_path;
>
> -    return rioc->file;
> +    return QIO_CHANNEL(rioc);
>  }
>
> -static QEMUFile *rdma_new_output(RDMAContext *rdma)
> +static QIOChannel *rdma_new_output(RDMAContext *rdma)
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
>
> -    rioc->file = qemu_file_new_output(QIO_CHANNEL(rioc));
>      rioc->rdmaout = rdma;
>      rioc->rdmain = rdma->return_path;
>
> -    return rioc->file;
> +    return QIO_CHANNEL(rioc);
>  }
>
>  static void rdma_accept_incoming_migration(void *opaque)
>  {
>      RDMAContext *rdma = opaque;
> -    QEMUFile *f;
> +    QIOChannel *ioc;
>
>      trace_qemu_rdma_accept_incoming_migration();
>      if (qemu_rdma_accept(rdma) < 0) {
> @@ -3875,15 +3873,16 @@ static void rdma_accept_incoming_migration(void *opaque)
>          return;
>      }
>
> -    f = rdma_new_input(rdma);
> -    if (f == NULL) {
> +    ioc = rdma_new_input(rdma);
> +    if (ioc == NULL) {
>          error_report("RDMA ERROR: could not open RDMA for input");
>          qemu_rdma_cleanup(rdma);
>          return;
>      }
>
>      rdma->migration_started_on_destination = 1;
> -    migration_fd_process_incoming(f);
> +    migration_incoming_setup(ioc, CH_MAIN, &error_abort);
> +    migration_incoming_process();
>  }
>
>  void rdma_start_incoming_migration(InetSocketAddress *host_port,
> @@ -3995,8 +3994,8 @@ void rdma_start_outgoing_migration(void *opaque,
>
>      trace_rdma_start_outgoing_migration_after_rdma_connect();
>
> -    s->to_dst_file = rdma_new_output(rdma);
>      s->rdma_migration = true;
> +    migration_outgoing_setup(rdma_new_output(rdma));
>      migration_connect(s);
>      return;
>  return_path_err:
> --

* Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


