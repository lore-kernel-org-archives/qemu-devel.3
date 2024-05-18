Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17422C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 02:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8AFv-0001hh-JS; Fri, 17 May 2024 22:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1s8AFs-0001hH-VM
 for qemu-devel@nongnu.org; Fri, 17 May 2024 22:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1s8AFq-0007dy-Cy
 for qemu-devel@nongnu.org; Fri, 17 May 2024 22:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716001016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yg04oMLxjoZ4jpbyLEToQIIgc4vmR6dtaXG6u2ddne0=;
 b=Wj4lPkxRdDusxZnaed2OMj/RatSG7JMv05TKE1tYUvbYpJek/9VdNB1b/Z1MERxMwXTbX4
 PeTGlpTJ8TnU1s7i+LzE4EA01q4UfcJZASN5b/tFkufhSbl2ZdmsOQ6xGOccBY2ZMuNndR
 N4TGraIdRW9F9L/E2/UJjmZSsSVKjvQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-lFXzEULyP_GJa0qsltFB-Q-1; Fri,
 17 May 2024 22:56:54 -0400
X-MC-Unique: lFXzEULyP_GJa0qsltFB-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF0B41C106A5;
 Sat, 18 May 2024 02:56:53 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 125801054820;
 Sat, 18 May 2024 02:56:52 +0000 (UTC)
Date: Fri, 17 May 2024 21:56:50 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v2 0/2] Fix NBD+TLS regression in presence of iothread
Message-ID: <2r2ckvblrrghnkxi5weqw3xd4rhkcwh62nxk6lzoa7nywwvtvs@uzwy76j3gu7c>
References: <20240518025246.791593-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518025246.791593-4-eblake@redhat.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 17, 2024 at 09:50:13PM GMT, Eric Blake wrote:
> In v2:
> - correct list email address
> - add iotest
> - add R-b
> 
> I'm offline next week, and have been communicating with Stefan who may
> want to push this through his block tree instead of waiting for me to
> get back.

I also meant to add that I did test that the iotest 2/2 fails unless
1/2 is applied.

> 
> Eric Blake (2):
>   qio: Inherit follow_coroutine_ctx across TLS
>   iotests: test NBD+TLS+iothread
> 
>  io/channel-tls.c                              |  26 +--
>  io/channel-websock.c                          |   1 +
>  tests/qemu-iotests/tests/nbd-tls-iothread     | 170 ++++++++++++++++++
>  tests/qemu-iotests/tests/nbd-tls-iothread.out |  54 ++++++
>  4 files changed, 240 insertions(+), 11 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/nbd-tls-iothread
>  create mode 100644 tests/qemu-iotests/tests/nbd-tls-iothread.out
> 
> -- 
> 2.45.0
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


