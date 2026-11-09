Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9EF606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex-team.ru header.i=@yandex-team.ru header.a=rsa-sha256 header.s=default header.b=Ae36NRz2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQIj6-0001LI-BY; Mon, 09 Nov 2026 01:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1xQIj4-0001LA-S4
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 01:19:30 -0500
Received: from forwardcorp1e.mail.yandex.net ([2a02:6b8:c32:0:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1xQIj2-0002E0-KC
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 01:19:30 -0500
Received: from mail-nwsmtp-smtp-corp-main-37
 (mail-nwsmtp-smtp-corp-main-37.yp-c.yandex.net)
 by forwardcorp1e.mail.yandex.net (postfix) with ESMTPS id BC4641002FD;
 Mon, 09 Nov 2026 09:19:21 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:3fb6:d465:7a94:f06d]
 by mail-nwsmtp-smtp-corp-main-37 with ESMTPSA id KJK6tD4iRKo0-eIgf5NK6;
 Mon, 09 Nov 2026 09:19:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1794205161;
 bh=zHnKZHdyXrCQ+7iS3xUf5eqYCLM0bh0cjgBZWtGRFc8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Ae36NRz2/bwsEHtEleaQIL61kB3Y4jxh4W1KR67lSDdIDDKFC18wYduQhdQSS3ZoQ
 PAfeLo8A+7+Va48+MAG/bKEAh9RlrN7Hr5hk3l0bBAdW2mRPtwY3Gskq+3EV8WVlw6
 3+2d9Q0lwYcWaa3jHPoCheiV6eVFDUochLPfwuX8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-37;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6e857bd1-d68f-4e2c-9a7f-313fccca9c5b@yandex-team.ru>
Date: Mon, 9 Nov 2026 11:19:32 +0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] backends/vhost-user: fix memory leak when
 vhost_dev_init() fails
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261105162443.232929-1-sgarzare@redhat.com>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <20261105162443.232929-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c32:0:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1e.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/5/26 21:24, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
>
> vhost_dev_init() clears the struct vhost_dev in the error path calling
> vhost_dev_cleanup(). So, to prevent memory leaks, we need to keep a
> local reference to the vhost_virtqueue array and deallocate it in case
> of failure, just as most other callers of vhost_dev_init() do.
>
> Discovered while reviewing a patch by Alexandr Moshkov fixing the
> same issue in vhost-user-fs.
>
> Fixes: f24bb7287ddb ("Add vhost-user-backend")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---

Reviewed-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>


Best regards,

Alexandr


