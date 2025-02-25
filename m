Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF0AC021B6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 10:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmrvQ-0004w0-JN; Tue, 25 Feb 2025 05:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tmrvN-0004va-UP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 05:12:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tmrvM-0000g2-AP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 05:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740478341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TdmHorMipX77Tcbocj5bxx7AZmxW96a+zgSklEwLxpk=;
 b=NOe+zuAuJXq/0P9VIsTcjEh8lxneeaW6FjKXmuW694jL0byyWMtVxLWPEDopxmA9iXqmdd
 IlT2qXFqlYU1I/E7F3YToUzyJOKPey4tvB/bO7ivxhLhdPbwnKxz2X4FEbgOi2mddBi9HU
 tZ+rn6KVS0NhiH6SRGnrQapSZGgc1/s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-usBeZIf9Nfaq07xYpQKw2Q-1; Tue,
 25 Feb 2025 05:12:19 -0500
X-MC-Unique: usBeZIf9Nfaq07xYpQKw2Q-1
X-Mimecast-MFC-AGG-ID: usBeZIf9Nfaq07xYpQKw2Q_1740478338
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CFB31800876; Tue, 25 Feb 2025 10:12:18 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.124])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF4BA1955BD4; Tue, 25 Feb 2025 10:12:14 +0000 (UTC)
Date: Tue, 25 Feb 2025 11:12:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: Problem with iotest 233
Message-ID: <Z72XfP8gI9-SB4B9@redhat.com>
References: <5a31e4fb-3e0f-4455-9941-18b00287b276@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a31e4fb-3e0f-4455-9941-18b00287b276@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 25.02.2025 um 08:20 hat Thomas Huth geschrieben:
> 
>  Hi!
> 
> I'm facing a weird hang in iotest 233 on my Fedora 41 laptop. When running
> 
>  ./check -raw 233
> 
> the test simply hangs. Looking at the log, the last message is "== check
> plain client to TLS server fails ==". I added some debug messages, and it
> seems like the previous NBD server is not correctly terminated here.
> The test works fine again if I apply this patch:
> 
> diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nbd
> --- a/tests/qemu-iotests/common.nbd
> +++ b/tests/qemu-iotests/common.nbd
> @@ -35,7 +35,7 @@ nbd_server_stop()
>          read NBD_PID < "$nbd_pid_file"
>          rm -f "$nbd_pid_file"
>          if [ -n "$NBD_PID" ]; then
> -            kill "$NBD_PID"
> +            kill -9 "$NBD_PID"
>          fi
>      fi
>      rm -f "$nbd_unix_socket" "$nbd_stderr_fifo"
> 
> ... but that does not look like the right solution to me. What could prevent
> the qemu-nbd from correctly shutting down when it receives a normal SIGTERM
> signal?

Not sure. In theory, qemu_system_killed() should set state = TERMINATE
and make main_loop_wait() return through the notification, which should
then make it shut down. Maybe you can attach gdb and check what 'state'
is when it hangs and if it's still in the main loop?

I can't reproduce the problem, though I'm on F40. I tried it both on my
working branch and with current git master (b69801dd).

Kevin


