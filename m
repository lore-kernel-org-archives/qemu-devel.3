Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6B0C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 15:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjhw3-00041d-8L; Mon, 11 Mar 2024 11:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rjhvz-00040d-Kk; Mon, 11 Mar 2024 11:51:28 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rjhvw-0001Vo-4f; Mon, 11 Mar 2024 11:51:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:30ad:0:640:87bc:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 30E9E60A5E;
 Mon, 11 Mar 2024 18:51:19 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b4b7::1:11] (unknown
 [2a02:6b8:b081:b4b7::1:11])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IpnGGq0IbqM0-plzqaxoZ; Mon, 11 Mar 2024 18:51:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710172278;
 bh=L/jD759x9ycSc5ltZpGJiZQYbCiwgkN2lTGBjdVvK5E=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=pt/8G3G844J6AOrYzg+RgIjiFlmHoX6ox025pc3m7XSdczPzdGYnOhphcnZeftO4r
 oDn7fZXtwy4cgjbbKh9qayGLyYiMfaDoPE61HJZk1n40njvHUTgV1s70AsdC27VhM4
 E/k0OMZhgH/mwT2Rh4PNXl9+B/XAEFZrba9ekQE8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <76223a28-cbb5-4c54-8138-178239c32caa@yandex-team.ru>
Date: Mon, 11 Mar 2024 18:51:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
Content-Language: en-US
To: Peter Krempa <pkrempa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, eblake@redhat.com, hreitz@redhat.com,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
References: <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
 <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
 <99dd287b-816b-4f4f-b156-32f94bbb62c2@yandex-team.ru>
 <87o7gbyy8w.fsf@pond.sub.org> <ZUTffE0wfjLH2u+e@redhat.com>
 <87cywqn84g.fsf@pond.sub.org>
 <1310efb0-e211-46f5-b166-d7d529507a43@yandex-team.ru>
 <ZeWnFhLKCamlP97y@redhat.com> <ZeWr3ZGrRUrciHH4@angien.pipo.sk>
 <65f517cd-3a1b-41bd-b326-e509cb208b92@yandex-team.ru>
 <Ze4hIfIwXPUPPMFK@angien.pipo.sk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <Ze4hIfIwXPUPPMFK@angien.pipo.sk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11.03.24 00:07, Peter Krempa wrote:
> On Thu, Mar 07, 2024 at 22:42:56 +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 04.03.24 14:09, Peter Krempa wrote:
>>> On Mon, Mar 04, 2024 at 11:48:54 +0100, Kevin Wolf wrote:
>>>> Am 28.02.2024 um 19:07 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>>> On 03.11.23 18:56, Markus Armbruster wrote:
>>>>>> Kevin Wolf<kwolf@redhat.com>  writes:
> 
> [...]
> 
>>
>> I only see the following differencies:
>>
>> 1. block-job-complete documents that it completes the job synchronously.. But looking at mirror code I see it just set s->should_complete = true, which will be then handled asynchronously.. So I doubt that documentation is correct.
>>
>> 2. block-job-complete will trigger final graph changes. block-job-cancel will not.
>>
>> Is [2] really useful? Seems yes: in case of some failure before starting migration target, we'd like to continue executing source. So, no reason to break block-graph in source, better keep it unchanged.
>>
>> But I think, such behavior better be setup by mirror-job start parameter, rather then by special option for cancel (or even compelete) command, useful only for mirror.
> 
> Libvirt's API design was based on the qemu quirk and thus we allow users
> to do the decision after starting the job, thus anything you pick needs
> to allow us to do this at "completion" time.
> 

OK, this means that simply switch to an option at job-start is not enough.

> Libvirt can adapt to any option that will give us the above semantics
> (extra parameter at completion time, different completion command or
> extra command to switch job properties right before completion), but to
> be honest all of these feel like they would be more hassle than keeping
> 'block-job-cancel' around from qemu's side.
> 

I understand. But still, it would be good to finally resolve the duplication between job-* and block-job-* APIs. We can keep old quirk working for a long time even after making a new consistent API.

-- 
Best regards,
Vladimir


