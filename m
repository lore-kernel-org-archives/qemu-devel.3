Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E1AC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 18:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUViN-0006CY-QZ; Thu, 18 Jul 2024 14:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUViM-0006BW-DF
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 14:18:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUViG-0007db-K0
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 14:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721326712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YtMB9Od/uwhWdDlRPJSwPEl0GYgePd/kClhdwmd2/44=;
 b=HRXku2vUMhFFxKmXA4jzO/deazL5VIpdLkVhQdq30fB1l2EV//JjJ3Jp89ZDyKlxCVVR2H
 zuxSioxaOIxv79Slkkg+lidqQ4N+vdyfDh5zA52rIR6p8pD8Rus4It9377xYGNutc7W5J8
 WNR7ySbmDVPBaaT8PNdoEOO5EeydYYQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-2w_nJg9uMkiuJg0k5PCYMg-1; Thu,
 18 Jul 2024 14:18:23 -0400
X-MC-Unique: 2w_nJg9uMkiuJg0k5PCYMg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 229F819560AA; Thu, 18 Jul 2024 18:18:19 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.0])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D62D1955E89; Thu, 18 Jul 2024 18:18:15 +0000 (UTC)
Date: Thu, 18 Jul 2024 20:18:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-block@nongnu.org, jsnow@redhat.com
Subject: Re: [PATCH] qapi-block-core: Clean up
 blockdev-snapshot-internal-sync doc
Message-ID: <ZplcZPzuOCAWOX4x@redhat.com>
References: <20240718123609.3063055-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718123609.3063055-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 18.07.2024 um 14:36 hat Markus Armbruster geschrieben:
> BlockdevSnapshotInternal is the arguments type of command
> blockdev-snapshot-internal-sync.  Its doc comment contains this note:
> 
>     # .. note:: In a transaction, if @name is empty or any snapshot matching
>     #    @name exists, the operation will fail.  Only some image formats
>     #    support it; for example, qcow2, and rbd.
> 
> "In a transaction" is misleading, and "if @name is empty or any
> snapshot matching @name exists, the operation will fail" is redundant
> with the command's Errors documentation.  Drop.
> 
> The remainder is fine.  Move it to the command's doc comment, where it
> is more prominently visible, with a slight rephrasing for clarity.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Thanks, applied to the block branch.

Kevin


