Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF53EC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE67y-0000dr-UA; Mon, 03 Jun 2024 07:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE67v-0000ar-Mk
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE67s-0004Ni-56
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717415114;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WEE6E0JR53r1GcyxDwlQycZKgjQWLUOQd9yhzwu976k=;
 b=PxU75O2vxpf5emPXIxzjs+eeA7oXGrEqJlAX+z1KVzb+4DSY1TRL/FnmFzQYBh6qXw2n3a
 NADKcR06uHWP0WEEKWPRWO6MwJXCC5dg7n0twbpNJSOCJYHyggnE5g6V7SRm7hvuZBQ/a+
 T3KG4IoWbsRi4/UfqzjYIOwQXlxHcyQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-T-FCASiUMUmf2wjhIfScnw-1; Mon, 03 Jun 2024 07:45:04 -0400
X-MC-Unique: T-FCASiUMUmf2wjhIfScnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D578785A58C;
 Mon,  3 Jun 2024 11:45:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2353202696B;
 Mon,  3 Jun 2024 11:45:02 +0000 (UTC)
Date: Mon, 3 Jun 2024 12:45:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 2/2] iotests: test NBD+TLS+iothread
Message-ID: <Zl2svHuiX0_t2ctw@redhat.com>
References: <20240531180639.1392905-4-eblake@redhat.com>
 <20240531180639.1392905-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531180639.1392905-6-eblake@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, May 31, 2024 at 01:04:59PM -0500, Eric Blake wrote:
> Prevent regressions when using NBD with TLS in the presence of
> iothreads, adding coverage the fix to qio channels made in the
> previous patch.
> 
> The shell function pick_unused_port() was copied from
> nbdkit.git/tests/functions.sh.in, where it had all authors from Red
> Hat, agreeing to the resulting relicensing from 2-clause BSD to GPLv2.
> 
> CC: qemu-stable@nongnu.org
> CC: "Richard W.M. Jones" <rjones@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/tests/nbd-tls-iothread     | 168 ++++++++++++++++++
>  tests/qemu-iotests/tests/nbd-tls-iothread.out |  54 ++++++
>  2 files changed, 222 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/nbd-tls-iothread
>  create mode 100644 tests/qemu-iotests/tests/nbd-tls-iothread.out



> +# pick_unused_port
> +#
> +# Picks and returns an "unused" port, setting the global variable
> +# $port.
> +#
> +# This is inherently racy, but we need it because qemu does not currently
> +# permit NBD+TLS over a Unix domain socket
> +pick_unused_port ()
> +{
> +    if ! (ss --version) >/dev/null 2>&1; then
> +        _notrun "ss utility required, skipped this test"
> +    fi
> +
> +    # Start at a random port to make it less likely that two parallel
> +    # tests will conflict.
> +    port=$(( 50000 + (RANDOM%15000) ))
> +    while ss -ltn | grep -sqE ":$port\b"; do
> +        ((port++))
> +        if [ $port -eq 65000 ]; then port=50000; fi
> +    done
> +    echo picked unused port
> +}

In retrospect I'd probably have suggested putting this into
common.qemu as its conceptually independant of this test.


That's not a blocker though so

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


