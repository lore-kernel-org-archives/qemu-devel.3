Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A2ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 08:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCZcs-0004pA-Lm; Sat, 25 Oct 2025 04:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vCZcp-0004oG-EB; Sat, 25 Oct 2025 04:27:48 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vCZcm-0004mV-3l; Sat, 25 Oct 2025 04:27:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E573B81319;
 Sat, 25 Oct 2025 11:27:36 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:538::1:38] (unknown
 [2a02:6bf:8080:538::1:38])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZRVago0Iq4Y0-z5BIA0Fc; Sat, 25 Oct 2025 11:27:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761380856;
 bh=KWWCqMJH6Ql1W/IFRnvwCq5J4WUr2GhmDqB+gagjSSQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=IGpMrW5FnaSnSx+Xvu3f7HEqJDbCRmHwIQQ5GQ68HHO4kig6GoFTjFztI3ENKqPlE
 v2Dl7o3k24Ip5DqT8/sYJbNTd0mqsp7XsO6sVZjKBD/yxKy0d8f7/FeF0+vrGDW/vJ
 wx2mzMAElxdt+DHaog/s6/f3VeYl0iC1MMT0ly5E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5c4788a7-3485-4c03-80a4-4034f6889343@yandex-team.ru>
Date: Sat, 25 Oct 2025 11:27:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Add missing null checks during
 query-named-block-nodes
To: Wesley Hershberger <wesley.hershberger@canonical.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20251024-second-fix-3149-v1-1-d997fa3d5ce2@canonical.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251024-second-fix-3149-v1-1-d997fa3d5ce2@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 24.10.25 21:07, Wesley Hershberger wrote:
> Some operations insert an implicit node above the top node in the block
> graph (e.g. block-stream or blockdev-backup). The implicit node is
> removed when the operation finishes. If QMP query-named-block-nodes is
> called while the operation is removing the implicit node, it may observe
> a node with no children, causing a segfault.
> 
> This is hypothesized to only affect the block-stream operation as other
> operations use the workaround bdc4c4c5e372756a5ba3fb3a61e585b02f0dd7f4
> or do not detach their children during cleanup (see
> 3108a15cf09865456d499b08fe14e3dbec4ccbb3).
> 
> This backtrace was observed in #3149 on a relatively recent build. The
> bs passed to bdrv_refresh_filename is the cor_filter_bs from the
> block-stream operation; bs->implicit was "true".
> 
> 0  bdrv_refresh_filename (bs=0x5efed72f8350)
>      at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:8082
> 1  0x00005efea73cf9dc in bdrv_block_device_info
>      (blk=0x0, bs=0x5efed72f8350, flat=true, errp=0x7ffeb829ebd8)
>      at block/qapi.c:62
> 2  0x00005efea7391ed3 in bdrv_named_nodes_list
>      (flat=<optimized out>, errp=0x7ffeb829ebd8)
>      at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:6275
> 3  0x00005efea7471993 in qmp_query_named_block_nodes
>      (has_flat=<optimized out>, flat=<optimized out>, errp=0x7ffeb829ebd8)
>      at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/blockdev.c:2834
> 4  qmp_marshal_query_named_block_nodes
>      (args=<optimized out>, ret=0x7f2b753beec0, errp=0x7f2b753beec8)
>      at qapi/qapi-commands-block-core.c:553
> 5  0x00005efea74f03a5 in do_qmp_dispatch_bh (opaque=0x7f2b753beed0)
>      at qapi/qmp-dispatch.c:128
> 6  0x00005efea75108e6 in aio_bh_poll (ctx=0x5efed6f3f430)
>      at util/async.c:219
> ...
> 
> The get_allocated_file_size change resolves a second segfault after the
> first was resolved. Here, bdrv_filter_bs returns NULL as the
> bs (cor_filter_bs) has no children:
> 
> 0  bdrv_co_get_allocated_file_size (bs=<optimized out>)
>      at /usr/src/qemu-1:10.1.0+ds-5ubuntu2+test8/b/qemu/block.c:6018
> 1  0x0000631d078522be in bdrv_co_get_allocated_file_size_entry
>      (opaque=0x7ffd375c5dd0) at block/block-gen.c:288
> 2  0x0000631d07929ec2 in coroutine_trampoline
>      (i0=<optimized out>, i1=<optimized out>)
>      at util/coroutine-ucontext.c:175
> ...
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3149
> Buglink: https://bugs.launchpad.net/bugs/2126951
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir

