Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F5BD43FE6
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 07:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCwdq-00045U-F0; Mon, 18 Nov 2024 02:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tCwdf-00044n-Hj; Mon, 18 Nov 2024 02:57:39 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tCwdb-0007iR-Gz; Mon, 18 Nov 2024 02:57:39 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:4fa4:0:640:dbe3:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4CABE6097B;
 Mon, 18 Nov 2024 10:57:29 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:210::1:15] (unknown
 [2a02:6b8:b081:210::1:15])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id SvKpRg1IhuQ0-zScn4R7D; Mon, 18 Nov 2024 10:57:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1731916648;
 bh=IBI4jtNbqXAT47F045NcacpMJ6kjnSWTOzquvobkw+w=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=cepKmmq5H67xgZASbBeO70UFDQKmXK1AQcSgxRrmyLGSW0hdME874ZNuVrVSB665W
 2U1/l9tEaI+CcjfFwu5Js3Hq+lTiv2df+MOqIPToZHcgFx93lCHgGhpWBXyUVjX60O
 8nuC5f4bR6PpbsSzlJgR6ca9AmBCDJgxqzgskaz4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6eaf3d9f-d80f-4a4c-bd4f-853d0b43b46c@yandex-team.ru>
Date: Mon, 18 Nov 2024 10:57:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] block: allow commit to unmap zero blocks
To: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20241026163010.2865002-1-libvirt-e6954efa@volkihar.be>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20241026163010.2865002-1-libvirt-e6954efa@volkihar.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 26.10.24 19:30, Vincent Vanlaer wrote:
> This patch series adds support for zero blocks in non-active commits.
> The first three patches in the series refactor the relevant code, patch
> four makes the actual changes, and the last patch adds a test for the
> new functionality.
> 
> ---
> 
> Changes since v3:
> - minor reformating based on checkpatch.pl
> - moved tracepoint in commit_iteration before first possible return on
>    error
> - renamed the handle_error label in commit_iteration to fail and
>    prevented the happy path from passing through this label
> - moved test script to the tests/qemu-iotests/tests folder and named it
>    commit-zero-blocks
> 
> Changes since v2:
> - moved main loop of commit_run to a separate function and refactored
>    the error handling.
> - call blk_co_pwrite_zero even if the size of the zero region does not
>    align with the sectors of the base image. This removes the need for
>    the CommitMethod enum
> 
> Changes since v1:
> - split up the implementation in three separate commits
> - removed accidentally left over includes from testing
> 
> Vincent Vanlaer (5):
>    block: get type of block allocation in commit_run
>    block: move commit_run loop to separate function
>    block: refactor error handling of commit_iteration
>    block: allow commit to unmap zero blocks
>    block: add test non-active commit with zeroed data
> 
>   block/commit.c                                | 116 +++++++++++++-----
>   tests/qemu-iotests/tests/commit-zero-blocks   |  96 +++++++++++++++
>   .../qemu-iotests/tests/commit-zero-blocks.out |  54 ++++++++
>   3 files changed, 232 insertions(+), 34 deletions(-)
>   create mode 100755 tests/qemu-iotests/tests/commit-zero-blocks
>   create mode 100644 tests/qemu-iotests/tests/commit-zero-blocks.out
> 

Thanks, applied to my block branch,

with

     diff --git a/block/commit.c b/block/commit.c
     index 5c24c8b80a..bfd969b13f 100644
     --- a/block/commit.c
     +++ b/block/commit.c
     @@ -172,7 +172,8 @@ static int commit_iteration(CommitBlockJob *s, int64_t offset,
          *requested_bytes = bytes;

          return 0;
     -fail:;
     +
     +fail:
          BlockErrorAction action = block_job_error_action(&s->common, s->on_error,
                                                           error_in_source, -ret);
          if (action == BLOCK_ERROR_ACTION_REPORT) {

change to patch 3.


Unfortunately, I've missed soft-freeze on 05.11. Will send PR when 10.0 development phase opens.

-- 
Best regards,
Vladimir


