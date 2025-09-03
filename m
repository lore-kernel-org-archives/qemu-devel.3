Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2026DCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uthqm-0007E3-Li; Wed, 03 Sep 2025 03:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uthqR-0007AA-Gc
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:23:56 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uthqO-0004Xx-QI
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:23:51 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C50E380841;
 Wed, 03 Sep 2025 10:23:43 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8f::1:11] (unknown
 [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gNaH2b3GuGk0-gVaTXciQ; Wed, 03 Sep 2025 10:23:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756884223;
 bh=+YS3P42Pzsq/3U4RLjH6I+FFjMfLqS33XuUzumtuWVE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0QUvdBMPSDQD/MmOxKVcvDV0ITM6c6TVWFq4ZAbum1S3s1G/l/BzznGjXegjer84r
 o+Aj3BTtaMQChNg9uUWCDYmsFNru6FC1rfuO3gS7gY9bSMWB9eEkvRJ9Z8IuImqd//
 BujvFVGVHmkiEaTSbiMzw7diSxoMJJQgWGRP7/eU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <49b05983-2b54-4aad-90f6-92a527b6698e@yandex-team.ru>
Date: Wed, 3 Sep 2025 10:23:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/20] net/tap: net_init_tap_one(): refactor to use
 netdev as first arg
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
 <20250823160323.20811-12-vsementsov@yandex-team.ru>
 <CACGkMEvOgLj0EjXOg6=fqcm08-5UY1JfQaOBKDQjfSJLk6zmLw@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEvOgLj0EjXOg6=fqcm08-5UY1JfQaOBKDQjfSJLk6zmLw@mail.gmail.com>
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

On 03.09.25 08:19, Jason Wang wrote:
> On Sun, Aug 24, 2025 at 12:03 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> This is needed for further unification of bridge initialization in
>> net_init_tap() and net_init_bridge().
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   net/tap.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index eab0a86173..468dae7004 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -692,15 +692,18 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
>>
>>   #define MAX_TAP_QUEUES 1024
>>
>> -static int net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>> +static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
>>                               const char *model, const char *name,
>>                               const char *ifname, const char *script,
>>                               const char *downscript, const char *vhostfdname,
>>                               int vnet_hdr, int fd, Error **errp)
>>   {
>> +    const NetdevTapOptions *tap = &netdev->u.tap;
>>       TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
>>       int vhostfd;
>>
>> +    assert(netdev->type == NET_CLIENT_DRIVER_TAP);
>> +
> 
> I think we should try our best to avoid assertions and return errors here.
> 

Hmm. But why? This is a static function that we call only for TAP. The error here
is not logically possible.

The error here would mean:

- either we have a terrible bug in code, so we don't understand which functions call which ones, so better to stop here (abort)
- or it's a kind of memory corruption, and again, better to abort than continue damage users data

The assert may be removed not breaking the logic. But it brings the best kind of documentation,
that in this function we work only with TAP.

Finally, there a lot of similar asserts already in net code and in tap.c:

git grep 'assert.*== NET_CLIENT' | wc -l
45

> 
>>       if (tap_set_sndbuf(s->fd, tap, errp) < 0) {
>>           goto failed;
>>       }
>> @@ -826,7 +829,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
>>               return -1;
>>           }
>>
>> -        ret = net_init_tap_one(tap, peer, "tap", name, NULL,
>> +        ret = net_init_tap_one(netdev, peer, "tap", name, NULL,
>>                                  NULL, NULL,
>>                                  tap->vhostfd, vnet_hdr, fd, errp);
>>           if (ret < 0) {
>> @@ -875,7 +878,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
>>                   return -1;
>>               }
>>
>> -            ret = net_init_tap_one(tap, peer, "tap", name, NULL,
>> +            ret = net_init_tap_one(netdev, peer, "tap", name, NULL,
>>                                      NULL, NULL,
>>                                      vhost_fds ? vhost_fds[i] : NULL,
>>                                      vnet_hdr, fd, errp);
>> @@ -905,7 +908,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
>>               return -1;
>>           }
>>
>> -        ret = net_init_tap_one(tap, peer, "bridge", name, NULL,
>> +        ret = net_init_tap_one(netdev, peer, "bridge", name, NULL,
>>                                  NULL, NULL, tap->vhostfd,
>>                                  vnet_hdr, fd, errp);
>>           if (ret < 0) {
>> @@ -946,7 +949,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
>>                   return -1;
>>               }
>>
>> -            ret = net_init_tap_one(tap, peer, "tap", name, ifname,
>> +            ret = net_init_tap_one(netdev, peer, "tap", name, ifname,
>>                                      i >= 1 ? "no" : script,
>>                                      i >= 1 ? "no" : downscript,
>>                                      tap->vhostfd, vnet_hdr, fd, errp);
>> --
>> 2.48.1
>>
> 


-- 
Best regards,
Vladimir

