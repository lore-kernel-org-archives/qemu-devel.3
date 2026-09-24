Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E30C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9j4y-0007A0-C2; Thu, 24 Sep 2026 09:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9j4H-00077E-Lm
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9j4E-0002Pm-G2
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790254849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mccdL15MvG8klgJkba1crD0d1cm2gLMlPqEKfYaSRV4=;
 b=hqi3nbk4PwFw6dLRtA/bKyO3YsbVPzlZ1xkmAJfHAsafEaLNGGrwguLq+D6hRcy+KPQrZy
 oza4/XIHfwRZd67WJhyOXG5v9Z2p74npGHUiyLvu4VLydYaPy+4378R+0sU7XKw28OIJqe
 OltFTdgFDxXY5IOPWpO2/xqNiWluW44=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-GZApZNeWNCyeEBjmuh760Q-1; Thu,
 24 Sep 2026 09:00:43 -0400
X-MC-Unique: GZApZNeWNCyeEBjmuh760Q-1
X-Mimecast-MFC-AGG-ID: GZApZNeWNCyeEBjmuh760Q_1790254842
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C10CD1801333; Thu, 24 Sep 2026 13:00:42 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.118])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E630D1956054; Thu, 24 Sep 2026 13:00:40 +0000 (UTC)
Date: Thu, 24 Sep 2026 15:00:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v3 4/4] iotests/108: skip if fuse is unsuable
Message-ID: <arUe9s7ggIpAYiO9@redhat.com>
References: <20260813183740.3503107-1-farman@linux.ibm.com>
 <20260813183740.3503107-5-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813183740.3503107-5-farman@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 13.08.2026 um 20:37 hat Eric Farman geschrieben:
> It is possible that the ability to fusermount is restricted
> to privileged users. Rather than waiting for this test to
> perform a mount and subsequently fail, perform a dummy mount
> early on and skip the tests if fuse is not usable.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

There is a typo in the subject line (s/unsuable/unusable/).

>  tests/qemu-iotests/108 | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
> index bf808b3512..8dc725cf66 100755
> --- a/tests/qemu-iotests/108
> +++ b/tests/qemu-iotests/108
> @@ -73,6 +73,23 @@ else
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
> +        --pidfile "$TEST_DIR/qsd.pid" 2>&1)

If FUSE is available, this hangs because QSD doesn't exit by itself, but
waits for clients to connect.

--daemonize might give you the right semantics (print errors while
setting up the export to stderr, exit after initialising everything)
when combined with your code below to kill QSD.

> +    if [[ $response = *"Failed to mount FUSE session to export"* ]]; then
> +        _notrun 'FUSE support is not usable (permission error?)'
> +    fi

Should this part use _notrun_on_fuse_error()?

Kevin


