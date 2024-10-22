Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E5BD2C547
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 12:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3E6u-0001ed-TB; Tue, 22 Oct 2024 08:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3E6r-0001ci-2q
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3E6n-0000yF-2O
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729600530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFUMJtSNU3lK+M9aff2zgFfm+xVqKXbjxKE1BICSRCs=;
 b=Rsu65IVyPNY1W3S7Rdzb0kCu2ZTumZiXne1mGFlPlugZyWAZjrJlK1unQV/NPGjOManReI
 Mt3NOpnlWD4volVaNdsYgfq/QZQgsbrjnpEGzb7r7cBXyaA0az45CopSXjfC+dkxYh+go0
 O1RR/cvwLy9Ii8pGBOwclHdg42P4KWE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-qTjoDoM2ONqxLiieYrxhDg-1; Tue,
 22 Oct 2024 08:35:26 -0400
X-MC-Unique: qTjoDoM2ONqxLiieYrxhDg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4531619560AB; Tue, 22 Oct 2024 12:35:24 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 272071956056; Tue, 22 Oct 2024 12:35:19 +0000 (UTC)
Date: Tue, 22 Oct 2024 14:35:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, devel@lists.libvirt.org, hreitz@redhat.com,
 jsnow@redhat.com, pkrempa@redhat.com
Subject: Re: [PATCH v3 3/7] qapi: block-job-change: make copy-mode parameter
 optional
Message-ID: <ZxecANVZTYjhpeye@redhat.com>
References: <20241002140616.561652-1-vsementsov@yandex-team.ru>
 <20241002140616.561652-4-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002140616.561652-4-vsementsov@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

Am 02.10.2024 um 16:06 hat Vladimir Sementsov-Ogievskiy geschrieben:
> We are going to add more parameters to change. We want to make possible
> to change only one or any subset of available options. So all the
> options should be optional.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Acked-by: Markus Armbruster <armbru@redhat.com>

This is different from blockdev-reopen, which requires repeating all
options (and can therefore reuse the type from blockdev-add). One of the
reasons why we made it like that is that we had some options for which
"option absent" was a meaningful value in itself, so it would have
become ambiguous if an absent option in blockdev-reopen should mean
"leave the existing value unchanged" or "unset the option".

Are we confident that this will never happen with job options? In case
of doubt, I would go for consistency with blockdev-reopen.

Either way, it would be good to document the reasoning for whatever
option we choose in the commit message.

Kevin


