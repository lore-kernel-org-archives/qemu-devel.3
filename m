Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DC9CA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk6c-0006J8-I1; Wed, 03 Sep 2025 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk6a-0006Db-Mq; Wed, 03 Sep 2025 05:48:40 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk6Y-0000zQ-R3; Wed, 03 Sep 2025 05:48:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1458780782;
 Wed, 03 Sep 2025 12:48:37 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8f::1:11] (unknown
 [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id amcqsq3Gk8c0-V24V4yl0; Wed, 03 Sep 2025 12:48:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756892916;
 bh=YMa/x0ridEfQ5FbHXvxzJ9Rfar15+QUx0etXY3CGblQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=HZmxDKzpUho7cK7OfAw6bXiOt6bICjv3ip0ZXWPFcfF6pkNWN4Fpb8/8kiDR8pxbC
 sQea4a2UbWiQY3B4w2MjNhzUbY0mghr0xYu0Bbn9LrRobs492TTqvdqSEAV8+5Y9p8
 pGjR/ds5FSgwgPLPd3b3g+41aIh8qQ2yLr60UZ4Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4f81e583-4da8-4921-9389-c05db9c99d65@yandex-team.ru>
Date: Wed, 3 Sep 2025 12:48:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] oslib-posix: add qemu_fds_set_blocking() helper
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-9-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250903094411.1029449-9-vsementsov@yandex-team.ru>
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

On 03.09.25 12:44, Vladimir Sementsov-Ogievskiy wrote:
> And use it in io/channel-socket.c. This simplifies the following
> commit, which will move this functionality from io/channel-socket.c
> to the callers.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   include/qemu/osdep.h |  7 +++++++
>   io/channel-socket.c  | 24 +++++++++++++-----------
>   util/oslib-posix.c   | 12 ++++++++++++
>   3 files changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 1b38cb7e45..dde98d588c 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -689,6 +689,13 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
>   void qemu_set_cloexec(int fd);
>   bool qemu_set_blocking(int fd, bool block, Error **errp);
>   
> +/*
> + * qemu_fds_set_blockinging:
> + * Call qemu_socket_set_block() on several fds.
> + * When @nfds = 0, does nothing, @fds is not touched.
> + */
> +bool qemu_fds_set_blockinging(int *fds, int nfds, bool block, Error **errp);

Oops. s/inging/ing/ is needed.



-- 
Best regards,
Vladimir

