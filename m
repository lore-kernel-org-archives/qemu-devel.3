Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E42BCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArWV-000487-1X; Mon, 20 Oct 2025 11:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vArWS-00045i-0J
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:10:08 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vArWP-0007WS-Mq
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:10:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 55A1B82920;
 Mon, 20 Oct 2025 18:10:02 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a51::1:37] (unknown
 [2a02:6bf:8080:a51::1:37])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1AXOnM4F4Cg0-s1JpnJMs; Mon, 20 Oct 2025 18:10:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760973001;
 bh=lA3KtcClbRPBwyo2hNufie359p2TRtHOAVxJQBlhefA=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=bRtJw/HHg8Mplr2d2POYHr/XkbhFb5jqDPUHFl2/ysqfqnXq6HGlZ97EDJoBeHbll
 5hRwJu5QG3DiQN7hf66Vm3U+rMAQEUJB+4KQvRjSDRhuVgEOVWcJxvrsOYQND12pC9
 P9ku93AEGjoszWbByzUHi1nyS1GhPQ48NTpWgLGI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <31b99516-8eb2-4fa1-96e0-583055a90093@yandex-team.ru>
Date: Mon, 20 Oct 2025 18:10:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: vmsd errp handlers: return bool
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>
Cc: peterx@redhat.com, stefanb@linux.vnet.ibm.com, farosas@suse.de,
 qemu-devel@nongnu.org
References: <20251020091907.2173711-1-vsementsov@yandex-team.ru>
 <87347d7s0j.fsf@pond.sub.org>
 <0ce2f913-36c2-44a2-8141-256ff847529d@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <0ce2f913-36c2-44a2-8141-256ff847529d@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 20.10.25 14:22, Vladimir Sementsov-Ogievskiy wrote:
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index d798faeec3..1c2484187f 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -43,8 +43,7 @@
>    *   avoid useless error object creation and destruction.  Note that
>    *   we still have many functions returning void.  We recommend
>    *   • bool-valued functions return true on success / false on failure,
> - *   • pointer-valued functions return non-null / null pointer, and
> - *   • integer-valued functions return non-negative / negative.
> + *   • pointer-valued functions return non-null / null pointer.
>    *
>    * = Creating errors =
>    *
> 

Still, we have functions that may return positive numbers, like
numbers of bytes read. So integer return value makes sense, and
removing this recommendation for integer-valued functions is wrong.

May be adding some additional advice like:

Don't blindly passthorough the -errno together with errp, if you
don't sure it is reasonably used. Prefer boolean for functions
which doesn't need to return some positive integer on success.
Prefer the only -1 error value for integer-valued functions, if
you don't need more different errors.

-- 
Best regards,
Vladimir

