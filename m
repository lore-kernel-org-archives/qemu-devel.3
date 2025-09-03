Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9997CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utiB6-0000xx-5O; Wed, 03 Sep 2025 03:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utiB4-0000xY-IA
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:45:10 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utiB2-0000ST-8Z
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:45:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2511C8046D;
 Wed, 03 Sep 2025 10:45:03 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8f::1:11] (unknown
 [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2jaZio3Gh8c0-eXUQFCiK; Wed, 03 Sep 2025 10:45:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756885502;
 bh=IzU7kfqbOHF58uCS8nJjBOGKtor+r/ut3M21WS2RgTc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=WBct9oEImVta+gGqu++Ug7crLXpYbOHLYP5766viF3rlzTk15Ia0Xri7PF1c1rAjt
 df9wlg0XWHpyk5kDLWSCfvsHQFMAHk3d8OeRJk5yLpHmGp/0BiA2FbWpAf2aAQaqWm
 UILphMnOZVKLyCyeoktcgieY9+TT3poeycBSD96g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f4c2eddf-bdf3-4ccd-a094-9b4142a285e3@yandex-team.ru>
Date: Wed, 3 Sep 2025 10:45:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/20] net/tap: introduce net_tap_fd_init_external()
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
 <20250823160323.20811-17-vsementsov@yandex-team.ru>
 <CACGkMEsy9_nZYSrKf+uhbZfC3XPaVCE1iLUFfpiavNpi+sNi6A@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEsy9_nZYSrKf+uhbZfC3XPaVCE1iLUFfpiavNpi+sNi6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 03.09.25 08:37, Jason Wang wrote:
> On Sun, Aug 24, 2025 at 12:03 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Add helper that covers logic for initializing fds, given from monitor
>> or helper.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   net/tap.c | 90 ++++++++++++++++++++++---------------------------------
>>   1 file changed, 36 insertions(+), 54 deletions(-)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index 27642c45a9..8cea6ed87b 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -627,13 +627,40 @@ static bool set_fd_nonblocking(int fd, const char *note, Error **errp)
>>       return ok;
>>   }
>>
>> +static int net_tap_fd_init_external(const Netdev *netdev, NetClientState *peer,
>> +                                    const char *model, const char *name,
>> +                                    const char *vhostfdname,
>> +                                    int *pvnet_hdr, int fd, Error **errp)
> 
> Is net_tap_fd_init_mon() better?
> 

The function is shared between "monitor" case and "helper" case.

I just didn't look what "helper" actually do, and decided that fd comes from somewhere...

Now looking at code, I see that for helper we do fork(), and exec() the helper in child process, and then read
the fd in parent from preliminary created socket pair.

So I still think that "external" works good: either we get fd from monitor, or from third "helper" program.

-- 
Best regards,
Vladimir

