Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3254ACCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 14:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE79a-0000Xb-9s; Wed, 29 Oct 2025 10:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE79U-0000WZ-20
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE79J-0000PV-Vb
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761748049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+IQt/32bOOtTfd/77x4Ws/t6l8hg78hvdIEEVSQvjkA=;
 b=EUFRjlDrsepzcUJ80GU4C31MMdtqx1T13O4vIxuSLSSk1eIjqFfpRGqhWp1sXIWhzLaDKM
 0N1yBlW010t+HFjWJDXLmvAywziZ6jJzlYGa6iplNe3t0OkcbE52F6ruttu0/TmMw5qKgU
 q7NzpwuMNMtSg50FanpUrI8a26S9Ew0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-97CtU9YkPOargnTYZXGDHQ-1; Wed,
 29 Oct 2025 10:27:24 -0400
X-MC-Unique: 97CtU9YkPOargnTYZXGDHQ-1
X-Mimecast-MFC-AGG-ID: 97CtU9YkPOargnTYZXGDHQ_1761748042
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19D3D1800D86; Wed, 29 Oct 2025 14:27:22 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.204])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE7B61800579; Wed, 29 Oct 2025 14:27:17 +0000 (UTC)
Date: Wed, 29 Oct 2025 15:27:15 +0100
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
Message-ID: <aQIkQ8q9CaUYw8Ob@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-4-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028163343.116249-4-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> For rbd (and others), as described in “rbd: Run co BH CB in the
> coroutine’s AioContext”, the pattern of setting a completion flag and
> waking a coroutine that yields while the flag is not set can only work
> when both run in the same thread.
> 
> iscsi has the same pattern, but the details are a bit different:
> iscsi_co_generic_cb() can (as far as I understand) only run through
> iscsi_service(), not just from a random thread at a random time.
> iscsi_service() in turn can only be run after iscsi_set_events() set up
> an FD event handler, which is done in iscsi_co_wait_for_task().
> 
> As a result, iscsi_co_wait_for_task() will always yield exactly once,
> because iscsi_co_generic_cb() can only run after iscsi_set_events(),
> after the completion flag has already been checked, and the yielding
> coroutine will then be woken only once the completion flag was set to
> true.  So as far as I can tell, iscsi has no bug and already works fine.
> 
> Still, we don’t need the completion flag because we know we have to
> yield exactly once, so we can drop it.  This simplifies the code and
> makes it more obvious that the “rbd bug” isn’t present here.
> 
> This makes iscsi_co_generic_bh_cb() and iscsi_retry_timer_expired() a
> bit boring, and actually, for the former, we could drop it and run
> aio_co_wake() directly from scsi_co_generic_cb() to the same effect; but
> that would remove the replay_bh_schedule_oneshot_event(), and I assume
> we shouldn’t do that.  At least schedule both the BH and the timer in
> the coroutine’s AioContext to make them simple wrappers around
> qemu_coroutine_enter(), without a further BH indirection.

I don't think we have to keep the BH. Is your concern about replay? I
doubt that this works across different QEMU versions anyway, and if it
does, it's pure luck.

> Finally, remove the iTask->co != NULL checks: This field is set by
> iscsi_co_init_iscsitask(), which all users of IscsiTask run before even
> setting up iscsi_co_generic_cb() as the callback, and it is never set or
> cleared elsewhere, so it is impossible to not be set in
> iscsi_co_generic_cb().
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

Kevin


