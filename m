Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C72ACCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 19:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDpbK-0004uG-Gx; Tue, 28 Oct 2025 15:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDpbF-0004sx-O0; Tue, 28 Oct 2025 15:43:21 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDpb5-0006ho-MU; Tue, 28 Oct 2025 15:43:18 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9870C807A0;
 Tue, 28 Oct 2025 22:42:57 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:582::1:19] (unknown
 [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ugjA7e2bISw0-0nv0meGR; Tue, 28 Oct 2025 22:42:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761680577;
 bh=VD5K9zsc+MES5/cLVQ3Gjd9ZvoM4VS3G43lFQ3wtURo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EtaOTqU/lbzBKkBXp6hl/sdtzlWTrKvv2diAHYHucaTLFGhT/gfIwTtip6KHBfLoE
 r4fbifg7jX+u91nITA1JwGZC9ai6i0UCBvGr9QwRZqB3c42CCfGhAhNMBG1+LP8pZL
 xYl5ac+Ny3Qyl1bpPy2u3xc7S6b5LTy2I3gjJiqA=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2a215e28-2daf-4049-a147-e408d849ea6f@yandex-team.ru>
Date: Tue, 28 Oct 2025 22:42:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: Keep filter children attached during drop
To: Wesley Hershberger <wesley.hershberger@canonical.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20251028-third-fix-3149-v1-0-bf3c712d2439@canonical.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251028-third-fix-3149-v1-0-bf3c712d2439@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 28.10.25 19:08, Wesley Hershberger wrote:
> Thank you all for the discussion in the previous thread:
> 20251024-second-fix-3149-v1-1-d997fa3d5ce2@canonical.com
> 
> I have verified that this patch resolves the issue from #3149 and passes
> the iotests for qcow2/raw/nbd that don't fail on master (for me). Thanks
> for the pointers on testing.
> 
> I'm committed to finding a solution to this that is adequately
> understood and tested; I'm happy to continue to make
> adjustments/submissions as needed until we have a solution that is
> satisfying.
> 
> Please let me know if any adjustments are needed; thanks for your
> patience and continued involvement.
> 
> Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> ---
> Wesley Hershberger (2):
>        iotests/257: Insert missing flush during blockdev-backup
>        block: Drop detach_subchain for bdrv_replace_node
> 
>   block.c                    | 38 ++++----------------------------------
>   tests/qemu-iotests/257     |  8 ++++++--
>   tests/qemu-iotests/257.out | 14 +++++++-------
>   3 files changed, 17 insertions(+), 43 deletions(-)
> ---
> base-commit: 36076d24f04ea9dc3357c0fbe7bb14917375819c
> change-id: 20251027-third-fix-3149-582fd7382fb9
> 
> Best regards,

Seems good to me:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

(weak for test, as I don't know its logic. Still, this test-output change
doesn't look wrong in context of block permissions, so I don't care)

Also, I think the two commits should be merged into one (keep my r-b if you
do), as otherwise we break ./check.py on the first one and then fix on the
second, it may break git bisect.

-- 
Best regards,
Vladimir

