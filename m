Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74A3C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 06:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjWs8-000682-3k; Tue, 14 Jul 2026 02:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjWs6-00067s-AM
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 02:44:02 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjWs3-0005IY-3a
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 02:44:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 44984C0ACA;
 Tue, 14 Jul 2026 09:43:54 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5a::1:8] (unknown [2a02:6bf:8080:c5a::1:8])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id qhIE8a0WUa60-iFs0GVxB; Tue, 14 Jul 2026 09:43:53 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784011433;
 bh=r8KPb3y//RYKRgHfgvivtE7A7YNyxncNVY/L841+RZY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=j+URN8oRBXStdquZQsENNPTSXMrkOcgvj4Y46g9DyH0xMU59QjBbQc6/qId1L1zwM
 Ef3hhUfOBiP4+RfSd59JE3Fo0PiXhua/SB1sAu2w2Uf5YLlqKoxzbk9S2tdSuLlmma
 rmD26r8Dyu/c5fcX5zl1hpp4FPZSIEfzotOo/q1U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <449911ff-33cb-4fef-8dd2-33d8f3dc9620@yandex-team.ru>
Date: Tue, 14 Jul 2026 09:43:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 12/14] net/tap: support local migration with virtio-net
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, armbru@redhat.com, peterx@redhat.com,
 farosas@suse.de, raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-13-vsementsov@yandex-team.ru>
 <20260713153340-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260713153340-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 13.07.26 22:36, Michael S. Tsirkin wrote:
> On Fri, Jul 10, 2026 at 10:18:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Support transferring of TAP state (including open fd).
>>
>> Add new property "local-migration-supported", which defines
>> whether local-migration is actually supported for this TAP device.
>> Starting from 11.2 QEMU Machine Types it's enabled by default.
>>
>> Note, that local-migration (including migrating opened FDs
>> through migration channel, which must be UNIX socket), is
>> enabled by global "local" migration parameters. But individual
>> devices may have additional options to enable/disable it
>> per device.
>>
>> The tricky thing, is that we need to know, should we do
>> call open/connect in TAP initialization code. That means,
>> that on incoming migration we want to know status of
>> "local" migration parameter at time of creating TAP device.
>> So, currently, for incoming local migration only TAP device
>> created through QMP is supported, as you need to set migration
>> parameter first (through QMP as well).
>>
>> So the full picture is:
>>
>> On source, to start outgoing "local" migration you need:
>>
>>   - migration parameter "local" set to true
>>   - "local-migration-supported" TAP option set to true (the
>>     default, starting from 11.2 QEMU Machine Types)
>>
>> If at least one of these options is not set, TAP backend
>> doesn't participate in migration.
>>
>> On target, things are more difficult:
>>
>> Same, you need both "local" and "local-migration-supported"
>> be set. And same, if one of them is not set, TAP backend
>> is initialized as usual, and doesn't accept any incoming
>> state.
>>
>> Additionally, if you are going to set "local", it must be
>> set before creating the TAP device. If TAP device created
>> with "local" unset, it initializes as usual. If you enable
>> "local" after it and start incoming migration, it will fail
>> in .pre_load handler of TAP backend.
>>
>> Moreover, there are interface restrictions: if you create TAP
>> device when QEMU is in INCOMING state, and both "local"
>> and "local-migration-supported" set, most of TAP options are
>> not allowed, and script/downscript are required to be explicitly
>> unset (set to "" or "no").
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> 
> I am still confused why is this per device. I just do not
> see where is it useful to set it for some devices
> but not others. So it looks like a machine property
> "incoming local migration" to me?
> 
> Sorry if I am being dense.

1. We need at least "per device class": when local-migration-support is
implemented for some new device, we still need to migrate from/to older
version without this support.

Assume we have "local" migration parameter and support for TAP in 11.2.
Then, in 12.0 support for vhost-user-blk is implemented. If we have only
global "local" parameter, the migration will be broken between 11.2 and
12.0, with local=true, as in 11.2 it means only TAP local migration, but
in 12.0 it means both TAP and vhost-user-blk local migration.

Of course, now it's a bit redundant, as we have only TAP, and may define,
that TAP is always supported (as support is introduced together with
"local"). But there are another considerations:

2. Symmetry: if have a possiblity to disable feature only for vhost-user-blk,
seems good to have same possibility for TAP.

3. Disabling fd-migration per device may be useful to switch this specific
device to another backend.

-- 
Best regards,
Vladimir

