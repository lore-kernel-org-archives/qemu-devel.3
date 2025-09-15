Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5074CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 18:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyE0z-0006Pk-9l; Mon, 15 Sep 2025 14:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyE0a-0006M3-Dp; Mon, 15 Sep 2025 14:33:02 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyE0R-0002Lj-JZ; Mon, 15 Sep 2025 14:32:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:999c:0:640:51a7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9E3BBC0162;
 Mon, 15 Sep 2025 21:32:43 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:184::1:6] (unknown [2a02:6bf:8080:184::1:6])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id fWUlUp1Gt4Y0-2CkCu56m; Mon, 15 Sep 2025 21:32:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757961162;
 bh=VTVKlhnsDlbUjct4u/W2nwagl6fp2Sb7pcSDSjODXYA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ZMRclWT63ZTc0yBJ2cPo1hPxhqG12cBSsWJ7YtEubHp7+N1qRnocMm83aGE/bsGFW
 bopxJsurVS0Hr1998TbnggrkQh0S8Rua6P9th1tgTg3JkfpqKpzZwqzHZHvHBRNRQF
 MfQbP6hPD4tgehPsOIxbdgCg9pay3lMTQsZO01EQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e2860e37-4ccc-497c-a6bb-81c9ec236fcd@yandex-team.ru>
Date: Mon, 15 Sep 2025 21:32:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] handle result of qio_channel_set_blocking()
To: Jag Raman <jag.raman@oracle.com>
Cc: "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "leiyang@redhat.com" <leiyang@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Zhao Liu <zhao1.liu@intel.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20250915132211.135095-1-vsementsov@yandex-team.ru>
 <20250915132211.135095-6-vsementsov@yandex-team.ru>
 <3E40E309-5E2E-4527-AE97-E90DE3EA5B02@oracle.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <3E40E309-5E2E-4527-AE97-E90DE3EA5B02@oracle.com>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 15.09.25 20:04, Jag Raman wrote:
> 
> 
>> On Sep 15, 2025, at 9:22 AM, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
>>
>> Currently, we just always pass NULL as errp argument. That doesn't
>> look good.
>>
>> Some realizations of interface may actually report errors.
>> Channel-socket realization actually either ignore or crash on
>> errors, but we are going to straighten it out to always reporting
>> an errp in further commits.
>>
>> So, convert all callers to either handle the error (where environment
>> allows) or explicitly use &error_abort.
>>
>> Take also a chance to change the return value to more convenient
>> bool (keeping also in mind, that underlying realizations may
>> return -1 on failure, not -errno).
>>
>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Thanks for the patch, Vladimir! LGTM, please see some nits below
> 
> Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>

Thanks for reviewing!

> 
>> ---
>> block/nbd.c                      |  5 ++++-
>> chardev/char-socket.c            | 14 ++++++++++----
>> hw/remote/proxy.c                |  6 +++++-

[..]

>>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index d242be9811..acec0487a8 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -1411,7 +1411,9 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
>>          ....options sent, ending in NBD_OPT_EXPORT_NAME or NBD_OPT_GO....
>>       */
>>
>> -    qio_channel_set_blocking(client->ioc, false, NULL);
>> +    if (!qio_channel_set_blocking(client->ioc, false, errp)) {
>> +        return -EINVAL;
> 
> Should we consider a different errno here? Perhaps EIO?

I still think, that EINVAL is better, as this opertions is not about IO, it's
just changing flags of file descriptor. The actual errno is lost at this stage,
but looking at fcntl (which should be the underlying mechanism) spec, it could
be one of EACCES, EAGAIN, EBADF, EINVAL. And EINVAL is good default for "just
an error".

> 
>> +    }
>>      qio_channel_set_follow_coroutine_ctx(client->ioc, true);
>>
>>      trace_nbd_negotiate_begin();

[..]

>> diff --git a/tests/unit/io-channel-helpers.c b/tests/unit/io-channel-helpers.c
>> index c0799c21c2..22b42d14cd 100644
>> --- a/tests/unit/io-channel-helpers.c
>> +++ b/tests/unit/io-channel-helpers.c
>> @@ -20,6 +20,7 @@
>>
>> #include "qemu/osdep.h"
>> #include "io-channel-helpers.h"
>> +#include "qapi/error.h"
>> #include "qemu/iov.h"
>>
>> struct QIOChannelTest {
>> @@ -109,8 +110,8 @@ void qio_channel_test_run_threads(QIOChannelTest *test,
>>      test->src = src;
>>      test->dst = dst;
>>
>> -    qio_channel_set_blocking(test->dst, blocking, NULL);
>> -    qio_channel_set_blocking(test->src, blocking, NULL);
>> +    qio_channel_set_blocking(test->dst, blocking, &error_abort);
>> +    qio_channel_set_blocking(test->src, blocking, &error_abort);
> 
> Do we need to assert that the call to qio_channel_set_blocking()
> was successful, similar to what qio_channel_test_validate() does
> with other function calls?
> 

No, &error_abort does this work for us: in case of error it will
print the error message and abort (look at error_handle() in
util/error.c)



-- 
Best regards,
Vladimir

