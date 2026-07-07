Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD99C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh6d4-000525-4U; Tue, 07 Jul 2026 10:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wh6d2-00050j-1u; Tue, 07 Jul 2026 10:18:28 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wh6cy-0004zK-ME; Tue, 07 Jul 2026 10:18:27 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c1b:16:0:640:bc52:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 204AA808A5;
 Tue, 07 Jul 2026 17:18:19 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a91::1:28] (unknown
 [2a02:6bf:8080:a91::1:28])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id IIJjJQ2YFW20-apyvBJOz; Tue, 07 Jul 2026 17:18:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1783433898;
 bh=OOwDFySYv8gSkyQo6HibOF3rXT7AradyM2uSWKSuWgY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=A+yxhftoRyi+xA+U6Hqg3jLTjYjxpKSRbN9SynZg+1TleUHE2pGoJc5+1aXEh9sdf
 SFAk0RsTaAIj5svJS1oO2NB3cT877kEnESR8o3V5gOnUBj3gtqlJWgxmsJGaSLGGno
 FWgxhgwfztql4W1inRPIDpg3C6SAy0z4s1EBN7Eo=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3f4bf163-4a29-47f6-bdf6-c64cc8ec8a04@yandex-team.ru>
Date: Tue, 7 Jul 2026 17:18:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] job: don't drop job->paused while a pause is pending
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
References: <20260623152406.1180235-1-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260623152406.1180235-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 23.06.26 18:24, Denis V. Lunev wrote:
> A guest can abort QEMU with
> 
>    qemu-system-x86_64: ../job.c:379: job_set_aio_context: Assertion
>    `job->paused || job_is_completed_locked(job)' failed.
> 
> when it touches a virtio-blk device whose BlockBackend lives in an
> iothread while a block job (drive-mirror / blockCopy) runs on the same
> node. It is guest-triggerable and reproduces on current master. It was
> reported against the qemu-kvm 10.0 downstream, hit by the live-migration
> validation suite when a blockdev-mirror (libvirt blockCopy) ran while
> the guest reset its virtio-blk device during boot.
> 
> Under overlapping drains job_pause_point_locked() clears job->paused on
> wake while a pause is still pending (pause_count > 0), and the
> concurrent AioContext change reads paused == false and asserts. Patch 1
> carries the full interleaving and the fix; being in the job layer it
> also covers the other bdrv_try_change_aio_context() callers
> (x-blockdev-set-iothread, blockdev hot-plug/unplug, job completion), not
> just the virtio-blk reset path.
> 
> Patch 2 is a deterministic regression test in tests/unit/test-blockjob
> that fails without patch 1 and passes with it. It is illustrative only:
> it pins the exact invariant patch 1 restores, but the fix stands on its
> own and the test may be dropped freely.
> 
> There is no iotests reproducer. iotests run under qtest, which has no
> vCPU, so the only way to change a running job's AioContext from outside
> its iothread is x-blockdev-set-iothread, which runs in the main loop
> under the BQL - the same lock the pause handshake takes - and the
> cross-thread window never opens on an idle qtest VM. Several designs
> (back-to-back set-iothread, pause/resume churn, two iothreads, a
> latency-injecting null-co feeding a throttled mirror) all pass on the
> unfixed build; a timing test that passes on broken code is worse than
> none.
> 
> To reproduce on master: in the guest, tightly unbind/rebind a virtio-blk
> PCI function backed by an iothread; on the host, keep a throttled
> blockdev-mirror alive on that disk's node. The assertion fires within
> seconds; with patch 1 it runs indefinitely.
> 
> checkpatch is clean; test-blockjob, test-bdrv-drain and test-block-iothread
> pass.
> 
> Denis V. Lunev (2):
>    job: keep job paused across overlapping pause requests
>    tests/unit/test-blockjob: cover keeping a job paused while a pause is
>      pending
> 
>   job.c                      |   9 +++-
>   tests/unit/test-blockjob.c | 100 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 108 insertions(+), 1 deletion(-)
> 

Thanks, applied to my block branch.

-- 
Best regards,
Vladimir

