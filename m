Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B26DC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzO8-0000RK-8B; Tue, 28 May 2024 12:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sBzO7-0000Qa-19
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sBzO5-00005E-H3
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716912560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6eyyZdfL/8MfAoN38i3a9dpHXQqh7lkTOO9bPr6NcYQ=;
 b=JFruStgk1NEfOJtfaGwZs68Mx6iVTbc7BjhoOeR7esEsNqiinGQbqG27epJ+aRlBcA8PuU
 2XSqhRGlMGeQBM44d7dS0upcnxH8rqDX4kfRosrv88YTs70AJfI/HPe4SmE6/1hP+F6/8v
 37HxaSK1Mf2VzjlWyQ/ofjbQ4Dw3C88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-mswCxDjVPf6KF4oBwqQOcw-1; Tue, 28 May 2024 12:09:15 -0400
X-MC-Unique: mswCxDjVPf6KF4oBwqQOcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35D798025FC;
 Tue, 28 May 2024 16:09:15 +0000 (UTC)
Received: from redhat.com (unknown [10.39.195.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18BAC1C0654B;
 Tue, 28 May 2024 16:09:13 +0000 (UTC)
Date: Tue, 28 May 2024 18:09:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: stefanha@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mtosatti@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v5] linux-aio: add IO_CMD_FDSYNC command support
Message-ID: <ZlYBqNQNpP85bT-R@redhat.com>
References: <20240425070412.37248-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425070412.37248-1-ppandit@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 25.04.2024 um 09:04 hat Prasad Pandit geschrieben:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Libaio defines IO_CMD_FDSYNC command to sync all outstanding
> asynchronous I/O operations, by flushing out file data to the
> disk storage. Enable linux-aio to submit such aio request.
> 
> When using aio=native without fdsync() support, QEMU creates
> pthreads, and destroying these pthreads results in TLB flushes.
> In a real-time guest environment, TLB flushes cause a latency
> spike. This patch helps to avoid such spikes.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Thanks, applied to the block branch.

Kevin


