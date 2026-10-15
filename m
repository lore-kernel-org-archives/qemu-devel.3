Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED4ECC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGxZ-0000Ek-05; Thu, 15 Oct 2026 04:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHGxP-00009x-0O; Thu, 15 Oct 2026 04:36:59 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHGxN-0008Ky-GB; Thu, 15 Oct 2026 04:36:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bd2d:0:640:e9de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 35EDC81029;
 Thu, 15 Oct 2026 11:36:54 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d5a::1:34] (unknown
 [2a02:6bf:8080:d5a::1:34])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id raQXVJ2ZQW20-Gq8nKBi9; Thu, 15 Oct 2026 11:36:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1792053413;
 bh=KHTEPFmiEwQ0yQsrs6tGyYV+2aoH9M4EgoCDXN68RFc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=qww3J+x4V177Stj0VqyiRahDODtX9UNaD517SbLY5MgclQexNL6n2vgDPahHwzqPG
 TWXxZuE13QkwHM2cUXySEXsvARnp9oLXyFPmtPbXv4kYJTnEZWPEQWvPxrFEjqY5qW
 ABPAFJiFWBced81hgX3pbMSxLHTkHeykqUWgBzYY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <45219cf8-9f77-4f31-802e-f9f95e722b05@yandex-team.ru>
Date: Thu, 15 Oct 2026 11:36:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] block/commit: batch block-status queries
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, 
 John Snow <jsnow@redhat.com>
References: <20260929155125.3151111-1-den@openvz.org>
 <20260929155125.3151111-4-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260929155125.3151111-4-den@openvz.org>
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

On 29.09.26 18:51, Denis V. Lunev wrote:
> From: Denis V. Lunev<den@openvz.org>
> 
> commit_iteration() asks for block status COMMIT_BUFFER_SIZE (512K) at a
> time, so a long run above base pays one query per 512K for an answer
> the whole run shares.
> 
> Query the remainder of the image instead and keep the answer in a
> CommitStatus owned by commit_run(). No device or export writes top
> above base_overlay while the job runs: they ask for
> BLK_PERM_CONSISTENT_READ along with BLK_PERM_WRITE, and the job
> withholds CONSISTENT_READ there, having to share WRITE or it would
> block its own writes to base through the backing chain. A job target
> asks for WRITE alone and is refused by the op blocker instead. From
> filtered_base downwards CONSISTENT_READ is shared again, and there only
> the job writes.
> 
> Copying is still bounded by the read buffer. Zeroes need no buffer, so
> COMMIT_ZERO_CHUNK bounds them, keeping a cancel from waiting on a huge
> write-zeroes, and an unallocated span is crossed in one step.
> 
> Reviewed-by: Andrey Drobyshev<andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> CC: John Snow<jsnow@redhat.com>
> CC: Andrey Drobyshev<andrey.drobyshev@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

