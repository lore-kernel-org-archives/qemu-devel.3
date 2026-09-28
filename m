Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B01C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB6ef-0002gy-GB; Mon, 28 Sep 2026 04:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xB6eb-0002g8-Mw; Mon, 28 Sep 2026 04:24:05 -0400
Received: from 2.mo15.mail-out.ovh.net ([5.135.90.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xB6eZ-00005L-Ao; Mon, 28 Sep 2026 04:24:05 -0400
Received: from DAGFR11EX3.OVH.local (unknown [10.110.37.92])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4htZ8Q69fkz3wcK;
 Mon, 28 Sep 2026 08:23:50 +0000 (UTC)
Received: from [10.15.146.202] (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 10:23:50 +0200
Message-ID: <19b7e322-f98b-4059-ae5e-95b2bdfe0c0c@ovhcloud.com>
Date: Mon, 28 Sep 2026 10:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nbd/client-connection: Fix client returning a closed
 channel
To: <eblake@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20260925155346.357703-1-guillaume.vincke@ovhcloud.com>
 <20260925155346.357703-2-guillaume.vincke@ovhcloud.com>
 <arbf-WK4eJCeNX35@redhat.com>
Content-Language: en-US
From: guillaume vincke <guillaume.vincke@ovhcloud.com>
In-Reply-To: <arbf-WK4eJCeNX35@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.190.254.61]
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 2600547311674409255
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFCWFn9bE8G/Z7soDwUT2uX/lPR+rCrPNtdXV9i8J2xFChwfhYbDFupKfVXbyCJw7WOjdvatCuxyJvefpuZC3pMneFR/4dMnPZVLqccaWuAp4BfnqGFnYWt0Y+4vVCgY5asVf4gAVyxJlA4ReIEl7D38j9j8YsHGxJJY6Nyqht7ibjwJzhzldnoEhTPZbON0m4I2wOozhfSWBa9IZnBe+AMt9DrUkLvcBYMVnPu4FFETS8PtWSVOX6aXaoZUiSYVp3V0oYSN0dJLFT/sBdkk6kjXlv9Zi6q2sZivoFvAoTmi6VsU4Iua8KL6TPNQvHTy67UZfkMwRKtvARBJrqqsSaFdjdBtAt4CcqBVLwXYruwP8WJyUWfzLS9XAHeF0jvnmbxv9ZkYrXzYauRMubL/5EXlLT3GVvWHStZvcALDHy4C1fUu+bxQaXb9GkG77tDrKvUmSxc6j4/J6M+Wjy0Ehj6nO4k3+9niZIzmIN9gBIGmvmWy4PGInnClqM0dMx8bfcLX79NHBsDLU6bifS/HoCMZUSEUXBFyS3r2yIasCC6ZEXYTHjYBM85lfYvYj0V48nHSPFGlYUSl3sNT1Gb8ezK6eCWeZzgH32OoTzlza1V+fJppeNTgUNg+hS1QUlDPD57ug4kmP31ljtcbtbyZQt0AsGRaLfvq0VpwHS9/mVfYA
DKIM-Signature: a=rsa-sha256; bh=tKaWeHbD6Q8Iu28LKJqyOKduNdj38NXJ2TxJ7sotyOU=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1790583831; v=1; 
 b=k6MCT5IpkINQHJtH+pM/3pFwP8LwYmvs+3IM2cFAuFGFHlNvC5qTElzBkl+zXDbPgr/YH8Vc
 Dt1lZ5mrSjx0X9Nuby8xzWFR0MRTLcwpQI/NE3uaPptu9mVFLH7HlKsQ7/ua0ILP6IofPU7IUnt
 svIf6s/WFN5Xdn0GGmDI5Bts=
Received-SPF: pass client-ip=5.135.90.179;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=2.mo15.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/25/26 23:00, Eric Blake wrote:
> On Fri, Sep 25, 2026 at 05:53:45PM +0200, Guillaume Vincke wrote:
>> When a server closes the connection after a successful handshake but
>> before running any operations, the channel returned by
>> nbd_co_establish_connection() is the closed one and the connect thread
>> is not started.
>>
>> When configured with reconnect-delay=0 (the default), this situation
>> generates at least two IO errors. The first one happens when trying to
>> issue an operation to the closed socket. The connect thread will be
>> started on the next request, which may happen long after, and will
>> create the second error as nbd_co_establish_connection() returns a NULL
>> channel.
>>
>> Peeking the channel to detect FIN or RST avoids the first IO error and
>> does not delay the starting of the connect thread.
>>
>> Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
>> ---
>>   nbd/client-connection.c | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/nbd/client-connection.c b/nbd/client-connection.c
>> index 6a4f080717..878219fede 100644
>> --- a/nbd/client-connection.c
>> +++ b/nbd/client-connection.c
>> @@ -274,6 +274,26 @@ void nbd_client_connection_release(NBDClientConnection *conn)
>>       }
>>   }
>>   
>> +/* only true when the peer closed the channel. Does not detect if dead */
> 
> For consistent style, I would use
> 
> /* Only true when the peer closed the channel. Does not detect if dead. */
> 
>> +static bool nbd_channel_is_closed(QIOChannel *ioc)
>> +{
>> +    char data;
>> +    struct iovec iov = { .iov_base = &data, .iov_len = 1 };
>> +    ssize_t len = -1;
>> +
>> +    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
>> +        return false;
>> +    }
>> +
>> +    len = qio_channel_readv_full(
>> +        ioc, &iov, 1, NULL, NULL, QIO_CHANNEL_READ_FLAG_MSG_PEEK, NULL);
>> +
>> +    if (len == 0 || (len < 0 && len != QIO_CHANNEL_ERR_BLOCK)) {
>> +        return true;
>> +    }
>> +    return false;
> 
> The last group could be shortened to:
> 
>     return len == 0 || (len < 0 && len != QIO_CHANNEL_ERR_BLOCK);

Thanks, I will make sure to include those changes in v2 once patch 2/2
is reviewed, to avoid a new submission for these alone.

> 
> but that is not mandatory.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 


