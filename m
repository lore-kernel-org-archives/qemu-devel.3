Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D22CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 17:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwP3C-0005Qa-Rs; Wed, 10 Sep 2025 13:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwP3A-0005O3-FS; Wed, 10 Sep 2025 13:56:08 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwP36-0003kR-5L; Wed, 10 Sep 2025 13:56:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7B6AEC019D;
 Wed, 10 Sep 2025 20:55:58 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b48::1:39] (unknown
 [2a02:6bf:8080:b48::1:39])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vtO5i20GtGk0-Lb6nKEN4; Wed, 10 Sep 2025 20:55:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757526958;
 bh=6Yyglttyp/01VH6lqQ0e3YzHYb2TAjz/lND9UKGjSZk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=RtOCPB32lnD9dTThvmIDI1lz8446UTwIudeT0AQ8kLBv61sHL3bpmFgxrT+BLu15A
 vKZT0NP6Ctb/M9XUQvw8AaK5E51sfGjXwfhzJdakVvSmZO7MevS6WKt934URyNV+tC
 E+rqI2U4j5QOjpil5m2kGKdgFfE/RHiXO14mdwQw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2bfafcf7-7051-4c14-a580-fb33895a0a1a@yandex-team.ru>
Date: Wed, 10 Sep 2025 20:55:57 +0300
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
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMFIhJp-GfOhv3AV@redhat.com>
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

On 10.09.25 12:44, Daniel P. Berrangé wrote:
>> @@ -36,7 +37,11 @@ static gboolean ga_channel_listen_accept(GIOChannel *channel,
>>           g_warning("error converting fd to gsocket: %s", strerror(errno));
>>           goto out;
>>       }
>> -    qemu_socket_set_nonblock(client_fd);
>> +    if (!qemu_set_blocking(client_fd, false, &err)) {
>> +        g_warning("errer: %s", error_get_pretty(err));
> s/errer/error/
> 
> 
> This is a pre-existing problem, but none of this code should be using
> g_warning. g_printerr() should have been used for printing error
> messages. I'm not expecting you to fix that, just an observation.


Why not g_error()? I see some g_warnings in qga code a correct "warnings", not "errors".. And if we use sometimes g_warning, the g_error is more correct pair for it.

Or we don't want any of g_error / g_warning in QEMU code?

-- 
Best regards,
Vladimir

