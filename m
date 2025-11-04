Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6304ECCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 11:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGFT8-0000Kr-2C; Tue, 04 Nov 2025 06:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGFT6-0000Kb-2S
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 06:44:56 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGFT4-0003yR-Cb
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 06:44:55 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1B7E380C83;
 Tue, 04 Nov 2025 14:44:51 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:95c::1:2] (unknown [2a02:6bf:8080:95c::1:2])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id niiaVe1GseA0-ZVKEhT12; Tue, 04 Nov 2025 14:44:50 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762256690;
 bh=ExouIuQACFu5zuc7VO47RUHb2vxQtEfQ/0PO46HHFps=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=yS1AIMNmEELjcS94FIkpZO+oBXS3CYCoB+O7LrVRdYEChJ9zSRkUSzJtkOYZsDx4u
 18pt9D68kktSrTAHgsTLrPUpkbzjETQO69C2+OUTlk7QnRLmV8QlWZIY79s4ATrsdG
 2su+F3ZNLEU+I1VUBSRCIKJgUv1UkGXOO7NabVHM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <966c338b-8302-4583-be9b-bb683ce3f3c5@yandex-team.ru>
Date: Tue, 4 Nov 2025 14:44:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] chardev: postpone connect
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: pbonzini@redhat.com, eduardo@habkost.net, qemu-devel@nongnu.org,
 raphael@enfabrica.net, armbru@redhat.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
References: <20251104101715.76691-1-vsementsov@yandex-team.ru>
 <CAMxuvazmJ+0fUDae-W4ZFFKAgtZLBFrxtZCrTT8sgBCmNirW2g@mail.gmail.com>
 <aQnmW2NskQtEfsGe@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aQnmW2NskQtEfsGe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 04.11.25 14:41, Daniel P. Berrangé wrote:
> On Tue, Nov 04, 2025 at 03:35:17PM +0400, Marc-André Lureau wrote:
>> Hi Vladimir
>>
>> On Tue, Nov 4, 2025 at 2:17 PM Vladimir Sementsov-Ogievskiy <
>> vsementsov@yandex-team.ru> wrote:
>>
>>> Hi all!
>>>
>>> That's a preparation for backend-transfer migration of
>>> vhost-user-blk, and introduced DEFINE_PROP_CHR_NO_CONNECT()
>>> is unused now.
>>>
>>> v3 of "vhost-user-blk: live-backend local migration" is coming
>>> soon, and will be based on this series (and will use
>>> DEFINE_PROP_CHR_NO_CONNECT of course).
>>>
>>> changes in v6:
>>> 05: move connect() call into "if (s)"
>>> 07: - drop assertion
>>>      - improve doc comment, to cover @s==NULL relations with @connect
>>>      - add r-b by Marc-André
>>>
>>> Vladimir Sementsov-Ogievskiy (7):
>>>    chardev/char-socket: simplify reconnect-ms handling
>>>    chardev/char: split chardev_init_common() out of qemu_char_open()
>>>    chardev/char: qemu_char_open(): add return value
>>>    chardev/char: move filename and be_opened handling to qemu_char_open()
>>>    chardev/char: introduce .init() + .connect() initialization interface
>>>    chardev/char-socket: move to .init + .connect api
>>>    chardev: introduce DEFINE_PROP_CHR_NO_CONNECT
>>>
>>
>> Do you need this series in 10.2? We are at soft-freeze today, this is
>> closer to a feature than a simple refactoring, we may just wait for the
>> next dev phase.
> 
> Back in v2, I had a request to convert the other chardev backends
> to the new model too, as IMHO it is undesirable to introduce the
> technical debt by only touching 1 backend:
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg03272.html
> 

Right. I remember it, and have a draft converting series. It turned out to be more than expected,
about 24 commits, and personally I'm not sure, that it worth doing.. I'll send an RFC too look at.

-- 
Best regards,
Vladimir

