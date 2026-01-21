Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC29D262B0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 07:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viSHN-0000hl-T1; Wed, 21 Jan 2026 02:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1viSHH-0000c1-Ok; Wed, 21 Jan 2026 02:05:19 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1viSHF-0004sX-M5; Wed, 21 Jan 2026 02:05:19 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5a81:0:640:624e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C319880743;
 Wed, 21 Jan 2026 10:05:11 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:96e::1:11] (unknown
 [2a02:6bf:8080:96e::1:11])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id A5VsjA1CCGk0-vLjOZLfS; Wed, 21 Jan 2026 10:05:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768979111;
 bh=DG4j6bpf3a8+EEpLchFBsWUAWx4tVOoyrA9SV8/g49Q=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=bNTBjDCWbz0abA1GNX+227tTA9b/W6gHdxZLrFciygi4MmWrGCi9KOi8AYjBGdqNw
 VbNQBUNIQtuVaOiPVcq4uY20gT1A3MycQc7f0magFmlFCXC9/6onLl0syppPoPm4aL
 wsS3AJcSgX2u3AhmzoxHji38v5z8FKLsrLMwk8nQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <01ab664d-18f0-4d9e-af6b-9cf6570647d9@yandex-team.ru>
Date: Wed, 21 Jan 2026 10:05:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests: test active mirror with unaligned, small write
 zeroes op
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, eblake@redhat.com
References: <0e2a9f8d-c6f4-43dd-936d-4d977d427b96@yandex-team.ru>
 <20260120113859.251743-1-f.ebner@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260120113859.251743-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
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

On 20.01.26 14:38, Fiona Ebner wrote:
> This tests the scenario fixed by "block/mirror: check range
> when setting zero bitmap for sync write" [0].
> 
> [0]https://lore.kernel.org/qemu-devel/20260112152544.261923-1-f.ebner@proxmox.com/
> 
> Signed-off-by: Fiona Ebner<f.ebner@proxmox.com>

Thanks!

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

and queued.

-- 
Best regards,
Vladimir

