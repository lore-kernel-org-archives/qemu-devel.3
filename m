Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0176CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RR1-0005Vc-1m; Thu, 16 Oct 2025 13:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9RQy-0005V8-CJ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:06:36 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9RQh-00034s-KZ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:06:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 3DF518087C;
 Thu, 16 Oct 2025 20:06:08 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8c::1:19] (unknown
 [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 66V0dJ2FteA0-33sefxQQ; Thu, 16 Oct 2025 20:06:07 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760634367;
 bh=BQFzDHRPcsG95hqAzOUrUUME4AbEydmyDCfVvEu+fgI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EQyMxoPSMAijUMsetJBDp07bFU6zC+yVRVBXBDWfHwbq+muOlJzQB3fI3sZ4qBNC+
 ui6MG7g3WTwjff3eiVBt9JUuy/mcPxDxn2psJB6B6foObf4cED1K7rub+SNzcMGr/U
 UIs5N/YA7rr2enlOrSxd+5D/GJxltOxvi81bijJo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a54163ca-ed15-4eab-8a49-2ae5f5c82da9@yandex-team.ru>
Date: Thu, 16 Oct 2025 20:06:06 +0300
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
 <981b9636-0a7a-4334-b222-7621971e6b2c@yandex-team.ru>
 <aPEckcsXUEjfDk2z@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aPEckcsXUEjfDk2z@x1.local>
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

On 16.10.25 19:25, Peter Xu wrote:
> On Wed, Oct 15, 2025 at 11:17:27PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Off topic:
>>
>> Didn't you think about moving to some context-free protocol for migration
>> stream? Current protocol is hardly bound to migration states definitions
>> in the code. This, for example, makes writing an external tool to analyze the
>> stream almost impossible. As well, any misconfiguration leads to strange
>> error, when we treat data wrongly on the target.
>>
>> I imagine.. json? Or something like this.. So that we can always understand
>> the structure of incoming object, even if we don't know, what exactly we
>> are going to get. This also simplifies expanding the state in new verions:
>> we just add a new field into migratable object, and can handle absent field
>> in incoming stream.
> 
> Have you looked at the current encoded JSON dump within the migration
> stream?  See should_send_vmdesc().
> 
> That looks like what you're describing, but definitely different in that it
> should only be used for debugging purposes e.g. when a stream is dumped
> into a file.  The JSON should only only appear also on precopy as of now.
> 
> We might try to move it _before_ the real binary stream, or making the
> stream itself to be JSON, but there'll be tricky things we need to think
> about.
> 
> At least it should be problematic when we want to dump it before the binary
> stream, because there can be VMSD fields or subsections that has a test()
> function that will only conditionally appear depending on any possible
> conditions (e.g. device register states).  If we try to dump it before
> hand, it may mean after device registers changed and when we stop VM and
> dump the real binary stream the test() fn may return something different,
> starting to mismatch with the JSON description.
> 
> Dump the whole thing completely with JSON format is indeed another approach

Yes I meant this. Or maybe some other external binary protocol like protobuf.

> that I am not aware of anyone hought further.  I believe some of us
> (including myself) pictured how it could look like, but I am not aware
> anyone went deeper than that.  Maybe it's because the current methods work
> not as good but okay so that no one yet decided to think it all through.
> In short, for simple machine types, they use VMSD versioning hence backward
> migration is not supported.  For enterprise use, machine type properties
> are used and there aren't a huge lot so maybe not as bothering.
> 

yes. Too much work with little benefit..

another thought:

We have QAPI protocol, with quite good schema description, and we can add
new optional fields to structures, and backward compatibility works.

Maybe, we can migrate a QAPI generated structures? Then we may describe
state of devices in QAPI..

Just note: working with QEMU's migration protocol and QAPI for years,
I can say that QAPI is a lot simpler in:
- implementing new features in backward compatible style
- maintaining downstream-only features

Still, QAPI is not good for passing big chunks of raw data, like memory pages.

-- 
Best regards,
Vladimir

