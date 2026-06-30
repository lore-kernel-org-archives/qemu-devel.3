Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32FAC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVr4-0003tc-6P; Tue, 30 Jun 2026 06:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1weVr1-0003su-EP; Tue, 30 Jun 2026 06:38:11 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1weVqy-0002r7-T3; Tue, 30 Jun 2026 06:38:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id ADA73C0218;
 Tue, 30 Jun 2026 13:38:02 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:976::1:1a] (unknown
 [2a02:6bf:8080:976::1:1a])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 1cbg8VDZMOs0-WmXOxRdv; Tue, 30 Jun 2026 13:38:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1782815882;
 bh=ev4IihDmETgazzWp8Pqc5g50Di22Qzp+GgSj4D6hXO8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=M/JkPIY7CLDF8zahTFzOPfV5GAqr6/s8heHkm6EUBnRPLh62nxPKP8U+DH+666865
 fzXCGZhTRzopglaQz7hpY2MwSlBiHeu6Soa5esVuqQlF5r3fe2gv821sWK97gYRha4
 rCXmbESdOX4W/dUTPOs1NaQkBccdlbkyVcAg9eFU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <10c79082-100e-4933-abbb-2dd5d3334395@yandex-team.ru>
Date: Tue, 30 Jun 2026 13:38:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] job: keep job paused across overlapping pause requests
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
References: <20260623152406.1180235-1-den@openvz.org>
 <20260623152406.1180235-2-den@openvz.org>
Content-Language: ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260623152406.1180235-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

23.06.26 18:24, Denis V. Lunev пишет:
> job_pause_point_locked() sets job->paused before yielding and clears it
> unconditionally on wake, before re-checking whether a pause is still
> pending. job_pause() re-enters a parked job only while it is not yet
> paused, so the wake that resumes one comes from a drainending
> (job_resume() -> job_enter_cond()). If the next drain begins before that
> wake runs, the woken coroutine clears job->paused while pause_count is
> already > 0 again:
> 
>    AioContext change (BQL thread)     job coroutine (iothread)
>    -----------------------------      ------------------------
>                                       parked in job_pause_point():
>                                         paused=1, pause_count=1, yielded
>    drain ends -> job_resume():
>      pause_count = 0
>      job_enter_cond(): queue wake ..>   (wake pending)
>    bdrv_try_change_aio_context():
>      bdrv_drain_all_begin():
>        job_pause() per node
>        pause_count = N (> 0)
>                                       wake runs, leaves job_do_yield():
>                                         paused = 0  (pause_count == N)
>      tran_commit -> job_set_aio_context():
>        assert(paused || completed) --> abort: paused == 0
> 
> bdrv_try_change_aio_context() drains precisely to quiesce the job before
> changing its AioContext, but that brief paused==0 window trips the
> assertion. It is guest-triggerable: a virtio-blk reset
> (virtio_blk_stop_ioeventfd() -> blk_set_aio_context()) racing a running
> mirror/blockCopy job hits it, as do x-blockdev-set-iothread, blockdev
> hot-plug/unplug and job completion.
> 
> Keep job->paused set while a pause is still pending: loop the yield
> until job_should_pause_locked() is false (or the job is cancelled), and
> only then clear job->paused. Drained-state consumers then never observe
> a pending-pause job as unpaused.
> 
> Signed-off-by: Denis V. Lunev<den@openvz.org>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir

