Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0007CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHihH-0000My-Sd; Fri, 16 Oct 2026 10:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xHihC-0000MU-42
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xHihA-0005lz-5s
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792160042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xJuEEWt2sMrjRemjFk2WWfHqZaaP6fHIKw/txvPFo+I=;
 b=DG3tHi2F/DAYEqbfVtuCXkdVJRNcER3tpkGZpXgro9CJISNxrjSN9ekrxZsaS9no00xodI
 TTU7p9Kh0AMlJA/vZqcyQ1dZ0ZZRDLAQmd7QJ18Izh87p/HTDHceGCFYaw5/r+YEthyLSJ
 SCep8VfwGcr0N6CfVqDxrp3Im83Xj+I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-J3jajnK5OEahoA1AL1nV1w-1; Fri,
 16 Oct 2026 14:13:59 +0000
X-MC-Unique: J3jajnK5OEahoA1AL1nV1w-1
X-Mimecast-MFC-AGG-ID: J3jajnK5OEahoA1AL1nV1w_1792160037
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F6DB18005A5; Fri, 16 Oct 2026 14:13:57 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A5DC18004D2; Fri, 16 Oct 2026 14:13:54 +0000 (UTC)
Date: Fri, 16 Oct 2026 09:13:52 -0500
From: Eric Blake <eblake@redhat.com>
To: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 2/2] iotests: Add coverage for NBD connect thread
 start delay
Message-ID: <atIvl0e9VddTigCO@redhat.com>
References: <20261016084136.233836-1-guillaume.vincke@ovhcloud.com>
 <20261016084136.233836-3-guillaume.vincke@ovhcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016084136.233836-3-guillaume.vincke@ovhcloud.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 16, 2026 at 10:41:36AM +0200, Guillaume Vincke wrote:
> Test the connect thread starting condition with reconnect-delay=0 when
> the server disconnects after a successful handshake but before running
> operations. Prior to the change to nbd_co_establish_connection(), this
> test would demonstrate two I/O errors. The tests 264 and 277 covering
> reconnection do not use reconnect-delay=0 so this case is not exercised.
> 
> Add a test that provokes multiple errors in order to put an NBD client
> in the above-mentioned situation and shows that the first operation
> starts the connect thread and leads to successful subsequent I/O.
> 
> Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
> ---
>  tests/qemu-iotests/tests/nbd-stale-connection | 60 +++++++++++++++++++
>  .../tests/nbd-stale-connection.out            | 17 ++++++
>  2 files changed, 77 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/nbd-stale-connection
>  create mode 100644 tests/qemu-iotests/tests/nbd-stale-connection.out

> +
> +# estimated duration required by the connect thread to reach a running server
> +MAX_NBD_CONNECT_DURATION = 1
> +

> +
> +    with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk):
> +        iotests.log('=== NBD server up. Wait for the connect thread to park '
> +                    'the channel ===')
> +        # in CONNECTING, the operation starts the connect thread
> +        log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
> +        # wait for the connect thread to get a new channel and stop
> +        time.sleep(MAX_NBD_CONNECT_DURATION)

Timeout-based tests are always risky for false negatives when the CI
system has more load than the development system.  But comparing this
version of the patch to v1, it looks like you managed to get much more
reliable witness points.  I'll be running this through testing on my
own branch of gitlab several times to see if I can tease out any more
failures, but hopefully it is ready to use. I'll reply again once I've
made a decision on whether to include it in my current pull request or
defer it to my next batch of patches.

> +
> +    iotests.log('=== NBD server down. The parked channel is closed ===')
> +
> +    with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk):
> +        iotests.log('=== NBD server up. Restart the connect thread ===')
> +        # operation will determine that the channel got closed and restart the
> +        # connect thread
> +        log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
> +        # Wait for it to succeed
> +        iotests.log('=== Wait for the connect thread to park the new channel. '
> +                    'Subsequent operations are successful ===')
> +        time.sleep(MAX_NBD_CONNECT_DURATION)
> +        log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
> diff --git a/tests/qemu-iotests/tests/nbd-stale-connection.out b/tests/qemu-iotests/tests/nbd-stale-connection.out
> new file mode 100644
> index 0000000000..065ba329e9
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/nbd-stale-connection.out
> @@ -0,0 +1,17 @@
> +Start NBD server
> +=== NBD Device connected ===
> +{"return": {}}
> +Kill NBD server
> +=== NBD server down. Detect the break and start the connect thread ===
> +{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
> +Start NBD server
> +=== NBD server up. Wait for the connect thread to park the channel ===
> +{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
> +Kill NBD server
> +=== NBD server down. The parked channel is closed ===
> +Start NBD server
> +=== NBD server up. Restart the connect thread ===
> +{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
> +=== Wait for the connect thread to park the new channel. Subsequent operations are successful ===
> +{"return": {}}
> +Kill NBD server
> -- 
> 2.43.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


