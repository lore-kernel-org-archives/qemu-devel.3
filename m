Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B593FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuVds-000859-0V; Tue, 18 Mar 2025 08:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tuVd5-0007no-I0
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tuVd2-00067w-Vg
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742299263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CHnPFO3uiVHVJ8wqm5JwUcb4XA8QSuOXmUycEIhGDnU=;
 b=J2Xm6Y7GN238sBJfrDJ4B9PoelMc623S1zJ6YAJjHBBGHlfXKw6XZ1O29+x/1ZcE01yQrj
 8TkO2MN0EEYYiw+rWj2PuIclHESSkGq82syJX3s5WAcoZarYAkrFzeU4BKR7bRuEfQsebc
 tOyMRNBRCHLD+zAybqLH92Jfln7W0YY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-dUR30p8cPg-l7meLTHL3Ug-1; Tue,
 18 Mar 2025 08:00:58 -0400
X-MC-Unique: dUR30p8cPg-l7meLTHL3Ug-1
X-Mimecast-MFC-AGG-ID: dUR30p8cPg-l7meLTHL3Ug_1742299257
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFF8A1956048; Tue, 18 Mar 2025 12:00:56 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.124])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A0BE180175A; Tue, 18 Mar 2025 12:00:54 +0000 (UTC)
Date: Tue, 18 Mar 2025 13:00:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: gerben@altlinux.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] qcow2: fix null pointer dereference in crypto block
Message-ID: <Z9lgdFO48OpQa6Nt@redhat.com>
References: <20250318105924.258014-1-gerben@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318105924.258014-1-gerben@altlinux.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 18.03.2025 um 11:58 hat gerben@altlinux.org geschrieben:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> This error was discovered by fuzzing qemu-img.
> 
> The qcow2_refresh_limits() is missing a check
> for the s->crypto pointer, which can lead to
> a null pointer dereference. This commit adds the necessary check.
> 
> Reported-by: Leonid Reviakin <L.reviakin@fobos-nt.ru>
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>

Please provide more information how to trigger this. This is probably
the wrong place to fix it. I think a qcow2 image that has bs->encrypted
should always also have s->crypto, so we need to understand why this
isn't the case here.

Kevin


