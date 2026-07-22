Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8246C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmSbP-0001O7-Vt; Wed, 22 Jul 2026 04:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmSbO-0001Lo-44
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 04:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmSbM-0000Qr-Hj
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 04:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784710011;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMK+CrTjBl5ZM+vkKftpTac5Yt965jBDHDr5TPfX1yc=;
 b=GIna0VU6ii29Yf/TOE8GtME9oxwNSHyvZk+l3U2V+uqup/45ZEoqmMcTqx0JrE7UOQbYYL
 TlO1ai6iMiR5eUhh5dY+LdHLxwFW+az5miY6r0EXtSUJwUCjBfTKmGJWd+3W2Jro7TH6/z
 Qw6xfrqdqv/AdipzvGqNj4Bm5QbVrYs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-c95RLVajPFeLw6RDvqfN2A-1; Wed,
 22 Jul 2026 04:46:48 -0400
X-MC-Unique: c95RLVajPFeLw6RDvqfN2A-1
X-Mimecast-MFC-AGG-ID: c95RLVajPFeLw6RDvqfN2A_1784710007
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98CC31800747; Wed, 22 Jul 2026 08:46:47 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.82])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F68E1800902; Wed, 22 Jul 2026 08:46:45 +0000 (UTC)
Date: Wed, 22 Jul 2026 09:46:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 2/3] iotests: skip FUSE tests when FUSE is not usable
Message-ID: <amCDcaKeymbVGZAO@redhat.com>
References: <20260715103451.1930909-1-den@openvz.org>
 <20260715103451.1930909-3-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715103451.1930909-3-den@openvz.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 15, 2026 at 12:34:50PM +0200, Denis V. Lunev wrote:
> file-io-error, fuse-allow-other and fuse-mmap-shared skip only when
> FUSE is not compiled in. When FUSE is built in but unusable at run
> time (no /dev/fuse access, fusermount lacking permissions), the
> export fails to mount with "Failed to mount FUSE session to export"
> and the tests report a spurious failure instead of skipping, like
> NBD tests already do for missing NBD support.
> 
> Add _notrun_on_fuse_error() to common.rc and use it in the shell
> tests. fuse-mmap-shared is Python, so it gets an equivalent inline
> check.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>  tests/qemu-iotests/common.rc              | 14 ++++++++++++++
>  tests/qemu-iotests/tests/file-io-error    |  4 +---
>  tests/qemu-iotests/tests/fuse-allow-other |  2 ++
>  tests/qemu-iotests/tests/fuse-mmap-shared |  9 ++++++---
>  4 files changed, 23 insertions(+), 6 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


