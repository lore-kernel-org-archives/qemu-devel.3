Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB082E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 19:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVyLk-0007Zf-KS; Thu, 09 Jan 2025 14:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVyLd-0007Vu-6Z
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 14:37:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVyLW-0004GR-M7
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 14:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736451452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEIuvOL8YQlOhHgxv3fTWcchjC1tOAEs5RQJWZQ9xjU=;
 b=B02PjsAZvCJ6L/+/UbxyW6PwGjCuDE/HyZTn7zitsUT4vcIh8KqhPUlzHdYa2iRBkJrqba
 WNRON28VuvEYGxPrpBrWoz+cP2VgRTzXZ+JJU1ro0YYMYme0LPgGviqXya7Qqak432kGGZ
 jz5vrKKhpOEpiInnsxmXr4rO+ctp/94=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-rQH270VWOvywL5JEMYPyOg-1; Thu, 09 Jan 2025 14:37:30 -0500
X-MC-Unique: rQH270VWOvywL5JEMYPyOg-1
X-Mimecast-MFC-AGG-ID: rQH270VWOvywL5JEMYPyOg
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7bb8df9222dso251067285a.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 11:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736451450; x=1737056250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEIuvOL8YQlOhHgxv3fTWcchjC1tOAEs5RQJWZQ9xjU=;
 b=L7xhKg97Rw008PbGqDvTPrb0NxaI1kBVNUDl52QfnTee57ud79a3QT2S3/4RAUxLL2
 rZ3JTNb2BWKDnGjXGUH1r6Y5RlvLJQ983Ht2WYNNlm7LFYcTztpFNu+x+Zkl9ldNEszM
 tc8Wv2+DDjIXF/lgyscDAv4+vkBDZC72vXp4hWZ9VYCYDiqQzFI601zVbMH4ms6GG3gT
 AOchvUB1Dla5FA3kxTY9COwAXLBDz6LZ0lN55e1Brw2i4YYP8vaaHGQ0RCV1kqMVJQar
 khVc/d2snVvOCi0dluF27GxCaijhfDuskBdVvISlKvWUSRGdhZeC08XuxhNs7EgDJV/l
 XT6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt/VcuDzqQLjsFFdKdHtkvaJxRwUsCKRX55ugtEVYbWA1raAAoWVOziVszGI6+PqBCvZIaCFzmH/es@nongnu.org
X-Gm-Message-State: AOJu0YyMx8I+BS3nR8DGeJOsgCneVtdsX8sLBdnFdTvsbopfdRTj7N8h
 bIWJimsqQRCN7PAq76UjnifKZ8w1iDRLFtItarPMdpi++Vu0tbFZRdB5mxAwrw/zlU/xVqPV8B5
 JcRY1ecNNkQGVVqK7YNv3zOKBYhSpebtGT9eAbIaOneJHrfTBvFp/
X-Gm-Gg: ASbGncs6ZzM4ALPbrat9LcnnhV+qaJQAcSlyZen1/yo2sRvCQxt1Fi72EFA2Sdbf7E4
 MfOqmnsup3o+u0NtwdyP3kMW2MBNdEPOTvXNANygCx/Qa9uhE8w57tPE8J+qGNtu7yge3+FjGRt
 thYGEUULNrzPkVWjhQMHGM+KDCGuze0eGG8nECiUUqzTiqC0I6AxCzWUCm7tVE0GbZwsSngZZga
 9Gly4sAS2/2opJ6VDOAfEAvZ5NJb+YCgAlUbHhtScjZc8QqXHNoiqCbVOiYPR2W2+OKckxyaPD0
 fJsUJq2hvZ758Sk64A==
X-Received: by 2002:a05:620a:28ca:b0:7b6:d4df:28a7 with SMTP id
 af79cd13be357-7bcd9759e8cmr1147274085a.38.1736451448435; 
 Thu, 09 Jan 2025 11:37:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQxDG4mxTMSHQe9DSMldBjjXh4Ock4774Ac2HEzWDRrF9xykW7ZyG5Noc0Kqt8xlXgawCHQw==
X-Received: by 2002:a05:620a:28ca:b0:7b6:d4df:28a7 with SMTP id
 af79cd13be357-7bcd9759e8cmr1147269785a.38.1736451448027; 
 Thu, 09 Jan 2025 11:37:28 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3503178sm98211185a.90.2025.01.09.11.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 11:37:27 -0800 (PST)
Date: Thu, 9 Jan 2025 14:37:24 -0500
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>,
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
Message-ID: <Z4AldAcucTyqZ0HJ@x1n>
References: <20250109-san-v7-0-93c432a73024@daynix.com>
 <20250109-san-v7-1-93c432a73024@daynix.com>
 <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu>
 <Z4AjkXbZeu3T94Y1@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4AjkXbZeu3T94Y1@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jan 09, 2025 at 02:29:21PM -0500, Peter Xu wrote:
> On Thu, Jan 09, 2025 at 01:30:35PM +0100, BALATON Zoltan wrote:
> > On Thu, 9 Jan 2025, Akihiko Odaki wrote:
> > > Do not refer to "memory region's reference count"
> > > -------------------------------------------------
> > > 
> > > Now MemoryRegions do have their own reference counts, but they will not
> > > be used when their owners are not themselves. However, the documentation
> > > of memory_region_ref() says it adds "1 to a memory region's reference
> > > count", which is confusing. Avoid referring to "memory region's
> > > reference count" and just say: "Add a reference to a memory region".
> > > Make a similar change to memory_region_unref() too.
> > > 
> > > Refer to docs/devel/memory.rst for "owner"
> > > ------------------------------------------
> > > 
> > > memory_region_ref() and memory_region_unref() used to have their own
> > > descriptions of "owner", but they are somewhat out-of-date and
> > > misleading.
> > > 
> > > In particular, they say "whenever memory regions are accessed outside
> > > the BQL, they need to be preserved against hot-unplug", but protecting
> > > against hot-unplug is not mandatory if it is known that they will never
> > > be hot-unplugged. They also say "MemoryRegions actually do not have
> > > their own reference count", but they actually do. They just will not be
> > > used unless their owners are not themselves.
> > > 
> > > Refer to docs/devel/memory.rst as the single source of truth instead of
> > > maintaining duplicate descriptions of "owner".
> > > 
> > > Clarify that owner may be missing
> > > 
> > > ---------------------------------
> > > A memory region may not have an owner, and memory_region_ref() and
> > > memory_region_unref() do nothing for such.
> > > 
> > > memory: Clarify owner must not call memory_region_ref()
> > > --------------------------------------------------------
> > > 
> > > The owner must not call this function as it results in a circular
> > > reference.
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > ---
> > > include/exec/memory.h | 59 ++++++++++++++++++++++++---------------------------
> > > 1 file changed, 28 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > > index 9458e2801d50..ca247343f433 100644
> > > --- a/include/exec/memory.h
> > > +++ b/include/exec/memory.h
> > > @@ -1210,7 +1210,7 @@ void memory_region_section_free_copy(MemoryRegionSection *s);
> > >  * memory_region_add_subregion() to add subregions.
> > >  *
> > >  * @mr: the #MemoryRegion to be initialized
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that keeps the region alive
> > >  * @name: used for debugging; not visible to the user or ABI
> > >  * @size: size of the region; any subregions beyond this size will be clipped
> > >  */
> > > @@ -1220,29 +1220,26 @@ void memory_region_init(MemoryRegion *mr,
> > >                         uint64_t size);
> > > 
> > > /**
> > > - * memory_region_ref: Add 1 to a memory region's reference count
> > > + * memory_region_ref: Add a reference to the owner of a memory region
> > >  *
> > > - * Whenever memory regions are accessed outside the BQL, they need to be
> > > - * preserved against hot-unplug.  MemoryRegions actually do not have their
> > > - * own reference count; they piggyback on a QOM object, their "owner".
> > > - * This function adds a reference to the owner.
> > > - *
> > > - * All MemoryRegions must have an owner if they can disappear, even if the
> > > - * device they belong to operates exclusively under the BQL.  This is because
> > > - * the region could be returned at any time by memory_region_find, and this
> > > - * is usually under guest control.
> > > + * This function adds a reference to the owner of a memory region to keep the
> > > + * memory region alive. It does nothing if the owner is not present as a memory
> > > + * region without owner will never die.
> > > + * For references internal to the owner, use object_ref() instead to avoid a
> > > + * circular reference.
> > 
> > Reading this again I'm still confused by this last sentence. Do you mean
> > references internal to the memory region should use object_ref on the memory
> > region or that other references to the owner should use object_ref on the
> > owner? This sentence is still not clear about that.
> 
> Having two refcounts are definitely confusing.. especially IIRC all MRs'
> obj->free==NULL, so the MR's refcount isn't working.  Dynamic MR's needs
> its g_free() on its own.
> 
> I acked both patches, but maybe it could indeed be slightly better we drop
> this sentence, meanwhile in patch 2 we can drop the object_ref() too: it
> means for parent/child MRs that share the same owner, QEMU does nothing on
> the child MRs when add subregion, because it assumes the child MR will
> never go away when the parent is there who shares the owner.
> 
> So maybe we try not to touch MR's refcount manually, but fix what can be
> problematic for owner->ref only.

As an attached comment: I may have forgot some context on this issue, but I
still remember I used to have a patch that simply detach either parent or
child MR links when finalize().  It's here:

https://lore.kernel.org/all/ZsenKpu1czQGYz7m@x1n/

I see this issue was there for a long time so maybe we want to fix it one
way or another.  I don't strongly feel which way to go, but personally I
still prefer that way (I assume that can fix the same issue), and it
doesn't have MR's refcount involved at all, meanwhile I don't see an issue
yet with it..

-- 
Peter Xu


