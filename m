Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A05ED49C71
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 08:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vljuq-00057k-GE; Fri, 30 Jan 2026 03:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vljuj-00056I-Eu
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 03:31:38 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vljug-0004rh-0F
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 03:31:37 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id CD34980787;
 Fri, 30 Jan 2026 11:31:28 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:37::1:8] (unknown [2a02:6bf:8080:37::1:8])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id RVfx8D5ApKo0-22uIWrxI; 
 Fri, 30 Jan 2026 11:31:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769761887;
 bh=JVkyrKYa3UOg72IBroIHhC753bCo5zN14oJpq6XMyeA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=IIYm3ydb+MewOXYtyFoXOBzwMk9bIcgVm0/fY8PRBEAc9RY1rZQklRNY8UEv82pS5
 R/gxd5Wbl6hK31N2KnrLwoRV2kJKC7WHzZFagjeksPwCTn7mczgS2aITiMreZdh32S
 VFXA5vNR5BovAss0YtNXLUNES2JGmr8UlPQULNa0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4edd7e3d-6e57-43de-a11f-dabb9b6989ce@yandex-team.ru>
Date: Fri, 30 Jan 2026 11:31:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] net/af-xdp: fix type overflow
To: Ilya Maximets <i.maximets@ovn.org>, jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru
References: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
 <20260129213215.1405459-2-vsementsov@yandex-team.ru>
 <c3bfb469-330f-4f61-9062-c877f29e2f5a@ovn.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <c3bfb469-330f-4f61-9062-c877f29e2f5a@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 30.01.26 02:15, Ilya Maximets wrote:
> On 1/29/26 10:32 PM, Vladimir Sementsov-Ogievskiy wrote:
>> In for-loop in net_init_af_xdp, we do nc->queue_index = i,
>> where is is int64_t for 0 to queues-1, and nc->queue_index is
>> unsigned int.
>>
>> Also in parse_socket_fds, g_strv_length() returns guint which
>> is equivalent to unsigned int.
>>
>> Let's simply use unsigned int type for queues, and update
>> the check appropriately.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   net/af-xdp.c | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/af-xdp.c b/net/af-xdp.c
>> index 14f302ea21..bb7a7d8e33 100644
>> --- a/net/af-xdp.c
>> +++ b/net/af-xdp.c
>> @@ -442,14 +442,14 @@ static NetClientInfo net_af_xdp_info = {
>>   };
>>   
>>   static int *parse_socket_fds(const char *sock_fds_str,
>> -                             int64_t n_expected, Error **errp)
>> +                             unsigned n_expected, Error **errp)
>>   {
>>       gchar **substrings = g_strsplit(sock_fds_str, ":", -1);
>> -    int64_t i, n_sock_fds = g_strv_length(substrings);
>> +    unsigned i, n_sock_fds = g_strv_length(substrings);
>>       int *sock_fds = NULL;
>>   
>>       if (n_sock_fds != n_expected) {
>> -        error_setg(errp, "expected %"PRIi64" socket fds, got %"PRIi64,
>> +        error_setg(errp, "expected %u socket fds, got %u",
>>                      n_expected, n_sock_fds);
>>           goto exit;
>>       }
>> @@ -484,7 +484,7 @@ int net_init_af_xdp(const Netdev *netdev,
>>       unsigned int ifindex;
>>       uint32_t prog_id = 0;
>>       g_autofree int *sock_fds = NULL;
>> -    int64_t i, queues;
>> +    unsigned i, queues;
>>       Error *err = NULL;
>>       AFXDPState *s;
>>       bool inhibit;
>> @@ -496,13 +496,14 @@ int net_init_af_xdp(const Netdev *netdev,
>>           return -1;
>>       }
>>   
>> -    queues = opts->has_queues ? opts->queues : 1;
>> -    if (queues < 1) {
>> +    if (opts->has_queues && (opts->queues < 0 || opts->queues > UINT_MAX)) {
> 
> Not a full review, but this changes the logic.  Zero is not a valid number
> of queues.

Oops, good shot, thanks for looking. Will fix.

> 
>>           error_setg(errp, "invalid number of queues (%" PRIi64 ") for '%s'",
>> -                   queues, opts->ifname);
>> +                   opts->queues, opts->ifname);
>>           return -1;
>>       }
>>   
>> +    queues = opts->has_queues ? opts->queues : 1;
>> +
>>       inhibit = opts->has_inhibit && opts->inhibit;
>>       if (inhibit && !opts->sock_fds && !opts->map_path) {
>>           error_setg(errp, "'inhibit=on' requires 'sock-fds' or 'map-path'");
>> @@ -537,7 +538,7 @@ int net_init_af_xdp(const Netdev *netdev,
>>   
>>       for (i = 0; i < queues; i++) {
>>           nc = qemu_new_net_client(&net_af_xdp_info, peer, "af-xdp", name);
>> -        qemu_set_info_str(nc, "af-xdp%"PRIi64" to %s", i, opts->ifname);
>> +        qemu_set_info_str(nc, "af-xdp%u to %s", i, opts->ifname);
>>           nc->queue_index = i;
>>   
>>           if (!nc0) {
> 


-- 
Best regards,
Vladimir

