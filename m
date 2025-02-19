Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B111C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 13:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkk3b-0000Hu-Rt; Wed, 19 Feb 2025 08:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkk3Z-0000HM-Ic
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:24:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkk3X-0000Z6-AI
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739971442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gMwi4mOlVKrhhA5BBEdM2yWvk3njB0aVNAj7lrSGSpM=;
 b=XfGZXRiCbPvmq+fHp6HqIxfeuh5dadtsfaGZlUAUJFT0bJsyPFXt1tTVpJ2tuiV6uvDTNV
 3dxwotKtIXEbrBkj2MXrup9GOo7obwGW3ltaVE8I/ot7opnbBCu3TWLgKzVIhtVKUwD9GT
 LllgJKIe1O63+RUDgkgsmEXuFFwXrP8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-gYLSR9PzO06GCECdteu-Pg-1; Wed, 19 Feb 2025 08:23:58 -0500
X-MC-Unique: gYLSR9PzO06GCECdteu-Pg-1
X-Mimecast-MFC-AGG-ID: gYLSR9PzO06GCECdteu-Pg_1739971438
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e4f08c54e6so58808496d6.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 05:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739971438; x=1740576238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMwi4mOlVKrhhA5BBEdM2yWvk3njB0aVNAj7lrSGSpM=;
 b=PeU0MG0EqmgnX1EaKik9QfPHaFnCFh05dppJ1q5eRMdvXTThCKeOonVQvAeGj8/tWN
 qSyuS+0x5Kx7TCGQLvFNG4//uzvDOkMMYnET1qE63Ybab7ErQlJHSx688U7wZqrPAwZ4
 zusrrZ/vLMUW/3jNKJbdikAotS+4AILjk8SWFb5oggnVtBsx851B+j/AwCDpQURUFg7j
 hNGW3cHRyYg4923GWCwyYRngaj8sZQ1R7X2VEmD8svQfjDBSVzhPWgKI0JUGST4ZQUBR
 sY4wzXYVAuXZj8Ku6mmYapwwFrDJX6qgF5Yd7ujWKp/wb510QSET8ibFS/p/H7GQJiT4
 M/NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9+qfcAVZN+BWPcw0Kc7p+LDG1JIiBtClwb8IsuoTfiExCISVg/TCiVmaCPhNBgz+i0Zf41cFybhin@nongnu.org
X-Gm-Message-State: AOJu0Yzi8qUlDPXCEqaIJQwxlHlHGjxyZdzBouWvbhdYkSq8CaECET1Q
 GVEw30MOM3VafGz4tihcgXQR6wLS59QhLICuUR3/SXE6zallX4WpaLSAJMReex0G0n3gq/WKZaF
 3t9/RMYZyeDQF2jE/ak7pb/1QNE6EsDCvUXLsdqZI3oIuauoY1040
X-Gm-Gg: ASbGncsQ4/3LEkJEQldKqRfP4S+qnyikFun65aRUAcc75NlcEln9sxcD8QTYOSqLoYA
 bY15d+JAg1I8FE9nqdcAOqOqVn9JBTmz6lbuVvNq338G18brfJIW8BqdXvGDEquLvkpjOEwL7iC
 06cyzvNAUFMsBgVLZqyq9Cdic1rJa1XImJ4hEZ6uKUau2hSRbXvSBQ4gsOyviYOK30WZgjhX0rD
 5lGUBkRVrGQRAqIGqdUNS1pNHehkXozF4ZidpNxGoVkEk8j9aSVasvET2A=
X-Received: by 2002:a05:6214:ace:b0:6d8:9d28:ff07 with SMTP id
 6a1803df08f44-6e6975bd7abmr47366096d6.45.1739971437734; 
 Wed, 19 Feb 2025 05:23:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIsnf+mXP/Ss90ycivqCSnzBEVzswh5HPa6j2tx3HEptLMYC2jCqYMNe+zKBmtzRlFHWTqCg==
X-Received: by 2002:a05:6214:ace:b0:6d8:9d28:ff07 with SMTP id
 6a1803df08f44-6e6975bd7abmr47365846d6.45.1739971437368; 
 Wed, 19 Feb 2025 05:23:57 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e65dcf88d6sm74788206d6.122.2025.02.19.05.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 05:23:56 -0800 (PST)
Date: Wed, 19 Feb 2025 08:23:53 -0500
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Fabiano Rosas <farosas@suse.de>, Li Zhijian via <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] migration: Prioritize RDMA in ram_save_target_page()
Message-ID: <Z7XbaXI4-fiVHYE7@x1.local>
References: <20250218074345.638203-1-lizhijian@fujitsu.com>
 <8734gb9erz.fsf@suse.de> <Z7UDtxdNSS-Jqm-y@x1.local>
 <0930f197-ae7f-4920-bac8-838733683883@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0930f197-ae7f-4920-bac8-838733683883@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 19, 2025 at 09:39:38AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 19/02/2025 06:03, Peter Xu wrote:
> > On Tue, Feb 18, 2025 at 05:30:40PM -0300, Fabiano Rosas wrote:
> >> Li Zhijian via <qemu-devel@nongnu.org> writes:
> >>
> >>> Address an error in RDMA-based migration by ensuring RDMA is prioritized
> >>> when saving pages in `ram_save_target_page()`.
> >>>
> >>> Previously, the RDMA protocol's page-saving step was placed after other
> >>> protocols due to a refactoring in commit bc38dc2f5f3. This led to migration
> >>> failures characterized by unknown control messages and state loading errors
> >>> destination:
> >>> (qemu) qemu-system-x86_64: Unknown control message QEMU FILE
> >>> qemu-system-x86_64: error while loading state section id 1(ram)
> >>> qemu-system-x86_64: load of migration failed: Operation not permitted
> >>> source:
> >>> (qemu) qemu-system-x86_64: RDMA is in an error state waiting migration to abort!
> >>> qemu-system-x86_64: failed to save SaveStateEntry with id(name): 1(ram): -1
> >>> qemu-system-x86_64: rdma migration: recv polling control error!
> >>> qemu-system-x86_64: warning: Early error. Sending error.
> >>> qemu-system-x86_64: warning: rdma migration: send polling control error
> >>>
> >>> RDMA migration implemented its own protocol/method to send pages to
> >>> destination side, hand over to RDMA first to prevent pages being saved by
> >>> other protocol.
> >>>
> >>> Fixes: bc38dc2f5f3 ("migration: refactor ram_save_target_page functions")
> >>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >>> ---
> >>>   migration/ram.c | 9 +++++----
> >>>   1 file changed, 5 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/migration/ram.c b/migration/ram.c
> >>> index 6f460fd22d2..635a2fe443a 100644
> >>> --- a/migration/ram.c
> >>> +++ b/migration/ram.c
> >>> @@ -1964,6 +1964,11 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
> >>>       ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> >>>       int res;
> >>>   
> >>> +    /* Hand over to RDMA first */
> >>> +    if (control_save_page(pss, offset, &res)) {
> >>> +        return res;
> >>> +    }
> >>> +
> >>
> >> Can we hoist that migrate_rdma() from inside the function? Since the
> >> other paths already check first before calling their functions.
> > 
> 
> Yeah, it sounds good to me.
> 
> 
> > If we're talking about hoist and stuff.. and if we want to go slightly
> > further, I wonder if we could also drop RAM_SAVE_CONTROL_NOT_SUPP.
> > 
> >      if (!migrate_rdma() || migration_in_postcopy()) {
> >          return RAM_SAVE_CONTROL_NOT_SUPP;
> >      }
> > 
> > We should make sure rdma_control_save_page() won't get invoked at all in
> > either case above..  
> 
> > For postcopy, maybe we could fail in the QMP migrate /
> > migrate_incoming cmd, at migration_channels_and_transport_compatible()
> 
> I tried to kill RAM_SAVE_CONTROL_NOT_SUPP, but It seems it doesn't need to touch any postcopy logic
> "in the QMP migrate / migrate_incoming cmd, at migration_channels_and_transport_compatible()"
> 
> Is there something I might have overlooked?

Yes it looks almost good.  What I meant is (please see below):

> 
> A whole draft diff would be like below:
> It includes 3 parts:
> 
> migration/rdma: Remove unnecessary RAM_SAVE_CONTROL_NOT_SUPP check in rdma_control_save_page()
> migration: kill RAM_SAVE_CONTROL_NOT_SUPP
> migration: open control_save_page() to ram_save_target_page()
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 589b6505eb2..fc6a964fd64 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1143,32 +1143,6 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
>       return len;
>   }
>   
> -/*
> - * @pages: the number of pages written by the control path,
> - *        < 0 - error
> - *        > 0 - number of pages written
> - *
> - * Return true if the pages has been saved, otherwise false is returned.
> - */
> -static bool control_save_page(PageSearchStatus *pss,
> -                              ram_addr_t offset, int *pages)
> -{
> -    int ret;
> -
> -    ret = rdma_control_save_page(pss->pss_channel, pss->block->offset, offset,
> -                                 TARGET_PAGE_SIZE);
> -    if (ret == RAM_SAVE_CONTROL_NOT_SUPP) {
> -        return false;
> -    }
> -
> -    if (ret == RAM_SAVE_CONTROL_DELAYED) {
> -        *pages = 1;
> -        return true;
> -    }
> -    *pages = ret;
> -    return true;
> -}
> -
>   /*
>    * directly send the page to the stream
>    *
> @@ -1964,6 +1938,16 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
>       ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>       int res;
>   
> +    if (migrate_rdma() && !migration_in_postcopy()) {

Here instead of bypassing postcopy, we should fail the migrate cmd early if
postcopy ever enabled:

diff --git a/migration/migration.c b/migration/migration.c
index 862f469ea7..3a82e71437 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -257,6 +257,12 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
         return false;
     }
 
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE &&
+        migrate_postcopy_ram()) {
+        error_setg(errp, "RDMA migration doesn't support postcopy");
+        return false;
+    }
+
     return true;
 }

> +        res = rdma_control_save_page(pss->pss_channel, pss->block->offset,
> +                                     offset, TARGET_PAGE_SIZE);
> +
> +        if (res == RAM_SAVE_CONTROL_DELAYED) {
> +            res = 1;
> +        }
> +        return res;
> +    }
> +
>       if (!migrate_multifd()
>           || migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
>           if (save_zero_page(rs, pss, offset)) {
> @@ -1976,10 +1960,6 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
>           return ram_save_multifd_page(block, offset);
>       }
>       }
>   
> -    if (control_save_page(pss, offset, &res)) {
> -        return res;
> -    }
> -
>       return ram_save_page(rs, pss);
>   }
>   
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 76fb0349238..c6876347e1e 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3284,14 +3284,11 @@ err:
>   int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
>                              ram_addr_t offset, size_t size)
>   {
> -    if (!migrate_rdma() || migration_in_postcopy()) {
> -        return RAM_SAVE_CONTROL_NOT_SUPP;
> -    }
> +    assert(migrate_rdma());
>   
>       int ret = qemu_rdma_save_page(f, block_offset, offset, size);
>   
> -    if (ret != RAM_SAVE_CONTROL_DELAYED &&
> -        ret != RAM_SAVE_CONTROL_NOT_SUPP) {
> +    if (ret != RAM_SAVE_CONTROL_DELAYED) {
>           if (ret < 0) {
>               qemu_file_set_error(f, ret);
>           }
> diff --git a/migration/rdma.h b/migration/rdma.h
> index f55f28bbed1..bb0296c3726 100644
> --- a/migration/rdma.h
> +++ b/migration/rdma.h
> @@ -33,7 +33,6 @@ void rdma_start_incoming_migration(InetSocketAddress *host_port, Error **errp);
>   #define RAM_CONTROL_ROUND     1
>   #define RAM_CONTROL_FINISH    3
>   
> -#define RAM_SAVE_CONTROL_NOT_SUPP -1000
>   #define RAM_SAVE_CONTROL_DELAYED  -2000
>   
>   #ifdef CONFIG_RDMA
> @@ -56,7 +55,9 @@ static inline
>   int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
>                              ram_addr_t offset, size_t size)
>   {
> -    return RAM_SAVE_CONTROL_NOT_SUPP;
> +    /* never reach */
> +    assert(0);
> +    return -1;
>   }
>   #endif
>   #endif
> 
> 
> 
> 
> Thanks
> Zhijian
> 
> > 
> >>
> >>>       if (!migrate_multifd()
> >>>           || migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
> >>>           if (save_zero_page(rs, pss, offset)) {
> >>> @@ -1976,10 +1981,6 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
> >>>           return ram_save_multifd_page(block, offset);
> >>>       }
> >>>   
> >>> -    if (control_save_page(pss, offset, &res)) {
> >>> -        return res;
> >>> -    }
> >>> -
> >>>       return ram_save_page(rs, pss);
> >>>   }
> >>
> > 

-- 
Peter Xu


