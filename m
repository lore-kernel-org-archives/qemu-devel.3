Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A525DCCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 13:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEpAk-0004sl-08; Fri, 31 Oct 2025 09:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vEpAf-0004ma-9v
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vEpAa-0005X0-Q1
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761917269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erRw8BTL5CU/VRmnweaSJezOf/K5XG+5dZFBQ64Jj9M=;
 b=OqTnYkUCmxg+jJr4INzGovBYB3W5W6VDE4SZBpcKcmDT+HNUFPa6D/dV/oGZYmGSCFo125
 vKOT8bEpVdQ9EP/VZcUFyH5YEwdCOcpQUbUHDJBVwEn0QnFsFyWRkDv9TdCL2+++4xxP4s
 j9ZtVx9ruPBfYAwmfENq9cf0plw2N0Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-KNIt9dVBPh-_IeoEKhmnPQ-1; Fri,
 31 Oct 2025 09:27:46 -0400
X-MC-Unique: KNIt9dVBPh-_IeoEKhmnPQ-1
X-Mimecast-MFC-AGG-ID: KNIt9dVBPh-_IeoEKhmnPQ_1761917264
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A30718001E9; Fri, 31 Oct 2025 13:27:44 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.146])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04BD0180057E; Fri, 31 Oct 2025 13:27:39 +0000 (UTC)
Date: Fri, 31 Oct 2025 14:27:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH 03/16] iscsi: Run =?utf-8?Q?co_?=
 =?utf-8?Q?BH_CB_in_the_coroutine=E2=80=99s?= AioContext
Message-ID: <aQS5SWGLdSedudTb@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-4-hreitz@redhat.com>
 <aQIkQ8q9CaUYw8Ob@redhat.com>
 <5206b3f2-42c7-48a2-aa92-5580f2733ae3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5206b3f2-42c7-48a2-aa92-5580f2733ae3@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 31.10.2025 um 10:07 hat Hanna Czenczek geschrieben:
> On 29.10.25 15:27, Kevin Wolf wrote:
> > Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
> > > For rbd (and others), as described in “rbd: Run co BH CB in the
> > > coroutine’s AioContext”, the pattern of setting a completion flag and
> > > waking a coroutine that yields while the flag is not set can only work
> > > when both run in the same thread.
> > > 
> > > iscsi has the same pattern, but the details are a bit different:
> > > iscsi_co_generic_cb() can (as far as I understand) only run through
> > > iscsi_service(), not just from a random thread at a random time.
> > > iscsi_service() in turn can only be run after iscsi_set_events() set up
> > > an FD event handler, which is done in iscsi_co_wait_for_task().
> > > 
> > > As a result, iscsi_co_wait_for_task() will always yield exactly once,
> > > because iscsi_co_generic_cb() can only run after iscsi_set_events(),
> > > after the completion flag has already been checked, and the yielding
> > > coroutine will then be woken only once the completion flag was set to
> > > true.  So as far as I can tell, iscsi has no bug and already works fine.
> > > 
> > > Still, we don’t need the completion flag because we know we have to
> > > yield exactly once, so we can drop it.  This simplifies the code and
> > > makes it more obvious that the “rbd bug” isn’t present here.
> > > 
> > > This makes iscsi_co_generic_bh_cb() and iscsi_retry_timer_expired() a
> > > bit boring, and actually, for the former, we could drop it and run
> > > aio_co_wake() directly from scsi_co_generic_cb() to the same effect; but
> > > that would remove the replay_bh_schedule_oneshot_event(), and I assume
> > > we shouldn’t do that.  At least schedule both the BH and the timer in
> > > the coroutine’s AioContext to make them simple wrappers around
> > > qemu_coroutine_enter(), without a further BH indirection.
> > I don't think we have to keep the BH. Is your concern about replay? I
> > doubt that this works across different QEMU versions anyway, and if it
> > does, it's pure luck.
> 
> It is solely about replay, yes.  I assumed the
> replay_bh_schedule_oneshot_event() would be a replay point, so removing it
> would, well, remove a replay point.  I suppose we’re going to have one
> replay point per request anyway (when going through the blkreplay driver),
> so maybe it doesn’t matter much?

Yes, I think it is a replay point. And I don't really know what replay
does when the log has an event that doesn't appear in the code (or the
other way around).

I just don't expect that compatibility of replay logs across QEMU
versions is important (and even if it were important, that it is
achieved, because we probably change the control flow leading to replay
points all the time without even noticing). As far as I understand the
idea is that you want to debug a guest, and during that single debug
session you record a guest and then replay it multiple times. I don't
think it's expected that you keep the replay logs for a long time and
across QEMU updates.

Kevin


