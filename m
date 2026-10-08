Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E320ECA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEqtq-0006MN-Fv; Thu, 08 Oct 2026 12:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEqto-0006Lf-N3
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 12:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEqtn-0005rv-6h
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 12:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791476594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6oi8WXJggmXJAk2vu5Kv85Xp6eb3FTsoOrPKjLrMAyk=;
 b=Mo2B3RLxZ69wXdSq8z1OQRuQPZJdnaEVgackLP2LHFnilxpSCeh1JckMi37I4UaQvucmA3
 WwRo2EJstndtP5E6YuRWcY5+9g4msfzYYgmdTEHo420vK3idWSJ7H9iB9OAtokjd9bbp9m
 l7kYpaonHFKAPbT3RP8rLfNXoLDqaSw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-oKKkA4C0PeK46Fp9zL5uEQ-1; Thu,
 8 Oct 2026 16:23:11 +0000
X-MC-Unique: oKKkA4C0PeK46Fp9zL5uEQ-1
X-Mimecast-MFC-AGG-ID: oKKkA4C0PeK46Fp9zL5uEQ_1791476590
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09ACA195606E; Thu,  8 Oct 2026 16:23:10 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED82F30001BB; Thu,  8 Oct 2026 16:23:07 +0000 (UTC)
Date: Thu, 8 Oct 2026 11:23:04 -0500
From: Eric Blake <eblake@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v4 4/5] iotests/108: skip if fuse is unusable
Message-ID: <asbEypwIt_7BrynM@redhat.com>
References: <20260925194409.716498-1-farman@linux.ibm.com>
 <20260925194409.716498-5-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925194409.716498-5-farman@linux.ibm.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Sep 25, 2026 at 09:44:08PM +0200, Eric Farman wrote:
> It is possible that the ability to fusermount is restricted
> to privileged users. Rather than waiting for this test to
> perform a mount and subsequently fail, perform a dummy mount
> early on and skip the tests if fuse is not usable.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  tests/qemu-iotests/108 | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
> index bf808b35125..fc3f7322678 100755
> --- a/tests/qemu-iotests/108
> +++ b/tests/qemu-iotests/108
> @@ -73,6 +73,26 @@ else
>          _notrun 'Passwordless sudo for losetup or FUSE support required, but' \
>                  'neither is available'
>      fi
> +
> +    # Test to see if fuse is usable or not (permissions, etc.)
> +    export_mp="$TEST_DIR/fuse-export"
> +    touch "$export_mp"
> +
> +    response=$($QSD \
> +        --blockdev null-co,node-name=export-node \
> +        --export fuse,id=fuse-export,node-name=export-node,mountpoint="$export_mp",allow-other=off \
> +        --daemonize \
> +        --pidfile "$TEST_DIR/qsd.pid" 2>&1)
> +    _notrun_on_fuse_error "$response"
> +
> +    if [ -f "$TEST_DIR/qsd.pid" ]; then
> +        qsd_pid=$(cat "$TEST_DIR/qsd.pid")
> +        kill -KILL "$qsd_pid"
> +        # Wait for process to exit (cannot `wait` because the QSD is daemonized)
> +        while [ -f "$TEST_DIR/qsd.pid" ]; do
> +            true
> +        done

This appears to go into an infinite loop on a machine I tested where
corporate policy software held the fuse mountpoint open long enough
that it caused a race condition in tearing things down.  I'm dropping
this one from my pull request, but 1-3 and 5 remain.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


