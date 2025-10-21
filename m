Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383D3CCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 06:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB5V6-0003hs-J6; Tue, 21 Oct 2025 02:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vB5V3-0003fa-Ib; Tue, 21 Oct 2025 02:05:37 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vB5V0-0004HK-DL; Tue, 21 Oct 2025 02:05:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A3E6780453;
 Tue, 21 Oct 2025 09:05:29 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a4c::1:32] (unknown
 [2a02:6bf:8080:a4c::1:32])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id R5Pl376FrCg0-XE51kZfK; Tue, 21 Oct 2025 09:05:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761026728;
 bh=Op+o1PiNaGSiNNqHX2HXf41TTwtXTvwRtJ1o4+Mkehg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=a8eJcENbOBN08RW1Sz3mmxlpzY2OCxbSOhLVCHyqG5EMBBACNtP7DSaFCIRtoiY6C
 PU33fmCJ71uwvm+091RdgHVdjRqQGZrmyzJlfrdG9bYYhuwJ7r5lI+vFOARJRpGlEs
 i+8vYmDKlA3phUt72iZlUl5ZyfMz0+YWqqdn2tzU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <edbc31b7-545b-416b-a5c1-eee3276ac9d8@yandex-team.ru>
Date: Tue, 21 Oct 2025 09:05:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stream: Remove bdrv from job in .clean()
To: Wesley Hershberger <wesley.hershberger@canonical.com>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20251020-fix-3149-v1-1-04b2d4db5179@canonical.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251020-fix-3149-v1-1-04b2d4db5179@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 21.10.25 01:10, Wesley Hershberger wrote:
> This is similar to bdc4c4c5e372756a5ba3fb3a61e585b02f0dd7f4
> (qmp blockdev-backup). The cor_filter_bs was added to the blockjob as
> the main BDS (by passing it to block_job_create), so
> bdrv_cor_filter_drop doesn't actually remove it from global_bdrv_states.
> 
> This can cause races with qmp query-named-block nodes as described in
>   #3149.

Hmm. But why it lead to segfault? Ok, children kept in global_bdrv_states.
and referenced by the job itself (as I can assume from the patch). What's
wrong with the state, so we went in segfault?

Also, would be good to write the segfault backtrace here, for someone
to search the fix through git.

> 
> As in bdc4c4c, there is no function to remove just the cor_filter_bs
> from the job, so drop all the job's nodes as they are no longer needed.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3149
> Buglink: https://bugs.launchpad.net/bugs/2126951
> Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> ---
> This patch fixes the issue described in Gitlab #3149. Please see the bug
> for additional context & reproducer for the issue.
> 
> I'm happy to discuss alternative approaches or resubmit as needed.
> 
> `make check-block` passes locally.
> 
> A review would be greatly appreciated as a customer's production is
> impacted.
> 
> First-time patch mailer so please pardon any mistakes.
> ---
>   block/stream.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/block/stream.c b/block/stream.c
> index c0616b69e259bf5a9b146dadd9dbac62bfaa9f23..1733abd8f96d7847701f54a7a55d3284387b8582 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -132,6 +132,12 @@ static void stream_clean(Job *job)
>   {
>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>   
> +    /*
> +     * The job still holds a reference to cor_filter_bs; drop all bdrv to
> +     * ensure that it is unref-ed
> +     */
> +    block_job_remove_all_bdrv(&s->common);
> +
>       if (s->cor_filter_bs) {
>           bdrv_cor_filter_drop(s->cor_filter_bs);
>           s->cor_filter_bs = NULL;
> 
> ---
> base-commit: 3a2d5612a7422732b648b46d4b934e2e54622fd6
> change-id: 20251020-fix-3149-f01ae62fa53c
> 
> Best regards,


-- 
Best regards,
Vladimir

