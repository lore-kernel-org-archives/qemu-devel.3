Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AD4C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 06:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDGqj-0004oN-8o; Fri, 09 May 2025 02:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uDGqV-0004je-D3
 for qemu-devel@nongnu.org; Fri, 09 May 2025 02:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uDGqT-0003Dy-LB
 for qemu-devel@nongnu.org; Fri, 09 May 2025 02:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746770667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HjAoYaLhZpqMCjPL/iLBw0WthQv1l6BPcZV2ENe3NGs=;
 b=IEjFhksvYv83gSQeHzLPec5M/trpwef7gAHLdUmYG0vL7x7i94htu2+317atk3/8duV2/E
 c+pZSi9B/rAqdL3//TRuivy1YAgpwVET2EWWTPFjgCXRqV/ivoHnS5PwujI2NuBjRJlM32
 HufzrdHt7KCpe+T5nwwZNgEBvWSfo4o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-FJs8mqSDP7mbEuVD9qPpgw-1; Fri, 09 May 2025 02:04:25 -0400
X-MC-Unique: FJs8mqSDP7mbEuVD9qPpgw-1
X-Mimecast-MFC-AGG-ID: FJs8mqSDP7mbEuVD9qPpgw_1746770664
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-44059976a1fso6225465e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 23:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746770664; x=1747375464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HjAoYaLhZpqMCjPL/iLBw0WthQv1l6BPcZV2ENe3NGs=;
 b=b/cSkOPfNLNZRytskeT/5YKd2ARtCSEHbBLC1F5JNC7HXQPPmr1qO2f71Jh0Zn0mHL
 fk2RTQKed3kskZo3Qdzqd29Vh9FqkcZCxykIk39cgKZRjxPbh7AC/1RRQBTVfUYDlVYm
 uGbHiG/E23SRZXSYqn2AzeHNIiE92Piu2OOyamCaq5z03NlNdmNXSWxgA56zKFoJNPzc
 TuMyOGuTkkDNISjpziVMsZeT+sWE4PQH2kVayMX8TXNFZqa71CkDWn3Ppc7P1rfrJEEO
 8GuGmt47ok85Cd/teOUtPnyVYUYCwKA8pKCENHaQiIxtqhn+nQkLEuVFkAPQEApt0YuW
 eX4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRMpps+jL3rTfRL2mVjiKxmZPrGOLb2Ra2BZfUZfYIMxwPLK/3y2RmTsriJGCujGQLjNv71sjaL/j5@nongnu.org
X-Gm-Message-State: AOJu0YyBYSP6k91JWp4qU6eNw3+vs/97Qsn8O6UPX1qajjafcqMmzqqq
 0ncItHB1luPGYbolFDmOjyK2UGP9Ym3ZAR2hAJgEcViM1D8oRzay/xSbG0MH2Yabf2LRub7g+Jl
 br7xhtAjtF6+88OIJBBOxdM0Lhr2xRu0SY68zSrTIS3fYtG9N5u1v8fh1P6GO15qLC640Q7on2c
 TBSYBrTlJW97IY/a0L/bKw4E0pKIc=
X-Gm-Gg: ASbGncv0ApxIKHEjD0YhJVS1xAe2CtT2kg6Tn42lL1v5PLxaCzfDg/r6w9poSUYPqHp
 /SjQEM/YG5/E1wuwiy22utl180xZ+w6PDSPGrKVA6gsQXGe6ct7hRQTbIuESCCzodQRRbVVc=
X-Received: by 2002:a05:600c:3c87:b0:43c:e9f7:d6a3 with SMTP id
 5b1f17b1804b1-442d6d44d1cmr16882115e9.13.1746770663765; 
 Thu, 08 May 2025 23:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR7udclj5IOldEE0yngowZHah6KJ2dOvJvq0k/U7eo49EZIG/L9oFPoAu5zv9FHAzKbhGNvdMsFsDTAD/EGOs=
X-Received: by 2002:a05:600c:3c87:b0:43c:e9f7:d6a3 with SMTP id
 5b1f17b1804b1-442d6d44d1cmr16881845e9.13.1746770663392; Thu, 08 May 2025
 23:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250508122849.207213-1-ppandit@redhat.com>
 <20250508122849.207213-4-ppandit@redhat.com>
 <87ecwzfbnk.fsf@suse.de> <aBzQYslYtUZgXjgO@x1.local>
In-Reply-To: <aBzQYslYtUZgXjgO@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 9 May 2025 11:34:06 +0530
X-Gm-Features: AX0GCFsx6lAnxGKiUaJbbkTQHI6N1neFetE_-XK7op0fuahoZuEm9XFQapfbpEg
Message-ID: <CAE8KmOzi8Zzy5hE2SMdTbMZJQD5_XH34rfEP_B85jstUF9E08g@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] migration: write zero pages when postcopy enabled
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

> > This patch should come before 1/3, otherwise it'll break bisect.
> We could squash the two together, IMHO.

* It is adjusting the specific optimisation behaviour for the use case
of when Multifd and Postcopy are enabled together. I think it's better
as a separate patch. It'll help to see how that optimization
changed/evolved over time.

> > s/ones/once/
> >
> > > +         *
> > > +         * It becomes a problem when both Multifd & Postcopy options are
> > > +         * enabled. If the zero page which was skipped during multifd phase,
> > > +         * is accessed during the Postcopy phase of the migration, a page
> > > +         * fault occurs. But this page fault is not served because the
> > > +         * 'receivedmap' says the zero page is already received. Thus the
> > > +         * migration hangs.
>
> More accurate version could be: "the thread accessing the page may hang".
> As discussed previously, in most cases IIUC it won't hang migration when
> accessed in vcpu contexts, and will move again when all pages migrated
> (triggers uffd unregistrations).

* Okay.

> Meanwhile when at it.. for postcopy if we want we don't need to set all
> zeros.. just fault it in either using one inst.  Summary:
>
> void multifd_recv_zero_page_process(MultiFDRecvParams *p)
> {
>     bool received;
>
>     for (int i = 0; i < p->zero_num; i++) {
>         void *page = p->host + p->zero[i];
>
>         received = ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i]);
>         if (!received) {
>             ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
>         }

* Okay.

>         if (received) {
>             /* If it has an older version, we must clear the whole page */
>             memset(page, 0, multifd_ram_page_size());
>         } else if (migrate_postcopy_ram()) {
>             /*
>              * If postcopy is enabled, we must fault in the page because
>              * XXX (please fill in..).  Here we don't necessarily need to
>              * zero the whole page because we know it must be pre-filled
>              * with zeros anyway.
>              */
>             *(uint8_t *)page = 0;
>
> We could also use MADV_POPULATE_WRITE but not sure which one is faster, and
> this might still be easier to follow anyway..

* Not sure how this is to work; During Multifd phase (Postcopy not
running), when migrate_postcopy_ram() returns true, we shall raise a
page fault here?

* Could we zero-initialise the destination guest memory when migration
starts? And not migrate the zero pages from the source at all? ie. we
mark the page received in the 'receivedmap' as is done now, but page
fault should also not happen for that guest address, because the
memory was already zero-initialised at the beginning. I think there
might be some scope to send zero-page entries piggy-backed with
non-zero pages, whose contents are migrated anyway.

* Say there are 10 pages (4KB each, Total: 40KB). Of these 10 pages:

        Non-zero pages: 1, 2, 4, 7, 9, 10
               Zero Pages: 3, 5-6 and 8

* We only migrate/send non-zero pages from source to the destination.
When non-zero page-4 is migrated, an entry/hint of page-3 being zero
one is piggy-backed with it. When non-zero page-7 is sent an
entry/hint of pages-5-6 being zero pages is sent with it. Similarly a
hint of page-8 being zero page is sent along with page-9. (thinking
aloud)

Thank you.
---
  - Prasad


