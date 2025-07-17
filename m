Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739ADC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucJdV-0004pH-Ea; Thu, 17 Jul 2025 04:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucJdQ-0004kE-JL
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:06:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucJdH-0006mu-7J
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752739581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RlJnwjeDE1GAbnO/XxhFYXL7uAR2EHW+OEhbSnCRXaw=;
 b=EqHRq0h9VdHeONpOw2Y4PL1ayblGKeYMaSNIouZceWlVis6a/ve/wuwea2NuqKiG+m2AAa
 pERuHtLs/N/fTMmpMew4wn3N9Rci2YE9hN+ramnersASwFHHgf+1/Hp9TzR1O9lJ0I/EqK
 BecCoM1bBLuherie866XrtDdzfNQUzw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-VUMwkSP8OOKVy6RiisRNzg-1; Thu, 17 Jul 2025 04:06:19 -0400
X-MC-Unique: VUMwkSP8OOKVy6RiisRNzg-1
X-Mimecast-MFC-AGG-ID: VUMwkSP8OOKVy6RiisRNzg_1752739578
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b38fc4d8dbaso801590a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 01:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752739578; x=1753344378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RlJnwjeDE1GAbnO/XxhFYXL7uAR2EHW+OEhbSnCRXaw=;
 b=nh7msdCTZAzLIRBAiEUBA37pMVQwuzKtnjRX0fq/LL+TKeSVIKhk5/P5iqO8YLwwd1
 BkTvO6WTsKpyGaGo6DSj2PzuZOzovGRMEmLGNkzvAtGoBkkoEXm7TXmok012Ng+aCQKw
 n65sFMvzSJ2juBkgIJp0AtEw7fE1AmGisoKYWuLsR8mcVCoqKXhDwmAqOd7nLznncSL/
 MhQaQGk8o7xfnS5ZuWxEQY+eT+idbibHItolFtIaHX64oges3vdTPSJMXGqBMcVypJtj
 FSiQvJhw1hYm5/mKMZvUh4EAD5MisgyuvWPSt6RFxNbc7YMnED73K/VVEfDeflfnYhi0
 n2JQ==
X-Gm-Message-State: AOJu0YzOsV4jBPBvievjTTgIbzTJPFmsCcDwfxDQPDUQzSmkyVY/1Ev4
 6i7SGgwnFL5EeZ9hZTtxcRIfGEZ5og/HBCJ8ekQv0mucr2u+d/hzt+aR0ipVwqk865h1UHla/V+
 6zuYGF85kzh4CR4wOMIZmAYwY/CvsKuuM6rFOGmcF8rPgU/BVOiOL4JW4
X-Gm-Gg: ASbGnctKCMhxkYmmlGWqwhhhWrsJSjrXCDL6/45fdTjt4NqBuCsaNoQMaWy68E0RPdl
 i0IZ1Wy9UrN++G018GV1Y7yMOTJ9QBRNxX4NPXnp3EE8jdpRHg0EIj8+IQo9krOj7aQXWl3w5rk
 8l1d8BSgzGsiRjmslBHsVb3HtpeFTCFreN52+LYn9VTTibkoUvNpIYgcAnBf80Hvx6CA2mU5SQ3
 4ppnB40w37zoBAp278Ig4//5a7SRY5ttnH5HeLhCPt/QGyhMR/bg0+kUC5yRbsnDBq4jec0hhRc
 XCu8hN/fMJnxJwEK3Bcb89+kPW1cCwtY96S/y4DVv6qUZPpeAXeALA==
X-Received: by 2002:a05:6300:628d:b0:238:351a:6442 with SMTP id
 adf61e73a8af0-238351aa1e9mr5909217637.45.1752739578213; 
 Thu, 17 Jul 2025 01:06:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNu6IJWCZi0IiL4eGl25b5bj0yrW0Gg4EwUs+FZjIyZxHZutc+AjsV8YIDGdFLk50eOju5Cg==
X-Received: by 2002:a05:6300:628d:b0:238:351a:6442 with SMTP id
 adf61e73a8af0-238351aa1e9mr5909180637.45.1752739577781; 
 Thu, 17 Jul 2025 01:06:17 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.169])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe52cddesm15130094a12.6.2025.07.17.01.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 01:06:17 -0700 (PDT)
Date: Thu, 17 Jul 2025 13:36:06 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v5 09/23] migration: push Error **errp into
 ram_postcopy_incoming_init()
Message-ID: <aHiu7m0SokILGIXl@armenon-kvm.bengluru.csb>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
 <20250717-propagate_tpm_error-v5-9-1f406f88ee65@redhat.com>
 <c535b2b0-78d6-4afa-bd6a-d11159d3a952@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c535b2b0-78d6-4afa-bd6a-d11159d3a952@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Akihiko,

Thanks for the review.

On Thu, Jul 17, 2025 at 12:34:21PM +0900, Akihiko Odaki wrote:
> On 2025/07/17 9:37, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that ram_postcopy_incoming_init() must report an error
> > in errp, in case of failure.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   migration/postcopy-ram.c | 9 ++++++---
> >   migration/postcopy-ram.h | 2 +-
> >   migration/ram.c          | 6 +++---
> >   migration/ram.h          | 2 +-
> >   migration/savevm.c       | 2 +-
> >   5 files changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 45af9a361e8eacaad0fb217a5da2c5004416c1da..05617e5fbcad62226a54fe17d9f7d9a316baf1e4 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -681,6 +681,7 @@ out:
> >    */
> >   static int init_range(RAMBlock *rb, void *opaque)
> >   {
> > +    Error **errp = opaque;
> >       const char *block_name = qemu_ram_get_idstr(rb);
> >       void *host_addr = qemu_ram_get_host_addr(rb);
> >       ram_addr_t offset = qemu_ram_get_offset(rb);
> > @@ -701,6 +702,8 @@ static int init_range(RAMBlock *rb, void *opaque)
> >        * (Precopy will just overwrite this data, so doesn't need the discard)
> >        */
> >       if (ram_discard_range(block_name, 0, length)) {
> > +        error_setg(errp, "failed to discard RAM block %s len=%zu",
> > +                   block_name, length);
> >           return -1;
> >       }
> > @@ -749,9 +752,9 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
> >    * postcopy later; must be called prior to any precopy.
> >    * called from arch_init's similarly named ram_postcopy_incoming_init
> >    */
> > -int postcopy_ram_incoming_init(MigrationIncomingState *mis)
> > +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)
> >   {
> > -    if (foreach_not_ignored_block(init_range, NULL)) {
> > +    if (foreach_not_ignored_block(init_range, errp)) {
> >           return -1;
> >       }
> > @@ -1703,7 +1706,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis, Error **errp)
> >       return false;
> >   }
> > -int postcopy_ram_incoming_init(MigrationIncomingState *mis)
> > +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)
> >   {
> >       error_report("postcopy_ram_incoming_init: No OS support");
> >       return -1;
> > diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> > index 3852141d7e37ab18bada4b46c137fef0969d0070..ca19433b246893fa5105bcebffb442c58a9a4f48 100644
> > --- a/migration/postcopy-ram.h
> > +++ b/migration/postcopy-ram.h
> > @@ -30,7 +30,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis);
> >    * postcopy later; must be called prior to any precopy.
> >    * called from ram.c's similarly named ram_postcopy_incoming_init
> >    */
> > -int postcopy_ram_incoming_init(MigrationIncomingState *mis);
> > +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp);
> >   /*
> >    * At the end of a migration where postcopy_ram_incoming_init was called.
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 7208bc114fb5c366740db380ee6956a91b3871a0..8223183132dc0f558f45fbae3f4f832845730bd3 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3708,7 +3708,7 @@ static int ram_load_cleanup(void *opaque)
> >   /**
> >    * ram_postcopy_incoming_init: allocate postcopy data structures
> >    *
> > - * Returns 0 for success and negative if there was one error
> > + * Returns 0 for success and -1 if there was one error
> 
> This is true but not relevant in this patch's goal.
> 
> Besides, I'm not in favor of letting callers make an assumption on integer
> return values (i.e., let callers assume a particular integer value in the
> error conditions). It is subtle to make a mistake to return -errno while the
> documentation says it returns -1.
> 
> I think a proper way to avoid bugs due to return values here is to change
> the type to bool, which ensures there are two possible values; that is a
> nice improvement but something that can be done later.

I agree, I shall remove the unnecessary documentation change as it is not in
the scope.

> 
> >    *
> >    * @mis: current migration incoming state
> >    *
> > @@ -3716,9 +3716,9 @@ static int ram_load_cleanup(void *opaque)
> >    * postcopy-ram. postcopy-ram's similarly names
> >    * postcopy_ram_incoming_init does the work.
> >    */
> > -int ram_postcopy_incoming_init(MigrationIncomingState *mis)
> > +int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp)
> >   {
> > -    return postcopy_ram_incoming_init(mis);
> > +    return postcopy_ram_incoming_init(mis, errp);
> >   }
> >   /**
> > diff --git a/migration/ram.h b/migration/ram.h
> > index 921c39a2c5c45bc2344be80854c46e4c10c09aeb..275709a99187f9429ccb4111e05281ec268ba0db 100644
> > --- a/migration/ram.h
> > +++ b/migration/ram.h
> > @@ -86,7 +86,7 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms);
> >   void ram_postcopy_send_discard_bitmap(MigrationState *ms);
> >   /* For incoming postcopy discard */
> >   int ram_discard_range(const char *block_name, uint64_t start, size_t length);
> > -int ram_postcopy_incoming_init(MigrationIncomingState *mis);
> > +int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp);
> >   int ram_load_postcopy(QEMUFile *f, int channel);
> >   void ram_handle_zero(void *host, uint64_t size);
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index d1edeaac5f2a5df2f6d94357388be807a938b2ef..8eba151a693b7f2dc58853292c92024288eae81e 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1983,7 +1983,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
> >           return -1;
> >       }
> > -    if (ram_postcopy_incoming_init(mis)) {
> > +    if (ram_postcopy_incoming_init(mis, NULL)) {
> >           return -1;
> >       }
> > 
> 

Regards,
Arun


