Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6181FCD1288
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 08:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq7Vf-00055a-Mc; Fri, 29 Mar 2024 04:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rq7Vd-00054c-MS; Fri, 29 Mar 2024 04:22:45 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rq7Va-0004P5-1l; Fri, 29 Mar 2024 04:22:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:400c:0:640:9907:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A21FA60A96;
 Fri, 29 Mar 2024 11:22:34 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6509::1:4] (unknown
 [2a02:6b8:b081:6509::1:4])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VMJN0c26XKo0-iJ2yZBUH; Fri, 29 Mar 2024 11:22:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711700554;
 bh=1lk0ZJkIPzg5XHl/qgfXaG7vrWBCpJHKO/3RGbjPlQY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=09XqntTJ+A0OCOw/4FG46kn+nxxF9HrZKvJvjDfpuIseOTt3Lw0oWQ4YISi0Ry2G7
 N3hlRudutx322qUFSgjKf/e5GnYVL3e86xR1kSIUowVa9WVjFz2oRu1RCYJWc1SPyy
 fKEQ0vQnSTJMee/S4Fl+tdLLVcToBZNPbcyyQdo4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ececa74a-f9d4-44f8-85fb-3f25944ebf6a@yandex-team.ru>
Date: Fri, 29 Mar 2024 11:22:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/19] block/mirror: fix -Werror=maybe-uninitialized
 false-positive
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, John Snow <jsnow@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-6-marcandre.lureau@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240328102052.3499331-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 28.03.24 13:20, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ../block/mirror.c:1066:22: error: ‘iostatus’ may be used uninitialized [-Werror=maybe-uninitialized]

Actually that's a false-positive.. Compiler can't believe that body of WITH_JOB_LOCK_GUARD() will be executed unconditionally. Probably we should mention this in a comment.

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> ---
>   block/mirror.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 1bdce3b657..53dd7332ee 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -926,7 +926,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
>       MirrorBDSOpaque *mirror_top_opaque = s->mirror_top_bs->opaque;
>       BlockDriverState *target_bs = blk_bs(s->target);
>       bool need_drain = true;
> -    BlockDeviceIoStatus iostatus;
> +    BlockDeviceIoStatus iostatus = BLOCK_DEVICE_IO_STATUS__MAX;
>       int64_t length;
>       int64_t target_length;
>       BlockDriverInfo bdi;

-- 
Best regards,
Vladimir


