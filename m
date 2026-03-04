Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF88EFCE21
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpvO-0007zK-PA; Wed, 04 Mar 2026 12:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxpvM-0007z5-VZ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:22:17 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxpvK-0000vw-M5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:22:16 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4387C808B5;
 Wed, 04 Mar 2026 20:22:11 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:921::1:1b] (unknown
 [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AMsiR60AxuQ0-x3mbXFsv; Wed, 04 Mar 2026 20:22:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772644930;
 bh=dnYiuuig96vVoXVynQ4qWwoqoA7+oKMcE4+ksKfXsvE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=GlnqSC8IwEm8onqpI0O/8v9t2TC5nD/yK3dbcZDyh4xMSVeO51vZj9xULZCm+rO+1
 +dZsmGBxo+sBRwXENYA6sxzX6L69ggxDkYEtoxAnlhg33HLKVfyj0vaPVvn+z7TLZ3
 gTXcmXCR4Rb2n9VmXqB6kEt3rc5MzKMPoFA0yYgM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c113727b-d045-44c0-9d94-ab022b61fb09@yandex-team.ru>
Date: Wed, 4 Mar 2026 20:22:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] migration: factor out vmstate_save_field() from
 vmstate_save_state()
To: Peter Xu <peterx@redhat.com>
Cc: farosas@suse.de, "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-8-vsementsov@yandex-team.ru>
 <aacAhTY55cp4QgQu@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aacAhTY55cp4QgQu@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 03.03.26 18:38, Peter Xu wrote:
> On Sat, Feb 21, 2026 at 12:02:05AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Simplify vmstate_save_state() which is rather big, and simplify further
>> refactoring.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> I wonder how hard it is to have this helper also cover the rest in the loop
> over elements, on e.g. VMS_ARRAY_OF_POINTER, vmdesc_loop being able to
> change, and all the nullptr handling.
> 
> I had a feeling that you intentionally skipped those because it'll not be
> as trivial

Yes, at least it would make me to dig deeper and understand the logic
around vmdesc and vmdesc_loop :) So I decided to limit the change to
what I need for further conversion to bool+errp.

> - I think it's fine, but IIUC we can always figure a way out.
> Can be done later.  Agree this is an improvement already,
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
-- 
Best regards,
Vladimir

