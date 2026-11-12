Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1369606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=GGOmEwkm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRs4-0001A1-Oj; Thu, 12 Nov 2026 05:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRRs3-000199-8U; Thu, 12 Nov 2026 05:17:31 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRRs0-0007Ph-LO; Thu, 12 Nov 2026 05:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794478635; bh=rB+6uiYcnxUm4GF7S83BebVS75MYqVWCfGNmiGUp11Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GGOmEwkmqnA8Nh3swf9Kb/TmJd3iqWDkrSeUCsvaywKVYahGyw8BAOU+aEezF5j9n
 LCtS8sDJP6EbJeCBMer7pc+I+PPT2dMEB7J3Qsjgh3WxCquj3ZPo3aK0Y40+4cFr0d
 bMWawgrAnEpVOXnV/uS0Iq8z+/6TlC0Xj298Fcbqm6vwHTepellmQKHl8okCrOMF/A
 pbnH6zwIJNOjyYm59/Yb9v+7BkaxP3NHoUiZ7K0izjWAldRl2lVa8PvSnmGYJ5ipHI
 ZQnRtUSNPhsrpfJUBvGnt1EaQBtT+hdtisIn/o87t/bYgmj/zxgNPfqGpaBkXzS5mh
 erl9kDycT5YTQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5367E1E5B15;
 Thu, 12 Nov 2026 13:17:15 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A791D45A77A;
 Thu, 12 Nov 2026 13:17:14 +0300 (MSK)
Message-ID: <997928c4-7854-4807-a942-7acf57ee48a7@tls.msk.ru>
Date: Thu, 12 Nov 2026 13:17:14 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH TRIVIAL] io: avoid potential double close of
 qio_channel_file's fd
To: Filip Hejsek <filip.hejsek@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
References: <20261012-fix-double-close-v1-1-d37f2224dcb0@gmail.com>
 <5a08b9a9-4a45-4311-98ae-d1cb8c3618c5@tls.msk.ru>
 <ad189334ed90d17253f9087a6fb89a9fdd20174a.camel@gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ad189334ed90d17253f9087a6fb89a9fdd20174a.camel@gmail.com>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 06:10, Filip Hejsek wrote:
> On Thu, 2026-11-12 at 05:07 +0300, Michael Tokarev wrote:

>> Hmm.  It looks like linux is the obscure system now, not the other way
>> around.  Before, POSIX.1-2008 stated that after EINTR, the state of the
>> FD is unspecified.  However, POSIX.1-2024 states that after EINTR, the
>> FD should remain open.  And linux isn't going to change the way close(2)
>> works there.
> 
> The system where close() may keep the fd open is HP-UX, which QEMU
> doesn't support. On Linux, macOS, Windows, and FreeBSD/NetBSD/OpenBSD,
> the fd is always closed. Of these, at least Linux can close the fd and
> return EINTR when the syscall is interrupted, in violation of POSIX.1-
> 2024.

Yes, I understand. Yet, POSIX standartized the HP-UX behavior, so all other
systems has become "obscure" this way.


>> Why do we care about this close(2) return value here anyway?
>> Have you seen actual failure case?
> 
> This was spotted while reading the code, so no failures observed. But
> the risk isn't an incorrect return value, it's about finalize()
> calling close() a second time. That applies to the tools as well.

I mean, this weren't a problem until now, for all the decades qemu exists.
Not a problem in practice, that is.

I understand what the problem we have.  And yes it is better to keep such
an FD "dangling" in case of close() returned error and haven't actually
closed the FD, than to close an innocent/reused FD.

> So what about changing the comment to this? I can send a v2 if we agree
> on wording.
> 
>    Set fioc->fd to -1, to prevent qio_channel_file_finalize() from
>    closing it again.
> 
>    POSIX.1-2024 specifies that the fd is closed even when close()
>    returns an error, except when the error is EINTR. The systems that
>    QEMU supports however violate the standard and always close the fd,
>    even when returning EINTR. If the fd was actually closed, we must not
>    try to close it a second time as we could accidentally close someone
>    else's fd.

Yes, let's pick this commit instead.  No need to re-send.

Thanks,

/mjt

