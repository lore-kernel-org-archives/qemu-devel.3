Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC4EC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpayX-0004DL-K1; Tue, 04 Mar 2025 17:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpayW-0004D9-Qn
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:42:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpayV-0003I7-9d
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741128174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hmfv2urCxfVN1SsqlCP2ejn6LkzlSE19snyDrHkw9lU=;
 b=atZQblW0jLjaEzMQxGeCbSQy4u4mGS6u+q3Bx2gO9zh3yxkHl+f3GSxa8beEyUNyVsh3Gl
 WKqpjeME//+NAhWD0wyZGZx+Q9mfF7nd/ICYnlIZ0ekdiHvQRPF23aErVUczRejRW/VuFn
 KEAnX8d4ZBjqzhw511C2cQ39A8/Aec0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-PwniXGY7O6WtAloCuTDeHA-1; Tue,
 04 Mar 2025 17:42:43 -0500
X-MC-Unique: PwniXGY7O6WtAloCuTDeHA-1
X-Mimecast-MFC-AGG-ID: PwniXGY7O6WtAloCuTDeHA_1741128162
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BFD81954B1A; Tue,  4 Mar 2025 22:42:42 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.46])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2F0F180094C; Tue,  4 Mar 2025 22:42:40 +0000 (UTC)
Date: Tue, 4 Mar 2025 16:42:37 -0600
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] iotests: Stop NBD server in test 162 before starting the
 next one
Message-ID: <fjcumhsohdegemog2fns2hzeszw2gq5zdhqis2sjpkfd6t2rq3@qilj2cmkqc5w>
References: <20250225070650.387638-1-thuth@redhat.com>
 <ivu664vsymtwjgan2nsidcxhejmamycnc2pxf7goafcwpbahiv@dxilv6q6366o>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ivu664vsymtwjgan2nsidcxhejmamycnc2pxf7goafcwpbahiv@dxilv6q6366o>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 27, 2025 at 01:14:12PM -0600, Eric Blake wrote:
> On Tue, Feb 25, 2025 at 08:06:50AM +0100, Thomas Huth wrote:
> > Test 162 recently started failing for me for no obvious reasons (I
> > did not spot any suspicious commits in this area), but looking in
> > the 162.out.bad log file, there was a suspicious message at the end:
> > 
> >  qemu-nbd: Cannot lock pid file: Resource temporarily unavailable
> > 
> > And indeed, the test starts the NBD server two times, without stopping
> > the first server before running the second one, so the second one can
> > indeed fail to lock the PID file. Thus let's make sure to stop the
> > first server before the test continues with the second one. With this
> > change, the test works fine for me again.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  tests/qemu-iotests/162 | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Added to my NBD queue.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


