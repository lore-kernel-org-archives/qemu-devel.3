Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC64CAC589
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 08:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvtT9-0002pn-I4; Tue, 09 Sep 2025 04:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvtT2-0002ec-Na; Tue, 09 Sep 2025 04:12:45 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvtSt-0007zH-K7; Tue, 09 Sep 2025 04:12:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 2BD43C015E;
 Tue, 09 Sep 2025 11:12:26 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b64::1:1] (unknown [2a02:6bf:8080:b64::1:1])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id PCEAiP2GpW20-f1ROJSAF; Tue, 09 Sep 2025 11:12:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757405545;
 bh=GssSMoemrDhLNPsPgYDbYiRNgmKnrSMA4AiCNXG825M=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=YvuXuFo+Kyycxxn+BVCKCIXfDsXfBEGyEQGmQ0aaK10+E9pVoSF2fIRXe3KolT78p
 t+SA/zGTmPPPPfHnyMrIr1a5RaxIglhoHgNqoH8HUIDmu4VlEWqbABtApJDnsEZRHJ
 9ljKrspGcVC99bUP9jdG3bI4bKNRuGhokF+0q9JU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2a5b37b9-6bb2-460e-b9b3-0a3505f132c4@yandex-team.ru>
Date: Tue, 9 Sep 2025 11:12:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] io: deal with blocking/non-blocking fds
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 03.09.25 12:44, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> The series brings two things:
> 
> 1. unify code which sets fds blocking/non-blocking through the whole
> source
> 
> 2. for fds, which comes from qio_channel_readv_full(), stop making
> them blocking in generic code, and move this logic to the callers,
> all except coming from migration qemu-file (see last patch)

Oops, I found commit

commit ff5927baa7ffb9c97873a071f6a8d85a3584182b

     util: rename qemu_*block() socket functions

     The qemu_*block() functions are meant to be be used with sockets (the
     win32 implementation expects SOCKET)

     Over time, those functions where used with Win32 SOCKET or
     file-descriptors interchangeably. But for portability, they must only be
     used with socket-like file-descriptors. FDs can use
     g_unix_set_fd_nonblocking() instead.

     Rename the functions with "socket" in the name to prevent bad usages.

     This is effectively reverting commit f9e8cacc5557e43 ("oslib-posix:
     rename socket_set_nonblock() to qemu_set_nonblock()").


, which I effectively revert with these series..

Marc-André, Stefan could you take a look at my series?

I'm sure, that it's good to have one good interface, with errp and error
checking, instead of bucket of different functions, and making Error by
hand in many cases.

Except for the logic with files vs sockets, mentioned in the old commit.
Still, does it really make sense? It seems good to have a wrapper for
g_unix_set_fd_nonblocking() callded on FDs too..

So, formally, on top of my series I may add

bool qemu_socket_set_blocking(int fd, bool block, Error **errp)
{
    return qemu_set_blocking(fd, block errp);
}

and use it where _socket_ functions were used.

But that will not prevent someone in future to use qemu_set_blocking(), where
qemu_socket_set_blocking() should be used. No sense in it..

I think, in Windows, if we try to make non-socket to be non-blocking, we should get
a meaningful error, do we?

-- 
Best regards,
Vladimir

