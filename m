Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A336CEF48DF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 08:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqoJO-0000VH-Ad; Fri, 13 Feb 2026 03:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vqoJJ-0000UQ-VB; Fri, 13 Feb 2026 03:13:58 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vqoJH-0001wV-2p; Fri, 13 Feb 2026 03:13:57 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5D296C01C0;
 Fri, 13 Feb 2026 11:13:50 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:450::1:4] (unknown [2a02:6bf:8080:450::1:4])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id nDQhsJ1ACGk0-WAFULC36; Fri, 13 Feb 2026 11:13:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770970429;
 bh=1IZ9MlejDJwdIQ+fEG4Y0wqljfidAY+ZLvenxewrsqM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Co+pIaHLVFa8zPn83JXPCcniJgeF+eZtv0IQyTqycmhZ7gseWGbu2pUzzys4SO324
 PRX5fONlxcLUOi71UX5tkNdgRUEkdo0dHPW08Bix3UqUwF7z2ZsiIq6MBCM8ia2sHa
 pKSOH/O5sakCoxMqUUtA/7u2w2K0fo6JREJ3Km7A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <bd347b79-23e2-4a09-aa42-a08e7f2e0ff4@yandex-team.ru>
Date: Fri, 13 Feb 2026 11:13:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Never drop BLOCK_IO_ERROR with action=stop for
 rate limiting
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, xeor@yandex-team.ru, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20260212212738.141780-1-kwolf@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260212212738.141780-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 13.02.26 00:27, Kevin Wolf wrote:
> Commit 2155d2dd introduced rate limiting for BLOCK_IO_ERROR to emit an
> event only once a second. This makes sense for cases in which the guest
> keeps running and can submit more requests that would possibly also fail
> because there is a problem with the backend.
> 
> However, if the error policy is configured so that the VM is stopped on
> errors, this is both unnecessary because stopping the VM means that the
> guest can't issue more requests and in fact harmful because stopping the
> VM is an important state change that management tools need to keep track
> of even if it happens more than once in a given second. If an event is
> dropped, the management tool would see a VM randomly going to paused
> state without an associated error, so it has a hard time deciding how to
> handle the situation.
> 
> This patch disables rate limiting for action=stop by essentially
> considering all BLOCK_IO_ERRORs with action=stop different errors. If
> the error is reported to the guest or ignored, the rate limiting stays
> in place.
> 
> Fixes: 2155d2dd7f73 ('block-backend: per-device throttling of BLOCK_IO_ERROR reports')
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

