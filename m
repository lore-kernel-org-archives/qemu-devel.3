Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08577C54E66
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 01:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkZwz-00082U-D0; Wed, 13 Mar 2024 21:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rkZwt-0007zQ-0N
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 21:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rkZwm-0004B5-Iw
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 21:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710379904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fH6T1KvANcBtscpLo1YuLOrMAPbVHPYlszTcE2LwWO0=;
 b=XvvkITVyqHSeJ4mOLku6ALSZ4TjGlG3lA66MDMd9FQ3VKvx9MXwTY3NC3P4owvZH86I/Fi
 MN+Z/fLBW8UuLEZDRr+VOCviXN9h1YGweaVM6Jsf2XAASp5BfChGTidJl6uHkP1tcjpjnB
 BUMPRqShg9XsN+LQCaMcu3BVsxZwPQo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-KQvkGX6KNCyuUk3Axcc3gA-1; Wed, 13 Mar 2024 21:31:41 -0400
X-MC-Unique: KQvkGX6KNCyuUk3Axcc3gA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0B5A101A56C;
 Thu, 14 Mar 2024 01:31:40 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A69441C060A4;
 Thu, 14 Mar 2024 01:31:38 +0000 (UTC)
Date: Wed, 13 Mar 2024 20:31:37 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, hreitz@redhat.com, 
 aliang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH for-9.0] mirror: Don't call job_pause_point() under graph
 lock
Message-ID: <53ojeem7ijpzjlaaqzpknjzrm3n7agbpjjmwfgewfbyrrosqrj@iz52y5m3q6zh>
References: <20240313153000.33121-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313153000.33121-1-kwolf@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Mar 13, 2024 at 04:30:00PM +0100, Kevin Wolf wrote:
> Calling job_pause_point() while holding the graph reader lock
> potentially results in a deadlock: bdrv_graph_wrlock() first drains
> everything, including the mirror job, which pauses it. The job is only
> unpaused at the end of the drain section, which is when the graph writer
> lock has been successfully taken. However, if the job happens to be
> paused at a pause point where it still holds the reader lock, the writer
> lock can't be taken as long as the job is still paused.
> 
> Mark job_pause_point() as GRAPH_UNLOCKED and fix mirror accordingly.
> 
> Cc: qemu-stable@nongnu.org
> Buglink: https://issues.redhat.com/browse/RHEL-28125
> Fixes: 004915a96a7a40e942ac85e6d22518cbcd283506
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/job.h |  2 +-
>  block/mirror.c     | 10 ++++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


