Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33EFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 08:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4amv-0003pX-SW; Fri, 03 Oct 2025 04:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v4amt-0003os-TF; Fri, 03 Oct 2025 04:05:11 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v4ami-00068R-0q; Fri, 03 Oct 2025 04:05:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:8982:0:640:5cf4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E3AC2C015E;
 Fri, 03 Oct 2025 11:04:39 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:589::1:33] (unknown
 [2a02:6bf:8080:589::1:33])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id d4cWxL2GwuQ0-1MuJOunD; Fri, 03 Oct 2025 11:04:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1759478679;
 bh=LWvElokDLunhqOYyBU/7ts/qLv6wOT/GiGu+Zck0Rkw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=z+bfkB+M4nisdFWpy9oRkGtP63dORIPNIZbwDmXy1r/rgWZNyg/xjG+AmuVen6jS5
 tJMoeeNfM6rU5iPz6YnXWelfC7fqOSrLM6Lq658uwkoidqjYWePkGy/vliylTbM8hN
 OU6mpHR5kRTN8AMFV3CTqRI3KszIcg8UZNNgTvCc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f4aa2d8a-0bc4-476e-aee0-0770a4bbd396@yandex-team.ru>
Date: Fri, 3 Oct 2025 11:04:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] file-posix: populate pwrite_zeroes_alignment
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Jean-Louis Dupond <jean-louis@dupond.be>, Hanna Reitz <hreitz@redhat.com>
References: <20251002184000.410486-1-stefanha@redhat.com>
 <20251002184000.410486-2-stefanha@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251002184000.410486-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 02.10.25 21:39, Stefan Hajnoczi wrote:
> Linux block devices require write zeroes alignment whereas files do not.
> 
> It may come as a surprise that block devices opened in buffered I/O mode
> require the alignment although regular read/write requests do not.
> 
> Therefore it is necessary to populate the pwrite_zeroes_alignment field.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   block/file-posix.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 8c738674ce..05c92c824d 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1602,6 +1602,23 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
>   
>               bs->bl.pdiscard_alignment = dalign;
>           }
> +
> +#ifdef __linux__
> +        /*
> +         * When request_alignment > 1, pwrite_zeroes_alignment does not need to
> +         * be set explicitly. When request_alignment == 1, it must be set
> +         * explicitly because Linux requires logical block size alignment.
> +         */
> +        if (bs->bl.request_alignment == 1) {

would "if (!s->needs_alignment) {" be a more visual check? This way reader will not have to analyze
raw_probe_alignment, and understand that needs_alignment=false is the only path for block device
to have request_alignment==1.

> +            ret = probe_logical_blocksize(s->fd,
> +                                          &bs->bl.pwrite_zeroes_alignment);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret,
> +                                 "Failed to probe logical block size");
> +                return;
> +            }
> +        }
> +#endif /* __linux__ */
>       }
>   
>       raw_refresh_zoned_limits(bs, &st, errp);


-- 
Best regards,
Vladimir

