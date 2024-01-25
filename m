Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37A8C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2sj-0003GI-KR; Thu, 25 Jan 2024 11:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rT2s6-0003By-Ba; Thu, 25 Jan 2024 11:46:58 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rT2s2-00064J-2c; Thu, 25 Jan 2024 11:46:32 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a595:0:640:6c6f:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 530F561057;
 Thu, 25 Jan 2024 19:46:20 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b678::1:5] (unknown
 [2a02:6b8:b081:b678::1:5])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id JkXucL1IXSw0-8RuasQY8; Thu, 25 Jan 2024 19:46:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1706201179;
 bh=C1Stoek2lRUPClw4Zanbr8OC1702zyA2JTfRBPaOYn8=;
 h=In-Reply-To:Cc:References:To:From:Subject:Date:Message-ID;
 b=u1rlLSQVvAAyS8bPVZYfqu025E4jqbboQKCG4iDjNRHJP0ROW7ZCrk4MhbQZgE2sj
 +blSHxlfTA5MjKNWkKoFsBpLJHM73hIRRa0KmLr+AFgRVYuekTf/PNGmH+0WBucJxE
 PabOGMOIV0fxPS2z0TASVDgXGgkfGNtLfPS8OhLY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6620975c-c962-4aff-9592-bb0ccad6c307@yandex-team.ru>
Date: Thu, 25 Jan 2024 19:46:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: allocate aligned write buffer for 'truncate -m
 full'
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 den@virtuozzo.com
References: <20231211105559.316897-1-andrey.drobyshev@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231211105559.316897-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11.12.23 13:55, Andrey Drobyshev wrote:
> In case we're truncating an image opened with O_DIRECT, we might get
> -EINVAL on write with unaligned buffer.  In particular, when running
> iotests/298 with '-nocache' we get:
> 
> qemu-io: Failed to resize underlying file: Could not write zeros for
> preallocation: Invalid argument
> 
> Let's just allocate the buffer using qemu_blockalign0() instead.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

I also suggest to use QEMU_AUTO_VFREE (keep my r-b if you do).

> ---
>   block/file-posix.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index b862406c71..cee8de510b 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2354,7 +2354,7 @@ static int handle_aiocb_truncate(void *opaque)
>               goto out;
>           }
>   
> -        buf = g_malloc0(65536);
> +        buf = qemu_blockalign0(aiocb->bs, 65536);
>   
>           seek_result = lseek(fd, current_length, SEEK_SET);
>           if (seek_result < 0) {
> @@ -2413,7 +2413,7 @@ out:
>           }
>       }
>   
> -    g_free(buf);
> +    qemu_vfree(buf);
>       return result;
>   }
>   

-- 
Best regards,
Vladimir


