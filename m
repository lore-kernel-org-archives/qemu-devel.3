Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD7BC021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiDoI-0007Vr-Nm; Wed, 12 Feb 2025 09:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tiDoG-0007VT-7w; Wed, 12 Feb 2025 09:33:53 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tiDoA-0006ex-7i; Wed, 12 Feb 2025 09:33:51 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:3e09:0:640:a98e:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id DE1FD60CCC;
 Wed, 12 Feb 2025 17:33:33 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b51c::1:4] (unknown
 [2a02:6b8:b081:b51c::1:4])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id WXQ6K90IcuQ0-jWHGVEY2; Wed, 12 Feb 2025 17:33:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1739370813;
 bh=F6hESNbhgqv9NUwZsDo3ni2rmZBMtUl0e2FHKsqRwdY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=KrKERp8eplJltQAoxC8JaB4qc9FudZ0nJ0rjZQ2T5TfalhPAaMxPBxoPaLgYA+Hxy
 sLk72fIBxLtPBzBE8fHEJGANwYPMLhYhGuj53FwNBWVrJTPVxpsW0yGHuzSyfl19Ei
 GMZvZsfCE84d1QIHMBn3rcsrVgOROfZudW/CZ4Jk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <48a28d16-e20d-4328-bf4a-84dd7d23ee88@yandex-team.ru>
Date: Wed, 12 Feb 2025 17:33:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nbd/server: Allow users to adjust handshake limit in
 QMP
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, devel@lists.libvirt.org
References: <20250203222722.650694-4-eblake@redhat.com>
 <20250203222722.650694-6-eblake@redhat.com>
 <d1171e97-eac6-4b9c-81cd-43dbb3777911@yandex-team.ru>
 <nqkksqej7hazlphlzzj7bjkoed2xxcjxqjdk7s42tjylhvojgr@mbyy5twhm6zl>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <nqkksqej7hazlphlzzj7bjkoed2xxcjxqjdk7s42tjylhvojgr@mbyy5twhm6zl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 11.02.25 00:46, Eric Blake wrote:
> On Thu, Feb 06, 2025 at 10:20:09AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> ---
>>>    qapi/block-export.json         | 10 ++++++++++
>>>    include/block/nbd.h            |  6 +++---
>>
>> [..]
>>
>>> @@ -52,6 +57,10 @@
>>>    #
>>>    # @addr: Address on which to listen.
>>>    #
>>> +# @handshake-max-secs: Time limit, in seconds, at which a client that
>>> +#     has not completed the negotiation handshake will be disconnected,
>>> +#     or 0 for no limit (since 10.0; default: 10).
>>> +#
>>
>> Hmm. [not about the series], shouldn't we finally deprecate older interface?
> 
> By older interface, you are asking about the QMP command
> 'nbd-server-start' as compared to struct NbdServerOptions.  But the
> struct is not directly present in any QMP commands; rather, it only
> appears to be used by qemu-storage-daemon as one of its command line
> options that needs to set up an NBD server with a JSON-like syntax
> that has less nesting than QMP nbd-server-start.  blockdev-nbd.c has
> two functions [nbd_server_start_options(NbdServerOPtions *arg...)  and
> qmp_nbd_server_start(args...)] that both unpack their slightly
> different forms and pass them as parameters to nbd_server_start() that
> is then agnostic to whether the older QMP command or newer q-s-d CLI
> option was specified.
> 
> It looks like libvirt is still using QMP nbd-server-start.  If we were
> to start the deprecation process for qemu 10.0, what would the new
> command look like?  What would everyone be required to use by qemu
> 10.2?
> 

Oh you are right, I was inattentive.

So, probably thing to be deprecated is actually SocketAddressLegacy, which is the only difference.

And why just not move common part of the structures to common base? I'll send a patch with a try.

-- 
Best regards,
Vladimir


