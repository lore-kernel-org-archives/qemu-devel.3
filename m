Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8947606A208
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OCC15q+L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQos8-0005rl-GZ; Tue, 10 Nov 2026 11:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQos7-0005qk-3f
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:38:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQos5-0006dk-JT
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794328736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uowACFDcc9BaDHWPNQ3ue9AAAO+aWPWnQM+5mQGHL3c=;
 b=OCC15q+L0hRdzGIR0qFv1/GdGgk4a8UQwHa+1y5ObN82Z91rQJtatTllcCHMRHBD6iHx9i
 yDwc4s1B7XLCaqRrusKs9xvm1QSUCpCD5feYUbu/v1wctivnaOOeEQf6m8jrNqyRdKW0dT
 4bhHkI6PcBb99AjBuc0IBnThyWo765A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-AtAP0E8gMoa4ONNwy0tuMQ-1; Tue,
 10 Nov 2026 11:38:54 -0500
X-MC-Unique: AtAP0E8gMoa4ONNwy0tuMQ-1
X-Mimecast-MFC-AGG-ID: AtAP0E8gMoa4ONNwy0tuMQ_1794328733
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFC5D1800556; Tue, 10 Nov 2026 16:38:52 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42D1E30000E7; Tue, 10 Nov 2026 16:38:49 +0000 (UTC)
Date: Tue, 10 Nov 2026 10:38:43 -0600
From: Eric Blake <eblake@redhat.com>
To: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 2/2] iotests: Add coverage for NBD connect thread
 start delay
Message-ID: <avNIZtBnJ8qikVPW@redhat.com>
References: <20261105164124.249395-1-guillaume.vincke@ovhcloud.com>
 <20261105164124.249395-3-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105164124.249395-3-guillaume.vincke@ovhcloud.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 05:41:24PM +0100, Guillaume Vincke wrote:
> Test the connect thread starting condition with reconnect-delay=0 when
> the server disconnects after a successful handshake but before running
> operations. Prior to the change to nbd_co_establish_connection(), this
> test would demonstrate two I/O errors. The tests 264 and 277 covering
> reconnection do not use reconnect-delay=0 so this case is not exercised.
> 
> Add a test that provokes multiple errors in order to put an NBD client
> in the above-mentioned situation and shows that the first operation
> starts the connect thread and leads to successful subsequent I/O.
> 
> Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


