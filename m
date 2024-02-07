Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A890C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 08:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXdVi-0004Q8-1P; Wed, 07 Feb 2024 03:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1rXdVT-0004G8-VI
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:42:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1rXdVS-0001zC-DP
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707295329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kUcLyn/KXvDOwvs0ZF2srembB6ZAc/qXkAyP/Z5vSpI=;
 b=Of3mtrCFv24GTA6PBi71qzfo5xa2C1vb9ffG+hSIXuHDXw8zpGvS9fU7jYs9iCwVPqhH1X
 ALWKgddE4oH/yQb0UuMoOU5OZZIlt8tL5gRWh4/Fe5hke6fHEZSv9x4+Q9/qFT+m6ogUYZ
 9DnoLUP/pyHGvYYUbNxSWjR/5BjzEHo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-avBS_1E1Pg6ebF6sZ5NweQ-1; Wed,
 07 Feb 2024 03:41:02 -0500
X-MC-Unique: avBS_1E1Pg6ebF6sZ5NweQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D96E29AC009;
 Wed,  7 Feb 2024 08:41:02 +0000 (UTC)
Received: from orkuz (unknown [10.43.3.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F58B492BF0;
 Wed,  7 Feb 2024 08:41:01 +0000 (UTC)
Date: Wed, 7 Feb 2024 09:41:01 +0100
From: Jiri Denemark <jdenemar@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Hao Xiang <hao.xiang@bytedance.com>, qemu-devel@nongnu.org, 
 farosas@suse.de
Subject: Re: Re: [PATCH 2/6] migration/multifd: Add zero pages and zero bytes
 counter to migration status interface.
Message-ID: <qhvli57ctzn3cyt2fwppmcauhmlrqoz7ubljxswx7ghroshop2@kmiaukhnvfko>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
 <20240206231908.1792529-3-hao.xiang@bytedance.com>
 <ZcMDVpLilA-PZ3he@x1n> <ZcMI-wPq94x6cO2Z@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcMI-wPq94x6cO2Z@x1n>
User-Agent: NeoMutt/20231221
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jdenemar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 07, 2024 at 12:37:15 +0800, Peter Xu wrote:
> On Wed, Feb 07, 2024 at 12:13:10PM +0800, Peter Xu wrote:
> > On Tue, Feb 06, 2024 at 11:19:04PM +0000, Hao Xiang wrote:
> > > This change extends the MigrationStatus interface to track zero pages
> > > and zero bytes counter.
> > > 
> > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> I'll need to scratch this, sorry..
> 
> The issue is I forgot we have "duplicate" which is exactly "zero
> page"s.. See:
> 
>     info->ram->duplicate = stat64_get(&mig_stats.zero_pages);
> 
> If you think the name too confusing and want a replacement, maybe it's fine
> and maybe we can do that.  Then we can keep this zero page counter
> introduced, reporting the same value as duplicates, then with a follow up
> patch to deprecate "duplicate" parameter.  See an exmaple on how to
> deprecate in 7b24d326348e1672.
> 
> One thing I'm not sure is whether Libvirt will be fine on losing
> "duplicates" after 2+ QEMU major releases.  Copy Jiri for this.  My
> understanding is that Libvirt should be keeping an eye on deprecation list
> and react, but I'd like to double check..

This should not be a big deal as we can internally map either one
(depending on what QEMU supports) to the same libvirt's field. AFAIK
there is a consensus on Cc-ing libvirt-devel on patches that deprecate
QEMU interfaces so that we can update our code in time before the
deprecated interface is dropped.

BTW, libvirt maps "duplicate" to:

/**
 * VIR_DOMAIN_JOB_MEMORY_CONSTANT:
 *
 * virDomainGetJobStats field: number of pages filled with a constant
 * byte (all bytes in a single page are identical) transferred since the
 * beginning of the migration job, as VIR_TYPED_PARAM_ULLONG.
 *
 * The most common example of such pages are zero pages, i.e., pages filled
 * with zero bytes.
 *
 * Since: 1.0.3
 */
# define VIR_DOMAIN_JOB_MEMORY_CONSTANT          "memory_constant"

Jirka


