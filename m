Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191A5E9A05E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9tL-0005UY-1k; Thu, 19 Feb 2026 14:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vt9st-0005T7-NF
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:40:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vt9sm-0004fY-3O
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771530012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+I0GTYyR9NzqLZxw+F+YDaR+3n5QpSYWV3wkDlQpSA8=;
 b=G5xlNycY2zVTJ1IKTZRxC2SLmoGqLnj5oKWL6S2WuLXgnnVLKiFBUUqVePEFZar3Pnn06v
 rh7BFGG0W9+TjPDy1f1Ad4C0uja1wyL6neAXePekXWL1QLEf2sBfcXBgZM9Dmz8PDX3vVW
 Ry2+vguz16h1n/ivHKaKtFm8rSmqEO4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-DgQRrCQtOzie71neKllU4Q-1; Thu, 19 Feb 2026 14:40:11 -0500
X-MC-Unique: DgQRrCQtOzie71neKllU4Q-1
X-Mimecast-MFC-AGG-ID: DgQRrCQtOzie71neKllU4Q_1771530010
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cb52a9c0eeso1698532785a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771530010; x=1772134810; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+I0GTYyR9NzqLZxw+F+YDaR+3n5QpSYWV3wkDlQpSA8=;
 b=A4XUPE907Dkx4AHgnr+mFFJXfdV+qrSfd+UMGF9wkSiQIWvdrVw1LJKe7ibmSoYHfK
 Zy2u5nS99/Vv1oRcH+T39M3uZ5+1Xo6d2cN86jjIG1rg4BVY1m5YcIvqm6N+8S/YbeXj
 cPMVNOVfjfRIZ8nHBi7j0SxYsdvLenwPIxqx4n1FQkkfCXkxdmuC9U9KawN3gaLsfYzR
 vtYbpg9Qzm915Uh0ZVB5mPAix+u+T7fTYvBZc4KKSEWceBT3prWh3RS5FKnSqiCUX9tI
 xjGGcF9s9YYGLMqTAG5yCsnJM3JtbYYLDCFJHngp5B2DnbhdtoOwEzqcZlOENMm0R/I/
 P+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771530010; x=1772134810;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+I0GTYyR9NzqLZxw+F+YDaR+3n5QpSYWV3wkDlQpSA8=;
 b=qwvCinxk/opoUpsk63eDV+l9R1ACnblXbGw6DILMIEqXRo84JvQ+e5OQUapjwQEOAn
 RbB44S+VlcrSRLPxV0rm5HlJCrYE4t3ShLoj7YeFi0o40vSSrPYpotv81rLlGon+cvUS
 hSyVBMmdxigqQMkNJJFDS2Zs7eazANlGNBrDWKT0+uEkm7fbNd+iym6a83roWhHJH9AL
 z82q+e9FrEvHcincZ6mXJdfYBn7eRWyQfeDGZA+P7PS4F/2NkCe4H0CWGasfAg2Q5MvJ
 M541zIt8H+LR3xWaPc0agEiOdNCS7FapWd96oDiG13uu/dWmbMKR4tCoA9S4w+FhtfCO
 BMuw==
X-Gm-Message-State: AOJu0YwS+IxPNg4GzEIO2mnMG6gINFcnkd6UYzc6JoGHkilQqQXosOon
 Nha2oK5Uzwwvk5rSqKfSTDzC67CbIPKzy8x/Y61N9o6kAusmLOX7uCB/qdSgDocEj5IOMPvm1oK
 J8XZw3gCDtkeVDVprYv3f2wMZqiKHDvrFcz6zmN/1Ye2J8spHKHSH4faO
X-Gm-Gg: AZuq6aLfh+2qFuaoTldjJGC+++gyC41zTcBQGU1C/6poOF3E8AZGBCzsLJbIksUh22/
 VEajw9zzjYxQcfHg+MOm0huLOg+JnJC+N1UNHBYQ/2ec4P8vun522f1NSreYPgGKrp4K9qf84VH
 BbWpv/0LxBPA9bi9j/b+6del4c7Qac83afFBhYs50ZKMkG8DtkjZy3XJIpmx3AHuiE0sY17x8YO
 +zB7OJ2irhpaFrwjg7+VW1KwJeUyQtNtSoFsM5dQAgsO3osNY2GVlG3oYnAufl5D0dCGXo6h0/f
 ZoKyMRCB1wOk3cALozvEQHBYQ7vxXXljXO5TMLrWLqvEoXi3qmgDKztoJ8O65H0SacHn/ActkJ2
 6/i/COpSoyuFShA==
X-Received: by 2002:a05:620a:4d94:b0:8cb:50d6:18c3 with SMTP id
 af79cd13be357-8cb50d61b3dmr1532721685a.1.1771530010534; 
 Thu, 19 Feb 2026 11:40:10 -0800 (PST)
X-Received: by 2002:a05:620a:4d94:b0:8cb:50d6:18c3 with SMTP id
 af79cd13be357-8cb50d61b3dmr1532718185a.1.1771530009994; 
 Thu, 19 Feb 2026 11:40:09 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b0e12eesm2157317685a.15.2026.02.19.11.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 11:40:09 -0800 (PST)
Date: Thu, 19 Feb 2026 14:39:58 -0500
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 kvm@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH 06/10] system/memory: split RamDiscardManager into source
 and manager
Message-ID: <aZdnDrs9ivLctEIj@x1.local>
References: <20260204100708.724800-1-marcandre.lureau@redhat.com>
 <20260204100708.724800-7-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260204100708.724800-7-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Feb 04, 2026 at 02:07:02PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Refactor the RamDiscardManager interface into two distinct components:
> - RamDiscardSource: An interface that state providers (virtio-mem,
>   RamBlockAttributes) implement to provide discard state information
>   (granularity, populated/discarded ranges, replay callbacks).
> - RamDiscardManager: A concrete QOM object that wraps a source, owns
>   the listener list, and handles listener registration/unregistration
>   and notifications.
> 
> This separation moves the listener management logic from individual
> source implementations into the central RamDiscardManager, reducing
> code duplication between virtio-mem and RamBlockAttributes.
> 
> The change prepares for future work where a RamDiscardManager could
> aggregate multiple sources.

The split of sources v.s. manager makes sense to me.

I didn't follow the whole history of how the discard manager evolved, but
IIUC it was called "discard manager" only because initially we were pretty
much focused on the DONTNEED side of things so that when things got dropped
we need to notify.

However IIUC the current status quo of the discard manager covers both
sides (population and discards).  It maintains what ranges of memory is
available in general for consumption by listeners.

For that, I wonder if during this major refactoring we should think about
renaming this slightly misleading name.  Considering that the major
difference of such special MR (either managed by virtio-mem or ramattr) is
about its "sparseness": say, not all of the memory is used but only a
portion of it to be used in a somehow sparsed fashion, maybe
SparseRamSources / SparseRamManager?  Another option I thought about is
DynamicRam*.

No strong feelings on the namings.  But raising this up in case you also
think it might be a good idea.

[...]

> @@ -699,50 +682,60 @@ struct RamDiscardManagerClass {
>       * @replay_discarded:
>       *
>       * Call the #ReplayRamDiscardState callback for all discarded parts within
> -     * the #MemoryRegionSection via the #RamDiscardManager.
> +     * the #MemoryRegionSection via the #RamDiscardSource.
>       *
> -     * @rdm: the #RamDiscardManager
> +     * @rds: the #RamDiscardSource
>       * @section: the #MemoryRegionSection
>       * @replay_fn: the #ReplayRamDiscardState callback
>       * @opaque: pointer to forward to the callback
>       *
>       * Returns 0 on success, or a negative error if any notification failed.
>       */
> -    int (*replay_discarded)(const RamDiscardManager *rdm,
> +    int (*replay_discarded)(const RamDiscardSource *rds,
>                              MemoryRegionSection *section,
>                              ReplayRamDiscardState replay_fn, void *opaque);

A major question I have here is how we should process replay_populated()
and replay_discarded() when split the class.

I had a gut feeling that this should not belong to the *Source object,
instead it might be more suitable for the manager?

I read into some later patches and I fully agree with your definition of
aggregations when there're multiple sources, which mentioned in the commit
messsages later of this part:

    The aggregation uses:
    - Populated: ALL sources populated
    - Discarded: ANY source discarded

IOW, a piece of mem that is "private" in terms of ram attr manager, but
"populated" in terms of virtio-mem, should be treated as discarded indeed.

However I also saw that in some follow up patches the series did a trick to
fetch the first Source then invoke the replay hook on the first source:

int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
                                         const MemoryRegionSection *section,
                                         ReplayRamDiscardState replay_fn,
                                         void *opaque)
{
    RamDiscardSourceEntry *first;
    ReplayCtx ctx;

    first = QLIST_FIRST(&rdm->source_list);
    if (!first) {
        return replay_fn(section, opaque);
    }

    ctx.rdm = rdm;
    ctx.replay_fn = replay_fn;
    ctx.user_opaque = opaque;

    return ram_discard_source_replay_populated(first->rds, section,
                                               aggregated_replay_populated_cb,
                                               &ctx);
}

It seems to me that aggregated_replay_populated_cb() will indeed still do
the proper aggregations, however if we could move the replay functions into
the manager (or do we need it to be a hook at all?  Perhaps it will just be
an API of the manager?), then we don't need this trick of fetching the 1st
source, instead the manager should do the math of "AND all the sources on
reported populated info" then invoke the listener handlers.  Maybe that'll
be cleaner from the high level.

What do you think?

Thanks,

-- 
Peter Xu


