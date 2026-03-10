Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84153EB104A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 11:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzv1d-0004B9-7m; Tue, 10 Mar 2026 07:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzv1a-0004A7-Kj
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzv1X-0007kE-Os
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773141193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4sY/YdUr05uhno43aNant5ZZWtzsFXYPprSFTRyh+1M=;
 b=PNCQ2TMHM5dC6Bfr5IwlpLFt7udq6I7B1+RkKAkA/q/O+sV3osYKkTspncBRWWMZBPKW0p
 afYcXrc693mcmfoZXWrWD+gWRYV8SfXq86yh8a1cC/glh5chWNciS5SXVeqojsIOSq8fna
 N4I2Sb6+BcbNBYnF/+ZHcBEL8k0IVX8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-3VohT8J5P5u5IDaRdVzL5w-1; Tue,
 10 Mar 2026 07:13:12 -0400
X-MC-Unique: 3VohT8J5P5u5IDaRdVzL5w-1
X-Mimecast-MFC-AGG-ID: 3VohT8J5P5u5IDaRdVzL5w_1773141191
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD9791800365; Tue, 10 Mar 2026 11:13:10 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 564E419560A6; Tue, 10 Mar 2026 11:13:09 +0000 (UTC)
Date: Tue, 10 Mar 2026 12:13:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v5 00/25] export/fuse: Use coroutines and multi-threading
Message-ID: <aa_8ws_EI0-TgA1D@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 09.03.2026 um 16:08 hat Hanna Czenczek geschrieben:
> Hi,
> 
> This series:
> - Fixes some bugs/minor inconveniences,
> - Removes libfuse from the request processing path,
> - Make the FUSE export use coroutines for request handling,
> 
> More detail on the v1 cover letter:
> https://lists.nongnu.org/archive/html/qemu-block/2025-03/msg00359.html
> 
> v2 cover letter:
> https://lists.nongnu.org/archive/html/qemu-block/2025-06/msg00040.html
> 
> v3 cover letter:
> https://lists.nongnu.org/archive/html/qemu-block/2025-07/msg00005.html
> 
> v4 cover letter:
> https://lists.nongnu.org/archive/html/qemu-block/2026-02/msg00324.html
> 
> 
> v4 fixes the problems Kevin has pointed out on list:
> - Fix fuse-allow-other test by making the export writable,
> - Drop outdated comment,
> - Add comment explaining why bufptr should be explicitly set to NULL in
>   the empty-read branch of fuse_read().
> 
> And the TSA warnings indicated off-list, by making all FUSE handling
> functions (which run in a coroutine) GRAPH_RDLOCK, having
> fuse_co_process_request() take the lock.  For this, we need to drop the
> permission manipulation functions in the I/O path, but that is easy (new
> patch 16).

Thanks, applied to the block branch.

Kevin


