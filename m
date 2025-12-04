Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E60AD1D893
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 08:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR4P9-0002eI-CH; Thu, 04 Dec 2025 03:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vR4Oz-0002dX-04
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:09:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vR4Ox-0001QD-B3
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764835760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIsDAdxlIFW2gKqkUMRnW0ZBuC2UzuSj2oJytvSOukE=;
 b=FJpLcf2C/w4ymA4/Z2c95nMM6K3fFprymbtKLwIgMYwCLn/D+jmbVqZVR2Jem/ebuuiiEw
 KUxW8SXYl8sinp6lUI//gX4DwvU39Hu+3zgTvMDPEEdJJ3d6S3m1QCQTCTyd5kfZ8LfsQK
 lckxqiW7hyMX9DZ6OyWcJ+rtscLKGwg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-bGS90BlfM72WsmxNpfP-_w-1; Thu,
 04 Dec 2025 03:09:17 -0500
X-MC-Unique: bGS90BlfM72WsmxNpfP-_w-1
X-Mimecast-MFC-AGG-ID: bGS90BlfM72WsmxNpfP-_w_1764835755
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD46B180034C; Thu,  4 Dec 2025 08:09:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 711CE300F965; Thu,  4 Dec 2025 08:09:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B2CF721E6A27; Thu, 04 Dec 2025 09:09:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Ben Chaney <bchaney@akamai.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  "Michael S. Tsirkin" <mst@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Alex
 Williamson <alex@shazbot.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Stefan Weil <sw@weilnetz.de>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Hamza Khan <hamza.khan@nutanix.com>,  Mark Kanda <mark.kanda@oracle.com>,
 Joshua Hunt <johunt@akamai.com>,  Max Tottenham <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v3 6/8] tap: cpr support
In-Reply-To: <20251203-cpr-tap-v3-6-3c12e0a61f8e@akamai.com> (Ben Chaney's
 message of "Wed, 03 Dec 2025 13:51:23 -0500")
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
 <20251203-cpr-tap-v3-6-3c12e0a61f8e@akamai.com>
Date: Thu, 04 Dec 2025 09:09:10 +0100
Message-ID: <874iq6mzx5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Ben Chaney <bchaney@akamai.com> writes:

> From: Steve Sistare <steven.sistare@oracle.com>
>
> Provide the cpr=on option to preserve TAP and vhost descriptors during
> cpr-transfer, so the management layer does not need to create a new
> device for the target.
>
> Save all tap fd's in canonical order, leveraging the index argument of
> cpr_save_fd.  For the i'th queue, the tap device fd is saved at index 2*i,
> and the vhostfd (if any) at index 2*i+1.
>
> tap and vhost fd's are passed by name to the monitor when a NIC is hot
> plugged, but the name is not known to qemu after cpr.  Allow the manager
> to pass -1 for the fd "name" in the new qemu args to indicate that QEMU
> should search for a saved value.  Example:
>
>   -netdev tap,id=hostnet2,fds=-1:-1,vhostfds=-1:-1,cpr=on

Hmm.  See below.

>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Ben Chaney <bchaney@akamai.com>

[...]

> diff --git a/qapi/net.json b/qapi/net.json
> index 118bd34965..264213b5d9 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -355,6 +355,8 @@
   ##
   # @NetdevTapOptions:
   #
   # Used to configure a host TAP network interface backend.
   #
   # @ifname: interface name
   #
   # @fd: file descriptor of an already opened tap
   #
   # @fds: multiple file descriptors of already opened multiqueue capable
   #     tap

Not this patch's fault: the interface is misguided, and its
documentation inadequate.

@fds is a string of file descriptor names or numbers separated by ':'.
Not documented.  I found out by reading the code.

This violates QAPI design principle "no string parsing".  It should be
an array of strings.

Aside: get_fds() should use g_strsplit().

Your patch extends the syntax to "file descriptor names or numbers or
"-1" separated by ":".  This is problematic.

Before the patch, a file descriptor name or number is interpreted as a
file descriptor number if it starts with a digit.  "-1" doesn't, so it's
interpreted as a file descriptor name.  Yes, "-1" works as file
descriptor name.  I just verified that

    {"execute": "getfd", "arguments": {"fdname": "-1"}}

works by changing 'fdname': 'fdname' to 'fdname': '-1' in
tests/qtest/libqtest.c, and running tests/qtest/dbus-display-test with
QTEST_LOG=/dev/stdout.  The test passes using file descriptor name "-1".

Aside: not restricting the syntax of identifiers to something sensible
like "begin with a letter, and contain only ASCII letters, digits, and
hyphen" is a mistake we've make again and again.

Your patch changes the interpretation of "-1" from "file descriptor
name" to "saved file descriptor".

If it does so regardless of the value of @cpr, then this is an
incompatible change.

We normally require such changes to go through the deprecation process.
We waive that when we're *confident* not doing so will not inconvenience
any users.  Are we here?

If it does so only when @cpr is true, the semantics of "-1" depends on
@cpr.  Yuck!

We can accept "yuck!" when the alternatives are no better.  Have we
considered any?

Regardless, we clearly need to document syntax and semantics of @fds.
Please fix the doc string before this patch, then have this patch update
it.

   #
   # @script: script to initialize the interface
   #
   # @downscript: script to shut down the interface
   #
   # @br: bridge name (since 2.8)
   #
   # @helper: command to execute to configure bridge
   #
   # @sndbuf: send buffer limit.  Understands [TGMKkb] suffixes.
   #
   # @vnet_hdr: enable the IFF_VNET_HDR flag on the tap interface
   #
   # @vhost: enable vhost-net network accelerator
   #
   # @vhostfd: file descriptor of an already opened vhost net device
   #
   # @vhostfds: file descriptors of multiple already opened vhost net
   #     devices

Likewise.

   #
   # @vhostforce: vhost on for non-MSIX virtio guests
   #
   # @queues: number of queues to be created for multiqueue capable tap
   #
>  # @poll-us: maximum number of microseconds that could be spent on busy
>  #     polling for tap (since 2.7)
>  #
> +# @cpr: preserve fds and vhostfds during cpr-transfer.

The commit message explains things in a lot more detail.  Users may not
need to know all that detail.  But this feels too terse.

Please don't abbreviate "file descriptors" to "fds" in documentation
prose.

> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'NetdevTapOptions',
> @@ -373,7 +375,8 @@
     'data': {
       '*ifname':     'str',
       '*fd':         'str',
       '*fds':        'str',
       '*script':     'str',
       '*downscript': 'str',
       '*br':         'str',
       '*helper':     'str',
       '*sndbuf':     'size',
       '*vnet_hdr':   'bool',
       '*vhost':      'bool',
       '*vhostfd':    'str',
>      '*vhostfds':   'str',
>      '*vhostforce': 'bool',
>      '*queues':     'uint32',
> -    '*poll-us':    'uint32'} }
> +    '*poll-us':    'uint32',
> +    '*cpr':        'bool'} }
>  
>  ##
>  # @NetdevSocketOptions:


