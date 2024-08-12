Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B0BC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 14:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdWHU-0005Ar-NO; Mon, 12 Aug 2024 10:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sdWHT-00059t-Td
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 10:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sdWHP-0001SO-GZ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 10:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723473854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=opwMB0xGbmOtcyHeLB6tuSv2y26sqAdkROMcKyBV/TI=;
 b=JBOjlfxiFUQZ9a3r/uWc4kOWlGVL0SyBeZwVmaLUgS7KJxhXeRvLOHurPY7rXkP32tivq6
 7KWx65ZRFm+PQFY5tDLZ5jH43bVGATsUFmTOdPa8jNThKAC6c9iXtQ8HQFAtHxM4wrnZTW
 tsaOObYAXS4n+UoR2bQFwFNEulOmp70=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-5KhBxp5SPJS5RrCbKmGZiQ-1; Mon,
 12 Aug 2024 10:44:11 -0400
X-MC-Unique: 5KhBxp5SPJS5RrCbKmGZiQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E79D1925386; Mon, 12 Aug 2024 14:44:08 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C364D19560A3; Mon, 12 Aug 2024 14:44:03 +0000 (UTC)
Date: Mon, 12 Aug 2024 09:44:00 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, 
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-stable@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Subject: Re: [PULL 5/5] nbd/server: CVE-2024-7409: Close stray clients at
 server-stop
Message-ID: <d64mjderokt63rplpix32dtvemzdsk4yfizvyk63kynw7dyxje@32hjzvut7yzf>
References: <20240808215529.1065336-7-eblake@redhat.com>
 <20240808215529.1065336-12-eblake@redhat.com>
 <27a348fb-830d-47ec-b2db-0c354711f6f6@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a348fb-830d-47ec-b2db-0c354711f6f6@tls.msk.ru>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Aug 11, 2024 at 11:02:52AM GMT, Michael Tokarev wrote:
> 09.08.2024 00:53, Eric Blake wrote:
> > A malicious client can attempt to connect to an NBD server, and then
> > intentionally delay progress in the handshake, including if it does
> > not know the TLS secrets.  Although the previous two patches reduce

> 
> Eric, from the 5-patch series, only this last patch is Cc'd for stable,
> but it obviously does not work without all 4 previous patches.  Do you
> mean whole series should be applied to -stable?
> 
> I picked up patches 2-5 for 7.2 and 9.0.

You are correct that patch 5 in isolation won't work due to missing
pre-reqs, but also that 1 is fluff that doesn't need backporting; my
apologies for not more judiciously adding the cc to all 4 patches
worth the backport effort.  I'm in the middle of efforts to backport
only 2-5 to various RHEL releases, so your choice to do the same for
7.2 and 9.0 matches what I'm doing downstream.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


