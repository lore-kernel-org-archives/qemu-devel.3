Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CAF606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GM0fjeYs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAzD-0008St-6N; Thu, 19 Nov 2026 17:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xUAzC-0008Rd-5T
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:52:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xUAzA-0005xQ-EU
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795128727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=otv7/WStme270n9jbGrhByx6Tp6158eoLURuMsius1o=;
 b=GM0fjeYsMvhxaPEPLuFKQSqgEdhK4Gc2aWO2Ir/ix9VBj93mAdGly7sxENscChjJAxvxQA
 9fUrqmh4sZEEfg9ZYkRnXur+OMVJU5K/GW9etMpJsNQuNL9q9CRABFgB30nmhqAkDJuGov
 0obi7Q2qQvct5vdMD0Fk4irfD4ISbMI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-Ezrr1z5XNeymC39n6-xIHw-1; Thu,
 19 Nov 2026 22:52:03 +0000
X-MC-Unique: Ezrr1z5XNeymC39n6-xIHw-1
X-Mimecast-MFC-AGG-ID: Ezrr1z5XNeymC39n6-xIHw_1795128722
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0149B18004FD; Thu, 19 Nov 2026 22:52:02 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38E161800550; Thu, 19 Nov 2026 22:51:59 +0000 (UTC)
Date: Thu, 19 Nov 2026 16:51:56 -0600
From: Eric Blake <eblake@redhat.com>
To: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net
Subject: Re: [PATCH 4/5] iotests: Add coverage for NBD resize
Message-ID: <av98gYPX3Wsoiq7N@redhat.com>
References: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
 <20261119144632.232457-5-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119144632.232457-5-guillaume.vincke@ovhcloud.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 19, 2026 at 03:46:31PM +0100, Guillaume Vincke wrote:
> Test the block_resize QMP function on an NBD device. Prior to the
> addition of bdrv_co_refresh_connection(), running block_resize on a
> node that did not process any requests between the device size
> update and the function call failed with "Cannot grow NBD nodes".
> 
> Add a test that updates an NBD node size and verifies that the
> block_resize behaves as expected. The first part configures a reconnect
> delay and asserts that the call succeeds. The second uses the default
> reconnect-delay=0 and asserts that, even though the function returns an
> error, the reconnection routine gets started and that retrying succeeds
> once the node has successfully reconnected.
> 
> Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
> ---
>  tests/qemu-iotests/tests/nbd-resize     | 81 +++++++++++++++++++++++++
>  tests/qemu-iotests/tests/nbd-resize.out | 24 ++++++++
>  2 files changed, 105 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/nbd-resize
>  create mode 100644 tests/qemu-iotests/tests/nbd-resize.out
> 
> diff --git a/tests/qemu-iotests/tests/nbd-resize b/tests/qemu-iotests/tests/nbd-resize
> new file mode 100755
> index 0000000000..4f305eaebf
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/nbd-resize
> @@ -0,0 +1,81 @@
> +#!/usr/bin/env python3
> +# group: quick

Can this also go in the 'auto' group?

> +
> +for reconnect_delay in [10, 0]:
> +    iotests.log(f"=== Resize with reconnect-delay={reconnect_delay} ===")
> +    with iotests.VM() as vm:
> +        vm.launch()
> +
> +        iotests.qemu_img_create('-f', iotests.imgfmt, disk, '1M')
> +        with iotests.qemu_nbd_popen('-k',
> +                                    nbd_sock,
> +                                    '-f',
> +                                    iotests.imgfmt,
> +                                    disk):
> +            vm.cmd('blockdev-add', {
> +                'driver': 'nbd',
> +                'node-name': node_name,
> +                'server': { 'type': 'unix', 'path': nbd_sock },
> +                'reconnect-delay': reconnect_delay,
> +            })
> +
> +            iotests.log('Size before resize:')
> +            iotests.log(node_size(vm))
> +
> +        iotests.qemu_img('resize', '-f', iotests.imgfmt, disk, '2M')
> +        with iotests.qemu_nbd_popen('-k',
> +                                    nbd_sock,
> +                                    '-f',
> +                                    iotests.imgfmt,
> +                                    disk):
> +            iotests.log(vm.qmp('block_resize', {
> +                'node-name': node_name,
> +                'size': 2097152,
> +            }))
> +            iotests.log('Size after resize:')
> +            iotests.log(node_size(vm))

After growing the image from 1M to 2M, is it also worth doing IO to
offsets in the newly-expanded part of the file to prove the resized
region is accessible?

> +            if reconnect_delay == 0:
> +                # With delay=0, block_resize fails while the client reconnects.
> +                # Retry once parked.
> +                iotests.log('Waiting until the reconnection succeeds')
> +                wait_for_parked_connection(vm)
> +
> +                iotests.log(vm.qmp('block_resize', {
> +                    'node-name': node_name,
> +                    'size': 2097152,
> +                }))
> +                iotests.log('Size after retried resize:')
> +                iotests.log(node_size(vm))
> +
> +            vm.shutdown()
> diff --git a/tests/qemu-iotests/tests/nbd-resize.out b/tests/qemu-iotests/tests/nbd-resize.out
> new file mode 100644
> index 0000000000..89eda39740
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/nbd-resize.out
> @@ -0,0 +1,24 @@
> +=== Resize with reconnect-delay=10 ===
> +Start NBD server
> +Size before resize:
> +1048576
> +Kill NBD server
> +Start NBD server
> +{"return": {}}
> +Size after resize:
> +2097152
> +Kill NBD server
> +=== Resize with reconnect-delay=0 ===
> +Start NBD server
> +Size before resize:
> +1048576
> +Kill NBD server
> +Start NBD server
> +{"error": {"class": "GenericError", "desc": "Failed to reconnect NBD node"}}
> +Size after resize:
> +1048576
> +Waiting until the reconnection succeeds
> +{"return": {}}
> +Size after retried resize:
> +2097152
> +Kill NBD server
> -- 
> 2.43.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


