Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F102AD591A3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5FV-0005Ei-Pr; Mon, 18 Nov 2024 12:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tD5FM-0005Dm-8t
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:09:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tD5FI-00016S-Jc
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731949742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mhlfkqHNgFnvBvTvJRurhkfyCkSNmYtYqezFcT5vvS0=;
 b=aUSViXXeNgjcvBpO4YEhHOP2wfsc39HEb7vAZNd0d7QLzsMLdIItTYlCNYp9EIcAogISk7
 ZKV/PQ5S3CcuuZncZEfRW6Qc7u2oSpFytrBIzNaLxrsP3XK0Qk5oNNJGw5/v7/ol36F/rt
 7grqe99Sly78YFsH5WSIRaj35cQYdFA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-8tfY0km6NMiu1gtBelk-WA-1; Mon,
 18 Nov 2024 12:08:58 -0500
X-MC-Unique: 8tfY0km6NMiu1gtBelk-WA-1
X-Mimecast-MFC-AGG-ID: 8tfY0km6NMiu1gtBelk-WA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4E3C19560BD; Mon, 18 Nov 2024 17:08:57 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A45130001A0; Mon, 18 Nov 2024 17:08:54 +0000 (UTC)
Date: Mon, 18 Nov 2024 11:08:51 -0600
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH] nbd-server: Silence server warnings on port probes
Message-ID: <j7bbrsft54ay6dckd4x7q3nokwrukyy2uspnjafjnd2rj34zey@xrzfihu5qbux>
References: <20241115195638.1132007-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115195638.1132007-2-eblake@redhat.com>
User-Agent: NeoMutt/20241002
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Nov 15, 2024 at 01:55:53PM -0600, Eric Blake wrote:
> While testing the use of qemu-nbd in a Pod of a Kubernetes cluster, I
> got LOTS of log messages of the forms:
> 
> qemu-nbd: option negotiation failed: Failed to read flags: Unexpected end-of-file before all data were read
> qemu-nbd: option negotiation failed: Failed to read flags: Unable to read from socket: Connection reset by peer
> 
> While it is nice to warn about clients that aren't following protocol
> (in case it helps diagnosing bugs in those clients), a mere port probe
> (where the client never write()s any bytes, and where we might even
> hit EPIPE in trying to send our greeting to the client) is NOT
> abnormal, but merely serves to pollute the log.  And Kubernetes
> _really_ likes to do port probes to determine whether a given Pod is
> up and running.
> 
> Easy ways to demonstrate the above port probes:
> $ qemu-nbd -r -f raw path/to/file &
> $ nc localhost 10809 </dev/null
> $ bash -c 'exec </dev/tcp/localhost/10809'
> $ kill $!
> 
> Silence the noise by not capturing errors until after our first
> successful read() from a client.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/server.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)

In testing this as a potential candidate for -rc1, I'm seeing iotests
failures in `./check 094 119 -nbd` both pre- and post-patch.
Bisecting now to see if I can find where those tests started
regressing (looks like a timing change; a "return" line is swapping
place with a SHUTDOWN event line in the QMP output).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


