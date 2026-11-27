Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21338606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NeiyW94j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWsrx-0005ga-NM; Fri, 27 Nov 2026 05:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xWsrw-0005gN-8I
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 05:07:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xWsru-0002ha-DW
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 05:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795774068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TGbAk9/WjlzJXn1u8mQ6ZqKPd+sFpbBwXbbZsIVncEI=;
 b=NeiyW94jKruDzzrgNaUIT+Gl5g8tK7W+kG2P0IcWccKMr5Zu5AJZ9BQWXdsA5ydZu6jgIh
 M3GnZo4xqDi+TQC4bAeT8X6Bi64iRaRUd4hswSK16iT+cgkKtaBpsoFxd8kNNawelWwIFM
 q6r2SmE9h5rLUOuqvuzu8OwkRALcOk0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-LYQcMrxfNnqoLI54B5v7Nw-1; Fri,
 27 Nov 2026 10:07:46 +0000
X-MC-Unique: LYQcMrxfNnqoLI54B5v7Nw-1
X-Mimecast-MFC-AGG-ID: LYQcMrxfNnqoLI54B5v7Nw_1795774066
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7E9B195604C
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 10:07:45 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.41])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E23118004FC; Fri, 27 Nov 2026 10:07:43 +0000 (UTC)
Date: Fri, 27 Nov 2026 11:07:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, stefanha@redhat.com,
 Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH] file-posix: Fix loss of QAPI feature
 'dynamic-auto-read-only'
Message-ID: <awlWbYivEwjVq7Yg@redhat.com>
References: <20261124152218.2562390-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124152218.2562390-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 24.11.2026 um 16:22 hat Markus Armbruster geschrieben:
> Recent commit 691094b7091b added a variant member to BlockdevOptions
> branch 'host-device' by changing the branch type to new struct type
> BlockdevOptionsHostDevice that has the old branch type
> BlockdevOptionsFile as base.  This is a perfectly reasonable thing to
> do.  However, since a type only inherits its base's members, and not
> its features or conditions, this lost BlockdevOptionsFile's feature
> 'dynamic-auto-read-only'.
> 
> Considering we are in deep freeze, fix the regression the stupidest
> and safest way possible: copy the feature from BlockdevOptionsFile to
> BlockdevOptionsHostDevice.
> 
> Reported-by: Peter Krempa <pkrempa@redhat.com>
> Fixes: 691094b7091b ("file-posix: Add 'accept-read-only-device' option")
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


