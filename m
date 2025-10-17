Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C4ECCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 09:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9gbd-0005cx-JE; Fri, 17 Oct 2025 05:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9gbc-0005cT-1k
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 05:18:36 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9gbS-0002AY-Mc
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 05:18:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 74491C01AE;
 Fri, 17 Oct 2025 12:18:19 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a93::1:3a] (unknown
 [2a02:6bf:8080:a93::1:3a])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HIOuEO3F74Y0-3CGPfJ44; Fri, 17 Oct 2025 12:18:18 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760692698;
 bh=nhDdxeX4Z+uxfkkBzUc2ETUMHYbCTHs++QrcRHtNbus=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=c43vgnRYZeisDpG+rff/0xvVHicy8zdvRx7MYi5pDjZLaOaVlO4JynqUpYzKo3V7s
 2dfiN9OHjkiyIB311ZYd8svuArHuIZ1ApLbhcFBAKK11EIqQ6A6MhXIf7Fo16a4Oqh
 R3EhlaYR0AftcyS/ExKjUglntLUWy6yhcAT80NWY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <de82625b-be53-428e-973d-0aadeda26541@yandex-team.ru>
Date: Fri, 17 Oct 2025 12:18:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, mst@redhat.com, jasowang@redhat.com,
 farosas@suse.de, sw@weilnetz.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
References: <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
 <aPE8Oo5D3oesB7sV@x1.local> <aPE-vmyg1mLDO4pf@redhat.com>
 <aPFHl3VWV0pCmzd1@x1.local> <aPFOHjl5BoWEMqSL@redhat.com>
 <aPFVWi1pwxS8yGay@x1.local> <aPH557l6YnXT-3r8@redhat.com>
 <7b6ad405-0dbe-41d7-8d29-e3e92d969647@yandex-team.ru>
 <aPIDRft9RqtGvdVf@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aPIDRft9RqtGvdVf@redhat.com>
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

On 17.10.25 11:50, Daniel P. Berrangé wrote:
> On Fri, Oct 17, 2025 at 11:26:59AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 17.10.25 11:10, Daniel P. Berrangé wrote:
>>>> Meanwhile, the admin will need to manage the list of devices even if the
>>>> admin doesn't really needed to, IMHO.
>>> We shouldn't need to list devices in every scenario.
>>
>> Do you mean, we may make union,
>>
>>     backend-transfer = true | false | [list of IDs]
>>
>> Where true means, enable backend-transfer for all supporting devices?
>> So that normally, we'll not list all devices, but just set it to true?
> 
> Well I was thinking separate parameters
> 
>     backend-transfer: bool
>     backend-transfer-devices: [str]   (optional list of IDs)
> 
> but it amounts to the same thing
> 
>> But this way, migration will fail, if target version doesn't support
>> backend-transfer for some of used devices, or support for some
>> another, where source lack the support. So that's a way to create a
>> situation, where two QEMUs, with same device options, same machine
>> types, same configurations and same migration parameters / capabilities
>> define incompatible migration states..
> 
> It is worse - the backend on both sides may support transfer,
> but may none the less be incompatible due to changed configuration,
> so this needs mgmt app input too.
> 
> The challenge we have is that whether or not a backend supports
> transfer requires fairly detailed know of QEMU and the specific
> configuration of the backend. It is pretty undesirable for mgmt
> apps to have to that knowledge, as the matrix of possibilities
> is quite large and liable to change over time.
> 
> If we consider 'backend transfer' to be a performance optimization,
> then really we want QEMU to "do the right thing" as much as is
> possible.
> 
> Source and dst QEMUs don't have a bi-directional channel though,
> so they can't negotiate the common subset of backends they both
> support - it'll need help from the mgmt app.

As I heard from Peter, there a future plans to create such channel
https://wiki.qemu.org/ToDo/LiveMigration#Migration_handshake

> 
> One possibility is a new QMP command "query-migratable-backends"
> which lists all device IDs, whose current backend configuration
> is reporting the ability to transfer state. The mgmt app could
> run that on both sides of the migration, take the intersection
> of the two lists, and then further subtract any devices where
> it has delibrately changed the backend configuration on the dst.
> 
> If we had that, then we could always pass the ID list to the
> migrate command, while also avoiding hardcoding knowledge of
> QEMU backend impl details - it would largely "just work".


Yes "query + get intersection + set the list" works good for me.
That's enough abstract, the management app should not even care
what these IDs are.

And if migration-handshake realized, that (as many other
paraameters) may be simplified. We may finally have

    backend-transfer = "off" | "auto" | [list of IDs]

, where "auto" means exactly negotiate with target the maximal set
of devices, for which we can do backend-transfer.

> 
>>> We need to focus on
>>> the internal API design. We need to have suitable APIs exposed by backends
>>> to allow us to query migratability and process vmstate a mere property
>>> 'backend-transfer' is insufficient, whether set by QEMU code, or set by
>>> the mgmt app.
>>>
>>> If we have proper APIs each device should be able to query whether its
>>> backend can be transferred, and so "do the right thing" if backend
>>> transfer is requested by migration. The ability to list devices in the
>>> migrate command is only needed to be able to exclude some backends if
>>> the purpose of migration is to change a backend
> 
> With regards,
> Daniel


-- 
Best regards,
Vladimir

