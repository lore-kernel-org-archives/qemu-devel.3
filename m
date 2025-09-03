Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5282BCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 15:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utpSo-0000c8-TM; Wed, 03 Sep 2025 11:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utpSm-0000bC-NU
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 11:31:56 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utpSj-0005Gt-0t
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 11:31:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B5E8BC014E;
 Wed, 03 Sep 2025 18:31:47 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8f::1:11] (unknown
 [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kVioRc3GiGk0-XBM3fDGR; Wed, 03 Sep 2025 18:31:47 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756913507;
 bh=fxLb4RyIdNx+Sc6lTQsww71wyL+g+IEgYuA2JRPzWVs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=CMcSJvpCjPQ/HqfqGO1aPwOQ9HwtdDT/nEqMH7WQumgcWCXKH6sixueByEpwieehl
 K8dm7LODcHSqSvnq8WCMxqm2uZhVN00B4bHiL8XteZtFXmZTnKVUz1R6xiSJ8Vt6zF
 lsr0R7lvTEWnprVC0foAZH8OrhH/VJkZfJKcPQ1U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <16e31f9b-49ef-44a4-b9ad-0668e3c2c530@yandex-team.ru>
Date: Wed, 3 Sep 2025 18:31:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] net/tap: implement interfaces for local migration
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, peterx@redhat.com,
 mst@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
 <20250903133706.1177633-6-vsementsov@yandex-team.ru>
 <aLhR2unpr2xg2MYl@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aLhR2unpr2xg2MYl@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 03.09.25 17:34, Daniel P. Berrangé wrote:
> On Wed, Sep 03, 2025 at 04:37:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Handle local-incoming option:
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   include/net/tap.h |   4 ++
>>   net/tap.c         | 136 +++++++++++++++++++++++++++++++++++++++-------
>>   2 files changed, 119 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/net/tap.h b/include/net/tap.h
>> index 6f34f13eae..3ef2e2dbae 100644
>> --- a/include/net/tap.h
>> +++ b/include/net/tap.h
>> @@ -30,7 +30,11 @@
>>   
>>   int tap_enable(NetClientState *nc);
>>   int tap_disable(NetClientState *nc);
>> +bool tap_local_incoming(NetClientState *nc);
>>   
>>   int tap_get_fd(NetClientState *nc);
>>   
>> +int tap_load(NetClientState *nc, QEMUFile *f);
>> +int tap_save(NetClientState *nc, QEMUFile *f);
>> +
>>   #endif /* QEMU_NET_TAP_H */
>> diff --git a/net/tap.c b/net/tap.c
>> index a9d955ac5f..499db756ea 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -35,6 +35,8 @@
>>   #include "net/eth.h"
>>   #include "net/net.h"
>>   #include "clients.h"
>> +#include "migration/migration.h"
>> +#include "migration/qemu-file.h"
>>   #include "monitor/monitor.h"
>>   #include "system/system.h"
>>   #include "qapi/error.h"
>> @@ -82,6 +84,7 @@ typedef struct TAPState {
>>       VHostNetState *vhost_net;
>>       unsigned host_vnet_hdr_len;
>>       Notifier exit;
>> +    bool local_incoming;
>>   } TAPState;
>>   
>>   static void launch_script(const char *setup_script, const char *ifname,
>> @@ -803,6 +806,40 @@ static int net_tap_init_vhost(TAPState *s, Error **errp) {
>>       return 0;
>>   }
>>   
>> +int tap_save(NetClientState *nc, QEMUFile *f)
>> +{
>> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
>> +
>> +    qemu_file_put_fd(f, s->fd);
>> +    qemu_put_byte(f, s->using_vnet_hdr);
>> +    qemu_put_byte(f, s->has_ufo);
>> +    qemu_put_byte(f, s->has_uso);
>> +    qemu_put_byte(f, s->enabled);
>> +    qemu_put_be32(f, s->host_vnet_hdr_len);
> 
> 
> Is it neccessary to transfer that metadata, or is there perhaps a way
> for the other side to query the TAP FD configuration from the kernel
> to detect this ?

Oh, good question, thanks for it. I just added everything and then I was debugging other places.

for hdr_len we have TUNGETVNETHDRSZ, so it's possible.

using_vnet_hdr, seems is equal to initial vnet_hdr option (with default to 1 if not specified), will doublecheck

for ufo/uso, which are set through TUNSETOFFLOAD, we don't have direct way to
get the state. But we can use the fact, that qemu tries to set them once,
and these variables are unchanged after initialization. So we can try set
same flags on target the same way, to understand what we have. Still,
this doesn't seem absolutely safe.. Kernel may behave differently than
for previous initialization, probably due to some changed settings.

for enabled it seems not possible, but we handle it in virtio layer.. Oops,
probably I always migrate enabled=false with this code, will check.

---

On the other hand, calling extra ioctls to learn something lead to extra downtime
(should be measured to be a good argument).

Also, just architecturally: seems better not ask third agent about metadata that we already know.

---

About forward-compatibility (if we add new fields here) - agree.

Maybe turn several boolean fields into one flags field. This way we'll get several "reserved" bits for future changes.

> 
> I'm concerned that this code / wire format is not extensible if we ever
> add another similar field to TAPState in the future.
> 
>> +
>> +    return 0;
>> +}
>> +
>> +int tap_load(NetClientState *nc, QEMUFile *f)
>> +{
>> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
>> +
>> +    s->fd = qemu_file_get_fd(f);
>> +    if (s->fd < 0) {
>> +        return -1;
>> +    }
>> +
>> +    s->using_vnet_hdr = qemu_get_byte(f);
>> +    s->has_ufo = qemu_get_byte(f);
>> +    s->has_uso = qemu_get_byte(f);
>> +    s->enabled = qemu_get_byte(f);
>> +    qemu_get_be32s(f, &s->host_vnet_hdr_len);
>> +
>> +    tap_read_poll(s, true);
>> +
>> +    return net_tap_init_vhost(s, NULL);
>> +}
>> +
>>   static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
>>                                     const char *model, const char *name,
>>                                     const char *ifname, const char *script,
> 
> With regards,
> Daniel


-- 
Best regards,
Vladimir

