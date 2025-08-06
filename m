Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8E5C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 20:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujlBt-0000x2-54; Wed, 06 Aug 2025 16:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujlBm-0000re-Rk
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 16:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujlBk-0005Yi-Ls
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 16:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754513803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2nEiXSALWRmjDKFeKZ40mLZfm59Pn30NroLaEKyj8kQ=;
 b=fkazLtAZ9ROOsNSgJ7u3Cki8LQcd3qWK+oBK2kvJvAiQmtPdthL0y4bU1MqrcXd/UbthHB
 ViYB65qF35r5UbOlMn9vsxcYAokGH8NA4eDmdFUD1BzYhgO03DeUw9OPGltRf9ppyecrcS
 vquyrSS7WEPqLC4wTNj9HI3VzbsdLZA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-weuCsk83MZC9JVdekE9asw-1; Wed, 06 Aug 2025 16:56:41 -0400
X-MC-Unique: weuCsk83MZC9JVdekE9asw-1
X-Mimecast-MFC-AGG-ID: weuCsk83MZC9JVdekE9asw_1754513800
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-707453b0307so7850476d6.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 13:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754513800; x=1755118600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2nEiXSALWRmjDKFeKZ40mLZfm59Pn30NroLaEKyj8kQ=;
 b=C6o9cGwTRDg13pHRilz6CdDj1TDpZ2MUPqjyo46yrszXHtdxDloMxpSl+yPo+7Qydr
 eJQtn5NT9QmixOaC0GcJKzON23l26nx27mAKDT/SnznCRZo4t/9U74hm14WjWf/TdL+x
 BDknpCwiLZd6K/BCnLdWgUuyIjeJ2Rbdhl8QYnQsAuDxPFCjhZNXI9XLCzfLgW16xYGG
 +0nBj32KYKpCV+xgYytxsnKnd70SHhEv3u3OvUt4CPbPpEwMJZj7uc83hyw2PUEQrkQP
 0Bk/Xtp6SsglbV1Z3yEuxHyfQlKwtr2+xTo1rRZf3PT7zuIe9WjUfjXObrzCYCug4Qja
 uIpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ/1qlv2ynfCpw6hxR+Fq1TuFdL4jmLYEsucdFS8JK4HxAUfeRw4jFMLXMxw4RptPUEbyyUiuaYnv0@nongnu.org
X-Gm-Message-State: AOJu0YxjEoesfGtSSG3xmshINfViu50hRfryQD5fQSCihX7n9rU8tMEl
 r8wg9lVy9SgKDFuZkZo5jdKSwfiwXc/Fajpu5Lv1GqhShvQVMKQu6le/ALOKxJ6q9Fu+darTYZR
 CV53cv0iOr9QLcPqTaQfktaNp2d9Gt57beEk7SwwQbnTQTmnaocBPogel
X-Gm-Gg: ASbGncsFnp8Jev7t378vgYLhqfRJxqBE0sv1itr0wfVXke4lqgReyCUUL1d9Wh7hTQk
 JI/k3nhIG9dO3gKeTChPwqvdKjjIMkrs66iwNRHIZrkTO4xt6D5o8bhasXJptudj/Vi8B8lMBO6
 AI/YLSapLZiH2M9k43A7doljT+NEMNcaW7AaPkZmLGynR9hCQkV9HldzyrYH5ndbJjxtJTITKFo
 sE3YLTHyN0VdURnmsZKYPsUYupjsNnLFDN5L1auayEUbIbYbwPpGhMjDQzX8GJJj6ATkvhSTMF+
 bs/VOvLWmyy8CfHCkfLAwOEW0JiJwfWH0aBoo1L0Dhx1cOZH8i5oSxLB55uKPhMKB3zJTseTslh
 8DYcw5Lyy1RWMR+1sQ6m+FQ==
X-Received: by 2002:a05:6214:20ee:b0:707:55f:ea2d with SMTP id
 6a1803df08f44-70979661b54mr70997036d6.49.1754513799641; 
 Wed, 06 Aug 2025 13:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs1gtGu8vJphhSWWdWp9dh3hfOfom66EcT9lTtMCHeAcgQMym2BIAxmGGD3DSZrxPSUviaeg==
X-Received: by 2002:a05:6214:20ee:b0:707:55f:ea2d with SMTP id
 6a1803df08f44-70979661b54mr70996786d6.49.1754513799218; 
 Wed, 06 Aug 2025 13:56:39 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077c9d8af4sm90108266d6.8.2025.08.06.13.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 13:56:38 -0700 (PDT)
Date: Wed, 6 Aug 2025 16:56:35 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, pbonzini@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC v2] memory.c: improve refcounting for RAM vs MMIO regions
Message-ID: <aJPBg2WBlfU5Rp21@x1.local>
References: <20250805081123.137064-1-aesteve@redhat.com>
 <aJO3ywz2Ej_kToU_@x1.local>
 <6c254144-a5ee-4536-b0a1-844fb5281b7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c254144-a5ee-4536-b0a1-844fb5281b7d@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 06, 2025 at 10:36:33PM +0200, David Hildenbrand wrote:
> On 06.08.25 22:15, Peter Xu wrote:
> > On Tue, Aug 05, 2025 at 10:11:23AM +0200, Albert Esteve wrote:
> > > v1->v2:
> > > - Added documentation
> > > - Explained the reasoning in the commit message
> > > 
> > > In the last version of the SHMEM MAP/UNMAP [1] Stefan
> > > raised a concern [2] about dynamically creating and
> > > destroying memory regions and their lifecycle [3].
> > > 
> > > After some discussion, David Hildenbrand proposed
> > > to detect RAM regions and handle refcounting differently.
> > > I tried to extend the reasoning in the commit message
> > > below. If I wrote any innacuracies, please keep me
> > > honest. I hope we can gather some feedback with
> > > this RFC patch before sending it for inclusion.
> > 
> > This seems working.  Looks like so far all RAM MRs are fine with it, but
> > I'm not strongly confident it's true or it'll trivially keep true in the
> > future too.
> > 
> > Besides, this still adds some trivial complexity to memory_region_ref() on
> > treating RAM/MMIO MRs differently.
> > > It also sounds like a pure "accident" that the shmem objects to be
> mapped
> > from the vhost-user devices are RAMs.  I wonder what happens if we want to
> > also support dynmaic MMIO regions.
> 
> Is this use case realistic?

Nop. :) It's a sincere wish that if such a feature to be introduced, it
could work for MMIOs too.  Or better if no need to introduce it.

> 
> If there is a reasonable way to prepare for such hypothetical use cases them
> while solving Albert's immediate use case, I'm all for it.
> 
> > 
> > Would this work even without changing QEMU memory core?
> > 
> > For example, have you thought about creating a VhostUserShmemObject for
> > each of the VHOST_USER_BACKEND_SHMEM_MAP request?
> 
> You mean, adding an intermediate object that remains the parent of these
> MemoryRegion?
> 
> Could work. To free a MemoryRegion, I guess we would unparent that
> intermediate object, and that object would then free the memory region --
> unless something still references that intermediate object. Not sure if the
> memory region might keep the intermediate object still alive (no idea).

It should, as long as memory_region_ref() will boost the tempobj's refcount
properly.

Thanks,

> 
> Certainly something to explore, Albert, can you look into that?
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Peter Xu


