Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8827EEFCE2A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqtj-0004Tf-8U; Wed, 04 Mar 2026 13:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxqti-0004TR-6s
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:24:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxqtg-0007O4-Oc
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772648675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQUZwEUOkiK/xrd4xFpZsZbuOPwMp9w/OyzVq7pNACM=;
 b=dACxryPCN9fNp2EWScXCSs9MNN96+sHrC445L6AOvHCmO8+Y8Xd+Hq/T/dnVw3g2LQw2I2
 lSBUxU/0W7ak5Dji7wtpdl/dpL4+z4U+J9q8iUfbJdbdgoF/hZU5n8dZvbOR88ptSVZ6N9
 pQTpnlHucLyWg+z6A6fHy05j2rUUhcc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-2pYlVI1UNjGu8E0W_fwUTw-1; Wed, 04 Mar 2026 13:24:33 -0500
X-MC-Unique: 2pYlVI1UNjGu8E0W_fwUTw-1
X-Mimecast-MFC-AGG-ID: 2pYlVI1UNjGu8E0W_fwUTw_1772648673
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cb6291d95aso238987385a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 10:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772648672; x=1773253472; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YQUZwEUOkiK/xrd4xFpZsZbuOPwMp9w/OyzVq7pNACM=;
 b=pYH2mydr7D3ucQvbUD8hk7AenFrkU/2E+q7AzN0fJP+QiyEJaxXa/X8ZFEfoX7K9Us
 9htrSzjT+vduiRCabReabhvpQXYZpb9odxuSy3kbexfPxXKn/CW1r/M8AQncQVUe5EGd
 vCuQQvQKZt9sjR4q4eQipm80l16rxkHaQyMwg6OqzOe8rRpULNTTvmftH9Dn5CmZAZvt
 gBMTctVI9QiPsTx43/9eGp2svmrixub3UckS3tKjlQq/1pELhDLQbrlJx6x2YAGWq4zt
 iBpMgkWrtywdjRHVjZmNy0DGX4ejaqgG2qKbG2hCDbMhUMeLksUHm8Myr9cXfTAmkDRk
 Eg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772648672; x=1773253472;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YQUZwEUOkiK/xrd4xFpZsZbuOPwMp9w/OyzVq7pNACM=;
 b=cpAy0J8o8YraUEDcVu7Bmc7VfiHYAOGZdA43NYfG5/8I+NqP5c7QrcsIKCm6GDFeLN
 erwOaidveEJC0CympbrtvrFR01dterQIhprZrVVRejOi0S0UdwRO+cPXf6ZcMKScC46i
 NyjskLQzF0M3eavNkaIpQui24NRXrdpl2jio/3I+26yP7gf6V/ao8WFIEg/T8umd1aKX
 1cXpXRC4IEasfZd745mXKecq8nFBaPC+osfh/gq+JyiWoPLwKGoWYpfvQAX82bkXaJYl
 OHr0TrQjOEphMFQhHOJZ3PFusXMQ4a5axYgJrkR2IJotwPVUljspxiIxxn6IKL4UYEqW
 2y/A==
X-Gm-Message-State: AOJu0YwjJdQD6Qo4cUmv5pUN2mPI9YNCJPqQbJWPUN2uBVHyQ8iTPFbW
 YAWYjCUlJBFY/b+UIl1HFy5DY8DyXj7E4Y5CIKoyK85B63VFL48oarPZWGeYrPUjJtYDHef+hFg
 sTlwp7N0/v2uyQbTf9dMmQFePw2o03JiEiwDBNRTkLViBDD0U4SCodGV82/R/Pq1Q
X-Gm-Gg: ATEYQzzUmDwOx30LB3Xg/Cdrh0+PW23uD6haAKKEymgNT8W2NufFSMb77/mM7B+icP2
 vsJ7Ln1KLAqMUqlzltBiBqeyZpBbxSoC7vA9ZxElG+NdSc5d5I5D4iDvE2juBHo5W/gZ5gZaNhz
 SbphCLXNC/lEUDw57Qy0gvXplaxbb6uNNGauA61gC64bdmiRjurDHbd8l4l6U0H++AfvsPsZbL/
 muZvQ3VGBH94S+avqzB6c/Hda7j0DAOXf23lPakA0MwrhIXvJGMyhmyLtgb09tf36Qs0FHVuGIL
 mASF4Lv1jyvrz6hKi7UOOU1PZqJZ+yCu0M6lUou64fmRofqL2JhVXn4UZngOplAk6CqGpO349hu
 l1VYWDw4nxZ04wA==
X-Received: by 2002:a05:620a:3711:b0:8ca:3ed2:175c with SMTP id
 af79cd13be357-8cd5af75f5dmr369800085a.43.1772648672162; 
 Wed, 04 Mar 2026 10:24:32 -0800 (PST)
X-Received: by 2002:a05:620a:3711:b0:8ca:3ed2:175c with SMTP id
 af79cd13be357-8cd5af75f5dmr369795685a.43.1772648671569; 
 Wed, 04 Mar 2026 10:24:31 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf72e21bsm1687787985a.44.2026.03.04.10.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 10:24:31 -0800 (PST)
Date: Wed, 4 Mar 2026 13:24:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH 5/7] system/memory: Display address spaces starting at
 0x0000.0000
Message-ID: <aah40xnBszzsWyT0@x1.local>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226220226.20164-6-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

Hi, Phil!

On Thu, Feb 26, 2026 at 11:02:23PM +0100, Philippe Mathieu-Daudé wrote:
> Since AddressSpace root MemoryRegion can be remapped, it is
> bogus to use the MemoryRegion address as the AddressSpace
> absolute address. Besides, the AddressSpace APIs take an
> @addr argument expecting AddressSpaces start at 0x0000.0000.

Could you share an example where a root MR can have addr!=0, and be
remapped while being the root MR of an AS?

Thanks,

> 
> Substract the MemoryRegion address in mtree_print_mr() to
> display AddressSpaces starting at 0x0000.0000.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  system/memory.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index d5060774834..1106f48d0d5 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3360,7 +3360,7 @@ static void mtree_print_mr_owner(const MemoryRegion *mr)
>  }
>  
>  static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
> -                           hwaddr base,
> +                           hwaddr offset, bool detect_overflow,
>                             MemoryRegionListHead *alias_print_queue,
>                             bool owner, bool display_disabled)
>  {
> @@ -3374,7 +3374,7 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>          return;
>      }
>  
> -    cur_start = base + mr->addr;
> +    cur_start = mr->addr + offset;
>      cur_end = cur_start + MR_SIZE(mr->size);
>  
>      /*
> @@ -3382,7 +3382,7 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>       * happen normally. When it happens, we dump something to warn the
>       * user who is observing this.
>       */
> -    if (cur_start < base || cur_end < cur_start) {
> +    if (detect_overflow && (cur_start < offset || cur_end < cur_start)) {
>          qemu_printf("[DETECTED OVERFLOW!] ");
>      }
>  
> @@ -3462,7 +3462,7 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>      }
>  
>      QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
> -        mtree_print_mr(ml->mr, level + 1, cur_start,
> +        mtree_print_mr(ml->mr, level + 1, cur_start, true,
>                         alias_print_queue, owner, display_disabled);
>      }
>  
> @@ -3641,7 +3641,8 @@ static void mtree_print_as(gpointer key, gpointer value, gpointer user_data)
>      struct AddressSpaceInfo *asi = user_data;
>  
>      g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
> -    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled);
> +    mtree_print_mr(mr, 1, -mr->addr, false,
> +                   asi->ml_head, asi->owner, asi->disabled);
>      qemu_printf("\n");
>  }
>  
> @@ -3688,7 +3689,7 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
>          const MemoryRegion *mr = ml->mr;
>  
>          qemu_printf("memory-region: %s\n", memory_region_name(mr));
> -        mtree_print_mr(mr, 1, 0, &ml_head, owner, disabled);
> +        mtree_print_mr(mr, 1, 0, false, &ml_head, owner, disabled);
>          qemu_printf("\n");
>      }
>  
> -- 
> 2.52.0
> 

-- 
Peter Xu


