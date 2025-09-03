Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCA9CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uthuc-0001MQ-To; Wed, 03 Sep 2025 03:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uthuY-0001Jm-PP
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:28:06 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uthuO-00056V-6G
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:27:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:999c:0:640:51a7:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 8FBE480881;
 Wed, 03 Sep 2025 10:27:47 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8f::1:11] (unknown
 [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kRaOsp3G4Ko0-Ml0I34sA; Wed, 03 Sep 2025 10:27:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756884467;
 bh=YFVc1NMI1OdMuKvxLtA0r37F+pwrPHMAFbr8JyL0hPM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=mM0BgwoiMPFg5BPIfm3ApXPFCSeldMO+nvua00a2fxrud4npWMp13X7edNb/HaRL7
 Dv17pGXDcxFiEv5SaISjSloZYCENz+J6/dy0udGdPIGyFZyvO8g8BwLLWVbcVpUdPa
 jFfXmTESgJYcBHNPi95yfF6rBxhVqGOegSIXBWHQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c0115a22-eb9e-4bcc-8f5f-c43ca07143d9@yandex-team.ru>
Date: Wed, 3 Sep 2025 10:27:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/20] net/tap: net_init_tap_one(): support bridge
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
 <20250823160323.20811-13-vsementsov@yandex-team.ru>
 <CACGkMEuRYb654ruHax6qcK9uLcn+_kJ4GsGEdrQwj3TZa-rdHw@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEuRYb654ruHax6qcK9uLcn+_kJ4GsGEdrQwj3TZa-rdHw@mail.gmail.com>
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

On 03.09.25 08:28, Jason Wang wrote:
> On Sun, Aug 24, 2025 at 12:03 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Use net_init_tap_one() in net_init_bridge().
> 
> Need to explain why this is needed.
> 

Oh, right. It took a minute for me to remember)

Will add:

To be able in further commits use net_init_bridge for "bridge" case of init_tap,
as it almost the same, but requires tap-related things in net_init_tap_one.

> 
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   net/tap.c | 28 +++++++++++++++++++++++-----
>>   1 file changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index 468dae7004..5acfb128a1 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -88,6 +88,12 @@ static void launch_script(const char *setup_script, const char *ifname,
>>   static void tap_send(void *opaque);
>>   static void tap_writable(void *opaque);
>>
>> +static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
>> +                            const char *model, const char *name,
>> +                            const char *ifname, const char *script,
>> +                            const char *downscript, const char *vhostfdname,
>> +                            int vnet_hdr, int fd, Error **errp);
>> +
>>   static void tap_update_fd_handler(TAPState *s)
>>   {
>>       qemu_set_fd_handler(s->fd,
>> @@ -626,8 +632,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
>>   {
>>       const NetdevBridgeOptions *bridge;
>>       const char *helper, *br;
>> -    TAPState *s;
>> -    int fd, vnet_hdr;
>> +    int fd, vnet_hdr, ret;
>>
>>       assert(netdev->type == NET_CLIENT_DRIVER_BRIDGE);
>>       bridge = &netdev->u.bridge;
>> @@ -648,9 +653,14 @@ int net_init_bridge(const Netdev *netdev, const char *name,
>>           close(fd);
>>           return -1;
>>       }
>> -    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
>>
>> -    qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
>> +    ret = net_init_tap_one(netdev, peer, "bridge", name,
>> +                           NULL, NULL, NULL,
>> +                           NULL, vnet_hdr, fd, errp);
>> +    if (ret < 0) {
>> +        close(fd);
>> +        return -1;
>> +    }
>>
>>       return 0;
>>   }
>> @@ -698,11 +708,19 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
>>                               const char *downscript, const char *vhostfdname,
>>                               int vnet_hdr, int fd, Error **errp)
>>   {
>> -    const NetdevTapOptions *tap = &netdev->u.tap;
>> +    const NetdevTapOptions *tap;
>>       TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
>>       int vhostfd;
>>
>> +    if (netdev->type == NET_CLIENT_DRIVER_BRIDGE) {
>> +        const NetdevBridgeOptions *bridge = &netdev->u.bridge;
>> +        qemu_set_info_str(&s->nc, "helper=%s,br=%s",
>> +                          bridge->helper, bridge->br);
>> +        return 0;
>> +    }
>> +
>>       assert(netdev->type == NET_CLIENT_DRIVER_TAP);
>> +    tap = &netdev->u.tap;
>>
>>       if (tap_set_sndbuf(s->fd, tap, errp) < 0) {
>>           goto failed;
>> --
>> 2.48.1
>>
> 


-- 
Best regards,
Vladimir

