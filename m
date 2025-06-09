Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1772C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 14:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOdtI-0002kD-2n; Mon, 09 Jun 2025 10:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uOdtB-0002f9-7S; Mon, 09 Jun 2025 10:54:17 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uOdt9-0001Io-BC; Mon, 09 Jun 2025 10:54:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:420d:0:640:5081:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A7CB160C59;
 Mon,  9 Jun 2025 17:54:12 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a98::1:26] (unknown
 [2a02:6bf:8080:a98::1:26])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BsiJqb8FeSw0-pEPRwsfh; Mon, 09 Jun 2025 17:54:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1749480852;
 bh=bu6jNEulbQDrH3QWarSuvNJUnsma1lm/8d3PLsM5QwE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QQto5Hy/lFgY2nz0M1ALufn0+YaTGQ0BlVvpO1yQ7OLlI8JMLgsnTwVOLY/P170OD
 rBaufXUkeN63I18BLtF9Jt2y468NIP/dfAqOEmPaHWyI0NokMIm8Ak+kOrPgknoXde
 sVrr6ktrF6zmvmB3aU6QkaGdGFGJUIhkVIrZlmrU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0ead7bce-a0c5-46e3-864f-600284018604@yandex-team.ru>
Date: Mon, 9 Jun 2025 17:54:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hbitmap: introduce hbitmap_inverse()
To: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, eblake@redhat.com
Cc: qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
References: <20250528120732.2247150-1-andrey.zhadchenko@virtuozzo.com>
 <20250528120732.2247150-3-andrey.zhadchenko@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250528120732.2247150-3-andrey.zhadchenko@virtuozzo.com>
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

On 28.05.25 15:07, Andrey Zhadchenko wrote:
> and bdrv_dirty_bitmap_inverse() helper
> 
> Signed-off-by: Andrey Zhadchenko<andrey.zhadchenko@virtuozzo.com>

Please, also add a test into tests/unit/test-hbitmap.c for a new function.

-- 
Best regards,
Vladimir


