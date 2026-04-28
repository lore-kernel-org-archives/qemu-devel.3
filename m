Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA0CFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHddC-0003mn-08; Tue, 28 Apr 2026 04:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wHddA-0003lg-1Z
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:17:20 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wHdd7-0007NR-BN
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:17:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2B1B580667;
 Tue, 28 Apr 2026 11:17:12 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:446::1:3c] (unknown
 [2a02:6bf:8080:446::1:3c])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id BHUifb1K5iE0-sC08QwuB; Tue, 28 Apr 2026 11:17:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1777364231;
 bh=eVtW1jH3E4ZtJg2+0nwO5lvSa4sUN9NdUKnrx8/I+Qk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=mtydSu7uNW2K4R5jBuw1d2OtGN+dUGc6egTCEYjIp482iK5pw2VQHHgCVW4r7Ghsw
 hlYucMIcn8A5lzYgZTAH+HaBfG5Lxz9TB1+5JEKdclYMKeUTx5Lg/P1Z2ltOx3egRl
 Hto/171HCd21ANla1FJX3bqe6VL5WnvvlPhOyq+4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b47b83aa-c574-4a38-bad2-4f42d6a7c597@yandex-team.ru>
Date: Tue, 28 Apr 2026 11:17:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/18] migration: VMStateInfo: introduce new handlers
 with errp
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-13-vsementsov@yandex-team.ru>
 <d80e91c1-2cbb-4081-a923-7b0c1da3b7cc@redhat.com>
 <f7525a89-7878-43e8-b791-69829589666f@yandex-team.ru>
 <CABgObfbz98A0P4_FAqeKVk_fS+o_3=79agYz=qwnMdmg-h2L-Q@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CABgObfbz98A0P4_FAqeKVk_fS+o_3=79agYz=qwnMdmg-h2L-Q@mail.gmail.com>
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

[add Markus]

On 27.04.26 22:11, Paolo Bonzini wrote:
> 
> 
> Il lun 27 apr 2026, 15:19 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> ha scritto:
> 
>     On 26.04.26 11:33, Paolo Bonzini wrote:
>      > On 3/4/26 21:22, Vladimir Sementsov-Ogievskiy wrote:
>      >> +    bool coroutine_mixed_fn (*load)(QEMUFile *f, void *pv, size_t size,
>      >> +                                    const VMStateField *field,
>      >> +                                    Error **errp);
>      >> +    bool coroutine_mixed_fn (*save)(QEMUFile *f, void *pv, size_t size,
>      >> +                                    const VMStateField *field,
>      >> +                                    JSONWriter *vmdesc,
>      >> +                                    Error **errp);
>      > Use void functions for callbacks, with a wrapper adding the bool type. While bool/errp is preferred in general, for callbacks it provides N opportunities to get it wrong instead of just one.
>      >
> 
>     Hmm, for now, the series is already merged.
> 
>     Next, I'm unsure, how callbacks are different from other functions around errors?
> 
> 
> As I wrote above, confusing the *error == NULL and bool return value is avoided without much extra effort for callbacks (or other kinds of virtual functions) l, because there is a single caller. So the balance between "avoiding the possibility of getting the return value wrong" and "convenience of having a return value" tilts more towards the former.
> 

Understand. Hm.

An alternative for this single-caller case, is just add an assertion into this caller:

bool wrapper(..., errp) {

    ERRP_GUARD();

    bool ok = x->foo(..., errp);

    assert(ok == !(*errp));

    return ok;
}


with this, we have:

- same overhead (using ERRP_GUARD)

- same guarantee

- keep common recommended bool+errp interface everywhere, which is rather good benefit IMHO


Markus, what do you think about this case of errp-functions?


-- 
Best regards,
Vladimir

