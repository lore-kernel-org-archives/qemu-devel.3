Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079B5C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVrQ-0003zC-V0; Tue, 30 Jun 2026 06:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1weVrM-0003yS-DS; Tue, 30 Jun 2026 06:38:32 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1weVrL-00035a-09; Tue, 30 Jun 2026 06:38:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 8BCE5C094E;
 Tue, 30 Jun 2026 13:38:27 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:976::1:1a] (unknown
 [2a02:6bf:8080:976::1:1a])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id Qcb15ZDaGeA0-hOaK52eI; Tue, 30 Jun 2026 13:38:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1782815907;
 bh=XWFbibFzNI/s5i8AdYOFuJjnyL61clMQOaHA55W3nEE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ENckK+efP/h0fP3I1h56DE3WK9ECzqYipVVa5eodtv1hDTMcrsnY4u8YFRv+C7Tkt
 /0w5d6t3kZMYpO/lPPF5ZMhXLT2k0QcR3/zdHqr94CH8/9hp41Zto4Z2zyLRMiH5Wo
 hiGZD6jlFqJrptJvi8148GSbA5i37DQrFS9XMGUY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fa492998-68db-4913-878f-432b54c4051d@yandex-team.ru>
Date: Tue, 30 Jun 2026 13:38:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/unit/test-blockjob: cover keeping a job paused
 while a pause is pending
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
References: <20260623152406.1180235-1-den@openvz.org>
 <20260623152406.1180235-3-den@openvz.org>
Content-Language: ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260623152406.1180235-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
> Add a regression test for the previous commit. A job that has reached
> its pause point is spuriously re-entered (job_enter()) while a pause is
> still pending (pause_count > 0), reproducing what an overlapping drain
> does: one drain's job_resume() wakes the job while the next drain's
> job_pause() is already counted. The job must stay parked - it must not
> run job code or clear job->paused, or job_set_aio_context() could
> observe paused == false and abort.
> 
> The test counts the job's run-loop iterations: without the fix the
> re-entered job clears job->paused, runs one iteration and re-pauses, so
> the counter advances; with the fix it stays parked and the counter is
> unchanged. It runs in the main AioContext, so job_enter() is synchronous
> and the check is deterministic.
> 
> Signed-off-by: Denis V. Lunev<den@openvz.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

