Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E64C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riEB0-00057y-MJ; Thu, 07 Mar 2024 08:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1riE9Z-0001UL-Io
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:51:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1riE9Y-0002ZR-7c
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709819461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6lm4/YFEFSCHfVn5J3/iDiia4dl53voOWHzghRiOdkg=;
 b=TvPuREkYzW78vRQ/OQ11ZuVUMNjI4w4+9LOKdaWu6pATGmQHt5mYl/jUCQXNstUt3LCIdK
 OSs/9q2FrCP7lNk+iENJPjFqGpcD1aMH2DRMYcdErff1B3naR/8M23CdPi15NFVhG0J0cw
 setDwZc7FbmfKvd+XrIOf6hhnhstXBk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-rK7sUyB6Ob6tM4sIwhUgVQ-1; Thu,
 07 Mar 2024 08:51:00 -0500
X-MC-Unique: rK7sUyB6Ob6tM4sIwhUgVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 086A31C54064;
 Thu,  7 Mar 2024 13:51:00 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63302111DCF4;
 Thu,  7 Mar 2024 13:50:58 +0000 (UTC)
Date: Thu, 7 Mar 2024 14:50:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] linux-aio: add IO_CMD_FDSYNC command support
Message-ID: <ZenGQZE4hlOR6J4V@redhat.com>
References: <20240307114744.1135711-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307114744.1135711-1-ppandit@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 07.03.2024 um 12:47 hat Prasad Pandit geschrieben:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Libaio defines IO_CMD_FDSYNC command to sync all outstanding
> asynchronous I/O operations, by flushing out file data to the
> disk storage.
> 
> Enable linux-aio to submit such aio request. This helps to
> reduce latency induced via pthread_create calls by
> thread-pool (aio=threads).
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Kernel support for this is "relatively" new, added in 2018. Should we
fall back to the thread pool if we receive -EINVAL?

Kevin


