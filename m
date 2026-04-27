Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6793FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLs1-0007zQ-AG; Mon, 27 Apr 2026 09:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wHLrx-0007wY-8V
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 09:19:25 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wHLrt-0003Jo-Sv
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 09:19:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A07C1C01BB;
 Mon, 27 Apr 2026 16:19:13 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:446::1:3c] (unknown
 [2a02:6bf:8080:446::1:3c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id CJYWP41LJ8c0-uEyRF00N; Mon, 27 Apr 2026 16:19:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1777295953;
 bh=hNzCrN4K2+ONj3VPB5swUZiK0a8HzVo1zKuKKFAyeEg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ZEDmDO8Qe8ixCa9Pc/4hvS6DpUidRkEQ6ih7Qert5a2tTnWxSdt8hpr5CoD2+0tyx
 vd7iiMZqtE+frFixUpOsgfI5xNr08YouIIV64qo5UKynfAFNNvQF3r9rup1pmgkm0f
 7epr4O8AtkibdhgVXNljN8C1AO2h5JbfQGI/wwos=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f7525a89-7878-43e8-b791-69829589666f@yandex-team.ru>
Date: Mon, 27 Apr 2026 16:19:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/18] migration: VMStateInfo: introduce new handlers
 with errp
To: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-13-vsementsov@yandex-team.ru>
 <d80e91c1-2cbb-4081-a923-7b0c1da3b7cc@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <d80e91c1-2cbb-4081-a923-7b0c1da3b7cc@redhat.com>
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

On 26.04.26 11:33, Paolo Bonzini wrote:
> On 3/4/26 21:22, Vladimir Sementsov-Ogievskiy wrote:
>> +    bool coroutine_mixed_fn (*load)(QEMUFile *f, void *pv, size_t size,
>> +                                    const VMStateField *field,
>> +                                    Error **errp);
>> +    bool coroutine_mixed_fn (*save)(QEMUFile *f, void *pv, size_t size,
>> +                                    const VMStateField *field,
>> +                                    JSONWriter *vmdesc,
>> +                                    Error **errp);
> Use void functions for callbacks, with a wrapper adding the bool type. While bool/errp is preferred in general, for callbacks it provides N opportunities to get it wrong instead of just one.
> 

Hmm, for now, the series is already merged.

Next, I'm unsure, how callbacks are different from other functions around errors?

I'm not sure that making wrappers, which will have to use ERRP_GUARD and check
*errp for the error is a good practice. If it is, it would be good to start by
modifying the documentation in include/qapi/error.h to mention the exclusion
for callbacks.


-- 
Best regards,
Vladimir

