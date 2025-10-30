Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136B1CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETP4-0006MY-0x; Thu, 30 Oct 2025 10:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vETP1-0006M6-I0
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vETOv-00043q-Bq
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761833589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gm8QRhGCGvFRxQQWy34/UhxO28Qtsj71qe9tmtZwCas=;
 b=dzkqkZVe0Fwnm7RM8hDrX2H8gkz1DuWb6VSsO29DT3UhRvh7HTdFSIkhV6Br/7EGV38B0V
 GnlZpagxYWQ+n1hda29dJE9SJojOzUhHt/kMZm4R8TIRSIZXjVWy0bK7+sTtz83/5ASgkM
 UutnZrhX8r1YJj+QjxEQ/s3lhfWiQFY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-vCnrZeb4N8awx9fRACoAMg-1; Thu,
 30 Oct 2025 10:13:06 -0400
X-MC-Unique: vCnrZeb4N8awx9fRACoAMg-1
X-Mimecast-MFC-AGG-ID: vCnrZeb4N8awx9fRACoAMg_1761833584
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A334C1955EAD; Thu, 30 Oct 2025 14:13:03 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.243])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C28841955F22; Thu, 30 Oct 2025 14:12:58 +0000 (UTC)
Date: Thu, 30 Oct 2025 15:12:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH 16/16] win32-aio: Run CB in original context
Message-ID: <aQNyaNumB0tiCOgM@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-17-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028163343.116249-17-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
> AIO callbacks must be called in the originally calling AioContext,
> regardless of the BDS’s “main” AioContext.
> 
> Note: I tried to test this (under wine), but failed.  Whenever I tried
> to use multiqueue or even just an I/O thread for a virtio-blk (or
> virtio-scsi) device, I/O stalled, both with and without this patch.
> 
> For what it’s worth, when not using an I/O thread, I/O continued to work
> with this patch.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

Should we then do the opposite thing and just move every request into
the main thread and only move back before returning to the caller?

But I'm also not against making the theoretical fix so that maybe
someone can fix the other problem later. It just seems to be of somewhat
limited use on its own.

Kevin


