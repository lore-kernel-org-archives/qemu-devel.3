Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B670C9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 05:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBmdl-0001Vn-Hl; Wed, 30 Sep 2026 01:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBmdk-0001Vd-4s
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 01:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBmdi-0005zr-9E
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 01:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790745236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O5BjoZ6/godBeTMa09s67ekRBYqqIQyjumOndzJr+tI=;
 b=ayvciFtUjlc7NJRh16AfTc3FrsQVKbSC9ZFUP0rrMMAA7v5zf8NeH3wi6t9XlFoQo6mOWd
 /8DxHAQt9Vo/XpUu/SZYgU0eJDiPHGbuImwTpQsSQm8bNQqULM+RwLaZbIPTvbzpEbfeUW
 CagVTgQComP48x49/3rmZ3v1u6QxG0s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-eYHtrYntO8Wi-We_tpUQQw-1; Wed,
 30 Sep 2026 01:13:53 -0400
X-MC-Unique: eYHtrYntO8Wi-We_tpUQQw-1
X-Mimecast-MFC-AGG-ID: eYHtrYntO8Wi-We_tpUQQw_1790745231
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60A121800A7F; Wed, 30 Sep 2026 05:13:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CD1F19560AB; Wed, 30 Sep 2026 05:13:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0839821E6A04; Wed, 30 Sep 2026 07:13:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <pbonzini@redhat.com>,
 <pankaj.gupta@amd.com>,  <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>,  <david@kernel.org>,
 <berrange@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH v7 10/12] hostmem: Support fully shared guest memfd to
 back a VM
In-Reply-To: <20260929235109.1398509-11-michael.roth@amd.com> (Michael Roth's
 message of "Tue, 29 Sep 2026 18:50:16 -0500")
References: <20260929235109.1398509-1-michael.roth@amd.com>
 <20260929235109.1398509-11-michael.roth@amd.com>
Date: Wed, 30 Sep 2026 07:13:48 +0200
Message-ID: <87qzibtj77.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Michael Roth <michael.roth@amd.com> writes:

> From: Peter Xu <peterx@redhat.com>
>
> Host backends supports guest-memfd now by detecting whether it's a
> confidential VM.  There's no way to choose it yet from the memory level to
> use it fully shared.  If we use guest-memfd, it so far always implies we
> need two layers of memory backends, while the guest-memfd only provides the
> private set of pages.
>
> This patch introduces a way so that QEMU can consume guest memfd as the
> only source of memory to back the object (aka, fully shared).
>
> To use the fully shared guest-memfd, one can add a memfd object with:
>
>   -object memory-backend-memfd,x-guest-memfd=on,share=on
>
> Note that share=on is required with fully shared guest_memfd.
>
> Since guest-memfd is not yet a drop-in replacement for memfd (e.g. lack
> of hugepage support), the option is tagged as experimental for now so
> that it can be made available for early enablement/testing without
> causing any surprises for other users.
>
> PS: there's a trivial touch-up on fd<0 check, because the stub to create
> guest-memfd may return negative but not -1.
>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> [mdr: add accompanying guest-memfd doc, mark as experimental]
> Co-developed-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


