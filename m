Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79D5CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 18:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPw7-0008OD-GM; Wed, 10 Sep 2025 14:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwPw4-0008N6-BX; Wed, 10 Sep 2025 14:52:52 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwPw1-0006yI-4x; Wed, 10 Sep 2025 14:52:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B2925807DE;
 Wed, 10 Sep 2025 21:52:41 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b48::1:39] (unknown
 [2a02:6bf:8080:b48::1:39])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id eqPm040GiW20-wDcMApAK; Wed, 10 Sep 2025 21:52:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757530361;
 bh=4DNXAcbJvD3oHDpYh2UxolhWLuXODSso3eywZ5V6l+8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=rOCS7IV+NmKxJIuebKusINffPmH7qmwXvZ9k0UeziQW+ibpK6xDXPEfwvUJ1hfPTH
 7nfmsPFw7+oY3tUiCpjybpVHDRq1UyUGdF6ADx/SaTu+rpZHS2LyyjuSIYunB3wFDk
 lb/INxIDDmoEqGv2q/Be/d+y7zbMt1N48E7noaRU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <719b1b6e-524e-4993-9977-cbceaff2a776@yandex-team.ru>
Date: Wed, 10 Sep 2025 21:52:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] util: drop qemu_socket_set_nonblock()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kostiantyn Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Coiby Xu <Coiby.Xu@gmail.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-5-vsementsov@yandex-team.ru>
 <aMFIhJp-GfOhv3AV@redhat.com>
 <2bfafcf7-7051-4c14-a580-fb33895a0a1a@yandex-team.ru>
 <aMHAQkYQ1kK4_yD_@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMHAQkYQ1kK4_yD_@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10.09.25 21:15, Daniel P. Berrangé wrote:
> On Wed, Sep 10, 2025 at 08:55:57PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 10.09.25 12:44, Daniel P. Berrangé wrote:
>>>> @@ -36,7 +37,11 @@ static gboolean ga_channel_listen_accept(GIOChannel *channel,
>>>>            g_warning("error converting fd to gsocket: %s", strerror(errno));
>>>>            goto out;
>>>>        }
>>>> -    qemu_socket_set_nonblock(client_fd);
>>>> +    if (!qemu_set_blocking(client_fd, false, &err)) {
>>>> +        g_warning("errer: %s", error_get_pretty(err));
>>> s/errer/error/
>>>
>>>
>>> This is a pre-existing problem, but none of this code should be using
>>> g_warning. g_printerr() should have been used for printing error
>>> messages. I'm not expecting you to fix that, just an observation.
>>
>>
>> Why not g_error()? I see some g_warnings in qga code a correct "warnings", not "errors".. And if we use sometimes g_warning, the g_error is more correct pair for it.
>>
>> Or we don't want any of g_error / g_warning in QEMU code?
> 
> g_error will call abort() after printing the message, which will
> prevent graceful cleanup and result in a core file, so is not
> very desirable to use.

Oh, right, I was stupid)

> 
> g_warning will also turn into g_error if G_DEBUG=fatal-warnings
> is set.
> 
> We really just want a plain message printed on the console with
> no side effects, and g_printerr gives us that.
> 
> 

Still, it's strange for me, that we just not use error_reprot()/warn_report() everywhere.

I see we have underlying error_vprintf() realization for code without monitor in stubs/error-printf.c..


-- 
Best regards,
Vladimir

