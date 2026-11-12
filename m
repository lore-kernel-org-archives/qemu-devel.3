Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBECE606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 02:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=etWZxte2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRKE8-0008Rz-LP; Wed, 11 Nov 2026 21:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRKE6-0008RS-Mr; Wed, 11 Nov 2026 21:07:46 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRKE4-0007Jf-Gz; Wed, 11 Nov 2026 21:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794449259; bh=ZHtGG67infQL834TFCQVL6Mofmo8PfFy4mWrYfgAx/E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=etWZxte2L7Bms925EM5na3DQN2nc5yoowllBelxmrwp1qi0UP4SRy3m60ylUyZ7p5
 qvOZhTkFZYEX48ccgqqQ89s03AMgWJR9t1jmMM0OQdzzayWIsgQP1yVse91YzNeDRe
 g6R+pZ3uxY2lqU6hZthvouyMr87JzXjBcuqWVFR5GthOrX4z6j7eumTVTNeL8NKfYF
 e2uQWVsPMeEjpZN0ssWqlxMYLKt/qJHSwORcf/G+LBTXHOujPNpdSScIc8tc6YR1wA
 wNs0ECwGP5bdppV/+juOpOIItAE36GHsH6z+xXBsuKGg8PaajdQmgsWZ0TleH0yJfw
 vYgj+m29UL62Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C9BA01E58F7;
 Thu, 12 Nov 2026 05:07:39 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 92960459553;
 Thu, 12 Nov 2026 05:07:39 +0300 (MSK)
Message-ID: <5a08b9a9-4a45-4311-98ae-d1cb8c3618c5@tls.msk.ru>
Date: Thu, 12 Nov 2026 05:07:39 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH TRIVIAL] io: avoid potential double close of
 qio_channel_file's fd
To: Filip Hejsek <filip.hejsek@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
References: <20261012-fix-double-close-v1-1-d37f2224dcb0@gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261012-fix-double-close-v1-1-d37f2224dcb0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/12/26 20:38, Filip Hejsek wrote:
> Make qio_channel_file_close() set fd to -1 even if qemu_close() returns
> an error so that qio_channel_file_finalize() doesn't call close again.
> 
> On Linux, close() always closes the fd, even when it returns an error.
> Because the fd can be reused after it is closed, the close must not
> be retried.
> 
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
>   io/channel-file.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/io/channel-file.c b/io/channel-file.c
> index 5cef75a67c..afc9640518 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -255,12 +255,18 @@ static int qio_channel_file_close(QIOChannel *ioc,
>   {
>       QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
>   
> -    if (qemu_close(fioc->fd) < 0) {
> +    int ret = qemu_close(fioc->fd);
> +    /*
> +     * The fd should now have been closed even if we got an error. There are
> +     * obscure systems where this isn't always the case, but an fd leak on
> +     * obscure systems is less bad than double close on common systems.
> +     */

Hmm.  It looks like linux is the obscure system now, not the other way
around.  Before, POSIX.1-2008 stated that after EINTR, the state of the
FD is unspecified.  However, POSIX.1-2024 states that after EINTR, the
FD should remain open.  And linux isn't going to change the way close(2)
works there.

And there's no posix_close(fd, flags).  Which is not available on linux
(yet).

And there's also an additional possible errno value here: EINPROGRESS.

The other possible failure cases seems to be consistent.

So at least, it looks like, the comment needs to be updated.  Yes,
linux is the main target of qemu, but not only, -- and channel-file is
used in the tools too (qemu-nbd, qemu-img, etc) - where it is rather
irrelevant - keep it open or close it again later.

Why do we care about this close(2) return value here anyway?
Have you seen actual failure case?

Thanks,

/mjt

