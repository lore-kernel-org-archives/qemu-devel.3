Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7012FC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 19:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf2S3-000597-K9; Mon, 03 Feb 2025 14:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tf2Rv-00057w-V5
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:49:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tf2Rt-0002S1-EA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738612176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K3I9F2gILUdlsyH1yUI8tSTXcEQlX3NQmEjrH8wRO6A=;
 b=PxZvx4l5Mhqzs3BgnxNVi+h0ZnVXIY0Py1hNBVZOAOeR5ft8MX8R6Fr13SoCpJ4zriyIoO
 whE0yrOY4u6VRqgzPpfC5+EAyaua/9OAFhck1F5rhYe7GvlDg44N+ebQQBIkP+Mi+Nf5Wm
 dlNilpc8YSn+5M4PKTnSow0vDfqb7ts=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-3p6J-6i3PsCU3m4Xcn885Q-1; Mon,
 03 Feb 2025 14:49:33 -0500
X-MC-Unique: 3p6J-6i3PsCU3m4Xcn885Q-1
X-Mimecast-MFC-AGG-ID: 3p6J-6i3PsCU3m4Xcn885Q
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A9E019560B8; Mon,  3 Feb 2025 19:49:32 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.73])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3753B18008D8; Mon,  3 Feb 2025 19:49:28 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:49:25 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 15/15] iotests: Add (NBD-based) tests for inactive nodes
Message-ID: <ifdiezfz5vp54mrpvawgo6dyp24azxajyfyclnidqhfckx3nbd@ol5ql25i7c7w>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250131095051.49708-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131095051.49708-6-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jan 31, 2025 at 10:50:51AM +0100, Kevin Wolf wrote:
> This tests different types of operations on inactive block nodes
> (including graph changes, block jobs and NBD exports) to make sure that
> users manually activating and inactivating nodes doesn't break things.
> 
> Support for inactive nodes in other export types will have to come with
> separate test cases because they have different dependencies like blkio
> or root permissions and we don't want to disable this basic test when
> they are not fulfilled.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py                 |   4 +
>  tests/qemu-iotests/tests/inactive-node-nbd    | 303 ++++++++++++++++++
>  .../qemu-iotests/tests/inactive-node-nbd.out  | 239 ++++++++++++++
>  3 files changed, 546 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/inactive-node-nbd
>  create mode 100644 tests/qemu-iotests/tests/inactive-node-nbd.out
> 

> +    iotests.log('\nMirror from active source to inactive target')
> +
> +    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
> +    iotests.log('snap-fmt active: %s' % node_is_active(vm, 'snap-fmt'))
> +    iotests.log('snap2-fmt active: %s' % node_is_active(vm, 'snap2-fmt'))
> +    iotests.log('target-fmt active: %s' % node_is_active(vm, 'target-fmt'))
> +
> +    # Activating snap2-fmt recursively activates the whole backing chain
> +    vm.qmp_log('blockdev-set-active', node_name='snap2-fmt', active=True)
> +    vm.qmp_log('blockdev-set-active', node_name='target-fmt', active=False)

Here, you have "Activating ... recursively activates"...

> +
> +    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
> +    iotests.log('snap-fmt active: %s' % node_is_active(vm, 'snap-fmt'))
> +    iotests.log('snap2-fmt active: %s' % node_is_active(vm, 'snap2-fmt'))
> +    iotests.log('target-fmt active: %s' % node_is_active(vm, 'target-fmt'))
> +
> +    vm.qmp_log('blockdev-mirror', job_id='job0', device='snap2-fmt',
> +               target='target-fmt', sync='full',
> +               filters=[iotests.filter_qmp_generated_node_ids])
> +
> +    iotests.log('\nBackup from active source to inactive target')
> +
> +    vm.qmp_log('blockdev-backup', job_id='job0', device='snap2-fmt',
> +               target='target-fmt', sync='full',
> +               filters=[iotests.filter_qmp_generated_node_ids])
> +
> +    iotests.log('\nBackup from inactive source to active target')
> +
> +    # Activating snap2-fmt recursively inactivates the whole backing chain
> +    vm.qmp_log('blockdev-set-active', node_name='snap2-fmt', active=False)
> +    vm.qmp_log('blockdev-set-active', node_name='target-fmt', active=True)

...but here, "Activating ... recursively inactivates".  Is one of
these statements wrong?

Overall a nice barrage of tests, and I can see how adding this many
tests caused your v2 to fix some bugs that it discovered in v1.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


