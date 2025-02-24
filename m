Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BC5C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 20:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmedf-00057S-21; Mon, 24 Feb 2025 15:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmedV-00056v-GH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:01:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmedS-0007vi-Be
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740427261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0fTghTPibK8gqHgVWc/vsWL5vej+q87gKhoY3eS6hOc=;
 b=Q54VSxfWFHyC+lSD0SIZBVl05vELr6lyW6T9M59PmMHhSHW+gmYVLof3TqV5kzcAI89Xfj
 sU/MlK5V0o6o2wIxA9SDJeh/mC3rkXOH7cUZMbBi4Oa5ukuFtG2RGY/7CRM3sfnfF4woSq
 9EsxGtPbSzTasRNvk1SdggbdEo9RJY8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-4K01G8-OMPeMloguSFO47Q-1; Mon, 24 Feb 2025 15:01:00 -0500
X-MC-Unique: 4K01G8-OMPeMloguSFO47Q-1
X-Mimecast-MFC-AGG-ID: 4K01G8-OMPeMloguSFO47Q_1740427260
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-471f4381c1eso107028751cf.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 12:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740427260; x=1741032060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0fTghTPibK8gqHgVWc/vsWL5vej+q87gKhoY3eS6hOc=;
 b=e3UQ9MCB25PJIMh75/GN5WS8P3NEXOCpjsHa5CLEzZSAyFE8lKQ5BBHGMem+NAaAoi
 h/Pxcizb/oNchbuKwei7HZicOF79hFP5u+6BtNvQ5rYpUHJRtLZok9KJQexldD4HksgZ
 RbDnsv1qczsRkAI009jB3EeOt4963OJro9EHS4Nh+2kGtrRYv9fzQ/2J2R4Cvgbsp6+x
 Eq8SzfG3SYRINDnJ7glnKS2zZPzArk1WMiR5bgqAyKN8MmWXFee42/J6P7qpvHi0U9KT
 l92WDfo715k0oko+EPZ3IBzljak0JLnhHdoC6+1MNmYG5OwgMHnlrpWe75mMh0t5oQyk
 ah0Q==
X-Gm-Message-State: AOJu0Yw3sf4fDYHR5ad3Bgs799mHG2/6lych9OZrxbXrhgEjH0tPYZm0
 VSSjoS2a7Ust0Br5MslDf7iUQqFVIjmmDZMcvsoNvepQk7mYrexKsBeNkrRBTRzmHNVFFL9FF19
 kqIFxzy1buotHPgvV+7oWQA+9jax5YJ58hCDJ9jXkU8HFS1xYpfA7
X-Gm-Gg: ASbGncsnH7/5zMgg++CGLRpuIm2NS1SpfCnePdgB7aUT9zSiBKust/C0k5hnZV6mXcD
 OykIBCIOMvUUIDfu4LVZwWtj2yJDliaj1Cpfer+TN/md0uiXypS5caBo5YUf1m1f0/cMWfGegfN
 adaEDB8C9ZZFQFj2N8JQDRHdrIlTDsW2LZfxeGkgNdnIiXI5Kmt1gVWNhbmhKjzPh25oESRFsNm
 5Eli6OLQvf/pWsbJw5L6fQNdvJFYfN8ENOQkxN/WkAVpayIo/ShPdF0s35oLfyJTs+zBQ==
X-Received: by 2002:a05:622a:113:b0:472:58b:4642 with SMTP id
 d75a77b69052e-47222947628mr197144111cf.47.1740427259683; 
 Mon, 24 Feb 2025 12:00:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjoLAxr4jr1cqHfNJgXYUwH5YLeDcYcO+Hx17L65a7KzXpd6S2ZoNlz9TjiLjsPajMjPqvkA==
X-Received: by 2002:a05:622a:113:b0:472:58b:4642 with SMTP id
 d75a77b69052e-47222947628mr197143461cf.47.1740427259228; 
 Mon, 24 Feb 2025 12:00:59 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47377e0715csm396441cf.6.2025.02.24.12.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 12:00:58 -0800 (PST)
Date: Mon, 24 Feb 2025 15:00:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 7/8] migration/rdma: Remove redundant
 migration_in_postcopy checks
Message-ID: <Z7zP-HRmX-Oe89Yf@x1.local>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
 <20250221063612.695909-8-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221063612.695909-8-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 21, 2025 at 02:36:11PM +0800, Li Zhijian wrote:
> Since we have disabled RDMA + postcopy, it's safe to remove
> the migration_in_postcopy()  that follows the migration_rdma().
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  migration/ram.c  | 2 +-
>  migration/rdma.c | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index e07651aee8d..c363034c882 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1939,7 +1939,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
>      int res;
>  
>      /* Hand over to RDMA first */
> -    if (migrate_rdma() && !migration_in_postcopy()) {

This line was just added in previous patch.

Would it be better move 5/6 above, then somehow squash 2/3/4/7 so that it
doesn't need to add something and got removed again?  I feel like the four
patches can be squashed into 1 or 2 instead when reorder them.

> +    if (migrate_rdma()) {
>          res = rdma_control_save_page(pss->pss_channel, pss->block->offset,
>                                       offset, TARGET_PAGE_SIZE);
>  
> diff --git a/migration/rdma.c b/migration/rdma.c
> index c6876347e1e..0349dd4a8b8 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3826,7 +3826,7 @@ int rdma_block_notification_handle(QEMUFile *f, const char *name)
>  
>  int rdma_registration_start(QEMUFile *f, uint64_t flags)
>  {
> -    if (!migrate_rdma() || migration_in_postcopy()) {
> +    if (!migrate_rdma()) {
>          return 0;
>      }
>  
> @@ -3858,7 +3858,8 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
>      RDMAControlHeader head = { .len = 0, .repeat = 1 };
>      int ret;
>  
> -    if (!migrate_rdma() || migration_in_postcopy()) {
> +    /* Hand over to RDMA first */
> +    if (!migrate_rdma()) {
>          return 0;
>      }
>  
> -- 
> 2.44.0
> 

-- 
Peter Xu


