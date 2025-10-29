Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1AECCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE9hq-0007f8-Vg; Wed, 29 Oct 2025 13:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE9hn-0007QH-4V
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE9hd-0007Vr-Kv
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761757872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GGgT1ZiQvLzNhhqYg47oRc/uUHEfmWcqV+uECETjbcI=;
 b=R84vH6nAJ3mBKX32GqIZq5ndd+V9HbqYw5DFlsFpgrnPEYB2KoN4QVRf7kGkOJsw2n78S9
 kXD/BMuLbTxBkdkWrthNIvZzCGFMn8pOEOcLIXCInOBe3UnpnKY9iwnwbtfCFMaE+F9wva
 AhowQ7tvw0dOzw7kCF27ifFiB+C6G0o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-hKvUPM2TP5uzBahRP6lHtg-1; Wed,
 29 Oct 2025 13:11:10 -0400
X-MC-Unique: hKvUPM2TP5uzBahRP6lHtg-1
X-Mimecast-MFC-AGG-ID: hKvUPM2TP5uzBahRP6lHtg_1761757868
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96474188093F; Wed, 29 Oct 2025 17:10:54 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.204])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B43F19560AD; Wed, 29 Oct 2025 17:10:49 +0000 (UTC)
Date: Wed, 29 Oct 2025 18:10:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH 06/16] gluster: Do not move coroutine into BDS context
Message-ID: <aQJKl_QCyJiwfOZn@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-7-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028163343.116249-7-hreitz@redhat.com>
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

Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
> The request coroutine may not run in the BDS AioContext.  We should wake
> it in its own context, not move it.
> 
> With that, we can remove GlusterAIOCB.aio_context.
> 
> Also add a comment why aio_co_schedule() is safe to use in this way.
> 
> **Note:** Due to a lack of a gluster set-up, I have not tested this
> commit.  It seemed safe enough to send anyway, just maybe not to
> qemu-stable.  To be clear, I don’t know of any user-visible bugs that
> would arise from the state without this patch; the request coroutine is
> moved into the main BDS AioContext, which feels wrong, but I’m not sure
> whether it can actually produce hard bugs.

Doesn't moving into a different AioContext mean that everything down to
the AIO callback in the guest device runs in a different thread? That's
definitely a big no-no for virtio-scsi, and I think also for virtio-blk.

> I’ll leave it to others’ opinions whether to keep or drop this patch
> under these circumstances.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

It looks trivially correct (famous last words...) and the bugs not
unlikely to be hit, so I'd say keep it.

I have no idea if the gluster library is actually thread safe, but if it
isn't, that breaks before gluster_finish_aiocb(). After reentering the
coroutine, the library isn't called any more.

Kevin


