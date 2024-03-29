Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4498EC6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 08:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq7gl-0007Oe-4H; Fri, 29 Mar 2024 04:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rq7gj-0007O9-Jr; Fri, 29 Mar 2024 04:34:13 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rq7gg-0006lV-0S; Fri, 29 Mar 2024 04:34:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:400c:0:640:9907:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D1CF360A5B;
 Fri, 29 Mar 2024 11:34:03 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6509::1:4] (unknown
 [2a02:6b8:b081:6509::1:4])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2YJLCc26N0U0-hvutITkM; Fri, 29 Mar 2024 11:34:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711701243;
 bh=7TuXW5rwLa9KtG3RwG0BRbFMhgh3OsWpTgPGHsPSh7o=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=mAromOqjBj72zKaJFsZcCCGMrhsP9c1+bG6dhy6L9B8VTcBH5fujvzb/MrpfCPoax
 PIfsaAAFS4YFIbxHbBY7ytx+OCqK0+KCS9mIK6ZIuer04bfGSxDNaW1k6MeK5fhTW6
 ehK6BYQWBcp7FxHVX1LeNbukA68pYsrkFeeV/QZE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <65d791e4-6c68-4b6d-b181-bc3886745ce3@yandex-team.ru>
Date: Fri, 29 Mar 2024 11:34:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] block/stream: fix -Werror=maybe-uninitialized
 false-positives
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
 <20240328102052.3499331-7-marcandre.lureau@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240328102052.3499331-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
> ../block/stream.c:193:19: error: ‘unfiltered_bs’ may be used uninitialized [-Werror=maybe-uninitialized]
> ../block/stream.c:176:5: error: ‘len’ may be used uninitialized [-Werror=maybe-uninitialized]
> trace/trace-block.h:906:9: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Again, same false-positives, because of WITH_GRAPH_RDLOCK_GUARD()..

Didn't you try to change WITH_ macros somehow, so that compiler believe in our good intentions?

Actually, "unused variable initialization" is bad thing too.

Anyway, if no better solution for now:
Acked-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> ---
>   block/stream.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index 7031eef12b..9076203193 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -155,8 +155,8 @@ static void stream_clean(Job *job)
>   static int coroutine_fn stream_run(Job *job, Error **errp)
>   {
>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
> -    BlockDriverState *unfiltered_bs;
> -    int64_t len;
> +    BlockDriverState *unfiltered_bs = NULL;
> +    int64_t len = -1;
>       int64_t offset = 0;
>       int error = 0;
>       int64_t n = 0; /* bytes */
> @@ -177,7 +177,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>   
>       for ( ; offset < len; offset += n) {
>           bool copy;
> -        int ret;
> +        int ret = -1;
>   
>           /* Note that even when no rate limit is applied we need to yield
>            * with no pending I/O here so that bdrv_drain_all() returns.

-- 
Best regards,
Vladimir


