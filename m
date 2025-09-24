Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0732CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 16:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1S0x-00082q-63; Wed, 24 Sep 2025 12:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v1S0o-00081D-M8
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v1S0h-00043i-7Z
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758729980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zUc5KtmLZMp25JLBlZyxCwe3gaMoronpF90fItmD7Ow=;
 b=NX1tnYcvICHQu6Fjw+rI6iLpjDePWnHik+2xtXs33ALhiWG3vjMvfcqSj1EhqqSmUigv5s
 Tt8WFdqqk1EGV9IgYsUDMrL1+p+E2aL1HmPyGrwGqWbavmjZXn63ZJZ7boo1uVOXWPj9Cr
 9UOLEcxRDdh02oq6nZvVgsAipAWNP+U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-MSfDoYaIPEmt5uDz9YzzkQ-1; Wed,
 24 Sep 2025 12:06:12 -0400
X-MC-Unique: MSfDoYaIPEmt5uDz9YzzkQ-1
X-Mimecast-MFC-AGG-ID: MSfDoYaIPEmt5uDz9YzzkQ_1758729971
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B6491956055; Wed, 24 Sep 2025 16:06:11 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1107C300018D; Wed, 24 Sep 2025 16:06:08 +0000 (UTC)
Date: Wed, 24 Sep 2025 18:06:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] block: remove 'detached-header' option from opts after use
Message-ID: <aNQW7jdz6pkI2RTq@redhat.com>
References: <20250919103810.1513109-1-berrange@redhat.com>
 <7okqs3bzbm7pof2cvym4mmeoed5alrap7kfy7ygqeevzmqi4ul@hibkvzgs5itm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7okqs3bzbm7pof2cvym4mmeoed5alrap7kfy7ygqeevzmqi4ul@hibkvzgs5itm>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 22.09.2025 um 14:37 hat Eric Blake geschrieben:
> On Fri, Sep 19, 2025 at 11:38:10AM +0100, Daniel P. Berrangé wrote:
> > The code for creating LUKS devices references a 'detached-header'
> > option in the QemuOpts  data, but does not consume (remove) the
> > option.
> > 
> > Thus when the code later tries to convert the remaining unused
> > QemuOpts into a QCryptoBlockCreateOptions struct, an error is
> > reported by the QAPI code that 'detached-header' is not a valid
> > field.
> > 
> > This fixes a regression caused by
> > 
> >   commit e818c01ae6e7c54c7019baaf307be59d99ce80b9
> >   Author: Daniel P. Berrangé <berrange@redhat.com>
> >   Date:   Mon Feb 19 15:12:59 2024 +0000
> > 
> >     qapi: drop unused QCryptoBlockCreateOptionsLUKS.detached-header
> > 
> > which identified that the QAPI field was unused, but failed to
> > realize the QemuOpts -> QCryptoBlockCreateOptions conversion
> > was seeing the left-over 'detached-header' optino which had not
> 
> option
> 
> > been removed from QemuOpts.
> > 
> > This problem was identified by the 'luks-detached-header' I/O
> > test, but unfortunate I/O tests are not run regularly for the

I assume this should be "unfortunately".

> > LUKS format.
> > 
> > Fixes: e818c01ae6e7c54c7019baaf307be59d99ce80b9
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  block/crypto.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks, applied to the block branch.

Kevin


