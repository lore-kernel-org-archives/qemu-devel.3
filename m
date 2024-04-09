Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427DCC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 06:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru4jp-0005RQ-73; Tue, 09 Apr 2024 02:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ru4jm-0005PU-4C; Tue, 09 Apr 2024 02:13:42 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ru4jj-0002XZ-6A; Tue, 09 Apr 2024 02:13:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:486:0:640:cf34:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 276A060B8A;
 Tue,  9 Apr 2024 09:13:33 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b66e::1:3c] (unknown
 [2a02:6b8:b081:b66e::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id WDShuX1Ij8c0-Ra0SJLgy; Tue, 09 Apr 2024 09:13:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1712643212;
 bh=Vu8GZVYONaRGQ4aI6GMYYZYqVV8sQjLoiudcUc8U+cM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QmKzPbGmsWYZ/WTC/IYoKvEpPEQ9zyOpDUFhfylVFgiWhK15ozWb7KivZdirWPPQA
 BWwFOGz54yQCbR8WhZGFSiHSWv/Bna6Ft81R7oHjQ6smN53LPcx46cUQ7ECbGuiadn
 DqYE/MEFFEvhOYTckIybRWzPKE2FggllSmDcvN5U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <779cd7c0-2213-4bb4-a3fd-c35f3e6037cd@yandex-team.ru>
Date: Tue, 9 Apr 2024 09:13:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] nbd/server: do not poll within a coroutine context
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Zhu Yangyang <zhuyangyang14@huawei.com>
References: <20240408160214.1200629-4-eblake@redhat.com>
 <20240408160214.1200629-5-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240408160214.1200629-5-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
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

On 08.04.24 19:00, Eric Blake wrote:
> From: Zhu Yangyang<zhuyangyang14@huawei.com>
> 
> Coroutines are not supposed to block. Instead, they should yield.
> 
> The client performs TLS upgrade outside of an AIOContext, during
> synchronous handshake; this still requires g_main_loop.  But the
> server responds to TLS upgrade inside a coroutine, so a nested
> g_main_loop is wrong.  Since the two callbacks no longer share more
> than the setting of data.complete and data.error, it's just as easy to
> use static helpers instead of trying to share a common code path.  It
> is also possible to add assertions that no other code is interfering
> with the eventual path to qio reaching the callback, whether or not it
> required a yield or main loop.
> 
> Fixes: f95910f ("nbd: implement TLS support in the protocol negotiation")
> Signed-off-by: Zhu Yangyang<zhuyangyang14@huawei.com>
> [eblake: move callbacks to their use point, add assertions]
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


