Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC66CCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 06:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9eJh-0002ja-Ds; Fri, 17 Oct 2025 02:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9eJc-0002j8-6t
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:51:52 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9eJR-0004fk-4z
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:51:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 471D180822;
 Fri, 17 Oct 2025 09:51:28 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a93::1:3a] (unknown
 [2a02:6bf:8080:a93::1:3a])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QpLpie3FNmI0-iZyCgkzN; Fri, 17 Oct 2025 09:51:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760683887;
 bh=wsVHjAjE7cIh2L5XnAQ7wIrGEC0q5uMNfkWhon3NOl8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=SHsSz1rvVIneOdaajuEwtIQmatj6U44om4QGVeCCMmNGC/WyqtjnWA4BoX9Qo7Izd
 8h+ie5rsHDnocnk7j7dRHs3Jb01375OUQlq/cmghLw/VWhnMMQZ9GhfDdyXYh/iH29
 OOqDqVBZQ/jEWuJyFfCnBiaF5y9huXdHtDsgcg+M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7995fd74-5f02-4cd6-94b5-f1b361298257@yandex-team.ru>
Date: Fri, 17 Oct 2025 09:51:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, farosas@suse.de, sw@weilnetz.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 qemu-devel@nongnu.org, michael.roth@amd.com, steven.sistare@oracle.com,
 leiyang@redhat.com, davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
References: <aO_ll4Lf0bq6vgdm@x1.local>
 <3b9f1da4-6264-45d4-ade1-a6273cc6fa1e@yandex-team.ru>
 <aO_--QWDJO7iOhR4@x1.local>
 <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
 <aPE8Oo5D3oesB7sV@x1.local> <aPE-vmyg1mLDO4pf@redhat.com>
 <aPFHl3VWV0pCmzd1@x1.local> <aPFOHjl5BoWEMqSL@redhat.com>
 <aPFVWi1pwxS8yGay@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aPFVWi1pwxS8yGay@x1.local>
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

On 16.10.25 23:28, Peter Xu wrote:
> On Thu, Oct 16, 2025 at 08:57:18PM +0100, Daniel P. Berrangé wrote:
>> Errm, machine types apply to devices, but this is about transferring
>> backends which are outside the scope of machine types.
> 
> Ah.. I didn't notice that net backends are not inherited by default from
> qdev, hence not applicable to machine type properties.
> 
> Is it possible we enable it somehow, so that backends can have compat
> properties similarly to frontends?

But that would mean, that we can't reconfigure a backend during live migration.

In my understanding, machine type properties are visible to the guest,
and that's why we can't change them for running vm, even during live
migration.

Bringing here another type of properties, which we _can_ change for
running vm (even if changing is not very comfortable for admin), will
be like tying ourselves hands.

And yes, there is a way to change any properties by qom-set. But it
lays out of paradigm of machine types, and normally we can't change
most of properties in flight.


Or in other words: if we _can_ go on only with migration parameters,
that actually shows, that what we are talking about is definitely
property of migration, not property of device.


And final note: if we can use one mechanism instead of two mechanisms,
it makes the architecture twice simpler. Trying to go on with _only_
device properties would mean run a bench of qom-set commands before
every migration (as we have to distinguish local and remote migrations
anyway), that looks bad. On the other hand, go on with _only_ migration
parameter is feasible and looks better.


And very final note: making global parameter + per-device parameters,
actually, global parameter become a workaround to the fact that we
don't want run a bench of qom-set commands. So, global parameter is
an additional API to hide inconvenience of the main API.

> 
> If we go with a list of devices in the migration parameters, to me it'll
> only be a way to workaround the missing of such capability of net backends.
> Meanwhile, the admin will need to manage the list of devices even if the
> admin doesn't really needed to, IMHO.
> 
> Thanks,
> 


-- 
Best regards,
Vladimir

