Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272D606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JvrIv4CB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWc86-0003Ok-70; Thu, 26 Nov 2026 11:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWc7x-0003Nv-LQ
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 11:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWc7u-0000tT-SJ
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 11:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795709713;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REoTOYV8V0OIaXrdZwSHBpynL0EQSvGyWDNE6vHFt2I=;
 b=JvrIv4CBqnPC+t9hpZEDcx28GooD1YSu+fYfzEqrBA3TYBUdXjarq0lMOzl0Rw7KF2Iyv3
 Y017DyQpI34xFISR1b265O7idzODdxZUi2Ynr4aIuNJEkyjmaZfGQEO3DKkUab419QohaQ
 hhe3XtFt+GyQU1R3gDzB+Iv8JVZkpq0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-AjF3VXRoNzWvcIEOaOvpug-1; Thu,
 26 Nov 2026 16:15:09 +0000
X-MC-Unique: AjF3VXRoNzWvcIEOaOvpug-1
X-Mimecast-MFC-AGG-ID: AjF3VXRoNzWvcIEOaOvpug_1795709708
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAAC61800626; Thu, 26 Nov 2026 16:15:07 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AAB530002D1; Thu, 26 Nov 2026 16:15:06 +0000 (UTC)
Date: Thu, 26 Nov 2026 16:15:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH for-12.0] tests/qtest: Speed up qmp_fd_receive() by doing
 fewer systemcalls
Message-ID: <awhbBycacvXwUVp-@redhat.com>
References: <20261126160743.276957-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126160743.276957-1-thuth@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 05:07:43PM +0100, Thomas Huth wrote:
> qmp_fd_receive() currently reads each byte individually via recv()
> from the socket. For tests that do a lot of traffic via QMP, this
> can be a significant overhead. Unfortunately, we cannot easily use
> a buffer for storing characters here, since we don't know the amount
> of characters in the current QMP reply yet, and thus we might read
> into the next reply already, i.e. the data that is required for the
> next call to qmp_fd_receive() instead. A buffer would be required to
> be stored on the caller side, and implementing this would be a major
> rework in this library and the code using it.
> 
> So this patch follows a slightly different approach instead: Read the
> bytes into a buffer with MSG_PEEK first - this does not remove the
> bytes from the socket queue yet. Then we try to consume as many bytes
> from the buffer as possible until a full response has been recognized
> or the buffer has been fully consumed. At the end, we then can
> finally remove the amount of consumed bytes from the socket queue.
> 
> This improvement especially speeds up the device-introspect-test in
> thorough mode.
> 
> Before the change:
> 
>  $ export QTEST_QEMU_BINARY=./qemu-system-aarch64
>  $ time tests/qtest/device-introspect-test -m thorough >/dev/null
> 
>  real	5m8,861s
>  user	2m37,489s
>  sys	2m33,150s
> 
> With this change included:
> 
>  $ export QTEST_QEMU_BINARY=./qemu-system-aarch64
>  $ time tests/qtest/device-introspect-test -m thorough >/dev/null
> 
>  real	3m21,598s
>  user	2m11,187s
>  sys	1m11,032s
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/libqmp.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


That's a nicer approach than my 5 minute PoC from a few months back
that tried to keep around a buffer statically.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


