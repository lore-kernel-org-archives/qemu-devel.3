Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F27C60A3806
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aHpcbKBx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM86f-00026v-Ki; Wed, 28 Oct 2026 14:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xM86V-00025t-H9
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xM86T-0001XU-RJ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793211024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ue/x2KZWVZRtcf81vAk/f5OULr7tqpzDHVpimw5Cw50=;
 b=aHpcbKBxhhcIsBfVy191Yolot1GJzsIR5IGhMxWQYnVy2HOAiH4AOmxdGOAY61Tw4/rxTl
 pakF+9XsYJ8xb76HITWAp3EukQ/Y+NpOWA/i5AWvh92m1Ry8a9udTl0ALSy7kkk8nJzL5g
 SN33oHGxx/qt4niafOlxs70By7Lhu8k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-PYZfBHTJNlmxhLNArGG6tA-1; Wed,
 28 Oct 2026 14:10:22 -0400
X-MC-Unique: PYZfBHTJNlmxhLNArGG6tA-1
X-Mimecast-MFC-AGG-ID: PYZfBHTJNlmxhLNArGG6tA_1793211021
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2235E1953997; Wed, 28 Oct 2026 18:10:21 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05EA11956087; Wed, 28 Oct 2026 18:10:18 +0000 (UTC)
Date: Wed, 28 Oct 2026 13:10:16 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, afaria@redhat.com, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] iotests: Add loop-accept-ro-dev test
Message-ID: <auI24QU96wyzXYEN@redhat.com>
References: <20261028171057.139326-1-kwolf@redhat.com>
 <20261028171057.139326-3-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028171057.139326-3-kwolf@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 06:10:57PM +0100, Kevin Wolf wrote:
> Add a test for the accept-read-only-device option of host_device.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/tests/loop-accept-ro-dev   | 87 +++++++++++++++++++
>  .../qemu-iotests/tests/loop-accept-ro-dev.out | 19 ++++
>  2 files changed, 106 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/loop-accept-ro-dev
>  create mode 100644 tests/qemu-iotests/tests/loop-accept-ro-dev.out
> 

> +
> +run_qemu()
> +{
> +    echo -e '{"execute":"qmp_capabilities"}\n{"execute":"quit"}' |

'printf %s' is slightly more portable than 'echo -e'; even though this
script uses /bin/bash, you can use 'shopt -s xpg_echo' to break the
latter. On the other hand, this is copy-paste from other tests, so not
a showstopper.

> +    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp |
> +        _filter_generated_node_ids | _filter_imgfmt |
> +        _filter_actual_image_size | _filter_img_info
> +}
> +
> +if ! sudo -n losetup &>/dev/null; then
> +    _notrun "sudo losetup not available"
> +fi

Huh - we seem to have several outstanding patches related to probing
whether losetup is usable:

https://lists.nongnu.org/archive/html/qemu-devel/2026-10/msg02963.html
https://lists.nongnu.org/archive/html/qemu-devel/2026-10/msg01918.html

Is this a common enough pattern in our qemu-iotests that we should
factor it out?

> +++ b/tests/qemu-iotests/tests/loop-accept-ro-dev.out
> @@ -0,0 +1,19 @@
> +QA output created by loop-accept-ro-dev
> +
> +=== Start QEMU on a loop device after blockdev --setro ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
> +Testing: -blockdev host_device,node-name=disk,filename=/dev/loop1 -device virtio-blk,drive=disk
> +QEMU_PROG: -blockdev host_device,node-name=disk,filename=/dev/loop1: The device is not writable: Permission denied
> +
> +Testing: -blockdev host_device,node-name=disk,filename=/dev/loop1,accept-read-only-device=off -device virtio-blk,drive=disk

/dev/loop1 might already be busy, at which point losetup will pick
/dev/loop2 or similar. This output needs to be filtered.

The rest of the test looks okay.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


