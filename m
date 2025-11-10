Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0887CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 16:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIUcN-0001J7-8n; Mon, 10 Nov 2025 11:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIUc7-0001CD-18
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:19:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIUc4-0006Wx-PN
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762791568;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHp4tImynCxj+bloGJ03P4xU9+vpwhKO2QtTweutyiI=;
 b=fAVWPzBDirY2A22UYcfxNWUsxyrq97NZVELo+CTDHJa0VLk3erOkQqbvhSCxEvNFpDXTWH
 rvsNpWMJwH6wR5oA/D7JOk2ARiWsXfZVF0ixcNJtbeKwQd11cFJ5Lznkf3Jo6/N/HUtyYw
 Wnvs6x2oN6zmKQEuHFyqJi6RMsesI2I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-QbmGJb0UOfujUYr-BZnBWQ-1; Mon,
 10 Nov 2025 11:19:25 -0500
X-MC-Unique: QbmGJb0UOfujUYr-BZnBWQ-1
X-Mimecast-MFC-AGG-ID: QbmGJb0UOfujUYr-BZnBWQ_1762791564
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 888F719560B3; Mon, 10 Nov 2025 16:19:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C013180087B; Mon, 10 Nov 2025 16:19:22 +0000 (UTC)
Date: Mon, 10 Nov 2025 16:19:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 12/12] iotests: Add coverage of recent NBD qio
 deadlock fix
Message-ID: <aRIQhtavlD8Q6zJa@redhat.com>
References: <20251108230525.3169174-14-eblake@redhat.com>
 <20251108230525.3169174-26-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251108230525.3169174-26-eblake@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Nov 08, 2025 at 04:59:33PM -0600, Eric Blake wrote:
> Test that all images in a qcow2 chain using an NBD backing file can be
> served by the same process.  Prior to the recent QIONetListener fixes,
> this test would demonstrate deadlock.
> 
> The test borrows heavily from the original formula by "John Doe" in
> the gitlab bug, but uses a Unix socket rather than TCP to avoid port
> contention, and uses a full-blown QEMU rather than qemu-storage-daemon
> since both programs were impacted.
> 
> The test starts out with the even simpler task of directly adding an
> NBD client without qcow2 chain ('client'), which also provokes the
> deadlock; but commenting out the 'Adding explicit NBD client' section
> will still show deadlock when reaching the 'Adding wrapper image...'.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3169
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: split out vvfat changes, add an explicit client in addition to the
> implicit one through qcow2
> ---
>  tests/qemu-iotests/tests/nbd-in-qcow2-chain   | 94 +++++++++++++++++++
>  .../qemu-iotests/tests/nbd-in-qcow2-chain.out | 75 +++++++++++++++
>  2 files changed, 169 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/nbd-in-qcow2-chain
>  create mode 100644 tests/qemu-iotests/tests/nbd-in-qcow2-chain.out

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


