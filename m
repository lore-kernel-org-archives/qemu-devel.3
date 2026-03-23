Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAFBF483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4i8w-0002Hm-Dw; Mon, 23 Mar 2026 12:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w4i8v-0002HG-1H
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w4i8t-0002za-BC
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774283316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzLbeZzxLSzxpQn7b8CzgnTGIhEcqDdeUipL8JUjw6k=;
 b=OyaSojr9XSJO9g/SnRm3z0eUJbtqPuXmFFc1e5zSkLlNWkuiz2XYlnutxl0pC6zVZQjMH+
 x1bJYROgnva+DCIJhxz2oR6ltiJeXUqJZt106SotpXlZjONFyXljt9BGqFYfFCNeaybGPT
 lNog3OWYZXMHeXions3JX9BLiWGt/oQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-iErOObFVM3OOaqc62ISY2w-1; Mon,
 23 Mar 2026 12:28:35 -0400
X-MC-Unique: iErOObFVM3OOaqc62ISY2w-1
X-Mimecast-MFC-AGG-ID: iErOObFVM3OOaqc62ISY2w_1774283314
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4751A18005BA; Mon, 23 Mar 2026 16:28:34 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.184])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B1881800764; Mon, 23 Mar 2026 16:28:32 +0000 (UTC)
Date: Mon, 23 Mar 2026 17:28:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH for-11.0 0/3] linux-aio/io-uring: Resubmit tails of short
 requests
Message-ID: <acFlG40EEYrKkJWq@redhat.com>
References: <20260318153206.171494-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318153206.171494-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 18.03.2026 um 16:32 hat Hanna Czenczek geschrieben:
> Hi,
> 
> Short reads and writes can happen.  One way to reproduce them is via
> FUSE export, if you force it to limit the request length in the
> read/write path (patch in the commit messages of patches 2 and 3), but
> specifically short writes apparently can also happen with NFS.
> 
> For the file-posix block driver, aio=threads already takes care of them.
> aio=native does not, at all, and aio=io_uring only handles short reads,
> but not writes.  This series has both aio=native and aio=io_uring handle
> both short reads and writes.  zone-append is not touched, as I don’t
> believe resubmitting the tail (if a short append can even happen) is
> safe.

Originally, I think you had intended to loop in coroutine code. Now it
looks like you decided to resubmit already on the lower level directly
when processing completions. Obviously, both approaches work, but I'm
curious what are the reasons that made you pick this approach after all.

Kevin


