Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FD5CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 20:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v97wT-0005PD-36; Wed, 15 Oct 2025 16:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v97wO-0005Or-R9
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:17:44 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v97wJ-0001JQ-MJ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:17:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A79CDC0283;
 Wed, 15 Oct 2025 23:17:29 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a94::1:15] (unknown
 [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RHXdxH3FkmI0-ac8P23ip; Wed, 15 Oct 2025 23:17:28 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760559448;
 bh=IRp+jKKVA4aFHoj8EEYL5pqxpTOFqc90da8+OSO60y0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=gfBv3rYpnbs2XBoe8ufuZAU8Hje5osn4G7dzkimy+k7FFUf4bJi7Lto0fqYzrylEa
 Y3e+FJLEt4lUDgolxhirHpnOhMNun3yD62avOoWmjd1wnaG3b3jeYjldvtixjgIuLS
 ygDKrwZzPYeYMugGjSdM+XQ2q+/YR/CRfNBKxPHk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <981b9636-0a7a-4334-b222-7621971e6b2c@yandex-team.ru>
Date: Wed, 15 Oct 2025 23:17:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/19] qapi: add interface for backend-transfer
 virtio-net/tap migration
To: Peter Xu <peterx@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, farosas@suse.de, sw@weilnetz.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, raphael.s.norwitz@gmail.com
References: <20251010173957.166759-1-vsementsov@yandex-team.ru>
 <20251010173957.166759-17-vsementsov@yandex-team.ru>
 <aO57SKp86zX2R8mV@x1.local>
 <6da192b9-7609-4cc8-82a9-1a445ecb10c9@yandex-team.ru>
 <aO6xqt5_1PDBwOwu@x1.local>
 <9a9ced95-583e-4c1e-84f0-af12a5800193@yandex-team.ru>
 <aO_nfsgM2CWEjyeQ@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aO_nfsgM2CWEjyeQ@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 15.10.25 21:27, Peter Xu wrote:
>> Interesting, could migration "return path" be somehow used to get information
>> from target, does it support backend transfer for concrete device?
>>
>> So that, we simply enable backend-transfer=true parameter both on
>> source and target. Than, source somehow find out through return path,
>> for the device, does target support backend-transfer for it, and decide,
>> what to do? Or that's too complicated?
> Fabiano is looking at something like that, we called it migration
> handshake.
> 
> https://wiki.qemu.org/ToDo/LiveMigration#Migration_handshake
> 
> Fundamentally one of its goal is that we can have bi-directional "talks"
> between src/dst, before migration ever started, to synchronize on things
> like this.  It's still likely not gonna happen this release.. though..  but
> it's on the radar.  With that, dst also doesn't need to set migration
> caps/params the same as src, because they'll talk things over.

Oh, that sounds cool, I've always dreamed of something like this.

Note for myself: look through the QEMU wiki, it may contain quite interesting things,
not only "QEMU Planning" and "Submit a Patch" :)

For live-update with backend transfer, we'll probably can not only check the
device tree, but recreate it automatically, using information from target.

> Allow QMP command "migrate[_incoming]" ..

O I thought about this too.

-

Off topic:

Didn't you think about moving to some context-free protocol for migration
stream? Current protocol is hardly bound to migration states definitions
in the code. This, for example, makes writing an external tool to analyze the
stream almost impossible. As well, any misconfiguration leads to strange
error, when we treat data wrongly on the target.

I imagine.. json? Or something like this.. So that we can always understand
the structure of incoming object, even if we don't know, what exactly we
are going to get. This also simplifies expanding the state in new verions:
we just add a new field into migratable object, and can handle absent field
in incoming stream.

-- 
Best regards,
Vladimir

