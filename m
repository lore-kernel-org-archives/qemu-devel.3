Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD04E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 15:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWGmh-0000u7-Vl; Fri, 10 Jan 2025 10:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tWGmf-0000tj-RF
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:18:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tWGmd-0004Rd-Lq
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736522327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5UpZh2fMURKku7Z8r4CdT4pbYBqmKqp8QjdXfUSMaI4=;
 b=D0pV/n3w95GunxXWWJdRY7Z9sg8jQIq8SIU5X88lwG1ZkAde09YBECDr/BdSYP8vSkAvoQ
 mhn5PtyOdBeKhkgKeKVJ7Uvi6BKA77FNKJhNCe9s1cKU9/uwizjodYS6DekbHKTmBecgdM
 nzL8zd5+Sh9FQr1l6Lltq890ChRy6sA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-Eho1kxjhOeCVu6dIiH_V6A-1; Fri, 10 Jan 2025 10:18:43 -0500
X-MC-Unique: Eho1kxjhOeCVu6dIiH_V6A-1
X-Mimecast-MFC-AGG-ID: Eho1kxjhOeCVu6dIiH_V6A
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4675749a982so37432691cf.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 07:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736522323; x=1737127123;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UpZh2fMURKku7Z8r4CdT4pbYBqmKqp8QjdXfUSMaI4=;
 b=F445OJGeZSgXsCBb12DzqI+eh3UTNuhU+n95m0RXV/SCMQSUh8nLly3fjvkLHnHMdb
 CSwb8agEVeqnhlrr7ICZKywjTxwvGBFshOTbNzLPBRuiSEH35zBKBZuKhgE/RjmbjDht
 xB/TumMlOkdLoxV5k30qEgcOI+LjDUURlD7E2fixMXfkwjDlFi0yJC1tnTTpnW4XGSJy
 5gcI+Zi9uKiy6X+CYTdAbMsifLhxs8yxB3agIYpwo8bGEC1JXXa2IkjlchZ8OLhYgqud
 bTks4yp9CGTsKGl0T/IaF9yYIDQdNwg9A8gcDhe5M6ePwpTeiQUNkIJ7iNPWiyv5XM/R
 NKsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVwB9LgvHhQF/bIswXE+3TrSuXGP73sk3l8EADyJh6J/eu1ciddpj+TPG3+HWbHWUCMnFzrLzsF1yS@nongnu.org
X-Gm-Message-State: AOJu0YzWzhSpwG8vI9YWm4XL3MN7+J3OlAFiw120uu0GxNd96uZnz7Lu
 +pCgrdiUGPHDgrIEBKOuXbd5F+0lJ4bZk7rB8OYG6zQPUtE4TZglsHw0EL8+IrKOoa1FNqHRWnS
 ChkOfx46cgxm6WgyMYJ6SKZHrIFnwHoVqL2Q4mqwhs2LUYQah6LXt
X-Gm-Gg: ASbGncuz0X/10i4Ae1j48NTfRhjqt97bBrq9GfThXfuznSABeBhq1v3AS/YrSeRoLqZ
 Puqve2OEQ1eH33scDqv/eEtxN29wq72M0lLkdUp9+yKF0R275FUeWtU6beFj1a26kKLGMjmrX6y
 jHGjzQ2Ztbg+P3syriQzPL2V5RrN0+mWxanbQq0c3GfMXASzcl92edUMgNvb7Cnk7WWgyXRJ3bA
 QVwTjoAIZ4WUVCZGdKtx2To9Q/KAvs0z2JYf0zGA4t8DmNjr+FENkSVinkf9i4x2dGQwt6UtSNW
 mxDTzKzSZdu0O0SM5Q==
X-Received: by 2002:a05:622a:1a86:b0:467:7b76:5957 with SMTP id
 d75a77b69052e-46c7107dcf1mr179269001cf.2.1736522323141; 
 Fri, 10 Jan 2025 07:18:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuhe74kUj9cCoJ0UVwhPcbWa4ai02GLiOz7AQ9uh7UqHcnSTBthfA1rcAj9GuvkK83pEI77g==
X-Received: by 2002:a05:622a:1a86:b0:467:7b76:5957 with SMTP id
 d75a77b69052e-46c7107dcf1mr179268551cf.2.1736522322725; 
 Fri, 10 Jan 2025 07:18:42 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c87321cfcsm10110721cf.14.2025.01.10.07.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 07:18:42 -0800 (PST)
Date: Fri, 10 Jan 2025 10:18:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
Message-ID: <Z4E6TnKaUt8FMWIv@x1n>
References: <20250109-san-v7-0-93c432a73024@daynix.com>
 <20250109-san-v7-1-93c432a73024@daynix.com>
 <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu>
 <Z4AjkXbZeu3T94Y1@x1n> <Z4AldAcucTyqZ0HJ@x1n>
 <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jan 10, 2025 at 05:43:15PM +0900, Akihiko Odaki wrote:
> On 2025/01/10 4:37, Peter Xu wrote:
> > On Thu, Jan 09, 2025 at 02:29:21PM -0500, Peter Xu wrote:
> > > On Thu, Jan 09, 2025 at 01:30:35PM +0100, BALATON Zoltan wrote:
> > > > On Thu, 9 Jan 2025, Akihiko Odaki wrote:
> > > > > Do not refer to "memory region's reference count"
> > > > > -------------------------------------------------
> > > > > 
> > > > > Now MemoryRegions do have their own reference counts, but they will not
> > > > > be used when their owners are not themselves. However, the documentation
> > > > > of memory_region_ref() says it adds "1 to a memory region's reference
> > > > > count", which is confusing. Avoid referring to "memory region's
> > > > > reference count" and just say: "Add a reference to a memory region".
> > > > > Make a similar change to memory_region_unref() too.
> > > > > 
> > > > > Refer to docs/devel/memory.rst for "owner"
> > > > > ------------------------------------------
> > > > > 
> > > > > memory_region_ref() and memory_region_unref() used to have their own
> > > > > descriptions of "owner", but they are somewhat out-of-date and
> > > > > misleading.
> > > > > 
> > > > > In particular, they say "whenever memory regions are accessed outside
> > > > > the BQL, they need to be preserved against hot-unplug", but protecting
> > > > > against hot-unplug is not mandatory if it is known that they will never
> > > > > be hot-unplugged. They also say "MemoryRegions actually do not have
> > > > > their own reference count", but they actually do. They just will not be
> > > > > used unless their owners are not themselves.
> > > > > 
> > > > > Refer to docs/devel/memory.rst as the single source of truth instead of
> > > > > maintaining duplicate descriptions of "owner".
> > > > > 
> > > > > Clarify that owner may be missing
> > > > > 
> > > > > ---------------------------------
> > > > > A memory region may not have an owner, and memory_region_ref() and
> > > > > memory_region_unref() do nothing for such.
> > > > > 
> > > > > memory: Clarify owner must not call memory_region_ref()
> > > > > --------------------------------------------------------
> > > > > 
> > > > > The owner must not call this function as it results in a circular
> > > > > reference.
> > > > > 
> > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > > include/exec/memory.h | 59 ++++++++++++++++++++++++---------------------------
> > > > > 1 file changed, 28 insertions(+), 31 deletions(-)
> > > > > 
> > > > > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > > > > index 9458e2801d50..ca247343f433 100644
> > > > > --- a/include/exec/memory.h
> > > > > +++ b/include/exec/memory.h
> > > > > @@ -1210,7 +1210,7 @@ void memory_region_section_free_copy(MemoryRegionSection *s);
> > > > >   * memory_region_add_subregion() to add subregions.
> > > > >   *
> > > > >   * @mr: the #MemoryRegion to be initialized
> > > > > - * @owner: the object that tracks the region's reference count
> > > > > + * @owner: the object that keeps the region alive
> > > > >   * @name: used for debugging; not visible to the user or ABI
> > > > >   * @size: size of the region; any subregions beyond this size will be clipped
> > > > >   */
> > > > > @@ -1220,29 +1220,26 @@ void memory_region_init(MemoryRegion *mr,
> > > > >                          uint64_t size);
> > > > > 
> > > > > /**
> > > > > - * memory_region_ref: Add 1 to a memory region's reference count
> > > > > + * memory_region_ref: Add a reference to the owner of a memory region
> > > > >   *
> > > > > - * Whenever memory regions are accessed outside the BQL, they need to be
> > > > > - * preserved against hot-unplug.  MemoryRegions actually do not have their
> > > > > - * own reference count; they piggyback on a QOM object, their "owner".
> > > > > - * This function adds a reference to the owner.
> > > > > - *
> > > > > - * All MemoryRegions must have an owner if they can disappear, even if the
> > > > > - * device they belong to operates exclusively under the BQL.  This is because
> > > > > - * the region could be returned at any time by memory_region_find, and this
> > > > > - * is usually under guest control.
> > > > > + * This function adds a reference to the owner of a memory region to keep the
> > > > > + * memory region alive. It does nothing if the owner is not present as a memory
> > > > > + * region without owner will never die.
> > > > > + * For references internal to the owner, use object_ref() instead to avoid a
> > > > > + * circular reference.
> > > > 
> > > > Reading this again I'm still confused by this last sentence. Do you mean
> > > > references internal to the memory region should use object_ref on the memory
> > > > region or that other references to the owner should use object_ref on the
> > > > owner? This sentence is still not clear about that.
> > > 
> > > Having two refcounts are definitely confusing.. especially IIRC all MRs'
> > > obj->free==NULL, so the MR's refcount isn't working.  Dynamic MR's needs
> > > its g_free() on its own.
> 
> We still have instance_finalize that will fire when the MR's refcount gets
> zero so it has its own use cases.
> 
> > > 
> > > I acked both patches, but maybe it could indeed be slightly better we drop
> > > this sentence, meanwhile in patch 2 we can drop the object_ref() too: it
> > > means for parent/child MRs that share the same owner, QEMU does nothing on
> > > the child MRs when add subregion, because it assumes the child MR will
> > > never go away when the parent is there who shares the owner.
> > > 
> > > So maybe we try not to touch MR's refcount manually, but fix what can be
> > > problematic for owner->ref only.
> > 
> > As an attached comment: I may have forgot some context on this issue, but I
> > still remember I used to have a patch that simply detach either parent or
> > child MR links when finalize().  It's here:
> > 
> > https://lore.kernel.org/all/ZsenKpu1czQGYz7m@x1n/
> > 
> > I see this issue was there for a long time so maybe we want to fix it one
> > way or another.  I don't strongly feel which way to go, but personally I
> > still prefer that way (I assume that can fix the same issue), and it
> > doesn't have MR's refcount involved at all, meanwhile I don't see an issue
> > yet with it..
> > 
> 
> For this particular topic I have somewhat a strong opinion that we should
> care the two reference counters.
> 
> Indeed, dealing with two reference counters is not fun, but sometimes it is
> necessary to do reference counting correctly. Your patch is to avoid
> reference counting for tracking dependencies among regions with the same
> owner, and it does so by ignoring the reference from container to subregion.

I don't think so?  When with that patch, container will reference subregion
the same way as others, which is to take a refcount on the owner.  That
kept at least the refcount behavior consistent within memory_region_ref().

That patch removes the circular reference by always properly release the
circular reference due to sub-regioning internally.

> 
> I prefer to keep reference counting correct instead of having an additional
> ad-hoc measure that breaks reference relationships.

Your patch added more complexity to me on refcounting, meanwhile it's also
not always "correct".  It can boil down to how you define "correct" - if
you mean one should always boost a refcount somewhere if it references one
MR, then it's still not 100% correct at least when mr->owner==NULL.  We
never yet did it alright, so to me it's a matter of working around current
sanitizer issue, and that's only about it yet so far.

Meanwhile I _think_ adding such complexity also means MR's finalize() will
be called in specific order when parent/child MRs belong to the same owner.
In my patch the order shouldn't matter, IIUC, which I preferred because
that reduces details that we may not care much (or I could have overlooked
why we need to care about it).  Basically that's simpler to maintain to me,
but again, I don't feel strongly until someone would like / be able to
rework MR refcounting completely.

Thanks,

-- 
Peter Xu


