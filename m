Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06401EDF176
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 16:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvwc-0005Mz-WE; Fri, 13 Feb 2026 11:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vqvwb-0005MC-8J
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:23:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vqvwZ-0001SV-Hu
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770999778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FjY//L9hwpADQt5NJ30vnChu+jutG9LiVXECY1Bgbco=;
 b=SfNhL4GYzWg8TNg6r9GKtHOxgg2x7NQO4VfVZWU04xPv1ZqPcS4/qP/HuV+99VQ2eDmfdP
 ARiZa7wArkMAqUnWoH86UbGibzpsv1UPVidnuELTxkTz0lqBpAgzzcswbq8k9vrhicDppp
 rQMFkfZushatNjDIfsp4NqEZN2IFRhE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-8R8_tbjVMIeiRkZX-V5NIA-1; Fri,
 13 Feb 2026 11:22:54 -0500
X-MC-Unique: 8R8_tbjVMIeiRkZX-V5NIA-1
X-Mimecast-MFC-AGG-ID: 8R8_tbjVMIeiRkZX-V5NIA_1770999773
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DCD01800630; Fri, 13 Feb 2026 16:22:52 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.253])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE2DA1800465; Fri, 13 Feb 2026 16:22:49 +0000 (UTC)
Date: Fri, 13 Feb 2026 17:22:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, fam@euphon.net,
 stefanha@redhat.com
Subject: Re: [PATCH 2/2] fdmon-io_uring: check CQ ring directly in
 gsource_check
Message-ID: <aY9P1zxBngbVcO3i@redhat.com>
References: <20260213143225.161043-1-axboe@kernel.dk>
 <20260213143225.161043-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213143225.161043-3-axboe@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 13.02.2026 um 15:26 hat Jens Axboe geschrieben:
> gsource_check() only looks at the ppoll revents for the io_uring fd,
> but CQEs can be posted during gsource_prepare()'s io_uring_submit()
> call via kernel task_work processing on syscall exit. These completions
> are already sitting in the CQ ring but the ring fd may not be signaled
> yet, causing gsource_check() to return false.
> 
> Add a fallback io_uring_cq_ready() check so completions that arrive
> during submission are dispatched immediately rather than waiting for
> the next ppoll() cycle.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


