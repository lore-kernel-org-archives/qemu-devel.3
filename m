Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECFFC3DA6D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 10:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGy22-0003Py-Ht; Mon, 19 May 2025 06:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uGy1y-0003NI-84
 for qemu-devel@nongnu.org; Mon, 19 May 2025 06:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uGy1w-000197-AO
 for qemu-devel@nongnu.org; Mon, 19 May 2025 06:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747651655;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLSDWQVMV2yLj83AeBU9LftRqyrlSYdRQyf+lUuQY9k=;
 b=LKfjdFEtajw2Y1agkr90aTpxHO8imqd7kqH3H8Rc4PfoDhHuJTxGkFZbRlN7NHlq16ZqE4
 OEeGSNedD+/K/ADwYlp9JQ+ckcUeLGPVXqOmaWUADLcgFU/1ucZ9lGUdpetYmiWlteKrRb
 1KWgVnYtyFlG0TauWgrRqBoypz1RjVw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-sYLyS9cuPM-I7DZEyf3LsQ-1; Mon,
 19 May 2025 06:47:29 -0400
X-MC-Unique: sYLyS9cuPM-I7DZEyf3LsQ-1
X-Mimecast-MFC-AGG-ID: sYLyS9cuPM-I7DZEyf3LsQ_1747651647
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 373971800877; Mon, 19 May 2025 10:47:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97CA719560AA; Mon, 19 May 2025 10:47:24 +0000 (UTC)
Date: Mon, 19 May 2025 11:47:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Jones <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v4 3/3] nbd: Set unix socket send buffer on Linux
Message-ID: <aCsMOXt80pi_DSel@redhat.com>
References: <20250517201154.88456-1-nirsof@gmail.com>
 <20250517201154.88456-4-nirsof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250517201154.88456-4-nirsof@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, May 17, 2025 at 11:11:54PM +0300, Nir Soffer wrote:
> Like macOS we have similar issue on Linux. For TCP socket the send
> buffer size is 2626560 bytes (~2.5 MiB) and we get good performance.
> However for unix socket the default and maximum buffer size is 212992
> bytes (208 KiB) and we see poor performance when using one NBD
> connection, up to 4 times slower than macOS on the same machine.
> 
> Tracing shows that for every 2 MiB payload (qemu uses 2 MiB io size), we
> do 1 recvmsg call with TCP socket, and 10 recvmsg calls with unix
> socket.
> 
> Fixing this issue requires changing the maximum send buffer size (the
> receive buffer size is ignored). This can be done using:
> 
>     $ cat /etc/sysctl.d/net-mem-max.conf
>     net.core.wmem_max = 2097152
> 
>     $ sudo sysctl -p /etc/sysctl.d/net-mem-max.conf
> 
> With this we can set the socket buffer size to 2 MiB. With the defaults
> the value requested by qemu is clipped to the maximum size and has no
> effect.
> 
> I tested on 2 machines:
> - Fedora 42 VM on MacBook Pro M2 Max
> - Dell PowerEdge R640 (Intel(R) Xeon(R) Gold 6230 CPU @ 2.10GHz)
> 
> On the older Dell machine we see very little improvement, up to 1.03
> higher throughput. On the M2 machine we see up to 2.67 times higher
> throughput. The following results are from the M2 machine.
> 
> Reading from qemu-nbd with qemu-img convert. In this test buffer size of
> 4m is optimal (2.28 times faster).
> 
> | buffer size | time    | user    | system  |
> |-------------|---------|---------|---------|
> |     default |   4.292 |   0.243 |   1.604 |
> |      524288 |   2.167 |   0.058 |   1.288 |
> |     1048576 |   2.041 |   0.060 |   1.238 |
> |     2097152 |   1.884 |   0.060 |   1.191 |
> |     4194304 |   1.881 |   0.054 |   1.196 |
> 
> Writing to qemu-nbd with qemu-img convert. In this test buffer size of
> 1m is optimal (2.67 times faster).
> 
> | buffer size | time    | user    | system  |
> |-------------|---------|---------|---------|
> |     default |   3.113 |   0.334 |   1.094 |
> |      524288 |   1.173 |   0.179 |   0.654 |
> |     1048576 |   1.164 |   0.164 |   0.670 |
> |     2097152 |   1.227 |   0.197 |   0.663 |
> |     4194304 |   1.227 |   0.198 |   0.666 |
> 
> Computing a blkhash with nbdcopy. In this test buffer size of 512k is
> optimal (1.19 times faster).
> 
> | buffer size | time    | user    | system  |
> |-------------|---------|---------|---------|
> |     default |   2.140 |   4.483 |   2.681 |
> |      524288 |   1.794 |   4.467 |   2.572 |
> |     1048576 |   1.807 |   4.447 |   2.644 |
> |     2097152 |   1.822 |   4.461 |   2.698 |
> |     4194304 |   1.827 |   4.465 |   2.700 |
> 
> Computing a blkhash with blksum. In this test buffer size of 4m is
> optimal (2.65 times faster).
> 
> | buffer size | time    | user    | system  |
> |-------------|---------|---------|---------|
> |     default |   3.582 |   4.595 |   2.392 |
> |      524288 |   1.499 |   4.384 |   1.482 |
> |     1048576 |   1.377 |   4.381 |   1.345 |
> |     2097152 |   1.388 |   4.389 |   1.354 |
> |     4194304 |   1.352 |   4.395 |   1.302 |
> 
> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> ---
>  nbd/common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


