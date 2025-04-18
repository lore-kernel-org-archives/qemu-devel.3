Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CF5C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 18:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5qsI-0005eO-3C; Fri, 18 Apr 2025 14:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5qsF-0005e1-Vf
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 14:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5qsD-00032L-5h
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 14:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745002533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ay6qJwb9iZ4PtwxVfNtKAxqMkVunyejBGFMY9Qvf22A=;
 b=YLA5ZPOJTS3L3dt2LojN2CRBq6sdEihYlBf4iY2iHG2PygPnnzc2bmjYs77TVkoTeRsSV2
 enWe84unCEWpgslpzQ7yClft35UHuvnMSOIKvjOkDSJSlZLH8lusMcJqFsJ0M9e5VouPrz
 HIeJba9i8BAildtiLMxfeaoxpxtHy5c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468--0_WL_MWOVuiauWzFHx2ig-1; Fri,
 18 Apr 2025 14:55:30 -0400
X-MC-Unique: -0_WL_MWOVuiauWzFHx2ig-1
X-Mimecast-MFC-AGG-ID: -0_WL_MWOVuiauWzFHx2ig_1745002529
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 112CF1956094; Fri, 18 Apr 2025 18:55:29 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.121])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E16C1800965; Fri, 18 Apr 2025 18:55:27 +0000 (UTC)
Date: Fri, 18 Apr 2025 13:55:24 -0500
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Richard Jones <rjones@redhat.com>
Subject: Re: [PATCH] io: Set unix socket buffers on macOS
Message-ID: <6g5oovn3afxsczxmejpr4bsiwvwkwvh7jntmiydtbxn3wizt7y@6ulr3j3s7h6s>
References: <20250418142436.6121-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418142436.6121-1-nirsof@gmail.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 18, 2025 at 05:24:36PM +0300, Nir Soffer wrote:
> Testing with qemu-nbd shows that computing a hash of an image via
> qemu-nbd is 5-7 times faster with this change.
> 

> +++ b/io/channel-socket.c
> @@ -410,6 +410,19 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
>      }
>  #endif /* WIN32 */
>  
> +#if __APPLE__
> +    /* On macOS we need to tune unix domain socket buffer for best performance.
> +     * Apple recommends sizing the receive buffer at 4 times the size of the
> +     * send buffer.
> +     */
> +    if (cioc->localAddr.ss_family == AF_UNIX) {
> +        const int sndbuf_size = 1024 * 1024;
> +        const int rcvbuf_size = 4 * sndbuf_size;
> +        setsockopt(cioc->fd, SOL_SOCKET, SO_SNDBUF, &sndbuf_size, sizeof(sndbuf_size));
> +        setsockopt(cioc->fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf_size, sizeof(rcvbuf_size));
> +    }
> +#endif /* __APPLE__ */

Why does this have to be limited?  On linux, 'man 7 unix' documents
that SO_SNDBUF is honored (SO_RCVBUF is silently ignored but accepted
for compatibility).  On the other hand, 'man 7 socket' states that it
defaults to the value in /proc/sys/net/core/wmem_default (212992 on my
machine) and cannot exceed the value in /proc/sys/net/core/wmem_max
without CAP_NET_ADMIN privileges (also 212992 on my machine).

Of course, Linux and MacOS are different kernels, so your effort to
set it to 1M may actually be working on Apple rather than being
silently cut back to the enforced maximum.  And the fact that raising
it at all makes a difference merely says that unlike Linux (where the
default appears to already be as large as possible), Apple is set up
to default to a smaller buffer (more fragmentation requires more
time), and bumping to the larger value improves performance.  But can
you use getsockopt() prior to your setsockopt() to see what value
Apple was defaulting to, and then again afterwards to see whether it
actually got as large as you suggested?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


