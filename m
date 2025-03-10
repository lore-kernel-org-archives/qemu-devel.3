Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D64C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 11:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trb9h-0002Yf-Pa; Mon, 10 Mar 2025 07:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1trb9f-0002Xr-GT
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1trb9d-000291-Mr
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741605520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2ejXY0uHxwizPlTbC+Cj00POKsRg/Z71NBWJFwSfBY=;
 b=hU/KJkAPj5TWVrF0vyBsjDW5YO80qTdXs/cxMHrhdUhxhLwftRaJc6FuHOhMBqEk+7cq+l
 kL+QsRlmJbD8h3tDMN2gbTQNEBx9PsyxqHrwjdmReXNr2hFjO/tVMQlTqzgLI29XDk2Nsx
 Ox/hYaHOI6EDeYUrb/iGRRJ3/UVRM78=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-BOoqN2R1M3CqwnAWD5gZIQ-1; Mon,
 10 Mar 2025 07:18:34 -0400
X-MC-Unique: BOoqN2R1M3CqwnAWD5gZIQ-1
X-Mimecast-MFC-AGG-ID: BOoqN2R1M3CqwnAWD5gZIQ_1741605513
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C709A19560B4; Mon, 10 Mar 2025 11:18:32 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.222])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B8071800945; Mon, 10 Mar 2025 11:18:30 +0000 (UTC)
Date: Mon, 10 Mar 2025 12:18:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: gerben@altlinux.org, qemu-stable@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] block: Zero block driver state before reopening
Message-ID: <Z87Kg5rYGJtCAl5X@redhat.com>
References: <20250310104858.28221-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310104858.28221-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 10.03.2025 um 11:48 hat Kevin Wolf geschrieben:
> Block drivers assume in their .bdrv_open() implementation that their
> state in bs->opaque has been zeroed; it is initially allocated with
> g_malloc0() in bdrv_open_driver().
> 
> bdrv_snapshot_goto() needs to make sure that it is zeroed again before
> calling drv->bdrv_open() to avoid that block drivers use stale values.
> 
> One symptom of this bug is VMDK running into a double free when the user
> tries to apply an internal snapshot like 'qemu-img snapshot -a test
> test.vmdk'. This should be a graceful error because VMDK doesn't support
> internal snapshots.
> 
> ==25507== Invalid free() / delete / delete[] / realloc()
> ==25507==    at 0x484B347: realloc (vg_replace_malloc.c:1801)
> ==25507==    by 0x54B592A: g_realloc (gmem.c:171)
> ==25507==    by 0x1B221D: vmdk_add_extent (../block/vmdk.c:570)
> ==25507==    by 0x1B1084: vmdk_open_sparse (../block/vmdk.c:1059)
> ==25507==    by 0x1AF3D8: vmdk_open (../block/vmdk.c:1371)
> ==25507==    by 0x1A2AE0: bdrv_snapshot_goto (../block/snapshot.c:299)
> ==25507==    by 0x205C77: img_snapshot (../qemu-img.c:3500)
> ==25507==    by 0x58FA087: (below main) (libc_start_call_main.h:58)
> ==25507==  Address 0x832f3e0 is 0 bytes inside a block of size 272 free'd
> ==25507==    at 0x4846B83: free (vg_replace_malloc.c:989)
> ==25507==    by 0x54AEAC4: g_free (gmem.c:208)
> ==25507==    by 0x1AF629: vmdk_close (../block/vmdk.c:2889)
> ==25507==    by 0x1A2A9C: bdrv_snapshot_goto (../block/snapshot.c:290)
> ==25507==    by 0x205C77: img_snapshot (../qemu-img.c:3500)
> ==25507==    by 0x58FA087: (below main) (libc_start_call_main.h:58)
> 
> This error was discovered by fuzzing qemu-img.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Denis Rastyogin <gerben@altlinux.org>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Forgot these two lines, which I'll add while applying:

Closes: https://gitlab.com/qemu-project/qemu/-/issues/2853
Closes: https://gitlab.com/qemu-project/qemu/-/issues/2851

Kevin


